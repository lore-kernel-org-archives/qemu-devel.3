Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FB4EEB576
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 09:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sog9x-0007Af-CV; Thu, 12 Sep 2024 05:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9k-0006vf-6q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sog9g-0004LJ-7T
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 05:30:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48C41oF0022813;
 Thu, 12 Sep 2024 09:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=nZ5ZfuY8DqKcZ
 UIZERfUXcnqAcq5EHxmfo32LBk7SZo=; b=FEGqt8QpmeQxwXB/ajTOeOBN4hEZY
 3PjuCSfwUxlyKH9gaHyG4DDdJqT3CpmLTNk9gjIqcU4j5skqq2lETv8XV0dfceAf
 dGu+MaAcc5A4PC7grHib13bRgECVc2dYZeAUkwcUctwMSQ6m2+7U+2yNYcJiiYp+
 HAdOF+l2nezr/rJaiuWnTh4BJ6vunfqk1vT837maqvR7ETiyO1Q0qNeBCWarYaPN
 SWBy3FfpwnXchtqbnBX5MnXegqW5iEgbGspuHvac85t866o0xC9Zft+yPzFz62Pz
 C3T930AOIe/i07Ti3eQb8Gpr67C6aKplOPTFUksMuhKUh/sg31/D8+nxQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qjwst-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48C9UI6Z015105;
 Thu, 12 Sep 2024 09:30:19 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8qjwsq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48C7QDeQ027333;
 Thu, 12 Sep 2024 09:30:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v3eq3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 09:30:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48C9UGMW52167152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 09:30:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF4B120043;
 Thu, 12 Sep 2024 09:30:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F20020040;
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
Subject: [PATCH v2 3/5] target/i386/gdbstub: Factor out gdb_get_reg() and
 gdb_write_reg()
Date: Thu, 12 Sep 2024 11:28:22 +0200
Message-ID: <20240912093012.402366-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912093012.402366-1-iii@linux.ibm.com>
References: <20240912093012.402366-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x9vuZVoIRF2VVZ2gzin6UvFCOP4ltjJS
X-Proofpoint-ORIG-GUID: 8xR7GoCXNw5aLXBQ_Sqom08AL850ksF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_01,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=704 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120063
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

i386 gdbstub handles both i386 and x86_64. Factor out two functions
for reading and writing registers without knowing their bitness.

While at it, simplify the TARGET_LONG_BITS == 32 case.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/i386/gdbstub.c | 51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 4acf485879e..cc5eceeb7eb 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -96,6 +96,19 @@ static int gdb_write_reg_cs64(uint32_t hflags, uint8_t *buf, target_ulong *val)
     return 4;
 }
 
+static int gdb_get_reg(CPUX86State *env, GByteArray *mem_buf, target_ulong val)
+{
+    if (TARGET_LONG_BITS == 64) {
+        if (env->hflags & HF_CS64_MASK) {
+            return gdb_get_reg64(mem_buf, val);
+        } else {
+            return gdb_get_reg64(mem_buf, val & 0xffffffffUL);
+        }
+    } else {
+        return gdb_get_reg32(mem_buf, val);
+    }
+}
+
 int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -137,15 +150,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            if (TARGET_LONG_BITS == 64) {
-                if (env->hflags & HF_CS64_MASK) {
-                    return gdb_get_reg64(mem_buf, env->eip);
-                } else {
-                    return gdb_get_reg64(mem_buf, env->eip & 0xffffffffUL);
-                }
-            } else {
-                return gdb_get_reg32(mem_buf, env->eip);
-            }
+            return gdb_get_reg(env, mem_buf, env->eip);
         case IDX_FLAGS_REG:
             return gdb_get_reg32(mem_buf, env->eflags);
 
@@ -248,6 +253,21 @@ static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
     return 4;
 }
 
+static int gdb_write_reg(CPUX86State *env, uint8_t *mem_buf, target_ulong *val)
+{
+    if (TARGET_LONG_BITS == 64) {
+        if (env->hflags & HF_CS64_MASK) {
+            *val = ldq_p(mem_buf);
+        } else {
+            *val = ldq_p(mem_buf) & 0xffffffffUL;
+        }
+        return 8;
+    } else {
+        *val = (uint32_t)ldl_p(mem_buf);
+        return 4;
+    }
+}
+
 int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -288,18 +308,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     } else {
         switch (n) {
         case IDX_IP_REG:
-            if (TARGET_LONG_BITS == 64) {
-                if (env->hflags & HF_CS64_MASK) {
-                    env->eip = ldq_p(mem_buf);
-                } else {
-                    env->eip = ldq_p(mem_buf) & 0xffffffffUL;
-                }
-                return 8;
-            } else {
-                env->eip &= ~0xffffffffUL;
-                env->eip |= (uint32_t)ldl_p(mem_buf);
-                return 4;
-            }
+            return gdb_write_reg(env, mem_buf, &env->eip);
         case IDX_FLAGS_REG:
             env->eflags = ldl_p(mem_buf);
             return 4;
-- 
2.46.0


