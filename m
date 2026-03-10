Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90703FD4F08
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00ZN-0008Ev-Bu; Tue, 10 Mar 2026 13:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w00ZG-00082F-A4
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:08:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1w00ZD-0002Ck-JX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 13:08:26 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A9paHu1719464; Tue, 10 Mar 2026 17:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=UwFaq
 lxrl+cyGEDBTYQT8hq7HYgRfb2BLDnnOzcsRFQ=; b=C1DgBDtTjkOIz3Hbe+s99
 hn3vpsnaCTMEzri8YfQ2mMZS4sHaMaPTdi/Qq6KNsmtkI2JkvkCqmJ+fGuFf5kqd
 kZj9StMIRkTD5W5cwKcg+WTSSZCWGJmGfS1WKipP8vKc4tEm4ka3+gD7QKoYqhM8
 RS9NxjpszetE6Xbku5yef3K36+kuVvJWKQix5gbFUjJqZri5kMm8cnURpaXnNjqg
 HU4jOwwaHGXVKkZ4Ik5t3K+256WhUZEWJtKOEGLsMkLLDvs+u1kWS43VepdQqMwc
 T6B7wtDDghq42qziHyO7zovwk93mzjbRmPbG47R0clQ74qUGSR1aeYXy2dDtjJMf
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cskyp39mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 17:08:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62AGcjix014835; Tue, 10 Mar 2026 17:08:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafengwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 17:08:19 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62AH6kiM015679;
 Tue, 10 Mar 2026 17:08:19 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4crafenguc-3; Tue, 10 Mar 2026 17:08:19 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, kraxel@redhat.com,
 joe.jin@oracle.com
Subject: [PATCH v2 2/2] hw/nvram/fw_cfg: update bootorder and bios-geometry
 before launching
Date: Tue, 10 Mar 2026 10:06:17 -0700
Message-ID: <20260310170712.46336-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260310170712.46336-1-dongli.zhang@oracle.com>
References: <20260310170712.46336-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100148
X-Proofpoint-GUID: G-BsrQuDhMkkMhuM5dGNRRzDZCwnMxV6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE0OCBTYWx0ZWRfX6Gj5ZjvQMCeY
 HChQ902DMCcdAKXosb0aKdRXdjbU6Q7Nz3EoIAAaBYA/f7AIoCP2hEbh5WJPXTkxc1zpNIolWaI
 RAa5tn51YtYsSu6n3VwdqjlarA808zyFIC9xVBaAXYXV6mxbtWg/Z2+kAnyO5vdA2QZEYkRs7ow
 DLBczjiAwNtbCXb+S8UniTs2UFNOWsurvCnlv0AzUtVFldwPrSL44qP93LZS1YSurjQ9idhzo+2
 BxPGQIcoWmL6TQftC++9DM+LMv0NDSkQ7AWInDaaS0ANlG6aItjyl/66n6fI8xKxqpOTZn7Js27
 YEJvm0YO0QA9Vpxe8NXjP/NWcj0D+/9gj5CIjE7/zsDiquN5Gxv68gnREmdaugbAX37iqQM4tuV
 dkEUezbq7lUUmcxuoupq9a7pTqiHD1C9Wx24CQl+PizkrWDMvzBGkin303xthLP//n/Tm73KOyP
 1b+EL3Q2DZaI5SfJ3IoAJkGz5DeuMDpzHN6hyp44=
X-Proofpoint-ORIG-GUID: G-BsrQuDhMkkMhuM5dGNRRzDZCwnMxV6
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=69b05005 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=vtPLVedyJFvWhrfAsZQA:9 cc=ntf
 awl=host:12273
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

According to runstate_transitions_def[], RUN_STATE_PRELAUNCH is allowed to
transition to four states. Only the transition to RUN_STATE_RUNNING
requires updating "bootorder" and "bios-geometry".

Co-developed-by: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
v1 -> v2:
  - Add new runstate tranisition notifier to track transition from
    prelaunch to running

 hw/nvram/fw_cfg.c         | 31 +++++++++++++++++++++++++++++--
 include/hw/nvram/fw_cfg.h |  1 +
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 1d7d835421..5154d77028 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -27,6 +27,7 @@
 #include "system/system.h"
 #include "system/dma.h"
 #include "system/reset.h"
+#include "system/runstate.h"
 #include "system/address-spaces.h"
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
@@ -965,9 +966,8 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
     return true;
 }
 
-static void fw_cfg_machine_reset(void *opaque)
+static void __fw_cfg_machine_reset(FWCfgState *s)
 {
-    FWCfgState *s = opaque;
     void *ptr;
     size_t len;
     char *buf;
@@ -981,10 +981,37 @@ static void fw_cfg_machine_reset(void *opaque)
     g_free(ptr);
 }
 
+static void fw_cfg_machine_reset(void *opaque)
+{
+    FWCfgState *s = opaque;
+
+    __fw_cfg_machine_reset(s);
+}
+
+static void fw_cfg_runstate_transition(Notifier *notifier, void *data)
+{
+    FWCfgState *s = container_of(notifier, FWCfgState,
+                                 runstate_transition);
+    const VMRunStateTransition *transition = data;
+
+    /*
+     * According to runstate_transitions_def[], RUN_STATE_PRELAUNCH is
+     * allowed to transition to four states. Only the transition to
+     * RUN_STATE_RUNNING requires updating "bootorder" and "bios-geometry".
+     */
+    if (transition->old_state == RUN_STATE_PRELAUNCH &&
+        transition->new_state == RUN_STATE_RUNNING) {
+        __fw_cfg_machine_reset(s);
+    }
+}
+
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
 {
     FWCfgState *s = container_of(n, FWCfgState, machine_ready);
+
     qemu_register_reset(fw_cfg_machine_reset, s);
+    s->runstate_transition.notify = fw_cfg_runstate_transition;
+    qemu_add_runstate_transition_notifier(&s->runstate_transition);
 }
 
 static const Property fw_cfg_properties[] = {
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 56f17a0bdc..81ac940119 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -66,6 +66,7 @@ struct FWCfgState {
     uint16_t cur_entry;
     uint32_t cur_offset;
     Notifier machine_ready;
+    Notifier runstate_transition;
 
     bool dma_enabled;
     dma_addr_t dma_addr;
-- 
2.39.3


