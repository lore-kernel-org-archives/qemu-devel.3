Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CFDC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIp-0000IM-K8; Sat, 11 May 2024 07:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIo-0000HN-A0
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIl-0006xC-FG
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04f0so16228005e9.0
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428446; x=1716033246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nf//qjvXctRXrrQe7LSzMsk4uBFI3ROnap3D79JgrM=;
 b=bnQGp7Qmfb686F83QJUOGbue7Xno3heYn33snNbxykFRqzXYP5Hok7rCrOcbt2OOFy
 xu+9LS0GA24lqiCbr7wqGHGL2JAnT8lBhjGzkEGu4VSwMp2w9GNH/EQ0VldUzCgwu8CY
 Qh8+rlqfsKV2uREX9wbPidCpqcCTUGvduyep8vr8Uqjd8qYchzHQ3yz7yIKO8iCWhEkw
 e9WVr+SYwSWULLEpJ5F/U3uP4UjJeKZaMs7INfxFvjMAZ/GpUsHftawUcreG0piNPo/8
 gPMROrRonBlx4TX8YF6vniTmObML/B5g3p0uv7VTk42+TO9oveRzdp6d7W9mMGtCf6yb
 e/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428446; x=1716033246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nf//qjvXctRXrrQe7LSzMsk4uBFI3ROnap3D79JgrM=;
 b=ITxyAKCx4ntL6//kM183MRshPcgRaHAdi8SCZ/dHBYOpuO3tsEG2jryc9tmwfMK0V0
 qYNFV4kymYy6jdNOPvDexMxBWh/DY4Mi6GF8b+k5iKJpTFm4pgeX4ymS5GcYMSvrpN6C
 98nd4acX5IZfXEurKJBEhCsJ1Yn4NsrDrH50VI2UWwx8kT2z016M0kFOQVDQHGfqRh1W
 YWKSnnwGtgyiYWpLquieArz0wIee/orSV9v/bB3AKty370THef1DwFH+DciSoIuaPNi0
 WLcPBkG0dkr3dc7sUBoBvfEtac/5IyBuIZSRjIu8UTEamJSdaX1oaVY+wIAbL+3RiSbA
 S7vA==
X-Gm-Message-State: AOJu0YyW9WNiXpHPDCZzeRY510j+HjTdxEyQeL8VIHykVDh6cPRU8VtZ
 NIBKn2EiQUdt1jHwFxwPE7B5cTuCX1w8uc5gbv9Yg+VHiBuGF2OoZasjTtZNmi3G6N27UDqwqlJ
 5ZQ8=
X-Google-Smtp-Source: AGHT+IF+8GkpA3vizDaIwAYGclTrxGUQMDhyplXGWKFoNL8jR8UEFqf3fW+ZbUvi/ul1u2eYiRSIww==
X-Received: by 2002:adf:ef4c:0:b0:349:bccc:a1e7 with SMTP id
 ffacd0b85a97d-3504a6310c6mr5585423f8f.19.1715428445909; 
 Sat, 11 May 2024 04:54:05 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 03/17] Standardize reginfo_dump_mismatch printing
Date: Sat, 11 May 2024 13:53:46 +0200
Message-Id: <20240511115400.7587-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Hoist the "master vs apprentice" label to apprentice(), since
we will want different labels for dumping.  Remove all of the
"mismatch" text from reginfo_dump_mismatch -- just print "vs".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                     |  4 ++--
 risu.c                     |  1 +
 risu_reginfo_aarch64.c     | 12 +++++-------
 risu_reginfo_arm.c         | 18 +++++++++---------
 risu_reginfo_i386.c        |  6 +-----
 risu_reginfo_loongarch64.c | 11 ++++-------
 risu_reginfo_m68k.c        | 23 +++++++----------------
 risu_reginfo_ppc64.c       | 25 ++++++++++++-------------
 risu_reginfo_s390x.c       | 18 +++++++-----------
 9 files changed, 48 insertions(+), 70 deletions(-)

diff --git a/risu.h b/risu.h
index 2c43384..1b87af2 100644
--- a/risu.h
+++ b/risu.h
@@ -123,8 +123,8 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 /* print reginfo state to a stream, returns 1 on success, 0 on failure */
 int reginfo_dump(struct reginfo *ri, FILE * f);
 
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
+/* reginfo_dump_mismatch: print mismatch details to a stream */
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
 
 /* return size of reginfo */
 int reginfo_size(struct reginfo *ri);
