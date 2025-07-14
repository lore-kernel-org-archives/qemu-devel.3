Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD03C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLOR-0002CS-12; Mon, 14 Jul 2025 11:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKAF-0007Ou-5A
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:28:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKAB-0002V9-LU
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:28:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5gP001302;
 Mon, 14 Jul 2025 14:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=bXKF3Gu+
 z5Ax6KAjloH9/XYt4Xp0LnT8ObLH4D0kp4U=; b=dVxzXpBRjNgcrK2+ass2ckoI
 4Zv6IMSblwXkJmpDqYUJQeFQGatHsXNhDkqsqr181FihLEYpwCdZZq4O1FGumkof
 bd1D1nzit0Hpqcp/BXiMMmHnrlHUrvq3xHmtLxGCusmBbBXwnNbdbkZRTOZL6SYG
 JrFtNb0Jv6ExcWBSfDW5eBf34jaFoc/DhXGJnVbn1tJypsodnLDwGG2jip33Tg5e
 x0v8u9i5WKl5grmAFPM/dk7NgzJ42Z802AzRgdTMLMp2fFXxP4KgLV9JhHPAI3lq
 Pe8bCuMPOD1HKRsZa5irSfE8Ty55wpgKt81KBV+Y0ECYl+6b38TO5NTFNB8PoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv835-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56ECDiIm010889; Mon, 14 Jul 2025 14:27:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58kgft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:04 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EER3Mt039980;
 Mon, 14 Jul 2025 14:27:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58kgf3-1; Mon, 14 Jul 2025 14:27:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/2] preserve pending interrupts during cpr
Date: Mon, 14 Jul 2025 07:27:00 -0700
Message-Id: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=927 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-ORIG-GUID: vo258fqpLguwoL-EH2DaMPfUcbQ3b_F2
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687513b9 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=rsN0t9O5Kin3QS32dkkA:9 a=ZXulRonScM0A:10 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: vo258fqpLguwoL-EH2DaMPfUcbQ3b_F2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfX7QcdAIyyo9S6
 +LcaCEARC8q1udouGiLygQyXci5KdoyHSf91kDstt1o5ZPw2cKlu8M6Z/tUeOXd/fsRDSmQHWoI
 GBl6WipWIGLrmlPuvTZwlHZMBA1eltvO5Aq86Sraw7W70DcYkaOUBx7UtKPENsMXjzRq++68xIo
 GXbS7QQa736GwkqlC7GtvwtvT1WzOnKaJ/I0zt2eO5kozPFQ55yfLcpuuOJa8eJtYNMVsUF2EPz
 gUtTxkyu1PYk9EYWm5FymOR59W3wBBnxRppP9zu1GQyzKoGnQHteUsyeWiAyC/lkpf8JUv79TXE
 HQ/ZzwsDim8b/vYEORc3yUoIduomssQvg4n+GHFBvA7vm72oo8URoWKuyZQfGpd1BOWP9yGrhtk
 avk34b/PXCEu8ll+u1y2wu234Ri1/Ay7kuQ81v717famXjfMmpAQgVhVfOjiKdf4iI/PfIyQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Close a race condition that causes cpr-transfer to lose VFIO
interrupts.  See commit messages for details.

Steve Sistare (2):
  vfio/pci: augment set_handler
  vfio/pci: preserve pending interrupts

 hw/vfio/cpr.c              | 92 +++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.c              | 15 ++++++-
 hw/vfio/pci.h              |  4 +-
 include/hw/vfio/vfio-cpr.h |  6 +++
 4 files changed, 113 insertions(+), 4 deletions(-)

-- 
2.39.3


