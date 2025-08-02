Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34666C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNm-0000uM-Az; Sat, 02 Aug 2025 19:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNc-0000EV-RI
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:09 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNZ-0001fz-O1
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:08 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-610cbca60cdso1074290eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176264; x=1754781064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pE1fLFmCJjFnuFo97HR7nzUPrHPG2zxXSObncEMANME=;
 b=z7bobjeOva9hY/4w7VjRsVFiWQjwH3R7tMaV1hWOW5Nc8ILnV2renmmmKLix+LdByK
 o192CjKnLHjXOpc5T2gRxetRIc71WoLRAj4luVWWdO8PgL5mQ1Vjw4/CCn7SVaGpln2t
 cjCDkl2UuKRkvZQpDa/9pDJhIsLaMbCDhyh7QRHAbsX/e0eBNAIDHOjmPkc8YMfVe1/o
 7z4wlkJEr5mWReQIGwKmxgTzHfsyHIgc9EzZquR+aGELkoBibuYm8m623Mwd+n7y0nNc
 waVGhuZlVI/B06rwz8/JCBfEuD2oOLBGTLDhDEsl1yucou3VBYNeuawoO+2dmQidbwQ4
 nXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176264; x=1754781064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pE1fLFmCJjFnuFo97HR7nzUPrHPG2zxXSObncEMANME=;
 b=Q79dDBUuS2Yh9bEqrhHJIT19WxSPrCOcKIoWUF6cEVViet0IyYycsTKkaMdOODYAGn
 pBAu+C/LSp+cCZImJr053JpBBuy5pWAijzDrO2l+H7XELg8U4gHIfRGNJqQ8Lqw7p4MZ
 yX0JotYLR7Bszi4UyzxfQ5IIX4xaxYrlkg0sS+wJs1KPJfTheia2rJSQo3MpdtvUgFr0
 xwuohGhWqzPSH1ViW/jAFta86W0I5giO+cWdcY9wUusJeExG5zr3vzA8s1d2lDuU9yK5
 3eHT5vUGFsd0NKpHV8gnAfxmveVwXeVK+K0fm7Pgxbs+oqUvBvuuiqvJSs3FSmTMNbJP
 o87w==
X-Gm-Message-State: AOJu0YzgwfoMLkZfluIuHFh65UVPHqKrVGxuEX5mZfd3l+7/8yghNBkS
 MXN6eb3iElXEjEKuZJ98KA+TDRCO1Gf/UDpmXoQM4TlXW1cwA8/lDRM3vJquOAqQJV1pd7M5cqW
 PMk66PPQ=
X-Gm-Gg: ASbGncvxnEtCuzdTX9p+bmM+7rPNpRF1myoCbsqiRfFA4KJQP4qjHl0Y01tuySPVU8H
 +R5FN4J9R7g98lVf2WhDRbfxTpQzljoohkiomZorDX4BAgtTkrogsw72XkaLmC991gElHNq/9XW
 2OqJ6O45Ha7XBIj0MkRZkUYkmOoU8Ee326IWdFoqaBBOUV6QfYeoOGnw6EwIwc1Nb0UEKtilZVs
 yq4WDZZMm0xf6OXlmhZc3EOkvNdAmullTQTOYX7YO1JflbrdsPSyCowkSIj66ungoPoYZMlgpIo
 4Xf/BXwyaQNvywhylx5PNxb9/AdWCpGq6rkcGUBPm4KWAqRI8SSDn1f4MgGfhpKSEY0XeKrR2Oq
 5CR8iprwLCuZidYcYEaWgbUoMjjMD2A8/u0tuYHX/y1Ex8DJN9xRB
X-Google-Smtp-Source: AGHT+IHFQerrw5r16Yz6Kx+H7KLwf1lpAVjPWLeZHd4nfUtkRoygiR/DUMTu4KZnxaOzUrvuruR6AA==
X-Received: by 2002:a05:6820:c019:b0:619:950f:1d5c with SMTP id
 006d021491bc7-619950f261fmr1121058eaf.1.1754176264399; 
 Sat, 02 Aug 2025 16:11:04 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 47/95] linux-user: Unify elf_core_copy_regs signatures
Date: Sun,  3 Aug 2025 09:04:11 +1000
Message-ID: <20250802230459.412251-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

