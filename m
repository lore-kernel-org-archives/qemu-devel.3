Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B971CCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 15:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAV9C-0001yB-Od; Sun, 19 Oct 2025 11:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV9B-0001wR-5m
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:37 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1vAV99-0003Ba-7a
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 11:16:36 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 1777560A6C
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 17:16:34 +0200 (CEST)
Received: (qmail 23134 invoked by uid 990); 19 Oct 2025 15:16:34 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 19 Oct 2025 17:16:33 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v8 09/25] target/i386: call plugin trap callbacks
Date: Sun, 19 Oct 2025 17:14:58 +0200
Message-ID: <5fb50dd708c97604112c95fcf33045cfe215901a.1760884672.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1760884672.git.neither@nut.email>
References: <cover.1760884672.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999997) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=4wIyJdUT0Wq/HXsJOsBJPGZgllzvhv7UsSxinsdLJ6s=;
 b=PbfI4ZPKQRz4TJLXwGDwL+8wZ8cSZIYv666sDlb4D6SbxeXOF94owcdb1mZtv5iLdDRvBI4EpD
 h6kXWtRKuS5c9OqFq552nA+Epm+t61zbnfzrke9195Q/YKaPJUNy7n70gzuG7TokPdpFqiGjc+kq
 2xHUV41noLSdHjrpZFXbP+Cj6O5zI6w+927XjuZVqGfq3moB4iQOY6kfN92npWvycOSo+Pr8nlRA
 2bMxDBvMVZQc/uus7bkkCsLizHD2HQBcqCV9HBALhjVIvXYw8k+u1g0nRYGEBTCQNL9L/SHQL+T5
 1DtKIiq0G7MtMEW9UCOVDDpGhle1DA+8KTOVdAjk6oNy3DiKVI2UgB0fqzBzaWhI5lCgFIusbVld
 OOFTo+/9LsgJfKLwckq2kyjYsvGw0cH/Y+eNkNjaSp/Odx43wLCTi0yav7aBMnA3s0BVQH7mplG5
 rnXLnOts7Py1tYN9NxK6ZhnvkEUcA4W/BSqfGGr1GO7NIITDQ33mNbZT8iy5TmPmwl743IUwK6Mi
 zBvKHFnkOHtz+dHSCinXp+oqsECtM0PdcRDUa0eSf7XYFtU3riFAjh1p5t6SiTX9LrA6TPxntXh1
 Tw8P3iXNOwHNQaNKcY1nLqLtQ6kmy+EIs+5kYJ9y1bgFxQfyWKScF1AfpDuQVxFuNWwYh8x1il7M
 A=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places the hook for x86 targets.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 target/i386/tcg/excp_helper.c | 3 +++
 target/i386/tcg/seg_helper.c  | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 6fb8036d98..32f2784e92 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -23,6 +23,7 @@
 #include "system/runstate.h"
 #include "exec/helper-proto.h"
 #include "helper-tcg.h"
+#include "qemu/plugin.h"
 
 G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
                                           int next_eip_addend)
@@ -93,6 +94,7 @@ void raise_interrupt2(CPUX86State *env, int intno,
                       uintptr_t retaddr)
 {
     CPUState *cs = env_cpu(env);
+    uint64_t last_pc = env->eip + env->segs[R_CS].base;
 
     if (!is_int) {
         cpu_svm_check_intercept_param(env, SVM_EXIT_EXCP_BASE + intno,
@@ -106,6 +108,7 @@ void raise_interrupt2(CPUX86State *env, int intno,
     env->error_code = error_code;
     env->exception_is_int = is_int;
     env->exception_next_eip = env->eip + next_eip_addend;
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit_restore(cs, retaddr);
 }
 
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index f49fe851cd..667b1c3869 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -29,6 +29,7 @@
 #include "seg_helper.h"
 #include "access.h"
 #include "tcg-cpu.h"
+#include "qemu/plugin.h"
 
 #ifdef TARGET_X86_64
 #define SET_ESP(val, sp_mask)                                   \
@@ -1192,6 +1193,7 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                       int error_code, target_ulong next_eip, int is_hw)
 {
     CPUX86State *env = &cpu->env;
+    uint64_t last_pc = env->eip + env->segs[R_CS].base;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         if ((env->cr[0] & CR0_PE_MASK)) {
@@ -1263,6 +1265,8 @@ void do_interrupt_all(X86CPU *cpu, int intno, int is_int,
                  event_inj & ~SVM_EVTINJ_VALID);
     }
 #endif
+
+    qemu_plugin_vcpu_interrupt_cb(CPU(cpu), last_pc);
 }
 
 void do_interrupt_x86_hardirq(CPUX86State *env, int intno, int is_hw)
-- 
2.49.1


