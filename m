Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB867106B50E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5N3n-0002mN-Cu; Wed, 25 Mar 2026 08:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5N3e-0002hW-AH
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 08:10:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5N3c-0000rY-Im
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 08:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774440593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2SkktuFniNpBHFMckJQz4idYM3YsD8QVsvB/+MsLBM=;
 b=Mbwaa65GSRkGe9uHVEaz/3KPTHSGl6mUzKILXIZwdDPK2fijkdVBoKOiWbZuiSf9hK/Yrg
 hyEAwv+Tq1pYRsbcKZKu+YCvp705d/VmFabT/sq0u5CHQOwTsD2WDwiuC2nIno0Nk9w6eS
 sgNmTdmro0litLhF5m+bh3f2nTwzF4Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-xbaq4GiuMR-0xvz9je7mow-1; Wed,
 25 Mar 2026 08:09:52 -0400
X-MC-Unique: xbaq4GiuMR-0xvz9je7mow-1
X-Mimecast-MFC-AGG-ID: xbaq4GiuMR-0xvz9je7mow_1774440591
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36DF91956094; Wed, 25 Mar 2026 12:09:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D03F19560B1; Wed, 25 Mar 2026 12:09:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 1/2] target/i386/tcg/sysemu: Move target specific SMM code to
 separate functions
Date: Wed, 25 Mar 2026 13:09:43 +0100
Message-ID: <20260325120944.29391-2-thuth@redhat.com>
In-Reply-To: <20260325120944.29391-1-thuth@redhat.com>
References: <20260325120944.29391-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

This code movement will make the next patch easier to read.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/tcg/system/smm_helper.c | 47 ++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
index fb028a8272f..3be78cd53d3 100644
--- a/target/i386/tcg/system/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -32,26 +32,13 @@
 #define SMM_REVISION_ID 0x00020000
 #endif
 
-void do_smm_enter(X86CPU *cpu)
+static void sm_state_init(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     CPUState *cs = CPU(cpu);
-    target_ulong sm_state;
     SegmentCache *dt;
     int i, offset;
-
-    qemu_log_mask(CPU_LOG_INT, "SMM: enter\n");
-    log_cpu_state_mask(CPU_LOG_INT, CPU(cpu), CPU_DUMP_CCOP);
-
-    env->msr_smi_count++;
-    env->hflags |= HF_SMM_MASK;
-    if (env->hflags2 & HF2_NMI_MASK) {
-        env->hflags2 |= HF2_SMM_INSIDE_NMI_MASK;
-    } else {
-        env->hflags2 |= HF2_NMI_MASK;
-    }
-
-    sm_state = env->smbase + 0x8000;
+    target_ulong sm_state = env->smbase + 0x8000;
 
 #ifdef TARGET_X86_64
     for (i = 0; i < 6; i++) {
@@ -156,6 +143,25 @@ void do_smm_enter(X86CPU *cpu)
     x86_stl_phys(cs, sm_state + 0x7efc, SMM_REVISION_ID);
     x86_stl_phys(cs, sm_state + 0x7ef8, env->smbase);
 #endif
+}
+
+void do_smm_enter(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+
+    qemu_log_mask(CPU_LOG_INT, "SMM: enter\n");
+    log_cpu_state_mask(CPU_LOG_INT, CPU(cpu), CPU_DUMP_CCOP);
+
+    env->msr_smi_count++;
+    env->hflags |= HF_SMM_MASK;
+    if (env->hflags2 & HF2_NMI_MASK) {
+        env->hflags2 |= HF2_SMM_INSIDE_NMI_MASK;
+    } else {
+        env->hflags2 |= HF2_NMI_MASK;
+    }
+
+    sm_state_init(cpu);
+
     /* init SMM cpu state */
 
 #ifdef TARGET_X86_64
@@ -191,9 +197,8 @@ void do_smm_enter(X86CPU *cpu)
                            DESC_G_MASK | DESC_A_MASK);
 }
 
-void helper_rsm(CPUX86State *env)
+static void rsm_load_regs(CPUX86State *env)
 {
-    X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     target_ulong sm_state;
     int i, offset;
@@ -308,6 +313,14 @@ void helper_rsm(CPUX86State *env)
         env->smbase = x86_ldl_phys(cs, sm_state + 0x7ef8);
     }
 #endif
+}
+
+void helper_rsm(CPUX86State *env)
+{
+    X86CPU *cpu = env_archcpu(env);
+
+    rsm_load_regs(env);
+
     if ((env->hflags2 & HF2_SMM_INSIDE_NMI_MASK) == 0) {
         env->hflags2 &= ~HF2_NMI_MASK;
     }
-- 
2.53.0


