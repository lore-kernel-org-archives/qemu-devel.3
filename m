Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA4ACF5398
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 14:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ceW-0001U5-9v; Wed, 23 Oct 2024 10:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3ceS-0001Tq-8Z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 10:47:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t3ceP-0007qv-4D
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 10:47:55 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NDtNl5004074;
 Wed, 23 Oct 2024 14:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=smZkyXuolve1W0/s2YDpqysgan9A
 ihild+i2INYNmww=; b=aBux6ih/yzCwqfT16ila8DFp21hEz0srp7e+bIYUqcY2
 scXqpYp29ofV/g+BBFoSyrnEU/L4nYbv8Pb+xL3aXuB2WgXPbPNmA5eVSbe6jeR2
 2P9OcxDNyrEOXZ+AeghAUVR4nE6nNTq8JhrZJyqL9RIPHPS785TyWOT4WEyzM8NF
 m8GpeWeyqz+ioHjRpC70pORT2S1Hvv287kpcE2bgm6GZeRvXK5577OSd6zU6jX83
 BuFrG8UnVlNohfxtM40Az+Fs0xGGUPN9KwNfVJe4rFbphIzeEWm47FyvmIZo2qfl
 I6LgIKbzmJfWWoIhtkPkochBS54lCU135ZB6fvopUg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafuhrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 14:47:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NBhEFI014557;
 Wed, 23 Oct 2024 14:47:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emk7uak6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Oct 2024 14:47:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49NEllmw27525682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 14:47:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD6E62004E;
 Wed, 23 Oct 2024 14:47:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82C7020043;
 Wed, 23 Oct 2024 14:47:47 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.38.72])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Oct 2024 14:47:47 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] linux-user: Fix GDB complaining about system-supplied DSO
 string table index
Date: Wed, 23 Oct 2024 16:46:53 +0200
Message-ID: <20241023144744.50440-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8VlX8RXCoCA2VHs5elbU6DAqE7MMCLS8
X-Proofpoint-ORIG-GUID: 8VlX8RXCoCA2VHs5elbU6DAqE7MMCLS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

There are multiple ways to resolve it:

- Copy VDSO as a blob in load_elf_vdso(). This would require creating
  specialized loader logic, that duplicates parts of load_elf_image().

- Fix up VDSO's PHDR size in load_elf_vdso(). This would require either
  duplicating the parsing logic, or adding an ugly parameter to
  load_elf_image().

- Fix up VDSO's PHDR size in gen-vdso. This is the simplest solution,
  so do it. The only tricky part is byte-swaps: they need to be either
  done on local copies or in-place, and then reverted in the end. To
  preserve the existing code structure, do the former for Sym and Dyn,
  and the latter for Ehdr, Phdr, and Shdr.

To verify this change, I diffed the on-disk and the loaded VDSO; the
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
 linux-user/gen-vdso-elfn.c.inc | 89 ++++++++++++++++++++++------------
 linux-user/gen-vdso.c          | 40 +++++++--------
 2 files changed, 79 insertions(+), 50 deletions(-)

diff --git a/linux-user/gen-vdso-elfn.c.inc b/linux-user/gen-vdso-elfn.c.inc
index 95856eb839b..82002df4fc0 100644
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
@@ -154,6 +161,16 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
             fprintf(stderr, "LOAD segment not loaded at address 0\n");
             errors++;
         }
+        /*
+         * Extend the program header to cover the entire VDSO, so that
+         * load_elf_vdso() loads everything, including section headers.
+         */
+        if (len > phdr[i].p_filesz) {
+            phdr[i].p_filesz = len;
+        }
+        if (len > phdr[i].p_memsz) {
+            phdr[i].p_memsz = len;
+        }
         first_segsz = phdr[i].p_filesz;
         if (first_segsz < ehdr->e_phoff + phnum * sizeof(*phdr)) {
             fprintf(stderr, "LOAD segment does not cover PHDRs\n");
@@ -197,17 +214,24 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
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
@@ -218,7 +242,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
             case DT_PLTGOT:
             case DT_ADDRRNGLO ... DT_ADDRRNGHI:
                 /* These entries store an address in the entry. */
-                output_reloc(outf, buf, &dyn->d_un.d_val);
+                output_reloc(outf, buf, &target_dyn->d_un.d_val);
                 break;
 
             case DT_NULL:
@@ -235,7 +259,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                 break;
 
             case DT_SYMENT:
-                if (dyn->d_un.d_val != sizeof(ElfN(Sym))) {
+                if (dyn.d_un.d_val != sizeof(ElfN(Sym))) {
                     fprintf(stderr, "VDSO has incorrect dynamic symbol size\n");
                     errors++;
                 }
@@ -251,7 +275,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                  * ??? The RISC-V toolchain will emit these even when there
                  * are no relocations.  Validate zeros.
                  */
-                if (dyn->d_un.d_val != 0) {
+                if (dyn.d_un.d_val != 0) {
                     fprintf(stderr, "VDSO has dynamic relocations\n");
                     errors++;
                 }
@@ -287,7 +311,7 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
                 errors++;
                 break;
             }
-            dyn++;
+            target_dyn++;
         } while (tag != DT_NULL);
         if (errors) {
             exit(EXIT_FAILURE);
@@ -296,11 +320,11 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
 
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
 
@@ -311,4 +335,9 @@ static void elfN(process)(FILE *outf, void *buf, bool need_bswap)
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


