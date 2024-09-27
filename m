Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F68BCDD1D2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 18:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suFsm-0006ia-6z; Fri, 27 Sep 2024 14:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsk-0006Zo-0w; Fri, 27 Sep 2024 14:39:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1suFsi-00025G-80; Fri, 27 Sep 2024 14:39:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48RHMchJ018494;
 Fri, 27 Sep 2024 18:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :reply-to:mime-version:content-transfer-encoding; s=
 corp-2023-11-20; bh=+vcRWWGd/9tf+6KOZuMJ4EFLau3Zv/DD9us8GvcSK6g=; b=
 Hn5NzCtqn7iVmey8z5e2ZrWjW2NC+Ye+2by+JMpyRccdkxti7gnTMjFY6k8PtmQV
 sbDHE/hM1Hz1SlHZ1bpnCGgbd4OEv34QkCST2vvE2ME1ms7iStayMxCi/XCDj4Bj
 SHE7P7UsuI2/wA9O5VLzvb4+YKarnbOmXFuOgXhJtIhM4osCWdCvJY4xGFIQu8Xw
 PF2lXLqUpu/asEMT5CC3QZjtglDgHpbCZM7jNCBknsnWURR9DIOmuatatA305eIn
 wR1DStYoAufKPOPDwGFi1GR3Vn1zByqUkumX2HYUUvxZ7zBDLTdxoA+5fwldun+o
 12RKOLyJ54CUW7PEShWoSg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2d0jwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48RH5V56032872; Fri, 27 Sep 2024 18:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41smkm8fqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Sep 2024 18:39:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48RIdIob009004;
 Fri, 27 Sep 2024 18:39:44 GMT
Received: from localhost.localdomain (dhcp-10-175-14-34.vpn.oracle.com
 [10.175.14.34])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 41smkm8ff6-5; Fri, 27 Sep 2024 18:39:44 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, imammedo@redhat.com
Cc: dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eblake@redhat.com, armbru@redhat.com,
 annie.li@oracle.com, miguel.luis@oracle.com
Subject: [RFC V2 PATCH 04/11] acpi: Support Control Method sleep button for x86
Date: Fri, 27 Sep 2024 14:38:59 -0400
Message-ID: <20240927183906.1248-5-annie.li@oracle.com>
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
X-Proofpoint-GUID: VIkM-io6WJDS8fJ-vzdhJ0hWQo8Yqmh7
X-Proofpoint-ORIG-GUID: VIkM-io6WJDS8fJ-vzdhJ0hWQo8Yqmh7
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

Adding Control Method Sleep button and its GPE event handler for
x86.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/acpi-build.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5d4bd2b710..ee62333a03 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -40,6 +40,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/control_method_device.h"
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
@@ -1527,6 +1528,14 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
+    sb_scope = aml_scope("_SB");
+    acpi_dsdt_add_sleep_button(sb_scope);
+    aml_append(dsdt, sb_scope);
+
+    scope =  aml_scope("\\_GPE");
+    acpi_dsdt_add_sleep_gpe_event_handler(scope);
+    aml_append(dsdt, scope);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
-- 
2.43.5


