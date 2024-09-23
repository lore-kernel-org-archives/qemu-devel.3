Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160BDCF9C74
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:23:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpj-0006qT-Op; Mon, 23 Sep 2024 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpb-0006Xi-Tq
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpV-0000cJ-Va
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:34 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDIrm7015231;
 Mon, 23 Sep 2024 16:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=4oMT0GZlyJvgn
 2L4HOXrCiFpso5i/Pzu7DPF0kfbHT8=; b=FlAB/q4OVfoIO+8UY+2lG0+bfVSOJ
 3IYs7i0HHYWRjHkzyJ1eDLuNk7XK2u26I1e+j13D7gnmsAldRze8I/mQldm65RBu
 vgOmoVl8WR/mx132TVuLTbFllv33aTueUhO+UOgVyi2alOgnYU2BdDLj8tDwwX+M
 5hNriWq2sCiImz3RI88H+sUjzEarn+9N5/dZsZQZi2DkC76NZ9//a9+Cpd1MIdJK
 Ue+MPG3HbVM5I9Q+D2Nco3uDVsCKE9DRGvPBkuaxiSC+WBoQ/AVbIlJlLWFghg0i
 wDbyTrtTKz3NqmmQ1N/HRyGAv8FIgQ9TMWFOg1NP0R4r0W+5QYhIN6j5A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw5592-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:26 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMP3a032226;
 Mon, 23 Sep 2024 16:22:25 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NG0Fcn020814;
 Mon, 23 Sep 2024 16:22:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62y41m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMMNb49545574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB12720040;
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6727C20043;
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 14/18] cpu: Introduce cpu_is_paused()
Date: Mon, 23 Sep 2024 18:13:09 +0200
Message-ID: <20240923162208.90745-15-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: l_qiXPHN0cmCGPsIQpWXFEgGa00wfl09
X-Proofpoint-GUID: aJBNhVT0OsHHZNMySpPKPGuvxhTNlzjj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=964 bulkscore=0 phishscore=0
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

A qemu-system CPU is considered paused as a result of an external
request. A qemu-user CPU, in addition to that, should be considered
paused when it's executing a syscall.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c     | 5 +++++
 include/exec/cpu-common.h | 1 +
 system/cpus.c             | 7 ++++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 57a13c81fc4..de4753cded7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1329,3 +1329,8 @@ bool cpu_thread_is_idle(CPUState *cpu)
 
     return ret == -1 ? true : ret;
 }
+
+bool cpu_is_paused(CPUState *cpu)
+{
+    return cpu->stopped || cpu->in_syscall;
+}
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index d7fc24bc13d..e8b530ed889 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -233,6 +233,7 @@ void cpu_exit_syscall(CPUState *cs);
 
 int cpu_thread_is_idle_common(CPUState *cpu);
 bool cpu_thread_is_idle(CPUState *cpu);
+bool cpu_is_paused(CPUState *cpu);
 
 /**
  * env_archcpu(env)
diff --git a/system/cpus.c b/system/cpus.c
index 13072be26fa..407140c41f6 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -530,12 +530,17 @@ void cpu_resume(CPUState *cpu)
     qemu_cpu_kick(cpu);
 }
 
+bool cpu_is_paused(CPUState *cpu)
+{
+    return cpu->stopped;
+}
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        if (!cpu->stopped) {
+        if (!cpu_is_paused(cpu)) {
             return false;
         }
     }
-- 
2.46.0


