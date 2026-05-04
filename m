Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11283CD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:01:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtqO-00051K-Ob; Mon, 04 May 2026 10:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqI-0004x3-JX; Mon, 04 May 2026 10:00:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqF-0002Mn-80; Mon, 04 May 2026 10:00:14 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448faRd1404885; Mon, 4 May 2026 14:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=WTXv6ggNw4k3/KEZXtYbRHF2tUimvN8yb9zVOXhfW0E=; b=
 RZBklUEb1ZzQfn4+LqesIAxUiWkSn1bCXVU3SFq6rvOdBMwWMLzMvh72OYbFb/xQ
 Ek92gB33+fXCeVx1olOTc+Kf507XjHZL9hvhyUWjJNFsdFFf2zwnlI5wDp/J1wN0
 csePVLrDIkVCzZ3mf6WARUvESytWN1R9Occ2wG5ZD32uKqHp78zgS4XbcjiwABLc
 sq1EjI37S5xTLHTXaL0Owrtnw3AMG25JU7wIY3KKL/PdhxfXssO3yPoHvMj6Vixg
 1eumsKcSn4z3/eAK09wcSMEn/yspvMwmI50eRCdD/qMPctGZ9chTi4IdDtfsllPl
 Jf7RhmTfG2y6DPoKO3RsXQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9eptpxv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644DuT9d014253; Mon, 4 May 2026 14:00:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5adk967-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 13:59:59 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 644Dxvoe027094;
 Mon, 4 May 2026 13:59:59 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5adk954-2; Mon, 04 May 2026 13:59:59 +0000 (GMT)
From: Karolina Stolarek <karolina.stolarek@oracle.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH 1/5] scsi: Split SCSIBusInfo struct
Date: Mon,  4 May 2026 13:59:40 +0000
Message-ID: <076717370213882c79eaebf790ddc4ee3892055c.1777890280.git.karolina.stolarek@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1777890280.git.karolina.stolarek@oracle.com>
References: <cover.1777890280.git.karolina.stolarek@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040145
X-Proofpoint-ORIG-GUID: p7U5-te_aj2er5mQjBAS48YQyWvCHGtE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NSBTYWx0ZWRfXwjjhk3lT6VbU
 9glICHhB52Nocyo1x3qcG0tlhPC54R4nOVOs3xeFzDwBzUnhr26zyS5KAQdcOpS6mDtXZ/qEERL
 ys9vbvBRkWA8PWe03MGS0vayPmU5PrNKfQLafoO74maZiYg3IpfIIER0v7ZmsC+oYAdC5toeK5C
 hfz6d2q684+Kwfv7e+tHuaIYGdncerG8gfwbLFWTCCEUOfUZe+gl1pto/S2lJwH2HiKvYYJBTXX
 dJucyfKd2NuYanmuAYgkxy+dBzhH3+ikLec91s6EVB8XjfNCxch8dpe5dCck3rMVbAdmsmpKrta
 eeCVOM8wEggX6Ro9F4vtX93B6L/fdj/gyKQnyvUcMNlJg+Hj0w2elFlcKVOpeR8JYL+Gva96f09
 oM6rDxzHk5wdAOMGMo+Y+7CtVftjbOzGnwrx0isZi2bHbOEUQ+5KfyUAfLgb66EaLoMKF5KFIv4
 M5WXw5LpqJmwhubsTrtZfOykEgt//NKULczL2VqM=
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=69f8a661 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8
 a=yPCof4ZbAAAA:8 a=SZ3BYSetAXTqLoVbm0IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:12306
