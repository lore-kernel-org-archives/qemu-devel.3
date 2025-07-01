Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0B7C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYJA-0005tl-1i; Tue, 01 Jul 2025 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYJ8-0005pR-3k; Tue, 01 Jul 2025 06:33:46 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYJ5-0002Pd-Go; Tue, 01 Jul 2025 06:33:45 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b31d578e774so6066854a12.1; 
 Tue, 01 Jul 2025 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751366021; x=1751970821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ANEeeXFNou7PoIjW7yOiOz8sk3zkXq4bZ+pgAyMZ1Y=;
 b=cJCWDBUv6+Yroetb5s2lFDZ5vS+DdoqV64BrZW6ZV8vjngDhpuN6ivxTyIbN/H+ZTU
 J6F5H6T2lOoFrbOC05Ip8wa370myjitdO0ONbVBNP2NRTZH7esg9mHZSKSEEqqOjO0TK
 7DqgCTXZgPSc+jnSRUaVvMTXgE4dNq0BtjdoEK5/lT6QY7fxmIqD9DGrRKFy95oj0d4C
 g+I4/Y7pfuhh2//9EjKHCOLV4ckDaeOeDtvijtxyZgc3xifUNg4uSmmYJeXgbMP/WQuK
 IZMvV8IwX5Phw3TdjbU1d+b6Kj9sagAq7nS62cTC5DULHJnSBhFg1MEmPDL9VsTMigc/
 w64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751366021; x=1751970821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ANEeeXFNou7PoIjW7yOiOz8sk3zkXq4bZ+pgAyMZ1Y=;
 b=oNV9TN7DBM4KP9HOC+5DgiD6B5K/+1q9dHISSVN7t8r3kXL9b/MobRfbpeekspj4OA
 AuvXKvresdWg+3meK8GnUO3XX0Sa/Ltftvs+Pp71bGLDmhFtqbvpXYpttmt5l8+9GTUt
 /LM3wPwxoZ3Vi/cv04L6TuqMBk2UUaBgUZ2cTbudwJLFDhy1Ka1/RNSHR0LMpVCaJt7M
 5df2e6/WA9svEglPkbSwweRfPCfU3VvnVse+rAd5pYblfeCm90KE1zZJDCUisF7K+rme
 vZ34z/5TCiKAom4tXM6/piWWi0ukFHv63JqXh7NbFFVACdKO+c3S6VsNGj+AngzO/dTV
 jz2Q==
X-Gm-Message-State: AOJu0YyQCI5Iny1Y1uNExRQmPWCSo3d9hI3cMqMedbp1BypaqVMocisB
 ImRTflijyxFbvImt8qOMWLsr8EwXxtjLPNORZzTDwt62Uxmy/e6AJ2mQ4QMaaiP/aoA=
X-Gm-Gg: ASbGnctXpKrV5N51mRqnKvNCtm3JPTdZwBeM1wscUVPAHZmlBlhRE75t9hK4ta0TSxx
 3PwrSLzroXKPLKy0pZ+l0B6zeiBCDrqoSh6aJUiuGGzpf1k7A3NmxOSyeLm+RPEVi/2lsS0zEBo
 f952OzAMU+0eqOeMtrS6bLIAKl5B6An16+/Zw/OLRMW/aVECpPmqy9v1QbI/3PtYQrVgWFPKwxn
 giqojJe5ovE9Kd2xwsAM3bQo4c5MM7C7XedXv3c8HzNJiGjbbPnRdQLtLwjj65qkz51XqTduaad
 D2j7HjJBZeG6T6jccfmCUEKiSiO0OiMDnOMhRCwv0cnmMdo/WlS8kPC1s2nsGoJaWKnTSSP2M2X
 spZwX92CMcE0bAWNJVlhSIwEZH3PEOhl2+pQSqCo/Kk1lKQw30UK3jQ==
