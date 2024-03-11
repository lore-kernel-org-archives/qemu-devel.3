Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AA3C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl9o-0006rM-AQ; Mon, 11 Mar 2024 15:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4s-0003MB-Su
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4q-0000ME-8f
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4132ab0c302so8939425e9.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184366; x=1710789166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1vz5/CWs4cBAwnzrh8kwb3AZ0Dz8ocBGmwZVUospu4A=;
 b=Y54NYpw9Nke9tCtV3IhUtSs3rdt289/9M4B7k5uAfuv4bVfIguxM+H+A7m3FV3MmkP
 P3NlTKsriXbZHgG/cpOUdrPJgyjiC5c6qjK5eRLNV3ZiGPYPhA4j30k8u1aG21E+eJV3
 KWyqDqOQ40DmPNbaYUMo2q6NC2qSExijE5i+JECanw8wn80fq63r2gAjvyAAS3j4nUgJ
 /jfaNVRsSopX3VQhP0btENEBkHJbLL9du2VrbeDM3dY8HshjdcF6DlprBz6NpHqYXPO1
 iYNhn9Mwc4Qz/TC7e++zJn/cUq8G3B91k6MldNWkw+v8uMiyWuU02zsXrRVDiu4LEYHr
 cRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184366; x=1710789166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1vz5/CWs4cBAwnzrh8kwb3AZ0Dz8ocBGmwZVUospu4A=;
 b=ruGZJ1dDUO+K7C+EOh/Abh4ltmQKoW9PR7zGpYwcAUZcbrNLqVMOkWBE7H5ZgKZwkJ
 5K2ffCH7HzpctGbnxNjmHsYzS5vgREfgtoiNWGIyuVcoSO/qFjng9fG12NhZFvlnJZ+C
 r83eO03xXwOCtWxarZp8CDmkWPlckXMtbf1rzbvR9WAn46UkIPQsj9ULj/HjfquCjkRT
 u4PU6OMAjiG6OmgfmMUijjpdhKEugYrBMKSH75/8MCATXHPpqNDrFErraPx7e2seNXA/
 Bhnu6tSrreoUjmdJBjX9EWEtmehsqJSCIJypGq9UdNqkhPwUzJ8RxiHT3GppWqVUTmiz
 8BTA==
X-Gm-Message-State: AOJu0Yy0jHxfZIRNXI/DHIofIaO1F+dVnT3AxD2N/xKHjjF2cF9NxA2O
 4pjQaaKUZA8RwdEFZiX2eRP+k5EQjQlIdQz002VmytrmWbKpCn8Q7SUQ7NVPUalwxju2HqtPwKZ
 N
X-Google-Smtp-Source: AGHT+IFOc69sHOEUDFLJVNYzVKYQdqJGkcC+aiYhgXLIMzZ+U5sV2VQucufzNk9MLbkpeUxe5Yokqw==
X-Received: by 2002:a05:600c:3f94:b0:413:2ae8:428d with SMTP id
 fs20-20020a05600c3f9400b004132ae8428dmr2489251wmb.14.1710184365578; 
 Mon, 11 Mar 2024 12:12:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/20] contrib/elf2dmp: Fix error reporting style in addrspace.c
Date: Mon, 11 Mar 2024 19:12:27 +0000
Message-Id: <20240311191241.4177990-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240307-elf2dmp-v4-5-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/addrspace.h |  4 ++--
 contrib/elf2dmp/addrspace.c |  8 +++----
 contrib/elf2dmp/main.c      | 47 +++++++++++++++++--------------------
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index c868d647387..2ad30a9da48 100644
--- a/contrib/elf2dmp/addrspace.h
+++ b/contrib/elf2dmp/addrspace.h
@@ -39,7 +39,7 @@ void pa_space_destroy(struct pa_space *ps);
 void va_space_create(struct va_space *vs, struct pa_space *ps, uint64_t dtb);
 void va_space_set_dtb(struct va_space *vs, uint64_t dtb);
 void *va_space_resolve(struct va_space *vs, uint64_t va);
-int va_space_rw(struct va_space *vs, uint64_t addr,
-        void *buf, size_t size, int is_write);
+bool va_space_rw(struct va_space *vs, uint64_t addr,
+                 void *buf, size_t size, int is_write);
 
 #endif /* ADDRSPACE_H */
diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
index 4c127c9b1ec..c995c723ae8 100644
--- a/contrib/elf2dmp/addrspace.c
+++ b/contrib/elf2dmp/addrspace.c
@@ -226,8 +226,8 @@ void *va_space_resolve(struct va_space *vs, uint64_t va)
     return pa_space_resolve(vs->ps, pa);
 }
 
-int va_space_rw(struct va_space *vs, uint64_t addr,
-        void *buf, size_t size, int is_write)
+bool va_space_rw(struct va_space *vs, uint64_t addr,
+                 void *buf, size_t size, int is_write)
 {
     while (size) {
         uint64_t page = addr & ELF2DMP_PFN_MASK;
@@ -238,7 +238,7 @@ int va_space_rw(struct va_space *vs, uint64_t addr,
 
         ptr = va_space_resolve(vs, addr);
         if (!ptr) {
-            return 1;
+            return false;
         }
 
         if (is_write) {
@@ -252,5 +252,5 @@ int va_space_rw(struct va_space *vs, uint64_t addr,
         addr += s;
     }
 
-    return 0;
+    return true;
 }
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 8a71e2efd28..09af39422f1 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -79,9 +79,9 @@ static KDDEBUGGER_DATA64 *get_kdbg(uint64_t KernBase, struct pdb_reader *pdb,
     bool decode = false;
     uint64_t kwn, kwa, KdpDataBlockEncoded;
 
-    if (va_space_rw(vs,
-                KdDebuggerDataBlock + offsetof(KDDEBUGGER_DATA64, Header),
-                &kdbg_hdr, sizeof(kdbg_hdr), 0)) {
+    if (!va_space_rw(vs,
+                     KdDebuggerDataBlock + offsetof(KDDEBUGGER_DATA64, Header),
+                     &kdbg_hdr, sizeof(kdbg_hdr), 0)) {
         eprintf("Failed to extract KDBG header\n");
         return NULL;
     }
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
@@ -286,7 +286,7 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
         return 1;
     }
 
-    if (va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
+    if (!va_space_rw(vs, KdVersionBlock, &kvb, sizeof(kvb), 0)) {
         eprintf("Failed to extract KdVersionBlock\n");
         return 1;
     }
@@ -352,8 +352,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         WinContext64 ctx;
         QEMUCPUState *s = qe->state[i];
 
-        if (va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
-                    &Prcb, sizeof(Prcb), 0)) {
+        if (!va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
+                         &Prcb, sizeof(Prcb), 0)) {
             eprintf("Failed to read CPU #%d PRCB location\n", i);
             continue;
         }
@@ -363,8 +363,8 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
             continue;
         }
 
-        if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
-                    &Context, sizeof(Context), 0)) {
+        if (!va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
+                         &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
             continue;
         }
@@ -372,7 +372,7 @@ static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         printf("Filling context for CPU #%d...\n", i);
         win_context_init_from_qemu_cpu_state(&ctx, s);
 
-        if (va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
+        if (!va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
             eprintf("Failed to fill CPU #%d context\n", i);
             continue;
         }
@@ -396,8 +396,8 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
         return 1;
     }
 
-    if (va_space_rw(vs, base + dos_hdr->e_lfanew,
-                &nt_hdrs, sizeof(nt_hdrs), 0)) {
+    if (!va_space_rw(vs, base + dos_hdr->e_lfanew,
+                     &nt_hdrs, sizeof(nt_hdrs), 0)) {
         return 1;
     }
 
@@ -406,9 +406,7 @@ static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
         return 1;
     }
 
-    if (va_space_rw(vs,
-                base + data_dir[idx].VirtualAddress,
-                entry, size, 0)) {
+    if (!va_space_rw(vs, base + data_dir[idx].VirtualAddress, entry, size, 0)) {
         return 1;
     }
 
@@ -470,9 +468,8 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
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
@@ -488,9 +485,9 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
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
@@ -556,8 +553,8 @@ int main(int argc, char *argv[])
 
     printf("CPU #0 IDT is at 0x%016"PRIx64"\n", state->idt.base);
 
-    if (va_space_rw(&vs, state->idt.base,
-                &first_idt_desc, sizeof(first_idt_desc), 0)) {
+    if (!va_space_rw(&vs, state->idt.base,
+                     &first_idt_desc, sizeof(first_idt_desc), 0)) {
         eprintf("Failed to get CPU #0 IDT[0]\n");
         goto out_ps;
     }
-- 
2.34.1


