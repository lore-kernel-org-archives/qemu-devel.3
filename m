Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F37DC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbRy-00030v-CH; Thu, 28 Aug 2025 08:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRT-0002Pa-4s
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRQ-0007Dn-Mf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:22 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-24633f57e0bso5527475ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382959; x=1756987759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO/by0/tbmDYzcjyREljwjFXyz94mevqXElOlRv7pZQ=;
 b=Wjyx1BY+F3fy/ZXRHaHsd3U/D5DUHLmUy3hVSbWlLQTQczbD82kES9Q9VigPa3vQeK
 OQmOe6Tkkjc6RWJkcYiK+ynjUb0asywmYBDlIk+IuwYRP3zAdPA0w79FQdZX2ZC3fx7T
 b+DJYg/SzklJqNHQgJ/dEfSswlY0S6l3OII1bylsVKF4JoqE+6YFoVKqSdOpViPxFfOl
 VTHcNS8pNJN06GugMTJhV7BOZgZWif86SkMu96AejWHCj+ixiBlY2/LOIZjWAKE8dzQr
 rd8utCTJHg8BbXC0S6UiIGwuGNVwXCJJLebGGOP5pGpwkD6+XPPoXnDFMDhHYRA53KEO
 DRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382959; x=1756987759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO/by0/tbmDYzcjyREljwjFXyz94mevqXElOlRv7pZQ=;
 b=hlbAstOW1mpf6thh84VYhy7dJKIgkYSvE6mgysGEllS7qbQ+lv/OBYIlCwX8a8pJ6f
 8luVb6ImtCKtrR6rXPtZFJTV7ssmbFDd6Hr/hSTwRobxNi0vsexxAM2eYtg9ukkCwdTx
 P7E8Nqzue6x0WcOIxHLuE95qV4aLhKhc6x1XLYjJsYphBQm+vNeqgqlyqNiwU8hLuvYx
 LOXRO+rSpsPMf3Bke0PtXRQs5DTrsffcXwqhXzULrF1rT7TYmupvXrbBet6eDGXCjlL3
 dmLlsbkw4wWbfsJ3waYDqtUJx7BJ3J69X+Xe0SbZ/ioY7EmvPLpMkYhWi368rorRnkDM
 lX4g==
X-Gm-Message-State: AOJu0YxK8gB5Q+bxeMe97rh5vS47dS8t8Y++wMjChDra6DukcWLDiN6l
 Vfgax1aftg4b2Pa/RtUBcXjIw+p2xqAd1BaByB9oHh6pE9LL+IxB4rEIDvd9I5MepGaZkRqQjpW
 XqK2vs4o=
X-Gm-Gg: ASbGnculvu2mGUHGYYorL6n46ne3je88Ad9D9B7gA1RutxUuxsH1nyf8PlzerWTazRR
 WiuG/Y1y7h3apNNKVtsJuIoaNDdMTHpNCH5PpgtH4sTz4RmIvtR1iO5JjuqKEWxGLQThouwiIrX
 L++IeTKysN/qL/a6GD8qpWvo/MUT98Qb3NDEG7apR239r1MCvTDXHvEHBnKMkoCeDrdOeYMXhEc
 6sO1YbRAE4MoLs23muh3iaCcnXbk8rk9sfiGeHQTOzXm39XJeKWvESHGxv52gPlI0ea8QxFNC/w
 gHsx4XfqDPgfS7jK+Xqf6iZ9ngjfUofd7Dsvskiy+Bl/9kqeG9P65eac39KfMq1y6KT666I31zs
 Ok+mXPJHV6SLb+xI7+h1uSaDrjRmQOnEFZpmm
X-Google-Smtp-Source: AGHT+IFCCscqizuG84u8Cgj0RJPdWFTw/+uqtp06faTOZEsqP/+HK/4mE3bptCHwBtcbyBw/xkQMxg==
X-Received: by 2002:a17:903:4b4e:b0:248:d49f:1d71 with SMTP id
 d9443c01a7336-248d49f244fmr26198215ad.60.1756382959090; 
 Thu, 28 Aug 2025 05:09:19 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 15/87] linux-user: Declare elf_core_copy_regs in loader.h
Date: Thu, 28 Aug 2025 22:07:24 +1000
Message-ID: <20250828120836.195358-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


