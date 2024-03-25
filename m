Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C522C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romKU-0006eA-0C; Mon, 25 Mar 2024 11:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKO-0006dR-68
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1romKL-0001B0-R2
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:33:35 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PFSvG9019331; Mon, 25 Mar 2024 15:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=q3106Hz5kU/Uuvac4iDTSvDPcn+73mqj/QqR54yAxZQ=;
 b=NQOxE7Ricig1PKjhFrp9HsFWe6lJq46N76EmTZABExKjI+P5PxcR1Utms1ZCq2JNvwc6
 iUwaql2/KbqBCmxMoYpZIIbI6aktnCxXD+89mEbup/Ah+UMpGRKaDXHF/N70LK4haUem
 Hk3e5i0HnJydnSjAzRSryZNXSUC2n3M7IjGC4IMEAbsRAaQXEs5LrOzTRuU7dxtw9Yuy
 PHs/InaNCWkmPao9Ep1UKuzkp970EzKQ8JTWpUC2Vm5NeBFqxbk5s/vue5UFt1dO0ebx
 RqVkVrt9GIBoz41mh2bavkugQBn9mz6g4SqoESsKfEFAKMadaCsCNs7QAfS8TmQ8tiJb ew== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x3buw00p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42PD1G4F011328; Mon, 25 Mar 2024 15:33:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x2bmkskxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Mar 2024 15:33:28 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42PFXOcb27329168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Mar 2024 15:33:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B61A220043;
 Mon, 25 Mar 2024 15:33:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4FB1E20040;
 Mon, 25 Mar 2024 15:33:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.171.7.191])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Mar 2024 15:33:24 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] linux-user: Fix shmat(NULL) for h != g
Date: Mon, 25 Mar 2024 16:07:37 +0100
Message-ID: <20240325153313.526888-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E48SSKEVOcatb57ddDfc-Wr-xUDcXM-t
X-Proofpoint-GUID: E48SSKEVOcatb57ddDfc-Wr-xUDcXM-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=777
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250086
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

Hi,

I noticed that while shmat() now works with /proc/self/maps,
shmat(NULL) got broken. This series fixes that along with two related
strace issues, and adds a test.

Best regards,
Ilya

Ilya Leoshkevich (4):
  linux-user: Fix semctl() strace
  linux-user: Fix shmat() strace
  linux-user: Fix shmat(NULL) for h != g
  tests/tcg: Check that shmat(NULL)

 linux-user/mmap.c                            |  2 +-
 linux-user/strace.c                          | 10 +++---
 tests/tcg/multiarch/linux/linux-shmat-null.c | 38 ++++++++++++++++++++
 3 files changed, 43 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-shmat-null.c

-- 
2.44.0


