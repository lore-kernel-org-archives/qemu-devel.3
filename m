Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E23EEB57C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sog9u-00070M-Lu; Thu, 12 Sep 2024 05:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9k-0006vg-6o
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9g-0004LT-7g
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6Q1Cf023704;
 Thu, 12 Sep 2024 09:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=sLzg4gVgou+L8
 /YeEQBK1DBF4DR+LjSB0I8+lMA45jM=; b=LUltwvGKOA9UsWIJQzJrwaH9X1tUC
 WW+rqQmiqa20q1pf8bEGqJUtKEFDVn6T9bJmyFmMHQy4C2gLQnLE1hnhwOLyLfYQ
 ASbWsnj2aR9Io/OzGfPpFk3yCmUh5HHH9YT/EZD9/xd9hF8BIunzJXCr1Xdpz0ur
 /FDsM6LPgOA2r9uuEADKNOBQgbuawquIqZN9qYW8UHReom6OMHQwsRILtOvON4+v
 GHeKYeoBf/vYFWMz31FuJgSQk8gO0dTMhboYx8yL/uRj39Tv601KwcY/3OPCfOik
 irIkD+mZ6pmI9M9rNr2XmEHV0p8gARyQWzaIWxJmhYuMLgDLB+FJqo+wQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebajqa6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:20 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C9UJDW012239;
 Thu, 12 Sep 2024 09:30:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebajqa0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C6rOu5032103;
 Thu, 12 Sep 2024 09:30:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h2nmxx3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C9UGQh57803136
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 09:30:16 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C4292004D;
 Thu, 12 Sep 2024 09:30:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BE2C20040;
 Thu, 12 Sep 2024 09:30:16 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.24.155])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 09:30:15 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 2/5] linux-user/i386: Emulate orig_ax
Date: Thu, 12 Sep 2024 11:28:21 +0200
Message-ID: <20240912093012.402366-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912093012.402366-1-iii@linux.ibm.com>
References: <20240912093012.402366-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4Lzhc4wAQwIAPKHNCIrftTvwKgh_lY0H
X-Proofpoint-GUID: 1HCZYHqAxXAoJvASlPMJgI9pbb8EZ3Ga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=842 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409120063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The kernel uses orig_rax/orig_eax to store the syscall number before
a syscall. One can see this value in core dumps and ptrace.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c       | 4 ++--
 linux-user/i386/cpu_loop.c | 3 +++
 linux-user/qemu.h          | 4 ++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 05292c27776..2d73382ae6b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -203,7 +203,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
     (*regs)[12] = tswapreg(env->regs[R_EDX]);
     (*regs)[13] = tswapreg(env->regs[R_ESI]);
     (*regs)[14] = tswapreg(env->regs[R_EDI]);
-    (*regs)[15] = tswapreg(env->regs[R_EAX]); /* XXX */
+    (*regs)[15] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
     (*regs)[16] = tswapreg(env->eip);
     (*regs)[17] = tswapreg(env->segs[R_CS].selector & 0xffff);
     (*regs)[18] = tswapreg(env->eflags);
@@ -306,7 +306,7 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUX86State *en
     (*regs)[8] = tswapreg(env->segs[R_ES].selector & 0xffff);
     (*regs)[9] = tswapreg(env->segs[R_FS].selector & 0xffff);
     (*regs)[10] = tswapreg(env->segs[R_GS].selector & 0xffff);
-    (*regs)[11] = tswapreg(env->regs[R_EAX]); /* XXX */
+    (*regs)[11] = tswapreg(get_task_state(env_cpu_const(env))->orig_ax);
     (*regs)[12] = tswapreg(env->eip);
     (*regs)[13] = tswapreg(env->segs[R_CS].selector & 0xffff);
     (*regs)[14] = tswapreg(env->eflags);
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 8707a3eaf25..43ad4e2f39e 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -172,6 +172,7 @@ static void emulate_vsyscall(CPUX86State *env)
     /*
      * Perform the syscall.  None of the vsyscalls should need restarting.
      */
+    get_task_state(env_cpu(env))->orig_ax = syscall;
     ret = do_syscall(env, syscall, env->regs[R_EDI], env->regs[R_ESI],
                      env->regs[R_EDX], env->regs[10], env->regs[8],
                      env->regs[9], 0, 0);
@@ -218,6 +219,7 @@ void cpu_loop(CPUX86State *env)
         case EXCP_SYSCALL:
 #endif
             /* linux syscall from int $0x80 */
+            get_task_state(cs)->orig_ax = env->regs[R_EAX];
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EBX],
@@ -236,6 +238,7 @@ void cpu_loop(CPUX86State *env)
 #ifdef TARGET_X86_64
         case EXCP_SYSCALL:
             /* linux syscall from syscall instruction.  */
+            get_task_state(cs)->orig_ax = env->regs[R_EAX];
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EDI],
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index a2961f503f4..92b2bee87b1 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -113,6 +113,10 @@ struct TaskState {
     struct target_vm86plus_struct vm86plus;
     uint32_t v86flags;
     uint32_t v86mask;
+#endif
+#if defined(TARGET_I386)
+    /* Last syscall number. */
+    target_ulong orig_ax;
 #endif
     abi_ulong child_tidptr;
 #ifdef TARGET_M68K
-- 
2.46.0


