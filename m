Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB478CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFsy-0006I3-Rm; Wed, 24 Jun 2026 01:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFsj-0005Un-Lj; Wed, 24 Jun 2026 01:10:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFsh-0006Gk-Iz; Wed, 24 Jun 2026 01:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277633; bh=Keok8i8qUdh8lw5p9O3kG49/Lx9jiNE6zo1Es59rBbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Z0kg1DMyC0ObHuquafRIEgz52V4OydC8z2Kc9Jm9E58z1hbbRsCltaJ580D25idVt
 BF+Tu3E1RLLKa9AQYHi6YWpuD+AMQNw5BK3s/eAij8W8A4Ow7OfQgfh8I9qFZKUQlh
 gz7oiZN0N6DKYusf8UItENYVLsHbdpoxc7P7DOI4cz/+Igkqi8bO06NhWe7V0mFNZD
 OWDCjvVIgC6PH8mYVakIlojtsN23vHSi4CC9jbsSHnIECvOhreL93Gc3U3A1Z3XGcP
 gFqjLsiYJbuYm1JAepEVz5OLC2EVofbuCU2olNwG71Y2GN9l8Y1Lv2otvjAyv4hfHh
 SIN/LjYUSz7cw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6E27C1BA67D;
 Wed, 24 Jun 2026 08:07:13 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 587713DDB1A;
 Wed, 24 Jun 2026 08:07:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akshit Yadav <valium7171@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 95/95] linux-user: Fix AT_PHDR when program headers
 are relocated into their own segment
Date: Wed, 24 Jun 2026 08:05:30 +0300
Message-ID: <20260624050541.395079-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Akshit Yadav <valium7171@gmail.com>

When a binary is patched or relocated such that the program header table is
moved into a separate PT_LOAD segment (rather than sitting at the start of the
first loadable segment), QEMU's AT_PHDR auxv entry becomes incorrect. The
loader was computing AT_PHDR as load_addr + e_phoff, which assumes the headers
are mapped 1:1 from file offset 0. This breaks when the headers are elsewhere.

The Linux kernel instead locates the PT_LOAD segment that contains e_phoff,
then computes the in-memory address as p_vaddr + (e_phoff - p_offset). This
correctly handles relocated headers.

Fix by:
1. Add phdr_addr field to image_info to cache the resolved address.
2. Initialize to load_addr + e_phoff (fallback for headers outside any PT_LOAD).
3. In the PT_LOAD mapping loop, detect if the segment contains e_phoff and
   override with the segment-relative address.
4. Use info->phdr_addr for AT_PHDR instead of the incorrect formula.

Signed-off-by: Akshit Yadav <valium7171@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 156e536a7b9700018aaa2437072c14e3376340a7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0e757787d2..b995a85eaf 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -699,7 +699,7 @@ static abi_ulong create_elf_tables(abi_ulong p, int argc, int envc,
     /* There must be exactly DLINFO_ITEMS entries here, or the assert
      * on info->auxv_len will trigger.
      */
-    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->load_addr + exec->e_phoff));
+    NEW_AUX_ENT(AT_PHDR, (abi_ulong)(info->phdr_addr));
     NEW_AUX_ENT(AT_PHENT, (abi_ulong)(sizeof (struct elf_phdr)));
     NEW_AUX_ENT(AT_PHNUM, (abi_ulong)(exec->e_phnum));
     NEW_AUX_ENT(AT_PAGESZ, (abi_ulong)(TARGET_PAGE_SIZE));
@@ -1469,6 +1469,12 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     info->data_offset = load_bias;
     info->load_addr = load_addr;
     info->entry = ehdr->e_entry + load_bias;
+    /*
+     * Fallback for AT_PHDR if the program headers do not fall within
+     * any PT_LOAD segment (see the loop below, which overrides this with
+     * the correct in-memory address when a containing segment is found).
+     */
+    info->phdr_addr = load_addr + ehdr->e_phoff;
     info->start_code = -1;
     info->end_code = 0;
     info->start_data = -1;
@@ -1523,6 +1529,19 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
             vaddr_ef = vaddr + eppnt->p_filesz;
             vaddr_em = vaddr + eppnt->p_memsz;
 
+            /*
+             * If this segment contains the program headers, record their
+             * in-memory address for AT_PHDR. This matches the kernel, which
+             * locates the headers via the containing PT_LOAD rather than
+             * assuming load_addr + e_phoff (false when the phdrs are not
+             * mapped 1:1 from file offset 0, e.g. relocated into their own
+             * segment by a binary patcher).
+             */
+            if (eppnt->p_offset <= ehdr->e_phoff &&
+                ehdr->e_phoff < eppnt->p_offset + eppnt->p_filesz) {
+                info->phdr_addr = vaddr + (ehdr->e_phoff - eppnt->p_offset);
+            }
+
             /*
              * Some segments may be completely empty, with a non-zero p_memsz
              * but no backing file segment.
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 7f98fb2607..a9dda4bbd7 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -26,6 +26,7 @@
 struct image_info {
         abi_ulong       load_bias;
         abi_ulong       load_addr;
+        abi_ulong       phdr_addr;
         abi_ulong       start_code;
         abi_ulong       end_code;
         abi_ulong       start_data;
-- 
2.47.3


