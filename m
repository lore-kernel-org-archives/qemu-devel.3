Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84ACECF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpu-0007S3-Fr; Mon, 23 Sep 2024 12:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpb-0006Xj-U9
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpX-0000cn-P6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:34 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N8nkus021322;
 Mon, 23 Sep 2024 16:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=a19Q13gsnFLHt
 WGFByfdJRJnGzYniaISkm/mDVLQxWU=; b=VqmGNyx/BeDw/DyGWEZVFY6pU9puP
 4xczTWB8ap6V4OfYAyAwvIZDtm7tuZN+87m73BBbf0ZB+MeuVHb5O49q5n5hgWXr
 hyJyTMElCOHStvfRC0Mi3lOyajwQ2mNqTbAdWGe3KGsXMOTIubVPxyg3LZRO5hel
 Z6M0ZKoEzmaLbl2zYnndzTraHoEVmjCsyJyWMRnYzr/MBH2FR+GFxlNZVFYIm04u
 6Jp4upVFlhCGuBPDkEiGpJG0xmk/X2k/XN/2ZiVtoovK2X2mTTxJ1qFGfrtDR9fr
 nKFZkFNyvJtX6q6hw5ZBoea6VQgDxkZcFza48F/0A8AlZ6ptDSgy1z0Zg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvaw5ju-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGKSuw022836;
 Mon, 23 Sep 2024 16:22:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvaw5jk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NE0r4t008712;
 Mon, 23 Sep 2024 16:22:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v0ym0k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMMoQ49545572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5488220040;
 Mon, 23 Sep 2024 16:22:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F406D20043;
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
Subject: [PATCH 13/18] cpu: Implement cpu_thread_is_idle() for qemu-user
Date: Mon, 23 Sep 2024 18:13:08 +0200
Message-ID: <20240923162208.90745-14-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H1unpGehqrO8G9EApNiV1mjYh5yafUKj
X-Proofpoint-GUID: YrAN4IlKWBOSBVA4SXcT3j0wTiQKe2fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=926 classifier=spam adjust=0 reason=mlx scancount=1
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

Stopped CPUs are parked until cpu_thread_is_idle() is true, so
implement it for qemu-user. Share a part of the qemu-system's
implementation.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c     | 12 ++++++++++++
 cpu-common.c              | 19 +++++++++++++++++++
 include/exec/cpu-common.h |  3 +++
 include/sysemu/cpus.h     |  1 -
 system/cpus.c             | 17 ++++-------------
 5 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 3ebace1e833..57a13c81fc4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1317,3 +1317,15 @@ void cpu_exit_syscall(CPUState *cs)
 {
     cs->in_syscall = false;
 }
+
+bool cpu_is_stopped(CPUState *cpu)
+{
+    return cpu->stopped;
+}
+
+bool cpu_thread_is_idle(CPUState *cpu)
+{
+    int ret = cpu_thread_is_idle_common(cpu);
+
+    return ret == -1 ? true : ret;
+}
diff --git a/cpu-common.c b/cpu-common.c
index cb7c10a3915..2822ee9373d 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -497,3 +497,22 @@ void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data)
 {
     do_run_on_cpu(cpu, func, data, &bql);
 }
+
+bool cpu_work_list_empty(CPUState *cpu)
+{
+    return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list);
+}
+
+int cpu_thread_is_idle_common(CPUState *cpu)
+{
+    if (cpu->stop || !cpu_work_list_empty(cpu)) {
+        return 0;
+    }
+    if (cpu_is_stopped(cpu)) {
+        return 1;
+    }
+    if (!cpu->halted || cpu_has_work(cpu)) {
+        return 0;
+    }
+    return -1;
+}
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 32bd3cad83f..d7fc24bc13d 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -231,6 +231,9 @@ int cpu_exec_user(CPUState *cs);
 void cpu_enter_syscall(CPUState *cs);
 void cpu_exit_syscall(CPUState *cs);
 
+int cpu_thread_is_idle_common(CPUState *cpu);
+bool cpu_thread_is_idle(CPUState *cpu);
+
 /**
  * env_archcpu(env)
  * @env: The architecture environment
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index b4a566cfe75..bfa3fd45650 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -21,7 +21,6 @@ void dummy_start_vcpu_thread(CPUState *);
 
 void cpus_kick_thread(CPUState *cpu);
 bool cpu_work_list_empty(CPUState *cpu);
-bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
 bool cpu_can_run(CPUState *cpu);
 void qemu_wait_io_event_common(CPUState *cpu);
diff --git a/system/cpus.c b/system/cpus.c
index fe84b822798..13072be26fa 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -75,21 +75,12 @@ bool cpu_is_stopped(CPUState *cpu)
     return cpu->stopped || !runstate_is_running();
 }
 
-bool cpu_work_list_empty(CPUState *cpu)
-{
-    return QSIMPLEQ_EMPTY_ATOMIC(&cpu->work_list);
-}
-
 bool cpu_thread_is_idle(CPUState *cpu)
 {
-    if (cpu->stop || !cpu_work_list_empty(cpu)) {
-        return false;
-    }
-    if (cpu_is_stopped(cpu)) {
-        return true;
-    }
-    if (!cpu->halted || cpu_has_work(cpu)) {
-        return false;
+    int ret = cpu_thread_is_idle_common(cpu);
+
+    if (ret != -1) {
+        return ret;
     }
     if (cpus_accel->cpu_thread_is_idle) {
         return cpus_accel->cpu_thread_is_idle(cpu);
-- 
2.46.0


