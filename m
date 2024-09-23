Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEACCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpw-0007iR-It; Mon, 23 Sep 2024 12:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpb-0006Xh-TI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpW-0000bh-0W
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N76wSQ004443;
 Mon, 23 Sep 2024 16:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=N6zxJfcJaZ7LO
 kUC5FQaH52UCRfeJM/HvoMM9xuuUMY=; b=KgXYYJVKTb/cCYuAIxczc0S+s9v9z
 fmph7KqKwt2yQldC2DmD2M/wRivacBjzFbWsCGFBzwccSZG0UmsEpDoTTPKKFK5u
 BngBsI3vf+wjBZqaE9AgN88N4nrZ7mobRa5BLNyW4kDKx1Yl7spSevk8JLZkA6st
 XuIU638tpa68p81sLEUns6n4bowXZdtsMBaqBzDaOHIl6HPPvLlzDKrjW77977Jf
 eOTG8ZlxCj3UkaWK/C12qRYHzP5utHQzCVE1GVfMfP6Sxh+Xw5SE010RLmNsyeZj
 fPI9/60mwyXh79GW3cnE+sAvkHvNXx+0hurjGd3R7/vez49kIvF5IhE9A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMMpd032099;
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFpLq2020843;
 Mon, 23 Sep 2024 16:22:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62y41f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMJJk53543318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9DB020040;
 Mon, 23 Sep 2024 16:22:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5AF2C20043;
 Mon, 23 Sep 2024 16:22:19 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:19 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 07/18] qemu-thread: Introduce QEMU_COND_INITIALIZER
Date: Mon, 23 Sep 2024 18:13:02 +0200
Message-ID: <20240923162208.90745-8-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oM7bmpjmiJw8kCYNan474ip3CVrBZWF0
X-Proofpoint-GUID: giDOyaNMFJQz6DB1_lHuOSZR0nUdeqcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow static initialization of condition variables.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 include/qemu/thread-posix.h | 2 ++
 include/qemu/thread-win32.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/qemu/thread-posix.h b/include/qemu/thread-posix.h
index fc0846bfa7c..ed08181a9c6 100644
--- a/include/qemu/thread-posix.h
+++ b/include/qemu/thread-posix.h
@@ -32,6 +32,8 @@ struct QemuCond {
     bool initialized;
 };
 
+#define QEMU_COND_INITIALIZER {PTHREAD_COND_INITIALIZER, true}
+
 struct QemuSemaphore {
     QemuMutex mutex;
     QemuCond cond;
diff --git a/include/qemu/thread-win32.h b/include/qemu/thread-win32.h
index ed1f2d0e733..e1b014fcac4 100644
--- a/include/qemu/thread-win32.h
+++ b/include/qemu/thread-win32.h
@@ -29,6 +29,8 @@ struct QemuCond {
     bool initialized;
 };
 
+#define QEMU_COND_INITIALIZER {CONDITION_VARIABLE_INIT, true}
+
 struct QemuSemaphore {
     HANDLE sema;
     bool initialized;
-- 
2.46.0


