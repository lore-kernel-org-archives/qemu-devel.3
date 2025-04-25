Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EEAC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2p-0001GS-AK; Fri, 25 Apr 2025 11:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2R-0008OF-Me
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:27 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2P-0004Aj-1U
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso22184385e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595143; x=1746199943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlTD154RNTsUOn7xNaHUc8PsfGTdrGVjZxkIVHPDq5k=;
 b=W6y4hP9KSkFJteh3F7moyxMIdM1ld3854BQo7CgInnkAkQ1yhKl+RvOpngpUW0Wgzr
 ONIyzemLXNEpGhGZGqQybFlXkSbc6tlSSIl+HKKZph2A5Sx7pUif9hRwIPtS8/1VdNUR
 jnz58X8+683tKoVXIL2HEtPG/vm+gurgc7x15jxIRMbzDj3teItvp116INWwPU7ZEFmU
 7+DHo6+SHpXyS1qR47Rb8Kl8ZGqg7wv/4koYooGBfq/zK3NR64FwqEQc641S5LcmR8uV
 Kz6L8lNGhZZELkau5GnXd1Fcf2mjeEUg7av91Zqm41KrLVh+CE1cb6lcOT7ZBh4TdxaI
 oTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595143; x=1746199943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlTD154RNTsUOn7xNaHUc8PsfGTdrGVjZxkIVHPDq5k=;
 b=prLfuQtE8yKgT1mrBI1EWca0UufEq7Rf7hNFwC+YUBOtlrKqH3qS7KspF/E9Kk15NL
 skn7BVsbpacIPywQYBe3rJYnYgSoPg99kwZDszAMTmB7CxV61JIw29GpwVgAwrvnCA9T
 v6WTidnxvp1dJr26h8BKv+9IhsmC/bbl7r4FDV0yZtPlMacnDV30T9ouii/TO5er4w+r
 REo4YXnv1FQRMj3WAnTjAZAoQzzICdzB91cqi49Xt54hlMzTLD9+5TePHFycPLVkYh/8
 ofL118wYLAfkabirkv/zcGZQD0WMQoNndtt9JMxwMGv8Ssooh3PwFLCfiymcgwH3ZFaQ
 Fsbg==
X-Gm-Message-State: AOJu0YyloozmrkrbTgNcUh4xsxskeeR+6o5ZNs2z3zELO4UFNJCqbf0T
 45Z24drsfRCt/Q57pP3iy63hKgiTrdZkR76Bbv6T6lSSbrQItsoBNQp4wtBcRNmd6GduvShNa+Z
 Q
X-Gm-Gg: ASbGncuArIB4VTUXomQf3OkigrhkNNcXMhYYgMF/Al/Et+raDuFZks/5TuwMuYh11BP
 +tT/dBb67/wnOjYibQzyBAcGWhARlgb+hGRYo4HaA87NPEpxOOKjLTxNCO2V4/ycGnGwHoS+5q0
 DF6d+j+LKSUKOb4CVlP+RLduoIV8DS7Nh2CfsMgtjKm/aP/yf8HYz3APm7uqlsIhxXoYTkfxE5R
 FG0xlJ/G7W6l4N4F+8y39/mTZOwL+ot/NK5e2rd2/3IywZa09uX8LmOBXrD+pVNNo7NXc0xIs3l
 4hhQHIRSldYkmeKMNSA1G8mQ08WJ98I+fieMPSM4b91ShQRBoUqskud1sY7IMhY2kOhUoUNTAoh
 5nt+N1hxCvR2yjWE=
X-Google-Smtp-Source: AGHT+IHB2gU+BycUbmnPWyXUvNOLvaHjAN135kNvpVQVT4H69h9rTBsSkl3qDxXb8q81EGXMeB6nJQ==
X-Received: by 2002:a05:600c:1f82:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-440a6347ff9mr24932305e9.0.1745595142870; 
 Fri, 25 Apr 2025 08:32:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a536a1d1sm28589475e9.26.2025.04.25.08.32.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 44/58] linux-user/elfload: Use target_needs_bswap()
Date: Fri, 25 Apr 2025 17:28:28 +0200
Message-ID: <20250425152843.69638-45-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Check whether we need to swap at runtime using
target_needs_bswap().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250417131004.47205-2-philmd@linaro.org>
---
 linux-user/elfload.c | 63 +++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 99811af5e7b..fbfdec2f17c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -12,6 +12,7 @@
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/translation-block.h"
+#include "exec/tswap.h"
 #include "user/guest-base.h"
 #include "user-internals.h"
 #include "signal-common.h"
