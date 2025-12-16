Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF4FD609A9
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVWkh-0006mT-Un; Tue, 16 Dec 2025 10:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkg-0006lu-Sq; Tue, 16 Dec 2025 10:14:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vVWkf-0006sZ-7N; Tue, 16 Dec 2025 10:14:14 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGEhlee001615;
 Tue, 16 Dec 2025 15:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=jJWxWd0S0YUPymrmDoOQJ0f2xp9S05gEcaGVGWAr8
 uE=; b=W2HLPtTSslw7kykyS3AWXVuCl426GkabymWHs7JjAkXNf9zobNAcQfes4
 5qrmfC0ew7y1u8ef0YpWbjbME+WP8jjw1X/7B0JFGfmXvyjhuQp6aE3qw+byNR+j
 O0jm77DWB1O/AstSJkP8HrFYp8m8l5i926D0H0oqvYrr2WmcoY7a5RDoZolnKSbV
 cyTs9o1Nh6624Od79GBmu1qS+vQS2+MyG6h+qRvSuqUP4+PVAbeCnZ8LpDrB+5j2
 vGOg4ZZxjiv0igYg1EmGdIZLU1oR7r4bhcDaoDOJ0owOKuImVPihVYruJ+SvAsfL
 HQfKKCIIN5z6kGTQ8sJLC71rfKsmA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv7rb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGF2I24001680;
 Tue, 16 Dec 2025 15:14:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv7rb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGDPPps002761;
 Tue, 16 Dec 2025 15:14:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1kfn4rtj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 15:14:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGFE5cP66715946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 15:14:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3481C58065;
 Tue, 16 Dec 2025 15:14:05 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5834D58061;
 Tue, 16 Dec 2025 15:14:04 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 15:14:04 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, angeloj@linux.ibm.com
Subject: [PATCH v3 0/7] hw/ppc: Snapshot support for several ppc devices
Date: Tue, 16 Dec 2025 09:13:52 -0600
Message-ID: <20251216151359.418708-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX8VKSAFmpmGxK
 6FlFvrGU0FqllS9TB/S/J8ZsOyHsf1kGu2HsNotr5sYBE0m5QDXFG1iBPXopr19LMeg8kXUAe0Y
 0aYBw2lN485BbrsQ4dcdohg4pSX9iRQjRXX12DfRUC3LN4hecoSKOzWjCXRV/XCqmzbNVJfZVOK
 P5kJ/WIaZm81gKp2Hnx/6+PVO0V04edWkdwzYdTVk0bnNvC135kwCfE+Y2fPF7QUx+myGbtO3Y8
 dqE0cPWkg2kZeymlASR6+LBikHVVFzL5BBmOKUNIaJTDpIxla+PO/g1roe7OeupjGrZr9k36sji
 637sfpTr+tE4OHc+4Q4t8d4hJsTaDBE7Bx6jxW0eTwOMCZhcpFhkznMJN/z9yE2QYC0+sEuLaMY
 QrZAUXc1p2dOZ3PB7U2ZnbQppglJpw==
X-Proofpoint-ORIG-GUID: ilHEdk_yrXhIY9xrIdbOzETPzQ1faQuE
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69417740 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ne1qJFFQzzWKJjgbsqMA:9
X-Proofpoint-GUID: WOzNjwDwqWWMH_CnoCmx86Mpqg2x56Vz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Addressing comments from V2 review:

Updates in V3:
- pnv_psi: Remove PSI_DEBUG section as it was not used
- pnv_psi: Add missing post_load and vmstate info

Updates in V2:
- Added new patch set for PnvPsi support as it fits with the rest
- Added vmstate support for Power8 and Power9 for LPC
- Fixed pnv_core.c commit message

Tested:
passed make check

Thanks,
Caleb

Michael Kowal (2):
  hw/ppc: Add VMSTATE information for LPC model
  hw/ppc: Add VMSTATE information to PnvPsi

Caleb Schlossin (2):
  hw/ppc: Add pnv_spi vmstate support
  hw/ppc: Add pnv_i2c vmstate support

Angelo Jaramillo (3):
  hw/ppc: pnv_adu.c added vmstate support
  hw/ppc: pnv_core.c add vmstate support
  hw/ppc: pnv_chiptod.c add vmstate support

 hw/ppc/pnv_adu.c             | 12 +++++++++++
 hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c            | 22 +++++++++++++++++++
 hw/ppc/pnv_i2c.c             | 11 ++++++++++
 hw/ppc/pnv_lpc.c             | 41 ++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_psi.c             | 36 +++++++++++++++++++++++++++++--
 hw/ssi/pnv_spi.c             | 27 ++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 8 files changed, 187 insertions(+), 2 deletions(-)

-- 
2.47.3


