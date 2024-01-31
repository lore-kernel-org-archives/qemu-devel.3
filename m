Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13476C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 16:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVDq4-00037l-9E; Wed, 31 Jan 2024 11:53:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVDq2-00035P-MB
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:53:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.kanda@oracle.com>)
 id 1rVDq0-0007QW-OW
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 11:53:26 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40VEwu1O005688; Wed, 31 Jan 2024 16:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=lTydTREv6YFcLdU5Fpe6+J+Tfzvx/2dgyyF277WrhNU=;
 b=nfkxGnO2pE5Dq4Z8j5UGsEQQvMJt+7ElILr7RXfNAGi3gZf5JDrLxjl0/R1LHh7HFmMX
 wPrymhMclLCnaHtHtgR3OhPG2qIph219fDKmyoZnthAEmlor37BW4h4RXfvAKktEQ+WY
 glqQl8ZcEmomH8rz/MTC+2G/lUNKaXST57exX2/VQ4YMThzWqnepfZThBMva2KESCzAQ
 j5MMXAPi6MO75gCSUSCgSrDIA6Czxy7F02b1z1QypRY7qicI2ToScgGtC9ezX2Z6TMWh
 1xR5L3n+L24xo/MIl4rKUbvTD63/JRdPxEM2vZDvHE5QQwgc9XcUO+2SZWascuPsTN+P 2g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsvdtcar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 16:53:22 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40VGmaqk025958; Wed, 31 Jan 2024 16:53:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vvr99cfx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 Jan 2024 16:53:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VGmwZP013355;
 Wed, 31 Jan 2024 16:53:20 GMT
Received: from linux-3.us.oracle.com (dhcp-10-39-210-13.vpn.oracle.com
 [10.39.210.13])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3vvr99cfs6-1; Wed, 31 Jan 2024 16:53:20 +0000
From: Mark Kanda <mark.kanda@oracle.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com, pbonzini@redhat.com, mark.kanda@oracle.com,
 berrange@redhat.com
Subject: [PATCH v4 0/1] Initialize backend memory objects in parallel
Date: Wed, 31 Jan 2024 10:53:26 -0600
Message-Id: <20240131165327.3154970-1-mark.kanda@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310131
X-Proofpoint-ORIG-GUID: 6TstF9quxS3DOxmIcbBkNIC0A8KtQKYy
X-Proofpoint-GUID: 6TstF9quxS3DOxmIcbBkNIC0A8KtQKYy
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

v4:
- remove unneeded async check from host_memory_backend_set_prealloc()
- rename qemu_finish_async_mem_prealloc -> qemu_finish_async_prealloc_mem
- use new phase PHASE_LATE_BACKENDS_CREATED for async

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

 backends/hostmem.c     |   7 ++-
 hw/virtio/virtio-mem.c |   4 +-
 include/hw/qdev-core.h |   5 ++
 include/qemu/osdep.h   |  18 +++++-
 system/vl.c            |   9 +++
 util/oslib-posix.c     | 131 +++++++++++++++++++++++++++++++----------
 util/oslib-win32.c     |   8 ++-
 7 files changed, 145 insertions(+), 37 deletions(-)

-- 
2.39.3


