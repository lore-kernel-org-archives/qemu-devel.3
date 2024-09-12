Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A15EEB57B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sog9v-00074Q-Iw; Thu, 12 Sep 2024 05:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9k-0006vh-6x
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9g-0004LX-8p
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BIpASP013414;
 Thu, 12 Sep 2024 09:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:mime-version; s=pp1; bh=z15MGlbE7xNbf
 KEJzQJx28SesNJPf3ivaIA6ZPPyPdw=; b=TSCQ58hNNHNzzzANuOzOipKNUj7pF
 +MfnLD2JwlAOGGpQ4UbXWOQsjrkzwYkUuGVm+RhsejZbHQ93aERBCSwWfSSYt/wB
 YQvuKPpHDy0Q/et1K4xgdn4hzD9OtmRwGSEKjCcNRq+Y6wni9WkhNTZrXTW7yYZd
 Hc3KMR2SAk/7aiBZtX8P1PxqifojxqhkIpZTlbD4u/MjQ3cEN9eJrTg8W1EkU6Kb
 Yqr3zUNN7lqm2uT0yMhJZbpaErnJyUsYwjMKtLF/49Fpb/x+Fv0O5kTdhr7orxna
 RuL3zd3k4gxQd8zCLUKqOISB9fZazECSrX+e5kG9+KuEedzzeuVs67Frg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx2qrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:21 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C9T1Ul018821;
 Thu, 12 Sep 2024 09:30:20 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegx2qrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C8Q44X003141;
 Thu, 12 Sep 2024 09:30:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h15u767k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C9UHlr53150096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 09:30:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DED42004B;
 Thu, 12 Sep 2024 09:30:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1DF320040;
 Thu, 12 Sep 2024 09:30:16 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.24.155])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 09:30:16 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 4/5] target/i386/gdbstub: Expose orig_ax
Date: Thu, 12 Sep 2024 11:28:23 +0200
Message-ID: <20240912093012.402366-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912093012.402366-1-iii@linux.ibm.com>
References: <20240912093012.402366-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i9WFuKSwO2qVuHAKfe3yZx0DNjwJHqfs
X-Proofpoint-ORIG-GUID: LhQmdMKb_lvCQ0KQ4vUU49ONfr_DbMmn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=969
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120063
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

Copy XML files describing orig_ax from GDB and glue them with
CPUX86State.orig_ax.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 configs/targets/i386-linux-user.mak   |  2 +-
 configs/targets/x86_64-linux-user.mak |  2 +-
 gdb-xml/i386-32bit-linux.xml          | 11 ++++++
 gdb-xml/i386-64bit-linux.xml          | 11 ++++++
 target/i386/cpu.c                     |  1 +
 target/i386/cpu.h                     |  1 +
 target/i386/gdbstub.c                 | 51 +++++++++++++++++++++++++++
 7 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 gdb-xml/i386-32bit-linux.xml
 create mode 100644 gdb-xml/i386-64bit-linux.xml

diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index 5b2546a4309..b72a156473a 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -1,4 +1,4 @@
 TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
-TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_XML_FILES= gdb-xml/i386-32bit.xml gdb-xml/i386-32bit-linux.xml
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 9ceefbb615a..86042814d39 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -2,4 +2,4 @@ TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
-TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
diff --git a/gdb-xml/i386-32bit-linux.xml b/gdb-xml/i386-32bit-linux.xml
new file mode 100644
index 00000000000..5ffe5616e63
--- /dev/null
+++ b/gdb-xml/i386-32bit-linux.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2024 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.linux">
+  <reg name="orig_eax" bitsize="32" type="int"/>
+</feature>
diff --git a/gdb-xml/i386-64bit-linux.xml b/gdb-xml/i386-64bit-linux.xml
new file mode 100644
index 00000000000..0f26990d2f7
--- /dev/null
+++ b/gdb-xml/i386-64bit-linux.xml
@@ -0,0 +1,11 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2010-2024 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.i386.linux">
+  <reg name="orig_rax" bitsize="64" type="int"/>
+</feature>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c04..52788e6170d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7831,6 +7831,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 
     mce_init(cpu);
 
+    x86_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 
     /*
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 14edd57a37b..dc2e074e227 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2231,6 +2231,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void x86_cpu_gdb_init(CPUState *cs);
 
 void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index cc5eceeb7eb..04c49e802d7 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -18,8 +18,13 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "accel/tcg/vcpu-state.h"
 #include "cpu.h"
+#include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
+#ifdef CONFIG_LINUX_USER
+#include "linux-user/qemu.h"
+#endif
 
 #ifdef TARGET_X86_64
 static const int gpr_map[16] = {
@@ -406,3 +411,49 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     /* Unrecognised register.  */
     return 0;
 }
+
+#ifdef CONFIG_LINUX_USER
+
+#define IDX_ORIG_AX 0
+
+static int x86_cpu_gdb_read_linux_register(CPUState *cs, GByteArray *mem_buf,
+                                           int n)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    switch (n) {
+    case IDX_ORIG_AX:
+        return gdb_get_reg(env, mem_buf, get_task_state(cs)->orig_ax);
+    }
+    return 0;
+}
+
+static int x86_cpu_gdb_write_linux_register(CPUState *cs, uint8_t *mem_buf,
+                                            int n)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    switch (n) {
+    case IDX_ORIG_AX:
+        return gdb_write_reg(env, mem_buf, &get_task_state(cs)->orig_ax);
+    }
+    return 0;
+}
+
+#endif
+
+void x86_cpu_gdb_init(CPUState *cs)
+{
+#ifdef CONFIG_LINUX_USER
+    gdb_register_coprocessor(cs, x86_cpu_gdb_read_linux_register,
+                             x86_cpu_gdb_write_linux_register,
+#ifdef TARGET_X86_64
+                             gdb_find_static_feature("i386-64bit-linux.xml"),
+#else
+                             gdb_find_static_feature("i386-32bit-linux.xml"),
+#endif
+                             0);
+#endif
+}
-- 
2.46.0