@@ -2122,9 +2123,12 @@ static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
     memcpy(to, from, n);
 }
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_ehdr(struct elfhdr *ehdr)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap16s(&ehdr->e_type);            /* Object file type */
     bswap16s(&ehdr->e_machine);         /* Architecture */
     bswap32s(&ehdr->e_version);         /* Object file version */
@@ -2142,8 +2146,11 @@ static void bswap_ehdr(struct elfhdr *ehdr)
 
 static void bswap_phdr(struct elf_phdr *phdr, int phnum)
 {
-    int i;
-    for (i = 0; i < phnum; ++i, ++phdr) {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
+    for (int i = 0; i < phnum; ++i, ++phdr) {
         bswap32s(&phdr->p_type);        /* Segment type */
         bswap32s(&phdr->p_flags);       /* Segment flags */
         bswaptls(&phdr->p_offset);      /* Segment file offset */
@@ -2157,8 +2164,11 @@ static void bswap_phdr(struct elf_phdr *phdr, int phnum)
 
 static void bswap_shdr(struct elf_shdr *shdr, int shnum)
 {
-    int i;
-    for (i = 0; i < shnum; ++i, ++shdr) {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
+    for (int i = 0; i < shnum; ++i, ++shdr) {
         bswap32s(&shdr->sh_name);
         bswap32s(&shdr->sh_type);
         bswaptls(&shdr->sh_flags);
@@ -2174,6 +2184,10 @@ static void bswap_shdr(struct elf_shdr *shdr, int shnum)
 
 static void bswap_sym(struct elf_sym *sym)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap32s(&sym->st_name);
     bswaptls(&sym->st_value);
     bswaptls(&sym->st_size);
@@ -2183,6 +2197,10 @@ static void bswap_sym(struct elf_sym *sym)
 #ifdef TARGET_MIPS
 static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap16s(&abiflags->version);
     bswap32s(&abiflags->ases);
     bswap32s(&abiflags->isa_ext);
@@ -2190,15 +2208,6 @@ static void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags)
     bswap32s(&abiflags->flags2);
 }
 #endif
-#else
-static inline void bswap_ehdr(struct elfhdr *ehdr) { }
-static inline void bswap_phdr(struct elf_phdr *phdr, int phnum) { }
-static inline void bswap_shdr(struct elf_shdr *shdr, int shnum) { }
-static inline void bswap_sym(struct elf_sym *sym) { }
-#ifdef TARGET_MIPS
-static inline void bswap_mips_abiflags(Mips_elf_abiflags_v0 *abiflags) { }
-#endif
-#endif
 
 #ifdef USE_ELF_CORE_DUMP
 static int elf_core_dump(int, const CPUArchState *);
@@ -3144,11 +3153,11 @@ static bool parse_elf_properties(const ImageSource *src,
      * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
      * Swap most of them now, beyond the header and namesz.
      */
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-    for (int i = 4; i < n / 4; i++) {
-        bswap32s(note.data + i);
+    if (target_needs_bswap()) {
+        for (int i = 4; i < n / 4; i++) {
+            bswap32s(note.data + i);
+        }
     }
-#endif
 
     /*
      * Note that nhdr is 3 words, and that the "name" described by namesz
@@ -4000,9 +4009,12 @@ struct target_elf_prpsinfo {
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     prstatus->pr_info.si_signo = tswap32(prstatus->pr_info.si_signo);
     prstatus->pr_info.si_code = tswap32(prstatus->pr_info.si_code);
     prstatus->pr_info.si_errno = tswap32(prstatus->pr_info.si_errno);
@@ -4020,6 +4032,10 @@ static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 
 static void bswap_psinfo(struct target_elf_prpsinfo *psinfo)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     psinfo->pr_flag = tswapal(psinfo->pr_flag);
     psinfo->pr_uid = tswap16(psinfo->pr_uid);
     psinfo->pr_gid = tswap16(psinfo->pr_gid);
@@ -4031,15 +4047,14 @@ static void bswap_psinfo(struct target_elf_prpsinfo *psinfo)
 
 static void bswap_note(struct elf_note *en)
 {
+    if (!target_needs_bswap()) {
+        return;
+    }
+
     bswap32s(&en->n_namesz);
     bswap32s(&en->n_descsz);
     bswap32s(&en->n_type);
 }
-#else
-static inline void bswap_prstatus(struct target_elf_prstatus *p) { }
-static inline void bswap_psinfo(struct target_elf_prpsinfo *p) {}
-static inline void bswap_note(struct elf_note *en) { }
-#endif /* HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN */
 
 /*
  * Calculate file (dump) size of given memory region.
-- 
2.47.1


