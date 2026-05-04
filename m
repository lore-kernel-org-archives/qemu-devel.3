Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EEDCD3439
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJtqN-00050p-KV; Mon, 04 May 2026 10:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqJ-0004xl-QB; Mon, 04 May 2026 10:00:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karolina.stolarek@oracle.com>)
 id 1wJtqF-0002Ol-Rx; Mon, 04 May 2026 10:00:15 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6448fT2v1628790; Mon, 4 May 2026 14:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=EaoUPJL5UmkjOz9/H0tAjANnO5w98RqS2JjUBHYJHro=; b=
 CQWxo3PmbzNQsgWhTE+Yi+JReW/Mu7XZYcjUaLDrywigCVSgnJo/V8LCk1S5bjww
 ldPTq9D/WP1EzNBC9ezg9zrEF1K6hcR5EbJR1Q5fUpasSpkQwcnb0uHgq3jPfV+b
 rUbvy5toqn3LfsmCdbJX6IsEN8CpHj44aElU+XyFI1pLdaSFTVZJrqz2En2fw4J+
 cGVVqXaPsPmFJIXAryPsfo5HtwU9yKPox0FsLOjn6vteCPGk9FFSGKD0oPfdvGBn
 uozEKGMbVAa1Uwpn7lfWFkAtqU4EoQpCsz7xakbg2cL4vWUHFMUF/5W9Zj8UXuGf
 GTsAZf5lD3WIFnSg9FD33w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9fraqew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 644DuSGo014178; Mon, 4 May 2026 14:00:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5adk97m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 May 2026 14:00:01 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 644Dxvog027094;
 Mon, 4 May 2026 14:00:00 GMT
Received: from kstolare-e5-ol8.osdevelopmeniad.oraclevcn.com
 (kstolare-e5-ol8.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.20])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5adk954-3; Mon, 04 May 2026 14:00:00 +0000 (GMT)
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
Subject: [PATCH 2/5] scsi: Rename SCSIBusInfo to SCSIBusOps
Date: Mon,  4 May 2026 13:59:41 +0000
Message-ID: <0ec3e6b2d9a6961948eb27847898c2ea042cc533.1777890280.git.karolina.stolarek@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE0NSBTYWx0ZWRfX4m5JqUJYgp+o
 q/B8a82teFkuF99FNkN+MXJ8R/3uTypUpcE3yFRz9qjjH3WiUOBB9FKQ+2KvqZFPPaqDvMLqZtM
 BJLoOwPkNmPhxKtUF3YSeVW+wqzFwGzlZlyU/ueD6265rwH8GkpMinwdgtycJk0yFPA5EMov0Ib
 X6f4MPY+Mpt0+y3GfY2/3XSzEpLSOepUvBJhjcyMsDrKXk8KdsNFlG8XQbXXt3hP+GOXYBRDXnu
 od5Zhy9cU89ylOy0HfB3VU6+0sCMTKYFzMBDeXX8goIMcacQUFt3aQyEVdkxRIPWr2WQgDn/cPl
 GFjeBATFVJ25gPruRtWTgzBLsWzSlbRg5cWEqjDDUTpWHeLjJKRskIgpXsSOlFSy776jv0pQJWy
 b9om3C/Z5npSNj+D2zP0ux+Ebux6q3Olo2278AbViM2ccQd7IPU8zkj3TODDvLHoprbe29enIJz
 DQbFZJFQrnwi3dtiDg0nlg12Fge5mLpo0d/OkLbo=
X-Authority-Analysis: v=2.4 cv=TZ6mcxQh c=1 sm=1 tr=0 ts=69f8a662 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=hD80L64hAAAA:8 a=69wJf7TsAAAA:8
 a=yPCof4ZbAAAA:8 a=gS5mfdbYi_I4iAyqv3IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:12306
X-Proofpoint-ORIG-GUID: Lfd0ec0PYGg4IraVbI9cXD7ZGcz2pUzN
X-Proofpoint-GUID: Lfd0ec0PYGg4IraVbI9cXD7ZGcz2pUzN
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

