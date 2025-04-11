Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1069C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 20:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3L5M-00036i-RV; Fri, 11 Apr 2025 16:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3L5K-00035Y-MZ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:34:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3L5J-0000Gx-2o
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:34:46 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJgCNh013583;
 Fri, 11 Apr 2025 20:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:reply-to:subject:to; s=corp-2023-11-20;
 bh=88ME93WiideXXIUuxtug2b7AsUSEYoXviXqKYS28xus=; b=DrVNy+Cp77qJ
 rzdcjcQTYCuc1qBqi0LiRreMcxAOXjsMO1mt8U+hNg9tALhydoi7vrz84B3Wm7Iq
 wuNPi4v/nkd/2h9AOJ6GqmQwV7ALynvjPsiFdSfHKHFS/GE8Ov5FyvEp6r3xIFp5
 hkmfm42/6nQczu9DOxgEwerN2O2ap/XQ4gbUheOBaKGdn0o299UaowyfnbW7Z2pN
 DrJDbWFQPpAKZKPc3LvTef3KBRwVkvSNbKYCzlR/Cyvc5GeaxfDl0zynECjCleiE
 fjY9rst6hsMaAbztrQ7dYOIFijM7tTSeyZMdLVxHYD0McBLa1cly4OueXuP27Jy4
 XRHxzk4vwQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y9fe03cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:34:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53BKE5tw001287; Fri, 11 Apr 2025 20:34:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttye55a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:34:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53BKYZrg012521;
 Fri, 11 Apr 2025 20:34:35 GMT
Received: from localhost.localdomain (dhcp-10-43-12-85.usdhcp.oraclecorp.com
 [10.43.12.85])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 45ttye558x-1; Fri, 11 Apr 2025 20:34:34 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, philmd@linaro.org,
 zhao1.liu@intel.com, Jonathan.Cameron@huawei.com, annie.li@oracle.com
Subject: [RFC V3 PATCH 03/13] acpi: Support Control Method sleep button for x86
Date: Fri, 11 Apr 2025 16:34:06 -0400
Message-ID: <20250411203406.2930-1-annie.li@oracle.com>
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
X-Proofpoint-GUID: zenrVy4HWQbyDR_OlBa-M8Ahbud1jEvO
X-Proofpoint-ORIG-GUID: zenrVy4HWQbyDR_OlBa-M8Ahbud1jEvO
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

Add Control Method Sleep button and its GPE event handler for
x86 platform. The GPE event handler notifies OSPM when the
Sleep button event is triggered.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/acpi-build.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a332..4be3595e5a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -40,6 +40,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/control_method_device.h"
 #include "system/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
@@ -1359,7 +1360,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                                                      NULL);
     Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
     CrsRangeEntry *entry;
-    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
+    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs, *condition;
     CrsRangeSet crs_range_set;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
@@ -1465,6 +1466,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
+    sb_scope = aml_scope("_SB");
+    acpi_dsdt_add_sleep_button(sb_scope);
+    aml_append(dsdt, sb_scope);
+
+    /*
+     * The event handler for the control method sleep button is generated
+     * for notifying OSPM[ACPI v6.5 Section 4.8.2.2.2.].
+     */
+    scope =  aml_scope("\\_GPE");
+    method = aml_method("_L07", 0, AML_NOTSERIALIZED);
+    condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
+    aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBP")));
+    aml_append(condition,
+               aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x80)));
+    aml_append(method, condition);
+    aml_append(scope, method);
+    aml_append(dsdt, scope);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
-- 
2.43.5


