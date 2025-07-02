Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61287C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwg6-0007uM-4z; Wed, 02 Jul 2025 08:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfq-0007eQ-Vt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:52 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfd-000119-PF
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:50 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2f3dab2a2a9so916477fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459675; x=1752064475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veT9cRM8uVQ4CyOBVMkGv45SOq4u7Wg0GMO4n1xsuYc=;
 b=fIVgS+XhgEa/Y2eua6RF+88UK0SBQtuCXztSuFkJD5m7VmagCVkJXd8ZctxOCp2lVl
 rZNDW0cdeWMJZg2VpX99TR75RwELPiDNPv6/kvQSvE6yViLQrlRgCirHF3bnn3/1fh/t
 dKbXfeheJZllvnajCCu0pVNtDJlOmuLF7W2O8yC0L3Rb6kDT3WoMGwLJAttLO578tHn8
 V/cfCfRX86s02EBYKj8ee86fDxfDq/ED1H6EMZ2UIKk/LAAOQPA0vnNrGxDf+3GjC4u3
 6RRChgYqBJvA/izCO8B3XRinFUurSkgrNE5CgYRxeve+FvqnjNQfaT5Ds8JiRbTiyMzI
 7A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459675; x=1752064475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veT9cRM8uVQ4CyOBVMkGv45SOq4u7Wg0GMO4n1xsuYc=;
 b=HsFuEzzcw1mMcYYfaaYDMfvD2jUZG4I2gjtr3UEFcpB09wNEyF1MouOfyR44HajXl/
 RpLLe47/+EzL0HgD+lpIyz4ZF44DcMGWkkA7FEJ7MkGsTqhoj9ngfnPpIump6J/Gr+Kb
 IKyjawK4jj10uwgVCGEQw5sUiikga22VlrHCoUEVs0dn7lBcs8qWwIaifZWBFwKVbOzo
 xoDHMM6xNhVPk8Sya53mySKc1T0WDpYvmgLJqwgEKAxuln218qtF0rNFHDWMMxkVc3GM
 eLxuOQX8/ItdWj3mR9T+l7RHveSzQzO/MuEishIRp2uELrH1tk/5wWtfTatRUyPQZjj/
 5gVg==
X-Gm-Message-State: AOJu0YxEjssYeYHtNCa+mOgE433IjujASfzQlqczcDMDxVXI8lWYf8a/
 im4qjhl+lfnG6K2ul3GSqGgCrvLVSCeioDYF32Kwojp8nwjnAfCCMtnTt771dfvsKzsDvQnKZId
 R8g0Wtf4=
X-Gm-Gg: ASbGncs067ZHEgxpA4SuZQv4Op5B7gAY6XrxZBF1gqQ0q2b9LXmGJYCu0ww+D4pnJKr
 corNQInjXu21KgKFOHsDnybcop8TDsBWTIzSocd2pjtjDmfaheChmNwSvMSKHIe8kzxOu3paC8s
 /Ym1qB4Z+c0Vreu/V0zCnlQxu3FS9mV+YUQgGqcFp7lyhH9uny+R6IsguukTF3CMAIjNG1WEBB1
 PoMLWzNfpqEDlI7bi4ljrAXSGTyh2WfhiCmqQ8kLCjgokMzxmanzBo2xfjmb4eQQydnFbPENZEP
 2lSoOcNUULAhhG9qPZH0rQEIqpBYzDEH1Ea0E33ffhIEFVaWxlACI4FyhhZt0+6KEVWrNg==
X-Google-Smtp-Source: AGHT+IF+eKUEwGcQvLdS1+EQYSfXo2lkDqNDXie4SZnljuWO4jE7WI2cytf688NfHPCPWlUx0h9PHA==
X-Received: by 2002:a05:6870:e993:b0:2d5:b7b7:2d6e with SMTP id
 586e51a60fabf-2f5a8c6e11amr1851391fac.38.1751459674616; 
 Wed, 02 Jul 2025 05:34:34 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 17/97] target/arm: Implement SME2 BMOPA
Date: Wed,  2 Jul 2025 06:32:50 -0600
Message-ID: <20250702123410.761208-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  3 +++
 target/arm/tcg/sme_helper.c    | 34 ++++++++++++++++++++++++----------
 target/arm/tcg/translate-sme.c |  2 ++
 target/arm/tcg/sme.decode      |  2 ++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8246ce774c..17d1a7c102 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -153,3 +153,6 @@ DEF_HELPER_FLAGS_6(sme_sumopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_usmopa_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_6(sme2_bmopa_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index baeaa3e069..6122a5b5d9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1297,17 +1297,31 @@ DEF_IMOP_64(umopa_d, uint16_t, uint16_t)
 DEF_IMOP_64(sumopa_d, int16_t, uint16_t)
 DEF_IMOP_64(usmopa_d, uint16_t, int16_t)
 
-#define DEF_IMOPH(NAME, S) \
-    void HELPER(sme_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
+#define DEF_IMOPH(P, NAME, S) \
+    void HELPER(P##_##NAME##_##S)(void *vza, void *vzn, void *vzm,          \
                                   void *vpn, void *vpm, uint32_t desc)      \
     { do_imopa_##S(vza, vzn, vzm, vpn, vpm, desc, NAME##_##S); }
 
-DEF_IMOPH(smopa, s)
-DEF_IMOPH(umopa, s)
-DEF_IMOPH(sumopa, s)
-DEF_IMOPH(usmopa, s)
+DEF_IMOPH(sme, smopa, s)
+DEF_IMOPH(sme, umopa, s)
+DEF_IMOPH(sme, sumopa, s)
+DEF_IMOPH(sme, usmopa, s)
 
-DEF_IMOPH(smopa, d)
-DEF_IMOPH(umopa, d)
-DEF_IMOPH(sumopa, d)
-DEF_IMOPH(usmopa, d)
+DEF_IMOPH(sme, smopa, d)
+DEF_IMOPH(sme, umopa, d)
+DEF_IMOPH(sme, sumopa, d)
+DEF_IMOPH(sme, usmopa, d)
+
+static uint32_t bmopa_s(uint32_t n, uint32_t m, uint32_t a, uint8_t p, bool neg)
+{
+    uint32_t sum = ctpop32(~(n ^ m));
+    if (neg) {
+        sum = -sum;
+    }
+    if (!(p & 1)) {
+        sum = 0;
+    }
+    return a + sum;
+}
+
+DEF_IMOPH(sme2, bmopa, s)
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7b275dd2b8..c2615f06ae 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -539,3 +539,5 @@ TRANS_FEAT(SMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_smopa_
 TRANS_FEAT(UMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_umopa_d)
 TRANS_FEAT(SUMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_sumopa_d)
 TRANS_FEAT(USMOPA_d, aa64_sme_i16i64, do_outprod, a, MO_64, gen_helper_sme_usmopa_d)
+
+TRANS_FEAT(BMOPA, aa64_sme2, do_outprod, a, MO_32, gen_helper_sme2_bmopa_s)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 37bd0c6198..de8d04cb87 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -165,3 +165,5 @@ SMOPA_d         1010000 0 11 0 ..... ... ... ..... . 0 ...      @op_64
 SUMOPA_d        1010000 0 11 1 ..... ... ... ..... . 0 ...      @op_64
 USMOPA_d        1010000 1 11 0 ..... ... ... ..... . 0 ...      @op_64
 UMOPA_d         1010000 1 11 1 ..... ... ... ..... . 0 ...      @op_64
+
+BMOPA           1000000 0 10 0 ..... ... ... ..... . 10 ..      @op_32
-- 
2.43.0


