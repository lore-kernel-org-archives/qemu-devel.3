Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DCBC677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27j-0002lY-4Q; Tue, 10 Jun 2025 12:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15G-0004OK-UM
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15F-0006Am-4o
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:18 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXd77027869;
 Tue, 10 Jun 2025 15:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=29UgIXTM7Y0z8HZRCcFiT0zlkiqAg9XrRvwJO5NnVrA=; b=
 PQA1jkd49Of2Wh+lQduowvDEc/6FjDZiJulY915xIJ3u/nH4HPPBUtHVtUD3laIU
 U5CZNtZPh/Bfvpl5RxlzxJwhNsd5dcg365Kd78yUjGBnQWnKh55IaDH3fAKEiTxI
 F3B4mbdcAXWM0EF83DYMDVwuQ9vEF/TNiAV7pkyAyUw7LDJRePjkUkUSYzgFhKbA
 HzR6G1xuMSGcBusjtJYjAufwONuTHLwKIkqfJzMC/0ifJbSQIm2bN8y3Wzqu59cp
 kQf0/r5ArxmpFO9abkdHrdGpMYNU0D4w8dG7pk9z33gCwD37a+tPxktWOKans2uX
 FHiUuVxpie9e9O/dX746MA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474cbech5n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:14 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEoK26003889; Tue, 10 Jun 2025 15:40:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wb3d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfX028825;
 Tue, 10 Jun 2025 15:40:12 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-14; Tue, 10 Jun 2025 15:40:12 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 13/38] vfio/pci: vfio_notifier_init
Date: Tue, 10 Jun 2025 08:39:26 -0700
Message-Id: <1749569991-25171-14-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Proofpoint-GUID: rx_r0rXNwc8vjRx50r1pbf9VWAElgmt1
X-Authority-Analysis: v=2.4 cv=BffY0qt2 c=1 sm=1 tr=0 ts=684851de b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=w3t5z44oxExOTv3jo9sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: rx_r0rXNwc8vjRx50r1pbf9VWAElgmt1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfXw3nFDaPVlATd
 xxPkozQfDizNtJiQydnZy/cL/C9AZ+MRdeKmTvaWAxrYce1pAE2g4ChD/lOcAfUkZoY7qL7cs/j
 UTENmpci9xzUpkqvEvNd05VbHpDK7iQhbN+9T3kX84CZSyzniHWYcTO22697pLzg1jCTl7aDGMs
 rtVBfb8NXkE2CGehwFgqsCxXP9xG5sNbmeym+KBzgOEV6QF2h2ep8Rb/yEQQGBsMKfWcqdOqNij
 vph5IhsgZAV+TFAaNrxPTTcwHGfXM/kwi38KeteISIgtgY8wtAZQt7CYgtNy4tEXPTI4PrvUhmr
 cs3LJ7YYvrmNBim2XpkL5EZC/8ST8w9tngpSKDqHO55EYwENdQH4QtDMA7W8NL3B1wtYseCtLy4
 x3G5/wyoi/eF1SObmTFquPo+DrvLItf/iUzUaOMgOTYYT+iewM+xPJ9mQ3hn0gm7u5rX0z96
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Move event_notifier_init calls to a helper vfio_notifier_init.
This version is trivial, but it will be expanded to support CPR
in subsequent patches.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03630bb..4fac4d1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -57,6 +57,16 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+static bool vfio_notifier_init(EventNotifier *e, const char *name, Error **errp)
+{
+    int ret = event_notifier_init(e, 0);
+
+    if (ret) {
+        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+    }
+    return !ret;
+}
+
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
  * also be a huge overhead.  We try to get the best of both worlds by
@@ -137,8 +147,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (event_notifier_init(&vdev->intx.unmask, 0)) {
-        error_setg(errp, "event_notifier_init failed eoi");
+    if (!vfio_notifier_init(&vdev->intx.unmask, "intx-unmask", errp)) {
         goto fail;
     }
 
@@ -269,7 +278,6 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
     int32_t fd;
-    int ret;
 
 
     if (!pin) {
@@ -292,9 +300,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 #endif
 
-    ret = event_notifier_init(&vdev->intx.interrupt, 0);
-    if (ret) {
-        error_setg_errno(errp, -ret, "event_notifier_init failed");
+    if (!vfio_notifier_init(&vdev->intx.interrupt, "intx-interrupt", errp)) {
         return false;
     }
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -474,11 +480,13 @@ static void vfio_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 
 static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector)
 {
+    const char *name = "kvm_interrupt";
+
     if (vector->virq < 0) {
         return;
     }
 
-    if (event_notifier_init(&vector->kvm_interrupt, 0)) {
+    if (!vfio_notifier_init(&vector->kvm_interrupt, name, NULL)) {
         goto fail_notifier;
     }
 
@@ -535,11 +543,12 @@ static void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     PCIDevice *pdev = &vdev->pdev;
+    Error *err = NULL;
 
     vector->vdev = vdev;
     vector->virq = -1;
-    if (event_notifier_init(&vector->interrupt, 0)) {
-        error_report("vfio: Error: event_notifier_init failed");
+    if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+        error_report_err(err);
     }
     vector->use = true;
     if (vdev->interrupt == VFIO_INT_MSIX) {
@@ -755,13 +764,14 @@ retry:
 
     for (i = 0; i < vdev->nr_vectors; i++) {
         VFIOMSIVector *vector = &vdev->msi_vectors[i];
+        Error *err = NULL;
 
         vector->vdev = vdev;
         vector->virq = -1;
         vector->use = true;
 
-        if (event_notifier_init(&vector->interrupt, 0)) {
-            error_report("vfio: Error: event_notifier_init failed");
+        if (!vfio_notifier_init(&vector->interrupt, "interrupt", &err)) {
+            error_report_err(err);
         }
 
         qemu_set_fd_handler(event_notifier_get_fd(&vector->interrupt),
@@ -2925,8 +2935,8 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->err_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for error detection");
+    if (!vfio_notifier_init(&vdev->err_notifier, "err_notifier", &err)) {
+        error_report_err(err);
         vdev->pci_aer = false;
         return;
     }
@@ -2992,8 +3002,8 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
         return;
     }
 
-    if (event_notifier_init(&vdev->req_notifier, 0)) {
-        error_report("vfio: Unable to init event notifier for device request");
+    if (!vfio_notifier_init(&vdev->req_notifier, "req_notifier", &err)) {
+        error_report_err(err);
         return;
     }
 
-- 
1.8.3.1


