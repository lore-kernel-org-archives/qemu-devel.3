Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7328C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJqR-0006Qm-3R; Wed, 28 May 2025 12:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJqO-0006Nn-MQ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:41:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJqI-0007T3-Re
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:41:32 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqJm7024345;
 Wed, 28 May 2025 16:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=727HK
 22WZPUtQ4z+9kqTd3YZIkhPdLWPb+lVB2VXtZo=; b=ngcq1fc3umqV1HwexbZeG
 TrRSymdJ7ZmZ2j8rYxsAsNnOJGfWUNgyFIdMHa5vDnVNc3TyKw+r6La6puN5HVSL
 zdX1YFP0gzKSogMfilsF4z68VHmN+RyPVFgOyj911mWLDLEBNd+lpY2bQgRnyCV5
 PZ60d4ncwbwaBYZHu5Xfb+QDPlOQlp66kCWAcLfaLHdOa2E1JE1c+ve6yVWTKjiZ
 fVaZv2A0MK0JOfusuu7dRHYcoy02Hb+Wy3ngQi8xyXh2itPHqNhjzpSTGh/aME5s
 JfeRk3XhgYgbQomQafS3aTCpWnuD/Zp0mwQD+sSe+ibI6d+8AVqdAvYe65fkAHhU
 A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46txe50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:41:18 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFMJMI028686; Wed, 28 May 2025 16:41:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janqcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:41:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGfGTC021650;
 Wed, 28 May 2025 16:41:16 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janqas-1; Wed, 28 May 2025 16:41:16 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 09/13] microvm: enable sleep GED event
Date: Wed, 28 May 2025 12:41:06 -0400
Message-ID: <20250528164106.2215-1-annie.li@oracle.com>
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
X-Proofpoint-GUID: glxd0g9OHexO33ubwoveGocXVDXGXAWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfXxAkWosC+rpWz
 q6It+y4bhykIx8cydC8SH1uHrxJMdqLMgM/8Oaf/XOsiJLvayNYrOKr2+YwHSjemIHt2JcBKrFE
 aB3HtAPn0VeO58kosoTEhBoMYKwwswk+NGrGh+zwevAce7Ik3eWT5c9JqIQhI6sgXhopObRSwm8
 v5zL5pX/wk8L1L21hQ5gLbwNKiqjPt8rBUC/KzuppDw0WQykMx0+8NVsridbXPhcxmQ1ZqWmvYk
 S2dYAK4fQfi19/+71UF3au8d4sHSZHo2SAdD+0wShSBYwjklJniNBl4uL8TYmW2CkpK/27tIYhl
 OZnR+SeV1zvQDfu5PUjcZfrJJ13j0P949kNGS/Lh9+TzyYei0Juv0XCUpGtXwAWd3Zrn9DdjI37
 lnjG17e8t2X+DdVG3tgxEB+KA46twV1vULTVi4ITEiSxYuywa0pGrUcL8OPRH6bfRget1DgV
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=68373cae cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=GR07uqxev6xxxvSERWsA:9
X-Proofpoint-ORIG-GUID: glxd0g9OHexO33ubwoveGocXVDXGXAWv
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

The sleep GED event is enabled for microvm. Also, the system
suspend is enabled when the GED register is set for sleep.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/microvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index d0a236c74f..eba33c4365 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -205,7 +205,8 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     /* Optional and legacy devices */
     if (x86_machine_is_acpi_enabled(x86ms)) {
         DeviceState *dev = qdev_new(TYPE_ACPI_GED);
-        qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
+        qdev_prop_set_uint32(dev, "ged-event",
+                             ACPI_GED_PWR_DOWN_EVT | ACPI_GED_SLEEP_EVT);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
         /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
-- 
2.43.5


