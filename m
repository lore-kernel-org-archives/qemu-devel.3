Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705E9C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 01:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJMU-0001Ll-Kv; Sun, 23 Aug 2026 21:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMO-0001Ho-AR; Sun, 23 Aug 2026 21:20:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMK-0003Vs-Gy; Sun, 23 Aug 2026 21:20:23 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67NNt1FC4056749; Mon, 24 Aug 2026 01:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=clxy8
 VJLIb7ZVJZkEiuc8N2CQZhizNUvRA7//cEUtk4=; b=hvsHAuMhUGs6xaYlqVxp/
 bo5JnIHFTW1HpVlJmyaHv30W0b6+NG/pTtZ7S2WHEsBeRMfPDwiOs/eB5p6H8/vW
 2TDcJQfJ0hcXSSxCc5MMecZAUQGcYYkm+QWUTM9WwL4rlcrRMOGDze/sBUHVcglu
 C5rB/ZccJHTjE3kNE1sPg4LF/iKWWZBWZAgQ1MSMcI3T6GabaUerFmEgZL5/IUjw
 zmEfWDRWRLxGoKSbKDl+RqHEYG+E5jMxLP5BaPE97u4UcHp/UsMGT59rawmPPECX
 cC+ulxmbQ5VTaLqSG0W9Oqc9bafXSnG+Q9DqM1+tC5zJzNZ8aOOX8vCxTxvNPIGH
 A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g72j1sdhp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:20:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67O1FUje013312; Mon, 24 Aug 2026 01:20:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kh6xne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:20:01 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1JmVx024683;
 Mon, 24 Aug 2026 01:20:00 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4g84kh6xgy-5; Mon, 24 Aug 2026 01:20:00 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, mjrosato@linux.ibm.com,
 alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, joe.jin@oracle.com
Subject: [PATCH 4/8] hw/acpi/pcihp: Add forced slot unplug helper
Date: Sun, 23 Aug 2026 18:13:34 -0700
Message-ID: <20260824011420.752806-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260824011420.752806-1-dongli.zhang@oracle.com>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608240009
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfX2FZAv+NEUzMh
 0/f+D6S5WYim0n+8BmCp6KjrBXbs+jJMsdc5T6R3e9Xkl2pF6lgcmCWIyomY8ag7ITGJfRjgbmp
 GNrmiT0ppLxwZz8+mxz5cpK1saXK0NOosQmGm/EqiHgS0Sx5vbG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfXyJNsWrGl5CgZ
 2HDfYy7qKdHFHQqmRLTgn/EHqM17beE4ci0yr9qKKO/1ZB5eY19THVJurYZY62rst7Szl9uDbe0
 O477WhCm610LcWZEDH3mnTid139r/318CtQalmAfQB3qoaYddB+FiGMcjeWJBdnndIebrZemEG/
 kAMmVRrxn7HvSKKQBAlzgSzdybZU3ZXh0Jd4DBwiNMsAxaQyWSovQB8T7Mxxj36234cIp2xZSyE
 UslijqD6FqtBW2ZhzES7idcXNlyuUA23wSN/hzJTO1ZXKypghjuV0YDKQr9K6k6O2SSOtJT7x62
 cYjn8fxIrQalceoRiIY8Ocj6VGib1LfLnygWMyhrRXPkPZ8DSDrDjQj21f8OOpK8wkjVBncSnJ8
 UZLpdXFJzwaI5KPf2giTtoOIheR5XxKK0RXjRfF0xIfp8pr5+PIgq5NCGPrDG714LQOpzwtwvcA
 egfsm6g3eE+pDoR3WVl6fNz7/uPHVGPiayaIflXU=
X-Proofpoint-GUID: Cx5bsTKMuR6dct4cv0ju6y6bw1dVa-YM
X-Authority-Analysis: v=2.4 cv=Wek8rUhX c=1 sm=1 tr=0 ts=6a8b9c41 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=ux9k6O4l50MFplsCWjgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-ORIG-GUID: Cx5bsTKMuR6dct4cv0ju6y6bw1dVa-YM
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Add acpi_pcihp_device_force_unplug_cb() to complete PCI slot removal
through the existing ACPI PCI hotplug eject path.

Forced unplug intentionally does not introduce a separate teardown
sequence. It lets management trigger the same slot completion helper that
is already reachable when the guest writes the ACPI EJ register.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/acpi/acpi-pci-hotplug-stub.c |  6 ++++++
 hw/acpi/pcihp.c                 | 17 +++++++++++++++++
 include/hw/acpi/pcihp.h         |  3 +++
 3 files changed, 26 insertions(+)

diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index d58ea726a8..9451a45c0b 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -30,6 +30,12 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 {
 }
 
+void acpi_pcihp_device_force_unplug_cb(HotplugHandler *hotplug_dev,
+                                       AcpiPciHpState *s, DeviceState *dev,
+                                       Error **errp)
+{
+}
+
 void acpi_pcihp_reset(AcpiPciHpState *s)
 {
 }
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..7a1f2b873a 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -367,6 +367,23 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     acpi_send_event(DEVICE(hotplug_dev), ACPI_PCI_HOTPLUG_STATUS);
 }
 
+void acpi_pcihp_device_force_unplug_cb(HotplugHandler *hotplug_dev,
+                                       AcpiPciHpState *s, DeviceState *dev,
+                                       Error **errp)
+{
+    PCIDevice *pdev = PCI_DEVICE(dev);
+    int slot = PCI_SLOT(pdev->devfn);
+    int bsel = acpi_pcihp_get_bsel(pci_get_bus(pdev));
+
+    if (bsel < 0) {
+        error_setg(errp, "Unsupported bus. Bus doesn't have property '"
+                   ACPI_PCIHP_PROP_BSEL "' set");
+        return;
+    }
+
+    acpi_pcihp_eject_slot(s, bsel, 1U << slot);
+}
+
 bool acpi_pcihp_is_hotpluggable_bus(AcpiPciHpState *s, BusState *bus)
 {
     Object *o = OBJECT(bus->parent);
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index efce5fd2e1..13c131b8e8 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -75,6 +75,9 @@ void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
 void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp);
+void acpi_pcihp_device_force_unplug_cb(HotplugHandler *hotplug_dev,
+                                       AcpiPciHpState *s, DeviceState *dev,
+                                       Error **errp);
 
 void build_acpi_pci_hotplug(Aml *table, AmlRegionSpace rs, uint64_t pcihp_addr);
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
-- 
2.43.5


