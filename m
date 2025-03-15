Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACE2C28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 07:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMAo-00022b-9r; Sat, 15 Mar 2025 03:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMAl-0001zA-Sa; Sat, 15 Mar 2025 03:43:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMAj-0004nC-PM; Sat, 15 Mar 2025 03:43:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9A9DEFFAFB;
 Sat, 15 Mar 2025 10:41:55 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 895E31CACC5;
 Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6930F559E2; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 07/42] linux-user: Honor elf alignment when placing
 images
Date: Sat, 15 Mar 2025 10:42:09 +0300
Message-Id: <20250315074249.634718-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

Most binaries don't actually depend on more than page alignment,
but any binary can request it.  Not honoring this was a bug.

This became obvious when gdb reported

    Failed to read a valid object file image from memory

when examining some vdso which are marked as needing more
than page alignment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit c81d1fafa6233448bcc2d8fcd2ba63a4ae834f3a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 17cd547c0c..e1a8b102d4 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3278,7 +3278,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                            char **pinterp_name)
 {
     g_autofree struct elf_phdr *phdr = NULL;
-    abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
+    abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align;
+    size_t reserve_size, align_size;
     int i, prot_exec;
     Error *err = NULL;
 
@@ -3362,6 +3363,9 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
 
     load_addr = loaddr;
 
+    align = pow2ceil(info->alignment);
+    info->alignment = align;
+
     if (pinterp_name != NULL) {
         if (ehdr->e_type == ET_EXEC) {
             /*
@@ -3370,8 +3374,6 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              */
             probe_guest_base(image_name, loaddr, hiaddr);
         } else {
-            abi_ulong align;
-
             /*
              * The binary is dynamic, but we still need to
              * select guest_base.  In this case we pass a size.
@@ -3389,10 +3391,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Since we do not have complete control over the guest
              * address space, we prefer the kernel to choose some address
              * rather than force the use of LOAD_ADDR via MAP_FIXED.
-             * But without MAP_FIXED we cannot guarantee alignment,
-             * only suggest it.
              */
-            align = pow2ceil(info->alignment);
             if (align) {
                 load_addr &= -align;
             }
@@ -3416,13 +3415,35 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr = target_mmap(load_addr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
+    reserve_size = (size_t)hiaddr - loaddr + 1;
+    align_size = reserve_size;
+
+    if (ehdr->e_type != ET_EXEC && align > qemu_real_host_page_size()) {
+        align_size += align - 1;
+    }
+
+    load_addr = target_mmap(load_addr, align_size, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
                             (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
                             -1, 0);
     if (load_addr == -1) {
         goto exit_mmap;
     }
+
+    if (align_size != reserve_size) {
+        abi_ulong align_addr = ROUND_UP(load_addr, align);
+        abi_ulong align_end = align_addr + reserve_size;
+        abi_ulong load_end = load_addr + align_size;
+
+        if (align_addr != load_addr) {
+            target_munmap(load_addr, align_addr - load_addr);
+        }
+        if (align_end != load_end) {
+            target_munmap(align_end, load_end - align_end);
+        }
+        load_addr = align_addr;
+    }
+
     load_bias = load_addr - loaddr;
 
     if (elf_is_fdpic(ehdr)) {
-- 
2.39.5


