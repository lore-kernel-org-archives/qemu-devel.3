Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD9AC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Tv-0001f4-50; Tue, 11 Mar 2025 11:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Ti-0001RK-GY
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Td-0007ZT-5i
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMwHb006213;
 Tue, 11 Mar 2025 15:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=eRc7q
 L98Wi8eIpm3TvORdr4uS9sCMCakg5DuNfEuwAk=; b=gsEamgNlj/jmSTw9zu2TO
 1LqN6hrESxbTkdNc9L9qlZ2Y9spZBJ3lsABzY9cQRG7bd2365b2p3NjaTwonotsi
 8SCyl12u3MmMcokRjTRIp3b+gAemzE8+nG3BSxms+VgdPRzFIqv5Vw6zYoqFq5S5
 WbPSX3wzLcasokLFDe1J/6SkbQPBoX0CFnBPIObB/EOVl9shm8c/BQxIrISc9IoN
 Y/7J4F42ZbmZSAQ1vO1SUkjqCoqgfYjo6fyz79B52hHRLWbrCFFA0S2KIMAgvSj6
 rw/poxOTV7WpEtytbaNh0epWNGPhYHeCIXFnmdh99G1q0J/gy7u3ZLPWzudt3I6x
 Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ds9n2c2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:25:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BE8WdX021431; Tue, 11 Mar 2025 15:24:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 458cbfqnrr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:24:59 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52BFMCsB035998;
 Tue, 11 Mar 2025 15:24:59 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 458cbfqngj-6; Tue, 11 Mar 2025 15:24:59 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 5/6] amd_iommu: Fix the calculation for Device Table size
Date: Tue, 11 Mar 2025 15:24:45 +0000
Message-ID: <20250311152446.45086-6-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
References: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110096
X-Proofpoint-GUID: 3rNJH3WQxmo4BqlUo0qcjzGDuJl6DPA_
X-Proofpoint-ORIG-GUID: 3rNJH3WQxmo4BqlUo0qcjzGDuJl6DPA_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Correctly calculate the Device Table size using the format encoded in the
Device Table Base Address Register (MMIO Offset 0000h).

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8b97abe28c..cf00450ebe 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -665,8 +665,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
     uint64_t val = amdvi_readq(s, AMDVI_MMIO_DEVICE_TABLE);
     s->devtab = (val & AMDVI_MMIO_DEVTAB_BASE_MASK);
 
-    /* set device table length */
-    s->devtab_len = ((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1 *
+    /* set device table length (i.e. number of entries table can hold) */
+    s->devtab_len = (((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1) *
                     (AMDVI_MMIO_DEVTAB_SIZE_UNIT /
                      AMDVI_MMIO_DEVTAB_ENTRY_SIZE));
 }
-- 
2.43.5


