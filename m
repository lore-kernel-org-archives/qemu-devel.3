Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B622C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 11:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWvWZ-000883-Fq; Wed, 02 Jul 2025 07:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvWL-0007nF-1S; Wed, 02 Jul 2025 07:21:00 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWvWH-0002UR-JG; Wed, 02 Jul 2025 07:20:56 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so7107475a12.2; 
 Wed, 02 Jul 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751455249; x=1752060049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8uIRE/J6GXC1if0EgWProS/I1XupoffNSkt1/gwYYQ=;
 b=hqpghQZMSbScAukOJBFd4JRmW04sqtTjxrh3KdHbb2zoxajX3xaBpydTv5EjTOi6IB
 BkDif8wbiebStayDU8g8DRg3ezvxPULz2IkwNBnQ1L0cvJBqpNn2XVQ/1qZkBOUXlK1R
 ySBf5nemw3EqjJM+f8CK6tzobrUdkUXBMTsDvvL6DSfFkodR4ZLEjvaeZbwHQKCPiywj
 Yk+kmc4vNJIuS1VUOwpgTnrVsS2YFO0AosxYXM22bxeG+twQANlHn9IHU+fdPxJBV1pg
 l85nl2ohPD2zVtCwC3yjidgdVv8b/5POc82acOdgKK2WX1NMPJZsatHR/UIiN/WVTxeo
 c3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751455249; x=1752060049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8uIRE/J6GXC1if0EgWProS/I1XupoffNSkt1/gwYYQ=;
 b=QuQXxngh9IvQG+wJyx4IfmlzkH3mBmXn/xaLaLbMAtiyODecA1sHNArRbKKlSqOuzn
 EJGLo0S29MA8fJMoLCsng/M2tXHf5A2pUmKGUc1RluNIlysCoyEk89WO3XbFVXwJvROm
 IEtm5eNTv87xzVZGCKLpKH6niZgwYBh/kPideAxlNe4+3GbH7N5C2gerRc7hLme6/fg5
 2CRcauRDS6eUibrz/stERKlsPY7oYhPrkTWxfJpXQXI6TWnufNz+OwBlVVvewaVQ74LW
 R3gd1GLr9u1D28AnfaiztYF82XzSDjNKFhLgAEHVTcXMYW9jcXHuK5ZTE00IBFkn7mL0
 gheg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhwUJtMHnLDMs46ytAcw1HT8rk5RfQl5d5DEQ5ac2zzyxXFDmt1z+EkkJGnbucA/dhG68AcZQgMw==@nongnu.org
X-Gm-Message-State: AOJu0YzVCPWiG5wsW+C3tO8q7UYBrHBoWfnTLkNaB2Gbmjr3aZMaVR67
 GKyY5J1V90VSA3Vbumo9K8wkDK0c8e6AdgJ1LSmq6P/5hiCBhbsPE2w4X38IbA7jwYM=
X-Gm-Gg: ASbGncvKxNztx4KzZZUwkbIFRs0wkFdJyLH01yQh29g2Xx2WOZSx3Zc91R5v/op8Ksj
 uJ+QtJ60c8MpCFozsbyqgHO00OiVKv19IZ31mGs7x2PGID5IsTfM5BF/OH7s8JxvSnoiLZaqL6R
 zFRLKqwEuAB0rQguX/n/onkWSPRK0JooCczbjmBudBmAZI73QC059j+L+6llLWpNwkq+0siZV+a
 eadtG7gE81+BebIf31gft//+RMrkq9d24VrGlxPAFul7h/obHpW1tv1Bq6q3LFbiRIRjw+PJ6BO
 tDQDPv8SnJXolDNZNC+4yOmtCkX60aff45I8vZDRVy34yAYRdb0/yJBbdPpwmtfumnNlfGcwLYL
 ZzVbFN7of6nXEI2wRH/vZNx0Ug4XdztLd9Ix1V6D+8fc=
X-Google-Smtp-Source: AGHT+IGGQjhlrvbW+iIt6V15W/LueF9c//BvvTDJYFdexNu7sFc6puk+zVcL4FdoqsCgHzBCutZijA==
X-Received: by 2002:a17:90b:3e8a:b0:308:7270:d6ea with SMTP id
 98e67ed59e1d1-31a90c08754mr3570279a91.30.1751455249006; 
 Wed, 02 Jul 2025 04:20:49 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31a80823837sm1615862a91.1.2025.07.02.04.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 04:20:48 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v3 12/12] target/arm: Fix helper macros indentation in
 mve_helper.c
Date: Wed,  2 Jul 2025 20:49:54 +0930
Message-ID: <20250702111954.128563-13-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pg1-x52e.google.com
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
 target/arm/tcg/mve_helper.c | 268 ++++++++++++++++++------------------
 1 file changed, 134 insertions(+), 134 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 5dd2585684..2a7d3e7548 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -148,45 +148,45 @@ static void mve_advance_vpt(CPUARMState *env)
 }
 
 /* For loads, predicated lanes are zeroed instead of keeping their old values */
