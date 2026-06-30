Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09438C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 14:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weZJB-000316-3q; Tue, 30 Jun 2026 10:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJA-00030u-CK; Tue, 30 Jun 2026 10:19:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1weZJ8-0005U6-O7; Tue, 30 Jun 2026 10:19:28 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIlBE2429646; Tue, 30 Jun 2026 14:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=F3S14cRfglZUXzS0XFeBBm14YuG+pX37nxQ5KECID
 pg=; b=TeGYuXimi4ObfVheb02QGQw2tuHsHDqfFnX0ncxr1RrjlnlymXwjWuqCK
 tpUR++f2yNezczjtWdPo/xHcvgDtu1KWsCw9n4Y4d/TpZIEHZsNaqcvHKYopjtQ+
 yG4ug2h+byoScyKA3rmcmGzCXi/QK45g0XiCauyry7VA2zInc0z6+2GSzDCW3mx5
 emO4j3kEhubtQPa4ZRmYAVLnqJH9MNBk+vkXE/WlWW16QtlSBqLQtF6KpqwtnIwH
 V7DHYLib+jlDjJYRBqHvTC4GmNJCTqGc/NdCKoJpCwsF2WgxDNxKS4jlaUmW+viJ
 5jSV1EmAM2Vw+mBkWlUiHoaYm21VQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfy716-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UE4acc000851;
 Tue, 30 Jun 2026 14:19:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqatkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 14:19:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UEJK4k22807090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 14:19:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA3745805D;
 Tue, 30 Jun 2026 14:19:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C398558043;
 Tue, 30 Jun 2026 14:19:19 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.10.219])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 14:19:19 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: jrossi@linux.ibm.com, zycai@linux.ibm.com, jdaley@linux.ibm.com,
 jjherne@linux.ibm.com, farman@linux.ibm.com, nrb@linux.ibm.com
Subject: [PATCH v2 0/6] s390x: Fix intermittent errors with IPL from PCI
 devices on s390x
Date: Tue, 30 Jun 2026 10:19:11 -0400
Message-ID: <20260630141917.673995-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43d06b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ofBkBVCz4bjBFbFzGRQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX4KnMIjzOGEHv
 O7Dq1CphSHobkNM4eDXoqYx8apP2Kh3l6t+7HDhXQfoGlc3WADbKC+/bBFCfLzXTu0uWFvKPRgv
 7g/IRoakavrXf0maVhx+VmBCU6J/jC0=
X-Proofpoint-GUID: BVbek8cFs2WS2kyA8ZWwdbThIbUSX1U7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzNCBTYWx0ZWRfX2jMh3VHZqY01
 e+5k5JtHAOSWC3H7hbgXGxTG1dIULm/0WIlvHohIGUTBJV96gu9MYbFoBnI+ikEtkj5Z6rxQTkt
 3chP5lmm7FS613oeDhjbAAZVUwdpQ1Whcrv59nYgnVFWbv6gjwMcGolUFAuTeI3rvQf78sPNgJo
 Ligk/9Fu95TVpeeqJADdrrfkx9a1H96+mfkXpXVQw+DZq8vXRdTvmFbvZ39OHvTy5YC83wZ5PrN
 KOutZQYwGUKNWol8upNua2J4Z2NMYcOk1cvPs+PgCHQE57lSo0+unOD2cPrKpA7X/N/lRW8fn3t
 sPaKC+eW09/BSNu+VTgMuN+lpSvNRV56LiyTCzLZv3k+c0kdVNwucxalI1uHmXNz9c6LYfMjb29
 L0Bk+ErSRjNBaqsI6VRZ0uP6pFnzXTFd7z0cn7A2g0MsGzXsTSAwk6STOsAhsxxoE6FtUGux7dk
 NWwe10Ma/LYlcJb6yYw==
X-Proofpoint-ORIG-GUID: BVbek8cFs2WS2kyA8ZWwdbThIbUSX1U7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300134
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Correct how the queue notification offset is calculated so that it may be
used for multi-queue configurations in the future.

Handle some switch cases that were not caught for PCI devices.

Changes v1 -> v2:
    - Split addition of missing break into its own patch
    - Add PCI case to generic is_viritio_supported() wapper
    - Switch the order of patches formerly 3 and 4
    - Use virtio_is_supported() instead of checking cutype when writing IPLB
        location to cover both CCW and PCI virtio devices

Jared Rossi (3):
  pc-bios/s390-ccw/virtio.c: Fix missing break for PCI notifications
  pc-bios/s390-ccw: Verify virtio support when booting from virtio PCI
    device on s390x
  pc-bios/s390-ccw: write IPLB location for non-net virtio devices

Zhuoying Cai (3):
  pc-bios/s390-ccw: Refactor byte swapping
  pc-bios/s390-ccw: Add per-queue notification offset for multi-queue
    virtio configurations
  s390x: Enable boot menu for virtio pci device

 hw/s390x/ipl.c                |  1 +
 pc-bios/s390-ccw/main.c       |  5 ++-
 pc-bios/s390-ccw/virtio-pci.c | 57 ++++++++++++++++++++++++++---------
 pc-bios/s390-ccw/virtio-pci.h |  5 ++-
 pc-bios/s390-ccw/virtio.c     | 29 ++++++++++--------
 pc-bios/s390-ccw/virtio.h     |  2 ++
 6 files changed, 69 insertions(+), 30 deletions(-)

-- 
2.54.0


