Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF10C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNl-0000sY-VZ; Sat, 02 Aug 2025 19:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNf-0000Q4-0X
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:11 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNc-0001gV-S6
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:10 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741b1fe0d48so53977a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176267; x=1754781067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tl4Y/fGNJblvvmq3B2ou0KAzvAx2tU4UlLl5v489TQo=;
 b=k48GQTBwdzJ1SUD0lkhfqE4DKhZYpD7usPd47VOpQUWRbWdInbpDStyJRvcOIOQrRW
 3okoemzviifJ5ke+TEIReEnmlqeFe8Thw6wTMDBiH+XwOi+HNDOmJKdvwyNhPtPR6xmO
 Zz1qJu13qS3QSOFllqT9fSdEeW+OT1e2C4JISNns0I5330bhhO1/QNfSr0W+6sLbIc/p
 5DC4r+EFTtxZA0SdZ+vmwcGFtqkx7OgoBzbbiy2REeewl52OKbu8iKzql5T2QLPK7Z7r
 pBfHHU8JFtduLrP8yc+dJ02d0CrlRV0SZPSXA8IfdqDgZ0/zT9Suwl2X3IP39QgJ9T6h
 WT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176267; x=1754781067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tl4Y/fGNJblvvmq3B2ou0KAzvAx2tU4UlLl5v489TQo=;
 b=g6fNz4aMqgbHNiX79t2thYFyh/9WA+39QDdtdVeuD8kmIQcxUodR1do4+HrAE679/i
 4I8dIXxA2v4TruQIqsMUSFemn6P2+ng+GGHdInlVjPBE7XhwScRYtDA1kzR/kFq3cQtc
 T7mzIG6J9uJJxTZUwjobPK8BmOU5f1VSe52wlIoveeFmQqLC4xcmsaxgpqDNIb89oOZy
 tff+pD+pu/8gyemMkBUzctAyNMeXuZdhwGYitzlVQLSbK+vqhwwet6QY/aXqOO/APmEt
 HUARGODwHLjp5/4WiCXQMCnI6hKIq3t20H0B0OEFJooF2x5rClBL8KMm2KWXUttGQDMf
 kUrQ==
X-Gm-Message-State: AOJu0Yx55ChyYABvjCRDZiq16xgSDE80vqj51olrtJs+y6NQZpYb9dVD
 kijAOils3/84/GGUCSDXBLAFyfpo8vOKMTrIhCRuqMbGsz1n0wNfCMu4msuIt6zJNe60XzaG/aN
 clc0JfbQ=
X-Gm-Gg: ASbGnctpYlOBhrWWFEd7AZD/Jqm19GfA35lnFc2+LB5Bam0u4f9Bz2Z/erGxYBTjf3Q
 NlyCcPEO/Q2kryM3VtJkRjaJB4p0rF8cZmG8qf0DCkzKkFcIdPXUQ59XipuSTahCtoBrJsbgTR+
 HWMNLA4M3NOvQMyvL1UkdtruXyTcsfGIRA0kIx2LOXsWpCiarxs5iBjHscVGtLVysr+UiyvNxpx
 YqI5zhDwrTcDAMMVZ17vvFGgj4Pvzh/AAB88feA4z2JuaB3rQge03OvFRaLhSrX019tYcYW6buQ
 AQvl1EqnCmD5fINvuKa9hrr3FWrf2zxeGxUff98Of0FY69ne26GAjCgKl4y8vhxMfe8kPllnf1c
 dFTNsvfiR2fydEV2eWaeO6wt+EwF6kwUo2itJOhe5mXiGtce8WtygcBh5jikFMTA=
X-Google-Smtp-Source: AGHT+IFRDjzx8CQAETR9FABPCHS2UZlSWhPawBupfdlaAHj8dujDIkyGrzmZxisfexQfxLZHSywNuA==
X-Received: by 2002:a05:6808:2001:b0:40b:4208:7fc0 with SMTP id
 5614622812f47-433f034a598mr2747465b6e.30.1754176267591; 
 Sat, 02 Aug 2025 16:11:07 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 48/95] linux-user: Declare elf_core_copy_regs in loader.h
Date: Sun,  3 Aug 2025 09:04:12 +1000
Message-ID: <20250802230459.412251-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/loader.h  |  1 +
 linux-user/elfload.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/linux-user/loader.h b/linux-user/loader.h
index 6482c7c90c..84bb04f9fd 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -105,5 +105,6 @@ const char *elf_hwcap_str(uint32_t bit);
 const char *elf_hwcap2_str(uint32_t bit);
 const char *get_elf_platform(CPUState *cs);
 const char *get_elf_base_platform(CPUState *cs);
+void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
 
 #endif /* LINUX_USER_LOADER_H */
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 147c309057..0e02e8541b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -154,7 +154,7 @@ typedef abi_int         target_pid_t;
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 {
     regs[0] = tswapl(env->regs[15]);
     regs[1] = tswapl(env->regs[14]);
@@ -230,7 +230,7 @@ static bool init_guest_commpage(void)
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 {
     regs[0] = tswapl(env->regs[R_EBX]);
     regs[1] = tswapl(env->regs[R_ECX]);
@@ -283,7 +283,7 @@ static void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 
 #define ELF_NREG    18
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 {
     for (int i = 0; i < 16; i++) {
         regs[i] = tswapl(env->regs[i]);
@@ -368,7 +368,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 
 #define ELF_NREG    34
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 {
     int i;
 
@@ -453,7 +453,7 @@ static void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUPPCState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUPPCState *env)
 {
     int i;
     target_ulong ccr = 0;
@@ -504,7 +504,7 @@ enum {
     TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
 };
 
-static void elf_core_copy_regs(target_ulong *regs, const CPULoongArchState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPULoongArchState *env)
 {
     int i;
 
@@ -560,7 +560,7 @@ enum {
 };
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
 {
     int i;
 
@@ -601,7 +601,7 @@ static void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
 #define ELF_NREG 38
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
 {
     int i, pos = 0;
 
@@ -631,7 +631,7 @@ static void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
 #define ELF_NREG 34 /* gprs and pc, sr */
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUOpenRISCState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUOpenRISCState *env)
 {
     int i;
 
@@ -663,7 +663,7 @@ enum {
     TARGET_REG_SYSCALL = 22
 };
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
 {
     int i;
 
@@ -693,7 +693,7 @@ static void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUM68KState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUM68KState *env)
 {
     regs[0] = tswapl(env->dregs[1]);
     regs[1] = tswapl(env->dregs[2]);
@@ -748,7 +748,7 @@ enum {
     TARGET_REG_ORIG_R2 = 26,
 };
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUS390XState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUS390XState *env)
 {
     int i;
     uint32_t *aregs;
@@ -852,7 +852,7 @@ enum {
     TARGET_REG_AR0 = 64,
 };
 
-static void elf_core_copy_regs(target_ulong *regs, const CPUXtensaState *env)
+void elf_core_copy_regs(target_ulong *regs, const CPUXtensaState *env)
 {
     unsigned i;
 
@@ -2828,7 +2828,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * Last step is to implement target specific function that copies registers
  * from given cpu into just specified register set.  Prototype is:
  *
- * static void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
+ * void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
  *
  * Parameters:
  *     regs - copy register values into here (allocated and zeroed by caller)
-- 
2.43.0


