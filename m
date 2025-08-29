Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkr-0003B8-Kq; Sat, 30 Aug 2025 11:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b5-0004Kd-ER
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7b3-0003ZM-GQ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:29:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so2756459b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506564; x=1757111364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jb6JFkIYnDNTTWSsePdZAuaMtcjYsIqbTSzxW0KOgk=;
 b=lwd517LhNnfs84tjRc4dd4KneZ9mFRQi4c/fBUj8NkwWbcaAa5jD6wVIlO2jBG8e8W
 lZNCqTCrjcv1rMPNRjenmsud7ayBkM2HmdjaDRduS9WT/aokt3LY4qoDamujkxYhtRvx
 agFQ/9Ur8RPAiC923wksQJYGAQQmCq/bcgwUgphuzJDq9s6CqjNSd9yD0IEWR9+Ht0L7
 pPOLEPBnVWnSAYdjgQAMCNBRNvWZOTpMP3I37oUBOCrNygQM54ywKJXpKmo3byqNYLB2
 kNYoInAES1OHlIGJxZrp5e/HfyhWflXGzCgXpKk9kPwBtvWwh5D+zrsSkGNrCgIOwMo2
 3PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506564; x=1757111364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jb6JFkIYnDNTTWSsePdZAuaMtcjYsIqbTSzxW0KOgk=;
 b=aSb9LYjQFBLXl867SEiyy1a/eq9YpcXYUaOqNjVlWiElrTbkspFwM+epF90es9mz3t
 e0g27r/dqI1N6+74R3dthEf+S3W0GQeg/ZP+BErnKgpwVOHwwqG1cKRJ2uUfjc9GokOU
 Dy+1uQe3WyyUS6MI39A6s8vyMwmCe5mRZu8cLPxJFMunK1FKFS4gr1CdsWUFUcT8YEoU
 aG8o3xaduzbAtSL74o/uAIxUMhuIBk6/fgEeqzvB6q1+wQ1C356aS1QVTMU8YK3sRSHV
 ab+xLB9mjCO+/n/qa+lJmRot6PkFlQDUJoH8ZoGVNy/3MPw5fx4M/Yu8+1JiRk7Re9xl
 i4pA==
X-Gm-Message-State: AOJu0Yy+ztHWf6riRhE6g71gYTb56DBafAztGp4UGCfQqJS3mdeMP7Bv
 +ia1VDbi4PchuZM8oyz5rGn2ZD+i/2HnlQ+d2PTwjvjL7U/J7SO9BPwLZWkCBfFZvUPS6DuHjC2
 Ha6abdBg=
X-Gm-Gg: ASbGncs80n7lEDGUMorucK33vS7pjUjDaASF9pdAxKu5C3Q0PkQ9kQgJ1wIm99B7i6h
 56aojsu+9/h3tSq/f/9Bonz/6fbqZRNtaXdv57RGf2D+IIM8DaO7kfvtT/lyowuOSpcZ7tStjJ+
 40avc/Gj6lecs/piUSjhhzsf8cVEHrGzIKEAWxgMzYxygOrAVEUJuEm/mhYGPcAKvPVZ7udC4BR
 mnFc3EK9altEPuAFfRlV+axJId1Rg2k+h4fT3QpmKW6gjJMkMTTa3hrImiHSuF34Xw+fWC82d11
 u1dUOGrgevvWbLlGUvmILNBw1vQmX7cq9M1ZREUU6qddog8jVU7jyZCf7i5ZLobPvT6PXXWt6m8
 SdOvmGIzUO7AmAqwcM7mCBQtIacG8AzdZADnMVVPZJYCCFOPI0wdybn4Nyy/7psqnzrsSvvaomA
 ==
X-Google-Smtp-Source: AGHT+IGTlrmk8JEz8CqYJzr+5/eGwYzuUpA9KHBUhOm51NWYExovweXMBNLlaxVLYVBiGy5pociGKw==
X-Received: by 2002:a05:6a00:1709:b0:76e:987b:1dc with SMTP id
 d2e1a72fcca58-7723e275d14mr257706b3a.12.1756506563978; 
 Fri, 29 Aug 2025 15:29:23 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:29:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 45/91] linux-user/m68k: Expand target_elf_gregset_t
