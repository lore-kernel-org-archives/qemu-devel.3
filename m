Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E820C5DF97
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 01:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyJMV-0001Mq-5P; Sun, 23 Aug 2026 21:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMQ-0001IV-AP; Sun, 23 Aug 2026 21:20:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wyJMK-0003Vw-IF; Sun, 23 Aug 2026 21:20:24 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O00kWL3992865; Mon, 24 Aug 2026 01:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ZkCph
 0zQMEceV1V18yZjC3gcjw4ROxQqcgj3PoAbDGw=; b=K+ppLH/PCrj/wbA/jzZyt
 bdWHWQsvBzJP3uHHw0XVLHrTgqphOE8xm6sv4c059cmQtpVO+0EohzFiC2r2t2wJ
 gbK72cj5QYQpd4zlR3Pj5JlySk2DNqIxDPow3OPvB5cyzuuO2eJCNc917BuBXFbE
 B1Hf1v3SmNbum+TIuj2ohgbbVcc5dEPwqwSFc6Bud1ubjYj0CDPxUqXZuEjuKmUS
 jmw1wUjZVY9yejj23QxQERzBShuELPBA12M1EM/r1y6o/lOa4tz4r1wUGxIU44Wx
 0MmIrv1Li2sqU2zPBS71UGJi9LiBxcq0UyzBAOGjgXb2mK5kDV477Q24t0TpV3S5
 g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g726bhdp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:20:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67O1FURi013245; Mon, 24 Aug 2026 01:20:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4g84kh6xq4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 01:20:04 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67O1JmW1024683;
 Mon, 24 Aug 2026 01:20:03 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4g84kh6xgy-6; Mon, 24 Aug 2026 01:20:03 +0000 (GMT)
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
Subject: [PATCH 5/8] hw/acpi/piix4: Support forced PCI unplug
Date: Sun, 23 Aug 2026 18:13:35 -0700
Message-ID: <20260824011420.752806-6-dongli.zhang@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=Q6niJY2a c=1 sm=1 tr=0 ts=6a8b9c44 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=sVUD1VjQnF4y5snLtUwA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13521
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfXxvMG/AodywxN
 jCyivwTyKNJb7pSvrie6I6RuCokvMF818rlPF/8bsoT0lCdzDmVzD4+NE+ApH2tNNrMR29QI5vH
 anCSfJXwMSn8z9g4yRkYBLJhEllboYQdR0mYgvtnTOI2tygxcVXlp2gXMcNjY5bdMTVdVy3XRpy
 laFF9tvkH1QdRK0yFgl/ZdEyTF158dwT7d72qSHbJhdpZhUKFap93RJxyPEeEwVvBtD2bExAJc3
 A7Kx3mGRPcsDclRFwoGTz+j1hA6geSYW8y/l98FSUO1P4W9EQc33VoswjNARv9DLmJbxvOXNwMG
 JD3psO7dHlYK+SouXuCgwMhr9MeH2LxvI6+LOvBTjJZwc/RT3Gx/aw9pHyRj+Pi1DfUMQzPLjRr
 F+54t1AGpMLhGcirKbnldfuTeZLRSmF/vvsrA+AycOv/aNGvPYM537nGfrH7CS7qtDhHT+77DU5
 YJtx4JTtE1XpJo83Aw2HghZBAnRKht72ekQZFnFs=
X-Proofpoint-GUID: BQ11WiPJKvoDJTnITlj-K1M2Dpi6kofY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDAwOSBTYWx0ZWRfX7PdpZXwEuZUR
 Kgpvj5Y7N7TTyuKSMp5OJlRcXWjHfLjfn7glgHYeRaDpIakhtEpRIbV+XwtwlegXouqk0gUb+/J
 7oNzYP0rhwchNLwIlmNs4M0BGlJHxMf85/XFZ/BF0V0dvNDxdY2C
X-Proofpoint-ORIG-GUID: BQ11WiPJKvoDJTnITlj-K1M2Dpi6kofY
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

Support forced PCI unplug for PIIX4. This enables forced removal for ACPI
PCI hotplug on i440fx machines while rejecting non-PCI devices.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/acpi/piix4.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..7cfdcb7935 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -383,6 +383,20 @@ static void piix4_device_unplug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+static void piix4_device_force_unplug_cb(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    PIIX4PMState *s = PIIX4_PM(hotplug_dev);
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
+        acpi_pcihp_device_force_unplug_cb(hotplug_dev, &s->acpi_pci_hotplug,
+                                          dev, errp);
+    } else {
+        error_setg(errp, "acpi: forced device unplug for not supported device"
+                   " type: %s", object_get_typename(OBJECT(dev)));
+    }
+}
+
 static bool piix4_is_hotpluggable_bus(HotplugHandler *hotplug_dev,
                                       BusState *bus)
 {
@@ -604,6 +618,7 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->plug = piix4_device_plug_cb;
     hc->unplug_request = piix4_device_unplug_request_cb;
     hc->unplug = piix4_device_unplug_cb;
+    hc->force_unplug = piix4_device_force_unplug_cb;
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
-- 
2.43.5