X-Proofpoint-GUID: p7U5-te_aj2er5mQjBAS48YQyWvCHGtE
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=karolina.stolarek@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Extract information about the SCSI bus capabilities
into a dedicated struct SCSIBusConfig and keep bus
callbacks in the existing struct. Update
scsi_bus_init(_named) and their calling sites to
reflect that change.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-block@nongnu.org
Cc: qemu-ppc@nongnu.org
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
---
 hw/scsi/esp-pci.c            |  7 +++++--
 hw/scsi/esp.c                |  7 +++++--
 hw/scsi/lasi_ncr710.c        |  6 ++++--
 hw/scsi/lsi53c895a.c         |  6 ++++--
 hw/scsi/megasas.c            |  7 +++++--
 hw/scsi/mptsas.c             |  7 +++++--
 hw/scsi/ncr53c710.c          |  6 ++++--
 hw/scsi/scsi-bus.c           | 18 ++++++++++--------
 hw/scsi/scsi-disk.c          |  2 +-
 hw/scsi/spapr_vscsi.c        |  7 +++++--
 hw/scsi/virtio-scsi.c        |  7 +++++--
 hw/scsi/vmw_pvscsi.c         |  7 +++++--
 hw/ufs/lu.c                  |  8 +++++---
 hw/usb/dev-storage-bot.c     |  7 +++++--
 hw/usb/dev-storage-classic.c |  6 ++++--
 hw/usb/dev-uas.c             |  7 +++++--
 include/hw/scsi/scsi.h       | 18 +++++++++++++-----
 17 files changed, 90 insertions(+), 43 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index b31ccdbecc..34a095b73f 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -373,11 +373,13 @@ static const VMStateDescription vmstate_esp_pci_scsi = {
     }
 };
 
-static const struct SCSIBusInfo esp_pci_scsi_info = {
+static const struct SCSIBusConfig esp_pci_scsi_config = {
     .tcq = false,
     .max_target = ESP_MAX_DEVS,
     .max_lun = 7,
+};
 
+static const struct SCSIBusInfo esp_pci_scsi_info = {
     .transfer_data = esp_transfer_data,
     .complete = esp_command_complete,
     .cancel = esp_request_cancelled,
@@ -409,7 +411,8 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
     s->irq = qemu_allocate_irq(esp_irq_handler, pci, 0);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info,
+                  &esp_pci_scsi_config);
 }
 
 static void esp_pci_scsi_exit(PCIDevice *d)
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 933271431b..851af4d9fa 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1558,11 +1558,13 @@ static const MemoryRegionOps sysbus_esp_pdma_ops = {
     .impl.max_access_size = 2,
 };
 
-static const struct SCSIBusInfo esp_scsi_info = {
+static const struct SCSIBusConfig esp_scsi_config = {
     .tcq = false,
     .max_target = ESP_MAX_DEVS,
     .max_lun = 7,
+};
 
+static const struct SCSIBusInfo esp_scsi_info = {
     .load_request = esp_load_request,
     .transfer_data = esp_transfer_data,
     .complete = esp_command_complete,
@@ -1608,7 +1610,8 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), dev, &esp_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), dev, &esp_scsi_info,
+                  &esp_scsi_config);
 }
 
 static void sysbus_esp_hard_reset(DeviceState *dev)
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 4fde2265b5..7abc92b0bb 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -135,11 +135,13 @@ static void lasi_ncr710_command_complete(SCSIRequest *req, size_t resid)
     ncr710_transfer_data(req, len);
 }
 
-static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
+static const struct SCSIBusConfig lasi_ncr710_scsi_config = {
     .tcq = true,
     .max_target = 8,
     .max_lun = 8,  /* full LUN support */
+};
 
+static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
     .transfer_data = lasi_ncr710_transfer_data,
     .complete = lasi_ncr710_command_complete,
     .cancel = lasi_ncr710_request_cancelled,
@@ -176,7 +178,7 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
     trace_lasi_ncr710_device_realize();
 
     scsi_bus_init(&s->ncr710.bus, sizeof(s->ncr710.bus), dev,
-                  &lasi_ncr710_scsi_info);
+                  &lasi_ncr710_scsi_info, &lasi_ncr710_scsi_config);
     s->ncr710.as = &address_space_memory;
     s->ncr710.irq = s->lasi_irq;
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 54123f7757..da04f51cab 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2327,11 +2327,13 @@ static const VMStateDescription vmstate_lsi_scsi = {
     }
 };
 
-static const struct SCSIBusInfo lsi_scsi_info = {
+static const struct SCSIBusConfig lsi_scsi_config = {
     .tcq = true,
     .max_target = LSI_MAX_DEVS,
     .max_lun = 0,  /* LUN support is buggy */
+};
 
+static const struct SCSIBusInfo lsi_scsi_info = {
     .transfer_data = lsi_transfer_data,
     .complete = lsi_command_complete,
     .cancel = lsi_request_cancelled,
@@ -2383,7 +2385,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->ram_io);
     QTAILQ_INIT(&s->queue);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), d, &lsi_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, &lsi_scsi_config);
 }
 
 static void lsi_scsi_exit(PCIDevice *dev)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9e712721f8..f0824069f2 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2327,11 +2327,13 @@ static void megasas_scsi_uninit(PCIDevice *d)
     msi_uninit(d);
 }
 
