Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB12C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 20:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3LDJ-0008Rj-Cq; Fri, 11 Apr 2025 16:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3LDI-0008PP-1A
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:43:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3LDG-0001Mq-B7
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:42:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BKbBdp026274;
 Fri, 11 Apr 2025 20:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:reply-to:subject:to; s=corp-2023-11-20;
 bh=W1P1bs7VQBT8ohlWDXoBmUG081fUqYeB7+rytmTTyUI=; b=dYAg3Ua+SyVN
 SXNUc0kAMOJCbIfU/xUuJV7lI20LypXyQyw2uN+DHKQ7Ha5hoVjCvGmcECrs1BhZ
 a+S9VUSgEBBcQjAH0aaiYaVlcLvZ9oqsNSBxbgY/et3VYG0Ows1bkMLFQhDyNG2P
 YF7DUjNt0S2jxUYSbO7nhu7VpJJ9dXnqel3QR0MxTw9/Nc8vPOnLVrtnEfXYkLkD
 vl0bvbfNh3GY7wQeJnF9RYw9SSLEDKHrdUl2nWloJSMw9K232r4zde5++fi8ge3o
 ZzD25wlK0rc6WLtq63XH6HgTB5GoojXnZXP26kINtYqtgczPh6TxjFOQ50nAQQ7J
 C6s8niEdYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ya96808e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:42:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53BKJ7fX001648; Fri, 11 Apr 2025 20:42:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttye5dht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:42:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53BKgodo035382;
 Fri, 11 Apr 2025 20:42:50 GMT
Received: from localhost.localdomain (dhcp-10-43-12-85.usdhcp.oraclecorp.com
 [10.43.12.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 45ttye5dgr-1; Fri, 11 Apr 2025 20:42:50 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V3 PATCH 07/13] microvm: support control method sleep button
Date: Fri, 11 Apr 2025 16:42:35 -0400
Message-ID: <20250411204236.2977-1-annie.li@oracle.com>
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
X-Proofpoint-ORIG-GUID: DBHbSFo17MImDQFgprVYfyjps34PCAwX
X-Proofpoint-GUID: DBHbSFo17MImDQFgprVYfyjps34PCAwX
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the support of control method sleep button and System
S3 Sleeping State for microvm.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/acpi-microvm.c                 | 11 +++++++++++
 include/hw/acpi/generic_event_device.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 279da6b4aa..57c45ea327 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -32,6 +32,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/erst.h"
+#include "hw/acpi/control_method_device.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/microvm.h"
 #include "hw/pci/pci.h"
@@ -123,12 +124,22 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     build_ged_aml(sb_scope, GED_DEVICE, x86ms->acpi_dev,
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
+    acpi_dsdt_add_sleep_button(sb_scope);
     acpi_dsdt_add_virtio(sb_scope, mms);
     acpi_dsdt_add_xhci(sb_scope, mms);
     acpi_dsdt_add_pci(sb_scope, mms);
     aml_append(dsdt, sb_scope);
 
     /* ACPI 5.0: Table 7-209 System State Package */
+    scope = aml_scope("\\");
+    pkg = aml_package(4);
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S3));
+    aml_append(pkg, aml_int(0)); /* ignored */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(scope, aml_name_decl("_S3", pkg));
+    aml_append(dsdt, scope);
+
     scope = aml_scope("\\");
     pkg = aml_package(4);
     aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d2dac87b4a..28c5785863 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -85,6 +85,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_SLP_TYP_POS       0x2   /* SLP_TYPx Bit Offset */
 #define ACPI_GED_SLP_TYP_MASK      0x07  /* SLP_TYPx 3-bit mask */
 #define ACPI_GED_SLP_TYP_S5        0x05  /* System _S5 State (Soft Off) */
+#define ACPI_GED_SLP_TYP_S3        0x03  /* System _S3 State (Sleeping State) */
 #define ACPI_GED_SLP_EN            0x20  /* SLP_EN write-only bit */
 
 #define GED_DEVICE      "GED"
-- 
2.43.5


