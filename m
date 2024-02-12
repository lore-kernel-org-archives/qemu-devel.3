Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7868BC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 04:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZNid-0002vW-7G; Sun, 11 Feb 2024 23:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZNia-0002um-Q7; Sun, 11 Feb 2024 23:14:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZNiY-0008Ro-UE; Sun, 11 Feb 2024 23:14:56 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C2YZ5Y006410; Mon, 12 Feb 2024 04:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CZoLTizW4OujhBYLYK0Eh+Kk/Ws3fwZcs5AC4BzM6AA=;
 b=hQOKnHCanCTn9rckIAlsiowZy4pC1kvLhd8wTVKQr8c41zvyV8GFvPpV9BKGBY8nxBk7
 Rt3wzFPolCQa77lh2SLQYGHctzqA3vVW3jDm54gpgY0fGSWTtA808G8Maa4gfsXByhUj
 gW9WF24hHfYq2TV5/uJaQzx/jodMYOkntDjRzHk3ndXI5veIbIsVduC8b0OPycjbl3H3
 vGoTboMRjFCNl+I4bXHzt3WBQdcu/P04R1J6ODHRj/lx69jZ5jZB10OKZV+yDod45chE
 GRFI+I5ZmHmesFUTwZHJyTykHSlSDwfzjdLJ3+eVw64CDegiRxPSAPSVdSK6dLLTb/JI 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w74fsdvp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:38 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41C3uSis017110;
 Mon, 12 Feb 2024 04:14:37 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w74fsdvp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:37 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C3anJc024877; Mon, 12 Feb 2024 04:14:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfnxb6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41C4EWJV8127082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 04:14:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C1362004D;
 Mon, 12 Feb 2024 04:14:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 998492004B;
 Mon, 12 Feb 2024 04:14:30 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.179.18.54]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 04:14:30 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: kowsjois@linux.ibm.com, clg@kaod.org, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] Introduce SPAPR_IRQ_NR_IPIS and fix max-cpus
Date: Mon, 12 Feb 2024 09:44:21 +0530
Message-Id: <20240212041423.293085-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ouPnTLRIWO0zhi7wynpt9XTJo5Lmvpo
X-Proofpoint-ORIG-GUID: x1PlXaK5-k1WIDXRpLzZORCYIiLsQpqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_02,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011
 mlxscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=683 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402120031
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On spapr, the max number of CPU IPIs are 4096 which is accounted during
spapr_irq_init but currently existing macro SPAPR_XIRQ_BASE is being
used to refer to that. Introducing SPAPR_IRQ_NR_IPIS to refer to the
range
of CPU IPIS which is being further used to initialize mc->max_cpus
during spapr_machine_class_init().

v4: added "Reported-by" and "Tested-by" from Kowshik
v3: addressed further review comments from Cedric
v2: addressed review comments from Cedric

Harsh Prateek Bora (2):
  ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ range for CPU
    IPIs.
  ppc/spapr: Initialize max_cpus limit to SPAPR_IRQ_NR_IPIS.

 include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
 hw/ppc/spapr.c             |  9 +++------
 hw/ppc/spapr_irq.c         |  6 ++++--
 3 files changed, 20 insertions(+), 9 deletions(-)

-- 
2.39.3


