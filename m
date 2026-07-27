Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6129C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woNFD-0005f1-6U; Mon, 27 Jul 2026 11:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tycho@kernel.org>) id 1woMrH-0006m0-OV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:03:12 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tycho@kernel.org>) id 1woMrG-0007B3-4x
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 11:03:11 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7EACD601DE;
 Mon, 27 Jul 2026 15:03:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823011F000E9;
 Mon, 27 Jul 2026 15:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785164585;
 bh=OS5YQV4o6NpBgijEakeJsKx4uhqE5N3Wqh0IvH+4hPE=;
 h=From:To:Cc:Subject:Date;
 b=QB6vZI8LSpwYL2I+eFH+tKvolvWv/hBQqYjf05GWAafPSC7kOXHqXPgGJa6KzLhpj
 lrIC7uSCqfmfKOWPgckiw0X87WmtDTtc98CSPBcXHGboFTNr1N9URwty7GOUAY4Mku
 GjJaIqUSVD8uB8S7f1fW6EkfjahpKVBTpZrHvV/t6yJYE5eWqNPDDHXOQzp4UVeC24
 81WHhMowPGn2Sgj3qee6aE5ZXUOTUYIOWlnYzYmFr9KTxjxL6Q6ee8Q4nRlEqDr+6r
 odz5eLRvX4tCEL8+oaMq5d2bYTWec3c+qZn3E9HZoDDqxiX/qq8qCkj+lDzrtMfuK9
 hnjDm9sVfH4Ng==
From: Tycho Andersen <tycho@kernel.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 "Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v1] hw/vfio: Fix liveness check in vfio_connect_kvm_msi_virq()
Date: Mon, 27 Jul 2026 09:00:38 -0600
Message-ID: <20260727150038.2684512-1-tycho@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=tycho@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 27 Jul 2026 11:27:47 -0400
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

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

While working on savevm/loadvm for a new vfio device, I encountered the
crash below. Since vfio_connect_kvm_msi_virq() didn't check the ->use flag
for the vector, it would pass an unused vector down to
vfio_cpr_load_vector_fd() which would crash.

Fix this by checking the ->use flag along with the virq number to detect
whether a vector is valid or not.

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555a891ef in vfio_cpr_load_vector_fd (vdev=vdev@entry=0x0,
    name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1) at ../hw/vfio/cpr.c:44
44	    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
(gdb) bt
#0  0x0000555555a891ef in vfio_cpr_load_vector_fd
    (vdev=vdev@entry=0x0, name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1)
    at ../hw/vfio/cpr.c:44
#1  0x0000555555ce64a1 in vfio_notifier_init
    (vdev=0x0, e=e@entry=0x5555586971b4, name=name@entry=0x555555eeb27e "kvm_interrupt", nr=nr@entry=1, errp=errp@entry=0x0) at ../hw/vfio/pci.c:79
#2  0x0000555555ce721e in vfio_connect_kvm_msi_virq (vector=0x5555586971a8, nr=nr@entry=1)
    at ../hw/vfio/pci.c:601
#3  0x0000555555cea5a5 in vfio_connect_kvm_msi_virq (nr=1, vector=<optimized out>)
    at ../hw/vfio/pci.c:597
#4  vfio_pci_commit_kvm_msi_virq_batch (vdev=0x55555906de40) at ../hw/vfio/pci.c:822
#5  0x0000555555cea9f2 in vfio_msix_enable (vdev=vdev@entry=0x55555906de40) at ../hw/vfio/pci.c:850
#6  0x0000555555ceb152 in vfio_pci_load_config (vbasedev=0x55555906e900, f=<optimized out>)
    at ../hw/vfio/pci.c:3088
#7  0x0000555555a8c765 in vfio_load_device_config_state (f=0x5555574a43d0, opaque=0x55555906e900)
    at ../hw/vfio/migration.c:278
#8  0x0000555555b3a522 in vmstate_load
    (f=f@entry=0x5555574a43d0, se=se@entry=0x5555591edd40, errp=errp@entry=0x7fffffffe130)
    at ../migration/savevm.c:971
#9  0x0000555555b3ab1a in qemu_loadvm_section_start_full
    (f=f@entry=0x5555574a43d0, type=type@entry=4 '\004', errp=errp@entry=0x7fffffffe130)
    at ../migration/savevm.c:2654
#10 0x0000555555b3e1ee in qemu_loadvm_state_main
    (f=f@entry=0x5555574a43d0, mis=mis@entry=0x5555571de5a0, errp=0x7fffffffe130,
    errp@entry=0x555557157c10 <error_fatal>) at ../migration/savevm.c:2973
#11 0x0000555555b3f7b7 in qemu_loadvm_state
    (f=f@entry=0x5555574a43d0, errp=errp@entry=0x555557157c10 <error_fatal>)
    at ../migration/savevm.c:3058
#12 0x0000555555b40863 in load_snapshot
    (name=0x7fffffffecc9 "foo", vmstate=vmstate@entry=0x0, has_devices=has_devices@entry=false, devices=devices@entry=0x0, errp=errp@entry=0x555557157c10 <error_fatal>) at ../migration/savevm.c:3452
#13 0x0000555555adc211 in qmp_x_exit_preconfig (errp=0x555557157c10 <error_fatal>) at ../system/vl.c:2817
#14 qmp_x_exit_preconfig (errp=0x555557157c10 <error_fatal>) at ../system/vl.c:2802
#15 0x0000555555adf8ed in qemu_init (argc=<optimized out>, argv=<optimized out>) at ../system/vl.c:3849
#16 0x00005555558903fd in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:71

Fixes: 30edcb4d4e7a ("vfio-pci: preserve MSI")
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
An alternative implementation of this would be to set ->virq = -1 after
the allocation in vfio_msix_enable(), but since other locations that
checks ->virq >= 0 also check ->use, I added it here too. Maybe it would
be useful to do both.
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 380dd8c15f..b5280c3d2a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -589,7 +589,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
 {
     const char *name = "kvm_interrupt";
 
-    if (vector->virq < 0) {
+    if (!vector->use || vector->virq < 0) {
         return;
     }
 

base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
-- 
2.55.0


