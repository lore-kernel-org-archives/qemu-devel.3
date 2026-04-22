Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8DBF9B608
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:12:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUXw-0006xi-Qm; Wed, 22 Apr 2026 06:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXj-0006pF-T2
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXg-0000hr-3T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso69716885e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852646; x=1777457446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHkkfCdnBgFoOnCKUMnFf3OjHIWwkdSWF2yGrdtfKkY=;
 b=vEdhRZlisdyk1WKoTA6jSmUJG1Di6AlMdLF321nRbMhPaamRkytbtqNot14nb+Sy2Z
 7WG3rZjF5dfnvKiu/Sw3TQi2ORsGD7Ua0/FDTqLa8I8AQKyr5wfSE5pWzPWR+J4K1271
 FypAAy3Tu0OlrsZ8KUbkurIKgZZYn/ylV/9Q9hjzx4+/RGkm4MhC/6zwgBo408oMht49
 8ANg76EOje1SQyb6nUUWkCHeDH0/vyDWPMhQ9s07JQo3R3VIYaElfb57YtDKjKfZF06R
 PCUT1hBB6knVwbEpnlVodBHkj18/0kjNhqPGKFHheRmpzAWbwB7s4Ikn5AM2+mbMAEN4
 c4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852646; x=1777457446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FHkkfCdnBgFoOnCKUMnFf3OjHIWwkdSWF2yGrdtfKkY=;
 b=pdLaj8YotqWc4lOInG38sSORe3BCxZOvTiODQWmJrq9glpPsatN+Kl6wiftcBleHnV
 KnptHjtbmal92/0v9QcJ9eK+DbaczX5qgSsSZCkATftLJ/pB1iDWlzOeT/m8+tLdWJwN
 eI+2gg8rhgAjxqGX6o+qvY9VeUrMR88kDDTXKDSNnFR+nUBLZnNunFS0It2wO6UTzP6v
 rnWws+ay/UO5L+9k2TCM3lnGgctXUDLP8x/xYl7ZLL3CzvNwFpMvFpfYoB7YTik7Ix3T
 X4bEHLGmVafsVWX8ayIraWzpQe2blNEAooqcBxDb7UhMbEgk5qhelGK4Sap9mrggNS6F
 I0wQ==
X-Gm-Message-State: AOJu0YwTYHkY99bW4dyWaUD8nMdAlagTGk92SyJWUgwLz4peKIv8cHbm
 PwrTdUQeys0j/Sq5MJBnu5iBo9itHGb/n4wqMhSms1sWhAGexBNnkjkG6m7h4V2DpBwPMjM0Quv
 LxGk1ny0=
X-Gm-Gg: AeBDietM5j+IXkyl0ISHGWxSjfIUDWCu9hSJPdu1v0Jg/7LJYgSwTSWxQoA9S7ZF3Bl
 ektvypyGWAdG4mf3gUzyBGq6z37vokH6gqBIc2HeV+5EeIvxLUHpckaDYm8viefzDu8kWj8MbFL
 KWBxFyngaNe2akYn/bxnW8ieVA44g65tLNIrk5uVormTL/e6YCvSZvnMVdPPSU+WBGEbfYxM08T
 TX6IkKOKo4q9edqfAzCy/FMwDOh6I0oEvMuMVigkmN8hTON+30xbo4fSnENsk9+CutxI7qhHNGo
 Mmwk6tmzb2RrlUDw/pdJruCCyaRyeSwMV6FNBpFv5R3FbTvgHyfsArEFii1o8tzXtGYpNY76zDb
 UOJYckHYTU9x4yTWoiQfDXNTUkG9xJTIXJBoDTxtp/vCL9ZPGDZqoWqfwgQq8BA0L90sGdJIu0U
 Dx7BUdO6gRzjJs/pdstlX3uTcYQgQrL2XCsQ==
X-Received: by 2002:a05:600c:4e8f:b0:48a:56cd:5266 with SMTP id
 5b1f17b1804b1-48a56cd549bmr77005405e9.4.1776852646131; 
 Wed, 22 Apr 2026 03:10:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489fec8f7cbsm172089085e9.11.2026.04.22.03.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 965785F943;
 Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 02/31] target/arm: migrate system/cp trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 11:10:13 +0100
