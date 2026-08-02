Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A327C55171
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 13:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWiS-0003fV-Mj; Sun, 02 Aug 2026 09:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wqWiO-0003eX-2V
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 09:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wqWiM-0002wE-Cf
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 09:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785679133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59CkK+F73vfPSocFJQz/NNuH2cbrOatJZOUKvDr9AI0=;
 b=LocporsihnNo1Mu6qZy96+H6UUD9ZsXFCqOJYRrjPC+1pMi5DXQGYL3Hc+LtRczeLkdGxc
 AhNTwikjhYRe+Cb0bYh6/qlD5aCXrxhxzQhp9oUcEU6lSi3HlBJ+e/8wIyQw62WMGwawxX
 OtR1ExU270t2QEEJwQ62FbBmfYUh3+8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-7a25NvP3OnyV8a1HPefFYA-1; Sun,
 02 Aug 2026 09:58:52 -0400
X-MC-Unique: 7a25NvP3OnyV8a1HPefFYA-1
X-Mimecast-MFC-AGG-ID: 7a25NvP3OnyV8a1HPefFYA_1785679131
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DFB019560B2; Sun,  2 Aug 2026 13:58:51 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 117B430002E9; Sun,  2 Aug 2026 13:58:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Tycho Andersen (AMD)" <tycho@kernel.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/2] hw/vfio: Fix liveness check in vfio_connect_kvm_msi_virq()
Date: Sun,  2 Aug 2026 15:58:45 +0200
Message-ID: <20260802135846.328866-2-clg@redhat.com>
In-Reply-To: <20260802135846.328866-1-clg@redhat.com>
References: <20260802135846.328866-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/vfio/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 380dd8c15f8d5bb98b725075978eef2e4e1e6c2d..b5280c3d2a366cd7cff4069936858ac651afeb6d 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -589,7 +589,7 @@ static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
 {
     const char *name = "kvm_interrupt";
 
-    if (vector->virq < 0) {
+    if (!vector->use || vector->virq < 0) {
         return;
     }
 
-- 
2.55.0


