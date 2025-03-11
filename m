Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9E5C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Tt-0001cQ-Rw; Tue, 11 Mar 2025 11:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Ti-0001RJ-EY
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1ts1Tb-0007TP-4y
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:25:08 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BDMuSr014984;
 Tue, 11 Mar 2025 15:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=C40EJPNjrVzgTUH+NCm2drjXPBLno
 nB8MvrNQnLvNOU=; b=m9NV35ezvZA8lTmia14Sxg1f/d19IjEayKUbVn4Xjms3H
 n4xKX5OwsrIknideVchzKpT0FEOYvdPxCjWEYNCzOZRNXIV68bS8N0N2TtUnMURM
 WJk6fd/JebBofF/YkoOt0lhb3UPdklVwdUTL2jIuaFBvuaRdv7EDf1DnaMTW17x0
 eqFcgyLEmUWTrJ0jOHPXsjdOyQQwGdRE06B5yeug2R4g1Eh0tc8F2EliD9q9CAeZ
 adT06h13DCUYQn5BzyT088I9lqmMr3gqg4qoEvfh57CNEmeOuxJn7ll0Fc5k97FC
 FUV03mF3ed4BeobaG2oF25LB+/qk50NVrxgSO0+pg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458ctb56me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:24:56 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BFGj83019373; Tue, 11 Mar 2025 15:24:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 458cbfqnn3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 15:24:54 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52BFMCs1035998;
 Tue, 11 Mar 2025 15:24:54 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 458cbfqngj-1; Tue, 11 Mar 2025 15:24:54 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mst@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 0/6] amd_iommu: Fixes to align with AMDVi specification
Date: Tue, 11 Mar 2025 15:24:40 +0000
Message-ID: <20250311152446.45086-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-GUID: 5UyMkuoNT9D91saWaVI6zKIQQ4KU1b-b
X-Proofpoint-ORIG-GUID: 5UyMkuoNT9D91saWaVI6zKIQQ4KU1b-b
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

Correct mistakes in bitmasks, offsets, decoding of fields, and behavior that
do not match the latest AMD I/O Virtualization Technology (IOMMU)
Specification.  These bugs do not trigger problems today in the limited mode
of operation supported by the AMD vIOMMU (passthrough), but upcoming
functionality and tests will require them (and additional fixes).

These are all minor and hopefully not controversial fixes, so I am sending
them out at this time to separate them from later series adding
functionality. It is unclear how relevant these changes will be to stable
releases considering the state of the AMD vIOMMU, but the fixes on this
series should be simple enough to apply, so I Cc'd stable for consideration.

Thank you,
Alejandro

Alejandro Jimenez (6):
  amd_iommu: Fix Miscellanous Information Register 0 offsets
  amd_iommu: Fix Device ID decoding for INVALIDATE_IOTLB_PAGES command
  amd_iommu: Update bitmasks representing DTE reserved fields
  amd_iommu: Fix masks for Device Table Address Register
  amd_iommu: Fix the calculation for Device Table size
  amd_iommu: Do not assume passthrough translation for devices with
    DTE[TV]=0

 hw/i386/amd_iommu.c | 103 ++++++++++++++++++++++++--------------------
 hw/i386/amd_iommu.h |  25 ++++++-----
 2 files changed, 71 insertions(+), 57 deletions(-)


base-commit: 5136598e2667f35ef3dc1d757616a266bd5eb3a2
-- 
2.43.5


