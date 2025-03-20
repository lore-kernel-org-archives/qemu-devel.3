Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17148C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:31:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOPB-0002IV-7i; Thu, 20 Mar 2025 18:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP8-00029x-2h
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOP4-00076k-Av
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22359001f1aso33492115ad.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509815; x=1743114615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUQWJa8M2i9P17T56WC7L1ajUU3UpMhiv0rwi6K2NYA=;
 b=Hkd667eP7bMkXie4zy8yuG3vw1x9djl53E2oNotSMMAbikGCqQ3vVNb6o49lG6Dfqx
 bibjOyBO3N4om/1+L3Rh1Wh9ReJkvcX4lEnqYZmCQQP3GoGICkKGf5Ypo0hlxvZvrpIB
 oQqDDUFmrg/q+9wmP39Xla3aUarHjOeB8KmjHO6Mcyp4CW5Df7JCvnOEPT9KK8c51zPh
 iISg3qjrlo7EKwo24wgzMGorsO1hXk5YSRGE8i3NQQG4zxhCE4ZnuyUR2+h1B6zmLBvo
 yI41J4NDcEhi8/x4uhkn8AdxKk0b085UUxuBnt0IJtfdRV8p++hEBvOY0g9+zvKLDxbm
 BQEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509815; x=1743114615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUQWJa8M2i9P17T56WC7L1ajUU3UpMhiv0rwi6K2NYA=;
 b=Fnl4G9oXLvQmTuR5rLkCTwxffwiGHhWWQTPbi/XQQrEeWoE7PsppWr5rZt30NG51aI
 fc6QPXv7e30kWNUiPJgevzxf7expGUAEs3Qxou+Vd9R+v/Xg+eYv7tI4lzljZ/y9mzI9
 9AWnrM+cuA8CkSTmv1DKzQv4jyK64FQmdbreeeOHihZV/kSuQnaXYMTMCxVIcpEH4DR9
 AmEaYPxoYo308/dm6Fp0pFeIu9oGvL2Ts+LX//eUi90aTXazXexUFI81Oy9BSSaImfOH
 O0ZS8/nAqQWRwkV9Exdn40lCkEwCZWe3tp4y8d9PxOY4y2yeoFUHoh17ThcZUtYhTWd/
 T5Pw==
X-Gm-Message-State: AOJu0Ywi9qgeWOOF6SqMQBC0s1BxJE625ZHQ+OB71UxolcRkFwEC4o7A
 o8401SivH9GRvtMfWY4G0RBuqaCbj5l/u5210kauzxq4iHQYR2l5jyV7nNrvcPR4h1JPJPIpzLJ
 J
X-Gm-Gg: ASbGncsdcmK8OCg/nRlLIuptSJc5BirkFNhZkVdYSyoVrUIWI19EZholAfnnsu5Xi0U
 2kTrTwGU0BNpQEmAw0G9nNSvkVTtc+xk5sauo+/vQgM/Dvyemi/N8frVVts6uqkWFHwyt43wnfu
 G6fyNdC1OH2mWkganmmP1/tNYTK3S9Debwdxz0UQK4tj+NRAMnG2v/c2rqVELx54+5FcaepVm8U
 4m97eiV2tcWtVmnlb/64tISFcTOF+iHo/EaPeDlyOFbLYwobWbkacnvSwT3bY/wTHcMAHZn/zGS
 oEm5SFODna8ZPL6aiTykSaqIQiTPFzRhD8m8l0mpLFww
X-Google-Smtp-Source: AGHT+IH6ZvqlVmR/vgYitM0gTW8xnrCBbOkByuhosGlG4c0RqGsCkRYzWH0d/KpBtFj4JuB9Fwyv6A==
X-Received: by 2002:a17:902:f20c:b0:224:256e:5e3f with SMTP id
 d9443c01a7336-22780d8370amr16464875ad.25.1742509815082; 
 Thu, 20 Mar 2025 15:30:15 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 01/30] exec/cpu-all: remove BSWAP_NEEDED
Date: Thu, 20 Mar 2025 15:29:33 -0700
Message-Id: <20250320223002.2915728-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

This identifier is poisoned, so it can't be used from common code
anyway. We replace all occurrences with its definition directly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h    | 12 ------------
 linux-user/syscall_defs.h |  2 +-
 bsd-user/elfload.c        |  6 +++---
 hw/ppc/mac_newworld.c     |  4 +---
 hw/ppc/mac_oldworld.c     |  4 +---
 hw/sparc/sun4m.c          |  6 +-----
 hw/sparc64/sun4u.c        |  6 +-----
 linux-user/elfload.c      |  8 ++++----
 8 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 981a08e3bb3..013fcc9412a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -28,18 +28,6 @@
 #include "system/memory.h"
 #endif
 
