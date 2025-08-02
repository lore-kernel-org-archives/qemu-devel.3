Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C584AC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLNn-0000yB-A4; Sat, 02 Aug 2025 19:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNY-0008MM-Nr
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:04 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNV-0001fU-Py
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:04 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6197e13b6b8so1136399eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176260; x=1754781060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WoXWe4y77AsCGhDaS9yT+kQxHmDuhBAYI2/iArGrG58=;
 b=dk6Mo7++hgua1HNHkuDOQFmiz/XIvdOr26rmgkJbhwk+LtC81oRZjzrj2nD7lE8se4
 ejDBAoNuj1t2B/nLpz1JjWd9acG3UxSCJBFSbYSpdJAVHYLaefnSBKOS8OvMELd2SGwQ
 GAh3iIg7Ln5akFax5FtDIuN8ZpldRs9mKy6CQGPVylDLvLMVTXrPLnzz54Jf6oIWcBtY
 xBN6heIKz9vx5ErdWkDhuj6hoz2y9Mh0GRekGlGV5YQT7IgIdDLPBkraNbnUgTqaPw5E
 oGDn+TL7e+zWMiNMOoqMVgJueHqjfW1yGUV4ybLFhKAjvBIDtPevjR2ixRk7k2i0rhJj
 SDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176260; x=1754781060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoXWe4y77AsCGhDaS9yT+kQxHmDuhBAYI2/iArGrG58=;
 b=fR6Znx34H/H9O+Egdmv1eOAiNRoF94ZbI/FnxpiiliucA4VdEu4qJ2z5eZtV2uqKBg
 6Sd6LF9ipNaDPAXnLTExHnCDi5GYjTeSE8gJWaINGgFRlkzy2VoT04fPlS6kRgv75UP4
 5PvfmRqVelxDb6U/Glh5KtK0KWBOlmGqGWCToiX00HF8M8/XMLO6xXG1RGRJ7DROYGzA
 iPT7g1mDifCCsl5tjLVRuqYrT29C04BgDDdjA5XK3uxOI07qTe4R9q7kvugqQXREJH7J
 GlEZw3U8oOk5qVHd3eH5Ww0Z9MVpaM+Oy9g6+l7+EE3UsrqV7kIazEA0d4LJFTFvMrhu
 DD3w==
X-Gm-Message-State: AOJu0Yyn9SsPBBIw7UDfAqd1RgvhAwNBUx1vU4mP+d6y5opl/d8RJVBj
 Vx42NuJ42gyYpalZNTt8vIPhw6EsZwouUOOnyhiM567g7jCIqZ/CuKg+nklbALl/mHQKE4GA81Q
 6e1k0MHg=
X-Gm-Gg: ASbGncv3jM8XJyj0Mguwy4qkXXLGIOC/bSpA+xzsp5YbrQrqWO7DAMxYmpRLf4Vfvno
 WKDgE12ThVZ+MYkL3I6M0uObdZgxWgybPg9fwkeYNtNK0Etn8Qt61g/Ipr8M+JWI2dJkO46Qf3f
 eY43bUcRzXrasBKb4Tm9EFKPbXjKQKEX2u7WZBoC7+iL1cW53cKUNVGgvlV1E3X4De8nMxPzqXS
 jxO4k8TSo1ETI/SloDqTTl0YOd1RLPYH7sgM8BU0sayTrJoWgpAlYiNU6QwFhpkvU9sP56lKYqp
 sG3fX3P28BdBEdp5pVBbMncO2/lKEpyRmeW1ppdUfLSlLSWn4OS9XthACvIFCtdBIKN2Xouphiz
 jadvcmvATLC5QX+GFszgDbwd3o0q8aKnsoPl8TexjERl3AtfnEGKakIHUgBxyBp8=
X-Google-Smtp-Source: AGHT+IEwtK9RGF5EW2Y0w7REq/+SDUzIqLw7KOtBuqEVJPdKmxNxA/+RCc6PHRKB9f2dHIhoPN+4hw==
X-Received: by 2002:a05:6820:c91:b0:619:355c:f279 with SMTP id
 006d021491bc7-6198f23336bmr2714598eaf.4.1754176260306; 
 Sat, 02 Aug 2025 16:11:00 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.10.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:10:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 46/95] linux-user: Replace tswapreg with tswapl
