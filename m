Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6769FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:16:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbQy-00023U-Mr; Thu, 28 Aug 2025 08:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQu-00021I-MY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbQs-00076h-V1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:08:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-32326e09f58so911051a91.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382925; x=1756987725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iLTU2Od33oMP9jF0MYnO7hKypI+OnHyTOWI0bio9z0=;
 b=PSYq0UfRh8umX4WxqT0p9wHEMyW7fiiFzEv23FcTo9EjJO0TLpZ0jEiStDyTKfhen8
 uZRaqUeJnhGvDDqaCoAI11cc147m/c1ubTusc/AO5Tzk6wJGapRpbTkjIwCkLob38y30
 dX4DO4SAyObP4xmQNRqTpo/HwWABlIZ5PFGhN0QMpzuVLwl8QcjV8f43YE0U8eVXGPKf
 8NJCKuXrfQS4AnRh0xVhIe/vFz9eQLD22CRLEafVdMnINQTiwSiVoKIVCxpqAvSI/IbH
 ruL+UqDdU0G6TtKQOdq73gsQLmmwv6VdlStA50RWKHNLo/012ze/9hshQyyD3HHxuNKk
 6o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382925; x=1756987725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iLTU2Od33oMP9jF0MYnO7hKypI+OnHyTOWI0bio9z0=;
 b=XM/RwlKwdGCyjThjTNpu1CuBLg9ml5K2ksyTTBK21KGW06AMeG97YGVfkpTtxzFUiL
 xyL5IiOf5LuTg/HzKb+tH+MUT5vnKJ1/UzXslxNAvECwtNWyYMJ8Qw9HoSPqzXSUPNB0
 oUMIwrha8jD32gnEaNasqwNAvrjVJKA285wNjluTgv7bz2Y1T1bgpsntmWzXqpKnx6Nt
 5Aei8TL4scrUGp/7lYdQM15U6eLnbsQ92bnhvRix74dohLINsLSVIGaGfJcBEcBAnDLI
 gmpakloE9NthHrVrq1mVrtl9PY35Y46xcLWw/9wagFa7M47ZMt2Vttj+iXksGJNrjkxb
 /qPw==
X-Gm-Message-State: AOJu0YyAEOgYAqVIVIsN8xtdXkqN4hOTxEdIJhoNTHG+fFNGHSwrpKs9
 3Hlfj7lZjze+bmr+/576NvIPKAKMW/CGz3beHUoEgxH3OELSq93ykhK8+XpquRjCNT6HPw4EQsJ
 8J4Mg//c=
X-Gm-Gg: ASbGnctyHRMGb3E0xjpfE7+qcOYh/LLthCCSR/Ep1shSx7fk3cU3qclOUkikY9Bt0K1
 mF8Qxq8o3c0uemuV7W9dcyWyoJjQEM4uBfP01S28C/b043RkXKYgzROzbWB3yM/A9l1HrikTAhC
 k3rhou6sZQ4afzNcXFa4mWj54bA9b09NEja4d6ZFJUJ2IVVlGGUSG+rAE46BjVOovkUk30//peb
 fNeNE2enq9ecnmLulZ19GD1sb5uRK3TFKgK5xWFzwXilsVSH7746mr1ye9sx8Qb3NCNYXmLRhdQ
 nWHH3nNUNYOk35DKFv1dKhsTadnBmdpIFEJQfg1XM4dFnQtKyZudSzDlSF69TJ5sIY7CmoSgndf
 UCLT3ATca0c3J0wxB7b5lL7rQrw==
X-Google-Smtp-Source: AGHT+IH7ghq5yEyNDPaJ2fD5WRV4we5dOZnJDV8il6kOkqZ+rshKaHfZFLihicsc4aFM/hvB6oplwg==
X-Received: by 2002:a17:90b:2f47:b0:321:9628:ebf5 with SMTP id
 98e67ed59e1d1-32517d1ffbcmr29080246a91.30.1756382925016; 
 Thu, 28 Aug 2025 05:08:45 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:08:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 01/87] linux-user/x86_64: Convert target_elf_gregset_t to a
 struct