Message-ID: <20260422101043.1234229-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Migrate syn_aa64_sysregtrap and co-processor register trap syndromes
to the registerfields API. The co-processor syndromes are split
between single and duel register moves.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 124 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 22 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 517fb2368bc..29462aa103c 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -78,7 +78,7 @@ enum arm_exception_class {
 
 /* Generic syndrome encoding layout for HSR and lower 32 bits of ESR_EL2 */
 FIELD(SYNDROME, EC, 26, 6)
-FIELD(SYNDROME, IL, 25, 1)
+FIELD(SYNDROME, IL, 25, 1) /* IL=1 for 32 bit instructions */
 FIELD(SYNDROME, ISS, 0, 25)
 
 typedef enum {
@@ -172,7 +172,7 @@ static inline uint32_t syn_aa64_smc(uint32_t imm16)
 static inline uint32_t syn_aa32_svc(uint32_t imm16, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_AA32_SVC);
-    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
     res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
     return res;
 }
@@ -203,58 +203,138 @@ static inline uint32_t syn_aa64_bkpt(uint32_t imm16)
 static inline uint32_t syn_aa32_bkpt(uint32_t imm16, bool is_16bit)
 {
     uint32_t res = syn_set_ec(0, EC_AA32_BKPT);
-    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
     res = FIELD_DP32(res, ISS_IMM16, IMM16, imm16);
     return res;
 }
 
+/*
+ * ISS encoding for an exception from MSR, MRS, or System instruction
+ * in AArch64 state.
+ */
+FIELD(SYSREG_ISS, ISREAD, 0, 1) /* Direction, 1 is read */
+FIELD(SYSREG_ISS, CRM, 1, 4)
+FIELD(SYSREG_ISS, RT, 5, 5)
+FIELD(SYSREG_ISS, CRN, 10, 4)
+FIELD(SYSREG_ISS, OP1, 14, 3)
+FIELD(SYSREG_ISS, OP2, 17, 3)
+FIELD(SYSREG_ISS, OP0, 20, 2)
+
 static inline uint32_t syn_aa64_sysregtrap(int op0, int op1, int op2,
                                            int crn, int crm, int rt,
                                            int isread)
 {
-    return (EC_SYSTEMREGISTERTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL
-        | (op0 << 20) | (op2 << 17) | (op1 << 14) | (crn << 10) | (rt << 5)
-        | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_SYSTEMREGISTERTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, SYSREG_ISS, OP0, op0);
+    res = FIELD_DP32(res, SYSREG_ISS, OP2, op2);
+    res = FIELD_DP32(res, SYSREG_ISS, OP1, op1);
+    res = FIELD_DP32(res, SYSREG_ISS, CRN, crn);
+    res = FIELD_DP32(res, SYSREG_ISS, RT, rt);
+    res = FIELD_DP32(res, SYSREG_ISS, CRM, crm);
+    res = FIELD_DP32(res, SYSREG_ISS, ISREAD, isread);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from an MCR or MRC access
+ * (move to/from co-processor)
+ */
+FIELD(COPROC_ISS, ISREAD, 0, 1)
+FIELD(COPROC_ISS, CRM, 1, 4)
+FIELD(COPROC_ISS, RT, 5, 5)
+FIELD(COPROC_ISS, CRN, 10, 4)
+FIELD(COPROC_ISS, OP1, 14, 3)
+FIELD(COPROC_ISS, OP2, 17, 3)
+FIELD(COPROC_ISS, COND, 20, 4)
+FIELD(COPROC_ISS, CV, 24, 1)
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
 {
-    return (EC_CP14RTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
-        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP14RTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP2, opc2);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_cp15_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
 {
-    return (EC_CP15RTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc2 << 17) | (opc1 << 14)
-        | (crn << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP15RTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP2, opc2);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from an MCRR or MRRC access
+ * (move to/from co-processor with 2 regs)
+ */
+FIELD(COPROC_R2_ISS, ISREAD, 0, 1)
+FIELD(COPROC_R2_ISS, CRM, 1, 4)
+FIELD(COPROC_R2_ISS, RT, 5, 5)
+FIELD(COPROC_R2_ISS, RT2, 10, 5)
+FIELD(COPROC_R2_ISS, OP1, 16, 4)
+FIELD(COPROC_R2_ISS, COND, 20, 4)
+FIELD(COPROC_R2_ISS, CV, 24, 1)
+
 static inline uint32_t syn_cp14_rrt_trap(int cv, int cond, int opc1, int crm,
                                          int rt, int rt2, int isread,
                                          bool is_16bit)
 {
-    return (EC_CP14RRTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc1 << 16)
-        | (rt2 << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP14RRTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_R2_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_R2_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_R2_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT2, rt2);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_R2_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_R2_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
                                          int rt, int rt2, int isread,
                                          bool is_16bit)
 {
-    return (EC_CP15RRTTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (opc1 << 16)
-        | (rt2 << 10) | (rt << 5) | (crm << 1) | isread;
+    uint32_t res = syn_set_ec(0, EC_CP15RRTTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, COPROC_R2_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_R2_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_R2_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT2, rt2);
+    res = FIELD_DP32(res, COPROC_R2_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_R2_ISS, CRM, crm);
+    res = FIELD_DP32(res, COPROC_R2_ISS, ISREAD, isread);
+
+    return res;
 }
 
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
-- 
2.47.3


