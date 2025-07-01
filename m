Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA63AC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYIP-0004nE-0W; Tue, 01 Jul 2025 06:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIM-0004me-Iv; Tue, 01 Jul 2025 06:32:58 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIK-0002ID-8l; Tue, 01 Jul 2025 06:32:58 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23aeac7d77aso26255465ad.3; 
 Tue, 01 Jul 2025 03:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751365972; x=1751970772; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKaMETbB6c5cIkRuEznIr/CWZ85mI68zPqbRPb0CIv4=;
 b=lxq5UjoUQ/tb4BxYHfCh8qxKqyITGnXJUAKN5DqSrn039FuZLt2RTRc6twsUM1qlPE
 F4CZOozCfT37Bjl5YLHtaxwfeanvo5yG1JCDxAHOeZOmFMrA0kdoVVqmOOl1WP59ZQ0X
 hff6ipQhM7iCQmLxq7J7mk3qJcBgrEqt9oN1nXR+Afm6LOgX3dpCzJHWNWglFTy8qIqu
 mzDuO2gE8c8RUUWUTiOTWSqMqxbKS90kOaXEXF/kikVvXynivvLN+gMWT9dlQu3PEiZ7
 vxPrRo7Qc3yiFUV4I1oU4eQX6xlvyFsWfZ6Ly1daYd5S0gj30VRRj4PAewd/bT3/Xw4Z
 wHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365972; x=1751970772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKaMETbB6c5cIkRuEznIr/CWZ85mI68zPqbRPb0CIv4=;
 b=MdoV8N3BhQI9HifFqZErpGKMIaR3IsVa8K8F71bFHKT2sVPP+wG1UQ0H3PJfte71Nj
 TKvfIo4mdv8Zz1G4HMnBX5jcE3kQErN88ozL35fo+UPcLJbPeSttO0Fxr+iuCEUoIJzq
 hAmW5NHFxU6PYRvjo8agh+M9JUoiVnrbXOqMcztK0xj7bwEt5+N5kYzlUfRp51tkl28E
 h9e+soJMVeR6aASiHEVyoG2j2FpRQli1gWVIzkU5WyM0JfNPzYU+uioYLd/0vqkIDpNE
 UKuouhuZs5JBFXD6DIqdRX1e7ZRpsMgOPM/Z3pMmcVxkAYaWD+m+hma5yXuqmSHDcWi4
 +v5Q==
X-Gm-Message-State: AOJu0Yx0RFvGrcjnP/TV2TZhdpOgjcqD26/VEqMtxXe8m2ePLEutvahX
 h6Ag7QBRX9/SHCl6z4jGhjuJjsTaNz1w6uqmRUkLq19lPOkufcvyS+u374ps2RaaTSU=
X-Gm-Gg: ASbGnctpQJO4DwsNFeKqVtTPvbQFPT9hPmIgl9zZL9LA0Kih+ydfI6fpwnr3qGSpcJu
 FYqOm/my1gJsRKcnbVv0v2w15uVu0K1/rdN85pEWWH9U4KJ09GDAssx30Xhk4jw5NXDmkN+2BSp
 fLL91M3XEAuGVxgP5bfmTCBd3LM8yMTQXeN6Ak1b+dY1/g/EAUd9IptUSen1ZrBzJVQyLyKNr5G
 BvIaEgKiJ4/IWZAyTxcEP6jTiWZ59SiLj34pPce+UmhDMv+4euqYB2taq9Qfo/sGvZNTv9iGHJp
 K/3/jwdvDyDy28cT/v6VEipWNPYP5wrl9woH8Qu5CSBOIJ/VJhX3YYvBd52UDUvbraCi4uyqzwf
 Gxz9UG3MShZtU4rO4Fj0YOIVh5RWaGwEmfH7rFYm2Q74=
X-Google-Smtp-Source: AGHT+IHdFUODDvuKgSq7BSZFR2e1qfo0GDsmXLfQp0Eu+YAm5B+6Hs92AuRn9UB2hxXoPQUAf/w2Rw==
X-Received: by 2002:a17:902:ce8d:b0:224:26fd:82e5 with SMTP id
 d9443c01a7336-23ac463fad4mr259898845ad.48.1751365972359; 
 Tue, 01 Jul 2025 03:32:52 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23acb39b90bsm106444465ad.91.2025.07.01.03.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:32:51 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 04/12] target/arm: Fix VLDR helper load alignment checks