diff --git a/risu.c b/risu.c
index 6b6295c..9c31b8c 100644
--- a/risu.c
+++ b/risu.c
@@ -448,6 +448,7 @@ static int apprentice(void)
         reginfo_dump(&ri[MASTER], stderr);
         fprintf(stderr, "apprentice reginfo:\n");
         reginfo_dump(&ri[APPRENTICE], stderr);
+        fprintf(stderr, "mismatch detail (master : apprentice):\n");
         reginfo_dump_mismatch(&ri[MASTER], &ri[APPRENTICE], stderr);
         return EXIT_FAILURE;
 
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 1244454..da221d5 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -275,15 +275,15 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     return !ferror(f);
 }
 
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 {
     int i;
-    fprintf(f, "mismatch detail (master : apprentice):\n");
+
     if (m->faulting_insn != a->faulting_insn) {
-        fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
+        fprintf(f, "  faulting insn: %08x vs %08x\n",
                 m->faulting_insn, a->faulting_insn);
     }
+
     for (i = 0; i < 31; i++) {
         if (m->regs[i] != a->regs[i]) {
             fprintf(f, "  X%-2d    : %016" PRIx64 " vs %016" PRIx64 "\n",
@@ -342,7 +342,7 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
                 sve_dump_preg_diff(f, vq, pm, pa);
             }
         }
-        return !ferror(f);
+        return;
     }
 
     for (i = 0; i < 32; i++) {
@@ -356,6 +356,4 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
                     i, mv[1], mv[0], av[1], av[0]);
         }
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 85a39ac..221bd8a 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -183,32 +183,33 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
-    fprintf(f, "mismatch detail (master : apprentice):\n");
 
     if (m->faulting_insn_size != a->faulting_insn_size) {
-        fprintf(f, "  faulting insn size mismatch %d vs %d\n",
+        fprintf(f, "  faulting insn size: %d vs %d\n",
                 m->faulting_insn_size, a->faulting_insn_size);
     } else if (m->faulting_insn != a->faulting_insn) {
         if (m->faulting_insn_size == 2) {
-            fprintf(f, "  faulting insn mismatch %04x vs %04x\n",
+            fprintf(f, "  faulting insn: %04x vs %04x\n",
                     m->faulting_insn, a->faulting_insn);
         } else {
-            fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
+            fprintf(f, "  faulting insn: %08x vs %08x\n",
                     m->faulting_insn, a->faulting_insn);
         }
     }
+
     for (i = 0; i < 16; i++) {
         if (m->gpreg[i] != a->gpreg[i]) {
-            fprintf(f, "  r%d: %08x vs %08x\n", i, m->gpreg[i],
-                    a->gpreg[i]);
+            fprintf(f, "  r%d: %08x vs %08x\n", i, m->gpreg[i], a->gpreg[i]);
         }
     }
+
     if (m->cpsr != a->cpsr) {
         fprintf(f, "  cpsr: %08x vs %08x\n", m->cpsr, a->cpsr);
     }
+
     for (i = 0; i < 32; i++) {
         if (m->fpregs[i] != a->fpregs[i]) {
             fprintf(f, "  d%d: %016llx vs %016llx\n", i,
@@ -216,9 +217,8 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
                     (unsigned long long) a->fpregs[i]);
         }
     }
+
     if (m->fpscr != a->fpscr) {
         fprintf(f, "  fpscr: %08x vs %08x\n", m->fpscr, a->fpscr);
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index 834b2ed..18d15ca 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -349,14 +349,12 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i, j, n, w;
     uint64_t features;
     char r;
 
-    fprintf(f, "Mismatch (master v apprentice):\n");
-
     for (i = 0; i < NGREG; i++) {
         if (m->gregs[i] != a->gregs[i]) {
             assert(regname[i]);
@@ -399,6 +397,4 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
                     i, m->kregs[i], a->kregs[i]);
         }
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_loongarch64.c b/risu_reginfo_loongarch64.c
index 09a1eb6..630d6b2 100644
--- a/risu_reginfo_loongarch64.c
+++ b/risu_reginfo_loongarch64.c
@@ -195,18 +195,17 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     return !ferror(f);
 }
 
-/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
+/* reginfo_dump_mismatch: print mismatch details to a stream */
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
 {
     int i;
-    fprintf(f, "mismatch detail (master : apprentice):\n");
 
     if (m->vl != a->vl) {
-        fprintf(f, "  vl mismatch %08lx vs %08lx\n", m->vl, a->vl);
+        fprintf(f, "  vl     : %08lx vs %08lx\n", m->vl, a->vl);
     }
 
     if (m->faulting_insn != a->faulting_insn) {
-        fprintf(f, "  faulting insn mismatch %08x vs %08x\n",
+        fprintf(f, "  insn   : %08x vs %08x\n",
                 m->faulting_insn, a->faulting_insn);
     }
     /* r2:tp, r3:sp */
@@ -263,6 +262,4 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
             }
         }
     }
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index e29da84..18ae1d8 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -118,13 +118,12 @@ int reginfo_dump(struct reginfo *ri, FILE *f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
 
     if (m->gregs[R_PS] != a->gregs[R_PS]) {
-        fprintf(f, "Mismatch: Register PS\n");
-        fprintf(f, "master: [%x] - apprentice: [%x]\n",
+        fprintf(f, "    PS: %08x vs %08x\n",
                 m->gregs[R_PS], a->gregs[R_PS]);
     }
 
@@ -133,22 +132,18 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
             continue;
         }
         if (m->gregs[i] != a->gregs[i]) {
-            fprintf(f, "Mismatch: Register %c%d\n", i < 8 ? 'D' : 'A',
-                    i % 8);
-            fprintf(f, "master: [%x] - apprentice: [%x]\n", m->gregs[i],
-                    a->gregs[i]);
+            fprintf(f, "    %c%d: %08x vs %08x\n",
+                    i < 8 ? 'D' : 'A', i % 8, m->gregs[i], a->gregs[i]);
         }
     }
 
     if (m->fpregs.f_pcr != a->fpregs.f_pcr) {
-        fprintf(f, "Mismatch: Register FPCR\n");
-        fprintf(f, "m: [%04x] != a: [%04x]\n",
+        fprintf(f, "  FPCR: %04x vs %04x\n",
                 m->fpregs.f_pcr, a->fpregs.f_pcr);
     }
 
     if (m->fpregs.f_psr != a->fpregs.f_psr) {
-        fprintf(f, "Mismatch: Register FPSR\n");
-        fprintf(f, "m: [%08x] != a: [%08x]\n",
+        fprintf(f, "  FPSR: %04x vs %04x\n",
                 m->fpregs.f_psr, a->fpregs.f_psr);
     }
 
@@ -156,14 +151,10 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE * f)
         if (m->fpregs.f_fpregs[i][0] != a->fpregs.f_fpregs[i][0] ||
             m->fpregs.f_fpregs[i][1] != a->fpregs.f_fpregs[i][1] ||
             m->fpregs.f_fpregs[i][2] != a->fpregs.f_fpregs[i][2]) {
-            fprintf(f, "Mismatch: Register FP%d\n", i);
-            fprintf(f, "m: [%08x %08x %08x] != a: [%08x %08x %08x]\n",
+            fprintf(f, "   FP%d: %08x%08x%08x vs %08x%08x%08x\n", i,
                     m->fpregs.f_fpregs[i][0], m->fpregs.f_fpregs[i][1],
                     m->fpregs.f_fpregs[i][2], a->fpregs.f_fpregs[i][0],
                     a->fpregs.f_fpregs[i][1], a->fpregs.f_fpregs[i][2]);
         }
     }
-
-
-    return !ferror(f);
 }
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index bbdd63c..486bbf9 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -147,35 +147,35 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
+
     for (i = 0; i < 32; i++) {
         if (i == 1 || i == 13) {
             continue;
         }
-
         if (m->gregs[i] != a->gregs[i]) {
-            fprintf(f, "Mismatch: Register r%d\n", i);
-            fprintf(f, "master: [%lx] - apprentice: [%lx]\n",
+            fprintf(f, "%*s%d: %016lx vs %016lx\n",
+                    6 - (1 < 10 ? 1 : 2), "r", i,
                     m->gregs[i], a->gregs[i]);
         }
     }
 
     if (m->gregs[XER] != a->gregs[XER]) {
-        fprintf(f, "Mismatch: XER\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n", m->gregs[XER], a->gregs[XER]);
+        fprintf(f, "%6s: %016lx vs %016lx\n",
+                "xer", m->gregs[XER], a->gregs[XER]);
     }
 
     if (m->gregs[CCR] != a->gregs[CCR]) {
-        fprintf(f, "Mismatch: Cond. Register\n");
-        fprintf(f, "m: [%lx] != a: [%lx]\n", m->gregs[CCR], a->gregs[CCR]);
+        fprintf(f, "%6s: %016lx vs %016lx\n",
+                "ccr", m->gregs[CCR], a->gregs[CCR]);
     }
 
     for (i = 0; i < 32; i++) {
         if (m->fpregs[i] != a->fpregs[i]) {
-            fprintf(f, "Mismatch: Register f%d\n", i);
-            fprintf(f, "m: [%016lx] != a: [%016lx]\n",
+            fprintf(f, "%*s%d: %016lx vs %016lx\n",
+                    6 - (i < 10 ? 1 : 2), "f", i,
                     m->fpregs[i], a->fpregs[i]);
         }
     }
@@ -186,13 +186,12 @@ int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
             m->vrregs.vrregs[i][2] != a->vrregs.vrregs[i][2] ||
             m->vrregs.vrregs[i][3] != a->vrregs.vrregs[i][3]) {
 
-            fprintf(f, "Mismatch: Register vr%d\n", i);
-            fprintf(f, "m: [%x, %x, %x, %x] != a: [%x, %x, %x, %x]\n",
+            fprintf(f, "%*s%d: %08x%08x%08x%08x vs %08x%08x%08x%08x\n",
+                    6 - (i < 10 ? 1 : 2), "vr", i,
                     m->vrregs.vrregs[i][0], m->vrregs.vrregs[i][1],
                     m->vrregs.vrregs[i][2], m->vrregs.vrregs[i][3],
                     a->vrregs.vrregs[i][0], a->vrregs.vrregs[i][1],
                     a->vrregs.vrregs[i][2], a->vrregs.vrregs[i][3]);
         }
     }
-    return !ferror(f);
 }
diff --git a/risu_reginfo_s390x.c b/risu_reginfo_s390x.c
index 3fd91b9..9c8fcfd 100644
--- a/risu_reginfo_s390x.c
+++ b/risu_reginfo_s390x.c
@@ -107,34 +107,30 @@ int reginfo_dump(struct reginfo *ri, FILE * f)
     return !ferror(f);
 }
 
