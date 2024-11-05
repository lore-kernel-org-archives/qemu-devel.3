Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F398AD2C11E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 15:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8L6O-0000ri-PB; Tue, 05 Nov 2024 10:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L66-0000qL-Nc
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:04:01 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8L64-0000sC-FU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:03:58 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso65843845e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730819034; x=1731423834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKJ6rUlZAefITLcvceunRCf84be+5Vcrxe5vzgoY/DE=;
 b=FzTYufAPAXDPdveTGMTBjKjl7ssr8FaAE1NP4MOobOXygqDMcHCm9gn3SVtNhUgZOj
 SwiDEbNjCBhwslpHXn5d7KF4K4L5g0rXgrQErKwHmhCgSWPTu2Gx4hZIAIHcRI1d7RFU
 M8S3mmFRr9qjaHMTG2XJJTyprqp97Fdyg1KXLedIsK/1LCLZzXN5W+szUYTwpzPSnFC7
 fV84gKVyXqTXxPAuBEK6xm6FUs7S5Ks1mJKP2ZCIgm5go+819WFJFBlZ6P7I0k52NT2B
 Z6dvBNmJXATbMOJXBJHa+pwQgCA54mJ5Vh3pTBzENZsXyUcQ2eTj8Umw0bzSWbdLzfcJ
 Hkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819034; x=1731423834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKJ6rUlZAefITLcvceunRCf84be+5Vcrxe5vzgoY/DE=;
 b=Wni1ygC1Q7Hods9XkATlStFGSZy/+0a0LzgKQ82Gdip0Lsjo341ryC5BIzLu2x3C70
 2d/ks29eyafX6aqhvN7Va87ccdeIu19nNNL8sDhCL1l8Pm4DFvpHprm21QLEL2B1XmvC
 jW9R7/XYuhJbd1n1PLALU3Ty+8/SDU3W+SqW8fbZ8VsSPxxeTzNaEcndqNOSzo7DJLJQ
 L/d0o3qpk8fhYVldEGokLEKzGAkkOR4FBAaW3DYftDH4Wo/QI+pN/So1FFzd2qHXMjYc
 Ll7/YxT+7EzdacwysVg59tGZaKEwPd5/3oK9n6nu7kP/xm2mkouGe4Y0Vmq4DHpNV/Ye
 mUGA==
X-Gm-Message-State: AOJu0YxwfSW46im6Ub+r5NDFCU89y59Eo1Cw+C3Vy3aUgfY7ZdS5YGNU
 mLcPD/LextA7LYty8RbX9lHY6x33UxIfK1nXV4w2utEaqWJ5qQEUISkTiA5Jokcvh0kA9wyNkx+
 9lxI=
X-Google-Smtp-Source: AGHT+IGROxjAT+QgFog8ekxMk4eECGyf2ncFy1aCrBUtHnQpIbOsVY5wMqGuIgNi4WB9oqNFpA5byw==
X-Received: by 2002:a05:600c:1c9c:b0:42c:a8cb:6a5a with SMTP id
 5b1f17b1804b1-43283255a50mr163773155e9.15.1730819033875; 
 Tue, 05 Nov 2024 07:03:53 -0800 (PST)
