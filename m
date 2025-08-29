Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9B3CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkC-0000wu-QS; Sat, 30 Aug 2025 11:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X8-00035B-Rn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:22 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7X6-0002we-Nn
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:25:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77033293ed8so2352415b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506319; x=1757111119; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdSZmf4gf+D2YfOOkYcOeqd7VudOjMm2IgypnFCFG5I=;
 b=R6g0COUXlaiPMJDafAY5L0hfsbB7k1IadQawms/kJUoWbQZxQ97AnydiE8sFqBJpBo
 Vk2xBpbJ/L2dmHhDUhQj0XmxuptnOLGc5jiQt3bmEu4B4m5Z84AGBJngPYXYbmY9SiKD
 fedzVE0yVprmu3NO4bhQ8jS9BFLSGCFD6CXnwmiQJ/NPYpcTLV4sFi2cX5nOH6j6DVx6
 p1faZfSXZ8xRGmMqQSJt3yBzG1gw5NXvbUYITkefyeVslYVjaMu+ONxRo9TMaqnRIwEc
 GZpTPywgd7HRBqE1YXSOjwMUt/uHnMKykn2FY/bkYyqpKFsaQS+EKeb8c5kn6o3fuR+/
 7r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506319; x=1757111119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xdSZmf4gf+D2YfOOkYcOeqd7VudOjMm2IgypnFCFG5I=;
 b=TZq7/52v+wmEbf8eAbk+4uaInl/uTzSouFlRR1U8/fZZaJZVHA+0PB9ZBcaQshdP6i
 tHiK6aH+CMv34Pbd0N/PxWxpCLqEjxsLzHSBN/Ay2q91mmgkKamL2yDSKzwGgAVBXWsy
 9aqo/cEOeyva7FsQquT8N3qjBeDY5er2culvId/FjMKVIP2TURN700Hp2qAqO/OI+zyf
 T4NsRAMVbHe4DLyBhwrsMqgXyXA7Kta78jP03X2+h3kmwKO4g2RqmyCmaCN6+JDCPeAN
 B87bLy8vpA2WtLaxylTJ9iWZCUO4wnXdYLVuZc8POTZiP+vti0HbpGnUHvo5/aUOEdoV
 GlnA==
X-Gm-Message-State: AOJu0Yz665xreP38lI9v6zbbjx/CrCQ2NzC+h3UC2bNzyxbhHC9JKMuL
 ZaHxiemXgBgugPYXi5fZu7t/5fISgwycCgsoP9dKkMSZD6pRtu0xPbu8SRAdOXWQQz3Za8ZFxkq
 6Bv2A/w0=
X-Gm-Gg: ASbGncvgLU+gG93QozjfytCVraLM3KYl0VWv/I0IZUUChAGsabEuQ5FxZsPTRlT8D0g
 6oEj7btGyybalPBIDThUmTuEPcF4SZVjEIxl9iUvYrN12nfxojqPTb3KEwa9uDcfqQ+wwadcQs8
 53JJrSCV3W09CV4zdvCp2LGiMJNmswu0YsvpJ9lUfCA5Ueg6tBq5bVljJYD4xUkvyYH47ROhK5Y
 ljBDMv6M2HuDk+1wG+empIMPmTxzRiWxCF98eVBBx13cl2pQk5Mium7OmRE3GCZjo2wF+6p72t4
 mKIhgHx2+Gq54UslgKdm3f1dyc63HyYy8m8FCqJSGMy4bnpD++/tQkSweUEClOysuA4X2w3lq/b
 JMDBeUPDhPG7rTPiZo0MfrGAMyy9HkidJwV/EpePy58XtZmSS/EFAPOI7meFNSVwxpQSic4k=
X-Google-Smtp-Source: AGHT+IE6G8OQ44EsQZVppr97etnCQXNlov+mussN+3HAQQ3mjFZGJswhBrroZVTvE9COq5X/TREQOA==
X-Received: by 2002:a05:6a00:3e0f:b0:771:e06b:7edf with SMTP id
 d2e1a72fcca58-7723e350dcbmr319402b3a.24.1756506319195; 
 Fri, 29 Aug 2025 15:25:19 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a71c60bsm3302493b3a.103.2025.08.29.15.25.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:25:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/91] linux-user: Declare elf_core_copy_regs in loader.h
