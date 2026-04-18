Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C87F99C9D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFM-0008CC-TK; Sat, 18 Apr 2026 18:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFL-00086A-Go
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:39 -0400
Received: from p-east2-cluster1-host12-snip4-9.eps.apple.com ([57.103.76.62]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEFJ-0005FL-Ps
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:39 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 27F4418000FC; Sat, 18 Apr 2026 22:34:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551677; x=1779143677;
 bh=IdjugA9xaHsg2nQQQ2yDxOQbJO+pfnS1V2J1m3byuQQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=a4z+863NLCY/pk5Ci0Ocdvvsm9s/V/H7GtFjDWUWtBlHkLwOf+3YhEoL2yb+mltaNtkc6ma1pmy7DLiMZpLmF0/lGwqZWtyVsZ/0G1mn74oykbB2vrtcfmri9mGlGjzRNeOSeA7RBqJZjLVV+es8cii7MZfqCy42lkEMy+ZgFrUtgJvb9EhCWF2w22qjnT/ObV3cTb/lrRcT09KsvX2EaIZA4CXoWzIG8z78rLWgzSOsDcEM+iAhAyfI7efKc1V2LrmJdDw34fpJokKgTthVnyeMAslffwrBRJmLny/SwmC1cYMBrIoUBOUBy7Zi9VWdz/M2INuIevO6C9TARvS3tw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 56EA418000C4; Sat, 18 Apr 2026 22:34:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 35/38] target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
Date: Sun, 19 Apr 2026 00:33:17 +0200
Message-ID: <20260418223320.51330-36-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7Qp_TFdQSh-AecfZVKQKi9wOybeSg3Bf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOSBTYWx0ZWRfXylI5f6QgvWm3
 hccw+XSHHF6qrZaaXPg7YqUNP67fYJFoKrw+8y/Lf4nzGpZmMQwaa+eIEN+KMu9OYosKx1WzzaX
 49Nknp28P2p/7qeuYbSvN/dBP2vxQK22WNmKDN9jRTkpWP3eeCUPBA0uDwG9sanHIYhLBHUDqZ/
 9PZ2seme0bdTeXLbr83dHPJhea1HF44s2omv9iV6CUeIhEvZ74cjt7tkXW5+KGOiZ1P2Hn3+eyN
 hby9ljBhbx80O7ByHUq1QwPJE1BOOhzhUFYl8aGW4mydxKrnt9sVv4wqJERnYD9eZTgVeJDSDMl
 GFvWc+Wg9uzWzsJZaJhWct65+34nuARwUoSADN7LBwGXpYTltgvxUuL4+p4ye0=
X-Proofpoint-GUID: 7Qp_TFdQSh-AecfZVKQKi9wOybeSg3Bf
X-Authority-Info-Out: v=2.4 cv=W9M1lBWk c=1 sm=1 tr=0 ts=69e406fb
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=183X19KWV2qSZiVN73EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=697 lowpriorityscore=0 clxscore=1030 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180229
Received-SPF: pass client-ip=57.103.76.62;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In that case, the instruction pointer mustn't be incremented.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/emulate/x86_emu.c | 10 ++++++----
 target/i386/emulate/x86_emu.h |  4 ++--
 target/i386/hvf/hvf.c         |  9 +++++++--
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index c2da1a133f..c6ea854290 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -792,15 +792,17 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 static bool exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    emul_ops->simulate_rdmsr(env_cpu(env));
-    env->eip += decode->len;
+    if (!emul_ops->simulate_rdmsr(env_cpu(env))) {
+        env->eip += decode->len;
+    }
     return 0;
 }
 
 static bool exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    emul_ops->simulate_wrmsr(env_cpu(env));
-    env->eip += decode->len;
+    if (!emul_ops->simulate_wrmsr(env_cpu(env))) {
+        env->eip += decode->len;
+    }
     return 0;
 }
 
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a8d4c93098..b985240b90 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -31,8 +31,8 @@ struct x86_emul_ops {
     target_ulong (*read_cr) (CPUState *cpu, int cr);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
-    void (*simulate_rdmsr)(CPUState *cs);
-    void (*simulate_wrmsr)(CPUState *cs);
+    bool (*simulate_rdmsr)(CPUState *cs);
+    bool (*simulate_wrmsr)(CPUState *cs);
     bool (*is_protected_mode)(CPUState *cpu);
     bool (*is_long_mode)(CPUState *cpu);
     bool (*is_user_mode)(CPUState *cpu);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c0d028b147..dfe7500010 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -536,7 +536,7 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
-void hvf_simulate_rdmsr(CPUState *cs)
+bool hvf_simulate_rdmsr(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -557,6 +557,7 @@ void hvf_simulate_rdmsr(CPUState *cs)
         ret = apic_msr_read(cpu->apic_state, index, &val);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -639,9 +640,10 @@ void hvf_simulate_rdmsr(CPUState *cs)
 
     RAX(env) = (uint32_t)val;
     RDX(env) = (uint32_t)(val >> 32);
+    return 0;
 }
 
-void hvf_simulate_wrmsr(CPUState *cs)
+bool hvf_simulate_wrmsr(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
@@ -657,6 +659,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         r = cpu_set_apic_base(cpu->apic_state, data);
         if (r < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -668,6 +671,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
         ret = apic_msr_write(cpu->apic_state, index, data);
         if (ret < 0) {
             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
+            return 1;
         }
 
         break;
@@ -746,6 +750,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
          g_hypervisor_iface->wrmsr_handler(cs, msr, data);
 
     printf("write msr %llx\n", RCX(cs));*/
+    return 0;
 }
 
 static int hvf_handle_vmexit(CPUState *cpu)
-- 
2.50.1 (Apple Git-155)


