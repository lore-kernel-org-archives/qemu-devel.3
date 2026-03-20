Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7437E1098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYR-0002r4-Dw; Fri, 20 Mar 2026 09:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYN-0002oK-V9
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYK-0005yx-19
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:15 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b982d56dac4so9329166b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011969; x=1774616769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xMvV+Z30MGWIFjks+wq6XxTD4icaEeIiNeTijsECLbs=;
 b=zI2vjjJUrqNu9zJJsY5zHYvFvY31W+xuo7ciZuFQpapwjPaIru4Be2yY9yL322yMYz
 2EMX6zdXwAnrKZ+FQZ+s5JNh8Wo8tAlCKzuGgmLNjIrp3MFvKCV+dExaBjSxq5t1aagt
 VImSPa1iCmYjh58mlVdRF/VMp0kgPuyiTm5R3QVJf5oR3r2hsYbyHHkvwRjKdstMVu66
 i1dqKBW8N/u1sWBkcccSbiJvHL2/q7rHo9NcDhG3F5hwf4JOb5YVqr4Fx3MQ0JVaKoYM
 IKml/I9pSYgKt1yB/zDjifOjFeuyVC9Xzd311cTQ30sUZ90mOLu1hwMB2HtR18I+K+ph
 Jy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011969; x=1774616769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xMvV+Z30MGWIFjks+wq6XxTD4icaEeIiNeTijsECLbs=;
 b=s9TxkiSbNRh6jfXMhBXGCphbQqZge//j9pB/mrCb+HXpAqrwJLeQ/bhpFyyM3TTiXk
 6xVbADsuozWimZ66mYXRAwTA7HMvuq4NqJpGQh4qa+lzoKXftH5wKRA/H8uvhk0msQDc
 FDnVBxRbUGG8tCHSKEzqvhDUtZAfao6RBDr/GykH8Kn6hm5YNj7p0eV0u2+d411qRXqk
 llgZjCsRWWwxIHyTj7/Bo81xfeMgj3FcZD+U6gj+akqX43z2I+mmj3PMQ3h8cADy6isJ
 cmEljLlW+ZaAO9FXk342gM3Y0zqmiurNkvPhiMfKSHSVkTu22v5VTF6CmwAj/drFlpsn
 nveA==
X-Gm-Message-State: AOJu0Yyg3KbVLFhzzszJ+W1P0fhNwjPqZcKiAe/5Z6H1jlKUOkkZ3x8d
 r4n4RYaRt9CYYmejueO1W7cZNLNCeBB3IXhZV5wWRaGq6l0na9dVhueyWDU7tay2kryGjk1p9Ss
 +xLMvaOc=
X-Gm-Gg: ATEYQzy2D4QIhAzsl12+G1QqjSWP65Sd7G7LtB+Zrb2XbgrDRV2EK0rwXWWfXkl+4E2
 YJA0NoNOP68BhwIiW8KJBEtebSLtFmD2/DOcakLuYyiOWSqRY7ZQzTx/caEOhlLnXzXqDfqNGkB
 Gq5anZhPr5aYptP+oBo14uH/gbuxCxBfuWJfL/+/NkpmfPTRPNmivANGPJtX5g+C3eBSaOmNl2V
 +JwH7iu0XvIh2MtetFe3FusKXRXLQ86dxf5n6BItGwNgPEvHZByoUrO+DtC6cKRmAh2GjwdAbwk
 DwHIaEvDMFtvsgEpNLf4OTChDB8Ge6mHemRB02KST47aIBTzh0ZZDpjBdO2tIWlD+4VAW/4Ilbs
 HvY0qvG3pOTHVVDQr7OWRRuM2kdJVgUs93o8cgTTddov2gc00baE1PqrVd86k7OYIfd4ad4o2KJ
 OdOXUbhrE2XNRJgNIASKtyskc=
X-Received: by 2002:a17:907:a0cd:b0:b96:df8c:42da with SMTP id
 a640c23a62f3a-b982f524397mr224735566b.52.1774011969166; 
 Fri, 20 Mar 2026 06:06:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8dff5sm156496766b.24.2026.03.20.06.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C8C15F910;
 Fri, 20 Mar 2026 13:06:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 02/35] target/arm: migrate system/cp trap syndromes to
 registerfields
Date: Fri, 20 Mar 2026 13:05:33 +0000
Message-ID: <20260320130607.2071996-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 118 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 99 insertions(+), 19 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 517fb2368bc..3d2660614c6 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -208,53 +208,133 @@ static inline uint32_t syn_aa32_bkpt(uint32_t imm16, bool is_16bit)
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
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
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
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
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
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
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
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
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


