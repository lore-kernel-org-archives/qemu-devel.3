Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5324EC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raxxF-0008BZ-M3; Fri, 16 Feb 2024 08:08:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxE-0008Ao-I0
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1raxxC-0001Ow-K7
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:08:36 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GCbZaI006914; Fri, 16 Feb 2024 13:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Wrl1WgXQtSoar+XyTVaxT51hBzzxaBQEId1XBe1SyYk=;
 b=RxYbrwIb5YmBFmqzpOP+OyfbFuGPBchWx0w4NxUvZj+PJ6XiVfZUbHJc4jX5UPwB4Sot
 nb51fHjzwA57PwCqtDO3zz3jizJSOb9/Qt3f0oIZpOOoi6N43MP/+Rgsw1scRBlL8HW8
 GRnxHIN7+7Y9wHZ7sdkgkRE1XvYB4a5BuRRsICq5K19awCBSdWG0+sdb045CW6w2EvKB
 PYwhR0FND2mfuDOw0kq0I3uN7qqRioww7McE64Wk+TtUVl6hWEfWDez3KRBqfeHIchXe
 Q8+0LzUqxyjIbkl1Mw2GvNprqt9bG4xD7ZFLzZFHNacoM9kyrF2/E6tzP/kItUFGZfLt Fg== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7vcrfdb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:29 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41GAf7f4010060; Fri, 16 Feb 2024 13:08:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npmb0hv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 13:08:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41GD8NRe41943734
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 Feb 2024 13:08:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD0F920040;
 Fri, 16 Feb 2024 13:08:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6986D20043;
 Fri, 16 Feb 2024 13:08:23 +0000 (GMT)
Received: from black.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 16 Feb 2024 13:08:23 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 02/11] {linux,bsd}-user: Update ts_tid after fork()
Date: Fri, 16 Feb 2024 14:05:29 +0100
Message-ID: <20240216130817.369377-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216130817.369377-1-iii@linux.ibm.com>
References: <20240216130817.369377-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8lYRA4PspIxTCVaOBfjhOdYos7NeLB5K
X-Proofpoint-GUID: 8lYRA4PspIxTCVaOBfjhOdYos7NeLB5K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_11,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=946 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160106
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

Currently ts_tid contains the parent tid after fork(), which is not
correct. So far it has not affected anything, but the upcoming
follow-fork-mode child support relies on the correct value, so fix it.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 bsd-user/main.c   | 1 +
 linux-user/main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index e5efb7b8458..4140edc8311 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -127,6 +127,7 @@ void fork_end(int child)
          * state, so we don't need to end_exclusive() here.
          */
         qemu_init_cpu_list();
+        ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
         gdbserver_fork(thread_cpu);
     } else {
         mmap_fork_end(child);
diff --git a/linux-user/main.c b/linux-user/main.c
index 74b2fbb3938..e6427d72332 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -160,6 +160,7 @@ void fork_end(int child)
             }
         }
         qemu_init_cpu_list();
+        ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
         gdbserver_fork(thread_cpu);
     } else {
         cpu_list_unlock();
-- 
2.43.0


