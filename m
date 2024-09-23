Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FC0CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 16:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sslpo-000790-Vg; Mon, 23 Sep 2024 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpZ-0006XQ-NT
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sslpV-0000c9-6x
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 12:22:33 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N3ge9T015793;
 Mon, 23 Sep 2024 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=ykbgOs+Qb6ZSM
 Dq+eqthx7Au/caWdgCO0evwfHJo8Ys=; b=T85k0tOAdv7MKW1YLGYse972Oo/sB
 2nZsci/fiei/hn3PnITC0KUpUaDq6P4GaCHeOArNJhHszurb8GUrMQyzASIZYpFF
 5R5NqZ8VV5jAk4kUDZe4JLslJ9aaPUcmKGdwOdk/LJzZHWCr8b8fW7wS+1DA71SU
 xwrXbIASbOuVvMtUkfXc0eKl25d8kmCHDtsdijW3xGY5bFX5icvmP8s8HwoVblKV
 atJgMsqOAzQDIqU6fh7V876SWY3T6gGnDl0up6kZhM0uQjx2OMYynG/g8fY3alld
 YegbnqhjJJEedKW7SwtLPp6pvqicjuc/ar8m2x+qKqVfg6gSJB4wBjYuw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGMMpf032099;
 Mon, 23 Sep 2024 16:22:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41sntw558p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NDhh9Z008707;
 Mon, 23 Sep 2024 16:22:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t8v0ym0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:22:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48NGMIMF24773346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Sep 2024 16:22:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC22A20043;
 Mon, 23 Sep 2024 16:22:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 767442004D;
 Mon, 23 Sep 2024 16:22:18 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.179.24.235])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Sep 2024 16:22:18 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 05/18] accel/tcg: Factor out cpu_exec_user()
Date: Mon, 23 Sep 2024 18:13:00 +0200
Message-ID: <20240923162208.90745-6-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923162208.90745-1-iii@linux.ibm.com>
References: <20240923162208.90745-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q1bTbAzMFirASzwuIpC_ZPj8dMONCBXA
X-Proofpoint-GUID: ccqZCz8M9PKIMyXUIvRoXJCfQ7yZN_Xt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=491 bulkscore=0 phishscore=0
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

All linux-user cpu_loop() implementations contain the same sequence
of function calls. Factor them out so that they can be changed in one
place.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/user-exec.c              | 12 ++++++++++++
 bsd-user/aarch64/target_arch_cpu.h |  6 +-----
 bsd-user/arm/target_arch_cpu.h     |  5 +----
 bsd-user/i386/target_arch_cpu.h    |  5 +----
 bsd-user/x86_64/target_arch_cpu.h  |  5 +----
 include/exec/cpu-common.h          |  2 ++
 linux-user/aarch64/cpu_loop.c      |  5 +----
 linux-user/alpha/cpu_loop.c        |  5 +----
 linux-user/arm/cpu_loop.c          |  5 +----
 linux-user/hexagon/cpu_loop.c      |  5 +----
 linux-user/hppa/cpu_loop.c         |  5 +----
 linux-user/i386/cpu_loop.c         |  5 +----
 linux-user/loongarch64/cpu_loop.c  |  5 +----
 linux-user/m68k/cpu_loop.c         |  5 +----
 linux-user/microblaze/cpu_loop.c   |  5 +----
 linux-user/mips/cpu_loop.c         |  5 +----
 linux-user/openrisc/cpu_loop.c     |  5 +----
 linux-user/ppc/cpu_loop.c          |  5 +----
 linux-user/riscv/cpu_loop.c        |  5 +----
 linux-user/s390x/cpu_loop.c        |  5 +----
 linux-user/sh4/cpu_loop.c          |  5 +----
 linux-user/sparc/cpu_loop.c        |  5 +----
 linux-user/xtensa/cpu_loop.c       |  5 +----
 23 files changed, 35 insertions(+), 85 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 7ddc47b0ba4..ca3e8e988ee 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1288,3 +1288,15 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
 #define DATA_SIZE 16
 #include "atomic_template.h"
 #endif
