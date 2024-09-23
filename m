Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FEBCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslq2-0007xx-1Y; Mon, 23 Sep 2024 12:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpb-0006Xg-Sy
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpV-0000c3-VM
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:35 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N8jNKx008714;
 Mon, 23 Sep 2024 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=tnLB7U4elm2AT
 jCyYDfTzyHKOBxzoRlyTNltYqbQWTY=; b=h0irbCAUVzQUsY7OyZm1h1XcKZJoI
 Jg5kOxaiTqAxXgKLdERQYd8VNb8ugT5hU2hrMYdCCGsW6RBb7mxeLAwUiGWlUFDU
 C+LG0GLEHhrT1FVKV2rQS9ImKwWI/mtwLnNF7Ts00oatsA+/Qcp6ltqq/rinQCRu
 sbM9lXCbAdxbovtx9TmWou9yblRQbmpxCVovyVv2Pph5OTUJOqHrkU/3AMMs1ru9
 ++sEgDDt0PsZFYzoNApbv0nDCs7fXtF70x1hay7D20MVfqUlLk8MvgSHSBOURth0
 tC8GqRlVKvS4gqHx3MU54HFQkTi0SIfwFjT85tIp2ToSZhdqbSQlkkDLw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvaw5jh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMOeB026349;
 Mon, 23 Sep 2024 16:22:24 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvaw5je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDl7Gw000643;
 Mon, 23 Sep 2024 16:22:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fufp6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMLPv21496146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7A21520040;
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 251FE2004B;
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 11/18] accel/tcg: Unify user implementations of qemu_cpu_kick()
Date: Mon, 23 Sep 2024 18:13:06 +0200
Message-ID: <20240923162208.90745-12-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XXcVGCwq3l7KXshgY_oNVQdEjKoL6Z4I
X-Proofpoint-GUID: FTUeao5GLDZ0uApgh90MW7w548esJLnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
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

linux-user and bsd-user have the same implementation.
Move it to user-exec.c.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c | 5 +++++
 bsd-user/main.c       | 5 -----
 linux-user/main.c     | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d56882c87f3..7bd6e94b8e8 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1302,3 +1302,8 @@ int cpu_exec_user(CPUState *cs)
 
     return trapnr;
 }
+
+void qemu_cpu_kick(CPUState *cpu)
+{
+    cpu_exit(cpu);
+}
diff --git a/bsd-user/main.c b/bsd-user/main.c
index ba5b54c228d..b424a21f643 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -208,11 +208,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
     return thread_cpu == cpu;
 }
 
-void qemu_cpu_kick(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 /* Assumes contents are already zeroed.  */
 static void init_task_state(TaskState *ts)
 {
diff --git a/linux-user/main.c b/linux-user/main.c
index 016f60bf3dc..60091cf3053 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -186,11 +186,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
     return thread_cpu == cpu;
 }
 
-void qemu_cpu_kick(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 void task_settid(TaskState *ts)
 {
     if (ts->ts_tid == 0) {
-- 
2.46.0


