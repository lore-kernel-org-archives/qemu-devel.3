Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD89C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIx-0000Lq-CN; Sat, 11 May 2024 07:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIv-0000LE-8I
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIt-0006zb-0g
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:17 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-350513d2c6aso1137618f8f.2
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428453; x=1716033253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUAtQ4JWX99wQQNvfX1Znsvuc3Jvk42mU9SVFi0MMTs=;
 b=j17oNVJ28OY1269q1gbjNcBDPxEfNZd3HAv2tBu4TzI2DeacexCB6cO4a4ONsiUAiH
 4d0iz/73gIWRtg033NI3bpMgha4euXxQkPb6mATqH5Wk+vuUhX7xUesCB++smf0tmMu8
 zBdMGG5gH+PWSZuNPh+M0Z5IH3llKYOJMqJKUjDBRnrxS2uCfUCb8xs+/LSIeCbQ9tYj
 8mIe4XPmAPGtOiVorQhqdm/lO5wd1SCXqqTgQBgm09Wfh3zwV9hqQLxAx/z5i0CSpWbT
 P+M8PgM4HPJk9sJs7/Oy25Gk3KFh/70W14LK97HwHWjWm4q0dLCObZb5LOWpugBhkDZr
 Btsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428453; x=1716033253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUAtQ4JWX99wQQNvfX1Znsvuc3Jvk42mU9SVFi0MMTs=;
 b=Bt8CCjeZITyAxJ7SC4ElMMpPPCz/Gwqvp75SRxt4BCPzkZ00LewPwtkF02pe0ESYaw
 /BrDjIh4h9Xs5/vYzS+k4VV5KFgTMU31+rEwkL/YQRdjwNoOFBp8Z+8LgcBKW8341F3C
 k0RrOJ8qlotQK1YWqs+MrtKzQBYHas0sQyoQN1DxLwWG79X/Ark8GdQ8N1E8v64Oce9e
 aLuCZKiEIQ+Yrjr7ZluEaRXnZjVs8+tRhEf6kfbrsNkrOTWhmhkgExzv+MZIWJLAGKqx
 MXKeoCgDUsFZBJ8bJbFu+atTaKJF1tVtN2k3ATPaOUsMa1DRlvJ8Tn1H8bG2uFx6SlBN
 uJaw==
X-Gm-Message-State: AOJu0YyPNAJUPAUkSoZ417rBHd5qNn09QQPDSjZ6kGVSCkSB17zAbUQg
 EMiqXiNCTqFo+bQUYRZhhetQSzmq1CwB/2rTkITnQi0JYbGvrzMKySYboaK2a7At2Ud1gxAG6gI
 E1mk=
X-Google-Smtp-Source: AGHT+IG/qAMpd3CRrN0sGpR5ugsYy6Q5A5C/OlZYAVDInbOvUgmSWfFzVssFjO/CvZepxor4s3jh+Q==
X-Received: by 2002:a5d:4d4a:0:b0:34d:b70e:1ec7 with SMTP id
 ffacd0b85a97d-3504a630f0amr3424172f8f.16.1715428453564; 
 Sat, 11 May 2024 04:54:13 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 11/17] aarch64: Add support for ZA storage
Date: Sat, 11 May 2024 13:53:54 +0200
Message-Id: <20240511115400.7587-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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

Require NVL == SVL on startup, to make it easier to manage reginfo.
Most of the time PSTATE.SM would be active with PSTATE.ZA anyway,
for any non-trivial SME testing.

Extend saved storage only when PSTATE.ZA is active.
Use a carefully reserved uint16_t for saving SVCR.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_aarch64.h |  52 ++++++++++++-
 risu_reginfo_aarch64.c | 161 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 191 insertions(+), 22 deletions(-)

diff --git a/risu_reginfo_aarch64.h b/risu_reginfo_aarch64.h
index 536c12b..097b7ad 100644
--- a/risu_reginfo_aarch64.h
+++ b/risu_reginfo_aarch64.h
@@ -21,6 +21,43 @@
 #define SVE_VQ_MAX 16
 
 #define ROUND_UP(SIZE, POW2)    (((SIZE) + (POW2) - 1) & -(POW2))
