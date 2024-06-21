Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5974CC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 11:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcis-0006K8-QA; Fri, 21 Jun 2024 07:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sKciq-0006JG-O6; Fri, 21 Jun 2024 07:46:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1sKcim-00009b-Js; Fri, 21 Jun 2024 07:46:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LBSugg032437;
 Fri, 21 Jun 2024 11:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=pp1; bh=GY1kor56lvYEVDHjrqhHWg5o+Q
 GsYqjNH9nLpGBAElg=; b=UK7e/qzxmSW+5qKY+5w9EdYzOj7ks9GlhVrvSWWedB
 DpTOKb3lwgTDjldr+jj7X+iOVPTk/rgATn2zrEg1jbbMfKifVBmVV/UG+0TTjzRL
 LYQ+dsb+zdlZbZ2MbscED4cWUyNfdzEvrxcsJCtG9AnnxVFOnhxx9K7Ls531j9Wn
 tAk28wlkHtPnWy7FTk20bk17UwOW556VOq5FCl3iezNRLsRgt+w7G4/5SGYbSmjw
 IhUtR2za/43AqC51X6H778bU0cCmNJ6dQhM8P2Xvb7jxCSIK+KKD+/yQCLnuMWXI
 T6x+vRNMvciBmYKXgKJ/bEqEVPatXPzGCVycbu/j9CGA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw8p2g18s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 11:46:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45LBbRFp014215;
 Fri, 21 Jun 2024 11:46:20 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yw8p2g18n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 11:46:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 45L9FnZB032319; Fri, 21 Jun 2024 11:46:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yvrsppwmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jun 2024 11:46:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 45LBkGB351249650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jun 2024 11:46:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2053720040;
 Fri, 21 Jun 2024 11:46:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E9FA20043;
 Fri, 21 Jun 2024 11:46:14 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.171.38.80])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 21 Jun 2024 11:46:14 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 richard.henderson@linaro.org, harshpb@linux.ibm.com
Subject: [PATCH 0/3] target/ppc: Update vector insns to use 128 bit
Date: Fri, 21 Jun 2024 17:16:01 +0530
Message-Id: <20240621114604.868415-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yBYL2FbjQgQrjTiVM06IEQnNYm6pY6XK
X-Proofpoint-ORIG-GUID: hNuKZmLRr9IRvRXke-bnAqLMUid9K_DH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=671 spamscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406210084
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Updating a bunch of VMX and VSX storage access instructions to use
tcg_gen_qemu_ld/st_i128 instead of using tcg_gen_qemu_ld/st_i64 in
succession; as suggested by Richard, in my decodetree patches.
Plus some minor clean-ups to facilitate the above in case of VMX insns.

Chinmay Rath (3):
  target/ppc: Move get/set_avr64 functions to vmx-impl.c.inc.
  target/ppc: Update VMX storage access insns to use
    tcg_gen_qemu_ld/st_i128.
  target/ppc : Update VSX storage access insns to use tcg_gen_qemu
    _ld/st_i128.

 target/ppc/translate.c              | 10 -----
 target/ppc/translate/vmx-impl.c.inc | 50 +++++++++++----------
 target/ppc/translate/vsx-impl.c.inc | 68 ++++++++++++-----------------
 3 files changed, 57 insertions(+), 71 deletions(-)

-- 
2.39.3