All definitions of target_elf_gregset_t are an array of
ELF_NREG target_ulong.  Unify the signatures of the
target-specific elf_core_copy_regs by passing a pointer
to target_ulong instead.

Update the data usage within struct target_elf_prstatus.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 321 +++++++++++++++++++------------------------
 1 file changed, 143 insertions(+), 178 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e7622e7610..147c309057 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -146,7 +146,6 @@ typedef abi_int         target_pid_t;
 #define ELF_ARCH       EM_X86_64
 
 #define ELF_NREG    27
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /*
  * Note that ELF_NREG should be 29 as there should be place for
@@ -155,35 +154,35 @@ typedef target_ulong target_elf_gregset_t[ELF_NREG];
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 {
-    (*regs)[0] = tswapl(env->regs[15]);
-    (*regs)[1] = tswapl(env->regs[14]);
-    (*regs)[2] = tswapl(env->regs[13]);
-    (*regs)[3] = tswapl(env->regs[12]);
-    (*regs)[4] = tswapl(env->regs[R_EBP]);
-    (*regs)[5] = tswapl(env->regs[R_EBX]);
-    (*regs)[6] = tswapl(env->regs[11]);
-    (*regs)[7] = tswapl(env->regs[10]);
-    (*regs)[8] = tswapl(env->regs[9]);
-    (*regs)[9] = tswapl(env->regs[8]);
-    (*regs)[10] = tswapl(env->regs[R_EAX]);
-    (*regs)[11] = tswapl(env->regs[R_ECX]);
-    (*regs)[12] = tswapl(env->regs[R_EDX]);
-    (*regs)[13] = tswapl(env->regs[R_ESI]);
-    (*regs)[14] = tswapl(env->regs[R_EDI]);
-    (*regs)[15] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[16] = tswapl(env->eip);
-    (*regs)[17] = tswapl(env->segs[R_CS].selector & 0xffff);
-    (*regs)[18] = tswapl(env->eflags);
-    (*regs)[19] = tswapl(env->regs[R_ESP]);
-    (*regs)[20] = tswapl(env->segs[R_SS].selector & 0xffff);
-    (*regs)[21] = tswapl(env->segs[R_FS].selector & 0xffff);
-    (*regs)[22] = tswapl(env->segs[R_GS].selector & 0xffff);
-    (*regs)[23] = tswapl(env->segs[R_DS].selector & 0xffff);
-    (*regs)[24] = tswapl(env->segs[R_ES].selector & 0xffff);
-    (*regs)[25] = tswapl(env->segs[R_FS].selector & 0xffff);
-    (*regs)[26] = tswapl(env->segs[R_GS].selector & 0xffff);
+    regs[0] = tswapl(env->regs[15]);
+    regs[1] = tswapl(env->regs[14]);
+    regs[2] = tswapl(env->regs[13]);
+    regs[3] = tswapl(env->regs[12]);
+    regs[4] = tswapl(env->regs[R_EBP]);
+    regs[5] = tswapl(env->regs[R_EBX]);
+    regs[6] = tswapl(env->regs[11]);
+    regs[7] = tswapl(env->regs[10]);
+    regs[8] = tswapl(env->regs[9]);
+    regs[9] = tswapl(env->regs[8]);
+    regs[10] = tswapl(env->regs[R_EAX]);
+    regs[11] = tswapl(env->regs[R_ECX]);
+    regs[12] = tswapl(env->regs[R_EDX]);
+    regs[13] = tswapl(env->regs[R_ESI]);
+    regs[14] = tswapl(env->regs[R_EDI]);
+    regs[15] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
+    regs[16] = tswapl(env->eip);
+    regs[17] = tswapl(env->segs[R_CS].selector & 0xffff);
+    regs[18] = tswapl(env->eflags);
+    regs[19] = tswapl(env->regs[R_ESP]);
+    regs[20] = tswapl(env->segs[R_SS].selector & 0xffff);
+    regs[21] = tswapl(env->segs[R_FS].selector & 0xffff);
+    regs[22] = tswapl(env->segs[R_GS].selector & 0xffff);
+    regs[23] = tswapl(env->segs[R_DS].selector & 0xffff);
+    regs[24] = tswapl(env->segs[R_ES].selector & 0xffff);
+    regs[25] = tswapl(env->segs[R_FS].selector & 0xffff);
+    regs[26] = tswapl(env->segs[R_GS].selector & 0xffff);
 }
 
 #if ULONG_MAX > UINT32_MAX
@@ -223,7 +222,6 @@ static bool init_guest_commpage(void)
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    17
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /*
  * Note that ELF_NREG should be 19 as there should be place for
@@ -232,25 +230,25 @@ typedef target_ulong target_elf_gregset_t[ELF_NREG];
  *
  * See linux kernel: arch/x86/include/asm/elf.h
  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUX86State *env)
 {
-    (*regs)[0] = tswapl(env->regs[R_EBX]);
-    (*regs)[1] = tswapl(env->regs[R_ECX]);
-    (*regs)[2] = tswapl(env->regs[R_EDX]);
-    (*regs)[3] = tswapl(env->regs[R_ESI]);
-    (*regs)[4] = tswapl(env->regs[R_EDI]);
-    (*regs)[5] = tswapl(env->regs[R_EBP]);
-    (*regs)[6] = tswapl(env->regs[R_EAX]);
-    (*regs)[7] = tswapl(env->segs[R_DS].selector & 0xffff);
-    (*regs)[8] = tswapl(env->segs[R_ES].selector & 0xffff);
-    (*regs)[9] = tswapl(env->segs[R_FS].selector & 0xffff);
-    (*regs)[10] = tswapl(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[12] = tswapl(env->eip);
-    (*regs)[13] = tswapl(env->segs[R_CS].selector & 0xffff);
-    (*regs)[14] = tswapl(env->eflags);
-    (*regs)[15] = tswapl(env->regs[R_ESP]);
-    (*regs)[16] = tswapl(env->segs[R_SS].selector & 0xffff);
+    regs[0] = tswapl(env->regs[R_EBX]);
+    regs[1] = tswapl(env->regs[R_ECX]);
+    regs[2] = tswapl(env->regs[R_EDX]);
+    regs[3] = tswapl(env->regs[R_ESI]);
+    regs[4] = tswapl(env->regs[R_EDI]);
+    regs[5] = tswapl(env->regs[R_EBP]);
+    regs[6] = tswapl(env->regs[R_EAX]);
+    regs[7] = tswapl(env->segs[R_DS].selector & 0xffff);
+    regs[8] = tswapl(env->segs[R_ES].selector & 0xffff);
+    regs[9] = tswapl(env->segs[R_FS].selector & 0xffff);
+    regs[10] = tswapl(env->segs[R_GS].selector & 0xffff);
+    regs[11] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
+    regs[12] = tswapl(env->eip);
+    regs[13] = tswapl(env->segs[R_CS].selector & 0xffff);
+    regs[14] = tswapl(env->eflags);
+    regs[15] = tswapl(env->regs[R_ESP]);
+    regs[16] = tswapl(env->segs[R_SS].selector & 0xffff);
 }
 
 /*
@@ -284,29 +282,14 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
 #define EXSTACK_DEFAULT true
 
 #define ELF_NREG    18
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUARMState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 {
-    (*regs)[0] = tswapl(env->regs[0]);
-    (*regs)[1] = tswapl(env->regs[1]);
-    (*regs)[2] = tswapl(env->regs[2]);
-    (*regs)[3] = tswapl(env->regs[3]);
-    (*regs)[4] = tswapl(env->regs[4]);
-    (*regs)[5] = tswapl(env->regs[5]);
-    (*regs)[6] = tswapl(env->regs[6]);
-    (*regs)[7] = tswapl(env->regs[7]);
-    (*regs)[8] = tswapl(env->regs[8]);
-    (*regs)[9] = tswapl(env->regs[9]);
-    (*regs)[10] = tswapl(env->regs[10]);
-    (*regs)[11] = tswapl(env->regs[11]);
-    (*regs)[12] = tswapl(env->regs[12]);
-    (*regs)[13] = tswapl(env->regs[13]);
-    (*regs)[14] = tswapl(env->regs[14]);
-    (*regs)[15] = tswapl(env->regs[15]);
-
-    (*regs)[16] = tswapl(cpsr_read((CPUARMState *)env));
-    (*regs)[17] = tswapl(env->regs[0]); /* XXX */
+    for (int i = 0; i < 16; i++) {
+        regs[i] = tswapl(env->regs[i]);
+    }
+    regs[16] = tswapl(cpsr_read((CPUARMState *)env));
+    regs[17] = tswapl(env->regs[0]); /* XXX */
 }
 
 #define USE_ELF_CORE_DUMP