Received: from stoup.. ([154.14.63.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9ca6f8sm221301855e9.39.2024.11.05.07.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:03:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 2/4] linux-user: Fix GDB complaining about system-supplied DSO
 string table index
Date: Tue,  5 Nov 2024 15:03:46 +0000
Message-ID: <20241105150348.446982-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241105150348.446982-1-richard.henderson@linaro.org>
References: <20241105150348.446982-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

When debugging qemu-user processes using gdbstub, the following warning
appears every time:

    warning: BFD: warning: system-supplied DSO at 0x7f8253cc3000 has a corrupt string table index

The reason is that QEMU does not map the VDSO's section headers. The
VDSO's ELF header's e_shoff points to zeros, which GDB fails to parse.

The difference with the kernel's VDSO is that the latter is mapped as a
blob, ignoring program headers - which also don't cover the section
table. QEMU, on the other hand, loads it as an ELF file.

There appears to be no way to place section headers inside a section,
and, therefore, no way to refer to them from a linker script. Also, ld
hardcodes section headers to be non-loadable, see
_bfd_elf_assign_file_positions_for_non_load(). In theory ld could be
enhanced by implementing an "SHDRS" keyword in addition to the existing
"FILEHDR" and "PHDRS".

There are multiple ways to resolve the issue:

- Copy VDSO as a blob in load_elf_vdso(). This would require creating
  specialized loader logic, that duplicates parts of load_elf_image().

- Fix up VDSO's PHDR size in load_elf_vdso(). This would require either
  duplicating the parsing logic, or adding an ugly parameter to
  load_elf_image().

- Fix up VDSO's PHDR size in gen-vdso. This is the simplest solution,
  so do it.

There are two tricky parts:

- Byte-swaps need to be done either on local copies, or in-place and
  then reverted in the end. To preserve the existing code structure, do
  the former for Sym and Dyn, and the latter for Ehdr, Phdr, and Shdr.

- There must be no .bss, which is already the case - but having an
  explicit check is helpful to ensure correctness.

To verify this change, I diffed the on-disk and the loaded VDSOs; the
result does not show anything unusual, except for what seems to be an
existing oversight (which should probably be fixed separately):

│  Symbol table '.dynsym' contains 8 entries:
│     Num:    Value          Size Type    Bind   Vis      Ndx Name
│ -     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
│ -     6: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.29
│ +     0: 00007f61075bf000     0 NOTYPE  LOCAL  DEFAULT  UND
│ +     6: 00007f61075bf000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.29

Fixes: 2fa536d10797 ("linux-user: Add gen-vdso tool")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241023202850.55211-1-iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/gen-vdso.c          | 40 +++++++-------
 linux-user/gen-vdso-elfn.c.inc | 98 +++++++++++++++++++++++-----------
 2 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index 31e333be80..721f38d5a3 100644
--- a/linux-user/gen-vdso.c
+++ b/linux-user/gen-vdso.c
@@ -131,23 +131,6 @@ int main(int argc, char **argv)
     }
     fclose(inf);
 
-    /*
-     * Write out the vdso image now, before we make local changes.
-     */
-
-    fprintf(outf,
-            "/* Automatically generated from linux-user/gen-vdso.c. */\n"
-            "\n"
-            "static const uint8_t %s_image[] = {",
-            prefix);
-    for (long i = 0; i < total_len; ++i) {
-        if (i % 12 == 0) {
-            fputs("\n   ", outf);
-        }
-        fprintf(outf, " 0x%02x,", buf[i]);
-    }
-    fprintf(outf, "\n};\n\n");
-
     /*
      * Identify which elf flavor we're processing.
      * The first 16 bytes of the file are e_ident.
@@ -179,14 +162,17 @@ int main(int argc, char **argv)
      * Output relocation addresses as we go.
      */
 
