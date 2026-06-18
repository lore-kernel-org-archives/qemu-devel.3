Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EE1CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 21:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waKgt-0003f6-Uj; Thu, 18 Jun 2026 17:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1waKgs-0003ei-GE
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 17:54:26 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1waKgq-0002Jk-Nb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 17:54:26 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 36C6E43430;
 Thu, 18 Jun 2026 21:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5581F000E9;
 Thu, 18 Jun 2026 21:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781819656;
 bh=+/z2gsMFDguQ4ik1vH3gPJhI22TKOIejE07Hin8CMOU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=edEsvv4CFf0l5/HdrtEFUGhb6xsZ3b4p2evjCeGJuq9yU72F1hvInJFZnM9x6W6sI
 b3sBbGZNi2VUgJZw4SEuGtz/mB6Bi05rEjTb7kdr7gcV1gax2Ar0Q3CYtGIjNup8EO
 VqDX0nuod03xM47fhi+tmFi3OZsmd0vZz1NkEinI2iqKvsU8D6LHMl1a2+gMBjK3bh
 xBTDYUFLVuuNEkYJKisJEIpRkjtqGrT1dlJ2SDqr9HwQwosGR5cX+Z9Rln2l/Ir4+H
 A3yb/XDHHak9rpzxzhJe2alOOL43fExSSLms9d953RY6sZ9B5EPpq45lfLWy2LBnly
 lkHU+SetWC/Og==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, deller@gmx.de,
 Akshit Yadav <valium7171@gmail.com>
Subject: [PULL 1/4] linux-user: Fix AT_PHDR when program headers are relocated
 into their own segment
Date: Thu, 18 Jun 2026 23:54:08 +0200
Message-ID: <20260618215411.22057-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618215411.22057-1-deller@kernel.org>
References: <20260618215411.22057-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/elfload.c | 21 ++++++++++++++++++++-
 linux-user/qemu.h    |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b05b8b0c6b..8049c8ae62 100644
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
index 07fe801628..2268493141 100644
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
2.54.0