@@ -384,18 +367,16 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_CLASS       ELFCLASS64
 
 #define ELF_NREG    34
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUARMState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
 {
     int i;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapl(env->xregs[i]);
+        regs[i] = tswapl(env->xregs[i]);
     }
-    (*regs)[32] = tswapl(env->pc);
-    (*regs)[33] = tswapl(pstate_read((CPUARMState *)env));
+    regs[32] = tswapl(env->pc);
+    regs[33] = tswapl(pstate_read((CPUARMState *)env));
 }
 
 #define USE_ELF_CORE_DUMP
@@ -471,25 +452,24 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/powerpc/include/asm/elf.h.  */
 #define ELF_NREG 48
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUPPCState *env)
 {
     int i;
     target_ulong ccr = 0;
 
     for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[i] = tswapl(env->gpr[i]);
+        regs[i] = tswapl(env->gpr[i]);
     }
 
-    (*regs)[32] = tswapl(env->nip);
-    (*regs)[33] = tswapl(env->msr);
-    (*regs)[35] = tswapl(env->ctr);
-    (*regs)[36] = tswapl(env->lr);
-    (*regs)[37] = tswapl(cpu_read_xer(env));
+    regs[32] = tswapl(env->nip);
+    regs[33] = tswapl(env->msr);
+    regs[35] = tswapl(env->ctr);
+    regs[36] = tswapl(env->lr);
+    regs[37] = tswapl(cpu_read_xer(env));
 
     ccr = ppc_get_cr(env);
