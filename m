Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB4CCDD1D3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFsz-0007LZ-CV; Fri, 27 Sep 2024 14:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsw-0007Ez-PZ; Fri, 27 Sep 2024 14:40:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFst-0002IB-Mh; Fri, 27 Sep 2024 14:40:10 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMY1E018988;
 Fri, 27 Sep 2024 18:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :reply-to:mime-version:content-transfer-encoding; s=
 corp-2023-11-20; bh=WUAIwnS3VoVePc+BcDnyeq7tmpb2t4i1TH6as8Pihzk=; b=
 KumB2B4JZgLBxH34uPQ6xzyHCdRvK9FkVsUdqerwI7zKdDsSEJOe9Z7ctUCN+2/k
 5WuurtYRDV45j7amzOYvSJCXEE4BmI7BDdte8HChO0T8gY02Ockfx/1jpmj6zCGz
 d+Mwo3S9+eqYavZFujNcd0AvTBI0soUrU+SSnNG8EuS6vVYx9EvapS+QfzKp7cTS
 yMt8z2vmew+1Xp2NJYVIYNZQsAzGUpdpbyH2kPTwEdPgQ8az+yeG4XoB/LT6Ra2d
 gx5tFd2ZCZ+NQezflnwn4dQXyL0y8E5qLnDBhvJ3Nwfh3II+7CM2DXqV//7Wphwr
 NrZzAw9G7k3FBpqZdBGkjA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr1gh7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RIT3eu032853; Fri, 27 Sep 2024 18:39:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8g03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:57 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIof009004;
 Fri, 27 Sep 2024 18:39:56 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-7; Fri, 27 Sep 2024 18:39:55 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 06/11] acpi: Send the GPE event of suspend and wakeup
 for x86
Date: Fri, 27 Sep 2024 14:39:01 -0400
Message-ID: <20240927183906.1248-7-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240927183906.1248-1-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270135
X-Proofpoint-ORIG-GUID: 6i4fyM18r8xUOUBqJ7JTKYz2wxw8CX3W
X-Proofpoint-GUID: 6i4fyM18r8xUOUBqJ7JTKYz2wxw8CX3W
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: miguel.luis@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GPE event is triggered to notify the guest to suppend or
wakeup itself.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/core.c                       | 17 +++++++++++++----
 hw/core/machine-qmp-cmds.c           |  2 ++
 include/hw/acpi/acpi.h               |  1 +
 include/hw/acpi/acpi_dev_interface.h |  1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index ec5e127d17..e5c3ff9a54 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -354,6 +354,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
     return -1;
 }
 
+void acpi_send_sleep_wakeup_event(void)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+
+    if (obj) {
+        /* Send _GPE.L07 event */
+        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
+    }
+}
+
 static void acpi_notify_wakeup(Notifier *notifier, void *data)
 {
     ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
@@ -369,10 +379,9 @@ static void acpi_notify_wakeup(Notifier *notifier, void *data)
             (ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_TIMER_STATUS);
         break;
     case QEMU_WAKEUP_REASON_OTHER:
-        /* ACPI_BITMASK_WAKE_STATUS should be set on resume.
-           Pretend that resume was caused by power button */
-        ar->pm1.evt.sts |=
-            (ACPI_BITMASK_WAKE_STATUS | ACPI_BITMASK_POWER_BUTTON_STATUS);
+        /* ACPI_BITMASK_WAKE_STATUS should be set on resume. */
+        ar->pm1.evt.sts |= ACPI_BITMASK_WAKE_STATUS;
+        acpi_send_sleep_wakeup_event();
         break;
     default:
         break;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 770f8189ba..010bba05f3 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/acpi.h"
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
@@ -283,6 +284,7 @@ void qmp_system_sleep(Error **errp)
                    "suspend from running is not supported by this guest");
         return;
     }
+    acpi_send_sleep_wakeup_event();
 }
 
 void qmp_system_powerdown(Error **errp)
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index e0e51e85b4..07e31aa138 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -181,6 +181,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
 
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status);
+void acpi_send_sleep_wakeup_event(void);
 
 void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
 
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50..1cb050cd3a 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_SLEEP_STATUS = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
-- 
2.43.5