Date: Thu, 28 Aug 2025 22:07:10 +1000
Message-ID: <20250828120836.195358-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

A structure typedef may be abstract, while an array typedef cannot.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 60 +++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fce4c05674..ba205c5a19 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -154,7 +154,9 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH       EM_X86_64
 
 #define ELF_NREG    27
-typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
+typedef struct target_elf_gregset_t {
+    target_elf_greg_t regs[ELF_NREG];
+} target_elf_gregset_t;
 
 /*
  * Note that ELF_NREG should be 29 as there should be place for
@@ -163,35 +165,35 @@ typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
+static void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
 {
-    (*regs)[0] = tswapreg(env->regs[15]);
-    (*regs)[1] = tswapreg(env->regs[14]);
-    (*regs)[2] = tswapreg(env->regs[13]);
-    (*regs)[3] = tswapreg(env->regs[12]);
-    (*regs)[4] = tswapreg(env->regs[R_EBP]);
-    (*regs)[5] = tswapreg(env->regs[R_EBX]);
-    (*regs)[6] = tswapreg(env->regs[11]);
-    (*regs)[7] = tswapreg(env->regs[10]);
-    (*regs)[8] = tswapreg(env->regs[9]);
-    (*regs)[9] = tswapreg(env->regs[8]);
-    (*regs)[10] = tswapreg(env->regs[R_EAX]);
-    (*regs)[11] = tswapreg(env->regs[R_ECX]);
-    (*regs)[12] = tswapreg(env->regs[R_EDX]);
-    (*regs)[13] = tswapreg(env->regs[R_ESI]);
-    (*regs)[14] = tswapreg(env->regs[R_EDI]);
-    (*regs)[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[16] = tswapreg(env->eip);
-    (*regs)[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[18] = tswapreg(env->eflags);
-    (*regs)[19] = tswapreg(env->regs[R_ESP]);
-    (*regs)[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
-    (*regs)[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[0] = tswapreg(env->regs[15]);
+    r->regs[1] = tswapreg(env->regs[14]);
+    r->regs[2] = tswapreg(env->regs[13]);
+    r->regs[3] = tswapreg(env->regs[12]);
+    r->regs[4] = tswapreg(env->regs[R_EBP]);
+    r->regs[5] = tswapreg(env->regs[R_EBX]);
+    r->regs[6] = tswapreg(env->regs[11]);
+    r->regs[7] = tswapreg(env->regs[10]);
+    r->regs[8] = tswapreg(env->regs[9]);
+    r->regs[9] = tswapreg(env->regs[8]);
+    r->regs[10] = tswapreg(env->regs[R_EAX]);
+    r->regs[11] = tswapreg(env->regs[R_ECX]);
+    r->regs[12] = tswapreg(env->regs[R_EDX]);
+    r->regs[13] = tswapreg(env->regs[R_ESI]);
+    r->regs[14] = tswapreg(env->regs[R_EDI]);
+    r->regs[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
+    r->regs[16] = tswapreg(env->eip);
+    r->regs[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
+    r->regs[18] = tswapreg(env->eflags);
+    r->regs[19] = tswapreg(env->regs[R_ESP]);
+    r->regs[20] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    r->regs[21] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[22] = tswapreg(env->segs[R_GS].selector & 0xffff);
+    r->regs[23] = tswapreg(env->segs[R_DS].selector & 0xffff);
+    r->regs[24] = tswapreg(env->segs[R_ES].selector & 0xffff);
+    r->regs[25] = tswapreg(env->segs[R_FS].selector & 0xffff);
+    r->regs[26] = tswapreg(env->segs[R_GS].selector & 0xffff);
 }
 
 #if ULONG_MAX > UINT32_MAX
-- 
2.43.0