X-Google-Smtp-Source: AGHT+IFPJQcBEORDhZWHiifmQXlR0YeAtaipEe92oDHqWe6hOf2tHGeLS2SDBW1cb7lmBzlI4kNTDA==
X-Received: by 2002:a17:90b:48c8:b0:30e:3737:7c87 with SMTP id
 98e67ed59e1d1-31939af5b45mr4256466a91.5.1751366020858; 
 Tue, 01 Jul 2025 03:33:40 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-315f542e494sm15233336a91.31.2025.07.01.03.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:33:40 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 12/12] target/arm: Fix helper macros indentation in
 mve_helper.c
Date: Tue,  1 Jul 2025 20:01:59 +0930
Message-ID: <20250701103159.62661-13-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pg1-x533.google.com
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

Recent helper function load and store alignment fix caused the continuation
backslashes in those macro definitions to shift out of alignment.
This patch restores a uniform indentation for those trailing backslashes,
making them consistent.

Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/mve_helper.c | 280 ++++++++++++++++++------------------
 1 file changed, 140 insertions(+), 140 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 6dffd9cb35..72c07262c0 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -164,48 +164,48 @@ static void mve_advance_vpt(CPUARMState *env)
     ((T)(v) << (sizeof(T) * 8 - (B))) >> (sizeof(T) * 8 - (B)) }
 
 /* For loads, predicated lanes are zeroed instead of keeping their old values */
-#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                         \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned b, e;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);\
-        /*                                                              \
-         * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
-         * beats so we don't care if we update part of the dest and     \
-         * then take an exception.                                      \
-         */                                                             \
-        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
-            if (eci_mask & (1 << b)) {                                  \
-                d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
-                    SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),\
-                             TYPE,                                      \
-                             MSIZE * 8)                                 \
-                    : 0;                                                \
-            }                                                           \
-            addr += MSIZE;                                              \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VLDR(OP, MSIZE, LDTYPE, ESIZE, TYPE)                               \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)          \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned b, e;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);      \
+        /*                                                                    \
+         * R_SXTM allows the dest reg to become UNKNOWN for abandoned         \
+         * beats so we don't care if we update part of the dest and           \
+         * then take an exception.                                            \
+         */                                                                   \
+        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                         \
+            if (eci_mask & (1 << b)) {                                        \
+                d[H##ESIZE(e)] = (mask & (1 << b)) ?                          \
+                    SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),    \
+                             TYPE,                                            \
+                             MSIZE * 8)                                       \
+                    : 0;                                                      \
+            }                                                                 \
+            addr += MSIZE;                                                    \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
-#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                         \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        unsigned b, e;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);\
-        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
-            if (mask & (1 << b)) {                                      \
-                cpu_st##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC());\
-            }                                                           \
-            addr += MSIZE;                                              \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VSTR(OP, MSIZE, STTYPE, ESIZE, TYPE)                               \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)          \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        uint16_t mask = mve_element_mask(env);                                \
+        unsigned b, e;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);      \
+        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                         \
+            if (mask & (1 << b)) {                                            \
+                cpu_st##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
+            }                                                                 \
+            addr += MSIZE;                                                    \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 DO_VLDR(vldrb, 1, b, 1, uint8_t)
@@ -237,61 +237,61 @@ DO_VSTR(vstrh_w, 2, w, 4, int32_t)
  * For loads, predicated lanes are zeroed instead of retaining
  * their previous values.
  */