-    (*regs)[38] = tswapl(ccr);
+    regs[38] = tswapl(ccr);
 }
 
 #define USE_ELF_CORE_DUMP
@@ -517,7 +497,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 
 /* See linux kernel: arch/loongarch/include/asm/elf.h */
 #define ELF_NREG 45
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 enum {
     TARGET_EF_R0 = 0,
@@ -525,19 +504,18 @@ enum {
     TARGET_EF_CSR_BADV = TARGET_EF_R0 + 34,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPULoongArchState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPULoongArchState *env)
 {
     int i;
 
-    (*regs)[TARGET_EF_R0] = 0;
+    regs[TARGET_EF_R0] = 0;
 
     for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapl(env->gpr[i]);
+        regs[TARGET_EF_R0 + i] = tswapl(env->gpr[i]);
     }
 
-    (*regs)[TARGET_EF_CSR_ERA] = tswapl(env->pc);
-    (*regs)[TARGET_EF_CSR_BADV] = tswapl(env->CSR_BADV);
+    regs[TARGET_EF_CSR_ERA] = tswapl(env->pc);
+    regs[TARGET_EF_CSR_BADV] = tswapl(env->CSR_BADV);
 }
 
 #define USE_ELF_CORE_DUMP
@@ -563,7 +541,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/mips/include/asm/elf.h.  */
 #define ELF_NREG 45
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /* See linux kernel: arch/mips/include/asm/reg.h.  */
 enum {
@@ -583,27 +560,27 @@ enum {
 };
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUMIPSState *env)
 {
     int i;
 
     for (i = 0; i < TARGET_EF_R0; i++) {
-        (*regs)[i] = 0;
+        regs[i] = 0;
     }
-    (*regs)[TARGET_EF_R0] = 0;
+    regs[TARGET_EF_R0] = 0;
 
     for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapl(env->active_tc.gpr[i]);
+        regs[TARGET_EF_R0 + i] = tswapl(env->active_tc.gpr[i]);
     }
 
