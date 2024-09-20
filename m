Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269F1CF3973
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 00:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srR7d-00035k-KX; Thu, 19 Sep 2024 20:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1srR7a-00033Y-DJ; Thu, 19 Sep 2024 20:03:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1srR7X-0003Qo-OV; Thu, 19 Sep 2024 20:03:38 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48JLN9mc010092;
 Fri, 20 Sep 2024 00:03:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=corp-2023-11-20; bh=/2NNYjOkAxdbdq
 n/DlsO4FCAB9/eG5reVNgJlrfBgRk=; b=QzhH1ISy8pbrKuYUdA38aDRx5Nh2zt
 L2sYAqVYDmey+/QohuvsuEtLotZOgcEcYrgPkDaayJn8uyKxAcqfpTgW6B2w7s4Q
 Qxl2eiGEbSzHEOC/W6e3bZKod1rctHOHeelIBOxqkF6Ou+cKBw6Sf4Zgh39jX9xi
 ER8MtpLkaQeYKv3qIsrCRed63X759UxekYFkIslnecNnk6yqxqGMn1/UedvQ/ElH
 luS1Z9/YunVRLn2trPxMfMApadKBXHH6mTMPB/V4rryodJaAQd2i22/ZhrHaYD12
 BJUNuJtTgJ/VkCyTBixvJlgmq3H9dhhKzBwIo7fIHMXB2ioAw9hSyl4g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3n3nf3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 00:03:26 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48JLmQLW034049; Fri, 20 Sep 2024 00:03:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 41nycmg2dk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Sep 2024 00:03:25 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48K03Pr8023686;
 Fri, 20 Sep 2024 00:03:25 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 41nycmg2cn-1; Fri, 20 Sep 2024 00:03:25 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, its@irrelevant.dk,
 qemu-block@nongnu.org
Subject: [PATCH v2 0/1] hw/nvme: add atomic write support
Date: Thu, 19 Sep 2024 17:07:20 -0700
Message-ID: <20240920000721.993119-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_22,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409190161
X-Proofpoint-GUID: mu7GDz0nuLB02xqLHrMC5AesjLpXfb56
X-Proofpoint-ORIG-GUID: mu7GDz0nuLB02xqLHrMC5AesjLpXfb56
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Changelog:

v2:	- Include changes suggested by Klaus
	- Check for READ/WRITE commmands when walking SQs.
	- Updated the "cover-letter" below with new fio example.

=====================================================================================

Since there is work in the Linux NVMe Driver community to add Atomic Write
support, it would be desirable to be able to test it with qemu nvme emulation.
 
This patch will focus on supporting NVMe controller atomic write parameters (AWUN and
AWUPF) but can be extended to support Namespace parameters (NAWUN and NAWUPF)
and Boundaries (NABSN, NABO, and NABSPF).
 
Atomic Write Parameters for NVMe QEMU
-------------------------------------
New NVMe QEMU Parameters (See NVMe Specification for details):
        atomic.dn (default off) - Set the value of Disable Normal.
        atomic.awun=UINT16 (default: 0)
        atomic.awupf=UINT16 (default: 0)
 
qemu command line example:
        qemu-system-x86_64 -cpu host --enable-kvm -smp cpus=4 -no-reboot -m 8192M -drive file=./disk.img,if=ide \
        -boot c -device e1000,netdev=net0,mac=DE:CC:CC:EF:99:88 -netdev tap,id=net0 \
	-device nvme,id=nvme-ctrl-0,serial=nvme-1,atomic.dn=off,atomic.awun=15,atomic.awupf=7 \
        -drive file=./nvme.img,if=none,id=nvm-1 -device nvme-ns,drive=nvm-1,bus=nvme-ctrl-0 nvme-ns,drive=nvm-1,bus=nvme-ctrl-0
 
Making Writes Atomic:
---------------------
Currently, as the nvme emulator walks through the Submission Queue (SQ)
(nvme_process_sq()), it takes each request (read/write/etc) off the SQ and starts its
execution and then continues on with the next SQ entry until all entries are started. It
is likely, multiple requests (from multiple SQs) will be executing in parallel and acting
on a common LBA range.  This prevents writes from completing atomically. When a write
completes atomically, either all or none of the LBAs will be committed to media.  This
means writes to a common LBA range can not be done in parallel if writes are going to
be atomic. The nvme emulator does not currently guarantee this and LBAs
from multiple requests may get committed.  The fio test shown below, comfirms this.
 
