Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D8FC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 13:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVAxJ-0003d2-VP; Wed, 31 Jan 2024 08:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVAx9-0003bI-SW
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:48:36 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVAx7-000539-AX
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 08:48:35 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VD3fNF003818; Wed, 31 Jan 2024 13:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=2kwTwt5rnJbt2862S/MGaYuHd9/HNoUnXGIu3g+6Wto=;
 b=TQC0+tNvLKlwTUzNnmPrVr3styFAQ4yFDifqfEu96F7Vragy7O9NFTehtJEdRtMVjSED
 ZFli8njTArRcgSzOiRn7q/rofXaeBnCQ/2z7zgvyTPKYvybYMHlC/Lc1M25VDy4cVrGS
 kLmno71kW3JkNZHli4eUf/pT1MBjiYD522dUTJOBRnjYZDShRndEXHX1/OsWE/OYedFm
 gxFOoPKsjNPnTLo0EINFR8+HNN1Ti2+n9u6eiLe/XxIAkCtc5nhKU+pvLvFhejwJCVVp
 OpclymHnhlJWXjqnrYe/pTQ4obrGFPKhsyNOWeZvUkzFrVGBayEU9MRusth3pOoVNaZw /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdsup9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 13:48:29 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40VDKBxK014589; Wed, 31 Jan 2024 13:48:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr9f3epd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 13:48:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VDmSxG007814;
 Wed, 31 Jan 2024 13:48:28 GMT
Received: from linux-3.us.oracle.com (dhcp-10-39-210-13.vpn.oracle.com
 [10.39.210.13])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3vvr9f3ep1-1; Wed, 31 Jan 2024 13:48:28 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com,
 berrange@redhat.com
Subject: [PATCH v3 0/1] Initialize backend memory objects in parallel
Date: Wed, 31 Jan 2024 07:48:42 -0600
Message-Id: <20240131134843.3074922-1-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=903
 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310106
X-Proofpoint-ORIG-GUID: LeZs0ZoQz0gGq2mcBwCsIjdRkE9nEiQy
X-Proofpoint-GUID: LeZs0ZoQz0gGq2mcBwCsIjdRkE9nEiQy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=mark.kanda@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v3:
- squash into a single patch
- use global context list for async handling only (MT capability)
- add BQL asserts to guard against concurrent async prealloc requests
- clean up qemu_finish_async_mem_prealloc() error handling

Includes David's suggested restructuring [1] (with David's SoB).

[1] https://lore.kernel.org/qemu-devel/c15161eb-f52c-4a82-8b4b-0ba03842188c@redhat.com/

v2:
- require MADV_POPULATE_WRITE (simplify the implementation)
- require prealloc context threads to ensure optimal thread placement
- use machine phase 'initialized' to determine when to allow parallel init

QEMU initializes preallocated backend memory when parsing the corresponding
objects from the command line. In certain scenarios, such as memory being
preallocated across multiple numa nodes, this approach is not optimal due to
the unnecessary serialization.

This series addresses this issue by initializing the backend memory objects in
parallel.

Mark Kanda (1):
  oslib-posix: initialize backend memory objects in parallel

 backends/hostmem.c     |   8 ++-
 hw/virtio/virtio-mem.c |   4 +-
 include/qemu/osdep.h   |  18 +++++-
 system/vl.c            |   8 +++
 util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
 util/oslib-win32.c     |   8 ++-
 6 files changed, 140 insertions(+), 37 deletions(-)

-- 
2.39.3