-int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
+void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f)
 {
     int i;
 
     if (m->pc_offset != a->pc_offset) {
-        fprintf(f, "Mismatch: PC offset master: [%016lx] - PC offset apprentice: [%016lx]\n",
+        fprintf(f, "  PC     : %016lx vs %016lx\n",
                 m->pc_offset, a->pc_offset);
     }
 
     for (i = 0; i < 16; i++) {
         if (m->gprs[i] != a->gprs[i]) {
-            fprintf(f, "Mismatch: r%d master: [%016lx] - r%d apprentice: [%016lx]\n",
-                    i, m->gprs[i], i, a->gprs[i]);
+            fprintf(f, "  r%-2d    : %016lx vs %016lx\n",
+                    i, m->gprs[i], a->gprs[i]);
         }
     }
 
     for (i = 0; i < 16; i++) {
         if (*(uint64_t *)&m->fprs[i] != *(uint64_t *)&a->fprs[i]) {
-            fprintf(f, "Mismatch: f%d master: [%016lx] - f%d apprentice: [%016lx]\n",
-                    i, *(uint64_t *)&m->fprs[i],
-                    i, *(uint64_t *)&a->fprs[i]);
+            fprintf(f, "  f%-2d    : %016lx vs %016lx\n",
+                    i, *(uint64_t *)&m->fprs[i], *(uint64_t *)&a->fprs[i]);
         }
     }
 
     if (m->fpc != a->fpc) {
-        fprintf(f, "Mismatch: FPC master: [%08x] - FPC apprentice: [%08x]\n",
-                m->fpc, a->fpc);
+        fprintf(f, "  FPC    : %08x vs %08x\n", m->fpc, a->fpc);
     }
-
-    return !ferror(f);
 }
-- 
2.34.1


