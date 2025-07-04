Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A68C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGu-0000Pv-7F; Fri, 04 Jul 2025 12:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFR-0004WG-6p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:49 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFO-0006wO-BU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:48 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so481719f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646405; x=1752251205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q638xM7x9lLv6t8aWS5h2DnITOOQdyI00w41MrG7A2Q=;
 b=R8H/lCIm+pa4bQa9vNHgXP7OIjAVmqiBGvABfYbbKBNQHWyWbaNABFOnrCCiVk9XNd
 39H/BI9ApL7TZLTvoLp3dfYC9VolpJI1H1uE5qL6ahVOGStBTorjYXEK6aKk7M5gBBA7
 wtpQolO0XMBreDX0ZdqLga7q5UXK721o55oxKBF/Phm2rZY8/FtRhq+MWD1EF5spVK4C
 bX7xeM1hWheuKq3LnRBPgU9TfvVHMks4I02TmPH6ziNbnMzRWJm5clvu+U48fyTHz020
 rZ8ZKHVKP7JU+zT0r40zDVSpSHF3VJSqn0qumy7yUe3FR9u2sjLEuijvxTymhf7bOD8O
 NXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646405; x=1752251205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q638xM7x9lLv6t8aWS5h2DnITOOQdyI00w41MrG7A2Q=;
 b=NfV/hm2gDxuh52jASL8SVY+1f4d6GpBXZNyTeJ8ZaF6UIcPZeMeOkFp0vq2O555aTy
 kk5ocS/q9o7zLfn3WMRKdFBFqP/jCAVYSctjZiGKeReH/D0G76FCMI676z8bqY+9Z1Q/
 JhX1Aj2FLr6Aw6N3ADi/COd1FkM1GQTwfEY4ClDzo3W8dr8zIHkg3BpZ3ie6+gom616l
 IT+MSOAMa+karMo6COAaCRQ8eTAtnqqDWuz2E7EqM1MhnQyzhFoi7w07EMbuW1DxsP6n
 9DAVEJCi3cLaiZ3pD/Nby8z861AzDYGHoTqe0qv79D/7g2G4BtayiFZH6z73IcGnSsGr
 JWSA==
X-Gm-Message-State: AOJu0Ywad6Y7QUtgVvnnmB7baBy/hjWCYP5KYIe31RecvtY89Gpy0v83
 2avxcAuxq9Q5A4hBHhwwBVauWc0q0niLsSEAuAs4bVD1/Tpdytr/P8XG5Szr6dOQfPQcwoPVJ1A
 XopQ0
X-Gm-Gg: ASbGncuTz/FPPSCIiH28M7/Y4/4w3/R+9oSyrUEK7ngUcW595IeRtrMEEgJajbVNqf6
 mnI2szfqLyifuiYvJbkQ07/bqDRGp+1sd//28e66+/OxxX5VHGQj/FNvI63DOjYv1OGy3GGpiyz
 immKYHTJkQ19RJ+XT+ZQ15DoCw880gmVLyukvsF0xF1JKcR1o0o2KdWdDAqdcQUriU9EMZs6oHp
 VgzLZehHhUuTjGMRSN8WTlA4xaEjkJZvbPFqBTwT0zZ7EuLykGJBq5dXoXrkvzF10pDAld5HsFc
 xSZIWDLepWT6ouJiUn1YOzgt3+obf5pnogSZXftFgc0wrbBOfgbl2tOjeFjkRKafYElcUspWCEn
 T5O8=
X-Google-Smtp-Source: AGHT+IEJwi+u9hIx8yNeZ6Xd+K0ln9Fyu6AigVwTFN4WjIJ+RfLmVdq6rPh+QDuw8pd3LsfcosiACw==
X-Received: by 2002:a05:6000:2307:b0:3a5:26eb:b4af with SMTP id
 ffacd0b85a97d-3b4964f1f58mr2494339f8f.18.1751646404809; 
 Fri, 04 Jul 2025 09:26:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 108/119] target/arm: Move ld1qq and st1qq primitives to
 sve_ldst_internal.h