Align the name of the structure with its actual function.
Update the checkpatch.pl script to check for SCSIBusOps
in place of SCSIBusInfo.

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
 hw/scsi/esp-pci.c            |  4 +--
 hw/scsi/esp.c                |  4 +--
 hw/scsi/lasi_ncr710.c        |  4 +--
 hw/scsi/lsi53c895a.c         |  4 +--
 hw/scsi/megasas.c            |  4 +--
 hw/scsi/mptsas.c             |  6 ++---
 hw/scsi/ncr53c710.c          |  4 +--
 hw/scsi/scsi-bus.c           | 48 ++++++++++++++++++------------------
 hw/scsi/spapr_vscsi.c        |  4 +--
 hw/scsi/virtio-scsi.c        |  4 +--
 hw/scsi/vmw_pvscsi.c         |  4 +--
 hw/ufs/lu.c                  |  4 +--
 hw/usb/dev-storage-bot.c     |  4 +--
 hw/usb/dev-storage-classic.c |  4 +--
 hw/usb/dev-uas.c             |  4 +--
 include/hw/scsi/scsi.h       | 14 +++++------
 scripts/checkpatch.pl        |  2 +-
 17 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 34a095b73f..17ed0b186d 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -379,7 +379,7 @@ static const struct SCSIBusConfig esp_pci_scsi_config = {
     .max_lun = 7,
 };
 
-static const struct SCSIBusInfo esp_pci_scsi_info = {
+static const struct SCSIBusOps esp_pci_scsi_ops = {
     .transfer_data = esp_transfer_data,
     .complete = esp_command_complete,
     .cancel = esp_request_cancelled,
@@ -411,7 +411,7 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
     s->irq = qemu_allocate_irq(esp_irq_handler, pci, 0);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info,
+    scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_ops,
                   &esp_pci_scsi_config);
 }
 
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 851af4d9fa..b928693ed2 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1564,7 +1564,7 @@ static const struct SCSIBusConfig esp_scsi_config = {
     .max_lun = 7,
 };
 
-static const struct SCSIBusInfo esp_scsi_info = {
+static const struct SCSIBusOps esp_scsi_ops = {
     .load_request = esp_load_request,
     .transfer_data = esp_transfer_data,
     .complete = esp_command_complete,
@@ -1610,7 +1610,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
 
     qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), dev, &esp_scsi_info,
+    scsi_bus_init(&s->bus, sizeof(s->bus), dev, &esp_scsi_ops,
                   &esp_scsi_config);
 }
 
diff --git a/hw/scsi/lasi_ncr710.c b/hw/scsi/lasi_ncr710.c
index 7abc92b0bb..726250b9d7 100644
--- a/hw/scsi/lasi_ncr710.c
+++ b/hw/scsi/lasi_ncr710.c
@@ -141,7 +141,7 @@ static const struct SCSIBusConfig lasi_ncr710_scsi_config = {
     .max_lun = 8,  /* full LUN support */
 };
 
