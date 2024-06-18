Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF9C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 09:00:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJUgV-0004rE-2Q; Tue, 18 Jun 2024 04:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sJUgS-0004ol-Ky; Tue, 18 Jun 2024 04:59:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sJUgQ-0006kU-Uf; Tue, 18 Jun 2024 04:59:20 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I8rmSY010165;
 Tue, 18 Jun 2024 08:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:content-transfer-encoding
 :mime-version; s=pp1; bh=mqTT+Ygafz8WcBnb2Ws2WlXTOOUtu0UYbjikxtk
 mGOk=; b=FJw2juGXyXRWrV3ql7v5Aau1A31YFRjEi0XGNDg3ZrlPIFZbquAqbQ5
 OjiUvhjRnKXySjTVMCPO+PEJF+7nERNoPIk/0lYh7ajQS0fAKFeITvdc+Fn1MMrq
 8JF7hKp9L5wH+B8/0zrT6noVRRJjO+f3r+QYXEZ6LBW0sCM1inpQeQsIk9HR43fa
 2eZUHs8HKTvFVvEi0qWLWJt0cFF8QAqvDbgUXie/FeYeOWmkL3sArSTRUMLKVQ9I
 20UjvsAEg7tbjG0MSYvnsajfawdpisn9Vi3AZQGqwqBgnR/EDjtJyisGfdZNpRyl
 0LV+ROS1tkU5glBu9K/vsWqACkgWw6Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu5vp08bt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:58:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45I8wleQ017828;
 Tue, 18 Jun 2024 08:58:47 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yu5vp08bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:58:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45I78iwQ023963; Tue, 18 Jun 2024 08:58:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9q1e87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jun 2024 08:58:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45I8we1929885120
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2024 08:58:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD1FA20040;
 Tue, 18 Jun 2024 08:58:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EF6A2004B;
 Tue, 18 Jun 2024 08:58:39 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.199.192.140])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jun 2024 08:58:39 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH v3 0/4] target/ppc: Move VSX storage access and compare
Date: Tue, 18 Jun 2024 14:28:27 +0530
Message-Id: <20240618085831.546883-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PjoTVZ1gESPuTRrWOKaFY12mlQDcWPY2
X-Proofpoint-GUID: LXSu_7G3ixMX1p2UnESPLdyJJmKAgtDA
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=737
 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180065
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
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

Moving all remaining VSX storage access instructions and all VSX compare
instructions of XX3 form with RC field, to decodetree specification.

Change log :

v3:
- Patch 2/4 : Updated the added function do_ea_calc_ra to return
  modifiable EA, after discussions with Richard.

v2: https://lore.kernel.org/qemu-devel/20240613093318.314913-1-rathc@linux.ibm.com/
 - Addressed comments by Richard in v1 :
   - Patch 2/4 : Handled proper ea calculation in narrow mode.
     Also created a new function for ea calculation instead of inlining,
     for later use by (p){lx,stx}vp insns.
   - Patch 4/4 : Unified helper calls.
 - Retained Richard's "Reviewed-by" in patches 1, 3 and 4.

v1: https://lore.kernel.org/qemu-devel/20240607144921.726730-1-rathc@linux.ibm.com/

Chinmay Rath (4):
  target/ppc: Moving VSX scalar storage access insns to decodetree.
  target/ppc: Move VSX vector with length storage access insns to
    decodetree.
  target/ppc: Move VSX vector storage access insns to decodetree.
  target/ppc: Move VSX fp compare insns to decodetree.

 target/ppc/helper.h                 |  24 +-
 target/ppc/insn32.decode            |  41 +++
 target/ppc/fpu_helper.c             |  16 +-
 target/ppc/mem_helper.c             |   8 +-
 target/ppc/translate.c              |  15 +
 target/ppc/translate/vsx-impl.c.inc | 416 ++++++++++++++--------------
 target/ppc/translate/vsx-ops.c.inc  |  49 ----
 7 files changed, 287 insertions(+), 282 deletions(-)

-- 
2.39.3