+
+int cpu_exec_user(CPUState *cs)
+{
+    int trapnr;
+
+    cpu_exec_start(cs);
+    trapnr = cpu_exec(cs);
+    cpu_exec_end(cs);
+    process_queued_cpu_work(cs);
+
+    return trapnr;
+}
diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index b288e0d069b..6ab6c07e973 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -51,11 +51,7 @@ static inline void target_cpu_loop(CPUARMState *env)
     abi_long ret;
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
+        trapnr = cpu_exec_user(cs);
         switch (trapnr) {
         case EXCP_SWI:
             /* See arm64/arm64/trap.c cpu_fetch_syscall_args() */
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
index 517d0087644..2fa97c168c0 100644
--- a/bsd-user/arm/target_arch_cpu.h
+++ b/bsd-user/arm/target_arch_cpu.h
@@ -43,10 +43,7 @@ static inline void target_cpu_loop(CPUARMState *env)
     CPUState *cs = env_cpu(env);
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
         switch (trapnr) {
         case EXCP_UDEF:
         case EXCP_NOCP:
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index 9bf2c4244b7..cbc4d77daba 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -110,10 +110,7 @@ static inline void target_cpu_loop(CPUX86State *env)
     /* target_siginfo_t info; */
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case 0x80: {
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
index 4094d61da1a..5442056d009 100644
--- a/bsd-user/x86_64/target_arch_cpu.h
+++ b/bsd-user/x86_64/target_arch_cpu.h
@@ -118,10 +118,7 @@ static inline void target_cpu_loop(CPUX86State *env)
     /* target_siginfo_t info; */
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2e1b499cb71..4a7b43f9aa3 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -226,6 +226,8 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
+/* accel/tcg/user-exec.c */
+int cpu_exec_user(CPUState *cs);
 
 /**
  * env_archcpu(env)
diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 71cdc8be50c..9104996fd46 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -83,10 +83,7 @@ void cpu_loop(CPUARMState *env)
     abi_long ret;
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_SWI:
diff --git a/linux-user/alpha/cpu_loop.c b/linux-user/alpha/cpu_loop.c
index 2ea039aa71f..dda42aa9ee7 100644
--- a/linux-user/alpha/cpu_loop.c
+++ b/linux-user/alpha/cpu_loop.c
@@ -32,10 +32,7 @@ void cpu_loop(CPUAlphaState *env)
     while (1) {
         bool arch_interrupt = true;
 
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_RESET:
diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index ec665862d93..81fb01c4f95 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -325,10 +325,7 @@ void cpu_loop(CPUARMState *env)
     abi_ulong ret;
 
     for(;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch(trapnr) {
         case EXCP_UDEF:
diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index d41159e52ad..678d8a42abb 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -33,10 +33,7 @@ void cpu_loop(CPUHexagonState *env)
     target_ulong ret;
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index bc093b8fe8b..121763a56cb 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -114,10 +114,7 @@ void cpu_loop(CPUHPPAState *env)
     int trapnr;
 
     while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 92beb6830cc..8707a3eaf25 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -210,10 +210,7 @@ void cpu_loop(CPUX86State *env)
     abi_ulong ret;
 
     for(;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch(trapnr) {
         case 0x80:
diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 73d7b6796a4..1735c1c4ff1 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -18,10 +18,7 @@ void cpu_loop(CPULoongArchState *env)
     abi_long ret;
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/m68k/cpu_loop.c b/linux-user/m68k/cpu_loop.c
index f79b8e4ab05..8e2f9161c64 100644
--- a/linux-user/m68k/cpu_loop.c
+++ b/linux-user/m68k/cpu_loop.c
@@ -30,10 +30,7 @@ void cpu_loop(CPUM68KState *env)
     unsigned int n;
 
     for(;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch(trapnr) {
         case EXCP_ILLEGAL:
diff --git a/linux-user/microblaze/cpu_loop.c b/linux-user/microblaze/cpu_loop.c
index 212e62d0a62..3867a62c07b 100644
--- a/linux-user/microblaze/cpu_loop.c
+++ b/linux-user/microblaze/cpu_loop.c
@@ -29,10 +29,7 @@ void cpu_loop(CPUMBState *env)
     CPUState *cs = env_cpu(env);
 
     while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 462387a0737..d14af50cbbe 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -71,10 +71,7 @@ void cpu_loop(CPUMIPSState *env)
 # endif
 
     for(;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch(trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/openrisc/cpu_loop.c b/linux-user/openrisc/cpu_loop.c
index a7aa586c8f9..f1eb799bd27 100644
--- a/linux-user/openrisc/cpu_loop.c
+++ b/linux-user/openrisc/cpu_loop.c
@@ -30,10 +30,7 @@ void cpu_loop(CPUOpenRISCState *env)
     abi_long ret;
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_SYSCALL:
diff --git a/linux-user/ppc/cpu_loop.c b/linux-user/ppc/cpu_loop.c
index 02204ad8beb..53a6ad996f3 100644
--- a/linux-user/ppc/cpu_loop.c
+++ b/linux-user/ppc/cpu_loop.c
@@ -74,10 +74,7 @@ void cpu_loop(CPUPPCState *env)
     for(;;) {
         bool arch_interrupt;
 
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         arch_interrupt = true;
         switch (trapnr) {
diff --git a/linux-user/riscv/cpu_loop.c b/linux-user/riscv/cpu_loop.c
index 52c49c2e426..e9013b312d2 100644
--- a/linux-user/riscv/cpu_loop.c
+++ b/linux-user/riscv/cpu_loop.c
@@ -33,10 +33,7 @@ void cpu_loop(CPURISCVState *env)
     target_ulong ret;
 
     for (;;) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/s390x/cpu_loop.c b/linux-user/s390x/cpu_loop.c
index 8b7ac2879ef..d8231403b65 100644
--- a/linux-user/s390x/cpu_loop.c
+++ b/linux-user/s390x/cpu_loop.c
@@ -61,10 +61,7 @@ void cpu_loop(CPUS390XState *env)
     abi_long ret;
 
     while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
diff --git a/linux-user/sh4/cpu_loop.c b/linux-user/sh4/cpu_loop.c
index c805f9db110..282d955ee92 100644
--- a/linux-user/sh4/cpu_loop.c
+++ b/linux-user/sh4/cpu_loop.c
@@ -31,10 +31,7 @@ void cpu_loop(CPUSH4State *env)
     while (1) {
         bool arch_interrupt = true;
 
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case 0x160:
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 50424a54df5..8923a44d607 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -217,10 +217,7 @@ void cpu_loop (CPUSPARCState *env)
     abi_long ret;
 
     while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         switch (trapnr) {
         case TARGET_TT_SYSCALL:
diff --git a/linux-user/xtensa/cpu_loop.c b/linux-user/xtensa/cpu_loop.c
index d51ce053926..7eb21415213 100644
--- a/linux-user/xtensa/cpu_loop.c
+++ b/linux-user/xtensa/cpu_loop.c
@@ -130,10 +130,7 @@ void cpu_loop(CPUXtensaState *env)
     int trapnr;
 
     while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
+        trapnr = cpu_exec_user(cs);
 
         env->sregs[PS] &= ~PS_EXCM;
         switch (trapnr) {
-- 
2.46.0


