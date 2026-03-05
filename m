Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64765EEF309
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 06:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy1u7-0001lt-Ty; Thu, 05 Mar 2026 01:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vy1u0-0001kk-7J; Thu, 05 Mar 2026 01:09:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1vy1tx-00011U-St; Thu, 05 Mar 2026 01:09:39 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 624IEjOZ725327; Thu, 5 Mar 2026 06:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zO6vZ8
 /wECSrMxXfxsUNz4uieQahr/Fqq9oa0w8gRvU=; b=oyA4rN1lm14zpfhneNzhhn
 qqcc/DcbPXi3HAvpEsdVenl7n1NMbF8uBQ9izmr2TsS8HCrt3o6jRt5ZOhlH8/gb
 BzJtc11YoV6CK75dTZYMRhSucvJyOVu982zyHG668xOAsukRm2PHO+gWdrTGVmAH
 BPhkxRZLSvWJ3ChKBPe0bFgSzhPlWZRcUczX8/RyJ0nH7X/kl33gKo2TeRW3KwFF
 zlI9iEgCS2XwF73ZVwrFLgisbf/7xl3quZ55RSKF9LDZqvtcZ6YbAUBZ9bKyqXPZ
 C6sly2XCvqis2j6nWemOLVN3gOoB8kfe/2UoT2R19jsInuQ+AcN/yTgZgNJQTQxQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdjd3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 06:09:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6254DIOi028908;
 Thu, 5 Mar 2026 06:09:31 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsa0tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Mar 2026 06:09:31 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62569TVq31326944
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Mar 2026 06:09:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68B3E5805C;
 Thu,  5 Mar 2026 06:09:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DE7B58058;
 Thu,  5 Mar 2026 06:09:28 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Mar 2026 06:09:28 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v4 0/9] pnv/phb4: Update PHB4 to the latest PHB5 spec
Date: Thu,  5 Mar 2026 00:09:02 -0600
Message-ID: <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a91e1c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=xddzaUbqZQmOpwfENsoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UFPK6qRZjRizQkbfAaBGN5nFGDk3rwDF
X-Proofpoint-GUID: I7Bho5ymYAULSmwQ9iCVLhSj4uLh7vwT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA0NiBTYWx0ZWRfX6I0c7j3LYtBq
 C5nVJzE+9AT5v2REnl+UaOBLpRY53DyNfSJxGGdKjOWPLCbD/jdnnkzz9moQ/01kLKMcLdB6OUv
 Kl/RL78lwwr/ImyM/1T5Peqj3nBeeW4Erl5nCYwBSZMIz3j3fNhW+ZhwW+JNlKUiwo/Fj1EjHtq
 yVLwSzkXOOT2h+cyH2Qzn4Anu7+j3N/hrhtTDo4RgsT86XC4JYb0QQVBAHmp6jmDorxyG/nYUbw
 itAuvfaf9y2yET3H6U9vDwDPSMRkPNBqzTQvl3HTX2cy+sSmK5rtH2zAsrrlW/foM2PUHsg16H1
 kjAmCg9RcoEWAez+uGkudAkpzxjUA6KJKHAYnFfg9yAJALFc36iANjiYdLKKKchrTqsGk7GVd8S
 F411uGidElB79T1pnwyveOk6inmXsx1LayAFXLCz/NPcYguKmI400TvOV05oFvPt8J23zNuFjJp
 r7eLSuSryrOIa1y0ztA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050046
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Hello,

This patchset v4 resolves the tsan build failure seen in
https://gitlab.com/mstredhat/qemu/-/jobs/13201554945

Few variables were declared directly after a case label inside a switch,
causing the compilation failure.
These are now moved to the top of the block.

This series updates the existing PHB4 model to the latest spec:
"Power Systems Host Bridge 5 (PHB5) Functional Specification Version 0.5_00".

Updates include the following:
- implemented sticky reset logic
- implemented read-only, write-only, W1C and WxC logic
- return all 1's on read to unimplemented registers
- update PCIE registers for link status, speed and width
- implement IODA PCT debug table without any functionality
- update LSI Source-ID register based on small/big PHB number of interrupts

Also, a new testbench for PHB4 model is added that does XSCOM read/writes
to various registers of interest and verifies the values.

Regards.


Saif Abrar (9):
  qtest/phb4: Add testbench for PHB4
  pnv/phb4: Add reset logic to PHB4
  pnv/phb4: Implement sticky reset logic in PHB4
  pnv/phb4: Implement read-only and write-only bits of registers
  pnv/phb4: Implement write-clear and return 1's on unimplemented reg
    read
  pnv/phb4: Set link-active status in HPSTAT and LMR registers
  pnv/phb4: Set link speed and width in the DLP training control
    register
  pnv/phb4: Implement IODA PCT table
  pnv/phb4: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb.c               |   1 +
 hw/pci-host/pnv_phb4.c              | 581 +++++++++++++++++++++++++---
 include/hw/pci-host/pnv_phb4.h      |  16 +-
 include/hw/pci-host/pnv_phb4_regs.h |  66 +++-
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-phb4-test.c         | 228 +++++++++++
 6 files changed, 835 insertions(+), 58 deletions(-)
 create mode 100644 tests/qtest/pnv-phb4-test.c

-- 
2.47.3


