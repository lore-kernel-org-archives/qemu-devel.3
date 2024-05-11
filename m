Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF3FC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIz-0000Mt-6H; Sat, 11 May 2024 07:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIx-0000M1-Tj
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:19 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIu-00070B-Uf
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:19 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34db6a299b8so2090894f8f.3
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428455; x=1716033255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hfxi5Tt4Z237MIY1mS3UWYWqzflEOIMry0lrn96HNUo=;
 b=EkQN/fjF/nx6K6220BFNxORdoLPEyNMH+cdf167MjTFwO/u2Hje3l+Ly5jbcLiYyUh
 sLqwbDNWtdhsa7igsFWJt3iWlXd+lAvg7KkQsA7b+fzOilvtcMO/7BL5gi0tUKKnqR1l
 jnARhKefMwNF4qB9E/kAsPUsXjRyp0AAsE/UXZLFAf68JGQwLQZhZd9rbO++mNgyI1TK
 PlQAOAokrCqM2amLH0xU4eRcAwZiALQh9Be88ZqOhjFstW9uQ+a1rCGICjp1wAe77Ngi
 KNfIVFDO7jbvPRdsC2zwkQeNxKtvLrn+YsefbGBOOf9JOXljkH4O+wxSVuyYp2Tm8KUo
 IjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428455; x=1716033255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hfxi5Tt4Z237MIY1mS3UWYWqzflEOIMry0lrn96HNUo=;
 b=ESx2uHd61c+RnNEXi757Fp8JRQkYAfYtOBa1yMl5oThxFR6hwe1kydlBh43gAuXK2I
 ofDAApasmGOYTxmgy+ctKoGLDvpC7jA5DTz+5JAOYgy0x7U8bRIZRK40RukKU5r1Wh7K
 pO4qCNm44ws13u1yZZ8nPBnYbHsFX6dm9PEv/PTXdKLZ5IyaV+yYRpR1It24VsNWhTGE
 jTmYvgCooYiHrkYQ0xGuoQ4Gtu6etNiBmLCyScFhEDoDBJCJXKNm1K/fHvJh751m8f2r
 pkpBxEbvTjJQ+IyPSPYkSwnxXpJy7gAIfhSc1lECG3XKWsExscHq6qX1wVwccWulZqfE
 jOeg==
X-Gm-Message-State: AOJu0YyKtua68+JH360SLIfhqkiB/sNyX2A/DFtnspffivz0qn9GI/fp
 e2yMeb21qLQWAJwDVb6arEhGCHJ3bJEzjtnHcZczvKddfZG+KAyDXHQM/gYjqQwBMbfB67JZ1oK
 Yy/w=
X-Google-Smtp-Source: AGHT+IE0Orr9TikqvutXVKw6KTHFrtGNRIRTWEDc2d61phOhONmJKtDBVJlQfVtv7SzYxGs/OiErQg==
X-Received: by 2002:adf:e904:0:b0:34c:5429:497e with SMTP id
 ffacd0b85a97d-3504a623031mr3505485f8f.8.1715428455440; 
 Sat, 11 May 2024 04:54:15 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 13/17] Use bool for reginfo_is_eq
Date: Sat, 11 May 2024 13:53:56 +0200
Message-Id: <20240511115400.7587-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

The function result is more naturally boolean.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu.h                     |  4 ++--
 risu_reginfo_aarch64.c     |  4 ++--
 risu_reginfo_arm.c         |  4 ++--
 risu_reginfo_i386.c        |  4 ++--
 risu_reginfo_loongarch64.c |  4 ++--
 risu_reginfo_m68k.c        | 16 ++++++++--------
 risu_reginfo_ppc64.c       |  4 ++--
 risu_reginfo_s390x.c       |  4 ++--
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/risu.h b/risu.h
index aa8cc22..4203178 100644
--- a/risu.h
+++ b/risu.h
@@ -117,8 +117,8 @@ uintptr_t get_pc(struct reginfo *ri);
 /* initialize structure from a ucontext */
 void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr);
 
-/* return 1 if structs are equal, 0 otherwise. */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
+/* return true if structs are equal, false otherwise. */
+bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
 
 /* print reginfo state to a stream */
 void reginfo_dump(struct reginfo *ri, FILE *f);