+
+#ifdef ZA_MAGIC
+/* System headers have all Streaming SVE definitions. */
+typedef struct sve_context risu_sve_context;
+typedef struct za_context  risu_za_context;
+#else
+#define ZA_MAGIC         0x54366345
+#define SVE_SIG_FLAG_SM  1
+
+/* System headers missing flags field. */
+typedef struct {
+    struct _aarch64_ctx head;
+    uint16_t vl;
+    uint16_t flags;
+    uint16_t reserved[2];
+} risu_sve_context;
+
+typedef struct {
+    struct _aarch64_ctx head;
+    uint16_t vl;
+    uint16_t reserved[3];
+} risu_za_context;
+
+#define ZA_SIG_REGS_OFFSET \
+    ROUND_UP(sizeof(risu_za_context), SVE_VQ_BYTES)
+
+#define ZA_SIG_REGS_SIZE(vq) \
+    ((vq) * (vq) * SVE_VQ_BYTES * SVE_VQ_BYTES)
+
+#define ZA_SIG_ZAV_OFFSET(vq, n) \
+    (ZA_SIG_REGS_OFFSET + (SVE_SIG_ZREG_SIZE(vq) * n))
+
+#define ZA_SIG_CONTEXT_SIZE(vq) \
+    (ZA_SIG_REGS_OFFSET + ZA_SIG_REGS_SIZE(vq))
+
+#endif /* ZA_MAGIC */
+
 #define RISU_SVE_REGS_SIZE(VQ)  ROUND_UP(SVE_SIG_REGS_SIZE(VQ), 16)
 #define RISU_SIMD_REGS_SIZE     (32 * 16)
 
@@ -36,12 +73,16 @@ struct reginfo {
     uint32_t fpsr;
     uint32_t fpcr;
     uint16_t sve_vl;
-    uint16_t reserved;
+    uint16_t svcr;
 
-    char extra[RISU_SVE_REGS_SIZE(SVE_VQ_MAX)]
+    char extra[RISU_SVE_REGS_SIZE(SVE_VQ_MAX) +
+               ZA_SIG_REGS_SIZE(SVE_VQ_MAX)]
         __attribute__((aligned(16)));
 };
 
+#define SVCR_SM  1
+#define SVCR_ZA  2
+
 static inline uint64_t *reginfo_vreg(struct reginfo *ri, int i)
 {
     return (uint64_t *)&ri->extra[i * 16];
@@ -59,4 +100,11 @@ static inline uint16_t *reginfo_preg(struct reginfo *ri, int vq, int i)
                                   SVE_SIG_REGS_OFFSET];
 }
 
+static inline uint64_t *reginfo_zav(struct reginfo *ri, int vq, int i)
+{
+    return (uint64_t *)&ri->extra[RISU_SVE_REGS_SIZE(vq) +
+                                  ZA_SIG_ZAV_OFFSET(vq, i) -
+                                  ZA_SIG_REGS_OFFSET];
+}
+
 #endif /* RISU_REGINFO_AARCH64_H */
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 86e70ab..67a2999 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -25,25 +25,44 @@
 #include "risu.h"
 #include "risu_reginfo_aarch64.h"
 
+#ifndef PR_SME_SET_VL
+#define PR_SME_SET_VL 63
+#endif
+
 /* Should we test SVE register state */
 static int test_sve;
+static int test_za;
 static const struct option extra_opts[] = {
     {"test-sve", required_argument, NULL, FIRST_ARCH_OPT },
+    {"test-za", required_argument, NULL, FIRST_ARCH_OPT + 1 },
     {0, 0, 0, 0}
 };
 
 const struct option * const arch_long_opts = &extra_opts[0];
 const char * const arch_extra_help
