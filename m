Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A9BCF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpj-0006pb-Hg; Mon, 23 Sep 2024 12:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpZ-0006XR-Mn
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpV-0000bw-OO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDZhUv021374;
 Mon, 23 Sep 2024 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=G6WSdkmP42unl
 7WPudmenQYEVSbWuO/h9ns2kNpxwXY=; b=ryLjvYlbKvjRZZHwrYQLN5RhyLDsD
 CljMHZ8Ks/EblcjefQSphXTDAnY2XW777Ue6/CrRiMf3SLNhPBFddauv33niE9AG
 b7ef5lj+rB/mlPmWE0xRvc9oQHW6pKwhGRj/Q+V78NAcENYWOLDF9/I8fDL/Kstl
 6nIZlk48snTnE/3LWlBzfLXHNbA7fELZYOmlig26F1jZGnWoEdeUfU/9/6hw3F/z
 FpOSx5r4pk6fWWfkWQcSMyfiA/CrKQZBJx4bZjzuF3jE23OlhrZ1mZPkM4LJUT68
 MgzC7u5rsUYnZJhQz3JwQWdYsnrhM4F7ux4AxZJieeFFlTn4cy2N7HLfA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrd0er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGIBVM014485;
 Mon, 23 Sep 2024 16:22:24 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41skjrd0en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NFWlh2005810;
 Mon, 23 Sep 2024 16:22:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tapm77yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMLfI21496148
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E167820040;
 Mon, 23 Sep 2024 16:22:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CC0720043;
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
Subject: [PATCH 12/18] cpu: Track CPUs executing syscalls
Date: Mon, 23 Sep 2024 18:13:07 +0200
Message-ID: <20240923162208.90745-13-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DX4hwG0DnGeVJpmGJiT_6smOjOohWR3k
X-Proofpoint-ORIG-GUID: mRQOyG-HRFMncZnToMMkpkHygc50Bphy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

CPUs that execute syscalls should be considered paused by
all_vcpus_paused(). Lay the groundwork by introducing a bool field in
CPUState to track this. The field is not used by sysemu, but it's only
one byte, so it should not be a problem.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c         | 10 ++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 include/exec/cpu-common.h     |  2 ++
 include/hw/core/cpu.h         |  1 +
 linux-user/syscall.c          |  5 +++++
 5 files changed, 22 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7bd6e94b8e8..3ebace1e833 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1307,3 +1307,13 @@ void qemu_cpu_kick(CPUState *cpu)
 {
     cpu_exit(cpu);
 }
+
+void cpu_enter_syscall(CPUState *cs)
+{
+    cs->in_syscall = true;
+}
+
+void cpu_exit_syscall(CPUState *cs)
+{
+    cs->in_syscall = false;
+}
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index c2849d43223..9f54345e11b 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -936,6 +936,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 {
     abi_long ret;
 
+    cpu_enter_syscall(env_cpu(cpu_env));
+
     bql_unlock();
 
     if (do_strace) {
@@ -951,6 +953,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
     bql_lock();
 
+    cpu_exit_syscall(env_cpu(cpu_env));
+
     return ret;
 }
 
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 4a7b43f9aa3..32bd3cad83f 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -228,6 +228,8 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 int cpu_exec(CPUState *cpu);
 /* accel/tcg/user-exec.c */
 int cpu_exec_user(CPUState *cs);
+void cpu_enter_syscall(CPUState *cs);
+void cpu_exit_syscall(CPUState *cs);
 
 /**
  * env_archcpu(env)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1c9c775df65..d073a79731b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -475,6 +475,7 @@ struct CPUState {
     bool created;
     bool stop;
     bool stopped;
+    bool in_syscall;
 
     /* Should CPU start in powered-off state? */
     bool start_powered_off;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ff34ae11340..344c2e65234 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -13771,6 +13771,8 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
     }
 #endif
 
+    cpu_enter_syscall(cpu);
+
     record_syscall_start(cpu, num, arg1,
                          arg2, arg3, arg4, arg5, arg6, arg7, arg8);
 
@@ -13791,5 +13793,8 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
     bql_lock();
 
     record_syscall_return(cpu, num, ret);
+
+    cpu_exit_syscall(cpu);
+
     return ret;
 }
-- 
2.46.0


