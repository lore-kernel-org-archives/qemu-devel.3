Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7294DC55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfD6-00044x-0r; Wed, 05 Aug 2026 13:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfD0-00042q-ML
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:14 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wrfCz-0006FB-5v
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:15:14 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81f3b227a4aso20286007b3.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785950112; x=1786554912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=urriLtqPEl/gKuko2XbipDGuuTKCURnorwcdL1mLq/8=;
 b=WFf/fioVWUtOI7i5hJpSRlqCSvYkIouMsRQkVftFvtobKyHbH/s9/sXy76ebT25z0f
 DLijDySVpQU1PnuhFrpD4wcH7d+ft1xHA75cPPWze8N/CDu68GEhIvkXaJROlpFmSX7K
 SIR2LXFqE2nWoD4c4VpiJzRj6+dwpWgYOz9icEatBkR/u5jdk3HUn8a9zZnvieMegqhX
 +KOzmWlDf9r/Zld1Z6MgimEYKFHMY7eoVCCLwMU0P1Ubk4qLB6RgIv9iVW4Qd1vRGQXO
 xOurz5pCSzh/lfrnYetUpbpsa/8D4FunYwSFJhPvywkG9Mr7AaJ0zHPyew5+qh5EWWcE
 ZwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950112; x=1786554912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=urriLtqPEl/gKuko2XbipDGuuTKCURnorwcdL1mLq/8=;
 b=KSaiurPTwHgYPdOmIySKFx+/V1TJ51Lwzu2Nboah51EnMMYv36D9Gf7A8U+APSpdMN
 9jO+K/9+tcQh0wihI2I1/BeZ/EuIoD7dCCsJPG6FS7olMVrD9lJQCiRh5JiWGfWROD85
 Es+g4sY6nehnPUOXLepQVc7sP7RYYd2zMjhBGfUYzCYS3q7GGrlMZja0UfiokqQ2c9RT
 DbqJ5u904HwJJ4a9VjS6a36MYfGa8sMpX/qXzpl3qEScixjF7AVdpu26an8f7FGkqYCM
 fvSFwUPtUU9yoNs1bCWDLVLg82chYKxhCZASViNaSzXisaRmMyeAr5ISiXaaX0LkNkW1
 AQ8g==
X-Gm-Message-State: AOJu0Yy16Oz805Ec6ndtfizf1FS68QPrgAHLnMAFCt4HtaSuHqh7RhIU
 AFd3AYgK5oGgQPO9oZjily+nzc+vqbbi3zWkKW3N7nxVkq/90E/qrnOtWbF6coVhI0U=
X-Gm-Gg: AR+sD10Npxnnk9fZtqYctZqDHfTDhIKtakZVsaG0zb2wegJZ78Gg1fVUv2i6S5jab2l
 FqMtNmjcyFyVuhngYeGktjas+1vapLb+80ZA1wD0TecvWJ/bEEj1eAkQ3/FkW6UkMFjsZnJtUac
 CTOhfrq1qUsA4fn7Nchh5NpcrhDPb1geZkBX0l4efi6Wq13G/9X10TAPASremBm3yvNAREVcGR2
 DaU14VnPlKmEFaxqlz3UylLSkxUTKS76j0XApTHJHTk+2pWoktDZ5PYwyabAXkGGL+wH8//HAAQ
 XQRKC/PPscvTLZ8Tbmwrm05xnD0t9ciAvTk+ciWFYoteqJ1QKZlT7j/uk1PB8W9gKk2S4Z8uj9e
 V6cI+v9D82JEWMvJY23Vt6HA2ASuCaj9sK4/wO2h+6N6bie12SwOL4WXRGCn7IzwwYc4Eugb9KX
 6aguL2DOIC/LmCSaGjOTQvKFlRsPP3ZV/3E3CceJ3g//CQ/HLt4UeR4PqjXKGd
X-Received: by 2002:a05:690c:9a12:b0:81f:6503:701a with SMTP id
 00721157ae682-8201f0b1331mr49017727b3.9.1785950112023; 
 Wed, 05 Aug 2026 10:15:12 -0700 (PDT)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8201341ddedsm24938817b3.23.2026.08.05.10.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 10:15:10 -0700 (PDT)
From: Matt Turner <mattst88@gmail.com>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/5] linux-user/mips: write the floating-point registers to a
 core dump
Date: Wed,  5 Aug 2026 13:15:04 -0400
Message-ID: <20260805171507.3119442-2-mattst88@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805171507.3119442-1-mattst88@gmail.com>
References: <20260805171507.3119442-1-mattst88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=mattst88@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Write an NT_FPREGSET note for MIPS and MIPS64, matching the kernel's
elf_fpregset_t layout (ELF_NFPREG = 33): fpr[0..31] hold f0-f31, and
fcsr occupies the low 32 bits of slot 32.  The pad field rounds the
struct to 33 × 8 bytes = 264 bytes.

Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 linux-user/mips/elfload.c      |  8 ++++++++
 linux-user/mips/target_elf.h   | 13 +++++++++++++
 linux-user/mips64/target_elf.h | 13 +++++++++++++
 3 files changed, 34 insertions(+)

diff --git ./linux-user/mips/elfload.c ./linux-user/mips/elfload.c
index ce2c4514f3..1d62ae0a4d 100644
--- ./linux-user/mips/elfload.c
+++ ./linux-user/mips/elfload.c
@@ -130,6 +130,14 @@ const char *get_elf_base_platform(CPUState *cs)
 
 #undef MATCH_PLATFORM_INSN
 
+void elf_core_copy_fpregs(target_elf_fpregset_t *r, const CPUMIPSState *env)
+{
+    for (int i = 0; i < 32; i++) {
+        r->fpr[i] = tswap64(env->active_fpu.fpr[i].d);
+    }
+    r->fcsr = tswap32(env->active_fpu.fcr31);
+}
+
 /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
 #ifndef TARGET_MIPS64
 void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
diff --git ./linux-user/mips/target_elf.h ./linux-user/mips/target_elf.h
index 157306f7a0..426f905d3a 100644
--- ./linux-user/mips/target_elf.h
+++ ./linux-user/mips/target_elf.h
@@ -26,4 +26,17 @@ typedef struct target_elf_gregset_t {
     };
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches the kernel's elf_fpregset_t (ELF_NFPREG = 33):
+ *   fpr[0..31] hold f0-f31; fcsr occupies the low 32 bits of slot 32.
+ *   pad rounds the struct to 33 × 8 bytes = 264 bytes.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+    uint32_t fcsr;
+    uint32_t pad;
+} target_elf_fpregset_t;
+
 #endif
diff --git ./linux-user/mips64/target_elf.h ./linux-user/mips64/target_elf.h
index 061471a0f1..efb5d97563 100644
--- ./linux-user/mips64/target_elf.h
+++ ./linux-user/mips64/target_elf.h
@@ -32,4 +32,17 @@ typedef struct target_elf_gregset_t {
     };
 } target_elf_gregset_t;
 
+#define HAVE_ELF_CORE_FPREGS    1
+
+/*
+ * Matches the kernel's elf_fpregset_t (ELF_NFPREG = 33):
+ *   fpr[0..31] hold f0-f31; fcsr occupies the low 32 bits of slot 32.
+ *   pad rounds the struct to 33 × 8 bytes = 264 bytes.
+ */
+typedef struct target_elf_fpregset_t {
+    uint64_t fpr[32];
+    uint32_t fcsr;
+    uint32_t pad;
+} target_elf_fpregset_t;
+
 #endif
-- 
2.54.0