-static const struct SCSIBusInfo megasas_scsi_info = {
+static const struct SCSIBusConfig megasas_scsi_config = {
     .tcq = true,
     .max_target = MFI_MAX_LD,
     .max_lun = 255,
+};
 
+static const struct SCSIBusInfo megasas_scsi_info = {
     .transfer_data = megasas_xfer_complete,
     .get_sg_list = megasas_get_sg_list,
     .complete = megasas_command_complete,
@@ -2447,7 +2449,8 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
         s->frames[i].state = s;
     }
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev), &megasas_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
+                  &megasas_scsi_info, &megasas_scsi_config);
 }
 
 static const Property megasas_properties_gen1[] = {
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index e4a7b2fee4..251ad575e8 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1259,11 +1259,13 @@ static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq)
     return req;
 }
 
-static const struct SCSIBusInfo mptsas_scsi_info = {
+static const struct SCSIBusConfig mptsas_scsi_config = {
     .tcq = true,
     .max_target = MPTSAS_NUM_PORTS,
     .max_lun = 1,
+};
 
+static const struct SCSIBusInfo mptsas_scsi_info = {
     .get_sg_list = mptsas_get_sg_list,
     .complete = mptsas_command_complete,
     .cancel = mptsas_request_cancelled,
@@ -1325,7 +1327,8 @@ static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
     s->request_bh = qemu_bh_new_guarded(mptsas_fetch_requests, s,
                                         &DEVICE(dev)->mem_reentrancy_guard);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), &dev->qdev, &mptsas_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), &dev->qdev,
+                  &mptsas_scsi_info, &mptsas_scsi_config);
 }
 
 static void mptsas_scsi_uninit(PCIDevice *dev)
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84..ba92870d9a 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2265,11 +2265,13 @@ static void ncr710_device_reset(DeviceState *dev)
     ncr710_soft_reset(s);
 }
 
-static const struct SCSIBusInfo ncr710_scsi_info = {
+static const struct SCSIBusConfig ncr710_scsi_config = {
     .tcq = true,
     .max_target = 8,
     .max_lun = 8,  /* Full LUN support */
+};
 
+static const struct SCSIBusInfo ncr710_scsi_info = {
     .transfer_data = ncr710_transfer_data,
     .complete = ncr710_command_complete,
     .cancel = ncr710_request_cancelled,
@@ -2415,7 +2417,7 @@ static void sysbus_ncr710_realize(DeviceState *dev, Error **errp)
 
     trace_ncr710_device_realize();
     scsi_bus_init(&s->ncr710.bus, sizeof(s->ncr710.bus), dev,
-                  &ncr710_scsi_info);
+                  &ncr710_scsi_info, &ncr710_scsi_config);
     s->ncr710.as = &address_space_memory;
 
     ncr710_scsi_fifo_init(&s->ncr710.scsi_fifo);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1a6b181b9d..b195007617 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -265,11 +265,13 @@ void scsi_device_unit_attention_reported(SCSIDevice *s)
 
 /* Create a scsi bus, and attach devices to it.  */
 void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
-                         const SCSIBusInfo *info, const char *bus_name)
+                         const SCSIBusInfo *info, const SCSIBusConfig *config,
+                         const char *bus_name)
 {
     qbus_init(bus, bus_size, TYPE_SCSI_BUS, host, bus_name);
     bus->busnr = next_scsi_bus++;
     bus->info = info;
+    bus->config = config;
     qbus_set_bus_hotplug_handler(BUS(bus));
 }
 
