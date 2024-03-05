Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50B2C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPM9-0006AF-0R; Tue, 05 Mar 2024 02:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLx-00068C-2i
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:48 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLu-0005rG-7w
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:44 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dd01ea35b5so14370355ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624201; x=1710229001;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dwGsXBpC+XXtpI/9XX8zmAjUVw+s9LJdBLuOAnq82co=;
 b=WSZV5j4qRP/IwelPqr9yjfuZ46YnqIIwr9FFUV9PVfgMuyqJmec1WUURUMQonFtE7P
 BxqQTHvuMp5VZH75cHX6ZitPx9nzT76/t/NjbXcasj1xJVEF4sW05Z7jeSytlw1gT4ft
 790yajdd+dbDgcsj9mzDzi7aCpPrAwU8MWVxR1G+MR7G95+g8IumYtpsoApxAYyNXI77
 xvPHAhJ/t30wUEKFGHkb9y+UwYqWKa5StcuMd+mCfUFuig7bVhJEhYtN2VgosvDvjM5Y
 tfuuzt6zVmnljZ2A444C81iAV6YdQDVqXSC8OeZL5/wTV7AuCkpzHlU5QPEQoC7mOz+M
 anlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624201; x=1710229001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwGsXBpC+XXtpI/9XX8zmAjUVw+s9LJdBLuOAnq82co=;
 b=eyOWhCFP+MFRQO7uPIzWgZsZ2b58TRWC6ELlBWJO21KeL+E32bSh1Y/NgUw6yyP4dh
 158Rl1c47nqnVAA2PQ01tfdEPW5qKiL183a17tYwkAbBp+ezvduEdbQdEm3jv1SAMErU
 EHMIwAc5Ztw2yviylf7vIPMXELovB1P0GtqCivS6iODYliJH3+i/7BlmjyVzK5qXln6S
 YqvHlI5zjSFoHSAsHTwLDxKXyYA/IHAYLbC04AaZPGb8oKg4MCj3XDO6TpZGAQHKJgBc
 hDtm8QYw39b81BSRNVCLvSKs7hkaHYS+0fqWttQuzl4kxGDVbAw55AIEN7Ssj1YlCmSc
 2AhA==
X-Gm-Message-State: AOJu0YyKecfZHO2GKHbxcOrBe86GcuwdcNtFLYncqLCHfnn9/WnRVxRI
 97SoYNTrtKZo/dOCMiSB4Rr0cyfyGR089mnb99gOP9FfhnucptPidnasu6bpGmOY+T21GD7PRMB
 N
X-Google-Smtp-Source: AGHT+IEifg8ly89hMFsPnJb1JPFtVToCwCvHBbYZn0pOC0mCxTUDHx2EZzCvXO3lBupd0Znq13XLbA==
X-Received: by 2002:a17:902:d503:b0:1dc:696d:ec6e with SMTP id
 b3-20020a170902d50300b001dc696dec6emr1021143plg.21.1709624200647; 
 Mon, 04 Mar 2024 23:36:40 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 b8-20020a170903228800b001db81640315sm9762433plh.91.2024.03.04.23.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:21 +0900
Subject: [PATCH v2 04/13] contrib/elf2dmp: Conform to the error reporting
 pattern
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-4-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/addrspace.h |   6 +--
 contrib/elf2dmp/download.h  |   2 +-
 contrib/elf2dmp/pdb.h       |   2 +-
 contrib/elf2dmp/qemu_elf.h  |   2 +-
 contrib/elf2dmp/addrspace.c |  12 ++---
 contrib/elf2dmp/download.c  |  10 ++--
 contrib/elf2dmp/main.c      | 114 +++++++++++++++++++++-----------------------
 contrib/elf2dmp/pdb.c       |  50 +++++++++----------
 contrib/elf2dmp/qemu_elf.c  |  32 ++++++-------
 9 files changed, 112 insertions(+), 118 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index 039c70c5b079..2ad30a9da48a 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -33,13 +33,13 @@ struct va_space {
     struct pa_space *ps;
 };
 
