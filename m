Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB88C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAR9-0002B2-EQ; Wed, 12 Aug 2026 11:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQd-0001cx-1l; Wed, 12 Aug 2026 10:59:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAQa-0001iN-B3; Wed, 12 Aug 2026 10:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=8/2rKRND8/j/F68Os4TZupVses8oBKBynuRaCkKjpUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ss94lkwwPhzVUsCV0aSOk+2onjVk2fLORsP+vktykvQBgAvwsRQTmyBTDvoKDHT3t
 1Xr7/NrEfHExuRoKhSeie3J0B9xBF2Diu+Ww6+7ZI3wwxL6yB78SnD6IZywGJjObgw
 mVgE9pXmg87rq8QFqJhFl7XWEDvYrZKp8mC9Kic48JpANwgMwrndgabgwNgwzDk+hS
 gDon31Sq7XtcsVSBEeH4nRpHBtfkgadLPn259Uh5k2dfvxQzgGrAfJu/6y4nWdl3Xn
 7/eLtvGZ3ZddYawuSGZKjKRvykNISIWZIMlY+Vg6doWxUlDQkDeE1g5dMyLtZrx4/S
 98J4RdyZaWg+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 53E381CA65F;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AEE08409DA1;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 18F152FA19; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Tycho Andersen (AMD)" <tycho@kernel.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 091/120] hw/vfio: Fix liveness check in
 vfio_connect_kvm_msi_virq()
Date: Wed, 12 Aug 2026 17:49:14 +0300
Message-ID: <20260812144955.649205-91-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260727150038.2684512-1-tycho@kernel.org
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit f498c21b3595157d6fff8fb4f546cfecb14bd6dc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5c192ee54b4..438f16d89f1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -592,7 +592,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
 {
     const char *name = "kvm_interrupt";
 
-    if (vector->virq < 0) {
+    if (!vector->use || vector->virq < 0) {
         return;
     }
 
-- 
2.47.3