@@ -336,15 +338,15 @@ static bool scsi_bus_check_address(BusState *qbus, DeviceState *qdev, Error **er
     SCSIDevice *dev = SCSI_DEVICE(qdev);
     SCSIBus *bus = SCSI_BUS(qbus);
 
-    if (dev->channel > bus->info->max_channel) {
+    if (dev->channel > bus->config->max_channel) {
         error_setg(errp, "bad scsi channel id: %d", dev->channel);
         return false;
     }
-    if (dev->id != -1 && dev->id > bus->info->max_target) {
+    if (dev->id != -1 && dev->id > bus->config->max_target) {
         error_setg(errp, "bad scsi device id: %d", dev->id);
         return false;
     }
-    if (dev->lun != -1 && dev->lun > bus->info->max_lun) {
+    if (dev->lun != -1 && dev->lun > bus->config->max_lun) {
         error_setg(errp, "bad scsi device lun: %d", dev->lun);
         return false;
     }
@@ -374,7 +376,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         }
         do {
             is_free = scsi_bus_is_address_free(bus, dev->channel, ++id, dev->lun, NULL);
-        } while (!is_free && id < bus->info->max_target);
+        } while (!is_free && id < bus->config->max_target);
         if (!is_free) {
             error_setg(errp, "no free target");
             return;
@@ -384,7 +386,7 @@ static void scsi_qdev_realize(DeviceState *qdev, Error **errp)
         int lun = -1;
         do {
             is_free = scsi_bus_is_address_free(bus, dev->channel, dev->id, ++lun, NULL);
-        } while (!is_free && lun < bus->info->max_lun);
+        } while (!is_free && lun < bus->config->max_lun);
         if (!is_free) {
             error_setg(errp, "no free lun");
             return;
@@ -493,7 +495,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
     };
 
     loc_push_none(&loc);
-    for (unit = 0; unit <= bus->info->max_target; unit++) {
+    for (unit = 0; unit <= bus->config->max_target; unit++) {
         dinfo = drive_get(IF_SCSI, bus->busnr, unit);
         if (dinfo == NULL) {
             continue;
@@ -700,7 +702,7 @@ static bool scsi_target_emulate_inquiry(SCSITargetReq *r)
         r->buf[2] = 5; /* Version */
         r->buf[3] = 2 | 0x10; /* HiSup, response data format */
         r->buf[4] = r->len - 5; /* Additional Length = (Len - 1) - 4 */
-        r->buf[7] = 0x10 | (r->req.bus->info->tcq ? 0x02 : 0); /* Sync, TCQ.  */
+        r->buf[7] = 0x10 | (r->req.bus->config->tcq ? 0x02 : 0); /* Sync, TCQ.  */
         memcpy(&r->buf[8], "QEMU    ", 8);
         memcpy(&r->buf[16], "QEMU TARGET     ", 16);
         pstrcpy((char *) &r->buf[32], 4, QEMU_HW_VERSION);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 5ba5b46c4f..8eb38b3816 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -859,7 +859,7 @@ static int scsi_disk_emulate_inquiry(SCSIRequest *req, uint8_t *outbuf)
     }
 
     /* Sync data transfer and TCQ.  */
-    outbuf[7] = 0x10 | (req->bus->info->tcq ? 0x02 : 0);
+    outbuf[7] = 0x10 | (req->bus->config->tcq ? 0x02 : 0);
     return buflen;
 }
 
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..f04dbc16c6 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1195,12 +1195,14 @@ static int vscsi_do_crq(struct SpaprVioDevice *dev, uint8_t *crq_data)
     return 0;
 }
 
-static const struct SCSIBusInfo vscsi_scsi_info = {
+static const struct SCSIBusConfig vscsi_scsi_config = {
     .tcq = true,
     .max_channel = 7, /* logical unit addressing format */
     .max_target = 63,
     .max_lun = 31,
+};
 
+static const struct SCSIBusInfo vscsi_scsi_info = {
     .transfer_data = vscsi_transfer_data,
     .complete = vscsi_command_complete,
     .cancel = vscsi_request_cancelled,
@@ -1225,7 +1227,8 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
 
     dev->crq.SendFunc = vscsi_do_crq;
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev), &vscsi_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
+                  &vscsi_scsi_info, &vscsi_scsi_config);
 
     /* ibmvscsi SCSI bus does not allow hotplug. */
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 6c73768011..f3062c08bf 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1264,12 +1264,14 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
     }
 }
 
