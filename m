Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF9BC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuIRH-0004QE-SI; Wed, 12 Aug 2026 19:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRE-0004PD-7b
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1wuIRC-0001Ro-5m
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 19:32:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CEooaT813932; Wed, 12 Aug 2026 23:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=l7DC6XjFIpBnBkC8J26vLiU4paiPG
 yHsrmqdczZ90vM=; b=fb7OKDTpGhwMRUHlKeN1bsTyQpK0U/JBU+ny4/U7oRAk0
 QJITRQNeizLN3Wh1bW7rjjaYNYuufVfcFs/m/v4uHVp0LrPBPuQ3JilBKPiXvtUi
 pfxxyHHUQ4aabdepjz319L5vHXL0Qr1rOsROmMLlu6kKLTL20ObWZh/lI9Las073
 Nzw0iJ+Y4ITCSBaFKTB7IAzevpJAXEo9ULB2VD+vdIHTfzBgnE9GA2cxNNEX3o+g
 RAfsQLQJzNO01uPKI7UE1Q4y6+XjJInx0Ach2A45gqjTi8UyUhLCCutXvg52CcDV
 cCXC6P/1mTo2UDLN+IuHNnkggCN8UuHn31wOLGOKA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fww0sykh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:38 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 67CNTxYn017358; Wed, 12 Aug 2026 23:32:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4fwtwfngr1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 23:32:38 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67CNWbHW025569;
 Wed, 12 Aug 2026 23:32:37 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4fwtwfngqu-1; Wed, 12 Aug 2026 23:32:37 +0000 (GMT)
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com, 
 maciej.szmigiero@oracle.com, mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: [PATCH 0/5] Support diskless memfd transport for cpr-exec
Date: Wed, 12 Aug 2026 16:27:45 -0700
Message-ID: <20260812232842.470225-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608120190
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfX5V1DqrHffEUJ
 S3wIiJ4o5nkS04DbfESBOBxjKd22TduQIoD0hZiZf8a3j10XX2FvhhVcDSF21QGvcXD7rJ0q3ul
 T95r2HYhgh8yBfRzj3weQ0CwVUjes9V+d2YRYx+6vSBpUYbHo7ot
X-Proofpoint-ORIG-GUID: 17KjzQifoahG2VIvEZHlJVQRDfdlryWf
X-Proofpoint-GUID: 17KjzQifoahG2VIvEZHlJVQRDfdlryWf
X-Authority-Analysis: v=2.4 cv=FcAHAp+6 c=1 sm=1 tr=0 ts=6a7d0296 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=1-XZeR_0vE17Cy7aLM4A:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE5MCBTYWx0ZWRfXyl4jHg1rUn8W
 rvaYmeXUuJVLv9zqnWSe3ivE1OYh5ivgn8bVjpbP7FNRg1cLU+xcR4dNuhO/nsTPt+3ic8OlzqX
 NIMi4IykyiIUAmsJ2R0R1D6Pszy4vYt1fQafY9BW2pE+OOza/0NYnwZyo+tRCbA9s9W9LAqiQzQ
 p7p9rMpQCmzEX8X/KBSYb/N0rhIj/+WIRrtKh5ydiy5I31JADdBFZmhK6vuqxHOPwUc0aPXas7c
 6ZiP3lcy3iV8LhxDFbRkK/i1dnApbWaHiZN1jkFwt1mC7t0JvNgfaAyvRT092SnkKCJBaBRGYH6
 mi6hOSO+VWGIcr5P444N7DzfHXZs1cbx/RCoDUXIlJgSQwVqA4f0CJUDL+okx5fTWka0S8WZ+99
 In7367fvDPGRfqLMkZ+vG5grKwp31dTiyylXS6HYpxirwm8yuYEifv7IwpweSZBRgDRNqws8Awy
 vQ33AYJrHcfMouImZZA==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, cpr-exec requires a file to save and load VM/device state.

Introduce a diskless approach so cpr-exec no longer relies on disk storage
for this state. The main idea is to add a new memfd-based migration
transport: instead of using a file, VM/device state is saved to and loaded
from an inherited memfd.

I tested this with virtio-blk, NVMe VFIO, and virtio-net.

/home/opc/ext4/qemu/build/qemu-system-x86_64 \
-machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on \
-accel kvm -cpu host \
-name debug-threads=on \
-m 8G -smp 4 \
-object memory-backend-memfd,id=ram0,size=8G,share=on \
-device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 \
-drive file=ol89.qcow2,if=none,id=drive0 \
-object iommufd,id=iommufd0 \
-device vfio-pci,host=0000:82:00.0,iommufd=iommufd0,id=vfio0,x-no-mmap=on \
-device virtio-net-pci,netdev=tapnet,mq=true,vectors=9,mac=52:54:11:22:14:49 \
-netdev tap,id=tapnet,script=qemu-ifup,downscript=no,queues=2,vhost=off \
-vnc :8 -monitor stdio

(qemu) migrate_set_parameter mode cpr-exec

(qemu) migrate_set_parameter cpr-exec-command /home/opc/ext4/qemu/build/qemu-system-x86_64 -machine q35,dump-guest-core=off,memory-backend=ram0,aux-ram-share=on -accel kvm -cpu host -name debug-threads=on -m 8G -smp 4 -object memory-backend-memfd,id=ram0,size=8G,share=on -device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4 -drive file=ol89.qcow2,if=none,id=drive0 -object iommufd,id=iommufd0 -device vfio-pci,host=0000:82:00.0,iommufd=iommufd0,id=vfio0,x-no-mmap=on -device virtio-net-pci,netdev=tapnet,mq=true,vectors=9,mac=52:54:11:22:14:49 -netdev tap,id=tapnet,script=qemu-ifup,downscript=no,queues=2,vhost=off -vnc :8 -monitor stdio -incoming defer

(qemu) migrate -d memfd:
QEMU 11.1.50 monitor - type 'help' for more information

(qemu) info status
VM status: paused (inmigrate)

(qemu) migrate_incoming memfd:

(qemu) info status
VM status: running


Dongli Zhang (5):
  migration/qapi: Add memfd migration transport
  migration: Add generic memfd channel helpers
  migration/cpr-exec: Add memfd helpers
  migration/cpr-exec: Support diskless memfd transport
  migration: cpr-exec memfd transport documentation

 docs/devel/migration/CPR.rst | 24 +++++++++++
 migration/channel.c          |  7 +++
 migration/cpr-exec-memfd.c   | 90 +++++++++++++++++++++++++++++++++++++++
 migration/cpr-exec-memfd.h   | 18 ++++++++
 migration/cpr-exec.c         |  9 ++++
 migration/memfd.c            | 90 +++++++++++++++++++++++++++++++++++++++
 migration/memfd.h            | 19 +++++++++
 migration/meson.build        |  2 +
 migration/migration.c        |  9 ++++
 qapi/migration.json          | 32 +++++++++++---
 10 files changed, 295 insertions(+), 5 deletions(-)

base-commit: e8d693e12af9cbb89d724baadfcc08559669e279

Thank you very much!

Dongli Zhang



