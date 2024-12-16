Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05A9E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNE0y-0003kn-PF; Mon, 16 Dec 2024 11:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tNE0x-0003kb-JB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:32:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tNE0v-0001Ks-SF
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:32:11 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGE0T2r012254;
 Mon, 16 Dec 2024 16:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=+b6DHOM4M+E7Gt7j9FYGubUSt/oikmSLmfYO3oc6E
 gc=; b=bFlsjQd0n7t5fE5zRCN8KC3ppFvp/YkijCn4Wk2ye86JGsXBGWxdX0QEy
 AUcynww6Pr7rif4D165D/Vy5NDsQnN1CLPqEKxCdR8NHj9OkMLkH40GoVzPSRKLz
 ei73UN8Z9Wn9u54+iffSfaSjKmsy/4o4q3kBUkwhDXVPkRULuUGtfa2lfr0+sMpD
 7/K04K84t+hx1Hftfj8zcyzXM4IWWDvF9zAGtbAOkVSRlJ2SNnsRbMpdcMcsXbwB
 THmVPT10t7+gxV+q4zCLWwqWApmOHRkzuYdeM/dsW83hAVBURtlvNVNab48omBk9
 ZMCCG4Wni9w/4bAULVkqLZq047R8A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb3f6g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 16:32:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGGVxjO031204;
 Mon, 16 Dec 2024 16:31:59 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpb3f6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 16:31:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGGUV6b029728;
 Mon, 16 Dec 2024 16:31:58 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hmbsex7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Dec 2024 16:31:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BGGVv8c25428672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 16:31:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C002B58055;
 Mon, 16 Dec 2024 16:31:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F4615804B;
 Mon, 16 Dec 2024 16:31:56 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.67.86.249])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with SMTP;
 Mon, 16 Dec 2024 16:31:56 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
 id E3296D9485; Mon, 16 Dec 2024 10:31:53 -0600 (CST)
From: Reza Arbab <arbab@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH] virtio-balloon-pci: Allow setting nvectors,
 so we can use MSI-X
Date: Mon, 16 Dec 2024 10:31:25 -0600
Message-ID: <20241216163125.438156-1-arbab@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pBCPaWAn6W4qaeecn-wdihSFcu-2OU3O
X-Proofpoint-GUID: 7NFiIfgNXHVUYM149Vga1uA0jKto_aeL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160137
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.13, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Most virtio-pci devices allow MSI-X. Add it to virtio-balloon-pci, but
only enable it in new machine types, so we don't break migration of
existing machine types between different qemu versions.

This copies what was done for virtio-rng-pci in:
9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-=
X")
bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vect=
ors")

Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
 hw/core/machine.c              |  6 +++++-
 hw/virtio/virtio-balloon-pci.c | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index e6900b43efa2..db59c7771ec4 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,7 +36,11 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
=20
-GlobalProperty hw_compat_9_2[] =3D {};
+GlobalProperty hw_compat_9_2[] =3D {
+    { "virtio-balloon-pci", "vectors", "0" },
+    { "virtio-balloon-pci-transitional", "vectors", "0" },
+    { "virtio-balloon-pci-non-transitional", "vectors", "0" },
+};
 const size_t hw_compat_9_2_len =3D G_N_ELEMENTS(hw_compat_9_2);
=20
 GlobalProperty hw_compat_9_1[] =3D {
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pc=
i.c
index ce2645ba7187..1c2b071eff0c 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -35,11 +35,23 @@ struct VirtIOBalloonPCI {
     VirtIOBalloon vdev;
 };
=20
+static Property virtio_balloon_properties[] =3D {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error *=
*errp)
 {
     VirtIOBalloonPCI *dev =3D VIRTIO_BALLOON_PCI(vpci_dev);
     DeviceState *vdev =3D DEVICE(&dev->vdev);
=20
+    if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors =3D 2;
+    }
+
     vpci_dev->class_code =3D PCI_CLASS_OTHERS;
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
@@ -55,6 +67,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *=
klass, void *data)
     pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_BALLOON;
     pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
     pcidev_k->class_id =3D PCI_CLASS_OTHERS;
+    device_class_set_props(dc, virtio_balloon_properties);
 }
=20
 static void virtio_balloon_pci_instance_init(Object *obj)

base-commit: ca80a5d026a280762e0772615f1988db542b3ade
--=20
2.47.1


