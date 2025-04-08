Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DBAC369A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 22:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Hij-0006TN-TD; Tue, 08 Apr 2025 18:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2Hii-0006SE-68; Tue, 08 Apr 2025 18:47:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2Hif-0004y2-GI; Tue, 08 Apr 2025 18:47:03 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9rjK019437;
 Tue, 8 Apr 2025 22:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2023-11-20; bh=Cq5B1DF8N0G92LcSRJ+PntIDtww+0
 3PxRqmOmRZpy8A=; b=iNDoWoEh5LFEe5BIIjYDu2F2U4kYZl3XzJIv8ACWbcGrc
 hpyPTBYY0V9QD2EMmwUfCI8VI7l0Hdqydr20EWgqs37XEutE2KuVBvOV6V3tkjpF
 RreFRjG7TynHZL3THsjdugbZ8ShaDqPC7+JHwWfGHXnZqGBgIg9FIcJW85FdWXW7
 pplU1A/g8ISBLu65bWGl/Umei5EQ9TU6nQ72r1rZZLf5MdCEdyp8V+Tb3ONP29t7
 rnQEvjZrZquxaP1qT65o1fjAh1IVWKtKlvVEqAaaETczNEGAUgM/z4AxXxNUqfjq
 klGeyOAFx18SmZEVTx7oySFm1A3rqZBDYqdcfT9Hg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu41e11d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Apr 2025 22:46:54 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 538MQo6U001469; Tue, 8 Apr 2025 22:46:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttya068h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Apr 2025 22:46:52 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 538MkquA038560;
 Tue, 8 Apr 2025 22:46:52 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 45ttya068c-1; Tue, 08 Apr 2025 22:46:52 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, foss@defmacro.it, kbusch@kernel.org,
 its@irrelevant.dk, qemu-block@nongnu.org
Subject: [PATCH 0/1] hw/nvme: create parameter to enable/disable cmic on
 subsystem
Date: Tue,  8 Apr 2025 15:56:43 -0700
Message-ID: <20250408225644.814616-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_09,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080156
X-Proofpoint-ORIG-GUID: AIJ9ReDe5_6c01aD1kzakTyblTNa7PXu
X-Proofpoint-GUID: AIJ9ReDe5_6c01aD1kzakTyblTNa7PXu
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While testing Linux atomic writes with qemu-nvme v10.0.0-rc1, Linux was 
incorrectly displaying atomic_write_max_bytes
# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
0
# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
#
Since AWUPF was set to 15, it was expected atomic_write_max_bytes would
be set to 8192.

The commit cd59f50ab017 ("hw/nvme: always initialize a subsystem")
introduced this behavior. The commit hardcodes the subsystem cmic bit
to ON which caused the Linux NVMe driver to treat the namespace as
multi-pathed which uncovered a bug with how Atomic Write Queue Limits 
were being inherited.  This Linux issue is being addressed, but the
question was asked of why the subsystem cmic bit was hardcoded to ON.
Most NVMe devices today don't set cmic to ON. Shouldn't the setting of
this bit be a settable parameter? 

<subsystem>,cmic=BOOLEAN (default: off)

Example:
    -device nvme-subsys,id=subsys0,cmic=on \
    -device nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 \
    -drive id=ns1,file=/dev/nullb3,if=none \
    -device nvme-ns,drive=ns1,bus=nvme0,nsid=1,shared=false 

Alan Adamson (1):
  hw/nvme: create parameter to enable/disable cmic on subsystem

 hw/nvme/ctrl.c   | 5 ++++-
 hw/nvme/nvme.h   | 1 +
 hw/nvme/subsys.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.43.5


