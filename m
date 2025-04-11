Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D91CC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 20:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3LCX-0007S8-HQ; Fri, 11 Apr 2025 16:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3LCV-0007Rz-RT
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:42:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3LCU-0001JW-Ad
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:42:11 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJGZcW006057;
 Fri, 11 Apr 2025 20:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:reply-to:subject:to; s=corp-2023-11-20;
 bh=8KM6E6rOAbrFIu4LFi0eFopihIoPkj2MOxJ2KXmHepM=; b=T8AMuuV+VpMk
 ONY2mHsiDbXvBy2LvHCRmjg8kXm9Wa7XcQbRsm8O1hOLNUiwHbhjl88mn62KvhT+
 SJFVQsRFfdMnJq8cs301GgGujemg3DJJeLqt8Dy5a9uWkOo9UbzI2GytIKR3rVkV
 Sdgib9ysrlsDd86fM3vEuJpVMsydgqOrSEzs2b5UBDN1kh74v7jDaoCVls4EYnbv
 TuGHtFsgIP0jGypGYGbVZcL7p2DBsVde2zBjLzU5u2eq+sj74KF5xVuIOa6w+30T
 EVaXYX5LPOJMFwVct/ZzugPk3AOjBs4KrNu6d92i1ow1lK+0ufU31564pjpWYTML
 HDZY9IZ0KQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y93m84p7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:41:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53BKBdle002058; Fri, 11 Apr 2025 20:41:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttye5cna-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:41:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53BKfu4m033040;
 Fri, 11 Apr 2025 20:41:56 GMT
Received: from localhost.localdomain (dhcp-10-43-12-85.usdhcp.oraclecorp.com
 [10.43.12.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 45ttye5cm0-1; Fri, 11 Apr 2025 20:41:56 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and wakeup
 for x86
Date: Fri, 11 Apr 2025 16:41:32 -0400
Message-ID: <20250411204133.2955-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411201912.2872-1-annie.li@oracle.com>
References: <20250411201912.2872-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504110131
X-Proofpoint-GUID: U6k3Y2ImWMLyCDPaNMwbm0VeRPYzEMJ-
X-Proofpoint-ORIG-GUID: U6k3Y2ImWMLyCDPaNMwbm0VeRPYzEMJ-
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: annie.li@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The GPE event is triggered to notify x86 guest to suppend
itself. The function acpi_send_sleep_event will also
trigger GED events on HW-reduced systems where ACPI GED
sleep event is supported.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/core.c                       | 10 ++++++++++
 include/hw/acpi/acpi.h               |  1 +
 include/hw/acpi/acpi_dev_interface.h |  1 +
 3 files changed, 12 insertions(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e13..00a9d226f0 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
     return -1;
 }
 
+void acpi_send_sleep_event(void)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+
+    if (obj) {
+        /* Send sleep event */
+        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
+    }
+}
+
 static void acpi_notify_wakeup(Notifier *notifier, void *data)
 {
     ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
index d1a4fa2af8..64d3ff78ed 100644
--- a/include/hw/acpi/acpi.h
+++ b/include/hw/acpi/acpi.h
@@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
 
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
                          AcpiEventStatusBits status);
+void acpi_send_sleep_event(void);
 
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