Date: Sun,  3 Aug 2025 09:04:10 +1000
Message-ID: <20250802230459.412251-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

With the removal of target_elf_greg_t, we don't need
a special case tswap.  Use tswapl for target_ulong.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 264 +++++++++++++++++++++----------------------
 1 file changed, 129 insertions(+), 135 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 70a1e402d3..e7622e7610 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,12 +130,6 @@ int info_is_fdpic(struct image_info *info)
 #define ELF_DATA        ELFDATA2LSB
 #endif
 
-#ifdef TARGET_ABI_MIPSN32
-#define tswapreg(ptr)   tswap64(ptr)
-#else
-#define tswapreg(ptr)   tswapal(ptr)
-#endif
-
 #ifdef USE_UID16
 typedef abi_ushort      target_uid_t;
 typedef abi_ushort      target_gid_t;
@@ -163,33 +157,33 @@ typedef target_ulong target_elf_gregset_t[ELF_NREG];
  */
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
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
+    (*regs)[0] = tswapl(env->regs[15]);
+    (*regs)[1] = tswapl(env->regs[14]);
+    (*regs)[2] = tswapl(env->regs[13]);
+    (*regs)[3] = tswapl(env->regs[12]);
+    (*regs)[4] = tswapl(env->regs[R_EBP]);
+    (*regs)[5] = tswapl(env->regs[R_EBX]);
+    (*regs)[6] = tswapl(env->regs[11]);
+    (*regs)[7] = tswapl(env->regs[10]);
+    (*regs)[8] = tswapl(env->regs[9]);
+    (*regs)[9] = tswapl(env->regs[8]);
+    (*regs)[10] = tswapl(env->regs[R_EAX]);
+    (*regs)[11] = tswapl(env->regs[R_ECX]);
+    (*regs)[12] = tswapl(env->regs[R_EDX]);
+    (*regs)[13] = tswapl(env->regs[R_ESI]);
+    (*regs)[14] = tswapl(env->regs[R_EDI]);
+    (*regs)[15] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
+    (*regs)[16] = tswapl(env->eip);
+    (*regs)[17] = tswapl(env->segs[R_CS].selector & 0xffff);
+    (*regs)[18] = tswapl(env->eflags);
+    (*regs)[19] = tswapl(env->regs[R_ESP]);
+    (*regs)[20] = tswapl(env->segs[R_SS].selector & 0xffff);
+    (*regs)[21] = tswapl(env->segs[R_FS].selector & 0xffff);
+    (*regs)[22] = tswapl(env->segs[R_GS].selector & 0xffff);
+    (*regs)[23] = tswapl(env->segs[R_DS].selector & 0xffff);
+    (*regs)[24] = tswapl(env->segs[R_ES].selector & 0xffff);
+    (*regs)[25] = tswapl(env->segs[R_FS].selector & 0xffff);
+    (*regs)[26] = tswapl(env->segs[R_GS].selector & 0xffff);
 }
 
 #if ULONG_MAX > UINT32_MAX