Date: Fri,  4 Jul 2025 17:24:48 +0100
Message-ID: <20250704162501.249138-109-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Move from sme_helper.c to the shared header.
Add a comment noting the lack of atomicity.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-97-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_ldst_internal.h | 63 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c        | 44 +++------------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index e87beba4357..c67cda9d3b5 100644
--- a/target/arm/tcg/sve_ldst_internal.h
+++ b/target/arm/tcg/sve_ldst_internal.h
@@ -141,6 +141,69 @@ DO_LD_PRIM_3(ld1dqu_le, ld1dd_le)
 #define sve_st1dq_be_tlb   sve_st1dd_be_tlb
 #define sve_st1dq_le_tlb   sve_st1dd_le_tlb
 
+/*
+ * The ARMVectorReg elements are stored in host-endian 64-bit units.
+ * For 128-bit quantities, the sequence defined by the Elem[] pseudocode
+ * corresponds to storing the two 64-bit pieces in little-endian order.
+ */
+/* FIXME: Nothing in this file makes any effort at atomicity. */
+
+static inline void sve_ld1qq_be_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_ld1dd_be_host(vd, reg_off + 8, host);
+    sve_ld1dd_be_host(vd, reg_off, host + 8);
+}
+
+static inline void sve_ld1qq_le_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_ld1dd_le_host(vd, reg_off, host);
+    sve_ld1dd_le_host(vd, reg_off + 8, host + 8);
+}
+
+static inline void
+sve_ld1qq_be_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_ld1dd_be_tlb(env, vd, reg_off + 8, addr, ra);
+    sve_ld1dd_be_tlb(env, vd, reg_off, addr + 8, ra);
+}
+
+static inline void
+sve_ld1qq_le_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_ld1dd_le_tlb(env, vd, reg_off, addr, ra);
+    sve_ld1dd_le_tlb(env, vd, reg_off + 8, addr + 8, ra);
+}
+
+static inline void sve_st1qq_be_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_st1dd_be_host(vd, reg_off + 8, host);
+    sve_st1dd_be_host(vd, reg_off, host + 8);
+}
+
+static inline void sve_st1qq_le_host(void *vd, intptr_t reg_off, void *host)
+{
+    sve_st1dd_le_host(vd, reg_off, host);
+    sve_st1dd_le_host(vd, reg_off + 8, host + 8);
+}
+
+static inline void
+sve_st1qq_be_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_st1dd_be_tlb(env, vd, reg_off + 8, addr, ra);
+    sve_st1dd_be_tlb(env, vd, reg_off, addr + 8, ra);
+}
+
+static inline void
+sve_st1qq_le_tlb(CPUARMState *env, void *vd, intptr_t reg_off,
+                 target_ulong addr, uintptr_t ra)
+{
+    sve_st1dd_le_tlb(env, vd, reg_off, addr, ra);
+    sve_st1dd_le_tlb(env, vd, reg_off + 8, addr + 8, ra);
+}
+
 #undef DO_LD_TLB
 #undef DO_ST_TLB
 #undef DO_LD_HOST
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index c1166e4ffa9..df16bb2f9c4 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -415,54 +415,22 @@ static inline void sme_##NAME##_v_tlb(CPUARMState *env, void *za,           \
     TLB(env, useronly_clean_ptr(addr), val, ra);                            \
 }
 
-/*
- * The ARMVectorReg elements are stored in host-endian 64-bit units.
- * For 128-bit quantities, the sequence defined by the Elem[] pseudocode
- * corresponds to storing the two 64-bit pieces in little-endian order.
- */
-#define DO_LDQ(HNAME, VNAME, BE, HOST, TLB)                                 \
-static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
-{                                                                           \
-    uint64_t val0 = HOST(host), val1 = HOST(host + 8);                      \
-    uint64_t *ptr = za + off;                                               \
-    ptr[0] = BE ? val1 : val0, ptr[1] = BE ? val0 : val1;                   \
-}                                                                           \
+#define DO_LDQ(HNAME, VNAME) \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
     HNAME##_host(za, tile_vslice_offset(off), host);                        \
 }                                                                           \
