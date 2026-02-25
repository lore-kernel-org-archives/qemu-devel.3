Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536E7FD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvN2e-0005KP-C8; Wed, 25 Feb 2026 17:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vvN2c-0005Jc-Hx
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:07:34 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vvN2a-0000Fd-Rt
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:07:34 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PHlTV5369277; Wed, 25 Feb 2026 22:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=XabJ/7aTeF03sGlGazocLR913/Scf
 bRVsUM9lH+GQTM=; b=eRL2bY7EFw88bh6tWdpa9skgBifoQOi1k1rEMaCGUgNYO
 S+B9pbZuSdh6faj1XeOnVMVEgnD++qp3aSnr6UQbyNwuI+mAg0ID1Y65lRogOcR+
 +J3lrrXd/LDAGFMaPhx5oqQlsvXP62ycEOfvyeuela6A0KyPrCb52lYhQL+n2IRD
 3/X4bLOJFH67ktQfNJKbSqDNCppNpDYVmhTWqWqtrIHQ3agkTCSdtK3oyd9RvcTA
 uA/J616Vns5UPeEqcXl7iAGGMOZU0aPv/UMdClxh0e/AlRSJtTrsanyTTJDGLYq3
 TGBLZmX27Aih3hbK9UfpHR/Gib2jAzn4tXqgLpg8g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5y5f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 22:07:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 61PKPUhO028474; Wed, 25 Feb 2026 22:07:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4cf35bnwpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 22:07:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 61PM7Sas037405;
 Wed, 25 Feb 2026 22:07:28 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4cf35bnwp3-1; Wed, 25 Feb 2026 22:07:27 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: joe.jin@oracle.com, philmd@linaro.org, kraxel@redhat.com, armbru@redhat.com
Subject: [PATCH 1/1] hw/nvram/fw_cfg: update bootorder and bios-geometry
 before launching
Date: Wed, 25 Feb 2026 14:05:56 -0800
Message-ID: <20260225220556.11049-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250211
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDIxMSBTYWx0ZWRfXx0BWnysz0ABU
 ixxt/XH4FFV2MQSHtyfzizbnEbel4kuBy6pg9ZxWqxCeIYatX7ZxQu4Ssg/6nqtcDTyQsbs17AR
 GrapoPdO9QrGjk04sdCg4D/e7C7JBnEkSjz5gfg02r5oAojkfW7gurxGyrYK3ZHzVtyf0OeunJP
 uKpqdrXLkbfhLdvwgF2ceJuJ1V9T8gDiDMuHytX/pjeZJGen5QPzz9ZV3GeG01+0IY9aItL2sXh
 +C+kOsdSZ489PUCQExD7lWJVwG5eYJJ6wtdN3ShttJ5aOCAV+oLkOoSFbQvPF0gdcbHaPzxuHYh
 smpTTqHsyQGCfE+Hum5eJV4BAbcwwvXtB7z/GCVsqZPzjhgg1K/yAapSnOdCoD/8e6x/bhqRBPA
 3ymxrZbzgmkd+ttFvOX4gGr+MriRd4fdLlqVM+v/aJlQhICl1pSl2Ir/oGOVNS4ur4+lwD9Hf/H
 qslKidirvufyIlPjGPg==
X-Proofpoint-GUID: MqejOOixWm9URHpZHNLrXHlAml7jY2LQ
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699f72a1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=Ge82wXWqdg-knZzUHAMA:9
X-Proofpoint-ORIG-GUID: MqejOOixWm9URHpZHNLrXHlAml7jY2LQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QEMU maintains disk boot order and geometry information in the lists
"fw_boot_order" and "fw_lchs". For example, boot order is derived from each
device's bootindex value.

During system reset, and only during system reset, QEMU updates the
"bootorder" and "bios-geometry" entries in fw_cfg based on the contents of
"fw_boot_order" and "fw_lchs". After the guest VM boots, the firmware
(e.g., SeaBIOS) can read the boot order from fw_cfg and boot from the disk
at the top of the list.

The reset handler fw_cfg_machine_reset() is invoked either implicitly
during instance creation or explicitly by the user via HMP/QMP.