@@ -240,23 +234,23 @@ typedef target_ulong target_elf_gregset_t[ELF_NREG];
  */
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *env)
 {
-    (*regs)[0] = tswapreg(env->regs[R_EBX]);
-    (*regs)[1] = tswapreg(env->regs[R_ECX]);
-    (*regs)[2] = tswapreg(env->regs[R_EDX]);
-    (*regs)[3] = tswapreg(env->regs[R_ESI]);
-    (*regs)[4] = tswapreg(env->regs[R_EDI]);
-    (*regs)[5] = tswapreg(env->regs[R_EBP]);
-    (*regs)[6] = tswapreg(env->regs[R_EAX]);
-    (*regs)[7] = tswapreg(env->segs[R_DS].selector & 0xffff);
-    (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
-    (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
-    (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
-    (*regs)[12] = tswapreg(env->eip);
-    (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
-    (*regs)[14] = tswapreg(env->eflags);
-    (*regs)[15] = tswapreg(env->regs[R_ESP]);
-    (*regs)[16] = tswapreg(env->segs[R_SS].selector & 0xffff);
+    (*regs)[0] = tswapl(env->regs[R_EBX]);
+    (*regs)[1] = tswapl(env->regs[R_ECX]);
+    (*regs)[2] = tswapl(env->regs[R_EDX]);
+    (*regs)[3] = tswapl(env->regs[R_ESI]);
+    (*regs)[4] = tswapl(env->regs[R_EDI]);
+    (*regs)[5] = tswapl(env->regs[R_EBP]);
+    (*regs)[6] = tswapl(env->regs[R_EAX]);
+    (*regs)[7] = tswapl(env->segs[R_DS].selector & 0xffff);
+    (*regs)[8] = tswapl(env->segs[R_ES].selector & 0xffff);
+    (*regs)[9] = tswapl(env->segs[R_FS].selector & 0xffff);
+    (*regs)[10] = tswapl(env->segs[R_GS].selector & 0xffff);
+    (*regs)[11] = tswapl(get_task_state(env_cpu_const(env))->orig_ax);
+    (*regs)[12] = tswapl(env->eip);
+    (*regs)[13] = tswapl(env->segs[R_CS].selector & 0xffff);
+    (*regs)[14] = tswapl(env->eflags);
+    (*regs)[15] = tswapl(env->regs[R_ESP]);
+    (*regs)[16] = tswapl(env->segs[R_SS].selector & 0xffff);
 }
 
 /*
@@ -294,25 +288,25 @@ typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUARMState *env)
 {
-    (*regs)[0] = tswapreg(env->regs[0]);
-    (*regs)[1] = tswapreg(env->regs[1]);
-    (*regs)[2] = tswapreg(env->regs[2]);
-    (*regs)[3] = tswapreg(env->regs[3]);
-    (*regs)[4] = tswapreg(env->regs[4]);
-    (*regs)[5] = tswapreg(env->regs[5]);
-    (*regs)[6] = tswapreg(env->regs[6]);
-    (*regs)[7] = tswapreg(env->regs[7]);
-    (*regs)[8] = tswapreg(env->regs[8]);
-    (*regs)[9] = tswapreg(env->regs[9]);
-    (*regs)[10] = tswapreg(env->regs[10]);
-    (*regs)[11] = tswapreg(env->regs[11]);
-    (*regs)[12] = tswapreg(env->regs[12]);
-    (*regs)[13] = tswapreg(env->regs[13]);
-    (*regs)[14] = tswapreg(env->regs[14]);
-    (*regs)[15] = tswapreg(env->regs[15]);
+    (*regs)[0] = tswapl(env->regs[0]);
+    (*regs)[1] = tswapl(env->regs[1]);
+    (*regs)[2] = tswapl(env->regs[2]);
+    (*regs)[3] = tswapl(env->regs[3]);
+    (*regs)[4] = tswapl(env->regs[4]);
+    (*regs)[5] = tswapl(env->regs[5]);
+    (*regs)[6] = tswapl(env->regs[6]);
+    (*regs)[7] = tswapl(env->regs[7]);
+    (*regs)[8] = tswapl(env->regs[8]);
+    (*regs)[9] = tswapl(env->regs[9]);
+    (*regs)[10] = tswapl(env->regs[10]);
+    (*regs)[11] = tswapl(env->regs[11]);
+    (*regs)[12] = tswapl(env->regs[12]);
+    (*regs)[13] = tswapl(env->regs[13]);
+    (*regs)[14] = tswapl(env->regs[14]);
+    (*regs)[15] = tswapl(env->regs[15]);
 
-    (*regs)[16] = tswapreg(cpsr_read((CPUARMState *)env));
-    (*regs)[17] = tswapreg(env->regs[0]); /* XXX */
+    (*regs)[16] = tswapl(cpsr_read((CPUARMState *)env));
+    (*regs)[17] = tswapl(env->regs[0]); /* XXX */
 }
 
 #define USE_ELF_CORE_DUMP
@@ -398,10 +392,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     int i;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(env->xregs[i]);
+        (*regs)[i] = tswapl(env->xregs[i]);
     }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(pstate_read((CPUARMState *)env));
+    (*regs)[32] = tswapl(env->pc);
+    (*regs)[33] = tswapl(pstate_read((CPUARMState *)env));
 }
 
 #define USE_ELF_CORE_DUMP
@@ -485,17 +479,17 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
     target_ulong ccr = 0;
 
     for (i = 0; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[i] = tswapreg(env->gpr[i]);
+        (*regs)[i] = tswapl(env->gpr[i]);
     }
 
-    (*regs)[32] = tswapreg(env->nip);
-    (*regs)[33] = tswapreg(env->msr);
-    (*regs)[35] = tswapreg(env->ctr);
-    (*regs)[36] = tswapreg(env->lr);
-    (*regs)[37] = tswapreg(cpu_read_xer(env));
+    (*regs)[32] = tswapl(env->nip);
+    (*regs)[33] = tswapl(env->msr);
+    (*regs)[35] = tswapl(env->ctr);
+    (*regs)[36] = tswapl(env->lr);
+    (*regs)[37] = tswapl(cpu_read_xer(env));
 
     ccr = ppc_get_cr(env);
-    (*regs)[38] = tswapreg(ccr);
+    (*regs)[38] = tswapl(ccr);
 }
 
 #define USE_ELF_CORE_DUMP
