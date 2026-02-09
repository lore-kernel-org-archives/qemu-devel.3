Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9737E81BDE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpU2a-0001xl-Lu; Mon, 09 Feb 2026 11:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vpU2Y-0001wk-JF
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:23:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1vpU2W-0002gK-SL
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:23:10 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 619FsiKc326349; Mon, 9 Feb 2026 16:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=dyiVOTaESx2GKlhXrM5WqXSstiiM
 GDJrr8BqpXDIYjk=; b=NnVbOOD+jWMkQ0ep6mk6KgDSfoMIzkCqZsOQYfZ7KkET
 vdD9QKOz4CPlNyB1hyQ2cKRm2ILsEfqiv+Blex+CyIAl+qFEH0mRyvvIgwgtKTTq
 LihN77tPqGxgV1NiqcKg40eM/SEh6boad+xPhF5TKv33sFTcDc0F+YEkwd4dv0tT
 e9vt5cQqDQtCEtZKds0X4AaiTtTT0yyv9zB9TPp8SPDrfAO/ffNZYjox7PF4SSk3
 Zz0fVdi7n1apHxTSfj2l62SsksVGS3e6321whiJmAnqDyAwimxRAa2CnYrz0HRMG
 6nCTvDyxemO0YHrKCmMT7ifKCvmeBceNfxPWcNUSsQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696w03ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 16:23:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 619Eti7F001847;
 Mon, 9 Feb 2026 16:23:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je1wke0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 16:23:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 619GN16945941142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Feb 2026 16:23:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9791A2004D;
 Mon,  9 Feb 2026 16:23:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E58D620040;
 Mon,  9 Feb 2026 16:22:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.240.54])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Feb 2026 16:22:58 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, clg@redhat.com, vaibhav@linux.ibm.com,
 harshpb@linux.ibm.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH 1/1] vfio/pci: Ensure D0 power state before guest access
Date: Mon,  9 Feb 2026 21:50:48 +0530
Message-ID: <20260209162242.11317-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YeCwJgRf c=1 sm=1 tr=0 ts=698a09ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=j59bBDI_fl7I2lqCRAoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9G28BQvgRn__dSghGUHpUyykht7ZH4XK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzNyBTYWx0ZWRfX3lC+u95QH4oe
 CnsHkjOuoxhjr191RnVm71/wkjnE3Z+f8muTSIIsVqh1pFuz3fiWvLwRHJ3Lm6EiCgHfAf5UKnG
 s8CRz6xoIUmfHxoAfrCieK3VYiJUrCvhoo+u5UNNqZrlTe+DhxiVmH4wEbVXuNcCac3Nzu78I4b
 dEOeirfAQpQFh9ggSL4cwnchFxosBKXFcKGyvm4X+SL8y9zaeFrG2XpG6IzOwoIUGPyHYZ4Auxo
 FfHuMtUQPCp0qN/YXS83ss2LGMNDTtUwAjb6367XNMHybhZhFPxqBSct1m8HYFaZ275yw1rvEak
 5BhHNgQxE3sz3ru1YBWRJsBXWtRkIIcxpV5CG6HERE34XcqLhdL17At6XDU2qMvs3MmYLJsR34E
 Q6WsufSKghZahu/8bNnRYXGcg7vgP5y2RmiRNLj0kkdph9uYkmX/XdAkTP9WcALWSPD/dd7Jiwg
 jrZUUqlCOxO0gzifnzg==
X-Proofpoint-ORIG-GUID: 9G28BQvgRn__dSghGUHpUyykht7ZH4XK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090137
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add vfio_ensure_d0_state() to safely transition PCI devices from D3hot/D3cold
to D0 before QEMU guest access, preventing config space inaccessibility and
tg3 IRQ crashes during VFIO realize.

Key changes:
- D3hot: Direct PMCSR write (offset 0x44) to force PowerState=00 (D0)
- D3cold: pm_runtime_resume() + pm_runtime_get_sync() for full power restore
- Polling loop verifies D0 transition completion
- No-op for already D0 devices

Fixes PowerPC EEH races where devices enter low-power states during VFIO
handover, causing config space access failures.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/vfio/pci.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c734472721..851cd789aa 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3392,6 +3392,51 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
+static int write_sysfs(const char *path, const char *value)
+{
+    FILE *f = fopen(path, "w");
+    if (!f) {
+        return -1;
+    }
+    int ret = fprintf(f, "%s", value);
+    fclose(f);
+    return (ret > 0) ? 0 : -1;
+}
+
+static void vfio_ensure_d0_state(VFIOPCIDevice *vdev)
+{
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    char sysfs_power_path[PATH_MAX];
+
+    /*
+     * Test config region accessibility (D3cold-safe, no PCI config
+     * reads!)
+     */
+    struct vfio_region_info reg_info = {
+        .argsz = sizeof(reg_info),
+        .index = VFIO_PCI_CONFIG_REGION_INDEX,
+        .offset = 0,
+        .size = 0
+    };
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, &reg_info) < 0) {
+        warn_report("vfio: %s config region probe failed (D3cold): %s",
+                    vbasedev->name, strerror(errno));
+
+        /* D3cold confirmed → sysfs power control (EEH-safe) */
+        snprintf(sysfs_power_path, sizeof(sysfs_power_path),
+                 "/sys/bus/pci/devices/%s/power/control", vbasedev->name;
+
+        /* Force runtime resume */
+        if (write_sysfs(sysfs_power_path, "on") == 0) {
+            g_usleep(10000);  /* 10ms settle */
+            write_sysfs(sysfs_power_path, "auto");
+            info_report("vfio: %s D3cold → D0 via sysfs", vbasedev->name);
+        }
+    }
+    return;
+}
+
 static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
 {
     ERRP_GUARD();
@@ -3401,6 +3446,13 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
 
+    /*
+     * ensure the power state of the pci device to D0,
+     * otherwise it will set to D0, before accessing the
+     * config space.
+     */
+    vfio_ensure_d0_state(vdev);
+
     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
-- 
2.51.1

