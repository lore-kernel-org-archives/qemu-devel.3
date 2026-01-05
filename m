Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F59C79FA7
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 16:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcn3J-0005YC-DI; Mon, 05 Jan 2026 11:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn24-00051P-BY; Mon, 05 Jan 2026 11:02:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1vcn1x-0001HZ-Jy; Mon, 05 Jan 2026 11:02:11 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6058C7CJ000524;
 Mon, 5 Jan 2026 16:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=OLx/LpuhIU50t1SHj7toe4Jilw5NkM56QNrM3M9nX
 U4=; b=Ig6fWlxnyZcGKw1dWeOlkrRJapHC5y+hEXysR2RXJZpqUkCgsI9KIn3sF
 c8p3DBBNtRKEObYA5nP+P1rrI5Yh8r38Nlo/ywuG0ipBTGCvLQmS46PxzVuaKBkG
 KJyhQewfEFafnLiT+jl47jXapGSC0Igdc7AC2XYTaBGx6NEHAuGKUh4fpixEjcY1
 JVdAPDawNIuke1olEGEp6nFg/SQoiXQI8L/3pmicK5YKshT8HEyHV61ACgeW7v/j
 oOqWiwnq3+ErS4aWVtOkwsY5z9+P2jZSabi1Of5xuuh83Vgp6snUoUHC1fGGy4ps
 7OrBRKuWqa7vvmSG2KyEngc6A0Mxg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheqgxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605Fk2hC028932;
 Mon, 5 Jan 2026 16:01:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4besheqgx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605ECqOD014503;
 Mon, 5 Jan 2026 16:01:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeempnms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jan 2026 16:01:49 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 605G1ltN19137054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jan 2026 16:01:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D4D358054;
 Mon,  5 Jan 2026 16:01:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D4DB5805A;
 Mon,  5 Jan 2026 16:01:46 +0000 (GMT)
Received: from gfwr532.rchland.ibm.com (unknown [9.10.239.133])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jan 2026 16:01:46 +0000 (GMT)
From: Caleb Schlossin <calebs@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, kowal@linux.ibm.com, angeloj@linux.ibm.com,
 harshpb@linux.ibm.com, calebs@linux.ibm.com
Subject: [PATCH v4 0/7] hw/ppc: Snapshot support for several ppc devices
Date: Mon,  5 Jan 2026 10:01:31 -0600
Message-ID: <20260105160138.3242709-1-calebs@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzOCBTYWx0ZWRfX5rcf79yloIFJ
 s9omxmzSMzy/uaCP2WRvBRMjNoWSAFjTKhM6yPiMaQLBNBRCjFu87pOotdyVfD6L1FovzxDUJXt
 wzJjBxXBrhYuBBG6IsWGtUCZecF2/Z3dYcht3Fj/73sXXVK8w+MSTSrmf6wb5ZlqGmKaUeTTQ25
 kcbaVcazwaiTNEgGNsInSseI1dGhuFtXfCszpVJTB4TY5a2Sgb0jZ1vOcxVU5NSyOEPspcgAdIH
 JHo8AZ4XR99lH204SfSdH49n+rLUrhGINyCsTiNmfs+a+OGFNnE/hNNZv5MDqRXBDGJ5SoWHRIR
 s28cafMEp2W6ohhaLCKuHROX4RnqCqjT5KmFpUbuLh2ZmLYtb4ockTeXN8AliCpje5zRUn5jQKx
 5fDWgwsksr+vuMLPY8OsOIOA5t33RFNJ0kbNij2Zp1EJC/UcVgpjeOwaf6rixGM81MJBAoD4yGa
 3VTGRjj+GsjbB8MRsDQ==
X-Proofpoint-GUID: eLwnBNghdvI4PJyXfqC-jklwcWfcr8gs
X-Proofpoint-ORIG-GUID: QQdIXulj7UOQbqG-kJNi93HkXlKhbGMx
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695be06e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ne1qJFFQzzWKJjgbsqMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Updates in V4:
- Rebase and fix patch apply failures

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

For the series:
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>

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