-/* some important defines:
- *
- * HOST_BIG_ENDIAN : whether the host cpu is big endian and
- * otherwise little endian.
- *
- * TARGET_BIG_ENDIAN : same for the target cpu
- */
-
-#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
-#define BSWAP_NEEDED
-#endif
-
 /* page related stuff */
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 86d773add75..5d227599924 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -462,7 +462,7 @@ typedef struct {
     abi_ulong sig[TARGET_NSIG_WORDS];
 } target_sigset_t;
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static inline void tswap_sigset(target_sigset_t *d, const target_sigset_t *s)
 {
     int i;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 833fa3bd057..3bca0cc9ede 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -44,7 +44,7 @@ static inline void memcpy_fromfs(void *to, const void *from, unsigned long n)
     memcpy(to, from, n);
 }
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_ehdr(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);            /* Object file type */
@@ -111,7 +111,7 @@ static void bswap_note(struct elf_note *en)
     bswap32s(&en->n_type);
 }
 
-#else /* ! BSWAP_NEEDED */
+#else
 
 static void bswap_ehdr(struct elfhdr *ehdr) { }
 static void bswap_phdr(struct elf_phdr *phdr, int phnum) { }
@@ -119,7 +119,7 @@ static void bswap_shdr(struct elf_shdr *shdr, int shnum) { }
 static void bswap_sym(struct elf_sym *sym) { }
 static void bswap_note(struct elf_note *en) { }
 
-#endif /* ! BSWAP_NEEDED */
+#endif /* HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN */
 
 #include "elfcore.c"
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab482..624c2731a65 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -199,9 +199,7 @@ static void ppc_core99_init(MachineState *machine)
     if (machine->kernel_filename) {
         int bswap_needed = 0;
 
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#endif
+        bswap_needed = HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN;
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0dbcea035c3..439953fc29e 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -155,9 +155,7 @@ static void ppc_heathrow_init(MachineState *machine)
     if (machine->kernel_filename) {
         int bswap_needed = 0;
 
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#endif
+        bswap_needed = HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN;
         kernel_base = KERNEL_LOAD_ADDR;
         kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL, NULL, NULL,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index a48d3622c5a..d27a9b693a5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -235,11 +235,7 @@ static unsigned long sun4m_load_kernel(const char *kernel_filename,
     if (linux_boot) {
         int bswap_needed;
 
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#else
-        bswap_needed = 0;
-#endif
+        bswap_needed = HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN;
         kernel_size = load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
                                NULL, NULL, NULL, NULL,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 8ab5cf0461f..c7bccf584e6 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -170,11 +170,7 @@ static uint64_t sun4u_load_kernel(const char *kernel_filename,
     if (linux_boot) {
         int bswap_needed;
 
-#ifdef BSWAP_NEEDED
-        bswap_needed = 1;
-#else
-        bswap_needed = 0;
-#endif
+        bswap_needed = HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN;
         kernel_size = load_elf(kernel_filename, NULL, NULL, NULL, kernel_entry,
                                kernel_addr, &kernel_top, NULL,
                                ELFDATA2MSB, EM_SPARCV9, 0, 0);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f54054dce3d..99811af5e7b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2122,7 +2122,7 @@ static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
     memcpy(to, from, n);
 }
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_ehdr(struct elfhdr *ehdr)
 {
     bswap16s(&ehdr->e_type);            /* Object file type */
@@ -3144,7 +3144,7 @@ static bool parse_elf_properties(const ImageSource *src,
      * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
      * Swap most of them now, beyond the header and namesz.
      */
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
     for (int i = 4; i < n / 4; i++) {
         bswap32s(note.data + i);
     }
@@ -4000,7 +4000,7 @@ struct target_elf_prpsinfo {
     char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
 };
 
-#ifdef BSWAP_NEEDED
+#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
 static void bswap_prstatus(struct target_elf_prstatus *prstatus)
 {
     prstatus->pr_info.si_signo = tswap32(prstatus->pr_info.si_signo);
@@ -4039,7 +4039,7 @@ static void bswap_note(struct elf_note *en)
 static inline void bswap_prstatus(struct target_elf_prstatus *p) { }
 static inline void bswap_psinfo(struct target_elf_prpsinfo *p) {}
 static inline void bswap_note(struct elf_note *en) { }
-#endif /* BSWAP_NEEDED */
+#endif /* HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN */
 
 /*
  * Calculate file (dump) size of given memory region.
-- 
2.39.5