-int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf);
+void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf);
 void pa_space_destroy(struct pa_space *ps);
 
 void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb);
 void va_space_set_dtb(struct va_space *vs, uint64_t dtb);
 void *va_space_resolve(struct va_space *vs, uint64_t va);
-int va_space_rw(struct va_space *vs, uint64_t addr,
-        void *buf, size_t size, int is_write);
+bool va_space_rw(struct va_space *vs, uint64_t addr,
+                 void *buf, size_t size, int is_write);
 
 #endif /* ADDRSPACE_H */
diff --git a/contrib/elf2dmp/download.h b/contrib/elf2dmp/download.h
index 5c274925f7aa..f65adb5d0894 100644
--- a/contrib/elf2dmp/download.h
+++ b/contrib/elf2dmp/download.h
@@ -8,6 +8,6 @@
 #ifndef DOWNLOAD_H
 #define DOWNLOAD_H
 
-int download_url(const char *name, const char *url);
+bool download_url(const char *name, const char *url);
 
 #endif /* DOWNLOAD_H */
diff --git a/contrib/elf2dmp/pdb.h b/contrib/elf2dmp/pdb.h
index 2a50da56ac96..feddf1862f08 100644
--- a/contrib/elf2dmp/pdb.h
+++ b/contrib/elf2dmp/pdb.h
@@ -233,7 +233,7 @@ struct pdb_reader {
     size_t segs_size;
 };
 
-int pdb_init_from_file(const char *name, struct pdb_reader *reader);
+bool pdb_init_from_file(const char *name, struct pdb_reader *reader);
 void pdb_exit(struct pdb_reader *reader);
 uint64_t pdb_resolve(uint64_t img_base, struct pdb_reader *r, const char *name);
 uint64_t pdb_find_public_v3_symbol(struct pdb_reader *reader, const char *name);
diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index afa75f10b2d2..adc50238b46b 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -42,7 +42,7 @@ typedef struct QEMU_Elf {
     int has_kernel_gs_base;
 } QEMU_Elf;
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
+bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename);
 void QEMU_Elf_exit(QEMU_Elf *qe);
 
 Elf64_Phdr *elf64_getphdr(void *map);
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 6f608a517b1e..c995c723ae80 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -57,7 +57,7 @@ static void pa_block_align(struct pa_block *b)
     b->paddr += low_align;
 }
 
-int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
+void pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
 {
     Elf64_Half phdr_nr = elf_getphdrnum(qemu_elf->map);
     Elf64_Phdr *phdr = elf64_getphdr(qemu_elf->map);
@@ -87,8 +87,6 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
     }
 
     ps->block_nr = block_i;
-
-    return 0;
 }
 
 void pa_space_destroy(struct pa_space *ps)
@@ -228,8 +226,8 @@ void *va_space_resolve(struct va_space *vs, uint64_t va)
     return pa_space_resolve(vs->ps, pa);
 }
 
