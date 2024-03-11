Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA0CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl6k-0004jS-Ts; Mon, 11 Mar 2024 15:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4y-0003OU-6K
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:13:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0000Mh-AE
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:55 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4132fc7dea7so4379085e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184367; x=1710789167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yBgzhXasfX7o3A8onUx+4Fu5/1iVNFXdpdqXuKLdnRM=;
 b=e6WxWNCbNLK1jix6sLXRHhLwWvaBTyHTvaYf9Vx37SMiQJoouy/8gVpLC4Pu/Jh8Xa
 KEX1cilBGtw9TG6VW65h8JfecpIyNbC3/4/FsdyCfFDxgw/Ti8QjyzRABxze5wvHvgG4
 3kOPC+Poh0ZHcOmEG+gYFH+3m7QjTapF6LYQf09e/4ib9C31EJPRk4Q27G/KLKrJ8nKn
 +WDLps1Aa8OItdc8iQ/ru0bh9iQ2k42gDJWdrKGIgEXGhk53TqUPgCbO9U0PUf+H04AD
 DH1XW7VlfCPN8LLrtqf5S2bGdjsFx39b85BEfCoGR4mnaZCGXwMNiXIyi3VAJRXPsW8S
 vqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184367; x=1710789167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBgzhXasfX7o3A8onUx+4Fu5/1iVNFXdpdqXuKLdnRM=;
 b=X7q8bkonpR3c3H1G9OdTSQedvx43xDebtU+hTvp8NxKY2gKsriHKKFR+jOgpK3Tf22
 KmtuuVTxWzz0EGjrQJUQ3L4y8ObxGjQW08xuOzFCge/pwTylIn35DqctenLaG57jsV5O
 wESX0/Kx5Ev86F69/1+DEyh8It1LXsoPiI3ic32evoyvYjAtES1nOBOd7OG8WAvqy+Jh
 5JhK2RtCwlUf+Uox67JtW9z8yoUHcajLtR8eHNaPq3Zd0a66QyH0yheNrPAxfcTu7y4b
 T715eoyrgzzbgkc9ZstoXHk1GCY99dq4AzvJeg/ym9lTDfNQ3D0C1WTp05ifgOh8TBA6
 c6Aw==
X-Gm-Message-State: AOJu0YzpxhnXEsp/Penlmnm5BVlOv8YlFeU8MAajlvPwrvtx+cX1Lj52
 uL0syaiFP8d3bOW0XNsjSdtyeKCExQLgLWHBZH1wlPxA0ARqkb2KSu09V6iSDdIskbmawmCyclm
 e
X-Google-Smtp-Source: AGHT+IHvDfS9HqHHP9Zd+pVc+frB2xWO3K9rssSWyDCIlCIEo4HuFYcC8l4EBNhaPJYEhFUBhW82sg==
X-Received: by 2002:a05:600c:5109:b0:413:2925:ffa0 with SMTP id
 o9-20020a05600c510900b004132925ffa0mr3183632wms.18.1710184367619; 
 Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/20] contrib/elf2dmp: Fix error reporting style in main.c
Date: Mon, 11 Mar 2024 19:12:31 +0000
Message-Id: <20240311191241.4177990-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

include/qapi/error.h says:
> We recommend
> * bool-valued functions return true on success / false on failure,
> ...

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240307-elf2dmp-v4-9-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 63 +++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index cb28971789e..9347b0cd5a2 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
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
+            return va_space_resolve(vs, SharedUserData);
         }
     }
 
@@ -220,16 +220,16 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
         uint64_t *cr3 = va_space_resolve(vs, Prcb + 0x7000);
 
         if (!cr3) {
-            return 1;
+            return false;
         }
 
         va_space_set_dtb(vs, *cr3);
         printf("DirectoryTableBase = 0x%016"PRIx64" has been found from CPU #0"
                 " as interrupt handling CR3\n", vs->dtb);
-        return !(va_space_resolve(vs, SharedUserData));
+        return va_space_resolve(vs, SharedUserData);
     }
 
-    return 1;
+    return true;
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
 
     if (!va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
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
@@ -379,8 +380,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
     }
 }
 
-static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
-        void *entry, size_t size, struct va_space *vs)
+static bool pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
+                                  void *entry, size_t size, struct va_space *vs)
 {
     const char e_magic[2] = "MZ";
     const char Signature[4] = "PE\0\0";
@@ -393,38 +394,38 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
     QEMU_BUILD_BUG_ON(sizeof(*dos_hdr) >= ELF2DMP_PAGE_SIZE);
 
     if (memcmp(&dos_hdr->e_magic, e_magic, sizeof(e_magic))) {
-        return 1;
+        return false;
     }
 
     if (!va_space_rw(vs, base + dos_hdr->e_lfanew,
                      &nt_hdrs, sizeof(nt_hdrs), 0)) {
-        return 1;
+        return false;
     }
 
     if (memcmp(&nt_hdrs.Signature, Signature, sizeof(Signature)) ||
             file_hdr->Machine != 0x8664 || opt_hdr->Magic != 0x020b) {
-        return 1;
+        return false;
     }
 
     if (!va_space_rw(vs, base + data_dir[idx].VirtualAddress, entry, size, 0)) {
-        return 1;
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
@@ -432,7 +433,7 @@ static int write_dump(struct pa_space *ps,
     if (fwrite(hdr, sizeof(*hdr), 1, dmp_file) != 1) {
         eprintf("Failed to write dump header\n");
         fclose(dmp_file);
-        return 1;
+        return false;
     }
 
     for (i = 0; i < ps->block_nr; i++) {
@@ -443,11 +444,11 @@ static int write_dump(struct pa_space *ps,
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
@@ -457,8 +458,8 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     IMAGE_DEBUG_DIRECTORY debug_dir;
     char pdb_name[sizeof(PDB_NAME)];
 
-    if (pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
-                &debug_dir, sizeof(debug_dir), vs)) {
+    if (!pe_get_data_dir_entry(base, start_addr, IMAGE_FILE_DEBUG_DIRECTORY,
+                               &debug_dir, sizeof(debug_dir), vs)) {
         eprintf("Failed to get Debug Directory\n");
         return false;
     }
@@ -546,7 +547,7 @@ int main(int argc, char *argv[])
     printf("CPU #0 CR3 is 0x%016"PRIx64"\n", state->cr[3]);
 
     va_space_create(&vs, &ps, state->cr[3]);
-    if (fix_dtb(&vs, &qemu_elf)) {
+    if (!fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
         goto out_elf;
     }
@@ -611,14 +612,14 @@ int main(int argc, char *argv[])
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
-- 
2.34.1


