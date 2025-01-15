Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFA5C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 16:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY633-0003vY-7D; Wed, 15 Jan 2025 11:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tY62l-0003rr-4G
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:15:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arbab@linux.ibm.com>)
 id 1tY62j-0006iO-C7
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 11:14:58 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGEkZN017005;
 Wed, 15 Jan 2025 16:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=LQL5QF1J9vNc5KIQO/meinNDsBdBUDtXlMAkpoDuL
 oE=; b=kNDjLIWfV5U3gQR8T1K034S9Dbnk8M2tLQtSSXKYsR2xYDB+X3ur1kKAw
 REztJISwbEqLeaJ/VYPTT5PgjMFFgh7SM0GTAQ+Nexrg+nvp4D67uq0Lnr/Dgp9l
 Kj9KG+Oc4bRVqz4wMxvasMDuFaKOU2X0d0x0yM7OmSRiZjUmHQVXIHPqJOgbFovw
 7lg0zIRJC8iBWjvDq0ZAWbeNYELs5/gJr7fXx2vbCNYdaOksaFbCB7Q4Gb1hKfNX
 DS6rJlNTW10DSCuhK++fI4OqtCflYGOso7Cmt63AYF3jkUEMtiCtEu9hNDTP2jp5
 fU3x8qQDwPZsDLQ4lhMFWSG2pkhVg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbu7w8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 16:14:49 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FGEmJJ017160;
 Wed, 15 Jan 2025 16:14:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbu7uk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 16:14:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FDxiEq007462;
 Wed, 15 Jan 2025 16:14:36 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yn9791-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jan 2025 16:14:36 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50FGEZCP39453116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jan 2025 16:14:35 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AD8C58060;
 Wed, 15 Jan 2025 16:14:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A7285803F;
 Wed, 15 Jan 2025 16:14:35 +0000 (GMT)
Received: from arbab-laptop.localdomain (unknown [9.53.178.221])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jan 2025 16:14:35 +0000 (GMT)
Received: by arbab-laptop.localdomain (Postfix, from userid 152845)
 id 960F54C7844; Wed, 15 Jan 2025 10:14:34 -0600 (CST)
From: Reza Arbab <arbab@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2] virtio-balloon-pci: Allow setting nvectors,
 so we can use MSI-X
Date: Wed, 15 Jan 2025 10:14:25 -0600
Message-ID: <20250115161425.246348-1-arbab@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3yCZSteNcQOXE6-kF7ZFC1yuksPodcbP
X-Proofpoint-ORIG-GUID: lEkhzQ-Db1mH0J8VfrmIxGast3tsiEkd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_07,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501150119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=arbab@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.793, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
9ea02e8f1306 ("virtio-rng-pci: Allow setting nvectors, so we can use MSI-X")
bad9c5a5166f ("virtio-rng-pci: fix migration compat for vectors")
62bdb8871512 ("virtio-rng-pci: fix transitional migration compat for vectors")

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
v2:
- Remove DEFINE_PROP_END_OF_LIST()
- Declare virtio_balloon_properties as const

 hw/core/machine.c              |  3 +++
 hw/virtio/virtio-balloon-pci.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c23b39949649..8f396ef8035a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,9 @@
 
 GlobalProperty hw_compat_9_2[] = {
     {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+    { "virtio-balloon-pci", "vectors", "0" },
+    { "virtio-balloon-pci-transitional", "vectors", "0" },
+    { "virtio-balloon-pci-non-transitional", "vectors", "0" },
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/hw/virtio/virtio-balloon-pci.c b/hw/virtio/virtio-balloon-pci.c
index ce2645ba7187..db7e1cb47537 100644
--- a/hw/virtio/virtio-balloon-pci.c
+++ b/hw/virtio/virtio-balloon-pci.c
@@ -35,11 +35,22 @@ struct VirtIOBalloonPCI {
     VirtIOBalloon vdev;
 };
 
+static const Property virtio_balloon_properties[] = {
+    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
+                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
+    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+                       DEV_NVECTORS_UNSPECIFIED),
+};
+
 static void virtio_balloon_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VirtIOBalloonPCI *dev = VIRTIO_BALLOON_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+        vpci_dev->nvectors = 2;
+    }
+
     vpci_dev->class_code = PCI_CLASS_OTHERS;
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
@@ -55,6 +66,7 @@ static void virtio_balloon_pci_class_init(ObjectClass *klass, void *data)
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BALLOON;
     pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
     pcidev_k->class_id = PCI_CLASS_OTHERS;
+    device_class_set_props(dc, virtio_balloon_properties);
 }
 
 static void virtio_balloon_pci_instance_init(Object *obj)

base-commit: 7433709a147706ad7d1956b15669279933d0f82b
-- 
2.47.1