-static const struct SCSIBusInfo lasi_ncr710_scsi_info = {
+static const struct SCSIBusOps lasi_ncr710_scsi_ops = {
     .transfer_data = lasi_ncr710_transfer_data,
     .complete = lasi_ncr710_command_complete,
     .cancel = lasi_ncr710_request_cancelled,
@@ -178,7 +178,7 @@ static void lasi_ncr710_realize(DeviceState *dev, Error **errp)
     trace_lasi_ncr710_device_realize();
 
     scsi_bus_init(&s->ncr710.bus, sizeof(s->ncr710.bus), dev,
-                  &lasi_ncr710_scsi_info, &lasi_ncr710_scsi_config);
+                  &lasi_ncr710_scsi_ops, &lasi_ncr710_scsi_config);
     s->ncr710.as = &address_space_memory;
     s->ncr710.irq = s->lasi_irq;
 
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index da04f51cab..2de24381f3 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2333,7 +2333,7 @@ static const struct SCSIBusConfig lsi_scsi_config = {
     .max_lun = 0,  /* LUN support is buggy */
 };
 
-static const struct SCSIBusInfo lsi_scsi_info = {
+static const struct SCSIBusOps lsi_scsi_ops = {
     .transfer_data = lsi_transfer_data,
     .complete = lsi_command_complete,
     .cancel = lsi_request_cancelled,
@@ -2385,7 +2385,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
     pci_register_bar(dev, 2, PCI_BASE_ADDRESS_SPACE_MEMORY, &s->ram_io);
     QTAILQ_INIT(&s->queue);
 
-    scsi_bus_init(&s->bus, sizeof(s->bus), d, &lsi_scsi_info, &lsi_scsi_config);
+    scsi_bus_init(&s->bus, sizeof(s->bus), d, &lsi_scsi_ops, &lsi_scsi_config);
 }
 
 static void lsi_scsi_exit(PCIDevice *dev)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index f0824069f2..11bb843c3a 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2333,7 +2333,7 @@ static const struct SCSIBusConfig megasas_scsi_config = {
     .max_lun = 255,
 };
 
-static const struct SCSIBusInfo megasas_scsi_info = {
+static const struct SCSIBusOps megasas_scsi_ops = {
     .transfer_data = megasas_xfer_complete,
     .get_sg_list = megasas_get_sg_list,
     .complete = megasas_command_complete,
@@ -2450,7 +2450,7 @@ static void megasas_scsi_realize(PCIDevice *dev, Error **errp)
     }
 
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
-                  &megasas_scsi_info, &megasas_scsi_config);
+                  &megasas_scsi_ops, &megasas_scsi_config);
 }
 
 static const Property megasas_properties_gen1[] = {
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 251ad575e8..b1b960b463 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1238,7 +1238,7 @@ static void *mptsas_load_request(QEMUFile *f, SCSIRequest *sreq)
     qemu_get_buffer(f, (unsigned char *)&req->scsi_io, sizeof(req->scsi_io));
 
     n = qemu_get_be32(f);
-    /* TODO: add a way for SCSIBusInfo's load_request to fail,
+    /* TODO: add a way for SCSIBusOps's load_request to fail,
      * and fail migration instead of asserting here.
      * This is just one thing (there are probably more) that must be
      * fixed before we can allow NDEBUG compilation.
@@ -1265,7 +1265,7 @@ static const struct SCSIBusConfig mptsas_scsi_config = {
     .max_lun = 1,
 };
 
-static const struct SCSIBusInfo mptsas_scsi_info = {
+static const struct SCSIBusOps mptsas_scsi_ops = {
     .get_sg_list = mptsas_get_sg_list,
     .complete = mptsas_command_complete,
     .cancel = mptsas_request_cancelled,
@@ -1328,7 +1328,7 @@ static void mptsas_scsi_realize(PCIDevice *dev, Error **errp)
                                         &DEVICE(dev)->mem_reentrancy_guard);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), &dev->qdev,
-                  &mptsas_scsi_info, &mptsas_scsi_config);
+                  &mptsas_scsi_ops, &mptsas_scsi_config);
 }
 
 static void mptsas_scsi_uninit(PCIDevice *dev)
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index ba92870d9a..9a4afd17e5 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2271,7 +2271,7 @@ static const struct SCSIBusConfig ncr710_scsi_config = {
     .max_lun = 8,  /* Full LUN support */
 };
 
