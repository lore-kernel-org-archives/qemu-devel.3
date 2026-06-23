Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13804CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wboxc-0000DY-Cc; Mon, 22 Jun 2026 20:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxa-0000Bw-J9; Mon, 22 Jun 2026 20:25:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wboxZ-0003aE-3D; Mon, 22 Jun 2026 20:25:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJmhfP3896476; Tue, 23 Jun 2026 00:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7yXoFt6D4Qg/7a6P7pGwcoqRjWCFg2Syq4ULr9AUY
 S0=; b=QLMNjEK1xwPdqR6UOpi7DsV8E6hwfIsdlXa4pEQoVjtHWMIF+NzKqnLZJ
 0VbNOaW7qA3yw+l1viwzoRse9pL/MGeBIJi2HD6iRBCuTbnuFPOFgeurvbrZbFa2
 GaF+zVBVV5J27OLS38P6hKIHi9E9E46ub/oyExBjZGEa6rnuPr6QNe3kMxyObB98
 hVHkuGY8on7eRXAcsaZMj53pwHyxCVLYQ6n1rmvv2wdW5h5hSpEvqU3342LWemaU
 cLemhY0GtR9EeXC35HGXISOc7eQ2tQxyt0pXmGo99zihNz67GkP2rfbckAVDnY+o
 dlXorvbr172pqNFbcbO7d60HrIncw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hm62g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N0JdJu029842;
 Tue, 23 Jun 2026 00:25:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k0r8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 00:25:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N0Pghc9044550
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:25:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C5A655805D;
 Tue, 23 Jun 2026 00:25:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3C9D58059;
 Tue, 23 Jun 2026 00:25:41 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.116.241])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 00:25:41 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH 0/5] s390x: Fix intermittent errors with IPL from PCI devices
 on s390x
Date: Mon, 22 Jun 2026 20:25:34 -0400
Message-ID: <20260623002539.126124-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N-M9CUX0zwRhGvhK4FxnHNB3mrgWiBuh
X-Proofpoint-GUID: N-M9CUX0zwRhGvhK4FxnHNB3mrgWiBuh
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a39d288 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EVJvMxfN8bAWsRElkj0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXzQkU14aR1y4Z
 1UsjiRfeDODPrPnCTvZkDqffKhsUOUbLDUxskriOuNrveN0XCoumQ7q2gMJvx2LfhOBkOzh1rQl
 DTjlxCMkbSc9vhDgkmYMCCp1piIJr9t7MxXO6LEkf3OrRBK0r+e3d3EnVsFwOAVNqTRb3j7psrz
 jvIakQ3QOH7RgKBoaAZeEXiU1voT6/VHchU8ZNC1I6ZJrOO/8ZY3C10JiI3B8DwDegP1TUyrQvZ
 QI4zrrITtm6/UqIubPuPgCkrUZ9QZccr7oDTtb+uOWtILXSQ4/y8laTQ2rB0ROPrXa7jjPealUc
 V28aYsIESL70lJOGiTID86w1QR1ZpsF1/hDKDOCwMI7eE8sxeC3grQN6gMMfgVM80NIU6E3OX3i
 T6LHgwTKXNNxyk4qERRnHbZeQY06jA5OReKJ104rkg8dBjBpJjTnSU7NEPq2Jln37/QQqbJ948v
 9Zz2bcmBe6aLly6vQcg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwMCBTYWx0ZWRfXwEmpARRRLHE1
 qoJokDjEAeAlN4dCU0DKIzhitNcNMl6pfgp0HZq6/uf8RGrLYTzW2gRdWZoa3fW4FV1Q6RxBXD4
 syk2zP6+xnQyyRtLKUrZTvvzZC3mzTI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

When booting from a PCI device on s390x there may be intermittent failures
caused by mismatched byte swaps.  Refactor the byte swapping to ensure that
it is properly synchronized.

Correct how the queue notification offset is calculated so that it meets the
specification and may be used for multi-queue configurations in the future.

Handle some switch cases that were not caught for PCI devices.

Jared Rossi (1):
  pc-bios/s390-ccw: Verify virtio support when booting from PCI device
    on s390x

Joshua Daley (1):
  pc-bios/s390-ccw: write IPLB location for virtio-blk-pci IPL

Zhuoying Cai (3):
  pc-bios/s390-ccw: Refactor byte swapping
  pc-bios/s390-ccw: Add per-queue notification offset for multi-queue
    virtio configurations
  s390x: Enable boot menu for virtio pci device

 hw/s390x/ipl.c                |  1 +
 pc-bios/s390-ccw/main.c       |  5 ++-
 pc-bios/s390-ccw/virtio-pci.c | 57 ++++++++++++++++++++++++++---------
 pc-bios/s390-ccw/virtio-pci.h |  2 +-
 pc-bios/s390-ccw/virtio.c     | 27 +++++++++--------
 pc-bios/s390-ccw/virtio.h     |  2 ++
 6 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.54.0


