Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DA5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZp7E-0007M8-5p; Fri, 02 Aug 2024 06:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp7A-0007AU-Dc
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp76-0004et-He
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729uS1N013971;
 Fri, 2 Aug 2024 10:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:mime-version; s=pp1; bh=6cyJwVwQiB19W
 8amtncYiVUFzK3zjHt38qcWFDXwo2w=; b=BtXvZ/O+UC+6v3pvtBPHW8+ZLrB5u
 auFI6cEq+0Tn6/Ax+xvUEqO/kongrFpfUhymBlcyLy/PSNueKn4ddG4ZIChbulPk
 eRIOYRM3XqTIJe86vgFckMVOnruRevCFMBBPwfREeQ/0D7u+mqjx4Sm8z3IbKoDu
 El1JNdEFM7SD2c+CAeTj86pZZg+D2OMNsqS/y46tg7GDgnS27dr+U0npTfMRp3CS
 qPbe2WYwkcummIQhD3Xi1T3ln0rBISbK9GYhWti1yi5loa1im20yxm0mwv8hchy5
 x1RLSI0WcSWQcPJGL9RIdX6ptqTiKIbzaklfzl74909Ks+5vxbMnh44Lw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rq508qqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472A2Hsp025352;
 Fri, 2 Aug 2024 10:02:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rq508qqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4727fQWO011170; Fri, 2 Aug 2024 10:02:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn6jp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 472A2CXS56885606
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2024 10:02:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 817FF2004F;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A7A72006C;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.14.120])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 4/5] target/i386/gdbstub: Expose orig_ax
Date: Fri,  2 Aug 2024 11:59:17 +0200
Message-ID: <20240802095942.34565-5-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802095942.34565-1-iii@linux.ibm.com>
References: <20240802095942.34565-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PFSZ990M2gV_1YJo7qm3hd59EuTbrzfk
X-Proofpoint-ORIG-GUID: QUXnaIjrIg2Hvk0ozlYVDBKGCAgTNxbK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_06,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 mlxlogscore=934 adultscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408020066
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

Copy XML files describing orig_ax from GDB and glue them with
CPUX86State.orig_ax.

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
index c6cc035df3d..f2819e91007 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2226,6 +2226,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
 int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
+void x86_cpu_gdb_init(CPUState *cs);
 
 void x86_cpu_list(void);
 int cpu_x86_support_mca_broadcast(CPUX86State *env);
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index ec64ab6c53f..ff688bd26ed 100644
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
@@ -407,3 +412,49 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
2.45.2


