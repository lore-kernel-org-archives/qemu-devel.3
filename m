Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF17C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKmq-0000wg-9G; Mon, 13 Jan 2025 08:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXKmo-0000w9-3y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:47:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1tXKmm-0006UX-7j
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:47:21 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50D3tBlo003313;
 Mon, 13 Jan 2025 13:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=j/GUulKt0szX9mh0W
 jefez6yA6KxsZWKXDGO1Z2rohI=; b=RyztO0pAjLP/ybAqsPbx6IkPnnkAclfdc
 O16SMDcUI40AA1RB6utcPCQ63+QIV/h9Qyxmmbh+HMNl3hpSlncdKCJ/TaUoyBKA
 wDdBoocDHPNtaVqfDw+998gDVmY2xHoKm+0VtXM4Vqiqbkp3VQpz+770FPfecjfa
 Q3rVQBeuY7LDGI6xJHuImUsPXWE/zKf/PllERdDhBHydXOR8V4AhcYkTAPdgi49G
 3SwyngRRxh8iGsrthddBgj3E5+I99lCoTx1cyVIlCuOpE8ZLl+DSAV+gZmjNdkIe
 UW30UvZR03MeiB7AvTGjxJaux1xIb6p/LvWuvkaHOF4VoQwONthVQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qvhjtpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 13:47:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50D9hJ3e001108;
 Mon, 13 Jan 2025 13:47:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jp51m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jan 2025 13:47:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50DDlEY848497006
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jan 2025 13:47:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BDAB52004D;
 Mon, 13 Jan 2025 13:47:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C74220040;
 Mon, 13 Jan 2025 13:47:14 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.22])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 13 Jan 2025 13:47:14 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/3] gdbstub: Protect gdb_handlesig() with EXCLUSIVE_GUARD()
Date: Mon, 13 Jan 2025 14:36:29 +0100
Message-ID: <20250113134658.68376-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113134658.68376-1-iii@linux.ibm.com>
References: <20250113134658.68376-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fz2NXy9bshC7JeifGvIFtPjd6i9U3PJ6
X-Proofpoint-ORIG-GUID: Fz2NXy9bshC7JeifGvIFtPjd6i9U3PJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1.787, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

If multiple threads hit a breakpoint at the same time, GDB gets
confused [1]. Prevent this situation by stopping the other threads once
a thread hits a breakpoint.

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=32023

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gdbstub/user.c b/gdbstub/user.c
index 0b4bfa9c488..d72f8ca6106 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -200,6 +200,8 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason, void *siginfo,
     char buf[256];
     int n;
 
+    EXCLUSIVE_GUARD();
+
     if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
         return sig;
     }
-- 
2.47.1


