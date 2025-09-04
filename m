Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04178CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 20:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuGs7-0003VJ-QU; Thu, 04 Sep 2025 16:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGs2-0003U9-OL
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:50 -0400
Received: from mailgate01.uberspace.is ([95.143.172.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uuGrs-0000jA-NX
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 16:47:50 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id 0B49360C0E
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 22:47:22 +0200 (CEST)
Received: (qmail 32639 invoked by uid 990); 4 Sep 2025 20:47:21 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 04 Sep 2025 22:47:21 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 09/25] target/i386: call plugin trap callbacks
Date: Thu,  4 Sep 2025 22:46:46 +0200
Message-ID: <b6c718c34d0456f765ee2f6e7fa92f96eea7e260.1757018626.git.neither@nut.email>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1757018626.git.neither@nut.email>
References: <cover.1757018626.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.999953) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.599953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=MaaCC1NnIoEHqjPuoSE9U+Utg1hySXIwLbGxGZHEZrM=;
 b=bvA/QUl7Tu2r5XKDlQ4PbUbx88gu0jteGou7bxHH1lweutUra3WoaJuhByepqlsRMLDsRfd12E
 nMDydLFXsKH0qtd3KZoGpaJJnMDjRTjmOyK1KYUEtxmhxpMOfDsgjzuFNzPuB6frwdGJqGtKuG/V
 XclODK0J0pzGWaq92VOTj68pzIzU+cGVs4TPEuculuVPoXU/AeMDSTtsH9fvz4QDYXinFNsjoOEy
 yQovzYPMg7r6X44joHJx1uOESW6ZNTPWMRfFwlXJpPpHMmy/mgJuQGQAzUlUxoxaB6k8iU1dozOT
 Kxe6H7Mhl3JVCz/JbnQq9gBqMHR6rgC9/8xdIys3CspzbHPHJv2hfq9QhnnP1diQPUTv6eBO39EO
 dAmSfePjPU6uWrjxQhywwUM7CV1QyMjgri5yXfB5coaqa+ZKzfI117dVLosNFsf6HlhbH/6w4ogP
 ZEdw2nFY3WHJUPTQhGfJOPg68taNLtHYRfzCnOiY38oofJacZedcrTmJn36IriCVwcRR9FrnX+81
 FW36n7ZioH2FoiOboIc1ZoO2VeUhqyGUREuQHycfjs2nrKBH4XUPfUJ50wsl86pF6ZciHM1h21PF
 gRICrZerJ35BMzQ9gKGoLSfpgjZ4QYsPmhb5tMdLbpGRIkE+XnvwQ6T7+v+EK1ep3wFBuE8GvS+Y
 8=
Received-SPF: pass client-ip=95.143.172.20; envelope-from=neither@nut.email;
 helo=mailgate01.uberspace.is
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 071f3fbd83..db635aceee 100644
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


