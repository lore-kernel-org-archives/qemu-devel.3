Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E614DC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 06:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl1JC-0003nH-N3; Fri, 15 Mar 2024 02:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rl1JB-0003mo-0k; Fri, 15 Mar 2024 02:44:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rl1J9-0005Wi-5G; Fri, 15 Mar 2024 02:44:48 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42F4l82B027619; Fri, 15 Mar 2024 06:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=LGiHrJSfmWH6IYFcAnL5sJHua6FcZd0Mm2ycoq6jj4g=;
 b=ceiA5yqdvpTzVhBOh41GX3gkREyqzLVeWoq5QqagJ9jPJfMHBtlW6EegOEIJAuNCV75J
 lOMmWeQPJ8KXPdJKV0brKN0AfxRAlivwHb4Zt3wZ2F6X3VKYhCafelZI4JbZZ6AsRpnZ
 AfUozQ2LgtiImgvKKGvLS6zB9VucuV+/5Vc+/hQfjzX4YxjgH4WpnzFwmMjY8lfBxF+y
 XnKjFUij9xBul+JH0RzetRBn8/s3Z+TUDxti7EOIjEE3YYWb6/mHVZF+4R+qZ0zRiQFM
 fNzy4tDELhJmO2E/QDAgsPyfR21p9PyQAv5E5/O7MI/ImW4P30s+LL+B0ZKwGIXWYami eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvfkw960a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 06:44:42 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42F6eqPK010689;
 Fri, 15 Mar 2024 06:44:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvfkw9604-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 06:44:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42F3t6jT015028; Fri, 15 Mar 2024 06:44:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33pa729-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 15 Mar 2024 06:44:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42F6iZPS40304990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Mar 2024 06:44:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B413920043;
 Fri, 15 Mar 2024 06:44:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E856620040;
 Fri, 15 Mar 2024 06:44:33 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 15 Mar 2024 06:44:33 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 clg@kaod.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 harshpb@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH v2 0/2] Moving fp arithmetic insns to decodetree.
Date: Fri, 15 Mar 2024 12:14:20 +0530
Message-Id: <20240315064422.737812-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e2gdoH_wZhyD12cVsC-a5fmap-gY10cc
X-Proofpoint-ORIG-GUID: pEWrn0nyl8mNq5hqYBrC6mHzWZ9QoNDd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=491 spamscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403150053
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch series moves floating-point arithmetic instructions from
legacy to decodetree format. The first patch consolidates the common
behaviour of floating-point helper functions using macros, reducing
code duplication. The second patch moves all the floating arithmetic
instructions to decodetree.

Change log :
v2 : Addressed review comments on v1
v1 : https://lore.kernel.org/qemu-devel/20240307110318.170319-1-rathc@linux.ibm.com/

Chinmay Rath (2):
  target/ppc: Merge various fpu helpers
  target/ppc: Move floating-point arithmetic instructions to decodetree.

 target/ppc/helper.h                |  44 ++---
 target/ppc/insn32.decode           |  42 +++++
 target/ppc/fpu_helper.c            | 235 +++++++-----------------
 target/ppc/translate/fp-impl.c.inc | 285 +++++++++++------------------
 target/ppc/translate/fp-ops.c.inc  |  31 ----
 5 files changed, 242 insertions(+), 395 deletions(-)

-- 
2.39.3