-int va_space_rw(struct va_space *vs, uint64_t addr,
-        void *buf, size_t size, int is_write)
+bool va_space_rw(struct va_space *vs, uint64_t addr,
+                 void *buf, size_t size, int is_write)
 {
     while (size) {
         uint64_t page = addr & ELF2DMP_PFN_MASK;
@@ -240,7 +238,7 @@ int va_space_rw(struct va_space *vs, uint64_t addr,
 
         ptr = va_space_resolve(vs, addr);
         if (!ptr) {
-            return 1;
+            return false;
         }
 
         if (is_write) {
@@ -254,5 +252,5 @@ int va_space_rw(struct va_space *vs, uint64_t addr,
         addr += s;
     }
 
-    return 0;
+    return true;
 }
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index 902dc04ffa5c..ec8d33ba1e4b 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -9,14 +9,14 @@
 #include <curl/curl.h>
 #include "download.h"
 
-int download_url(const char *name, const char *url)
+bool download_url(const char *name, const char *url)
 {
-    int err = 1;
+    bool success = false;
     FILE *file;
     CURL *curl = curl_easy_init();
 
     if (!curl) {
-        return 1;
+        return success;
     }
 
     file = fopen(name, "wb");
@@ -33,11 +33,11 @@ int download_url(const char *name, const char *url)
         unlink(name);
         fclose(file);
     } else {
-        err = fclose(file);
+        success = !fclose(file);
     }
 
 out_curl:
     curl_easy_cleanup(curl);
 
-    return err;
+    return success;
 }
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 89bf4e23566b..140ac6e00cfe 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -79,7 +79,7 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
     bool decode = false;
     uint64_t kwn, kwa, KdpDataBlockEncoded;
 
-    if (va_space_rw(vs,
+    if (!va_space_rw(vs,
                 KdDebuggerDataBlock + offsetof(KDDEBUGGER_DATA64, Header),
                 &kdbg_hdr, sizeof(kdbg_hdr), 0)) {
         eprintf("Failed to extract KDBG header\n");
@@ -97,8 +97,8 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
             return NULL;
         }
 
-        if (va_space_rw(vs, KiWaitNever, &kwn, sizeof(kwn), 0) ||
-                va_space_rw(vs, KiWaitAlways, &kwa, sizeof(kwa), 0)) {
+        if (!va_space_rw(vs, KiWaitNever, &kwn, sizeof(kwn), 0) ||
+            !va_space_rw(vs, KiWaitAlways, &kwa, sizeof(kwa), 0)) {
             return NULL;
         }
 
@@ -122,7 +122,7 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
 
     kdbg = g_malloc(kdbg_hdr.Size);
 
-    if (va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
+    if (!va_space_rw(vs, KdDebuggerDataBlock, kdbg, kdbg_hdr.Size, 0)) {
         eprintf("Failed to extract entire KDBG\n");
         g_free(kdbg);
         return NULL;
@@ -186,13 +186,13 @@ static void win_context_init_from_qemu_cpu_state(WinContext64 *ctx,
  * Finds paging-structure hierarchy base,
  * if previously set doesn't give access to kernel structures
  */
-static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
+static bool fix_dtb(struct va_space *vs, QEMU_Elf *qe)
 {
     /*
      * Firstly, test previously set DTB.
      */
     if (va_space_resolve(vs, SharedUserData)) {
-        return 0;
+        return true;
     }
 
     /*
@@ -206,7 +206,7 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
             va_space_set_dtb(vs, s->cr[3]);
             printf("DTB 0x%016"PRIx64" has been found from CPU #%zu"
                     " as system task CR3\n", vs->dtb, i);
-            return !(va_space_resolve(vs, SharedUserData));
+            return !!(va_space_resolve(vs, SharedUserData));
         }
     }
 
@@ -226,10 +226,10 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
         va_space_set_dtb(vs, *cr3);
         printf("DirectoryTableBase = 0x%016"PRIx64" has been found from CPU #0"
                 " as interrupt handling CR3\n", vs->dtb);
-        return !(va_space_resolve(vs, SharedUserData));
+        return !!(va_space_resolve(vs, SharedUserData));
     }
 
-    return 1;
+    return false;
 }
 
 static void try_merge_runs(struct pa_space *ps,
@@ -268,9 +268,10 @@ static void try_merge_runs(struct pa_space *ps,
     }
 }
 
-static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
-        struct va_space *vs, uint64_t KdDebuggerDataBlock,
-        KDDEBUGGER_DATA64 *kdbg, uint64_t KdVersionBlock, int nr_cpus)
+static bool fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
+                        struct va_space *vs, uint64_t KdDebuggerDataBlock,
+                        KDDEBUGGER_DATA64 *kdbg, uint64_t KdVersionBlock,
+                        int nr_cpus)
 {
     uint32_t *suite_mask = va_space_resolve(vs, SharedUserData +
             KUSD_OFFSET_SUITE_MASK);
@@ -283,12 +284,12 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
     QEMU_BUILD_BUG_ON(KUSD_OFFSET_PRODUCT_TYPE >= ELF2DMP_PAGE_SIZE);
 
     if (!suite_mask || !product_type) {
-        return 1;
+        return false;
     }
 
-    if (va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
+    if (!va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
         eprintf("Failed to extract KdVersionBlock\n");
-        return 1;
+        return false;
     }
 
     h = (WinDumpHeader64) {
@@ -333,7 +334,7 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
 
     *hdr = h;
 
-    return 0;
+    return true;
 }
 
 /*
@@ -352,8 +353,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         WinContext64 ctx;
         QEMUCPUState *s = qe->state[i];
 
-        if (va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
-                    &Prcb, sizeof(Prcb), 0)) {
+        if (!va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
+                         &Prcb, sizeof(Prcb), 0)) {
             eprintf("Failed to read CPU #%d PRCB location\n", i);
             continue;
         }
@@ -363,8 +364,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
             continue;
         }
 
-        if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
-                    &Context, sizeof(Context), 0)) {
+        if (!va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
+                         &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
             continue;
         }
@@ -372,15 +373,15 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         printf("Filling context for CPU #%d...\n", i);
         win_context_init_from_qemu_cpu_state(&ctx, s);
 
-        if (va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
+        if (!va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
             eprintf("Failed to fill CPU #%d context\n", i);
             continue;
         }
     }
 }
 
-static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
-        void *entry, size_t size, struct va_space *vs)
+static bool pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
+                                  void *entry, size_t size, struct va_space *vs)
 {
     const char e_magic[2] = "MZ";
     const char Signature[4] = "PE\0\0";
@@ -393,40 +394,39 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
     QEMU_BUILD_BUG_ON(sizeof(*dos_hdr) >= ELF2DMP_PAGE_SIZE);
 
     if (memcmp(&dos_hdr->e_magic, e_magic, sizeof(e_magic))) {
-        return 1;
+        return false;
     }
 
-    if (va_space_rw(vs, base + dos_hdr->e_lfanew,
-                &nt_hdrs, sizeof(nt_hdrs), 0)) {
-        return 1;
+    if (!va_space_rw(vs, base + dos_hdr->e_lfanew,
+                     &nt_hdrs, sizeof(nt_hdrs), 0)) {
+        return false;
     }
 
     if (memcmp(&nt_hdrs.Signature, Signature, sizeof(Signature)) ||
             file_hdr->Machine != 0x8664 || opt_hdr->Magic != 0x020b) {
-        return 1;
+        return false;
     }
 
-    if (va_space_rw(vs,
-                base + data_dir[idx].VirtualAddress,
-                entry, size, 0)) {
-        return 1;
+    if (!va_space_rw(vs, base + data_dir[idx].VirtualAddress,
+                     entry, size, 0)) {
+        return false;
     }
 
     printf("Data directory entry #%d: RVA = 0x%08"PRIx32"\n", idx,
             (uint32_t)data_dir[idx].VirtualAddress);
 
-    return 0;
+    return true;
 }
 
-static int write_dump(struct pa_space *ps,
-        WinDumpHeader64 *hdr, const char *name)
+static bool write_dump(struct pa_space *ps,
+                       WinDumpHeader64 *hdr, const char *name)
 {
     FILE *dmp_file = fopen(name, "wb");
     size_t i;
 
     if (!dmp_file) {
         eprintf("Failed to open output file \'%s\'\n", name);
-        return 1;
+        return false;
     }
 
     printf("Writing header to file...\n");
@@ -434,7 +434,7 @@ static int write_dump(struct pa_space *ps,
     if (fwrite(hdr, sizeof(*hdr), 1, dmp_file) != 1) {
         eprintf("Failed to write dump header\n");
         fclose(dmp_file);
-        return 1;
+        return false;
     }
 
     for (i = 0; i < ps->block_nr; i++) {
@@ -445,11 +445,11 @@ static int write_dump(struct pa_space *ps,
         if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
             eprintf("Failed to write block\n");
             fclose(dmp_file);
-            return 1;
+            return false;
         }
     }
 
-    return fclose(dmp_file);
+    return !fclose(dmp_file);
 }
 
 static bool pe_check_pdb_name(uint64_t base, void *start_addr,
@@ -459,8 +459,8 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     IMAGE_DEBUG_DIRECTORY debug_dir;
     char pdb_name[sizeof(PDB_NAME)];
 
-    if (pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
-                &debug_dir, sizeof(debug_dir), vs)) {
+    if (!pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
+                               &debug_dir, sizeof(debug_dir), vs)) {
         eprintf("Failed to get Debug Directory\n");
         return false;
     }
@@ -470,9 +470,8 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
         return false;
     }
 
-    if (va_space_rw(vs,
-                base + debug_dir.AddressOfRawData,
-                rsds, sizeof(*rsds), 0)) {
+    if (!va_space_rw(vs, base + debug_dir.AddressOfRawData,
+                     rsds, sizeof(*rsds), 0)) {
         eprintf("Failed to resolve OMFSignatureRSDS\n");
         return false;
     }
@@ -488,9 +487,9 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
         return false;
     }
 
-    if (va_space_rw(vs, base + debug_dir.AddressOfRawData +
-                offsetof(OMFSignatureRSDS, name), pdb_name, sizeof(PDB_NAME),
-                0)) {
+    if (!va_space_rw(vs, base + debug_dir.AddressOfRawData +
+                     offsetof(OMFSignatureRSDS, name),
+                     pdb_name, sizeof(PDB_NAME), 0)) {
         eprintf("Failed to resolve PDB name\n");
         return false;
     }
@@ -538,28 +537,25 @@ int main(int argc, char *argv[])
         return 1;
     }
 
-    if (QEMU_Elf_init(&qemu_elf, argv[1])) {
+    if (!QEMU_Elf_init(&qemu_elf, argv[1])) {
         eprintf("Failed to initialize QEMU ELF dump\n");
         return 1;
     }
 
-    if (pa_space_create(&ps, &qemu_elf)) {
-        eprintf("Failed to initialize physical address space\n");
-        goto out_elf;
-    }
+    pa_space_create(&ps, &qemu_elf);
 
     state = qemu_elf.state[0];
     printf("CPU #0 CR3 is 0x%016"PRIx64"\n", state->cr[3]);
 
     va_space_create(&vs, &ps, state->cr[3]);
-    if (fix_dtb(&vs, &qemu_elf)) {
+    if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
         goto out_elf;
     }
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
 
-    if (va_space_rw(&vs, state->idt.base,
+    if (!va_space_rw(&vs, state->idt.base,
                 &first_idt_desc, sizeof(first_idt_desc), 0)) {
         eprintf("Failed to get CPU #0 IDT[0]\n");
         goto out_ps;
@@ -597,12 +593,12 @@ int main(int argc, char *argv[])
     sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
     printf("PDB URL is %s\n", pdb_url);
 
-    if (download_url(PDB_NAME, pdb_url)) {
+    if (!download_url(PDB_NAME, pdb_url)) {
         eprintf("Failed to download PDB file\n");
         goto out_ps;
     }
 
-    if (pdb_init_from_file(PDB_NAME, &pdb)) {
+    if (!pdb_init_from_file(PDB_NAME, &pdb)) {
         eprintf("Failed to initialize PDB reader\n");
         goto out_pdb_file;
     }
@@ -617,14 +613,14 @@ int main(int argc, char *argv[])
         goto out_pdb;
     }
 
-    if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
-            KdVersionBlock, qemu_elf.state_nr)) {
+    if (!fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
+                     KdVersionBlock, qemu_elf.state_nr)) {
         goto out_kdbg;
     }
 
     fill_context(kdbg, &vs, &qemu_elf);
 
-    if (write_dump(&ps, &header, argv[2])) {
+    if (!write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");
         goto out_kdbg;
     }
diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index abf17c2e7c12..1c5051425185 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -158,30 +158,30 @@ static void *pdb_ds_read_file(struct pdb_reader* r, uint32_t file_number)
     return pdb_ds_read(r->ds.header, block_list, file_size[file_number]);
 }
 
-static int pdb_init_segments(struct pdb_reader *r)
+static bool pdb_init_segments(struct pdb_reader *r)
 {
     unsigned stream_idx = r->segments;
 
     r->segs = pdb_ds_read_file(r, stream_idx);
     if (!r->segs) {
-        return 1;
+        return false;
     }
 
     r->segs_size = pdb_get_file_size(r, stream_idx);
     if (!r->segs_size) {
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int pdb_init_symbols(struct pdb_reader *r)
+static bool pdb_init_symbols(struct pdb_reader *r)
 {
     PDB_SYMBOLS *symbols;
 
     symbols = pdb_ds_read_file(r, 3);
     if (!symbols) {
-        return 1;
+        return false;
     }
 
     r->symbols = symbols;
@@ -198,18 +198,18 @@ static int pdb_init_symbols(struct pdb_reader *r)
         goto out_symbols;
     }
 
-    return 0;
+    return true;
 
 out_symbols:
     g_free(symbols);
 
-    return 1;
+    return false;
 }
 
-static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
+static bool pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
 {
     if (hdr->block_size == 0) {
-        return 1;
+        return false;
     }
 
     memset(r->file_used, 0, sizeof(r->file_used));
@@ -218,22 +218,22 @@ static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
                 hdr->toc_page * hdr->block_size), hdr->toc_size);
 
     if (!r->ds.toc) {
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
-static int pdb_reader_init(struct pdb_reader *r, void *data)
+static bool pdb_reader_init(struct pdb_reader *r, void *data)
 {
     const char pdb7[] = "Microsoft C/C++ MSF 7.00";
 
     if (memcmp(data, pdb7, sizeof(pdb7) - 1)) {
-        return 1;
+        return false;
     }
 
-    if (pdb_reader_ds_init(r, data)) {
-        return 1;
+    if (!pdb_reader_ds_init(r, data)) {
+        return false;
     }
 
     r->ds.root = pdb_ds_read_file(r, 1);
@@ -241,15 +241,15 @@ static int pdb_reader_init(struct pdb_reader *r, void *data)
         goto out_ds;
     }
 
-    if (pdb_init_symbols(r)) {
+    if (!pdb_init_symbols(r)) {
         goto out_root;
     }
 
-    if (pdb_init_segments(r)) {
+    if (!pdb_init_segments(r)) {
         goto out_sym;
     }
 
-    return 0;
+    return true;
 
 out_sym:
     pdb_exit_symbols(r);
@@ -258,7 +258,7 @@ out_root:
 out_ds:
     pdb_reader_ds_exit(r);
 
-    return 1;
+    return false;
 }
 
 static void pdb_reader_exit(struct pdb_reader *r)
@@ -269,7 +269,7 @@ static void pdb_reader_exit(struct pdb_reader *r)
     pdb_reader_ds_exit(r);
 }
 
-int pdb_init_from_file(const char *name, struct pdb_reader *reader)
+bool pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
     GError *gerr = NULL;
     void *map;
@@ -278,21 +278,21 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     if (gerr) {
         eprintf("Failed to map PDB file \'%s\'\n", name);
         g_error_free(gerr);
-        return 1;
+        return false;
     }
 
     reader->file_size = g_mapped_file_get_length(reader->gmf);
     map = g_mapped_file_get_contents(reader->gmf);
-    if (pdb_reader_init(reader, map)) {
+    if (!pdb_reader_init(reader, map)) {
         goto out_unmap;
     }
 
-    return 0;
+    return true;
 
 out_unmap:
     g_mapped_file_unref(reader->gmf);
 
-    return 1;
+    return false;
 }
 
 void pdb_exit(struct pdb_reader *reader)
diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
index 055e6f8792e9..a22c057d3ec3 100644
--- a/contrib/elf2dmp/qemu_elf.c
+++ b/contrib/elf2dmp/qemu_elf.c
@@ -60,7 +60,7 @@ Elf64_Half elf_getphdrnum(void *map)
     return ehdr->e_phnum;
 }
 
-static int init_states(QEMU_Elf *qe)
+static bool init_states(QEMU_Elf *qe)
 {
     Elf64_Phdr *phdr = elf64_getphdr(qe->map);
     Elf64_Nhdr *start = (void *)((uint8_t *)qe->map + phdr[0].p_offset);
@@ -70,7 +70,7 @@ static int init_states(QEMU_Elf *qe)
 
     if (phdr[0].p_type != PT_NOTE) {
         eprintf("Failed to find PT_NOTE\n");
-        return 1;
+        return false;
     }
 
     qe->has_kernel_gs_base = 1;
@@ -107,7 +107,7 @@ static int init_states(QEMU_Elf *qe)
 
     qe->state_nr = cpu_nr;
 
-    return 0;
+    return true;
 }
 
 static void exit_states(QEMU_Elf *qe)
@@ -162,7 +162,7 @@ static bool check_ehdr(QEMU_Elf *qe)
     return true;
 }
 
-static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
+static bool QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
 {
 #ifdef CONFIG_LINUX
     struct stat st;
@@ -173,13 +173,13 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     fd = open(filename, O_RDONLY, 0);
     if (fd == -1) {
         eprintf("Failed to open ELF dump file \'%s\'\n", filename);
-        return 1;
+        return false;
     }
 
     if (fstat(fd, &st)) {
         eprintf("Failed to get size of ELF dump file\n");
         close(fd);
-        return 1;
+        return false;
     }
     qe->size = st.st_size;
 
@@ -188,7 +188,7 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     if (qe->map == MAP_FAILED) {
         eprintf("Failed to map ELF file\n");
         close(fd);
-        return 1;
+        return false;
     }
 
     close(fd);
@@ -201,14 +201,14 @@ static int QEMU_Elf_map(QEMU_Elf *qe, const char *filename)
     if (gerr) {
         eprintf("Failed to map ELF dump file \'%s\'\n", filename);
         g_error_free(gerr);
-        return 1;
+        return false;
     }
 
     qe->map = g_mapped_file_get_contents(qe->gmf);
     qe->size = g_mapped_file_get_length(qe->gmf);
 #endif
 
-    return 0;
+    return true;
 }
 
 static void QEMU_Elf_unmap(QEMU_Elf *qe)
@@ -220,25 +220,25 @@ static void QEMU_Elf_unmap(QEMU_Elf *qe)
 #endif
 }
 
-int QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
+bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename)
 {
-    if (QEMU_Elf_map(qe, filename)) {
-        return 1;
+    if (!QEMU_Elf_map(qe, filename)) {
+        return false;
     }
 
     if (!check_ehdr(qe)) {
         eprintf("Input file has the wrong format\n");
         QEMU_Elf_unmap(qe);
-        return 1;
+        return false;
     }
 
-    if (init_states(qe)) {
+    if (!init_states(qe)) {
         eprintf("Failed to extract QEMU CPU states\n");
         QEMU_Elf_unmap(qe);
-        return 1;
+        return false;
     }
 
-    return 0;
+    return true;
 }
 
 void QEMU_Elf_exit(QEMU_Elf *qe)

-- 
2.44.0


