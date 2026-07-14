Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809C1C44508
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 16:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjgIc-000067-1I; Tue, 14 Jul 2026 12:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIa-00005t-GZ; Tue, 14 Jul 2026 12:48:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wjgIY-0000jE-Ou; Tue, 14 Jul 2026 12:48:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EGBbLS1812481; Tue, 14 Jul 2026 16:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pvoIIub4PrTledCcB+BlOS500xRk1+X43t9B4+4JP
 0k=; b=EnP44anEkW7ZglHgMAILqrG5LwkjnpdxwoG8juStYiPDnp7rhyRmftskc
 IxSpHv9gSk615Zr0Ak3Ock2IShkLTUx14EQ/jOuiRNRjcQXr8D5vSCLwNYf3IYgJ
 Q7yUO2w+HkWzORc1+kL62djakvh+Avnel2GtzZjUJf74Td3tEHr89igTqR0aS4IL
 cNAFXWgsg/csIL1saSiOM0zhdVSWHncUbdaKmNCdpFjUAEp8FElMK8xTzu6Ax13D
 ysj6EZJfxpD7A2ugv9ZpLCaY/99VjyeSCC0NeomeOToufnofjkfA+2A/lkEg9n49
 srQKn+TE939cj1psOe6DYATwpLatQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt7as2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:47:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EGYbWl031430;
 Tue, 14 Jul 2026 16:47:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jurnn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 16:47:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EGlo3o47710666
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 16:47:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CFDC820043;
 Tue, 14 Jul 2026 16:47:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5794120040;
 Tue, 14 Jul 2026 16:47:48 +0000 (GMT)
Received: from shivang.com (unknown [9.124.218.131])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 16:47:47 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: hbathini@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 mahesh@linux.ibm.com, Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 0/3] hw/ppc: reorg PowerPC RAS code for better maintainability
Date: Tue, 14 Jul 2026 22:17:41 +0530
Message-ID: <20260714164745.573141-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: addLwsQ2wre2hD48V_pmxRAR_2IZhJov
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfXxjKYjUj5CXuN
 TAbOoYUaGZSRki537Kqc6PXa63LG7n+0sxNdN3XKzXg3BEfgWLLPwiweplIUGERB6NRSmzd9a/f
 mdzTev7NnHqi2ZbWrTMm08+64opBvB4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE3MyBTYWx0ZWRfX6BeesJ6Mmih5
 GUdq82cz/6Q94UPRp0NatCPqKhPeEU9kT3knKTWNQQw3z5r4GoaoJ58vHi9Z1sW/c3fuxFyy//c
 DQUygkmDaCdMKtcXzir7wgd0v8gJWWMzvk+jcWhYqggdkK+nWLeCfoDb8FD+2RS6ZVVQop9zxZD
 ccToFMSLSyvgu19xC7U9M5N+/l4St1R0HVlnsg3BsjSU/h40zTm3ADq0JR45EjW8aS+DNC+R4Qu
 87+bZBoxOknbNNNYgbLAniv8qlMBrXUwPkztz0dX60XAxofdgUtJMcoTkddeYf1aOVErzOIu0E+
 /BrMT/cNnyRI6CFhLreATE7XLxjn2i9aEe2R/JB5WLjApLVceZdiXntPYqmWc3ACmvAUmOYmFt0
 AiG0OjX6m8vQhI7edPTGciMbgYlVjrOn7pf5dWPJn5h2bgHNqqLqhlUXZLAJi/2j1VLG94uEBVd
 yqi37Q6QiioSvOdS7Rw==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a56683c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=jQmMyClVcm4b6RO8W5kA:9
X-Proofpoint-GUID: qxy6WrRoeNx_8mPxMkMVToOETLsKCqC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140173
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Extracting RAS related code from spapr_rtas.c, to a newly created spapr_rtas_ras.c
and carving out a MAINTAINERS entry dedicated to PowerPC RAS. This will cover RAS
related functionalities for PowerPC platforms.

Also adding myself as a reviewer, to help share the review workload.

Shivang Upadhyay (3):
  hw/ppc: move RAS-specific RTAS handlers to spapr_rtas_ras.c
  MAINTAINERS: add dedicated PowerPC RAS section
  MAINTAINERS: add self as reviewer for PowerPC RAS

 MAINTAINERS             |  33 +++---
 hw/ppc/meson.build      |   1 +
 hw/ppc/spapr_rtas.c     | 189 --------------------------------
 hw/ppc/spapr_rtas_ras.c | 232 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+), 206 deletions(-)
 create mode 100644 hw/ppc/spapr_rtas_ras.c

-- 
2.54.0