-#define DO_VLDR(OP, MFLAG, MSIZE, MTYPE, LDTYPE, ESIZE, TYPE)           \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        uint16_t eci_mask = mve_eci_mask(env);                          \
-        unsigned b, e;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
-        /*                                                              \
-         * R_SXTM allows the dest reg to become UNKNOWN for abandoned   \
-         * beats so we don't care if we update part of the dest and     \
-         * then take an exception.                                      \
-         */                                                             \
-        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
-            if (eci_mask & (1 << b)) {                                  \
-                d[H##ESIZE(e)] = (mask & (1 << b)) ?                    \
-                    (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;\
-            }                                                           \
-            addr += MSIZE;                                              \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VLDR(OP, MFLAG, MSIZE, MTYPE, LDTYPE, ESIZE, TYPE)               \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)        \
+    {                                                                       \
+        TYPE *d = vd;                                                       \
+        uint16_t mask = mve_element_mask(env);                              \
+        uint16_t eci_mask = mve_eci_mask(env);                              \
+        unsigned b, e;                                                      \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);            \
+        /*                                                                  \
+         * R_SXTM allows the dest reg to become UNKNOWN for abandoned       \
+         * beats so we don't care if we update part of the dest and         \
+         * then take an exception.                                          \
+         */                                                                 \
+        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                       \
+            if (eci_mask & (1 << b)) {                                      \
+                d[H##ESIZE(e)] = (mask & (1 << b)) ?                        \
+                    (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;  \
+            }                                                               \
+            addr += MSIZE;                                                  \
+        }                                                                   \
+        mve_advance_vpt(env);                                               \
     }
 
-#define DO_VSTR(OP, MFLAG, MSIZE, STTYPE, ESIZE, TYPE)                  \
-    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)    \
-    {                                                                   \
-        TYPE *d = vd;                                                   \
-        uint16_t mask = mve_element_mask(env);                          \
-        unsigned b, e;                                                  \
-        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));            \
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
-        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                   \
-            if (mask & (1 << b)) {                                      \
+#define DO_VSTR(OP, MFLAG, MSIZE, STTYPE, ESIZE, TYPE)                      \
+    void HELPER(mve_##OP)(CPUARMState *env, void *vd, uint32_t addr)        \
+    {                                                                       \
+        TYPE *d = vd;                                                       \
+        uint16_t mask = mve_element_mask(env);                              \
+        unsigned b, e;                                                      \
+        int mmu_idx = arm_to_core_mmu_idx(arm_mmu_idx(env));                \
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);            \
+        for (b = 0, e = 0; b < 16; b += ESIZE, e++) {                       \
+            if (mask & (1 << b)) {                                          \
                 cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
-            }                                                           \
-            addr += MSIZE;                                              \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+            }                                                               \
+            addr += MSIZE;                                                  \
+        }                                                                   \
+        mve_advance_vpt(env);                                               \
     }
 
 DO_VLDR(vldrb, MO_UB, 1, uint8_t, ldb, 1, uint8_t)
@@ -219,57 +219,57 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
  * their previous values.
  */
 #define DO_VLDR_SG(OP, MFLAG, MTYPE, LDTYPE, ESIZE, TYPE, OFFTYPE, ADDRFN, WB)\
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
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
-        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
-            d[H##ESIZE(e)] = (mask & 1) ?                               \
-                (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;  \
-            if (WB) {                                                   \
-                m[H##ESIZE(e)] = addr;                                  \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
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
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);              \
+        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) {\
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H##ESIZE(e)]);                              \
+            d[H##ESIZE(e)] = (mask & 1) ?                                     \
+                (MTYPE)cpu_##LDTYPE##_mmu(env, addr, oi, GETPC()) : 0;        \
+            if (WB) {                                                         \
+                m[H##ESIZE(e)] = addr;                                        \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 /* We know here TYPE is unsigned so always the same as the offset type */
-#define DO_VSTR_SG(OP, MFLAG, STTYPE, ESIZE, TYPE, ADDRFN, WB)          \
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
-        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);        \
-        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) { \
-            if (!(eci_mask & 1)) {                                      \
-                continue;                                               \
-            }                                                           \
-            addr = ADDRFN(base, m[H##ESIZE(e)]);                        \
-            if (mask & 1) {                                             \
-                cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC()); \
-            }                                                           \
-            if (WB) {                                                   \
-                m[H##ESIZE(e)] = addr;                                  \
-            }                                                           \
-        }                                                               \
-        mve_advance_vpt(env);                                           \
+#define DO_VSTR_SG(OP, MFLAG, STTYPE, ESIZE, TYPE, ADDRFN, WB)                \
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
+        MemOpIdx oi = make_memop_idx(MFLAG | MO_ALIGN, mmu_idx);              \
+        for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE, eci_mask >>= ESIZE) {\
+            if (!(eci_mask & 1)) {                                            \
+                continue;                                                     \
+            }                                                                 \
+            addr = ADDRFN(base, m[H##ESIZE(e)]);                              \
+            if (mask & 1) {                                                   \
+                cpu_##STTYPE##_mmu(env, addr, d[H##ESIZE(e)], oi, GETPC());   \
+            }                                                                 \
+            if (WB) {                                                         \
+                m[H##ESIZE(e)] = addr;                                        \
+            }                                                                 \
+        }                                                                     \
+        mve_advance_vpt(env);                                                 \
     }
 
 /*
@@ -280,58 +280,58 @@ DO_VSTR(vstrh_w, MO_TEUW, 2, stw, 4, int32_t)
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
-            d[H4(e)] = (mask & 1) ? cpu_ldl_mmu(env, addr, oi, GETPC()) : 0; \
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