-    = "  --test-sve=<vq>        Compare SVE registers with VQ\n";
+    = "  --test-sve=<vq>        Compare SVE registers with VQ\n"
+      "  --test-za=<vq>         Compare ZA storage with VQ\n";
 
 void process_arch_opt(int opt, const char *arg)
 {
-    assert(opt == FIRST_ARCH_OPT);
-    test_sve = strtol(arg, 0, 10);
-
-    if (test_sve <= 0 || test_sve > SVE_VQ_MAX) {
-        fprintf(stderr, "Invalid value for VQ (1-%d)\n", SVE_VQ_MAX);
-        exit(EXIT_FAILURE);
+    switch (opt) {
+    case FIRST_ARCH_OPT:
+        test_sve = strtol(arg, 0, 10);
+        if (test_sve <= 0 || test_sve > SVE_VQ_MAX) {
+            fprintf(stderr, "Invalid value for SVE VQ (1-%d)\n", SVE_VQ_MAX);
+            exit(EXIT_FAILURE);
+        }
+        break;
+    case FIRST_ARCH_OPT + 1:
+        test_za = strtol(arg, 0, 10);
+        if (test_za <= 0 || test_za > SVE_VQ_MAX
+            || (test_za & (test_za - 1))) {
+            fprintf(stderr, "Invalid value for ZA VQ (1-%d)\n", SVE_VQ_MAX);
+            exit(EXIT_FAILURE);
+        }
+        break;
+    default:
+        abort();
     }
 }
 
@@ -51,6 +70,31 @@ void arch_init(void)
 {
     long want, got;
 
+    if (test_za) {
+        /*
+         * For now, reginfo requires NVL == SVL.
+         * There doesn't seem to be much advantage to differing.
+         */
+        if (test_sve && test_sve != test_za) {
+            fprintf(stderr, "Mismatched values for SVE and ZA VQ\n");
+            exit(EXIT_FAILURE);
+        }
+
+        want = sve_vl_from_vq(test_za);
+        got = prctl(PR_SME_SET_VL, want);
+        if (want != got) {
+            if (got >= 0) {
+                fprintf(stderr, "Unsupported VQ for ZA (%d != %d)\n",
+                        test_za, (int)sve_vq_from_vl(got));
+            } else if (errno == EINVAL) {
+                fprintf(stderr, "System does not support SME\n");
+            } else {
+                perror("prctl PR_SME_SET_VL");
+            }
+            exit(EXIT_FAILURE);
+        }
+    }
+
     if (test_sve) {
         want = sve_vl_from_vq(test_sve);
         got = prctl(PR_SVE_SET_VL, want);
@@ -75,6 +119,9 @@ int reginfo_size(struct reginfo *ri)
     if (ri->sve_vl) {
         int vq = sve_vq_from_vl(ri->sve_vl);
         size += RISU_SVE_REGS_SIZE(vq);
+        if (ri->svcr & SVCR_ZA) {
+            size += ZA_SIG_REGS_SIZE(vq);
+        }
     } else {
         size += RISU_SIMD_REGS_SIZE;
     }
@@ -84,10 +131,11 @@ int reginfo_size(struct reginfo *ri)
 /* reginfo_init: initialize with a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 {
-    int i;
+    int i, vq;
     struct _aarch64_ctx *ctx, *extra = NULL;
     struct fpsimd_context *fp = NULL;
-    struct sve_context *sve = NULL;
+    risu_sve_context *sve = NULL;
+    risu_za_context *za = NULL;
 
     /* necessary to be able to compare with memcmp later */
     memset(ri, 0, sizeof(*ri));
@@ -112,6 +160,9 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
         case SVE_MAGIC:
             sve = (void *)ctx;
             break;
+        case ZA_MAGIC:
+            za = (void *)ctx;
+            break;
         case EXTRA_MAGIC:
             extra = (void *)((struct extra_context *)(ctx))->datap;
             break;
@@ -134,21 +185,55 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
     ri->fpsr = fp->fpsr;
     ri->fpcr = fp->fpcr;
 
-    if (test_sve) {
-        int vq = test_sve;
+    /*
+     * Note that arch_init required NVL==SVL, so test_sve and test_za
+     * are equal when non-zero.  We will verify this matches below.
+     */
+    vq = test_sve | test_za;
+    ri->sve_vl = sve_vl_from_vq(vq);
 
-        if (sve == NULL) {
-            fprintf(stderr, "risu_reginfo_aarch64: failed to get SVE state\n");
+    if (test_za) {
+        if (za == NULL) {
+            /* ZA_MAGIC is supposed to be present, even if empty. */
+            fprintf(stderr, "risu_reginfo_aarch64: missing ZA state\n");
             return;
         }
+        assert(za->head.size >= ZA_SIG_CONTEXT_SIZE(0));
 
-        if (sve->vl != sve_vl_from_vq(vq)) {
+        if (za->vl != ri->sve_vl) {
             fprintf(stderr, "risu_reginfo_aarch64: "
-                    "unexpected SVE state: %d != %d\n",
-                    sve->vl, sve_vl_from_vq(vq));
+                    "unexpected ZA VQ: %d != %d\n",
+                    za->vl, ri->sve_vl);
+            return;
+        }
+        if (za->head.size == ZA_SIG_CONTEXT_SIZE(0)) {
+            /* ZA storage is disabled. */
+        } else if (za->head.size < ZA_SIG_CONTEXT_SIZE(vq)) {
+            fprintf(stderr, "risu_reginfo_aarch64: "
+                    "failed to get complete ZA state\n");
+            return;
+        } else {
+            ri->svcr |= SVCR_ZA;
+            memcpy(reginfo_zav(ri, vq, 0), (char *)za + ZA_SIG_REGS_OFFSET,
+                   ZA_SIG_CONTEXT_SIZE(vq) - ZA_SIG_REGS_OFFSET);
+        }
+    }
+
+    if (test_sve) {
+        if (sve == NULL) {
+            /* SVE_MAGIC is supposed to be present, even if empty. */
+            fprintf(stderr, "risu_reginfo_aarch64: missing SVE state\n");
             return;
         }
 
+        if (sve->vl != ri->sve_vl) {
+            fprintf(stderr, "risu_reginfo_aarch64: "
+                    "unexpected SVE VQ: %d != %d\n",
+                    sve->vl, ri->sve_vl);
+            return;
+        }
+
+        ri->svcr |= sve->flags & SVE_SIG_FLAG_SM;
         if (sve->head.size <= SVE_SIG_CONTEXT_SIZE(0)) {
             /* Only AdvSIMD state is present. */
         } else if (sve->head.size < SVE_SIG_CONTEXT_SIZE(vq)) {
@@ -156,7 +241,6 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
                     "failed to get complete SVE state\n");
             return;
         } else {
-            ri->sve_vl = sve->vl;
             memcpy(reginfo_zreg(ri, vq, 0),
                    (char *)sve + SVE_SIG_REGS_OFFSET,
                    SVE_SIG_REGS_SIZE(vq));
@@ -164,7 +248,18 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
         }
     }
 
-    memcpy(reginfo_vreg(ri, 0), fp->vregs, RISU_SIMD_REGS_SIZE);
+    /*
+     * Be prepared for ZA state present but SVE state absent (VQ != 0).
+     * In which case, copy AdvSIMD vregs into the low portion of zregs;
+     * pregs remain all zero.
+     */
+    if (vq == 0) {
+        memcpy(reginfo_vreg(ri, 0), fp->vregs, RISU_SIMD_REGS_SIZE);
+    } else {
+        for (i = 0; i < 32; ++i) {
+            memcpy(reginfo_zreg(ri, vq, i), &fp->vregs[i], 16);
+        }
+    }
 }
 
 /* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
@@ -248,9 +343,11 @@ void reginfo_dump(struct reginfo *ri, FILE * f)
     fprintf(f, "  fpcr   : %08x\n", ri->fpcr);
 
     if (ri->sve_vl) {
-        int vq = sve_vq_from_vl(ri->sve_vl);
+        int vl = ri->sve_vl;
+        int vq = sve_vq_from_vl(vl);
 
-        fprintf(f, "  vl     : %d\n", ri->sve_vl);
+        fprintf(f, "  vl     : %d\n", vl);
+        fprintf(f, "  svcr   : %d\n", ri->svcr);
 
         for (i = 0; i < SVE_NUM_ZREGS; i++) {
             uint64_t *z = reginfo_zreg(ri, vq, i);
@@ -270,6 +367,14 @@ void reginfo_dump(struct reginfo *ri, FILE * f)
             sve_dump_preg(f, vq, p);
             fprintf(f, "\n");
         }
+
+        if (ri->svcr & SVCR_ZA) {
+            for (i = 0; i < vl; ++i) {
+                uint64_t *z = reginfo_zav(ri, vq, i);
+                fprintf(f, "  ZA[%-3d]: ", i);
+                sve_dump_zreg(f, vq, z);
+            }
+        }
         return;
     }
 
@@ -322,6 +427,10 @@ void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
         fprintf(f, "  vl     : %d vs %d\n", m->sve_vl, a->sve_vl);
     }
 
+    if (m->svcr != a->svcr) {
+        fprintf(f, "  svcr   : %d vs %d\n", m->svcr, a->svcr);
+    }
+
     if (m->sve_vl) {
         int vq = sve_vq_from_vl(m->sve_vl);
 
@@ -347,6 +456,18 @@ void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
                 sve_dump_preg_diff(f, vq, pm, pa);
             }
         }
+
+        if (m->svcr & a->svcr & SVCR_ZA) {
+            for (i = 0; i < vq * 16; i++) {
+                uint64_t *zm = reginfo_zav(m, vq, i);
+                uint64_t *za = reginfo_zav(a, vq, i);
+
+                if (!sve_zreg_is_eq(vq, zm, za)) {
+                    fprintf(f, "  ZA[%-3d]: ", i);
+                    sve_dump_zreg_diff(f, vq, zm, za);
+                }
+            }
+        }
         return;
     }
 
-- 
2.34.1


