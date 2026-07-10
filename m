Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC89C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE6-0004PK-25; Fri, 10 Jul 2026 19:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDq-0004IH-N3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:30 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDo-00032n-Jc
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:30 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so1203078a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724487; x=1784329287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sPZxYmX7vd6cvgBxLyZNN4yNhTfNGY/CctANfdVHSN4=;
 b=ZwRkN+doMC0BK97C0uw8MAN2va5PeU8MfT/Sqa//4WNushjExS/wGUAU5YaWaFIfR/
 30j4EZkKyvoAP2KeGd5yQtvpsNVwoXbS85OOMR9Hua0ozzraXi3M4jFrcl1sYYgV8aWG
 efVcWP/8/axGGzUon2cBMm/rtPMtTs3fHU6fu+K4To/iXnFLDLdVfLmBhkt/ba/CKpeV
 UBW0qC4PUVdnWzNNpvxfGIl8UUPGoczojlgZtnr9SWztRGuvcs9qwuuXfXRzfzUPJEdA
 vokjYx80kSzhukIJX8qi6579truVcwSy2P8oeiuQRIdrDFCkXxMWAf3KKQs0gMl9t2/f
 mxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724487; x=1784329287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sPZxYmX7vd6cvgBxLyZNN4yNhTfNGY/CctANfdVHSN4=;
 b=DIjT+qyHaDXyiH+8iHBIw4B39Wid2DCGJRHxbEp2UlqFqnK68Eq868vh0TG8QLKqcM
 acFcJNMYjzPDucuCiG55FYcHgC55sHx4GffolGCZhV3CYWpEZRfSgtb5GojgmP3GSJCF
 MdTghLg2GKQp0CUWVzAc6GFOHSMeXM7wJ50DXKdTl5TY3+LNZAGQdxAz17P5giqUUFc7
 mJcibY14ok/V44JYvvNsWjRjU0M8BXryLeUYQPCiDJoQezkie6HqSym5FOzPPMxcwP2T
 VF+827dHPcsvfny9PR8UcPsiQuFvHFz5KpeFhJwnecMGtBhOsxmj9MWVi9M+xYTzHVDF
 jfbA==
X-Gm-Message-State: AOJu0YxaqOg5UJPDFMlY69lSdIQ9S5WKlhYt5G535Y5o+NtPjgNDX0uj
 TnRNQSVTAGhupudebp4Q3qL0NSIrlGXDLoKrIem+qAR4JiBoPZZkuUUe1nnOrlfVPNNB2X61V4U
 i6JQ1
X-Gm-Gg: AfdE7cl82uDTqzMNrH0oI5KqT6zENXzC7ficaAs3gAZcC5mg4p7vongIanoqn4dqRUY
 SdpOAsGEN1tgCLOtiDsg/7uv70VK9nh/SUjWCjfwhEHO5sdQNOske37RuF+MbunQzZyswLmgEtc
 H33Hcv9nJbAbIwGjbg7wgVIkNX+ZIxKg9NY5DB315wEYP+yxy0l2PZBjzzHp/K+nT6j0y01GT+9
 GYDeoPYXNiCrecxikM09k4xmwpUIQlv/qyU+Q/fu+CCZXppzOXTGsCWK7Uhiq2OBExJLCk1C+zQ
 L8m9sVDzyq6opfTymWgLR0nS3oi0ZOmzF3xIhBNeswd5VcMQSx2J93sW14gB0aBcKaeUwxYocwI
 s8Gy8S7jGd/PpYDXQJJW1GKYbIZB/fUtkpIIDQfWkX09sMB0kfg9ySpZjbs3hqtllIMujFKoaUq
 pKvlcrzN7uZSswAPFUDLVgQGvSIRV5
X-Received: by 2002:a17:90b:28c3:b0:36d:8f51:fe29 with SMTP id
 98e67ed59e1d1-38dc7a4072cmr728017a91.17.1783724487125; 
 Fri, 10 Jul 2026 16:01:27 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] bsd-user: Use probe_guest_base
Date: Fri, 10 Jul 2026 16:01:15 -0700
Message-ID: <20260710230116.900171-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Merge the PT_LOAD loop with the PT_INTERP loop, as the XXX
comment suggests.  Pass the probed range to probe_guest_base.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/elfload.c | 37 +++++++++++++++++++------------------
 bsd-user/main.c    | 39 ++++-----------------------------------
 2 files changed, 23 insertions(+), 53 deletions(-)

diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 3bca0cc9ed..a87a892eb8 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -22,6 +22,7 @@
 #include "qemu.h"
 #include "disas/disas.h"
 #include "qemu/path.h"
+#include "user/probe-guest-base.h"
 
 static abi_ulong target_auxents;   /* Where the AUX entries are in target */
 static size_t target_auxents_sz;   /* Size of AUX entries including AT_NULL */
