Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FABAC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 17:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uect6-0003TO-Gg; Wed, 23 Jul 2025 13:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uect4-0003Rp-Ez
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:04:14 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1uect2-0001Fb-3T
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 13:04:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=Vgi0QYHkxzE85VYqe5vF1U31j80Gsh5QtkXPD7VBMv0=; b=abX3SlFxA/bT
 xEqCf7N1W8hrhWlKnWBWm7Zp8W4t1L8eTHanMiQix2k1Iy1820ofH6deClWQ3fzYWFBtkARpoO83b
 3udphXDzfoYBdJUuALf2BrThdEo+y+q2I1Iew9FMaebRrzm5/FMRrr1/lqy7xJ/plm644d0ztyV4D
 EEXHOkln71TzTb8TtEP1bJR6nyMKGv6DeXg4q6z6BRlW3RlpEm/u+kPkBZDmg4SJ0OcmAVeu2Un09
 djQV+dSk4vSG1sGZrDRR77QXIeaWOTjvuzgTcRMWy+Nx8SvbVwEaykxNX0KsdbB4sJzcwrAPJHBYy
 uh4A2lYKkpQsK4ftjtbacg==;
Received: from [130.117.225.5] (helo=vz9-barybin-2.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <nikolai.barybin@virtuozzo.com>) id 1uecnE-008cGV-1D;
 Wed, 23 Jul 2025 19:04:01 +0200
From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Subject: [PATCH] dump: enhance win_dump_available to report properly
Date: Wed, 23 Jul 2025 20:04:02 +0300
Message-ID: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=nikolai.barybin@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QMP query-dump-guest-memory-capability reports win dump as available for
any x86 VM, which is false.

This patch implements proper query of vmcoreinfo and calculation of
guest note size. Based on that we can surely report whether win dump
available or not.

For further reference one may review this libvirt discussion:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
[PATCH 0/4] Allow xml-configured coredump format on VM crash

Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
---
 dump/win_dump.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/dump/win_dump.c b/dump/win_dump.c
index 3162e8bd48..4bb1b28e63 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -14,14 +14,74 @@
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
 #include "hw/core/cpu.h"
+#include "hw/misc/vmcoreinfo.h"
 #include "qemu/win_dump_defs.h"
 #include "win_dump.h"
 #include "cpu.h"
+#include "elf.h"
 
 #if defined(TARGET_X86_64)
 
+#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
+    ((DIV_ROUND_UP((hdr_size), 4) +                     \
+      DIV_ROUND_UP((name_size), 4) +                    \
+      DIV_ROUND_UP((desc_size), 4)) * 4)
+
 bool win_dump_available(Error **errp)
 {
+    uint64_t addr, note_head_size, name_size, desc_size;
+    uint32_t size;
+    uint16_t guest_format;
+    uint8_t *guest_note = NULL;
+    size_t guest_note_size = 0;
+    VMCoreInfoState *vmci = vmcoreinfo_find();
+    ArchDumpInfo dump_info = {};
+    GuestPhysBlockList blocks = {};
+    int ret;
+
+    if (!vmci || !vmci->has_vmcoreinfo)
+        return false;
+
+    ret = cpu_get_dump_info(&dump_info, &blocks);
+    if (ret < 0)
+        return false;
+
+    guest_format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
+    if (guest_format != FW_CFG_VMCOREINFO_FORMAT_ELF)
+        return false;
+
+    size = le32_to_cpu(vmci->vmcoreinfo.size);
+    addr = le64_to_cpu(vmci->vmcoreinfo.paddr);
+    note_head_size = dump_info.d_class == ELFCLASS64 ?
+        sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);
+
+    guest_note = g_malloc(size + 1);
+    cpu_physical_memory_read(addr, guest_note, size);
+    if (dump_info.d_class == ELFCLASS64) {
+        const Elf64_Nhdr *hdr = (void *)guest_note;
+        if (dump_info.d_endian == ELFDATA2LSB) {
+            name_size = cpu_to_le64(hdr->n_namesz);
+            desc_size = cpu_to_le64(hdr->n_descsz);
+        } else {
+            name_size = cpu_to_be64(hdr->n_namesz);
+            desc_size = cpu_to_be64(hdr->n_descsz);
+        }
+    } else {
+        const Elf32_Nhdr *hdr = (void *)guest_note;
+        if (dump_info.d_endian == ELFDATA2LSB) {
+            name_size = cpu_to_le32(hdr->n_namesz);
+            desc_size = cpu_to_le32(hdr->n_descsz);
+        } else {
+            name_size = cpu_to_be32(hdr->n_namesz);
+            desc_size = cpu_to_be32(hdr->n_descsz);
+        }
+    }
+
+    guest_note_size = ELF_NOTE_SIZE(note_head_size, name_size, desc_size);
+    if (guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64 &&
+        guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32)
+        return false;
+
     return true;
 }
 
-- 
2.47.3


