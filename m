Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46324C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhMV-0004yY-45; Fri, 04 Jul 2025 10:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIQ-0005NF-8z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:47 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIO-00060e-Lf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:45 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2ea08399ec8so907999fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638903; x=1752243703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veT9cRM8uVQ4CyOBVMkGv45SOq4u7Wg0GMO4n1xsuYc=;
 b=rqLCLQaSWfRdHP/4qgCODNfkutWwUdUppEzOKv3eKqCxqQZydyIze9szcM3MC8RDR+
 78UMs7DqoKGJuxPP3KKQhXNvsd+AqxGyKuwpsa4c91obcsWwQ5tcD7UgUFfoM1lklR1E
 8+/OgomRAqkZayzSLUjcED3AhAlMGnPx0w0ZChPwGNyCHKOTeyQtk3ByO1oU6S+ABcrc
 qzLGU80W6eHNAmnrsJmZu+Kbl4s0kJcOPtDUttly4kllzZ+L87FcU2KghtgHXwQNgy3E
 JNYtyhl6II/JH8wkJe98+UIRgT0YldBS1C0ce9yWHpKGf3YfPaRugcImAkowbOh93Nu7
 aZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638903; x=1752243703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veT9cRM8uVQ4CyOBVMkGv45SOq4u7Wg0GMO4n1xsuYc=;
 b=qyjrwMbv8HjbMMOVOv1WMNnjyy5vm6h8S9W4Us9GpFSJegdx2hE1WAlnA/QsxHKvnI
 gSFxGkr62JVhvBHHZcgCXkt5oQKlUOm7vdb763h8wngWF3uY32Bi3OG0RmS2GDh47PQ9
 DwUjVdsPyQ3mxQObY8Fn+IwlX78c3KDwPtLh2fz19JjcjnuWfAF2WKx75ePEC1+h+6hA
 3pZUvwql9p9laeGw5/u/WIblanvkkVVhQAPcEIEEsOykQb+tmIAiYbdcmiSXfJSi6Wx3
 EOKX0Ey232T8hj044hzVegUi+tCk3CmKPCTZgPOOMKdme8imXyrioojMHxtrMaQ6cWYi
 vVrg==
X-Gm-Message-State: AOJu0Yyi0J2MTnevOXt7tbi1vJMowb/Fl8E9gtJyUujc2EoDaAN6H8Au
 R84CzGx079B0sSsZ/SuTHbIFdxnRCDK2sbbnbldf8BEVgqO3kYFfJLMet5553EGRYNntO+QoSJt
 LXsryf6Y=
X-Gm-Gg: ASbGncv85+Ma7AkuWC0+HAiWfIUyRUdNNAwr1ZhOLW6kZUQbgKlw/1WnMJnAj5zSNNO
 jBn0ie8FQnCvhZvrNpTw6w4FJcx18hpEMmJAxDCbJ9+kAL1GDp7vV3op+SFeqxerkaqbEISqk01
 APUY2MfaxGOMWF1PYxm5ffGD96DbcjjSP6qEUPYQadWOPmcDYcK17g+qmCTQBBfNxfGcQjdnYfo
 g18bvLcNI+cBR1SNh7n4UbVph7WYsIo56PvnKhcaA9cRBERWgI+2WguMGUv7Y41anPHWHUaY8MY
 7oU2Mo+S48osi2D+2JyneWIYONQ6QdlXr8dCNZ25xL0XeTN0Pz1/Ax8t0Qt754zDxgPQat7PYtt
 azQzuyaG8ljhgrJX6EX+SKfFYDvN+s34j6Y3weLP+ixZu5g65
X-Google-Smtp-Source: AGHT+IGPupSFzUiYRiHKxe4TbmvZIu1ZQcJkHVMehlkocSxuPRjGhl2NLJFDwobWUkATJz5DY80sCg==
X-Received: by 2002:a05:6870:e394:b0:2cc:3603:f05f with SMTP id
 586e51a60fabf-2f796e07cacmr1773852fac.35.1751638903056; 
 Fri, 04 Jul 2025 07:21:43 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 027/108] target/arm: Implement SME2 BMOPA
Date: Fri,  4 Jul 2025 08:19:50 -0600
Message-ID: <20250704142112.1018902-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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