However, users may attach or detach disks while the VM is in the prelaunch
state. Because there is no implicit reset when transitioning from prelaunch
to running, the "bootorder" and "bios-geometry" data in fw_cfg can become
stale. As a result, the firmware may be unable to locate the correct disk
to boot from.

Here is an example that demonstrates the bug.

1. Create a QEMU instance with a virtio-scsi HBA and keep it in the
prelaunch state. Use SeaBIOS rather than UEFI.

-device virtio-scsi-pci,id=scsi0,num_queues=4 \
-S \

2. First, attach the boot disk, then attach the secondary disk.

(qemu) drive_add 0 file=boot.qcow2,if=none,id=drive0
(qemu) device_add scsi-hd,drive=drive0,bus=scsi0.0,channel=0,scsi-id=0,lun=1,bootindex=1
(qemu) drive_add 0 file=secondary.qcow2,if=none,id=drive1
(qemu) device_add scsi-hd,drive=drive1,bus=scsi0.0,channel=0,scsi-id=0,lun=2,bootindex=-1

3. Start the VM from the prelaunch state. Because the "bootorder" and
"bios-geometry" data in fw_cfg is stale, SeaBIOS attempts to boot from the
secondary disk only once and then stops. As a result, the VM fails to boot.

One possible workaround is to require QEMU users to explicitly issue a
system_reset before starting a guest VM from the prelaunch state, if any
disks have been attached or detached.

Another option is to address the issue in SeaBIOS. Nowadays, SeaBIOS
attempts to boot from only a single disk. We could enhance SeaBIOS to try
multiple disks in order until boot succeeds.

Another option is to update "bootorder" and "bios-geometry" everywhere
disks are attached or detached. This may require identifying the relevant
functions across multiple device types, such as SCSI, NVMe, virtio-blk, and
IDE.

This commit fixes the issue in QEMU by ensuring that "bootorder" and
"bios-geometry" are always updated when QEMU transitions from the prelaunch
state to running.

Co-developed-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 hw/nvram/fw_cfg.c         | 20 ++++++++++++++++++--
 include/hw/nvram/fw_cfg.h |  2 ++
 monitor/qmp-cmds.c        |  6 ++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1d7d835421..6f60abae65 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -965,9 +965,8 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
     return true;
 }
 
-static void fw_cfg_machine_reset(void *opaque)
+static void __fw_cfg_machine_reset(FWCfgState *s)
 {
-    FWCfgState *s = opaque;
     void *ptr;
     size_t len;
     char *buf;
@@ -981,6 +980,23 @@ static void fw_cfg_machine_reset(void *opaque)
     g_free(ptr);
 }
 
+void fw_cfg_machine_reload(void)
+{
+    FWCfgState *s = fw_cfg_find();
+
+    if (!s) {
+        return;
+    }
+
+    __fw_cfg_machine_reset(s);
+}
+
+static void fw_cfg_machine_reset(void *opaque)
+{
+    FWCfgState *s = opaque;
+    __fw_cfg_machine_reset(s);
+}
+
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
 {
     FWCfgState *s = container_of(n, FWCfgState, machine_ready);
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 56f17a0bdc..8aace1d4a9 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -351,4 +351,6 @@ void load_image_to_fw_cfg(FWCfgState *fw_cfg, uint16_t size_key,
                           uint16_t data_key, const char *image_name,
                           bool try_decompress);
 
+void fw_cfg_machine_reload(void);
+
 #endif
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0c409c27dc..dfeb80d1d9 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -32,6 +32,7 @@
 #include "hw/mem/memory-device.h"
 #include "hw/intc/intc.h"
 #include "migration/misc.h"
+#include "hw/nvram/fw_cfg.h"
 
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -112,6 +113,11 @@ void qmp_cont(Error **errp)
             error_propagate(errp, local_err);
             return;
         }
+
+        if (runstate_check(RUN_STATE_PRELAUNCH)) {
+            fw_cfg_machine_reload();
+        }
+
         vm_start();
     }
 }
-- 
2.39.3


