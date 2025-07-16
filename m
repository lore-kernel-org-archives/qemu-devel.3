Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C90C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6Xr-00056P-R2; Wed, 16 Jul 2025 14:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6WI-0003sc-4L
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:06:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6WF-0006UP-QA
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 14:06:17 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHgIkV010941;
 Wed, 16 Jul 2025 18:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2025-04-25; bh=LgBW7cdlJHDrw0fG
 TI3W7zZIgKORiL0oWXnecXRuznw=; b=bWJHd6xxSOnIi+dScSrSLiEYa3o0Hu5+
 m/rKTcN6dujmLp6aSrRp0R2enqsmvBu6eNLmt/xLI8rtM+VudGfmRxt/yQ/kxO/G
 Hlz62dAsui9U+wkYdRmaaecKq9iPBOubia2PQV7BZfvbbY57nl+6ALBQ0R60z7kX
 wVd/blBchqaodDsF0lQWNdcOtIsDsTBCZ7SoZX76Fn4/9bUqaOKJcscK24DqotOJ
 9bLcO8uAGr8RZCUtTSel4GM1ZJkm7bN6++tKXErdEOVdGNxZ/ReJCJ53o/WZcGUF
 UfpdzNPm/yOfxrS00GcWEf0TMKeUexeheODZZbEQPTk/+hfmeqW/Zw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr11d36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 18:06:12 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56GGds2p039715; Wed, 16 Jul 2025 18:06:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5bq5ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 18:06:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56GI5BvD002385;
 Wed, 16 Jul 2025 18:06:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5bq5tx-1; Wed, 16 Jul 2025 18:06:10 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/2] preserve pending interrupts during cpr
Date: Wed, 16 Jul 2025 11:06:07 -0700
Message-Id: <1752689169-233452-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=924 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160163
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=6877ea14 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=rsN0t9O5Kin3QS32dkkA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: Tu5mHAHy6C16d7Q3GILEnjCwRREaYKAc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2MyBTYWx0ZWRfX2vMiE4OLhGSb
 2GAbapsHp1A1rRwT4yyhH4/VzmU5TqpSOUw86k6Re2DEzWyRDfkUuKiDnc8NUe1f6ikqvOKn6dq
 TTpB5EOldsuPM7mbRy2qmcx19YaTTMhNjLieXo+ElSm9nWt37eZe/rdSWQuq9QPkDsZWI83t3zZ
 M6LacGkzCH0TQBAAF2vkFT1IxGqlvVm7aqY4TX+vcMPw2Ffhwh654VzZ18jri483gXuRjTqBRY2
 HZn5Yowve89It2N9Ci0fiEhWCIGvcsy7jp9H23XmQOgVCpTWrYNdFA+pkI3sb74NGxNQ+Jec0fG
 tVAbpa+APNlJjdR1bz5TGN7S72Phf8PUHaEdAoQJIoLWRBPi6NsXzR1id7ktSze23Mx6QLzSrgP
 sYhOugFKAiaMdWAXMh//szm8/ItKEyIUD/I3APwCJOivf9NKG6jGk3iWQfRDRMJHzIaQHHnv
X-Proofpoint-GUID: Tu5mHAHy6C16d7Q3GILEnjCwRREaYKAc
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Close a race condition that causes cpr-transfer to lose VFIO
interrupts.  See commit messages for details.

Steve Sistare (2):
  vfio/pci: augment set_handler
  vfio/pci: preserve pending interrupts

 hw/vfio/cpr.c              | 93 +++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.c              | 15 +++++-
 hw/vfio/pci.h              |  4 +-
 include/hw/vfio/vfio-cpr.h |  6 +++
 4 files changed, 114 insertions(+), 4 deletions(-)

-- 
2.39.3


