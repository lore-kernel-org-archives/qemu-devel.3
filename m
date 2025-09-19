Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D78CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 21:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzimU-0006qO-Qh; Fri, 19 Sep 2025 17:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimM-0006mL-LV
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uzimG-0002Xx-01
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 17:36:28 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JDtqVM023272;
 Fri, 19 Sep 2025 21:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=ryenD
 os+M1PXZvVQZvc90q+nONMqUaP5DpPVnLvfdhE=; b=HtI3uWn6mx6s5PUyVVYnJ
 3x3iu/GqOgwCT9MOP7aB5D3ARNAvOP00q/sFgd1ulnrVEusD+2wwh5p6vH2XceTr
 XCsH+onxJHRa7OfHITnp+BXlDEwCb1HMQUxtO3p14oeWPljD6QgCcgRkFme+u4gr
 FoiQdQ/eUFPFOVjV4jMwrI7u002iK4gleASQIPjnLi5DrqUqxg6HVT8qoHGOsRQa
 AWvg8MzhEPZf1l7tsZGHnk+dobU7gxQORal2sR1ckzdgNh4S3l4tfvjrQaJPL0Cy
 1zE2MbFxe84diwhuHSlV8XFUom1FAuKIMlr63nLikn4XrfI5YNFTBmO6y0/PYaGv
 Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx6pdwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58JKd1T4033813; Fri, 19 Sep 2025 21:35:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2gwrt8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Sep 2025 21:35:57 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58JLUm0V004301;
 Fri, 19 Sep 2025 21:35:57 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 494y2gwra3-17; Fri, 19 Sep 2025 21:35:57 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 Ankit.Soni@amd.com, ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 16/22] amd_iommu: Set all address spaces to use passthrough
 mode on reset
Date: Fri, 19 Sep 2025 21:35:09 +0000
Message-ID: <20250919213515.917111-17-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
References: <20250919213515.917111-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190201
X-Authority-Analysis: v=2.4 cv=TqbmhCXh c=1 sm=1 tr=0 ts=68cdccbe b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=TyYeUvuNVc17vi0sGpoA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-GUID: 9Giyg3iRePjXw3btv5P91ofstwVHx-_4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4DiKxvkQXSv0
 fxr5wkiKymRpT7/DHiNO9rFQfrlWcgWNtirQl3kvffRvYzEzglKiGi6haIy0j05Co0H0DkwWZtQ
 JYkhnw4z4hojQhjV6LSwI9/pDCVzbyqd4HJE0oIkDH9Mev5nDzbNvkkNkdLHpGYipB5dF6SoL9g
 3bxK8jvi91NJKkInTQlQrDg4aZUwCf5/MwDGggRzqtDBDbNEBwHz5joFe9NXVlw8BFfkqMY/bEy
 o21al+BPdBUduYSoGgVwJxU6N5X0uaqunPhWVqb+RL5WzJp32gMKJm6fnytOao5FyE8tiKa1uqS
 gPkOnq1eO7CBorX2n6N3Ti66Sb5U4HMc9qRjVdsY8FGeyRc495Z4xhJL9OBtvG7Zw6bkA+qzdSn
 OEkOAQAe
X-Proofpoint-ORIG-GUID: 9Giyg3iRePjXw3btv5P91ofstwVHx-_4
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On reset, restore the default address translation mode (passthrough) for all
the address spaces managed by the vIOMMU.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 67a26f524706b..e9ce7b46e854f 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1001,6 +1001,35 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
     }
 }
 
+/*
+ * For all existing address spaces managed by the IOMMU, enable/disable the
+ * corresponding memory regions to reset the address translation mode and
+ * use passthrough by default.
+ */
+static void amdvi_reset_address_translation_all(AMDVIState *s)
+{
+    AMDVIAddressSpace **iommu_as;
+
+    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+
+        /* Nothing to do if there are no devices on the current bus */
+        if (!s->address_spaces[bus_num]) {
+            continue;
+        }
+        iommu_as = s->address_spaces[bus_num];
+
+        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+
+            if (!iommu_as[devfn]) {
+                continue;
+            }
+            /* Use passthrough as default mode after reset */
+            iommu_as[devfn]->addr_translation = false;
+            amdvi_switch_address_space(iommu_as[devfn]);
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2263,6 +2292,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     /* Discard all mappings on device reset */
     amdvi_address_space_unmap_all(s);
+    amdvi_reset_address_translation_all(s);
 }
 
 static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
-- 
2.43.5


