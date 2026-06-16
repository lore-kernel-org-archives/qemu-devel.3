Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265FCCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDv-0005kq-I0; Tue, 16 Jun 2026 17:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDh-0005c8-9V
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:18 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDf-0007Rp-Hw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:17 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-36babe2c4bdso3119282a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644874; x=1782249674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1d1aEjn4LJhKQ30FhQTml2wsIITUmwS+fUTg53jjKs=;
 b=A465g4Sjb5uVoqsvRYxqAUlACVlTvDX+qrDZ3K6eIzO/rnZwC91EO30+dfPeuAj9AI
 9xP+0/7E4tb/cfWiME9gR4dggwXTJP9MTgnigRgewizxEreG36K/DvK+DF8XceWZYnpl
 EEQvXET0dXnbHJjZmBcHr5fwa21yjb0rw6Hku9KXlbYFzXQrJ9sRvOFFDsMuiHLtKZAh
 Trnjo2GuTLd+2jYF/CwmNrXT7GMwSnMsaVRAPOTZw+OqHFpPSzpAh+DblVYcyqxtsF3o
 nWtybi/7DAuTepn8YIUlmU8yS78vMOrjjCVHetXYQEITrjM1KVKF6PrDlkv/QwJgwq6q
 BmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644874; x=1782249674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D1d1aEjn4LJhKQ30FhQTml2wsIITUmwS+fUTg53jjKs=;
 b=iohm1Kq5JDQJfhwowqy166HW4WUVIw52FUBLvWhAeU7U0pr+F7/LLpmRM2AF2vmnCR
 0k+fac6miu8DrPMOxBJxJo77WP+1V9ycuKBTlW18pK/U/bgn1t3xJxIwYVTeSVntPrnn
 HHCqxZAaOE/wH6twvmSXV+u9HmMlLTb9MM37BQHUBSyOmwL0AvW7qEEm8enF/t/G2I3Z
 d4110t9MBNZgO+WGcNUM7iayCAArnRrechJ21ifNpXVX3CPIL+mx7j5cUkYDvf/V3X05
 SnzQN4Pl+3ajUjdIpXY2M34ZAu2oIdezqVGlsLCWBp4PwXTB9an61YDG74JBxFRL+B36
 8bvg==
X-Gm-Message-State: AOJu0Yyz+/DrDNfgz7BCBo0NAnzLtC2Vet+bB5OEcXPxzixfbcO+py87
 GG/aeb1XBZYDjsGnE+g+g0vuj38D+zWpk5rT3YaabbDCpJ5cUmMItXMQO/ymGRn4cYpEBdAHCB/
 vBHxF
X-Gm-Gg: Acq92OGF/yDOFIOkdJqNksYaYnKlkVeWOU43I52b6BI/wtndGOIJ5oPyLHftPvtzLxs
 8OCVi6fcEsmVzTpeK0Ts0JTcv3qGw8Szh6rUdKuAjIooYY2S9dGrRxKRRGtTEBzc6VwqabzSWXG
 LxCpSuSmsJRvAADWtpyKFAUhejSu7omNk6Fnnpdk91IjE2E6mI1IJL9E19f1RtcZbGvtX9JwezG
 8ZIy4KUzZxGImu5eZav9CJmgS455m1o9wnn5xzFykF0aBUKIVIDOF+TKvbJTNiS/j8tnVtHTLcZ
 2MiIgQgRy4T5f1AmsndGIKgb4te+/ZfoRjYVOWaQy7gzdeLeHq/6wV1AlCR/aPQts/uWPtU1KR3
 yRew7/xqSEGwQqlyKM5vRabi+uFqU/ZhrNqk+ZbdnBB0LHlSAiCedQVBFkNLNNzsO/IyG0FLysI
 iBrmMetWONOEI/4eifGOnQKYJupvz0QIY9Fd+Ozzofs9q7Ox+JVtqTH6X1cqQn
X-Received: by 2002:a17:90a:e18c:b0:369:7421:b376 with SMTP id
 98e67ed59e1d1-37c9369eed3mr944374a91.19.1781644874241; 
 Tue, 16 Jun 2026 14:21:14 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 12/13] bsd-user: Use probe_guest_base
Date: Tue, 16 Jun 2026 14:20:53 -0700
Message-ID: <20260616212055.334466-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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