-#define DO_VLDR_SG(OP, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)        \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        OFFTYPE *m = vm;                                                \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);\
+#define DO_VLDR_SG(OP, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)              \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        OFFTYPE *m = vm;                                                      \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(LDTYPE) | MO_ALIGN, mmu_idx);      \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) {\
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
-            d[H##ESIZE(e)] = (mask & 1) ?                               \
-                SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),  \
-                         TYPE,                                          \
-                         MSIZE(LDTYPE) * 8)                             \
-                : 0;                                                    \
-            if (WB) {                                                   \
-                m[H##ESIZE(e)] = addr;                                  \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H##ESIZE(e)]);                              \
+            d[H##ESIZE(e)] = (mask & 1) ?                                     \
+                SIGN_EXT(cpu_ld##LDTYPE##_mmu(env, addr, oi, GETPC()),        \
+                         TYPE,                                                \
+                         MSIZE(LDTYPE) * 8)                                   \
+                : 0;                                                          \
+            if (WB) {                                                         \
+                m[H##ESIZE(e)] = addr;                                        \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 /* We know here TYPE is unsigned so always the same as the offset type */
-#define DO_VSTR_SG(OP, STTYPE, ESIZE, TYPE, ADDRFN, WB)                 \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        TYPE *m = vm;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);\
-        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
-            if (mask & 1) {                                             \
+#define DO_VSTR_SG(OP, STTYPE, ESIZE, TYPE, ADDRFN, WB)                       \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        TYPE *d = vd;                                                         \
+        TYPE *m = vm;                                                         \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MFLAG(STTYPE) | MO_ALIGN, mmu_idx);      \
+        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) {\
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H##ESIZE(e)]);                              \
+            if (mask & 1) {                                                   \
                 cpu_st##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
-            }                                                           \
-            if (WB) {                                                   \
-                m[H##ESIZE(e)] = addr;                                  \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+            }                                                                 \
+            if (WB) {                                                         \
+                m[H##ESIZE(e)] = addr;                                        \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 /*
@@ -302,58 +302,58 @@ DO_VSTR(vstrh_w, 2, w, 4, int32_t)
  * Address writeback happens on the odd beats and updates the address
  * stored in the even-beat element.
  */
-#define DO_VLDR64_SG(OP, ADDRFN, WB)                                    \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        uint32_t *d = vd;                                               \
-        uint32_t *m = vm;                                               \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
-        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H4(e & ~1)]);                         \
-            addr += 4 * (e & 1);                                        \
-            d[H4(e)] = (mask & 1) ? cpu_ldl_mmu(env, addr, oi, GETPC()) : 0;\
-            if (WB && (e & 1)) {                                        \
-                m[H4(e & ~1)] = addr - 4;                               \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VLDR64_SG(OP, ADDRFN, WB)                                          \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        uint32_t *d = vd;                                                     \
+        uint32_t *m = vm;                                                     \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);            \
+        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {            \
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H4(e & ~1)]);                               \
+            addr += 4 * (e & 1);                                              \
+            d[H4(e)] = (mask & 1) ? cpu_ldl_mmu(env, addr, oi, GETPC()) : 0;  \
+            if (WB && (e & 1)) {                                              \
+                m[H4(e & ~1)] = addr - 4;                                     \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
-#define DO_VSTR64_SG(OP, ADDRFN, WB)                                    \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,         \
-                          uint32_t base)                                \
-    {                                                                   \
-        uint32_t *d = vd;                                               \
-        uint32_t *m = vm;                                               \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned e;                                                     \
-        uint32_t addr;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);      \
-        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {      \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H4(e & ~1)]);                         \
-            addr += 4 * (e & 1);                                        \
-            if (mask & 1) {                                             \
-                cpu_stl_mmu(env, addr, d[H4(e)], oi, GETPC());          \
-            }                                                           \
-            if (WB && (e & 1)) {                                        \
-                m[H4(e & ~1)] = addr - 4;                               \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VSTR64_SG(OP, ADDRFN, WB)                                          \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, void *vm,               \
+                          uint32_t base)                                      \
+    {                                                                         \
+        uint32_t *d = vd;                                                     \
+        uint32_t *m = vm;                                                     \
+        uint16_t mask = mve_element_mask(env);                                \
+        uint16_t eci_mask = mve_eci_mask(env);                                \
+        unsigned e;                                                           \
+        uint32_t addr;                                                        \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                  \
+        MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN, mmu_idx);            \
+        for (e = 0; e < 16 / 4; e++, mask >>= 4, eci_mask >>= 4) {            \
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H4(e & ~1)]);                               \
+            addr += 4 * (e & 1);                                              \
+            if (mask & 1) {                                                   \
+                cpu_stl_mmu(env, addr, d[H4(e)], oi, GETPC());                \
+            }                                                                 \
+            if (WB && (e & 1)) {                                              \
+                m[H4(e & ~1)] = addr - 4;                                     \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 #define ADDR_ADD(BASE, OFFSET) ((BASE) + (OFFSET))
-- 
2.48.1


