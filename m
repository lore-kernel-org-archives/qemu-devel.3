Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8562EC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 20:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3L0h-0008Sl-2X; Fri, 11 Apr 2025 16:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3L0e-0008Ro-PQ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:29:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u3L0c-00082N-PW
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 16:29:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BJg16j012761;
 Fri, 11 Apr 2025 20:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:reply-to:subject:to; s=corp-2023-11-20;
 bh=aeYAHJf6KKs2YGAdU9Xnv8gw8a1LLXCET5QSylDWrvA=; b=diE5uzU7a8Tw
 OXGYKXmkjCHiyKnJGHQkwo8hJakXT0TOCJ1z13jsZAPLDaJmZAABvvJd/8Z52feN
 Mh/pgMlZJx/kDBQhpXRWxgoT5UZzDL5aL3w3d5GDVNoCUwcG1vFAvR+sFg/noUrg
 f+w+dTXqgeNRKPVdwtzaWU0HI1SlysRLzWZRYILvNb629yb/gNgYYXqSEB6PrQGb
 r9HrB1aezXC4YGwP6n0NtElgPvuLPVqtBg25VCOUWgo6/mBgUCgX6jFxUrEc1E5z
 LhceowGC4kCJZyLvzysV2a+nfv5ZqvwlAV0knpgzvjWnYhJ8xQx1m2dXyFk54l/z
 i3HgCR6CJg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y9fe030y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:29:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53BIqXr4023915; Fri, 11 Apr 2025 20:29:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttymhg79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 20:29:36 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53BKTafj000488;
 Fri, 11 Apr 2025 20:29:36 GMT
Received: from localhost.localdomain (dhcp-10-43-12-85.usdhcp.oraclecorp.com
 [10.43.12.85])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 45ttymhg4b-1; Fri, 11 Apr 2025 20:29:36 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, paul@xen.org, Jonathan.Cameron@huawei.com, git@dprinz.de, 
 imammedo@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V3 PATCH 01/13] acpi: Implement control method sleep button
Date: Fri, 11 Apr 2025 16:28:27 -0400
Message-ID: <20250411202827.2904-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250411201912.2872-1-annie.li@oracle.com>
References: <20250411201912.2872-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110130
X-Proofpoint-GUID: 0tkvaZKwaroUdcDA7DIDHeaEa4GeA9QT
X-Proofpoint-ORIG-GUID: 0tkvaZKwaroUdcDA7DIDHeaEa4GeA9QT
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

The fixed hardware sleep button isn't appropriate for hardware
reduced platform. This patch implements the control method sleep
button in a separate source file so that the button can be added
for various platforms.

Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/control_method_device.c         | 33 +++++++++++++++++++++++++
 hw/acpi/meson.build                     |  1 +
 include/hw/acpi/control_method_device.h | 21 ++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
new file mode 100644
index 0000000000..c3b1d484c4
--- /dev/null
+++ b/hw/acpi/control_method_device.c
@@ -0,0 +1,33 @@
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
+#include "hw/mem/nvdimm.h"
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