@@ -539,11 +533,11 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     (*regs)[TARGET_EF_R0] = 0;
 
     for (i = 1; i < ARRAY_SIZE(env->gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->gpr[i]);
+        (*regs)[TARGET_EF_R0 + i] = tswapl(env->gpr[i]);
     }
 
-    (*regs)[TARGET_EF_CSR_ERA] = tswapreg(env->pc);
-    (*regs)[TARGET_EF_CSR_BADV] = tswapreg(env->CSR_BADV);
+    (*regs)[TARGET_EF_CSR_ERA] = tswapl(env->pc);
+    (*regs)[TARGET_EF_CSR_BADV] = tswapl(env->CSR_BADV);
 }
 
 #define USE_ELF_CORE_DUMP
@@ -599,17 +593,17 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMIPSState *e
     (*regs)[TARGET_EF_R0] = 0;
 
     for (i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
-        (*regs)[TARGET_EF_R0 + i] = tswapreg(env->active_tc.gpr[i]);
+        (*regs)[TARGET_EF_R0 + i] = tswapl(env->active_tc.gpr[i]);
     }
 
     (*regs)[TARGET_EF_R26] = 0;
     (*regs)[TARGET_EF_R27] = 0;
-    (*regs)[TARGET_EF_LO] = tswapreg(env->active_tc.LO[0]);
-    (*regs)[TARGET_EF_HI] = tswapreg(env->active_tc.HI[0]);
-    (*regs)[TARGET_EF_CP0_EPC] = tswapreg(env->active_tc.PC);
-    (*regs)[TARGET_EF_CP0_BADVADDR] = tswapreg(env->CP0_BadVAddr);
-    (*regs)[TARGET_EF_CP0_STATUS] = tswapreg(env->CP0_Status);
-    (*regs)[TARGET_EF_CP0_CAUSE] = tswapreg(env->CP0_Cause);
+    (*regs)[TARGET_EF_LO] = tswapl(env->active_tc.LO[0]);
+    (*regs)[TARGET_EF_HI] = tswapl(env->active_tc.HI[0]);
+    (*regs)[TARGET_EF_CP0_EPC] = tswapl(env->active_tc.PC);
+    (*regs)[TARGET_EF_CP0_BADVADDR] = tswapl(env->CP0_BadVAddr);
+    (*regs)[TARGET_EF_CP0_STATUS] = tswapl(env->CP0_Status);
+    (*regs)[TARGET_EF_CP0_CAUSE] = tswapl(env->CP0_Cause);
 }
 
 #define USE_ELF_CORE_DUMP
@@ -636,15 +630,15 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUMBState *env
     int i, pos = 0;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[pos++] = tswapreg(env->regs[i]);
+        (*regs)[pos++] = tswapl(env->regs[i]);
     }
 
