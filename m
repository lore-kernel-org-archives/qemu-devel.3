Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0F4C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 12:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNtGG-0000KQ-5t; Sun, 30 Jun 2024 08:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sNtGD-0000Fb-Ro; Sun, 30 Jun 2024 08:02:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sNtGA-0004tc-0Q; Sun, 30 Jun 2024 08:02:25 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45UBurW3001445;
 Sun, 30 Jun 2024 12:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=DUwfdPv3f1KkjNiQxub9dWZFb2wyEzfrAXjmmdy
 6aG8=; b=eVZiWdrCG22KFRHfBMf5valdJ63eTjAcOg5hH1j0XxJJ1pSDIHn2Wl6
 MZepGc35Otfbk4YJ79liQMYPs0AxzC5KG59T3b35mhDx3KV4lRv7uk5x/HgpSGtP
 EPbGbUHP9CbsrdinJOnAll5ZuMYICA2Nm4N0Dm6qp9nWEfsZrC22+kO4EG3gQQqG
 hK+yzXf2Ah8q4OBREuusHnzYRM5qofOWzvybjDbYjNBGGqdL37afrq9G0odSW8MM
 i9po8E5iSQr4icFQXakthjjWVaaqh/lJpCIa+bhhPiuvlPLr2if7OGYkc6j9NZQb
 1ifl4lMJ/48Uii2ov5fU73hi2hioeXA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4033vm8b9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:16 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45UC2G2Q009939;
 Sun, 30 Jun 2024 12:02:16 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4033vm8b9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45U7sN9X024085; Sun, 30 Jun 2024 12:02:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya31nwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 30 Jun 2024 12:02:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45UC2BOA21365222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 30 Jun 2024 12:02:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65D5B20049;
 Sun, 30 Jun 2024 12:02:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED6E920040;
 Sun, 30 Jun 2024 12:02:08 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.58.130])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 30 Jun 2024 12:02:08 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 0/3] target/ppc: Update vector insns to use 128 bit
Date: Sun, 30 Jun 2024 17:31:54 +0530
Message-Id: <20240630120157.259233-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HhlWim2JYEWLmEVxFPy-HBXOUuG3SUO1
X-Proofpoint-ORIG-GUID: NP2HfRooztdJwgKdVHUwjVBlvFwiVTez
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 priorityscore=1501 mlxlogscore=765 impostorscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406300094
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Updating a bunch of VMX and VSX storage access instructions to use
tcg_gen_qemu_ld/st_i128 instead of using tcg_gen_qemu_ld/st_i64 in
succession; as suggested by Richard, in my decodetree patches.
Plus some minor clean-ups to facilitate the above in case of VMX insns.

Change log:

v2 : Applied IFALIGN_PAIR memop changes in patches 2/3 and 3/3,
based on review comments by Richard in v1.

v1 : https://lore.kernel.org/qemu-devel/20240621114604.868415-1-rathc@linux.ibm.com/

Chinmay Rath (3):
  target/ppc: Move get/set_avr64 functions to vmx-impl.c.inc.
  target/ppc: Update VMX storage access insns to use
    tcg_gen_qemu_ld/st_i128.
  target/ppc : Update VSX storage access insns to use tcg_gen_qemu
    _ld/st_i128.

 target/ppc/translate.c              | 10 -----
 target/ppc/translate/vmx-impl.c.inc | 52 ++++++++++++---------
 target/ppc/translate/vsx-impl.c.inc | 70 +++++++++++++----------------
 3 files changed, 61 insertions(+), 71 deletions(-)

-- 
2.39.3