-static const struct SCSIBusInfo ncr710_scsi_info = {
+static const struct SCSIBusOps ncr710_scsi_ops = {
     .transfer_data = ncr710_transfer_data,
     .complete = ncr710_command_complete,
     .cancel = ncr710_request_cancelled,
@@ -2417,7 +2417,7 @@ static void sysbus_ncr710_realize(DeviceState *dev, Error **errp)
 
     trace_ncr710_device_realize();
     scsi_bus_init(&s->ncr710.bus, sizeof(s->ncr710.bus), dev,
-                  &ncr710_scsi_info, &ncr710_scsi_config);
+                  &ncr710_scsi_ops, &ncr710_scsi_config);
     s->ncr710.as = &address_space_memory;
 
     ncr710_scsi_fifo_init(&s->ncr710.scsi_fifo);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index b195007617..391b279358 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -238,8 +238,8 @@ int scsi_bus_parse_cdb(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
 
     assert(cmd->len == 0);
     rc = scsi_req_parse_cdb(dev, cmd, buf, buf_len);
-    if (bus->info->parse_cdb) {
-        rc = bus->info->parse_cdb(dev, cmd, buf, buf_len, hba_private);
+    if (bus->ops->parse_cdb) {
+        rc = bus->ops->parse_cdb(dev, cmd, buf, buf_len, hba_private);
     }
     return rc;
 }
@@ -265,12 +265,12 @@ void scsi_device_unit_attention_reported(SCSIDevice *s)
 
 /* Create a scsi bus, and attach devices to it.  */
 void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
-                         const SCSIBusInfo *info, const SCSIBusConfig *config,
+                         const SCSIBusOps *ops, const SCSIBusConfig *config,
                          const char *bus_name)
 {
     qbus_init(bus, bus_size, TYPE_SCSI_BUS, host, bus_name);
     bus->busnr = next_scsi_bus++;
-    bus->info = info;
+    bus->ops = ops;
     bus->config = config;
     qbus_set_bus_hotplug_handler(BUS(bus));
 }
@@ -1007,8 +1007,8 @@ static void scsi_req_enqueue_internal(SCSIRequest *req)
 {
     assert(!req->enqueued);
     scsi_req_ref(req);
-    if (req->bus->info->get_sg_list) {
-        req->sg = req->bus->info->get_sg_list(req);
+    if (req->bus->ops->get_sg_list) {
+        req->sg = req->bus->ops->get_sg_list(req);
     } else {
         req->sg = NULL;
     }
@@ -1491,8 +1491,8 @@ void scsi_device_report_change(SCSIDevice *dev, SCSISense sense)
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, dev->qdev.parent_bus);
 
     scsi_device_set_ua(dev, sense);
-    if (bus->info->change) {
-        bus->info->change(bus, dev, sense);
+    if (bus->ops->change) {
+        bus->ops->change(bus, dev, sense);
     }
 }
 
@@ -1510,8 +1510,8 @@ void scsi_req_unref(SCSIRequest *req)
         BusState *qbus = req->dev->qdev.parent_bus;
         SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, qbus);
 
-        if (bus->info->free_request && req->hba_private) {
-            bus->info->free_request(bus, req->hba_private);
+        if (bus->ops->free_request && req->hba_private) {
+            bus->ops->free_request(bus, req->hba_private);
         }
         if (req->ops->free_req) {
             req->ops->free_req(req);
@@ -1550,7 +1550,7 @@ void scsi_req_data(SCSIRequest *req, int len)
     assert(req->cmd.mode != SCSI_XFER_NONE);
     if (!req->sg) {
         req->residual -= len;
-        req->bus->info->transfer_data(req, len);
+        req->bus->ops->transfer_data(req, len);
         return;
     }
 
@@ -1607,7 +1607,7 @@ void scsi_req_complete_failed(SCSIRequest *req, int host_status)
     assert(req->status == -1 && req->host_status == -1);
     assert(req->ops != &reqops_unit_attention);
 
-    if (!req->bus->info->fail) {
+    if (!req->bus->ops->fail) {
         status = scsi_sense_from_host_status(req->host_status, &sense);
         if (status == CHECK_CONDITION) {
             scsi_req_build_sense(req, sense);
@@ -1619,7 +1619,7 @@ void scsi_req_complete_failed(SCSIRequest *req, int host_status)
     req->host_status = host_status;
     scsi_req_ref(req);
     scsi_req_dequeue(req);
-    req->bus->info->fail(req);
+    req->bus->ops->fail(req);
 
     /* Cancelled requests might end up being completed instead of cancelled */
     notifier_list_notify(&req->cancel_notifiers, req);
@@ -1648,7 +1648,7 @@ void scsi_req_complete(SCSIRequest *req, int status)
 
     scsi_req_ref(req);
     scsi_req_dequeue(req);
-    req->bus->info->complete(req, req->residual);
+    req->bus->ops->complete(req, req->residual);
 
     /* Cancelled requests might end up being completed instead of cancelled */
     notifier_list_notify(&req->cancel_notifiers, req);
@@ -1659,8 +1659,8 @@ void scsi_req_complete(SCSIRequest *req, int status)
 void scsi_req_cancel_complete(SCSIRequest *req)
 {
     assert(req->io_canceled);
-    if (req->bus->info->cancel) {
-        req->bus->info->cancel(req);
+    if (req->bus->ops->cancel) {
+        req->bus->ops->cancel(req);
     }
     notifier_list_notify(&req->cancel_notifiers, req);
     scsi_req_unref(req);
@@ -1818,8 +1818,8 @@ void scsi_device_drained_begin(SCSIDevice *sdev)
      */
     if (bus->drain_count++ == 0) {
         trace_scsi_bus_drained_begin(bus, sdev);
-        if (bus->info->drained_begin) {
-            bus->info->drained_begin(bus);
+        if (bus->ops->drained_begin) {
+            bus->ops->drained_begin(bus);
         }
     }
 }
@@ -1836,8 +1836,8 @@ void scsi_device_drained_end(SCSIDevice *sdev)
 
     if (bus->drain_count-- == 1) {
         trace_scsi_bus_drained_end(bus, sdev);
-        if (bus->info->drained_end) {
-            bus->info->drained_end(bus);
+        if (bus->ops->drained_end) {
+            bus->ops->drained_end(bus);
         }
     }
 }
@@ -1880,8 +1880,8 @@ static void put_scsi_req(SCSIRequest *req, void *opaque)
     qemu_put_buffer(f, req->cmd.buf, sizeof(req->cmd.buf));
     qemu_put_be32s(f, &req->tag);
     qemu_put_be32s(f, &req->lun);
-    if (req->bus->info->save_request) {
-        req->bus->info->save_request(f, req);
+    if (req->bus->ops->save_request) {
+        req->bus->ops->save_request(f, req);
     }
     if (req->ops->save_request) {
         req->ops->save_request(f, req);
@@ -1920,8 +1920,8 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
          */
         req = scsi_req_new(s, tag, lun, buf, sizeof(buf), NULL);
         req->retry = (sbyte == 1);
-        if (bus->info->load_request) {
-            req->hba_private = bus->info->load_request(f, req);
+        if (bus->ops->load_request) {
+            req->hba_private = bus->ops->load_request(f, req);
         }
         if (req->ops->load_request) {
             req->ops->load_request(f, req);
diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index f04dbc16c6..1fdd384cfe 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -1202,7 +1202,7 @@ static const struct SCSIBusConfig vscsi_scsi_config = {
     .max_lun = 31,
 };
 
-static const struct SCSIBusInfo vscsi_scsi_info = {
+static const struct SCSIBusOps vscsi_scsi_ops = {
     .transfer_data = vscsi_transfer_data,
     .complete = vscsi_command_complete,
     .cancel = vscsi_request_cancelled,
@@ -1228,7 +1228,7 @@ static void spapr_vscsi_realize(SpaprVioDevice *dev, Error **errp)
     dev->crq.SendFunc = vscsi_do_crq;
 
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
-                  &vscsi_scsi_info, &vscsi_scsi_config);
+                  &vscsi_scsi_ops, &vscsi_scsi_config);
 
     /* ibmvscsi SCSI bus does not allow hotplug. */
     qbus_set_hotplug_handler(BUS(&s->bus), NULL);
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index f3062c08bf..8d2811d7fb 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1271,7 +1271,7 @@ static struct SCSIBusConfig virtio_scsi_scsi_config = {
     .max_lun = VIRTIO_SCSI_MAX_LUN,
 };
 
-static const struct SCSIBusInfo virtio_scsi_scsi_info = {
+static const struct SCSIBusOps virtio_scsi_scsi_ops = {
     .complete = virtio_scsi_command_complete,
     .fail = virtio_scsi_command_failed,
     .cancel = virtio_scsi_request_cancelled,
@@ -1344,7 +1344,7 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
     }
 
     scsi_bus_init_named(&s->bus, sizeof(s->bus), dev,
-                        &virtio_scsi_scsi_info, &virtio_scsi_scsi_config,
+                        &virtio_scsi_scsi_ops, &virtio_scsi_scsi_config,
                         vdev->bus_name);
     /* override default SCSI bus hotplug-handler, with virtio-scsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(dev));
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index e1310f20eb..0ed5c0490b 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1133,7 +1133,7 @@ static const struct SCSIBusConfig pvscsi_scsi_config = {
         .max_lun = 0,
 };
 
-static const struct SCSIBusInfo pvscsi_scsi_info = {
+static const struct SCSIBusOps pvscsi_scsi_ops = {
         .get_sg_list = pvscsi_get_sg_list,
         .complete = pvscsi_command_complete,
         .cancel = pvscsi_request_cancelled,
@@ -1174,7 +1174,7 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
                                                &DEVICE(pci_dev)->mem_reentrancy_guard);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(pci_dev),
-                  &pvscsi_scsi_info, &pvscsi_scsi_config);
+                  &pvscsi_scsi_ops, &pvscsi_scsi_config);
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), OBJECT(s));
     pvscsi_reset_state(s);
diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 297b0d95f8..462d8ea465 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -86,7 +86,7 @@ static const struct SCSIBusConfig ufs_scsi_config = {
     .max_channel = 0,
 };
 
-static const struct SCSIBusInfo ufs_scsi_info = {
+static const struct SCSIBusOps ufs_scsi_ops = {
     .get_sg_list = ufs_get_sg_list,
     .complete = ufs_scsi_command_complete,
 };
@@ -346,7 +346,7 @@ static void ufs_init_scsi_device(UfsLu *lu, BlockBackend *blk, Error **errp)
     DeviceState *scsi_dev;
 
     scsi_bus_init(&lu->bus, sizeof(lu->bus), DEVICE(lu),
-                  &ufs_scsi_info, &ufs_scsi_config);
+                  &ufs_scsi_ops, &ufs_scsi_config);
 
     blk_ref(blk);
     blk_detach_dev(blk, DEVICE(lu));
diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index 91e6588e29..e98fe1bcc4 100644
--- a/hw/usb/dev-storage-bot.c
+++ b/hw/usb/dev-storage-bot.c
@@ -19,7 +19,7 @@ static const struct SCSIBusConfig usb_msd_scsi_config_bot = {
     .max_lun = 15,
 };
 
-static const struct SCSIBusInfo usb_msd_scsi_info_bot = {
+static const struct SCSIBusOps usb_msd_scsi_ops_bot = {
     .transfer_data = usb_msd_transfer_data,
     .complete = usb_msd_command_complete,
     .cancel = usb_msd_request_cancelled,
@@ -39,7 +39,7 @@ static void usb_msd_bot_realize(USBDevice *dev, Error **errp)
     }
 
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
-                  &usb_msd_scsi_info_bot, &usb_msd_scsi_config_bot);
+                  &usb_msd_scsi_ops_bot, &usb_msd_scsi_config_bot);
     usb_msd_handle_reset(dev);
 }
 
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index 76e176dc20..4358e9a91f 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -22,7 +22,7 @@ static const struct SCSIBusConfig usb_msd_scsi_config_storage = {
     .max_lun = 0,
 };
 
-static const struct SCSIBusInfo usb_msd_scsi_info_storage = {
+static const struct SCSIBusOps usb_msd_scsi_ops_storage = {
     .transfer_data = usb_msd_transfer_data,
     .complete = usb_msd_command_complete,
     .cancel = usb_msd_request_cancelled,
@@ -58,7 +58,7 @@ static void usb_msd_storage_realize(USBDevice *dev, Error **errp)
     usb_desc_init(dev);
     dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
     scsi_bus_init(&s->bus, sizeof(s->bus), DEVICE(dev),
-                  &usb_msd_scsi_info_storage, &usb_msd_scsi_config_storage);
+                  &usb_msd_scsi_ops_storage, &usb_msd_scsi_config_storage);
     scsi_dev = scsi_bus_legacy_add_drive(&s->bus, blk, 0, !!s->removable,
                                          &s->conf, dev->serial, errp);
     blk_unref(blk);
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index de26114f10..0627213f48 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -624,7 +624,7 @@ static const struct SCSIBusConfig usb_uas_scsi_config = {
     .max_lun = 255,
 };
 
-static const struct SCSIBusInfo usb_uas_scsi_info = {
+static const struct SCSIBusOps usb_uas_scsi_ops = {
     .transfer_data = usb_uas_scsi_transfer_data,
     .complete = usb_uas_scsi_command_complete,
     .cancel = usb_uas_scsi_request_cancelled,
@@ -942,7 +942,7 @@ static void usb_uas_realize(USBDevice *dev, Error **errp)
 
     dev->flags |= (1 << USB_DEV_FLAG_IS_SCSI_STORAGE);
     scsi_bus_init(&uas->bus, sizeof(uas->bus), DEVICE(dev),
-                  &usb_uas_scsi_info, &usb_uas_scsi_config);
+                  &usb_uas_scsi_ops, &usb_uas_scsi_config);
 }
 
 static const VMStateDescription vmstate_usb_uas = {
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 53475effb8..85e40ef08d 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -15,7 +15,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(SCSIBus, SCSI_BUS)
 
 typedef struct SCSIBusConfig SCSIBusConfig;
-typedef struct SCSIBusInfo SCSIBusInfo;
+typedef struct SCSIBusOps SCSIBusOps;
 typedef struct SCSIDevice SCSIDevice;
 typedef struct SCSIRequest SCSIRequest;
 typedef struct SCSIReqOps SCSIReqOps;
@@ -143,7 +143,7 @@ struct SCSIBusConfig {
     int max_channel, max_target, max_lun;
 };
 
-struct SCSIBusInfo {
+struct SCSIBusOps {
     int (*parse_cdb)(SCSIDevice *dev, SCSICommand *cmd, uint8_t *buf,
                      size_t buf_len, void *hba_private);
     void (*transfer_data)(SCSIRequest *req, uint32_t arg);
@@ -173,7 +173,7 @@ struct SCSIBus {
     int busnr;
 
     SCSISense unit_attention;
-    const SCSIBusInfo *info;
+    const SCSIBusOps *ops;
     const SCSIBusConfig *config;
 
     int drain_count; /* protected by BQL */
@@ -184,7 +184,7 @@ struct SCSIBus {
  * @bus: SCSIBus object to initialize
  * @bus_size: size of @bus object
  * @host: Device which owns the bus (generally the SCSI controller)
- * @info: structure defining callbacks for the controller
+ * @ops: structure defining callbacks for the controller
  * @config: structure defining bus params
  * @bus_name: Name to use for this bus
  *
@@ -195,7 +195,7 @@ struct SCSIBus {
  * should use scsi_bus_init() instead.
  */
 void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
-                         const SCSIBusInfo *info, const SCSIBusConfig *config,
+                         const SCSIBusOps *ops, const SCSIBusConfig *config,
                          const char *bus_name);
 
 /**
@@ -205,10 +205,10 @@ void scsi_bus_init_named(SCSIBus *bus, size_t bus_size, DeviceState *host,
  * an automatically generated unique name.
  */
 static inline void scsi_bus_init(SCSIBus *bus, size_t bus_size,
-                                 DeviceState *host, const SCSIBusInfo *info,
+                                 DeviceState *host, const SCSIBusOps *ops,
                                  const SCSIBusConfig *config)
 {
-    scsi_bus_init_named(bus, bus_size, host, info, config, NULL);
+    scsi_bus_init_named(bus, bus_size, host, ops, config, NULL);
 }
 
 static inline SCSIBus *scsi_bus_from_device(SCSIDevice *d)
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e1cf2ff23b..24681e5c38 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3223,7 +3223,7 @@ sub process {
 				MemoryRegionOps|
 				MemoryRegionPortio|
 				QEMUFileOps|
-				SCSIBusInfo|
+				SCSIBusOps|
 				SCSIReqOps|
 				Spice[A-Z][a-zA-Z0-9]*Interface|
 				TypeInfo|
-- 
2.47.1


