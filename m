Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3D6CD6E54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzf-0005hM-P3; Sat, 30 May 2026 17:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzS-0005dp-Eu
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzQ-0000kw-2v
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2bf02708e8fso21427825ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175583; x=1780780383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1d1aEjn4LJhKQ30FhQTml2wsIITUmwS+fUTg53jjKs=;
 b=CEjtCDnmLoyzIYfunMsLtPtfEy/nH+2105YhVuocyvFNvtmVnnhf9xShGBm0YNEwGV
 RIAaBzu2AdraOacPQ4cKZWxtp0zzYcORJB3xu6DA37nzLrPHbq/x3aa8gmtHWqtpIG6Q
 rmonYC9H+78lx1qKCanZGiAZy88B1QUGhLbDzlnDmAfI7FKIn0QRDz919Km2lEL1izZ3
 ag5/B4FJdJITAQ0A+LFhj33fjE61DP31YtGd5k2Af1Y9dBjeD39NKmgr36zd0R53rcI8
 gfn44WJ3P5lUwloBUoMNQOyv5HYpxoHebaVriVdxS08BZUGHXT1bP1VVfwWgSOI/ku2m
 JG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175583; x=1780780383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D1d1aEjn4LJhKQ30FhQTml2wsIITUmwS+fUTg53jjKs=;
 b=Z6mt/TSTx1uDlu3pMi53WqVAFEWHEg/pIZaiNBFQ0sh2zE+gCgHdFWzHzbqlNgIaSv
 +7J9CnJ6h4sP8VZOfVrymvmNeRX7n6hgknLi02SHa4zSwj856YmF3ESybtZnu+Ho5tfm
 ijL5J1CEovnP5QllHA4EiXR/Oxb0rfqKEKofVh3oXoS+hJ92GaWe9K0/8u4aDaYChRDD
 gqR0uSEBwIT1GTjzGh33ShEj4MLHxWFvmajcUAinZlhqQsgADNKS70PcUTKfu5SsIlt7
 MKVpf/bYGfmi7MqXZhCOYBsHrAx2mOJ0h+C9p+uBj9ttAkTWb3X9XJrB27s0l7HTWfXf
 pwiQ==
X-Gm-Message-State: AOJu0YxVNm/lEmYtT+7o2WJwrn5Y9Wqt7KGgCHOsTBO1iGxQboCqYldd
 urw87X6ceCF5vNzhkO1/wyKrPl3wkMKndvjqlBkGWHehQiJjnhdcLWY57/j4Ap6xMEvIRPSOV2k
 PxeD0YvU=
X-Gm-Gg: Acq92OHl8LPnX1T1Chd0rb+BYT2CGu6koa0l6VytPjEHr+HZzX9VYiAsiOoZPQrI3IQ
 f7JCpzUI0JtvD4kLj12eWgB+19Ph+nTrWLDCeHgQZDVJk/XAjvsFRTxEECIIOHxufIqj05YUupW
 lT2Rz+Qg9HhIpOLOOO7TdSAZ++zN/dAlbkPu0c87Nrz8WBmYHFi3cyaMc46db/2/ntkgdAIRcVO
 kVujr2fCOLE9roS7934oBo3nG+Cy1xDPws3K3WalbamC4WZ+XIvbuYPZgE6LAjsWjjpeOEJakAq
 sUX9WKKaKsIi36UO/CxxfWrrNFqxZuQWrNmgKSWsMorNj4gbBHyfkW8cdhILExzpaggIPS752g2
 qHeXYSKaxP5ywP4h+KiLeTxLkNLRUZsfom7mZriYTB9jbdid2q3DC6hnKwk7pX2emBGMSvNP+Es
 Cb/vAwInuw2yXSLMrIL+a6E7QxOtosLKUJQCxdiqk=
X-Received: by 2002:a17:903:906:b0:2bd:7684:34b0 with SMTP id
 d9443c01a7336-2bf367d6ea3mr61196485ad.15.1780175582508; 
 Sat, 30 May 2026 14:13:02 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:13:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 12/13] bsd-user: Use probe_guest_base
Date: Sat, 30 May 2026 14:12:46 -0700
Message-ID: <20260530211248.375318-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
index 73aae8c327..772a26199b 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -540,41 +540,10 @@ int main(int argc, char **argv)
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