-static struct SCSIBusInfo virtio_scsi_scsi_info = {
+static struct SCSIBusConfig virtio_scsi_scsi_config = {
     .tcq = true,
     .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
     .max_target = VIRTIO_SCSI_MAX_TARGET,
     .max_lun = VIRTIO_SCSI_MAX_LUN,
+};
 
+static const struct SCSIBusInfo virtio_scsi_scsi_info = {
     .complete = virtio_scsi_command_complete,
     .fail = virtio_scsi_command_failed,
     .cancel = virtio_scsi_request_cancelled,
@@ -1342,7 +1344,8 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     }
 
     scsi_bus_init_named(&s->bus, sizeof(s->bus), dev,
-                       &virtio_scsi_scsi_info, vdev->bus_name);
+                        &virtio_scsi_scsi_info, &virtio_scsi_scsi_config,
+                        vdev->bus_name);
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev));
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 11ae6b9b74..e1310f20eb 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1126,12 +1126,14 @@ static const MemoryRegionOps pvscsi_ops = {
         },
 };
 
-static const struct SCSIBusInfo pvscsi_scsi_info = {
+static const struct SCSIBusConfig pvscsi_scsi_config = {
         .tcq = true,
         .max_target = PVSCSI_MAX_DEVS,
         .max_channel = 0,
         .max_lun = 0,
+};
 
+static const struct SCSIBusInfo pvscsi_scsi_info = {
         .get_sg_list = pvscsi_get_sg_list,
         .complete = pvscsi_command_complete,
         .cancel = pvscsi_request_cancelled,
@@ -1171,7 +1173,8 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     s->completion_worker = qemu_bh_new_guarded(pvscsi_process_completion_queue, s,
                                                &DEVICE(pci_dev)->mem_reentrancy_guard);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(pci_dev), &pvscsi_scsi_info);
+    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
+                  &pvscsi_scsi_info, &pvscsi_scsi_config);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s));
     pvscsi_reset_state(s);
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 3f3c9589ce..297b0d95f8 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -79,13 +79,14 @@ static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
     UfsRequest *req = scsi_req->hba_private;
     return req->sg;
 }
-
-static const struct SCSIBusInfo ufs_scsi_info = {
+static const struct SCSIBusConfig ufs_scsi_config = {
     .tcq = true,
     .max_target = 0,
     .max_lun = UFS_MAX_LUS,
     .max_channel = 0,
+};
 
+static const struct SCSIBusInfo ufs_scsi_info = {
     .get_sg_list = ufs_get_sg_list,
     .complete = ufs_scsi_command_complete,
 };
@@ -344,7 +345,8 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
 {
     DeviceState *scsi_dev;
 
-    scsi_bus_init(&lu->bus, sizeof(lu->bus), DEVICE(lu), &ufs_scsi_info);
+    scsi_bus_init(&lu->bus, sizeof(lu->bus), DEVICE(lu),
+                  &ufs_scsi_info, &ufs_scsi_config);
 
     blk_ref(blk);
     blk_detach_dev(blk, DEVICE(lu));
diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index a7f8d80c17..91e6588e29 100644
--- a/hw/usb/dev-storage-bot.c
+++ b/hw/usb/dev-storage-bot.c
@@ -13,11 +13,13 @@
 #include "hw/usb/desc.h"
 #include "hw/usb/msd.h"
 
-static const struct SCSIBusInfo usb_msd_scsi_info_bot = {
+static const struct SCSIBusConfig usb_msd_scsi_config_bot = {
     .tcq = false,
     .max_target = 0,
     .max_lun = 15,
+};
 
+static const struct SCSIBusInfo usb_msd_scsi_info_bot = {
     .transfer_data = usb_msd_transfer_data,
     .complete = usb_msd_command_complete,
     .cancel = usb_msd_request_cancelled,
@@ -36,7 +38,8 @@ static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
         s->dev.auto_attach = 0;
     }
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev), &usb_msd_scsi_info_bot);
+    scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
+                  &usb_msd_scsi_info_bot, &usb_msd_scsi_config_bot);
     usb_msd_handle_reset(dev);
 }
 
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 977151c4a0..76e176dc20 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -16,11 +16,13 @@
 #include "system/system.h"
 #include "system/block-backend.h"
 