-    (*regs)[pos++] = tswapreg(env->pc);
-    (*regs)[pos++] = tswapreg(mb_cpu_read_msr(env));
+    (*regs)[pos++] = tswapl(env->pc);
+    (*regs)[pos++] = tswapl(mb_cpu_read_msr(env));
     (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->ear);
+    (*regs)[pos++] = tswapl(env->ear);
     (*regs)[pos++] = 0;
-    (*regs)[pos++] = tswapreg(env->esr);
+    (*regs)[pos++] = tswapl(env->esr);
 }
 
 #endif /* TARGET_MICROBLAZE */
@@ -668,10 +662,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     int i;
 
     for (i = 0; i < 32; i++) {
-        (*regs)[i] = tswapreg(cpu_get_gpr(env, i));
+        (*regs)[i] = tswapl(cpu_get_gpr(env, i));
     }
-    (*regs)[32] = tswapreg(env->pc);
-    (*regs)[33] = tswapreg(cpu_get_sr(env));
+    (*regs)[32] = tswapl(env->pc);
+    (*regs)[33] = tswapl(cpu_get_sr(env));
 }
 
 #endif /* TARGET_OPENRISC */
@@ -702,15 +696,15 @@ static inline void elf_core_copy_regs(target_elf_gregset_t *regs,
     int i;
 
     for (i = 0; i < 16; i++) {
-        (*regs)[i] = tswapreg(env->gregs[i]);
+        (*regs)[i] = tswapl(env->gregs[i]);
     }
 
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PR] = tswapreg(env->pr);
-    (*regs)[TARGET_REG_SR] = tswapreg(env->sr);
-    (*regs)[TARGET_REG_GBR] = tswapreg(env->gbr);
-    (*regs)[TARGET_REG_MACH] = tswapreg(env->mach);
-    (*regs)[TARGET_REG_MACL] = tswapreg(env->macl);
+    (*regs)[TARGET_REG_PC] = tswapl(env->pc);
+    (*regs)[TARGET_REG_PR] = tswapl(env->pr);
+    (*regs)[TARGET_REG_SR] = tswapl(env->sr);
+    (*regs)[TARGET_REG_GBR] = tswapl(env->gbr);
+    (*regs)[TARGET_REG_MACH] = tswapl(env->mach);
+    (*regs)[TARGET_REG_MACL] = tswapl(env->macl);
     (*regs)[TARGET_REG_SYSCALL] = 0; /* FIXME */
 }
 
@@ -730,25 +724,25 @@ typedef target_ulong target_elf_gregset_t[ELF_NREG];
 
 static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUM68KState *env)
 {
-    (*regs)[0] = tswapreg(env->dregs[1]);
-    (*regs)[1] = tswapreg(env->dregs[2]);
-    (*regs)[2] = tswapreg(env->dregs[3]);
-    (*regs)[3] = tswapreg(env->dregs[4]);
-    (*regs)[4] = tswapreg(env->dregs[5]);
-    (*regs)[5] = tswapreg(env->dregs[6]);
-    (*regs)[6] = tswapreg(env->dregs[7]);
-    (*regs)[7] = tswapreg(env->aregs[0]);
-    (*regs)[8] = tswapreg(env->aregs[1]);
-    (*regs)[9] = tswapreg(env->aregs[2]);
-    (*regs)[10] = tswapreg(env->aregs[3]);
-    (*regs)[11] = tswapreg(env->aregs[4]);
-    (*regs)[12] = tswapreg(env->aregs[5]);
-    (*regs)[13] = tswapreg(env->aregs[6]);
-    (*regs)[14] = tswapreg(env->dregs[0]);
-    (*regs)[15] = tswapreg(env->aregs[7]);
-    (*regs)[16] = tswapreg(env->dregs[0]); /* FIXME: orig_d0 */
-    (*regs)[17] = tswapreg(env->sr);
-    (*regs)[18] = tswapreg(env->pc);
+    (*regs)[0] = tswapl(env->dregs[1]);
+    (*regs)[1] = tswapl(env->dregs[2]);
+    (*regs)[2] = tswapl(env->dregs[3]);
+    (*regs)[3] = tswapl(env->dregs[4]);
+    (*regs)[4] = tswapl(env->dregs[5]);
+    (*regs)[5] = tswapl(env->dregs[6]);
+    (*regs)[6] = tswapl(env->dregs[7]);
+    (*regs)[7] = tswapl(env->aregs[0]);
+    (*regs)[8] = tswapl(env->aregs[1]);
+    (*regs)[9] = tswapl(env->aregs[2]);
+    (*regs)[10] = tswapl(env->aregs[3]);
+    (*regs)[11] = tswapl(env->aregs[4]);
+    (*regs)[12] = tswapl(env->aregs[5]);
+    (*regs)[13] = tswapl(env->aregs[6]);
+    (*regs)[14] = tswapl(env->dregs[0]);
+    (*regs)[15] = tswapl(env->aregs[7]);
+    (*regs)[16] = tswapl(env->dregs[0]); /* FIXME: orig_d0 */
+    (*regs)[17] = tswapl(env->sr);
+    (*regs)[18] = tswapl(env->pc);
     (*regs)[19] = 0;  /* FIXME: regs->format | regs->vector */
 }
 
