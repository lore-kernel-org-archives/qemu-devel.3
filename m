Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55098C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 23:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwVzG-0002a2-5o; Mon, 15 Apr 2024 19:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1rwVzA-0002Xx-8X; Mon, 15 Apr 2024 19:43:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1rwVz7-0000YJ-NA; Mon, 15 Apr 2024 19:43:39 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43FNF98a027633; Mon, 15 Apr 2024 23:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=W9feHLyyMT6KOV00+MsVXU+/gKGDwdmxLhlzDDzFoio=;
 b=Ntqb0cjo2oeEabtHZgFQ77qXMckI3F4J0O5dsodptGRX4Z7z3oqX40HKBIxuYQy3YIL0
 wWYgDu4qBrMVBYXw4fR4QF4YtorSDijj6RDZsmE3jrSJU3nEd3kgPWfs6S37Iqu/D1v6
 vnd6/X3pHVxXCcNBoh6GDmOEJ03Hdep2ECsvshL8YhTJbpE6PbRyRFZto108p5R8x8dk
 M+HpGHd4C6l4a8EJ3iKnMwrknSZKT4l6Cc3rnVI7Ibabv27ePaKZRXVYmCDrf2+1h++y
 ajMh6s3wYdtl/1JLOoFuG2YT2jfnT4pwER9lQmPN8Jal6k341pp0iFh+n6b2wkbiLxCW aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgycm0t8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 23:43:28 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 43FMYeYx004328; Mon, 15 Apr 2024 23:43:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3xfggcquh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Apr 2024 23:43:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43FNhQpc021896;
 Mon, 15 Apr 2024 23:43:26 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3xfggcqucj-1; Mon, 15 Apr 2024 23:43:26 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: qemu-devel@nongnu.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, its@irrelevant.dk,
 qemu-block@nongnu.org
Subject: [RFC 0/1] hw/nvme: add atomic write support
Date: Mon, 15 Apr 2024 16:46:38 -0700
Message-Id: <20240415234639.3021291-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_19,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150159
X-Proofpoint-ORIG-GUID: uctqGBtZZ_cNA2w8sglXmsj-KxCRoeiC
X-Proofpoint-GUID: uctqGBtZZ_cNA2w8sglXmsj-KxCRoeiC
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Since there is discussion in the Linux NVMe Driver community to add NVMe Atomic Write
support, it would be desirable to test it with qemu nvme emulation.
 
Initially, this RFC will focus on supporting NVMe controller atomic write parameters(AWUN,
AWUPF, and ACWU) but will be extended to support Namespace parameters (NAWUN, NAWUPF
and NACWU).
 
Atomic Write Parameters for NVMe QEMU
-------------------------------------
New NVMe QEMU Parameters (See NVMe Specification for details):
        atomic.dn (default off) - Set the value of Disable Normal.
        atomic.awun=UINT16 (default: 0)
        atomic.awupf=UINT16 (default: 0)
        atomic.acwu=UINT16 (default: 0)
 
qemu command line example:
        qemu-system-x86_64 -cpu host --enable-kvm -smp cpus=4 -no-reboot -m 8192M -drive file=./disk.img,if=ide \
        -boot c -device e1000,netdev=net0,mac=DE:CC:CC:EF:99:88 -netdev tap,id=net0 \
        -device nvme,id=nvme-ctrl-0,serial=nvme-1,atomic.dn=off,atomic.awun=63,atomic.awupf=63,atomic.acwu=0 \
        -drive file=./nvme.img,if=none,id=nvm-1 -device nvme-ns,drive=nvm-1,bus=nvme-ctrl-0 nvme-ns,drive=nvm-1,bus=nvme-ctrl-0
 
Making Writes Atomic:
---------------------
- Prior to a command being pulled off the SQ and executed, a check is made to see if it
  conflicts "atomically" with a currently executing command.
- All currently executing commands on the same namespace, across all SQs need to be checked.
- If an atomic conflict is detected, the command is not started and remains on the queue.
 
Testing
-------
NVMe QEMU Parameters used: atomic.dn=off,atomic.awun=63,atomic.awupf=63,atomic.acwu=0
 
# nvme id-ctrl /dev/nvme0 | grep awun
awun      : 63
# nvme id-ctrl /dev/nvme0 | grep awupf
awupf     : 63
# nvme id-ctrl /dev/nvme0 | grep acwu
acwu      : 0    < Since qemu-nvme doesn't support Compare and Write, this is always zero
# nvme get-feature /dev/nvme0  -f 0xa
get-feature:0x0a (Write Atomicity Normal), Current value:00000000
#
 
# fio --filename=/dev/nvme0n1 --direct=1 --rw=randwrite --bs=32k --iodepth=256 --name=iops --numjobs=50 --verify=crc64 --verify_fatal=1 --ioengine=libaio
 
When executed without atomic write support, eventually the following error will be
observed:
 
        crc64: verify failed at file /dev/nvme0n1 offset 857669632, length 32768
(requested block: offset=857669632, length=32768, flags=88)
            Expected CRC: 9c87d3539dafdca0
            Received CRC: d521f7ea3b69d2ee
 
When executed with atomic write support, this error no longer happens.
 
Questions
---------
AWUN vs AWUPF - Does the nvme emulation need to do treat these differently? Currently the
larger of the two will be used as the max atomic write size.
 
Future Work
-----------
- Namespace support (NAWUN, NAWUPF and NACWU)
- Namespace Boundary support (NABSN, NABO, and NABSPF)
- Atomic Compare and Write Unit (ACWU)

Alan Adamson (1):
  nvme: add atomic write support

 hw/nvme/ctrl.c | 147 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  17 ++++++
 2 files changed, 163 insertions(+), 1 deletion(-)

-- 
2.39.3


