Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79424C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 19:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKixs-000215-2O; Thu, 29 May 2025 15:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixZ-0001O5-Up
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixX-0001FS-CV
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGftlo028823;
 Thu, 29 May 2025 19:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=yft2O
 AAbN0h+Wi7N2z2MfgGmj8WFSPzF83vw+HBtBNA=; b=KAAkQiZgClhvcB49YJkhG
 6BBvI6yWVRcjjCBEAujOZNTLUFWGdw2LIj28mGfAsV/c2/fSQoE+UmGvnTXqy4Bc
 e1jmdDOT4KDsQ5eFJqIguDhB3iYn+Acoy5TJWjk44sLnUvJP48JjMFEy+O+EKNHZ
 VgXORDJCE+WcPPWlXpP0qVn9nsBU/iZKwzLMVptsot0IqUxKgSDWVwDsUDd7w943
 eLRAHdSuQTK/v7H9g3QFeHbSBw3C1+dVN9+/KhCrAqd6s2G7K2gE1AC9syULJkoz
 mVOScKSnTIKuH66jQa91iDU2Knah2d3IOPUlFWQt21WxPYu7H9M0zEDdVvoXWqzg
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8r7p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJRCCV019218; Thu, 29 May 2025 19:30:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jccs17-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJUOVD005039;
 Thu, 29 May 2025 19:30:26 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jccrx6-5; Thu, 29 May 2025 19:30:26 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 4/7] amd_iommu: Fix masks for various IOMMU MMIO Registers
Date: Thu, 29 May 2025 19:30:20 +0000
Message-ID: <20250529193023.3590780-5-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290190
X-Proofpoint-ORIG-GUID: mdqHzNLOpRMtJG8az4PbPSoR0ykIjb5d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MCBTYWx0ZWRfX+IacEksABG20
 38X01rplU8uhL8FSQz46VEz21GCo3AtOKfqTPMLjm9VbefU6k5bz/2/qDX+2DLauow9Xdeoxduv
 EdrJK6HHKs9HGp6uIt7JfU1PPL7Rl/4W9k28nxXEcJIi6hT2taBa7ArQkEVwLV5fFIx7KXBJ0Ed
 BVbSAfH+rU0F5MGBNOqr9lxfCg8MWMZEoYCdGwg14RfEbZST9rqludIBhiQEimp8LMuzXn0iIMT
 QniY1AjE/xYhDE+XHt+G02s6eJIgf0hv8cnVK5tTmU+pjeZcLDXj+xsOckzrpRqOVGP7sIAnX7P
 YaKpEyVB/LRkughFJOorO5j1m7vgLAgRpRN3nlRoiOMoEH1ZZuvy9XKxA+ubKUZYNeSigH0vYV5
 MyUGEJxxZKj3UZ1VNaYHMxSXfz7mmNFt7QnynIfrSmYmQbE8PBER1LVqZVMOdT9O007LjekG
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6838b5d5 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=x93to4iw_sD-aHtwAakA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: mdqHzNLOpRMtJG8az4PbPSoR0ykIjb5d
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

Address various issues with definitions of the MMIO registers e.g. for the
Device Table Address Register, the size mask currently encompasses reserved
bits [11:9], so change it to only extract the bits [8:0] encoding size.

Convert masks to use GENMASK64 for consistency, and make unrelated
definitions independent.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 45a997af861e6..09352672bdcc2 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -68,34 +68,34 @@
 
 #define AMDVI_MMIO_SIZE               0x4000
 
-#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
-#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
-                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
+#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
+#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
+
 #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
 #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
 
 /* some of this are similar but just for readability */
 #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
 #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
-#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
-#define AMDVI_MMIO_CMDBUF_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_CMDBUF_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_CMDBUF_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_CMDBUF_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EVTLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_EVTLOG_SIZE_MASK       AMDVI_MMIO_CMDBUF_SIZE_MASK
-#define AMDVI_MMIO_EVTLOG_BASE_MASK       AMDVI_MMIO_CMDBUF_BASE_MASK
-#define AMDVI_MMIO_EVTLOG_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
-#define AMDVI_MMIO_EVTLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
+#define AMDVI_MMIO_EVTLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_EVTLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_EVTLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_EVTLOG_TAIL_MASK       GENMASK64(18, 4)
 
-#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
-#define AMDVI_MMIO_PPRLOG_HEAD_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
-#define AMDVI_MMIO_PPRLOG_BASE_MASK       AMDVI_MMIO_EVTLOG_BASE_MASK
-#define AMDVI_MMIO_PPRLOG_SIZE_MASK       AMDVI_MMIO_EVTLOG_SIZE_MASK
+#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_PPR_BASE + 7)
+#define AMDVI_MMIO_PPRLOG_SIZE_MASK       0x0f
+#define AMDVI_MMIO_PPRLOG_BASE_MASK       GENMASK64(51, 12)
+#define AMDVI_MMIO_PPRLOG_HEAD_MASK       GENMASK64(18, 4)
+#define AMDVI_MMIO_PPRLOG_TAIL_MASK       GENMASK64(18, 4)
 
 #define AMDVI_MMIO_EXCL_ENABLED_MASK      (1ULL << 0)
 #define AMDVI_MMIO_EXCL_ALLOW_MASK        (1ULL << 1)
-#define AMDVI_MMIO_EXCL_LIMIT_MASK        AMDVI_MMIO_DEVTAB_BASE_MASK
+#define AMDVI_MMIO_EXCL_LIMIT_MASK        GENMASK64(51, 12)
 #define AMDVI_MMIO_EXCL_LIMIT_LOW         0xfff
 
 /* mmio control register flags */
@@ -132,14 +132,14 @@
 #define AMDVI_DEV_TRANSLATION_VALID       (1ULL << 1)
 #define AMDVI_DEV_MODE_MASK               0x7
 #define AMDVI_DEV_MODE_RSHIFT             9
-#define AMDVI_DEV_PT_ROOT_MASK            0xffffffffff000
+#define AMDVI_DEV_PT_ROOT_MASK            GENMASK64(51, 12)
 #define AMDVI_DEV_PT_ROOT_RSHIFT          12
 #define AMDVI_DEV_PERM_SHIFT              61
 #define AMDVI_DEV_PERM_READ               (1ULL << 61)
 #define AMDVI_DEV_PERM_WRITE              (1ULL << 62)
 
 /* Device table entry bits 64:127 */
-#define AMDVI_DEV_DOMID_ID_MASK          ((1ULL << 16) - 1)
+#define AMDVI_DEV_DOMID_ID_MASK             GENMASK64(15, 0)
 
 /* Event codes and flags, as stored in the info field */
 #define AMDVI_EVENT_ILLEGAL_DEVTAB_ENTRY  (0x1U << 12)
@@ -197,7 +197,7 @@
 #define AMDVI_PAGE_SIZE  (1ULL << AMDVI_PAGE_SHIFT)
 
 #define AMDVI_PAGE_SHIFT_4K 12
-#define AMDVI_PAGE_MASK_4K  (~((1ULL << AMDVI_PAGE_SHIFT_4K) - 1))
+#define AMDVI_PAGE_MASK_4K      GENMASK64(63, 12)
 
 #define AMDVI_MAX_GVA_ADDR      (48UL << 5)
 #define AMDVI_MAX_PH_ADDR       (40UL << 8)
-- 
2.43.5