@@ -790,10 +784,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
     int i;
     uint32_t *aregs;
 
-    (*regs)[TARGET_REG_PSWM] = tswapreg(env->psw.mask);
-    (*regs)[TARGET_REG_PSWA] = tswapreg(env->psw.addr);
+    (*regs)[TARGET_REG_PSWM] = tswapl(env->psw.mask);
+    (*regs)[TARGET_REG_PSWA] = tswapl(env->psw.addr);
     for (i = 0; i < 16; i++) {
-        (*regs)[TARGET_REG_GPRS + i] = tswapreg(env->regs[i]);
+        (*regs)[TARGET_REG_GPRS + i] = tswapl(env->regs[i]);
     }
     aregs = (uint32_t *)&((*regs)[TARGET_REG_ARS]);
     for (i = 0; i < 16; i++) {
@@ -895,18 +889,18 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 {
     unsigned i;
 
-    (*regs)[TARGET_REG_PC] = tswapreg(env->pc);
-    (*regs)[TARGET_REG_PS] = tswapreg(env->sregs[PS] & ~PS_EXCM);
-    (*regs)[TARGET_REG_LBEG] = tswapreg(env->sregs[LBEG]);
-    (*regs)[TARGET_REG_LEND] = tswapreg(env->sregs[LEND]);
-    (*regs)[TARGET_REG_LCOUNT] = tswapreg(env->sregs[LCOUNT]);
-    (*regs)[TARGET_REG_SAR] = tswapreg(env->sregs[SAR]);
-    (*regs)[TARGET_REG_WINDOWSTART] = tswapreg(env->sregs[WINDOW_START]);
-    (*regs)[TARGET_REG_WINDOWBASE] = tswapreg(env->sregs[WINDOW_BASE]);
-    (*regs)[TARGET_REG_THREADPTR] = tswapreg(env->uregs[THREADPTR]);
+    (*regs)[TARGET_REG_PC] = tswapl(env->pc);
+    (*regs)[TARGET_REG_PS] = tswapl(env->sregs[PS] & ~PS_EXCM);
+    (*regs)[TARGET_REG_LBEG] = tswapl(env->sregs[LBEG]);
+    (*regs)[TARGET_REG_LEND] = tswapl(env->sregs[LEND]);
+    (*regs)[TARGET_REG_LCOUNT] = tswapl(env->sregs[LCOUNT]);
+    (*regs)[TARGET_REG_SAR] = tswapl(env->sregs[SAR]);
+    (*regs)[TARGET_REG_WINDOWSTART] = tswapl(env->sregs[WINDOW_START]);
+    (*regs)[TARGET_REG_WINDOWBASE] = tswapl(env->sregs[WINDOW_BASE]);
+    (*regs)[TARGET_REG_THREADPTR] = tswapl(env->uregs[THREADPTR]);
     xtensa_sync_phys_from_window((CPUXtensaState *)env);
     for (i = 0; i < env->config->nareg; ++i) {
-        (*regs)[TARGET_REG_AR0 + i] = tswapreg(env->phys_regs[i]);
+        (*regs)[TARGET_REG_AR0 + i] = tswapl(env->phys_regs[i]);
     }
 }
 
-- 
2.43.0


