Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB248CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 18:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suyKl-0003k3-39; Sun, 29 Sep 2024 14:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suyKa-0003Xc-Nb
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:07:41 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suyKZ-0008Ul-1a
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:07:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 48B7E5C35DE;
 Sun, 29 Sep 2024 18:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1307CC4CEC5;
 Sun, 29 Sep 2024 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727633258;
 bh=zugxR724dlw5HRjvz+NLeFunLq6E0krl84kUd9AxbSk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o/6tOhddQLXy22KKCtRvIH1q4jyjRlkiwLODq8IrHvnGVPEEf75Jk/gDgIJhMQ++g
 DzgT03CFq8MKsujusipgk/qihC6mGhGw2H5wwnGtW9bek4di5nwsM8D6LsjVfl0Ooi
 uWmofnICXJAghxSHXMiJfBcJuO3TC0njWXreq/cZr3TyYRBEt97/lzZYbnp4jPgBid
 kpwcCDl3l1Kgt9dsKmnitjcdhy1kUn/MR6kQZZCWZK08wKTEjfUgFXjQhMOmg62Ih+
 qcVrvW9L/BHoie8s6R/DvbFolTb6d+dgrPcEqLupVF6+G6xgy9B672rMKkULJg/IRl
 aHAvjHC7RQ6Vw==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 2/2] hw/x86: Always treat the PVH entrypoint as a 32-bit LE
 field
Date: Sun, 29 Sep 2024 20:06:58 +0200
Message-Id: <20240929180659.3598-3-ardb@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240929180659.3598-1-ardb@kernel.org>
References: <20240929180659.3598-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The PVH entrypoint is entered in 32-bit mode, and is documented as being
a 32-bit field. Linux happens to widen the field in the ELF note to 64
bits so treating it as a 64-bit field works for booting the kernel.

However, Xen documents the ELF note with the following example

  ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY, .long, xen_start32)

and uses .long in the code as well, and so reading more than 32 bits
here is risky. And dereferencing a size_t* in portable code is just
bizarre, so let's use a uint32_t specifically in all cases here.

While at it, read the field as little-endian explicitly, so things work
as expected on big endian hosts too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 hw/i386/x86-common.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 992ea1f25e..44e5c365f1 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -539,7 +539,7 @@ DeviceState *ioapic_init_secondary(GSIState *gsi_state)
  */
 static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
 {
-    size_t *elf_note_data_addr;
+    void *elf_note_data_addr;
 
     /* Check if ELF Note header passed in is valid */
     if (arg1 == NULL) {
@@ -555,8 +555,6 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
         elf_note_data_addr =
             ((void *)nhdr64) + nhdr_size64 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-
-        pvh_start_addr = *elf_note_data_addr;
     } else {
         struct elf32_note *nhdr32 = (struct elf32_note *)arg1;
         uint32_t nhdr_size32 = sizeof(struct elf32_note);
@@ -566,10 +564,9 @@ static uint64_t read_pvh_start_addr(void *arg1, void *arg2, bool is64)
         elf_note_data_addr =
             ((void *)nhdr32) + nhdr_size32 +
             QEMU_ALIGN_UP(nhdr_namesz, phdr_align);
-
-        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
     }
 
+    pvh_start_addr = ldl_le_p(elf_note_data_addr);
     return pvh_start_addr;
 }
 
-- 
2.39.5