Prior to taking a command off of a SQ, a check needs to be done to determine if it
conflicts atomically with a currently executing command.
 
bool nvme_atomic_write_check() - Checks a NVMe command to determine if it can be started,
or if it conflicts atomically with a currently executing command.
 
Returns:   NVME_ATOMIC_NO_START - The command atomically conflicts with a currently
           executing command and can not be started.
 
           NVME_ATOMIC_START_ATOMIC  - The command is an atomic write, does not
           conflict atomically with a currently executing command, and can be started.
 
           NVME_ATOMIC_START_NONATOMIC - The command is not an atomic write, but it
           can be started.

If a command is blocked from being started, nvme_process_sq() needs to be rescheduled.
 
Implementation:
---------------
Each SQ maintains a list of executing requests (sq->out_req_list). When a command is
taken off the SQ to start executing it, it is placed on out_req_list and removed when
the command completes and placed on the Completion Queue (CQ). When nvme_process_sq()
is executing and looking to take a command off the SQ, nvme_atomic_write_check() is
called to determine if it is atomically safe to start executing the command. If it is
safe, nvme_atomic_write_check() will return NVME_ATOMIC_START_ATOMIC or
NVME_ATOMIC_START_NONATOMIC. nvme_process_sq() then pulls the command off the SQ,
places an associated request onto out_req_list. If it is not atomically safe,
(nvme_atomic_write_check() returns NVME_ATOMIC_NO_START). The command remains on the SQ,
and processing of that SQ stops and nvme_process_sq() will be rescheduled.
When nvme_atomic_write_check() is called, the out_req_list for each SQ is walked and the
LBA range of the command to be started is compared with each executing request.

What is the Maximum Atomic Write Size?
--------------------------------------
By default the qemu parameter atomic.awun specifices that maximum atomic write size which
will be used by maximum atomic Write size. If Disable Normal is set to true with qemu
parameter atomic.dn or with the SET FEATURE command, the atomic.awupf value will specify
the maximum atomic write size.

Testing
-------
NVMe QEMU Parameters used: atomic.dn=off,atomic.awun=63,atomic.awupf=63
 
# nvme id-ctrl /dev/nvme0 | grep awun
awun      : 15
# nvme id-ctrl /dev/nvme0 | grep awupf
awupf     : 7
# nvme id-ctrl /dev/nvme0 | grep acwu
acwu      : 0    < Since qemu-nvme doesn't support Compare and Write, this is always zero
# nvme get-feature /dev/nvme0  -f 0xa
get-feature:0x0a (Write Atomicity Normal), Current value:00000000
#

fio testing - using upstream version fio-3.37-124 (includes atomic write support) 
---------------------------------------------------------------------------------
# fio --filename=/dev/nvme0n1 --direct=1 --rw=randwrite --bs=8k --iodepth=256 --name=iops --numjobs=50 --ioengine=libaio --loops=10 --verify=crc64 --verify_write_sequence=0
Since the block size passed into fio is 8k, this is <= the maximum atomic blocksize (awun=15(8k)), this test will always succeed. 

# fio --filename=/dev/nvme0n1 --direct=1 --rw=randwrite --bs=64k --iodepth=256 --name=iops --numjobs=50 --ioengine=libaio --loops=10 --verify=crc64 --verify_write_sequence=0
Since the block size passed into fio is 64k, which is > the maximum atomic blocksize (awun=15(8k)), this test will eventually fail with:
crc64: verify failed at file /dev/nvme0n1 offset 347799552, length 65536 (requested block: offset=347799552, length=65536, flags=88)
       Expected CRC: d54d5f50d2569c94
       Received CRC: 691e1aed4669ba33 

Future Work
-----------
- Namespace support (NAWUN, NAWUPF and NACWU)
- Namespace Boundary support (NABSN, NABO, and NABSPF)
- Atomic Compare and Write Unit (ACWU)

Alan Adamson (1):
  hw/nvme: add atomic write support

 hw/nvme/ctrl.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  12 ++++
 2 files changed, 175 insertions(+), 1 deletion(-)

-- 
2.43.5


