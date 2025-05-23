Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC45C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 06:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIMHh-0001UX-Fp; Fri, 23 May 2025 02:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uIMHZ-0001UG-Ui; Fri, 23 May 2025 02:53:30 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uIMHX-0001rV-Cs; Fri, 23 May 2025 02:53:29 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3EF2043EA1;
 Fri, 23 May 2025 08:53:22 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, vsementsov@virtuozzo.com
Subject: [PATCH] hw/core/qdev-properties-system: Add missing return in
 set_drive_helper()
Date: Fri, 23 May 2025 08:53:18 +0200
Message-Id: <20250523065318.278544-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Currently, changing the drive property of e.g. a scsi-hd object will
result in an assertion failure:

> bdrv_replace_child_noperm: Assertion `bdrv_get_aio_context(old_bs) ==
> bdrv_get_aio_context(new_bs)' failed.

The problematic scenario is already detected, but a 'return' statement
was missing.

Cc: qemu-stable@nongnu.org
Fixes: d1a58c176a ("qdev: allow setting drive property for realized device")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Reproducer:

#!/bin/bash
rm /tmp/disk0.raw
rm /tmp/disk1.raw
./qemu-img create -f raw /tmp/disk0.raw 1G
./qemu-img create -f raw /tmp/disk1.raw 1G
./qemu-system-x86_64 --qmp stdio \
--blockdev file,node-name=node0,filename=/tmp/disk0.raw \
--blockdev file,node-name=node1,filename=/tmp/disk1.raw \
--nodefaults \
--object 'iothread,id=iothread0' \
--device 'virtio-scsi-pci,id=virtioscsi0,bus=pci.0,addr=0x3,iothread=iothread0' \
--device 'scsi-hd,bus=virtioscsi0.0,scsi-id=1,drive=node0,id=scsi0' \
<<EOF
{"execute": "qmp_capabilities"}
{"execute": "qom-set", "arguments": { "path": "/machine/peripheral/scsi0", "property": "drive", "value": "node1" } }
{"execute": "quit"}
EOF

 hw/core/qdev-properties-system.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8e11e6388b..24e145d870 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -145,6 +145,7 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
         if (ctx != bdrv_get_aio_context(bs)) {
             error_setg(errp, "Different aio context is not supported for new "
                        "node");
+            return;
         }
 
         blk_replace_bs(blk, bs, errp);
-- 
2.39.5