-static inline void HNAME##_tlb(CPUARMState *env, void *za, intptr_t off,    \
-                               target_ulong addr, uintptr_t ra)             \
-{                                                                           \
-    uint64_t val0 = TLB(env, useronly_clean_ptr(addr), ra);                 \
-    uint64_t val1 = TLB(env, useronly_clean_ptr(addr + 8), ra);             \
-    uint64_t *ptr = za + off;                                               \
-    ptr[0] = BE ? val1 : val0, ptr[1] = BE ? val0 : val1;                   \
-}                                                                           \
 static inline void VNAME##_v_tlb(CPUARMState *env, void *za, intptr_t off,  \
                                target_ulong addr, uintptr_t ra)             \
 {                                                                           \
     HNAME##_tlb(env, za, tile_vslice_offset(off), addr, ra);                \
 }
 
-#define DO_STQ(HNAME, VNAME, BE, HOST, TLB)                                 \
-static inline void HNAME##_host(void *za, intptr_t off, void *host)         \
-{                                                                           \
-    uint64_t *ptr = za + off;                                               \
-    HOST(host, ptr[BE]);                                                    \
-    HOST(host + 8, ptr[!BE]);                                               \
-}                                                                           \
+#define DO_STQ(HNAME, VNAME) \
 static inline void VNAME##_v_host(void *za, intptr_t off, void *host)       \
 {                                                                           \
     HNAME##_host(za, tile_vslice_offset(off), host);                        \
 }                                                                           \
-static inline void HNAME##_tlb(CPUARMState *env, void *za, intptr_t off,    \
-                               target_ulong addr, uintptr_t ra)             \
-{                                                                           \
-    uint64_t *ptr = za + off;                                               \
-    TLB(env, useronly_clean_ptr(addr), ptr[BE], ra);                        \
-    TLB(env, useronly_clean_ptr(addr + 8), ptr[!BE], ra);                   \
-}                                                                           \
 static inline void VNAME##_v_tlb(CPUARMState *env, void *za, intptr_t off,  \
                                target_ulong addr, uintptr_t ra)             \
 {                                                                           \
@@ -477,8 +445,8 @@ DO_LD(ld1s_le, uint32_t, ldl_le_p, cpu_ldl_le_data_ra)
 DO_LD(ld1d_be, uint64_t, ldq_be_p, cpu_ldq_be_data_ra)
 DO_LD(ld1d_le, uint64_t, ldq_le_p, cpu_ldq_le_data_ra)
 
-DO_LDQ(sve_ld1qq_be, sme_ld1q_be, 1, ldq_be_p, cpu_ldq_be_data_ra)
-DO_LDQ(sve_ld1qq_le, sme_ld1q_le, 0, ldq_le_p, cpu_ldq_le_data_ra)
+DO_LDQ(sve_ld1qq_be, sme_ld1q_be)
+DO_LDQ(sve_ld1qq_le, sme_ld1q_le)
 
 DO_ST(st1b, uint8_t, stb_p, cpu_stb_data_ra)
 DO_ST(st1h_be, uint16_t, stw_be_p, cpu_stw_be_data_ra)
@@ -488,8 +456,8 @@ DO_ST(st1s_le, uint32_t, stl_le_p, cpu_stl_le_data_ra)
 DO_ST(st1d_be, uint64_t, stq_be_p, cpu_stq_be_data_ra)
 DO_ST(st1d_le, uint64_t, stq_le_p, cpu_stq_le_data_ra)
 
-DO_STQ(sve_st1qq_be, sme_st1q_be, 1, stq_be_p, cpu_stq_be_data_ra)
-DO_STQ(sve_st1qq_le, sme_st1q_le, 0, stq_le_p, cpu_stq_le_data_ra)
+DO_STQ(sve_st1qq_be, sme_st1q_be)
+DO_STQ(sve_st1qq_le, sme_st1q_le)
 
 #undef DO_LD
 #undef DO_ST
-- 
2.43.0


