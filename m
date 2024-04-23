Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E57C04FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 06:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz9i5-0006CA-FC; Tue, 23 Apr 2024 02:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9i2-00069y-Hd; Tue, 23 Apr 2024 02:32:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1rz9i0-0003V6-Fq; Tue, 23 Apr 2024 02:32:54 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N5UnZ5004762; Tue, 23 Apr 2024 06:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=o9+fuhfV9z+9EPGoOwmuBt93uZF2TE+k5N6J9eImm7k=;
 b=DV8tH+3+BA3o2vBDHxN8J96ljGejtQzn1C8b/ScsWGD9b5Ed7pQnUqdslTnFu8v9dSiM
 I5P7ddivtoND64Z7zwd+NiXMWh0lDkDzMq9FfEJUGLqEN1OHCPVtVZtNnqiuH2/RCpD2
 JUPjsaWOWa2/C5C20QljtAqF2bKSW2pgnqQj+3rczcJik9Alu2QNElcrc9TtyC5Yr/Lx
 is5/V/vw1OMMZqQLbaelGa/l59QOyDSJvUGKy9HvOZFlmuQeo7DTLj0j4KVaTW/rI7i2
 NcWW9UQkAS2HIJD2GdBJ8pkUbynRyfyfrjgPFuOY95nFSUpby0BfF5JDoBmqDY+mQKPr QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp6mpr4ne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43N6WlTg023445;
 Tue, 23 Apr 2024 06:32:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xp6mpr4na-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:47 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43N3bQmG023042; Tue, 23 Apr 2024 06:32:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1nv20f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 06:32:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43N6Wf3Q14156276
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 06:32:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D47620040;
 Tue, 23 Apr 2024 06:32:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48BB820043;
 Tue, 23 Apr 2024 06:32:40 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 06:32:40 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v2 0/8] target/ppc: Move fixed-point insns to
Date: Tue, 23 Apr 2024 12:02:26 +0530
Message-Id: <20240423063234.76282-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kNsFQ6wZ6ON-K7Gp3Fe5BPj308ojdNYK
X-Proofpoint-ORIG-GUID: 2-vbXn5cA92WZ1fHnX2pMt5UhdtJfyCE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_04,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=628 suspectscore=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

Moving all fixed-point instructions of the following type to decodetree
specification : arithmetic, compare, trap, select and logical.

Change log : 
v2 : Implemented code clean-ups as per comments by Richard in
     patches 1/8, 5/8 and 7/8 of v1.
v1 : https://lore.kernel.org/qemu-devel/20240416063927.99428-1-rathc@linux.ibm.com/ 

Chinmay Rath (8):
  target/ppc: Move mul{li, lw, lwo, hw, hwu} instructions to decodetree.
  target/ppc: Make divw[u] handler method decodetree compatible.
  target/ppc: Move divw[u, e, eu] instructions to decodetree.
  target/ppc: Move neg, darn, mod{sw, uw} to decodetree.
  target/ppc: Move multiply fixed-point insns (64-bit operands) to
    decodetree.
  target/ppc: Move div/mod fixed-point insns (64 bits operands) to
    decodetree.
  target/ppc: Move cmp{rb, eqb}, tw[i], td[i], isel instructions to
    decodetree.
  target/ppc: Move logical fixed-point instructions to decodetree.

 target/ppc/helper.h                        |  26 +-
 target/ppc/insn32.decode                   |  93 +++
 target/ppc/excp_helper.c                   |   4 +-
 target/ppc/int_helper.c                    |  24 +-
 target/ppc/translate.c                     | 841 +--------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 631 ++++++++++++++++
 6 files changed, 762 insertions(+), 857 deletions(-)

-- 
2.39.3