diff --git a/risu_reginfo_aarch64.c b/risu_reginfo_aarch64.c
index 67a2999..55a9ef6 100644
--- a/risu_reginfo_aarch64.c
+++ b/risu_reginfo_aarch64.c
@@ -262,8 +262,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
     }
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
+/* reginfo_is_eq: compare the reginfo structs, returns true if equal */
+bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
     return memcmp(r1, r2, reginfo_size(r1)) == 0;
 }
diff --git a/risu_reginfo_arm.c b/risu_reginfo_arm.c
index 0e179be..d11e666 100644
--- a/risu_reginfo_arm.c
+++ b/risu_reginfo_arm.c
@@ -155,8 +155,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
     reginfo_init_vfp(ri, uc);
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
+/* reginfo_is_eq: compare the reginfo structs, returns true if equal */
+bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
     return memcmp(r1, r2, sizeof(*r1)) == 0;    /* ok since we memset 0 */
 }
diff --git a/risu_reginfo_i386.c b/risu_reginfo_i386.c
index f4cf9a3..1c579fa 100644
--- a/risu_reginfo_i386.c
+++ b/risu_reginfo_i386.c
@@ -234,8 +234,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
 #endif
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+/* reginfo_is_eq: compare the reginfo structs, returns true if equal */
+bool reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     return !memcmp(m, a, sizeof(*m));
 }
diff --git a/risu_reginfo_loongarch64.c b/risu_reginfo_loongarch64.c
index 060715f..6150a40 100644
--- a/risu_reginfo_loongarch64.c
+++ b/risu_reginfo_loongarch64.c
@@ -153,8 +153,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *context, void *siaddr)
     }
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
+/* reginfo_is_eq: compare the reginfo structs */
+bool reginfo_is_eq(struct reginfo *r1, struct reginfo *r2)
 {
     return !memcmp(r1, r2, sizeof(*r1));
 }
diff --git a/risu_reginfo_m68k.c b/risu_reginfo_m68k.c
index a53244d..7335195 100644
--- a/risu_reginfo_m68k.c
+++ b/risu_reginfo_m68k.c
@@ -55,13 +55,13 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
     }
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+/* reginfo_is_eq: compare the reginfo structs, returns true if equal */
+bool reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     int i;
 
     if (m->gregs[R_PS] != a->gregs[R_PS]) {
-        return 0;
+        return false;
     }
 
     for (i = 0; i < 16; i++) {
@@ -69,27 +69,27 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
             continue;
         }
         if (m->gregs[i] != a->gregs[i]) {
-            return 0;
+            return false;
         }
     }
 
     if (m->fpregs.f_pcr != a->fpregs.f_pcr) {
-        return 0;
+        return false;
     }
 
     if (m->fpregs.f_psr != a->fpregs.f_psr) {
-        return 0;
+        return false;
     }
 
     for (i = 0; i < 8; i++) {
         if (m->fpregs.f_fpregs[i][0] != a->fpregs.f_fpregs[i][0] ||
             m->fpregs.f_fpregs[i][1] != a->fpregs.f_fpregs[i][1] ||
             m->fpregs.f_fpregs[i][2] != a->fpregs.f_fpregs[i][2]) {
-            return 0;
+            return false;
         }
     }
 
-    return 1;
+    return true;
 }
 
 /* reginfo_dump: print state to a stream */
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 730a565..a8e5935 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -64,8 +64,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
     ri->vrregs.vrsave = uc->uc_mcontext.v_regs->vrsave;
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+/* reginfo_is_eq: compare the reginfo structs, returns true if equal */
+bool reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     return memcmp(m, a, sizeof(*m)) == 0;
 }
diff --git a/risu_reginfo_s390x.c b/risu_reginfo_s390x.c
index cbf168e..d18b94f 100644
--- a/risu_reginfo_s390x.c
+++ b/risu_reginfo_s390x.c
@@ -73,8 +73,8 @@ void reginfo_init(struct reginfo *ri, ucontext_t *uc, void *siaddr)
     memcpy(ri->fprs, &uc->uc_mcontext.fpregs.fprs, sizeof(ri->fprs));
 }
 
-/* reginfo_is_eq: compare the reginfo structs, returns nonzero if equal */
-int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
+/* reginfo_is_eq: compare the reginfo structs */
+bool reginfo_is_eq(struct reginfo *m, struct reginfo *a)
 {
     return m->pc_offset == a->pc_offset &&
            m->fpc == a->fpc &&
-- 
2.34.1


