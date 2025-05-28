Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD53C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJsm-0001HM-A0; Wed, 28 May 2025 12:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJsl-0001HD-DP
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:43:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJsj-0007kq-Nx
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:43:59 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq5pp028798;
 Wed, 28 May 2025 16:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ac6kO
 eH89eYR2GEbVsxCjN4yoWwGYSLrITsjZygt6+Q=; b=HBRLKlhENkjZvuZQfwUpM
 zdtguW8N5z6r6pJu6ZuebwWsZAjkQecHVCzAXsXuG3E1Dxai0H3kXsIfVKjBOua1
 fO2bmlULBXVDYuZqK9Xnj/1JHVhLsE8EK//lsIeUkCndN32Np9xWTmll99vTL22O
 /JawlNTTC+BCtlbuWm4raDFgLT1+xrVGndgsw71fpBEYqvThbn4ZEVnrulN2FfGp
 Dc+cjhrHc4uW9IaP1290PASkmj0IQMwO8Um3kkK+Jenq2Bvx3fyyp/m1peUU/DsO
 1dUD9EYQKRv0/oy1RIA+SeAAEZNXrt9xzFoI1LVwxTH9jOuRZDq4/vw4tdFqB0Kv
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s6a29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:38:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFa7VR028607; Wed, 28 May 2025 16:38:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janmrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:38:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGZv1U004464;
 Wed, 28 May 2025 16:38:46 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janmp6-1; Wed, 28 May 2025 16:38:46 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 01/13] acpi: Implement control method sleep button
Date: Wed, 28 May 2025 12:38:34 -0400
Message-ID: <20250528163835.2151-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX5scameJKD5tx
 5aoroJRMymBLqrCGswZlLPLnzI9QicKOqN098Ojbi3dmkl07erSuCkjFnH98dZUUc2sld7SXpmp
 7uBU48PCfF/y6iOMWuujmPYpZK14gPw1NBCpUiLkYxEyVHR8f0Cu0JXoS5H1ygcrHgQFJ5QA27g
 nn2/q1GFEk/JH1zgZtlnRcgB4tZYdYtH4zeBgp8cB/OEJMYEiwXBiHPN5oRCW7VtdIu25Cx3wBG
 8lv4nuJn2pawGnO/kJPh/yOjNWHz/O7m139ZHVJR+6O17be0/YNU6KUAiOhFqViclyvCnxlTTJX
 4/x2wieyh76iumLLpzC5ZXT4zhuQfni3ZTzSkuWbiwUgfThYA7Mov5lItjBf/mhp3dB1Q9FAhqC
 4DNhkJ0DzbjQv1r9Rz+dCoorFjdwqoGUtUppuvZO2zXRV9hpn5I9Fs3CWFoTYQatnRb9W8lW
X-Proofpoint-GUID: sy7Wn9zCBmnBPc57lhvd_wRE6vG1RRRO
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68373c17 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=sPl2G_jGVtvQ9U5vArsA:9
X-Proofpoint-ORIG-GUID: sy7Wn9zCBmnBPc57lhvd_wRE6vG1RRRO
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The fixed hardware sleep button isn't appropriate for hardware
reduced platform. This patch implements the control method sleep
button in a separate source file so that the button can be added
for various platforms.

Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/control_method_device.c         | 38 +++++++++++++++++++++++++
 hw/acpi/meson.build                     |  1 +
 include/hw/acpi/control_method_device.h | 21 ++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
new file mode 100644
index 0000000000..f8d691ee04
--- /dev/null
+++ b/hw/acpi/control_method_device.c
@@ -0,0 +1,38 @@
+/*
+ * Control Method Device
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <annie.li@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/control_method_device.h"
+#include "hw/acpi/aml-build.h"
+
+/*
+ * The control method sleep button[ACPI v6.5 Section 4.8.2.2.2.2]
+ * resides in generic hardware address spaces. The sleep button
+ * is defined as _HID("PNP0C0E") that associates with device "SLPB".
+ */
+void acpi_dsdt_add_sleep_button(Aml *scope)
+{
+    Aml *dev = aml_device(ACPI_SLEEP_BUTTON_DEVICE);
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
+    /*
+     * No _PRW, the sleep button device is always tied to GPE L07
+     * event handler for x86 platform, or a GED event for other
+     * platforms such as virt, ARM, microvm, etc.
+     */
+    aml_append(dev, aml_operation_region("\\SLP", AML_SYSTEM_IO,
+                                         aml_int(0x201), 0x1));
+    Aml *field = aml_field("\\SLP", AML_BYTE_ACC, AML_NOLOCK,
+                           AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("SBP", 1));
+    aml_append(dev, field);
+    aml_append(scope, dev);
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b9691..a62e625cef 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('c
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMCLOCK', if_true: files('vmclock.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
new file mode 100644
index 0000000000..079f1a74dd
--- /dev/null
+++ b/include/hw/acpi/control_method_device.h
@@ -0,0 +1,21 @@
+/*
+ * Control Method Device
+ *
+ * Copyright (c) 2023 Oracle and/or its affiliates.
+ *
+ *
+ * Authors:
+ *     Annie Li <annie.li@oracle.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+
+#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
+#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
+
+#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
+
+void acpi_dsdt_add_sleep_button(Aml *scope);
+
+#endif
-- 
2.43.5