-    fprintf(outf, "static const unsigned %s_relocs[] = {\n", prefix);
+    fprintf(outf,
+            "/* Automatically generated by linux-user/gen-vdso.c. */\n"
+            "\n"
+            "static const unsigned %s_relocs[] = {\n", prefix);
 
     switch (buf[EI_CLASS]) {
     case ELFCLASS32:
-        elf32_process(outf, buf, need_bswap);
+        elf32_process(outf, buf, total_len, need_bswap);
         break;
     case ELFCLASS64:
-        elf64_process(outf, buf, need_bswap);
+        elf64_process(outf, buf, total_len, need_bswap);
         break;
     default:
         fprintf(stderr, "%s: invalid elf EI_CLASS (%u)\n",
@@ -196,6 +182,20 @@ int main(int argc, char **argv)
 
     fprintf(outf, "};\n\n");   /* end vdso_relocs. */
 
+    /*
+     * Write out the vdso image now, after we made local changes.
+     */
+    fprintf(outf,
+            "static const uint8_t %s_image[] = {",
+            prefix);
+    for (long i = 0; i < total_len; ++i) {
+        if (i % 12 == 0) {
+            fputs("\n   ", outf);
+        }
+        fprintf(outf, " 0x%02x,", buf[i]);
+    }
+    fprintf(outf, "\n};\n\n");
+
     fprintf(outf, "static const VdsoImageInfo %s_image_info = {\n", prefix);
     fprintf(outf, "    .image = %s_image,\n", prefix);
     fprintf(outf, "    .relocs = %s_relocs,\n", prefix);
diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
index 95856eb839..b47019e136 100644
--- a/linux-user/gen-vdso-elfn.c.inc
+++ b/linux-user/gen-vdso-elfn.c.inc
@@ -68,28 +68,45 @@ static void elfN(search_symtab)(ElfN(Shdr) *shdr, unsigned sym_idx,
                                 void *buf, bool need_bswap)
 {
     unsigned str_idx = shdr[sym_idx].sh_link;
-    ElfN(Sym) *sym = buf + shdr[sym_idx].sh_offset;
-    unsigned sym_n = shdr[sym_idx].sh_size / sizeof(*sym);
+    ElfN(Sym) *target_sym = buf + shdr[sym_idx].sh_offset;
+    unsigned sym_n = shdr[sym_idx].sh_size / sizeof(*target_sym);
     const char *str = buf + shdr[str_idx].sh_offset;
 
     for (unsigned i = 0; i < sym_n; ++i) {
         const char *name;
+        ElfN(Sym) sym;
 
+        memcpy(&sym, &target_sym[i], sizeof(sym));
         if (need_bswap) {
-            elfN(bswap_sym)(sym + i);
+            elfN(bswap_sym)(&sym);
         }
-        name = str + sym[i].st_name;
+        name = str + sym.st_name;
 
         if (sigreturn_sym && strcmp(sigreturn_sym, name) == 0) {
-            sigreturn_addr = sym[i].st_value;
+            sigreturn_addr = sym.st_value;
         }
         if (rt_sigreturn_sym && strcmp(rt_sigreturn_sym, name) == 0) {
-            rt_sigreturn_addr = sym[i].st_value;
+            rt_sigreturn_addr = sym.st_value;
         }
     }
 }
 
-static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
+static void elfN(bswap_ps_hdrs)(ElfN(Ehdr) *ehdr)
+{
+    ElfN(Phdr) *phdr = (void *)ehdr + ehdr->e_phoff;
+    ElfN(Shdr) *shdr = (void *)ehdr + ehdr->e_shoff;
+    ElfN(Half) i;
+
+    for (i = 0; i < ehdr->e_phnum; ++i) {
+        elfN(bswap_phdr)(&phdr[i]);
+    }
+
+    for (i = 0; i < ehdr->e_shnum; ++i) {
+        elfN(bswap_shdr)(&shdr[i]);
+    }
+}
+
+static void elfN(process)(FILE *outf, void *buf, long len, bool need_bswap)
 {
     ElfN(Ehdr) *ehdr = buf;
     ElfN(Phdr) *phdr;
@@ -103,24 +120,14 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
     int errors = 0;
 
     if (need_bswap) {
-        elfN(bswap_ehdr)(ehdr);
+        elfN(bswap_ehdr)(buf);
+        elfN(bswap_ps_hdrs)(buf);
     }
 
     phnum = ehdr->e_phnum;
     phdr = buf + ehdr->e_phoff;
-    if (need_bswap) {
-        for (unsigned i = 0; i < phnum; ++i) {
-            elfN(bswap_phdr)(phdr + i);
-        }
-    }
-
     shnum = ehdr->e_shnum;
     shdr = buf + ehdr->e_shoff;
-    if (need_bswap) {
-        for (unsigned i = 0; i < shnum; ++i) {
-            elfN(bswap_shdr)(shdr + i);
-        }
-    }
     for (unsigned i = 0; i < shnum; ++i) {
         switch (shdr[i].sh_type) {
         case SHT_SYMTAB:
@@ -154,7 +161,24 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
             fprintf(stderr, "LOAD segment not loaded at address 0\n");
             errors++;
         }
-        first_segsz = phdr[i].p_filesz;
+        /*
+         * Extend the program header to cover the entire VDSO, so that
+         * load_elf_vdso() loads everything, including section headers.
+         *
+         * Require that there is no .bss, since it would break this
+         * approach.
+         */
+        if (phdr[i].p_filesz != phdr[i].p_memsz) {
+            fprintf(stderr, "LOAD segment's filesz and memsz differ\n");
+            errors++;
+        }
+        if (phdr[i].p_filesz > len) {
+            fprintf(stderr, "LOAD segment is larger than the whole VDSO\n");
+            errors++;
+        }
+        phdr[i].p_filesz = len;
+        phdr[i].p_memsz = len;
+        first_segsz = len;
         if (first_segsz < ehdr->e_phoff + phnum * sizeof(*phdr)) {
             fprintf(stderr, "LOAD segment does not cover PHDRs\n");
             errors++;
@@ -197,17 +221,24 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
         output_reloc(outf, buf, &phdr[i].p_paddr);
     }
 
+    /* Relocate the section headers. */
+    for (unsigned i = 0; i < shnum; ++i) {
+        output_reloc(outf, buf, &shdr[i].sh_addr);
+    }
+
     /* Relocate the DYNAMIC entries. */
     if (dynamic_addr) {
-        ElfN(Dyn) *dyn = buf + dynamic_ofs;
-        __typeof(dyn->d_tag) tag;
+        ElfN(Dyn) *target_dyn = buf + dynamic_ofs;
+        __typeof(((ElfN(Dyn) *)target_dyn)->d_tag) tag;
 
         do {
+            ElfN(Dyn) dyn;
 
+            memcpy(&dyn, target_dyn, sizeof(dyn));
             if (need_bswap) {
-                elfN(bswap_dyn)(dyn);
+                elfN(bswap_dyn)(&dyn);
             }
-            tag = dyn->d_tag;
+            tag = dyn.d_tag;
 
             switch (tag) {
             case DT_HASH:
@@ -218,7 +249,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
             case DT_PLTGOT:
             case DT_ADDRRNGLO ... DT_ADDRRNGHI:
                 /* These entries store an address in the entry. */
-                output_reloc(outf, buf, &dyn->d_un.d_val);
+                output_reloc(outf, buf, &target_dyn->d_un.d_val);
                 break;
 
             case DT_NULL:
@@ -235,7 +266,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                 break;
 
             case DT_SYMENT:
-                if (dyn->d_un.d_val != sizeof(ElfN(Sym))) {
+                if (dyn.d_un.d_val != sizeof(ElfN(Sym))) {
                     fprintf(stderr, "VDSO has incorrect dynamic symbol size\n");
                     errors++;
                 }
@@ -251,7 +282,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                  * ??? The RISC-V toolchain will emit these even when there
                  * are no relocations.  Validate zeros.
                  */
-                if (dyn->d_un.d_val != 0) {
+                if (dyn.d_un.d_val != 0) {
                     fprintf(stderr, "VDSO has dynamic relocations\n");
                     errors++;
                 }
@@ -287,7 +318,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                 errors++;
                 break;
             }
-            dyn++;
+            target_dyn++;
         } while (tag != DT_NULL);
         if (errors) {
             exit(EXIT_FAILURE);
@@ -296,11 +327,11 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
 
     /* Relocate the dynamic symbol table. */
     if (dynsym_idx) {
-        ElfN(Sym) *sym = buf + shdr[dynsym_idx].sh_offset;
-        unsigned sym_n = shdr[dynsym_idx].sh_size / sizeof(*sym);
+        ElfN(Sym) *target_sym = buf + shdr[dynsym_idx].sh_offset;
+        unsigned sym_n = shdr[dynsym_idx].sh_size / sizeof(*target_sym);
 
         for (unsigned i = 0; i < sym_n; ++i) {
-            output_reloc(outf, buf, &sym[i].st_value);
+            output_reloc(outf, buf, &target_sym[i].st_value);
         }
     }
 
@@ -311,4 +342,9 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
     if (symtab_idx) {
         elfN(search_symtab)(shdr, symtab_idx, buf, need_bswap);
     }
+
+    if (need_bswap) {
+        elfN(bswap_ps_hdrs)(buf);
+        elfN(bswap_ehdr)(buf);
+    }
 }
-- 
2.43.0


