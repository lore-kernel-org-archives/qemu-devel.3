Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F1CFA466
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hye-0006Tt-17; Wed, 23 Oct 2024 16:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3hyb-0006TU-6l
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3hyY-0000NQ-Fr
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NEH55w027103;
 Wed, 23 Oct 2024 20:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=cVBm4dz0ihnoEpotybWF+C7QrPTd
 r8qrDltWxLke4vA=; b=l5YY6dAIRO3AzeKvrHjerRC+8HpNppsNMfSTBAKRq55T
 of6FzTZpL6nswlPAKkr1swjg7uouHjgYBFZiYJyRH4NRgfVt4FzshDgkBkiGOX18
 Z6S0G/lEReF6k7+e3HqliKs+c/AyrO+WCaS/qrwxjWEhXq782jyP/H6/A4wN14iE
 YObZTxcQ+1wdmgQORRHfe+aOs+D4eJh+0Rr1QDmv5cat7bMB2l+TP7iok5qEUOOj
 epnJy6zjrggbV4Amgagr3pgKAtgGmn//NYrHO5Zk+OlXOVcggcYGOSnIEU9A99Wx
 6BHEOHU43MaR/Fa4pQa8hQnT15aW7RXU/BLQ4OBkWA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafn21e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 20:28:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NIaxZF012606;
 Wed, 23 Oct 2024 20:28:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfcuke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 20:28:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49NKStwR52560336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:28:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D59F020049;
 Wed, 23 Oct 2024 20:28:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FECA20040;
 Wed, 23 Oct 2024 20:28:55 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.25.135])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 20:28:55 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] linux-user: Fix GDB complaining about system-supplied DSO
 string table index
Date: Wed, 23 Oct 2024 22:27:41 +0200
Message-ID: <20241023202850.55211-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qWaAL_320ACJq2TdMcHL3f6evpJFLp5G
X-Proofpoint-GUID: qWaAL_320ACJq2TdMcHL3f6evpJFLp5G
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230130
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---

v1: https://lore.kernel.org/qemu-devel/20241023144744.50440-1-iii@linux.ibm.com/
v1 -> v2: Check that there is no bss, mention linker scripts in the
          commit message (Richard).

 linux-user/gen-vdso-elfn.c.inc | 98 +++++++++++++++++++++++-----------
 linux-user/gen-vdso.c          | 40 +++++++-------
 2 files changed, 87 insertions(+), 51 deletions(-)

diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
index 95856eb839b..b47019e136c 100644
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
diff --git a/linux-user/gen-vdso.c b/linux-user/gen-vdso.c
index 31e333be802..721f38d5a3b 100644
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
-- 
2.47.0


