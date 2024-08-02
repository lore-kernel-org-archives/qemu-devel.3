Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87772C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZp7B-0007ES-Tn; Fri, 02 Aug 2024 06:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp78-00078y-Py
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp76-0004dU-R5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729HIZM018789;
 Fri, 2 Aug 2024 10:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=xgiNEOZec+cTa
 1XyCOikEGB8SlWebH4QPlQyjtj1wUE=; b=oh/SvruPCSevgRBiLtsM1Q8v/phPD
 pHG8NitNA1x5TQd4vV6f3svYfUiDeJwamegV4osgspxfbLMsCfxkb7HCPImPaHnh
 Z+bHQ7bOlnofW7CfOsTux9+rMwJwhBLysTt8l9KIf4kcBk3JTuqevs2N6Vv1ydF+
 A+5BkCV+xFUsACHUMyy0p4FD7e2weOqVfNg3aw7l9ACyTC/wVAJ3SnnUeqtsZmmO
 uLSM/u2PGeLRpo9A+bvyaapQdr0+uuhXFMtqKjk6rqVzROt+1J4pWIFByork6j9l
 IYHZNEegEjcm7zRseOHcJ+ds6S3mck53xhMmCGxPU31h2tndMmL8fctbA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ruypg6mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472A2HFQ006523;
 Fri, 2 Aug 2024 10:02:17 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ruypg6mk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4728orcN009205; Fri, 2 Aug 2024 10:02:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40ndx3eatf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 472A2CS851446106
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2024 10:02:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4B4920067;
 Fri,  2 Aug 2024 10:02:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C91D2004F;
 Fri,  2 Aug 2024 10:02:11 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.14.120])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2024 10:02:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/5] linux-user/i386: Emulate orig_ax
Date: Fri,  2 Aug 2024 11:59:15 +0200
Message-ID: <20240802095942.34565-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802095942.34565-1-iii@linux.ibm.com>
References: <20240802095942.34565-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rwiB53lT8I59F_9Rj7dfo6_S53MLMD9b
X-Proofpoint-ORIG-GUID: xQoDlqG88Gie9iMIojC94aZjD5as5CaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_06,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 suspectscore=0 mlxlogscore=913 phishscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The kernel uses orig_rax/orig_eax to store the syscall number before
a syscall. One can see this value in core dumps and ptrace.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/elfload.c       | 4 ++--
 linux-user/i386/cpu_loop.c | 3 +++
 linux-user/qemu.h          | 5 +++++
 3 files changed, 10 insertions(+), 2 deletions(-)

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
index 92beb6830cc..7a35215278a 100644
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
@@ -221,6 +222,7 @@ void cpu_loop(CPUX86State *env)
         case EXCP_SYSCALL:
 #endif
             /* linux syscall from int $0x80 */
+            get_task_state(cs)->orig_ax = env->regs[R_EAX];
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EBX],
@@ -239,6 +241,7 @@ void cpu_loop(CPUX86State *env)
 #ifdef TARGET_X86_64
         case EXCP_SYSCALL:
             /* linux syscall from syscall instruction.  */
+            get_task_state(cs)->orig_ax = env->regs[R_EAX];
             ret = do_syscall(env,
                              env->regs[R_EAX],
                              env->regs[R_EDI],
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index a2961f503f4..85ba5a53869 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -159,6 +159,11 @@ struct TaskState {
 
     /* Start time of task after system boot in clock ticks */
     uint64_t start_boottime;
+
+#if defined(TARGET_I386)
+    /* Last syscall number. */
+    target_ulong orig_ax;
+#endif
 };
 
 abi_long do_brk(abi_ulong new_brk);
-- 
2.45.2


