Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D10C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJkM-0004cy-7Q; Mon, 17 Jun 2024 17:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sJJDG-0002QT-J6; Mon, 17 Jun 2024 16:44:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sJJD9-0006Vp-Sy; Mon, 17 Jun 2024 16:44:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HKRHCY018827;
 Mon, 17 Jun 2024 20:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=kSEvuZKjHy0bxDDpd3H2sRaNIX
 8jPxdNxdbE/YcdrrM=; b=f5/CPVL+nU7uUZyixBBHYElIK/MqYiIPsaxUsXsZlB
 0YKwbAIXIDRudxUDNma+wG8us+9a5BABOJKfqnTwurr7yzd45frYjOBqMAwelyjm
 ZORFNXOlOVKqM5RzSRNtxNABgSuKSkGNI+aOvo2f1Ysavv0vpqlzTVOGtpZ9JZ6K
 ESmg65pfcqt6D5k5kuDluUO4/BsAN1W+WsQK6AtZYnZOJ/bSfgtc9QLaDrKnyfv7
 0ZaBxgTzebnha3eu3xoE6M1qTNv+iQ7z/IcdQRZSb9vXsUqLDrGdgyxJaz48K9C/
 zMGMNrIVmjtHRQD86KqD2N1U7F/slzMShFDueu4yN7sQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yttwc871h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 20:43:43 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45HKhhEm010300;
 Mon, 17 Jun 2024 20:43:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yttwc871f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 20:43:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45HIQoqj011027; Mon, 17 Jun 2024 20:43:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsmw3wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Jun 2024 20:43:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45HKhaGF51839388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2024 20:43:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 336CB2004D;
 Mon, 17 Jun 2024 20:43:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01DD02004B;
 Mon, 17 Jun 2024 20:43:35 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2024 20:43:34 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 0/5] XIVE changes for Cache Watch, VSTs, STT and info pic
Date: Mon, 17 Jun 2024 15:42:57 -0500
Message-Id: <20240617204302.12323-1-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HiFufm1alBdJTDhxKJAa4ILbEnchztRd
X-Proofpoint-GUID: qEdNnIt1X7yBhdgsq-T1fZGPRTWK582h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxlogscore=309 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406170157
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Jun 2024 17:18:34 -0400
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

These changes provide enhanced support of the External Interrupt Virtualization
Engine.  The changes are focused on the following areas:
 - Cache Watch, Cache Flush and Sync Injection
 - Virtual Structure Tables
 - Set Translation Table
 - 'info pic' command data that is dumped

Frederic Barrat (5):
  pnv/xive2: XIVE2 Cache Watch, Cache Flush and Sync Injection support
  pnv/xive2: Enable VST NVG and NVC index compression
  pnv/xive2: Set Translation Table for the NVC port space
  pnv/xive2: Fail VST entry address computation if table has no VSD
  pnv/xive2: Move xive2_nvp_pic_print_info() to xive2.c

 hw/intc/pnv_xive2_regs.h    | 108 +++++++
 include/hw/ppc/pnv_chip.h   |   1 +
 include/hw/ppc/xive2_regs.h |   9 +
 hw/intc/pnv_xive2.c         | 564 ++++++++++++++++++++++++++++++------
 hw/intc/xive.c              |  11 +-
 hw/intc/xive2.c             |  33 ++-
 6 files changed, 631 insertions(+), 95 deletions(-)

--
2.39.3