@@ -610,8 +611,9 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     abi_ulong elf_brk;
     int error, retval;
     char *elf_interpreter;
-    abi_ulong baddr, elf_entry, et_dyn_addr, interp_load_addr = 0;
+    abi_ulong elf_entry, et_dyn_addr, interp_load_addr = 0;
     abi_ulong reloc_func_desc = 0;
+    PGBRange range = { -1, 0 };
 
     load_addr = 0;
     elf_ex = *((struct elfhdr *) bprm->buf);          /* exec-header */
@@ -654,10 +656,10 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
 
     elf_brk = 0;
 
-
     elf_interpreter = NULL;
-    for (i = 0; i < elf_ex.e_phnum; i++) {
-        if (elf_ppnt->p_type == PT_INTERP) {
+    for (i = 0; i < elf_ex.e_phnum; i++, elf_ppnt++) {
+        switch (elf_ppnt->p_type) {
+        case PT_INTERP:
             if (elf_interpreter != NULL) {
                 free(elf_phdata);
                 free(elf_interpreter);
@@ -709,8 +711,14 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
                 close(bprm->fd);
                 return retval;
             }
+            break;
+
+        case PT_LOAD:
+            range.lo = MIN(range.lo, elf_ppnt->p_vaddr);
+            range.hi = MAX(range.hi,
+                           elf_ppnt->p_vaddr + elf_ppnt->p_memsz - 1);
+            break;
         }
-        elf_ppnt++;
     }
 
     /* Some simple consistency checks for the interpreter */
@@ -740,19 +748,12 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     info->end_code = 0;
     elf_entry = (abi_ulong) elf_ex.e_entry;
 
-    /* XXX Join this with PT_INTERP search? */
-    baddr = 0;
-    for (i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
-        if (elf_ppnt->p_type != PT_LOAD) {
-            continue;
-        }
-        baddr = elf_ppnt->p_vaddr;
-        break;
-    }
-
     et_dyn_addr = 0;
-    if (elf_ex.e_type == ET_DYN && baddr == 0) {
-        et_dyn_addr = ELF_ET_DYN_LOAD_ADDR;
+    if (elf_ex.e_type == ET_DYN) {
+        probe_guest_base(bprm->filename, NULL, NULL);
+        et_dyn_addr = ELF_ET_DYN_LOAD_ADDR - range.lo;
+    } else {
+        probe_guest_base(bprm->filename, &range, NULL);
     }
 
     /*
@@ -766,7 +767,7 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     info->elf_flags = elf_ex.e_flags;
 
     error = load_elf_sections(&elf_ex, elf_phdata, bprm->fd, et_dyn_addr,
-        &load_addr);
+                              &load_addr);
     for (i = 0, elf_ppnt = elf_phdata; i < elf_ex.e_phnum; i++, elf_ppnt++) {
         if (elf_ppnt->p_type != PT_LOAD) {
             continue;
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4f1544342e..5277b4e099 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -541,41 +541,10 @@ int main(int argc, char **argv)
         }
     }
 
-    /*
-     * If reserving host virtual address space, do so now.
-     * Combined with '-B', ensure that the chosen range is free.
-     */
-    if (reserved_va) {
-        void *p;
-
-        if (have_guest_base) {
-            p = mmap((void *)guest_base, reserved_va + 1, PROT_NONE,
-                     MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_EXCL, -1, 0);
-        } else {
-            p = mmap(NULL, reserved_va + 1, PROT_NONE,
-                     MAP_ANON | MAP_PRIVATE, -1, 0);
-        }
-        if (p == MAP_FAILED) {
-            const char *err = strerror(errno);
-            char *sz = size_to_str(reserved_va + 1);
-
-            if (have_guest_base) {
-                error_report("Cannot allocate %s bytes at -B %p for guest "
-                             "address space: %s", sz, (void *)guest_base, err);
-            } else {
-                error_report("Cannot allocate %s bytes for guest "
-                             "address space: %s", sz, err);
-            }
-            exit(1);
-        }
-        guest_base = (uintptr_t)p;
-        have_guest_base = true;
-
-        /* Ensure that mmap_next_start is within range. */
-        if (reserved_va <= mmap_next_start) {
-            mmap_next_start = (reserved_va / 4 * 3)
-                              & TARGET_PAGE_MASK & qemu_host_page_mask;
-        }
+    /* Ensure that mmap_next_start is within range. */
+    if (reserved_va && reserved_va <= mmap_next_start) {
+        mmap_next_start = ((reserved_va / 4 * 3)
+                           & TARGET_PAGE_MASK & qemu_host_page_mask);
     }
 
     if (loader_exec(filename, argv + optind, target_environ, regs, info,
-- 
2.43.0