Date: Tue,  1 Jul 2025 20:01:51 +0930
Message-ID: <20250701103159.62661-5-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations in the VLDR
instruction.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 41 ++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 506d1c3475..922cd2371a 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -147,6 +147,22 @@ static void mve_advance_vpt(CPUARMState *env)
     env->v7m.vpr = vpr;
 }
 
+/* Mapping of LDTYPE/STTYPE to the number of bytes accessed */
+#define MSIZE_b 1
+#define MSIZE_w 2
+#define MSIZE_l 4
+
+/* Mapping of LDTYPE/STTYPE to MemOp flag */
+#define MFLAG_b MO_UB
+#define MFLAG_w MO_TEUW
+#define MFLAG_l MO_TEUL
+
+#define MSIZE(t)  MSIZE_##t
+#define MFLAG(t)  MFLAG_##t
+
+#define SIGN_EXT(v, T, B) { \
+    ((T)(v) << (sizeof(T) * 8 - (B))) >> (sizeof(T) * 8 - (B)) }
+
 /* For loads, predicated lanes are zeroed instead of keeping their old values */
 #define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
     void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
@@ -155,6 +171,8 @@ static void mve_advance_vpt(CPUARMState *env)
         uint16_t mask = mve_element_mask(env);                          \
         uint16_t eci_mask = mve_eci_mask(env);                          \
         unsigned b, e;                                                  \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
+        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);\
         /*                                                              \
          * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
          * beats so we don't care if we update part of the dest and     \
@@ -163,7 +181,10 @@ static void mve_advance_vpt(CPUARMState *env)
         for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
             if (eci_mask & (1 << b)) {                                  \
                 d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
-                    cpu_##LDTYPE##_data_ra(env, addr, GETPC()) : 0;     \
+                    SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),\
+                             TYPE,                                      \
+                             MSIZE * 8)                                 \
+                    : 0;                                                \
             }                                                           \
             addr += MSIZE;                                              \
         }                                                               \
@@ -185,20 +206,20 @@ static void mve_advance_vpt(CPUARMState *env)
         mve_advance_vpt(env);                                           \
     }
 
-DO_VLDR(vldrb, 1, ldub, 1, uint8_t)
-DO_VLDR(vldrh, 2, lduw, 2, uint16_t)
-DO_VLDR(vldrw, 4, ldl, 4, uint32_t)
+DO_VLDR(vldrb, 1, b, 1, uint8_t)
+DO_VLDR(vldrh, 2, w, 2, uint16_t)
+DO_VLDR(vldrw, 4, l, 4, uint32_t)
 
 DO_VSTR(vstrb, 1, stb, 1, uint8_t)
 DO_VSTR(vstrh, 2, stw, 2, uint16_t)
 DO_VSTR(vstrw, 4, stl, 4, uint32_t)
 
-DO_VLDR(vldrb_sh, 1, ldsb, 2, int16_t)
-DO_VLDR(vldrb_sw, 1, ldsb, 4, int32_t)
-DO_VLDR(vldrb_uh, 1, ldub, 2, uint16_t)
-DO_VLDR(vldrb_uw, 1, ldub, 4, uint32_t)
-DO_VLDR(vldrh_sw, 2, ldsw, 4, int32_t)
-DO_VLDR(vldrh_uw, 2, lduw, 4, uint32_t)
+DO_VLDR(vldrb_sh, 1, b, 2, int16_t)
+DO_VLDR(vldrb_sw, 1, b, 4, int32_t)
+DO_VLDR(vldrb_uh, 1, b, 2, uint16_t)
+DO_VLDR(vldrb_uw, 1, b, 4, uint32_t)
+DO_VLDR(vldrh_sw, 2, w, 4, int32_t)
+DO_VLDR(vldrh_uw, 2, w, 4, uint32_t)
 
 DO_VSTR(vstrb_h, 1, stb, 2, int16_t)
 DO_VSTR(vstrb_w, 1, stb, 4, int32_t)
-- 
2.48.1


