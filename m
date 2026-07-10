Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C095C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiCPt-0000jR-Kx; Fri, 10 Jul 2026 10:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPn-0000ey-0h
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wiCPl-0005VE-3n
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 10:41:18 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ADIC411212225; Fri, 10 Jul 2026 14:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dOH6/D7smKp+iU17VebbwyH6QbmltiUz/3QF9KNOK
 No=; b=cxIraVkePNhW6dTZynAvSr5+FYAsZHdhmOjMggfyf8QCRo1DTw89MpOLD
 0XLbPPfN5rzkHTePXIlNxHNzosvdvUNiYbilzBeYNLAWAE7CUvEG2w7mgygpbpJ3
 35d9dd4KqRfNekm8jXi4Xi7Mo+yXyFKjjtlRaDwlVzdi8XX+F+erYtUoqek51yyP
 n+D2Mnd+5rH/QvsRvflQ15S0xT2UGunW4aCpArRfPrPBJ7J2yplgb7ad5Q4KsKP8
 /fStek7eMoHOlm/VNwqdiGfYEAy30wyKXVwWiUipSylvE3yWFkuMAVtI+2EsDGNX
 Dee5E8cvWSM5FNhOKnvE5q70mRSLw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fafh0cgsx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66AEYmgk013549;
 Fri, 10 Jul 2026 14:41:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0htb7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jul 2026 14:41:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66AEfAF321758572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jul 2026 14:41:11 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D35E55805C;
 Fri, 10 Jul 2026 14:41:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 542FB5805A;
 Fri, 10 Jul 2026 14:41:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jul 2026 14:41:10 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PULL v1 0/3] Merge tpm 2026/07/10 v1
Date: Fri, 10 Jul 2026 10:41:05 -0400
Message-ID: <20260710144108.621828-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VebH+lp9 c=1 sm=1 tr=0 ts=6a510489 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8 a=NEAV23lmAAAA:8
 a=kILJIRLdMjHf4_WiUX0A:9
X-Proofpoint-GUID: xXsAeJZz7S1uX5uDwo64pUx8J2lZGk1m
X-Proofpoint-ORIG-GUID: xXsAeJZz7S1uX5uDwo64pUx8J2lZGk1m
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX5v0nx3A+rnmn
 TitBXEmfTWOcfDphCoUjnwJcyWDuB6c87DA/rRqbOTu4JoUr/PPLJctFCbHy2Ag68xaL/Gbf8pN
 DcK4Bf8TIz4GPnpixLpDiPD9oQhxBvk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE0MiBTYWx0ZWRfX0ar6Irjrfezu
 GkRZkBH8e3+n9hrMbOsytcouCKoWq1r1YTQWjiPigEZNR0AoJ440yLdHiact7wA+YpdQoaIg4f2
 f4N+jP1DNf8nyyskAk9xsZNyquwbgRIvQ0+s6YvSiXaNp7fOaplH45ZlibEAjIYDAeBprMWOzAz
 +WX8Wu9V000Hi1Lrm4TFW9XkV11dLL2+FhfbsBHbghVDOV527niGscEBwegKgCObWpLgk4cjbwT
 epygqIbWt+h7gnZo34IjmltxFa5eqzuui7rTnNqbI/O4Y62pTVHIrTK7Q3vU2XM6THWkUhOALYy
 hXw7hzID+YFicEaZnCRdyBKBvrLY6+bFe6mpCfVt9xozzRYE/D24yYTU8ivrtAmMPEun6ETp5Tv
 5hAkRtDp6ec3/Vu6/0JMvnxLU7eNjUGIYq847R6xfwzc8HS+eSgFtRM0KKhxDcJ4D2daF3WvYoW
 G93teT3/rVIcf6Q79xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100142
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
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

The following changes since commit ab2056a0b7c944b16b224a8feabd99023772ae91:

  Merge tag 'pull-ufs-20260709' of https://gitlab.com/jeuk20.kim/qemu into staging (2026-07-09 12:04:14 +0200)

are available in the Git repository at:

  https://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2026-07-10-1

for you to fetch changes up to 5e33de4f00c25f12afdf02481e0dd4013a7e96b9:

  hw/core/machine: disable tpm-tis-device PPI for machine type <= 11.0 (2026-07-10 10:29:27 -0400)

----------------------------------------------------------------

This series of patches fixes a backwards compatibility issue related to
migration of VMs on aarch64.

----------------------------------------------------------------

Mohammadfaiz Bawa (3):
  hw/core/platform-bus: guard platform_bus_get_mmio_addr() against NULL
  hw/tpm: gate PPI support on tpm-tis-device behind a device property
  hw/core/machine: disable tpm-tis-device PPI for machine type <= 11.0

 hw/core/machine.c       |  1 +
 hw/core/platform-bus.c  |  3 +--
 hw/tpm/tpm_tis.h        |  1 +
 hw/tpm/tpm_tis_sysbus.c | 18 +++++++++++-------
 4 files changed, 14 insertions(+), 9 deletions(-)

-- 
2.55.0