-    (*regs)[TARGET_EF_R26] = 0;
-    (*regs)[TARGET_EF_R27] = 0;
-    (*regs)[TARGET_EF_LO] = tswapl(env->active_tc.LO[0]);
-    (*regs)[TARGET_EF_HI] = tswapl(env->active_tc.HI[0]);
-    (*regs)[TARGET_EF_CP0_EPC] = tswapl(env->active_tc.PC);
-    (*regs)[TARGET_EF_CP0_BADVADDR] = tswapl(env->CP0_BadVAddr);
-    (*regs)[TARGET_EF_CP0_STATUS] = tswapl(env->CP0_Status);
-    (*regs)[TARGET_EF_CP0_CAUSE] = tswapl(env->CP0_Cause);
+    regs[TARGET_EF_R26] = 0;
+    regs[TARGET_EF_R27] = 0;
+    regs[TARGET_EF_LO] = tswapl(env->active_tc.LO[0]);
+    regs[TARGET_EF_HI] = tswapl(env->active_tc.HI[0]);
+    regs[TARGET_EF_CP0_EPC] = tswapl(env->active_tc.PC);
+    regs[TARGET_EF_CP0_BADVADDR] = tswapl(env->CP0_BadVAddr);
+    regs[TARGET_EF_CP0_STATUS] = tswapl(env->CP0_Status);
+    regs[TARGET_EF_CP0_CAUSE] = tswapl(env->CP0_Cause);
 }
 
 #define USE_ELF_CORE_DUMP
@@ -622,23 +599,22 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
 
 #define USE_ELF_CORE_DUMP
 #define ELF_NREG 38
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUMBState *env)
 {
     int i, pos = 0;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[pos++] = tswapl(env->regs[i]);
+        regs[pos++] = tswapl(env->regs[i]);
     }
 
-    (*regs)[pos++] = tswapl(env->pc);
-    (*regs)[pos++] = tswapl(mb_cpu_read_msr(env));
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapl(env->ear);
-    (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapl(env->esr);
+    regs[pos++] = tswapl(env->pc);
+    regs[pos++] = tswapl(mb_cpu_read_msr(env));
+    regs[pos++] = 0;
+    regs[pos++] = tswapl(env->ear);
+    regs[pos++] = 0;
+    regs[pos++] = tswapl(env->esr);
 }
 
 #endif /* TARGET_MICROBLAZE */
@@ -654,18 +630,16 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
 
 /* See linux kernel arch/openrisc/include/asm/elf.h.  */
 #define ELF_NREG 34 /* gprs and pc, sr */
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUOpenRISCState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUOpenRISCState *env)
 {
     int i;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapl(cpu_get_gpr(env, i));
+        regs[i] = tswapl(cpu_get_gpr(env, i));
     }
-    (*regs)[32] = tswapl(env->pc);
-    (*regs)[33] = tswapl(cpu_get_sr(env));
+    regs[32] = tswapl(env->pc);
+    regs[33] = tswapl(cpu_get_sr(env));
 }
 
 #endif /* TARGET_OPENRISC */
@@ -677,7 +651,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/sh/include/asm/elf.h.  */
 #define ELF_NREG 23
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 /* See linux kernel: arch/sh/include/asm/ptrace.h.  */
 enum {
@@ -690,22 +663,21 @@ enum {
     TARGET_REG_SYSCALL = 22
 };
 
-static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
-                                      const CPUSH4State *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUSH4State *env)
 {
     int i;
 
     for (i = 0; i < 16; i++) {
-        (*regs)[i] = tswapl(env->gregs[i]);
+        regs[i] = tswapl(env->gregs[i]);
     }
 
-    (*regs)[TARGET_REG_PC] = tswapl(env->pc);
-    (*regs)[TARGET_REG_PR] = tswapl(env->pr);
-    (*regs)[TARGET_REG_SR] = tswapl(env->sr);
-    (*regs)[TARGET_REG_GBR] = tswapl(env->gbr);
-    (*regs)[TARGET_REG_MACH] = tswapl(env->mach);
-    (*regs)[TARGET_REG_MACL] = tswapl(env->macl);
-    (*regs)[TARGET_REG_SYSCALL] = 0; /* FIXME */
+    regs[TARGET_REG_PC] = tswapl(env->pc);
+    regs[TARGET_REG_PR] = tswapl(env->pr);
+    regs[TARGET_REG_SR] = tswapl(env->sr);
+    regs[TARGET_REG_GBR] = tswapl(env->gbr);
+    regs[TARGET_REG_MACH] = tswapl(env->mach);
+    regs[TARGET_REG_MACL] = tswapl(env->macl);
+    regs[TARGET_REG_SYSCALL] = 0; /* FIXME */
 }
 
 #define USE_ELF_CORE_DUMP
