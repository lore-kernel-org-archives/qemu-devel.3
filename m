Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFF7C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwqW-0006cm-Ut; Wed, 02 Jul 2025 08:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwnB-00004t-G6
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:26 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-00039d-VS
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:25 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so1095228fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460124; x=1752064924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=20kn4eYbxYwfStQX/tEOBcIiKRrQrxRWQALB+sLrCqM=;
 b=xEiD1yCdj8+UrRqy++o9frgUG0hyDsT1tNNUJPHZ6MniFhvIgJXxGYxcsXVttgotMV
 +EwP6YrbfVixuIGN2ctpDv9OBD8l7p1fqroMO2sk08ehtu4VYCJwCCAz12AnbAVFjhTF
 tq3WMoI1kIBFxVXg3QcdiKDM5YDwxhCQCR0/kmj8DP29SDPq7s1NvmGH9NrJNTHZUj9d
 +VAv8cGjQQp9HDlqnsrDME/OJbMX6HVIisoG3LI8nPmh3/Dj3z6cO4+3l+SQbFeZM36U
 8COWry3N7Pz6Hj+sdl8MpfiaRtswZJT8xSMmVyx6bRUFv9VHPJswuP1hDezw96jaGl4o
 5uTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460124; x=1752064924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20kn4eYbxYwfStQX/tEOBcIiKRrQrxRWQALB+sLrCqM=;
 b=WsH5rTTrCxyLEtZTbirFRQ/bBB5N2CPEfqutGJQM3Q67fxFuqqC7k8lyreAkNfdzhZ
 ezIR1GAxEnk3AiPdvg+lrI85PIIzXMtSfdPg3eSLWbRCvgraeGX7DeZubg1XkdDeKkIa
 8DvKC2p+y7d2lv2Lvr9lspgf9Isp2N6lB5vd1yV+D3/d1JpWx7hZJJq2bRtUGseFKk5V
 xwGoBxPXDisAnLgezGqSH/qdgmTgFatstksgHDAiH6e19uU9+QWmo/LprDHcBCilm/wm
 Y4XJRps0VZ+03UnjfOfjXzgWerR1SdeXCZsxnkGh836aTEnFuEMml6Hho4679zLRhGEr
 WmEA==
X-Gm-Message-State: AOJu0Yy3IVdUh2MFa/Ao5W+Dj7yumYjOP8DUC/9GVk/xfgUCb6c4hJTP
 4We/JUjv51CNGIqyqMHbYwgjIOEIaYKl/M3OtsDDJ0yaYR+xziKSous6XSPiASOtLg4IWKO7ILt
 lAuQBxek=
X-Gm-Gg: ASbGnct57qpXSGEK4JVg9BH95Ne/5dSo3hk/o1J5UKEV5U+rvT0VjYyD+vHTTqOAMsY
 E3exBbSl0noxiAd3h2MBltAV7DbqVptqR/QNwwwQc5QmrrQvbmfnp8W0rcSN8lfoDCKMO/Ov3wr
 qXMyAnmhKVtlvDwehBeuMbsqn3wmmBMhwRttuswu3fLjbdrnTVQxmbMA2wcI3PZP82a84aYpnWN
 gzgqr8dPxpCqBggcUWpfRII+OjvU5w/EQ6kefBXyV7wE7aqUmiqn1tRHceFTy/d0cy1Vb/AST7N
 Z6oqaxYYhqbPFfxyq1fYDjCwbA510gta4/VbrjpObqMH2RMOGkgSf79VM48sUWIFf3BOjA==
X-Google-Smtp-Source: AGHT+IGRyrp8Hpcb0W86klQq2+DaBkGAIEjXZaowzM1Cmc8GTwJXRrj3ZlRAKVK9sp/LoJyfdvRMjA==
X-Received: by 2002:a05:6870:32d1:b0:2ee:2800:8592 with SMTP id
 586e51a60fabf-2f5a8c8e296mr1883885fac.23.1751460123652; 
 Wed, 02 Jul 2025 05:42:03 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:42:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 85/97] target/arm: Move ld1qq and st1qq primitives to
 sve_ldst_internal.h
Date: Wed,  2 Jul 2025 06:33:58 -0600
Message-ID: <20250702123410.761208-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Move from sme_helper.c to the shared header.
Add a comment noting the lack of atomicity.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_ldst_internal.h | 63 ++++++++++++++++++++++++++++++
 target/arm/tcg/sme_helper.c        | 44 +++------------------
 2 files changed, 69 insertions(+), 38 deletions(-)

diff --git a/target/arm/tcg/sve_ldst_internal.h b/target/arm/tcg/sve_ldst_internal.h
index e87beba435..c67cda9d3b 100644
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
index 77eab68870..19c4c2efa2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -408,54 +408,22 @@ static inline void sme_##NAME##_v_tlb(CPUARMState *env, void *za,           \
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
@@ -470,8 +438,8 @@ DO_LD(ld1s_le, uint32_t, ldl_le_p, cpu_ldl_le_data_ra)
 DO_LD(ld1d_be, uint64_t, ldq_be_p, cpu_ldq_be_data_ra)
 DO_LD(ld1d_le, uint64_t, ldq_le_p, cpu_ldq_le_data_ra)
 
-DO_LDQ(sve_ld1qq_be, sme_ld1q_be, 1, ldq_be_p, cpu_ldq_be_data_ra)
-DO_LDQ(sve_ld1qq_le, sme_ld1q_le, 0, ldq_le_p, cpu_ldq_le_data_ra)
+DO_LDQ(sve_ld1qq_be, sme_ld1q_be)
+DO_LDQ(sve_ld1qq_le, sme_ld1q_le)
 
 DO_ST(st1b, uint8_t, stb_p, cpu_stb_data_ra)
 DO_ST(st1h_be, uint16_t, stw_be_p, cpu_stw_be_data_ra)
@@ -481,8 +449,8 @@ DO_ST(st1s_le, uint32_t, stl_le_p, cpu_stl_le_data_ra)
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


