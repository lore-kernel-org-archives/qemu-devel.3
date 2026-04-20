Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582F9F5580B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 10:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEm78-0008Sf-Hw; Mon, 20 Apr 2026 06:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm77-0008Rx-LO
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:25 -0400
Received: from p-west3-cluster4-host2-snip4-10.eps.apple.com ([57.103.74.191]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEm76-0000o2-1Y
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 06:44:25 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPS id
 1481418000A8; Mon, 20 Apr 2026 10:44:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776681863; x=1779273863;
 bh=IdjugA9xaHsg2nQQQ2yDxOQbJO+pfnS1V2J1m3byuQQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Y4APNMHI8lrLheuTzlQECpUx0gB1wYDEygpQ9sQX7gRHR/lsXp3RzIK1l+DxWBKxDPEwu29O8Zfna0T6pxW2Jv1W/74S5ltzXNwi57PI2NKrDVEE3TqlMGRZM+M2xWW0uJScuhQqATPSTPT5a7/TFq6adHcdSdd86zoGsfRU9ng8w8YjKvYIegyeT4U6PO0q1OJFeW+BkpMTcjIy4DTnhaZPUzi3QsDFyzQ0jAkjsdnxZutD1QP44vuOf/4cz28iUzeoD4qqAEpJa1UrTcVVTr7HnteefAqm/lNrx550sJT3zD524g4OowlYmxT2XrwSoKz14udaqiUfOEjvLuCYDQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-1 (Postfix) with ESMTPSA id
 7AA7E1800097; Mon, 20 Apr 2026 10:44:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 35/38] target/i386: emulate, hvf: rdmsr/wrmsr GPF handling
Date: Mon, 20 Apr 2026 12:42:45 +0200
Message-ID: <20260420104248.86702-36-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260420104248.86702-1-mohamed@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4dx0tQky0FyRJ8etG-ROFUMLSj2qtuUc
X-Proofpoint-GUID: 4dx0tQky0FyRJ8etG-ROFUMLSj2qtuUc
X-Authority-Info-Out: v=2.4 cv=d7D4CBjE c=1 sm=1 tr=0 ts=69e60385
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=183X19KWV2qSZiVN73EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEwNCBTYWx0ZWRfX5moUkBXcARtm
 iUyAwV7jxo0KKe1iO+NnUujp3m65SxV8r/J7qYBJAuM2pTqOdrkEDhWF/sonW0Al/Rl2rwhhipC
 sI4nDTZHdA1PWz99R6t7aLsPgdnAAQWZPJEw7WL1JtX4vr64+fk7qv59WaESRLMYjlnnIBrtMdn
 mawfWoFp7jBy7k1hjnepKFmpVWpvAIlAhzWywjbpgwJ0V9QasBl/EjltqRP3SFqPw1EjUC+IQdZ
 38oOQ42uah3IKF3+gEudw0efqHh8UqBhfBwCjxB7rQzpsudLKzBcAJQHi9kgUoVEkacQAzOTGv3
 kzYnCd/lvxkNWtEDC3BDcV/K/Er+XJdc9nTjwZBNQ4mADUTub7HRftKoPYqVnM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=697
 adultscore=0 clxscore=1030 suspectscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604200104
Received-SPF: pass client-ip=57.103.74.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