Date: Sat, 30 Aug 2025 08:23:41 +1000
Message-ID: <20250829222427.289668-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Make use of the fact that target_elf_gregset_t is a proper structure.
Drop ELF_NREG, target_elf_greg_t, and tswapreg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/m68k/target_elf.h | 24 ++++++++++++++++-----
 linux-user/m68k/elfload.c    | 42 +++++++++++++++++-------------------
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/linux-user/m68k/target_elf.h b/linux-user/m68k/target_elf.h
index cd6908ab57..0737412cee 100644
--- a/linux-user/m68k/target_elf.h
+++ b/linux-user/m68k/target_elf.h
@@ -10,12 +10,26 @@
 
 #define HAVE_ELF_CORE_DUMP      1
 
-typedef abi_ulong target_elf_greg_t;
-
-/* See linux kernel: arch/m68k/include/asm/elf.h.  */
-#define ELF_NREG                20
+/*
+ * See linux kernel: arch/m68k/include/asm/elf.h, where
+ * elf_gregset_t is mapped to struct user_regs_struct via sizeof.
+ *
+ * Note that user_regs_struct has
+ *    short stkadj, sr;
+ *    ...
+ *    short fmtvec, __fill;
+ * but ELF_CORE_COPY_REGS writes to unsigned longs.
+ * Therefore adjust the sr and fmtvec fields to match.
+ */
 typedef struct target_elf_gregset_t {
-    target_elf_greg_t regs[ELF_NREG];
+    abi_ulong d1, d2, d3, d4, d5, d6, d7;
+    abi_ulong a0, a1, a2, a3, a4, a5, a6;
+    abi_ulong d0;
+    abi_ulong usp;
+    abi_ulong orig_d0;
+    abi_ulong sr;
+    abi_ulong pc;
+    abi_ulong fmtvec;
 } target_elf_gregset_t;
 
 #endif
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
index 2970ff7dec..423d1f680a 100644
--- a/linux-user/m68k/elfload.c
+++ b/linux-user/m68k/elfload.c
@@ -18,28 +18,26 @@ const char *get_elf_cpu_model(uint32_t eflags)
     return "any";
 }
 
-#define tswapreg(ptr)   tswapal(ptr)
-
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 {
-    r->regs[0] = tswapreg(env->dregs[1]);
-    r->regs[1] = tswapreg(env->dregs[2]);
-    r->regs[2] = tswapreg(env->dregs[3]);
-    r->regs[3] = tswapreg(env->dregs[4]);
-    r->regs[4] = tswapreg(env->dregs[5]);
-    r->regs[5] = tswapreg(env->dregs[6]);
-    r->regs[6] = tswapreg(env->dregs[7]);
-    r->regs[7] = tswapreg(env->aregs[0]);
-    r->regs[8] = tswapreg(env->aregs[1]);
-    r->regs[9] = tswapreg(env->aregs[2]);
-    r->regs[10] = tswapreg(env->aregs[3]);
-    r->regs[11] = tswapreg(env->aregs[4]);
-    r->regs[12] = tswapreg(env->aregs[5]);
-    r->regs[13] = tswapreg(env->aregs[6]);
-    r->regs[14] = tswapreg(env->dregs[0]);
-    r->regs[15] = tswapreg(env->aregs[7]);
-    r->regs[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    r->regs[17] = tswapreg(env->sr);
-    r->regs[18] = tswapreg(env->pc);
-    r->regs[19] = 0;  /* FIXME: regs->format | regs->vector */
+    r->d1 = tswapal(env->dregs[1]);
+    r->d2 = tswapal(env->dregs[2]);
+    r->d3 = tswapal(env->dregs[3]);
+    r->d4 = tswapal(env->dregs[4]);
+    r->d5 = tswapal(env->dregs[5]);
+    r->d6 = tswapal(env->dregs[6]);
+    r->d7 = tswapal(env->dregs[7]);
+    r->a0 = tswapal(env->aregs[0]);
+    r->a1 = tswapal(env->aregs[1]);
+    r->a2 = tswapal(env->aregs[2]);
+    r->a3 = tswapal(env->aregs[3]);
+    r->a4 = tswapal(env->aregs[4]);
+    r->a5 = tswapal(env->aregs[5]);
+    r->a6 = tswapal(env->aregs[6]);
+    r->d0 = tswapal(env->dregs[0]);
+    r->usp = tswapal(env->aregs[7]);
+    r->orig_d0 = tswapal(env->dregs[0]); /* FIXME */
+    r->sr = tswapal(env->sr);
+    r->pc = tswapal(env->pc);
+    /* FIXME: regs->format | regs->vector */
 }
-- 
2.43.0