Date: Sat, 30 Aug 2025 08:23:15 +1000
Message-ID: <20250829222427.289668-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Drop the static from all implementations.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h  |  3 +++
 linux-user/elfload.c | 33 ++++++++++++++-------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 6482c7c90c..8f4a7f69ac 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -106,4 +106,7 @@ const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
 
+struct target_elf_gregset_t;
+void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
+
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 74f88dfa68..5ed5b3c544 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -165,7 +165,7 @@ typedef struct target_elf_gregset_t {
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->regs[0] = tswapreg(env->regs[15]);
     r->regs[1] = tswapreg(env->regs[14]);
@@ -244,7 +244,7 @@ typedef struct target_elf_gregset_t {
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
     r->regs[0] = tswapreg(env->regs[R_EBX]);
     r->regs[1] = tswapreg(env->regs[R_ECX]);
@@ -300,7 +300,7 @@ typedef struct target_elf_gregset_t {
     target_elf_greg_t regs[ELF_NREG];
 } target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
     for (int i = 0; i < 16; ++i) {
         r->regs[i] = tswapreg(env->regs[i]);
@@ -388,7 +388,7 @@ typedef struct target_elf_gregset_t {
     target_elf_greg_t regs[ELF_NREG];
 } target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUARMState *env)
 {
     for (int i = 0; i < 32; i++) {
         r->regs[i] = tswapreg(env->xregs[i]);
@@ -474,7 +474,7 @@ typedef struct target_elf_gregset_t {
     target_elf_greg_t regs[ELF_NREG];
 } target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUPPCState *env)
 {
     int i;
     target_ulong ccr = 0;
@@ -528,8 +528,7 @@ enum {
     TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *r,
-                               const CPULoongArchState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPULoongArchState *env)
 {
     r->regs[TARGET_EF_R0] = 0;
 
@@ -586,7 +585,7 @@ enum {
 };
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
 {
     int i;
 
@@ -628,7 +627,7 @@ typedef struct target_elf_gregset_t {
 } target_elf_gregset_t;
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMBState *env)
 {
     for (int i = 0; i < 32; i++) {
         r->regs[i] = tswapreg(env->regs[i]);
@@ -659,8 +658,7 @@ typedef struct target_elf_gregset_t {
     target_elf_greg_t regs[ELF_NREG];
 } target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *r,
-                               const CPUOpenRISCState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUOpenRISCState *env)
 {
     for (int i = 0; i < 32; i++) {
         r->regs[i] = tswapreg(cpu_get_gpr(env, i));
@@ -693,7 +691,7 @@ enum {
     TARGET_REG_SYSCALL = 22
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUSH4State *env)
 {
     for (int i = 0; i < 16; i++) {
         r->regs[i] = tswapreg(env->gregs[i]);
@@ -724,7 +722,7 @@ typedef struct target_elf_gregset_t {
     target_elf_greg_t regs[ELF_NREG];
 } target_elf_gregset_t;
 
-static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUM68KState *env)
 {
     r->regs[0] = tswapreg(env->dregs[1]);
     r->regs[1] = tswapreg(env->dregs[2]);
@@ -782,8 +780,7 @@ enum {
     TARGET_REG_ORIG_R2 = 26,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *r,
-                               const CPUS390XState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUS390XState *env)
 {
     int i;
     uint32_t *aregs;
@@ -890,8 +887,7 @@ enum {
     TARGET_REG_AR0 = 64,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *r,
-                               const CPUXtensaState *env)
+void elf_core_copy_regs(target_elf_gregset_t *r, const CPUXtensaState *env)
 {
     unsigned i;
 
@@ -2865,8 +2861,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * Last step is to implement target specific function that copies registers
  * from given cpu into just specified register set.  Prototype is:
  *
- * static void elf_core_copy_regs(taret_elf_gregset_t *regs,
- *                                const CPUArchState *env);
+ * void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUArchState *env);
  *
  * Parameters:
  *     regs - copy register values into here (allocated and zeroed by caller)
-- 
2.43.0


