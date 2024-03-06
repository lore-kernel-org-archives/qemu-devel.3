Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70ADC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWS-000543-2V; Wed, 06 Mar 2024 01:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkW1-0004tH-Vt
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:34 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVx-0006F3-MO
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:33 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6e4f7c0e723so588844a34.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705548; x=1710310348;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DA8YPsa0OXQme2Bi1zvzEkGMO6/tiDahixJX2f3DNcQ=;
 b=avChtoVtUHkYyqVht28y3RfXU5US87NUqi9M/pQUnnZDK7YxYnLWqxXX7ojcN9aaji
 bQkogFYO9T6e6WTkoKTAviA8RGP+FABLCweahu0T1JKWssh62+DPs8sfcIp2UYnts4wt
 lXpqBZRVZtHKMy+qFghOGHCpu8R0kqQSAemT1SqtPyoU4PDTtrSzuZOyDyRU50ndBplX
 7YociyseNVNusW46qz2QnMdn0sqUxkyf9HVjVebp9dRxT6KFBIWu5qcJooPp3JCu5gN/
 Oj/HIAmY81s3rCC4FBATTQHq/wPL/IXKP/i06jg6529Vp2He35Q4E+tK/38R3V3mi6E9
 Tp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705548; x=1710310348;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DA8YPsa0OXQme2Bi1zvzEkGMO6/tiDahixJX2f3DNcQ=;
 b=pgS7EX79kEyx2Pzo0y1kAOtF8yMnIWvfBZwqSv26pFSOxg/xnOPCKZTkDHmSr9qJVF
 y0XMIRdW50dhRmFBKJmkMhOb7z2opC64+nAJjpxeMKBh7vtBNmwAF2NNBwJXHmOoGXff
 jWj3EEOL20iV/vkvkxmMPKHZOSkEM5jY6854JEUk5B5hjIMFyiSbJPrVanbHRlPlqgWL
 HCwXM0qOBrlF9ZsyEApzl4RIZakJaV1Tv4RyAAg3DpJbB9v/aJeKFAl90gIH6S5Huz/n
 jsL8Z9ambOYMZ3wDsGCb94zADlx5iROHMtN/zIZSOsMZbaOS4PCFwd09WcoaRIGwQYCj
 iXkg==
X-Gm-Message-State: AOJu0YxfIkLWAmzC3zI+cOVbQmJCl92Mc7UC+jvdrKz7avOGK1S+5iZY
 fj/Isq8LMgFvxjUWlq18duR9C+LXr5eRP5FqyhQ+LPjS9JOklWzt6THYAGUkPVU=
X-Google-Smtp-Source: AGHT+IHwRHAzqX7ZbBLGAt6Y5El8jJrsihgD/oOojtW8gTurTLx6+1SWBKmuh7rhj41V5kljEd4/2A==
X-Received: by 2002:a9d:750b:0:b0:6e4:f48b:c468 with SMTP id
 r11-20020a9d750b000000b006e4f48bc468mr4446355otk.35.1709705547856; 
 Tue, 05 Mar 2024 22:12:27 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 p8-20020a63e648000000b005d68962e1a7sm10224837pgj.24.2024.03.05.22.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:11 +0900
Subject: [PATCH v3 05/19] contrib/elf2dmp: Fix error reporting style in
 addrspace.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-5-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x330.google.com
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
 contrib/elf2dmp/addrspace.h |  4 ++--
 contrib/elf2dmp/addrspace.c |  8 ++++----
 contrib/elf2dmp/main.c      | 47 +++++++++++++++++++++------------------------
 3 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/contrib/elf2dmp/addrspace.h b/contrib/elf2dmp/addrspace.h
index c868d6473873..2ad30a9da48a 100644
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
index 4c127c9b1ec4..c995c723ae80 100644
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
index 8a71e2efd281..09af39422f1e 100644
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
2.44.0