-static const struct SCSIBusInfo usb_msd_scsi_info_storage = {
+static const struct SCSIBusConfig usb_msd_scsi_config_storage = {
     .tcq = false,
     .max_target = 0,
     .max_lun = 0,
+};
 
+static const struct SCSIBusInfo usb_msd_scsi_info_storage = {
     .transfer_data = usb_msd_transfer_data,
     .complete = usb_msd_command_complete,
     .cancel = usb_msd_request_cancelled,
@@ -56,7 +58,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
     usb_desc_init(dev);
     dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
-                 &usb_msd_scsi_info_storage);
+                  &usb_msd_scsi_info_storage, &usb_msd_scsi_config_storage);
     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
                                          &s->conf, dev->serial, errp);
     blk_unref(blk);
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 8576dfec96..de26114f10 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -618,11 +618,13 @@ static void usb_uas_scsi_request_cancelled(SCSIRequest *r)
     scsi_req_unref(req->req);
 }
 
-static const struct SCSIBusInfo usb_uas_scsi_info = {
+static const struct SCSIBusConfig usb_uas_scsi_config = {
     .tcq = true,
     .max_target = 0,
     .max_lun = 255,
+};
 
+static const struct SCSIBusInfo usb_uas_scsi_info = {
     .transfer_data = usb_uas_scsi_transfer_data,
     .complete = usb_uas_scsi_command_complete,
     .cancel = usb_uas_scsi_request_cancelled,
@@ -939,7 +941,8 @@ static void usb_uas_realize(USBDevice *dev, Error **errp)
                                          &d->mem_reentrancy_guard);
 
     dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
-    scsi_bus_init(&uas->bus, sizeof(uas->bus), DEVICE(dev), &usb_uas_scsi_info);
+    scsi_bus_init(&uas->bus, sizeof(uas->bus), DEVICE(dev),
+                  &usb_uas_scsi_info, &usb_uas_scsi_config);
 }
 
 static const VMStateDescription vmstate_usb_uas = {
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index a3e246dbd9..53475effb8 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -14,6 +14,7 @@
 #define TYPE_SCSI_BUS "SCSI"
 OBJECT_DECLARE_SIMPLE_TYPE(SCSIBus, SCSI_BUS)
 
+typedef struct SCSIBusConfig SCSIBusConfig;
 typedef struct SCSIBusInfo SCSIBusInfo;
 typedef struct SCSIDevice SCSIDevice;
 typedef struct SCSIRequest SCSIRequest;
@@ -137,9 +138,12 @@ struct SCSIReqOps {
     void (*load_request)(QEMUFile *f, SCSIRequest *req);
 };
 
-struct SCSIBusInfo {
+struct SCSIBusConfig {
     int tcq;
     int max_channel, max_target, max_lun;
+};
+
+struct SCSIBusInfo {
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      size_t buf_len, void *hba_private);
     void (*transfer_data)(SCSIRequest *req, uint32_t arg);
@@ -170,6 +174,7 @@ struct SCSIBus {
 
     SCSISense unit_attention;
     const SCSIBusInfo *info;
+    const SCSIBusConfig *config;
 
     int drain_count; /* protected by BQL */
 };
@@ -179,7 +184,8 @@ struct SCSIBus {
  * @bus: SCSIBus object to initialize
  * @bus_size: size of @bus object
  * @host: Device which owns the bus (generally the SCSI controller)
- * @info: structure defining callbacks etc for the controller
+ * @info: structure defining callbacks for the controller
+ * @config: structure defining bus params
  * @bus_name: Name to use for this bus
  *
  * This in-place initializes @bus as a new SCSI bus with a name
@@ -189,7 +195,8 @@ struct SCSIBus {
  * should use scsi_bus_init() instead.
  */
 void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
-                         const SCSIBusInfo *info, const char *bus_name);
+                         const SCSIBusInfo *info, const SCSIBusConfig *config,
+                         const char *bus_name);
 
 /**
  * scsi_bus_init: Initialize a SCSI bus
@@ -198,9 +205,10 @@ void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
  * an automatically generated unique name.
  */
 static inline void scsi_bus_init(SCSIBus *bus, size_t bus_size,
-                                 DeviceState *host, const SCSIBusInfo *info)
+                                 DeviceState *host, const SCSIBusInfo *info,
+                                 const SCSIBusConfig *config)
 {
-    scsi_bus_init_named(bus, bus_size, host, info, NULL);
+    scsi_bus_init_named(bus, bus_size, host, info, config, NULL);
 }
 
 static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
-- 
2.47.1