@@ -720,30 +692,29 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 /* See linux kernel: arch/m68k/include/asm/elf.h.  */
 #define ELF_NREG 20
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUM68KState *env)
 {
-    (*regs)[0] = tswapl(env->dregs[1]);
-    (*regs)[1] = tswapl(env->dregs[2]);
-    (*regs)[2] = tswapl(env->dregs[3]);
-    (*regs)[3] = tswapl(env->dregs[4]);
-    (*regs)[4] = tswapl(env->dregs[5]);
-    (*regs)[5] = tswapl(env->dregs[6]);
-    (*regs)[6] = tswapl(env->dregs[7]);
-    (*regs)[7] = tswapl(env->aregs[0]);
-    (*regs)[8] = tswapl(env->aregs[1]);
-    (*regs)[9] = tswapl(env->aregs[2]);
-    (*regs)[10] = tswapl(env->aregs[3]);
-    (*regs)[11] = tswapl(env->aregs[4]);
-    (*regs)[12] = tswapl(env->aregs[5]);
-    (*regs)[13] = tswapl(env->aregs[6]);
-    (*regs)[14] = tswapl(env->dregs[0]);
-    (*regs)[15] = tswapl(env->aregs[7]);
-    (*regs)[16] = tswapl(env->dregs[0]); /* FIXME: orig_d0 */
-    (*regs)[17] = tswapl(env->sr);
-    (*regs)[18] = tswapl(env->pc);
-    (*regs)[19] = 0;  /* FIXME: regs->format | regs->vector */
+    regs[0] = tswapl(env->dregs[1]);
+    regs[1] = tswapl(env->dregs[2]);
+    regs[2] = tswapl(env->dregs[3]);
+    regs[3] = tswapl(env->dregs[4]);
+    regs[4] = tswapl(env->dregs[5]);
+    regs[5] = tswapl(env->dregs[6]);
+    regs[6] = tswapl(env->dregs[7]);
+    regs[7] = tswapl(env->aregs[0]);
+    regs[8] = tswapl(env->aregs[1]);
+    regs[9] = tswapl(env->aregs[2]);
+    regs[10] = tswapl(env->aregs[3]);
+    regs[11] = tswapl(env->aregs[4]);
+    regs[12] = tswapl(env->aregs[5]);
+    regs[13] = tswapl(env->aregs[6]);
+    regs[14] = tswapl(env->dregs[0]);
+    regs[15] = tswapl(env->aregs[7]);
+    regs[16] = tswapl(env->dregs[0]); /* FIXME: orig_d0 */
+    regs[17] = tswapl(env->sr);
+    regs[18] = tswapl(env->pc);
+    regs[19] = 0;  /* FIXME: regs->format | regs->vector */
 }
 
 #define USE_ELF_CORE_DUMP
