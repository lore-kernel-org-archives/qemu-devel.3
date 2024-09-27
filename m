Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C0CDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFsu-00076R-NR; Fri, 27 Sep 2024 14:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsr-0006we-0A; Fri, 27 Sep 2024 14:40:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFso-00024U-Rj; Fri, 27 Sep 2024 14:40:04 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMavk018461;
 Fri, 27 Sep 2024 18:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :reply-to:mime-version:content-transfer-encoding; s=
 corp-2023-11-20; bh=Y2ScNx7uhiDnRyw9+fg5cWmlnPTsA01dpbRI8RLsQyY=; b=
 QSTmCtlZLvKrPAWlcjMXi61cwKD5Dawmox9VOnaaeUHXZgDtCjKQaqTQBMzCUza8
 +a5Wgk7D8oZEK1uT08oIP9GdZfZ2M8KGMa0o2J4CK08CGyJ0+67TlzoYovrmPI/f
 zhhf10bzFSXRwUGq63lRg+o0ZBCMH+tEZR3fiJChLoq2dWjH/BAarNxYMooO69cE
 c96pck/9xaxIijMXBpb9G9e4B6XCInHjDUM4W7BAhEsGu3NmC3biB7sgSlKSV5P5
 La/t7+up3QPllTWLYQ1N/9Tf6ncV6s78lyBSClxCa3ChJz+42VDvOwMBVpx95wMk
 rSKXGb1t9bcUzy6COMrW0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2d0jw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RHSZDh032841; Fri, 27 Sep 2024 18:39:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8fma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIoX009004;
 Fri, 27 Sep 2024 18:39:32 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-3; Fri, 27 Sep 2024 18:39:32 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 02/11] acpi: Implement control method sleep button
Date: Fri, 27 Sep 2024 14:38:57 -0400
Message-ID: <20240927183906.1248-3-annie.li@oracle.com>
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
X-Proofpoint-GUID: 0dNhWGXxYG-hmIw3q3XSreHD5bhy5CA9
X-Proofpoint-ORIG-GUID: 0dNhWGXxYG-hmIw3q3XSreHD5bhy5CA9
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

The control method sleep button is added, as well as its GPE event
handler.

Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/control_method_device.c         | 54 +++++++++++++++++++++++++
 hw/acpi/meson.build                     |  1 +
 include/hw/acpi/control_method_device.h | 25 ++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
new file mode 100644
index 0000000000..f52c190352
--- /dev/null
+++ b/hw/acpi/control_method_device.c
@@ -0,0 +1,54 @@
+/*
+ * Control method devices
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <annie.li@oracle.com>
+ *
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/control_method_device.h"
+#include "hw/mem/nvdimm.h"
+
+void acpi_dsdt_add_sleep_button(Aml *scope)
+{
+    Aml *dev = aml_device("\\_SB."ACPI_SLEEP_BUTTON_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
+    Aml *pkg = aml_package(2);
+    aml_append(pkg, aml_int(0x01));
+    aml_append(pkg, aml_int(0x04));
+    aml_append(dev, aml_name_decl("_PRW", pkg));
+    aml_append(dev, aml_operation_region("\\Boo", AML_SYSTEM_IO,
+                                         aml_int(0x201), 0x1));
+    Aml *field = aml_field("\\Boo", AML_BYTE_ACC, AML_NOLOCK,
+                           AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("SBP", 1));
+    aml_append(field, aml_named_field("SBW", 1));
+    aml_append(dev, field);
+    aml_append(scope, dev);
+}
+
+void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope)
+{
+     Aml *method = aml_method("_L07", 0, AML_NOTSERIALIZED);
+     Aml *condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
+     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBP")));
+     aml_append(condition,
+                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x80)));
+     aml_append(method, condition);
+     condition = aml_if(aml_name("\\_SB.SLPB.SBW"));
+     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBW")));
+     aml_append(condition,
+                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x2)));
+     aml_append(method, condition);
+     aml_append(scope, method);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db90..0b4f1b432d 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
new file mode 100644
index 0000000000..87f8d6fd59
--- /dev/null
+++ b/include/hw/acpi/control_method_device.h
@@ -0,0 +1,25 @@
+/*
+ * Control method devices
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <annie.li@oracle.com>
+ *
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+
+#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
+#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
+
+#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
+
+void acpi_dsdt_add_sleep_button(Aml *scope);
+void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope);
+
+#endif
-- 
2.43.5


