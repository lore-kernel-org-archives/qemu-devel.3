Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1C3C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 20:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZdGF-0005k1-Ql; Mon, 12 Feb 2024 15:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZdGC-0005jU-Jl
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:50:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rZdGA-0003QJ-6J
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 15:50:40 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CKascn017559; Mon, 12 Feb 2024 20:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pZpk2dJjr4LZe4LQFXB8PlBikKDWfGUnXxvd3qiS1tQ=;
 b=FT9KA9XiRkQdX3cOSZ7fOTe+ncuVH3SvOS1XjHWMHVY2YbKrMmEEFuD3U93BBdK8+++d
 NuJvZHF9lDruOj4ege92UJqaCMc7ElgIqCLHCpzBMmGh7cyxj/9zZBK+qb7YpH5Fzgfv
 dK4f1BpDdhvbTErPesx9hJLx4D8GNQ+JsJSzpgMWn0aRJ3/mcrC/iohHAgSafgvRMyPg
 EKHfscn9jaX2HgCPp28RcDnOsovc3Zf5CZfeVa3AUFCBSrAH5MizuVJ80zmU8a0chIxF
 jdCpTwALZWYI3sqzAl0RmmdlFzqJDNnYE8ysKQ8v5AJBPFHlIfGbtlIV/4Lcm6NHQhn6 JA== 
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7th585yk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:50:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41CJdLaQ024762; Mon, 12 Feb 2024 20:50:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp3376-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 20:50:32 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41CKoSrY2359950
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 20:50:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FFC52004D;
 Mon, 12 Feb 2024 20:50:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 056AC20040;
 Mon, 12 Feb 2024 20:50:28 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.4.126])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 20:50:27 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] linux-user: Map low priority rt signals
Date: Mon, 12 Feb 2024 21:45:41 +0100
Message-ID: <20240212205022.242968-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lcu03cPTCa7oJuD0MADA7rDP8y01NWix
X-Proofpoint-ORIG-GUID: Lcu03cPTCa7oJuD0MADA7rDP8y01NWix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=639 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120161
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
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

Hi,

There are apps out there that want to use SIGRTMAX, which linux-user
currently does not map to a host signal. The reason is that with the
current approach it's not possible to map all target signals, so it
was decided to sacrifice the end of the range.

In this series I propose to sacrifice the middle instead. Patch 1 makes
the change, patch 2 is a test.

Best regards,
Ilya

Ilya Leoshkevich (2):
  linux-user: Map low priority rt signals
  tests/tcg: Add SIGRTMIN/SIGRTMAX test

 linux-user/signal.c                           | 18 +++++---
 tests/tcg/multiarch/linux/linux-sigrtminmax.c | 41 +++++++++++++++++++
 2 files changed, 54 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-sigrtminmax.c

-- 
2.43.0


