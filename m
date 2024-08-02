Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4CC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 10:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZp7E-0007MY-8K; Fri, 02 Aug 2024 06:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp7A-00079y-5E
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1sZp77-0004iq-0G
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 06:02:23 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729xmhq026998;
 Fri, 2 Aug 2024 10:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=jaf4NZqXAJUq7
 YRAbcqCdpqjW48Fp+pO5ITMV63+9UA=; b=L9TsIKHieWGF5+WQNKzWsiIDF98+e
 fr/MhoLD8IjiCI0TqVXk26EGTMxsTWLFQQ0VYkuoyOELR97qipYl/jqq0hOi3MyQ
 vzw79xc0riCAaQBZM5xU85HG64ZU/O+0scO16WJtlqlQcyS75M2+gr7rW6u97bCN
 kLBHT9n0m0/06Mwj1rfpoWZn+IhGMmyU44MlwOpTAU3uZWyJ2KP3it80ZpXxPKBp
 oslHhpFgnSCrrykCH/W0xp/4nM+ooGEQbUcMpDazRH8z2X9pqtKDuIgqWaYEJVET
 ZxU8B19VzHAw5SxGD3oNboAaJOV/DHikktPkYANAyLGtbVKiyQOctbhzw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rw9tr091-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472A2H4T030683;
 Fri, 2 Aug 2024 10:02:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rw9tr08x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 4726SNAf029118; Fri, 2 Aug 2024 10:02:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm16std-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Aug 2024 10:02:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 472A2CYN57803262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Aug 2024 10:02:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19FA12006B;
 Fri,  2 Aug 2024 10:02:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51892006A;
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
Subject: [PATCH 3/5] target/i386/gdbstub: Factor out gdb_get_reg() and
 gdb_write_reg()
Date: Fri,  2 Aug 2024 11:59:16 +0200
Message-ID: <20240802095942.34565-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802095942.34565-1-iii@linux.ibm.com>
References: <20240802095942.34565-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fNl_JTk-73h5PktGgvIjHAg2oSFRyTRI
X-Proofpoint-GUID: vKIzMZyDF7uCfsfcRfQFkEdYhYg2pjpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_06,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=673
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

i386 gdbstub handles both i386 and x86_64. Factor out two functions
for reading and writing registers without knowing their bitness.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 target/i386/gdbstub.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index 4acf485879e..ec64ab6c53f 100644
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
 
@@ -248,6 +253,22 @@ static int x86_cpu_gdb_load_seg(X86CPU *cpu, X86Seg sreg, uint8_t *mem_buf)
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
+        *val &= ~0xffffffffUL;
+        *val |= (uint32_t)ldl_p(mem_buf);
+        return 4;
+    }
+}
+
 int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -288,18 +309,7 @@ int x86_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
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
2.45.2