@@ -768,7 +739,6 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *e
 
 /* See linux kernel: arch/s390/include/uapi/asm/ptrace.h (s390_regs).  */
 #define ELF_NREG 27
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 enum {
     TARGET_REG_PSWM = 0,
@@ -778,22 +748,21 @@ enum {
     TARGET_REG_ORIG_R2 = 26,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUS390XState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUS390XState *env)
 {
     int i;
     uint32_t *aregs;
 
-    (*regs)[TARGET_REG_PSWM] = tswapl(env->psw.mask);
-    (*regs)[TARGET_REG_PSWA] = tswapl(env->psw.addr);
+    regs[TARGET_REG_PSWM] = tswapl(env->psw.mask);
+    regs[TARGET_REG_PSWA] = tswapl(env->psw.addr);
     for (i = 0; i < 16; i++) {
-        (*regs)[TARGET_REG_GPRS + i] = tswapl(env->regs[i]);
+        regs[TARGET_REG_GPRS + i] = tswapl(env->regs[i]);
     }
-    aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
+    aregs = (uint32_t *)&regs[TARGET_REG_ARS];
     for (i = 0; i < 16; i++) {
         aregs[i] = tswap32(env->aregs[i]);
     }
-    (*regs)[TARGET_REG_ORIG_R2] = 0;
+    regs[TARGET_REG_ORIG_R2] = 0;
 }
 
 #define USE_ELF_CORE_DUMP
@@ -869,7 +838,6 @@ static bool init_guest_commpage(void)
 
 /* See linux kernel: arch/xtensa/include/asm/elf.h.  */
 #define ELF_NREG 128
-typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 enum {
     TARGET_REG_PC,
@@ -884,23 +852,22 @@ enum {
     TARGET_REG_AR0 = 64,
 };
 
-static void elf_core_copy_regs(target_elf_gregset_t *regs,
-                               const CPUXtensaState *env)
+static void elf_core_copy_regs(target_ulong *regs, const CPUXtensaState *env)
 {
     unsigned i;
 
-    (*regs)[TARGET_REG_PC] = tswapl(env->pc);
-    (*regs)[TARGET_REG_PS] = tswapl(env->sregs[PS] & ~PS_EXCM);
-    (*regs)[TARGET_REG_LBEG] = tswapl(env->sregs[LBEG]);
-    (*regs)[TARGET_REG_LEND] = tswapl(env->sregs[LEND]);
-    (*regs)[TARGET_REG_LCOUNT] = tswapl(env->sregs[LCOUNT]);
-    (*regs)[TARGET_REG_SAR] = tswapl(env->sregs[SAR]);
-    (*regs)[TARGET_REG_WINDOWSTART] = tswapl(env->sregs[WINDOW_START]);
-    (*regs)[TARGET_REG_WINDOWBASE] = tswapl(env->sregs[WINDOW_BASE]);
-    (*regs)[TARGET_REG_THREADPTR] = tswapl(env->uregs[THREADPTR]);
+    regs[TARGET_REG_PC] = tswapl(env->pc);
+    regs[TARGET_REG_PS] = tswapl(env->sregs[PS] & ~PS_EXCM);
+    regs[TARGET_REG_LBEG] = tswapl(env->sregs[LBEG]);
+    regs[TARGET_REG_LEND] = tswapl(env->sregs[LEND]);
+    regs[TARGET_REG_LCOUNT] = tswapl(env->sregs[LCOUNT]);
+    regs[TARGET_REG_SAR] = tswapl(env->sregs[SAR]);
+    regs[TARGET_REG_WINDOWSTART] = tswapl(env->sregs[WINDOW_START]);
+    regs[TARGET_REG_WINDOWBASE] = tswapl(env->sregs[WINDOW_BASE]);
+    regs[TARGET_REG_THREADPTR] = tswapl(env->uregs[THREADPTR]);
     xtensa_sync_phys_from_window((CPUXtensaState *)env);
     for (i = 0; i < env->config->nareg; ++i) {
-        (*regs)[TARGET_REG_AR0 + i] = tswapl(env->phys_regs[i]);
+        regs[TARGET_REG_AR0 + i] = tswapl(env->phys_regs[i]);
     }
 }
 
@@ -2857,13 +2824,11 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
  * says that it needs to be array of elf_greg_t that has size of ELF_NREG.
  *
  * #define ELF_NREG <number of registers>
- * typedef taret_elf_greg_t target_elf_gregset_t[ELF_NREG];
  *
  * Last step is to implement target specific function that copies registers
  * from given cpu into just specified register set.  Prototype is:
  *
- * static void elf_core_copy_regs(taret_elf_gregset_t *regs,
- *                                const CPUArchState *env);
+ * static void elf_core_copy_regs(target_ulong *regs, const CPUArchState *env);
  *
  * Parameters:
  *     regs - copy register values into here (allocated and zeroed by caller)
@@ -2891,7 +2856,7 @@ struct target_elf_prstatus {
     struct target_timeval pr_stime;  /* XXX System time */
     struct target_timeval pr_cutime; /* XXX Cumulative user time */
     struct target_timeval pr_cstime; /* XXX Cumulative system time */
-    target_elf_gregset_t      pr_reg;       /* GP registers */
+    target_ulong       pr_reg[ELF_NREG];  /* GP registers */
     abi_int            pr_fpvalid;   /* XXX */
 };
 
@@ -3060,7 +3025,7 @@ static void fill_prstatus_note(void *data, CPUState *cpu, int signr)
         .pr_sid = getsid(0),
     };
 
-    elf_core_copy_regs(&prstatus.pr_reg, cpu_env(cpu));
+    elf_core_copy_regs(prstatus.pr_reg, cpu_env(cpu));
     bswap_prstatus(&prstatus);
     memcpy(data, &prstatus, sizeof(prstatus));
 }
-- 
2.43.0


