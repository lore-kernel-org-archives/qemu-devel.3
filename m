Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127ABC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJpA-0003tE-4x; Wed, 28 May 2025 12:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJp7-0003n3-A4
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:40:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJp5-0007Ky-LA
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:40:13 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq4U6028786;
 Wed, 28 May 2025 16:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=kOYwx
 GXVb9rgjj7TTVKAX1qLk1jf5Fok+IUVLU8wXDk=; b=rbIykQAF3uKuHw7jBBO5/
 X/UCKxA+7nDD7saN/oatkAMXdPIJLDyBY2hceZSOFlNvf2hJeLbEaHX3o83OwxOG
 Vsvkucpcr5BlMQSbyu+djwyppkrWLzoI6/GHAM8UvLJhC+nzhirkyDfIqw6NNBY+
 GaJWcM96AG9GBiCETsTvcoZs2V3SbP/YmV0uaVdjqq2JtdOYyVTEkgSHPdmTI65k
 EWnuHieJmrCspatZdW7LR1Bz30E4Wag7kY5iENGmQlSCUccquatJ0sUQtK4oIPrL
 Nui329GzCLzMqogY09uQc2wnEJ/2T0rlB0fJQQoBFOI7an29Fruy1F3mUoDRE/ud
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s6a6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:40:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFZtFB027835; Wed, 28 May 2025 16:40:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janp0c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:40:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGe3DZ017321;
 Wed, 28 May 2025 16:40:03 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jannwv-1; Wed, 28 May 2025 16:40:02 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 05/13] acpi: Send the GPE event of sleep for x86
Date: Wed, 28 May 2025 12:39:52 -0400
Message-ID: <20250528163953.2183-1-annie.li@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX/WIOfZEWzsPT
 HHBvf36ghIdOCuUPyIVu08x6wA0NVHZ082TEhXIpklQo6bvHX97TqrDJYekOtr8FtB2fXtV36Rq
 C5j+W19puesSeLI+R46a2EYO2kcrDDZ7dGX4sLiuzaNJ5ASfPohxht5GNoPTvakdffVflmsp6jD
 lkiyCXfPB/bvI0jx0Iz9V6oFbFdc0vZlW1jUfdV1V1Ctqkc5n2XB+Jjd3sFN7nwYTKGS5YSbfb7
 unozHkEXJZRbyrpHGI4K2axEOzRFUZ/549hbowSHB8IW6j6cRj9HYaSl5zSCRaGV2JYUhIVvzOs
 E+9KeUxPZezk47MpIALT4M7Gizp8sO+wGxkaSGtCLRt+e47zH/TIu3SGU+VOOafsmJ4dYcDswnu
 B6ZxDqCyhL+PMBebN+JLJdqu0aS6loRoecHjQzhUhSOizCgTTouFr/w3jKgiMSw996f4tJXV
X-Proofpoint-GUID: HdyBSE1LGyQK5zuzgzbOrBoajUqnI7yT
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68373c64 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=DeNaylJhju8rhfKi:21 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8
 a=jbaGl5hWb9-53QST99wA:9
X-Proofpoint-ORIG-GUID: HdyBSE1LGyQK5zuzgzbOrBoajUqnI7yT
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

The GPE event is triggered to notify x86 guest to sleep
itself. The function acpi_send_sleep_event will also
trigger GED events on HW-reduced systems where ACPI GED
sleep event is supported.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/core.c                       | 12 ++++++++++++
 include/hw/acpi/acpi.h               |  1 +
 include/hw/acpi/acpi_dev_interface.h |  1 +
 3 files changed, 14 insertions(+)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 58f8964e13..dcabe881bf 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -359,6 +359,18 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
     return -1;
 }
 
+void acpi_send_sleep_event(void)
+{
+    bool ambiguous;
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, &ambiguous);
+
+    assert(!ambiguous);
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


