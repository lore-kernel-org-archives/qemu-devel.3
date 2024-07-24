Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54716C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjRE-0000y0-6L; Wed, 24 Jul 2024 17:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjQy-0000A4-9c; Wed, 24 Jul 2024 17:22:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sWjQu-0000VT-AF; Wed, 24 Jul 2024 17:22:02 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OKujph028111;
 Wed, 24 Jul 2024 21:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=WL0BIHYsBeJCapukG04x/DzV9z
 mjrJcmAdGArXJvAZY=; b=EvNRma5cycSBDW2ti2wr0sKpvRlPCQjU4SdlEWb5nj
 Anh5oVGiuo9B/wrAAtxAxi0363AMsj2MViRttCYuLyS4V1vjSmaDhnlwNSbBWMjV
 YKHngGgRZgnreQMeN4cyP4ewuKTOV9W0OpZpaoggBHh+bvsYDbeG4BQJVok3A6pk
 x47p5j7p1OmMbfbG/ppK2fsZGy61eVv8D/BtrpmfvVtetpN1OdJvthyuqZOfs4EX
 9HowB3wyP0K+AceHm1VB8FI62JyyoGDk5sHNS12lZfc3/PBY+0blxZ9/SZm2IW4N
 fGZYSC+VF5nEEOnx7qh/PK6p6Giw5dAjDIjXfQymxHUw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k6wv8d78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:46 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46OLLjkb005213;
 Wed, 24 Jul 2024 21:21:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40k6wv8d76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46OJSgiW005876; Wed, 24 Jul 2024 21:21:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gy2pj1gh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jul 2024 21:21:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46OLLc9X54984994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2024 21:21:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95CD620040;
 Wed, 24 Jul 2024 21:21:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E7BD20073;
 Wed, 24 Jul 2024 21:21:37 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2024 21:21:37 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 00/11] XIVE changes for Cache Watch, VSTs, STT and info pic
Date: Wed, 24 Jul 2024 16:21:19 -0500
Message-Id: <20240724212130.26811-1-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EfNv3iaIY6soOtAbLPXu1x1YLx6ZxNZG
X-Proofpoint-ORIG-GUID: g6ltgv4xSbsCX25BcrYCJ9CHPr7u7inP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_24,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=769
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407240150
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Michael Kowal <kowal@linux.vnet.ibm.com>

These changes provide enhanced support of the External Interrupt Virtualization
Engine.  The changes are focused on the following areas:
 - Cache Watch, Cache Flush and Sync Injection
 - Virtual Structure Tables
 - Set Translation Table
 - 'info pic' command data that is dumped

Version 4 changes:
- Added Reviewed-by Tags to patch sets 1-8
- split patch set 9 into 3 patch sets, 9, 10 and 11

Frederic Barrat (9):
  pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
  pnv/xive2: Add NVG and NVC to cache watch facility
  pnv/xive2: Configure Virtualization Structure Tables through the PC
  pnv/xive2: Enable VST NVG and NVC index compression
  pnv/xive2: Set Translation Table for the NVC port space
  pnv/xive2: Fail VST entry address computation if table has no VSD
  pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c
  pnv/xive2: Refine TIMA 'info pic' output
  pnv/xive2: Dump more END state with 'info pic'

Michael Kowal (1):
  pnv/xive2: Structure/define alignment changes

Nicholas Piggin (1):
  pnv/xive: Support cache flush and queue sync inject with notifications

 hw/intc/pnv_xive2_regs.h    | 108 +++++++
 include/hw/ppc/pnv_chip.h   |   1 +
 include/hw/ppc/xive2_regs.h |   9 +
 hw/intc/pnv_xive2.c         | 566 ++++++++++++++++++++++++++++++------
 hw/intc/xive.c              |  12 +-
 hw/intc/xive2.c             |  33 ++-
 6 files changed, 633 insertions(+), 96 deletions(-)

--
2.43.0


