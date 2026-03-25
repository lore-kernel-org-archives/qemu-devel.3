Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC56106B50C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5N3p-0002oT-69; Wed, 25 Mar 2026 08:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5N3g-0002hk-9E
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 08:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5N3d-0000rk-00
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 08:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774440596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SdGyZXxwTYuvuSTrhC9NuPS6j2R9Ll8NKs9BQm1mdDs=;
 b=VxvKfpVHCuXcLigkEhN4uuFb71ipC0ENmwXNPTuD5itQ0C7j6Rfqd4nH2dycpfOWR9LQg0
 S7E4vrCXRwjmvsV8DkVEOw/UrjXK3cIRPPfgnrkkGca+E9FK1hUsauztCbnOyb6VKIQ5wb
 JxF6heasfhfacdcyWDeSawhxb8ssUJY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-ZODADJreNj2j6q6vA7L1Aw-1; Wed,
 25 Mar 2026 08:09:54 -0400
X-MC-Unique: ZODADJreNj2j6q6vA7L1Aw-1
X-Mimecast-MFC-AGG-ID: ZODADJreNj2j6q6vA7L1Aw_1774440593
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99384195423F; Wed, 25 Mar 2026 12:09:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.139])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A78AC19560B1; Wed, 25 Mar 2026 12:09:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/2] target/i386/tcg/sysemu: Allow 32-bit SMM code to be used
 in the 64-bit binary
Date: Wed, 25 Mar 2026 13:09:44 +0100
Message-ID: <20260325120944.29391-3-thuth@redhat.com>
In-Reply-To: <20260325120944.29391-1-thuth@redhat.com>
References: <20260325120944.29391-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a preparation for the QEMU universal binary where we might want
to support both, the x86_64 and the i386 target, in one binary. Instead
of using #ifdef TARGET_X86_64 here, check the LM bit to select the 32-bit
or 64-bit code during runtime.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/i386/tcg/system/smm_helper.c | 65 +++++++++++++++++++----------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
index 3be78cd53d3..4bbe18a86fb 100644
--- a/target/i386/tcg/system/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -23,24 +23,15 @@
 #include "exec/log.h"
 #include "tcg/helper-tcg.h"
 
-
-/* SMM support */
-
-#ifdef TARGET_X86_64
-#define SMM_REVISION_ID 0x00020064
-#else
-#define SMM_REVISION_ID 0x00020000
-#endif
-
-static void sm_state_init(X86CPU *cpu)
+static void sm_state_init_64(X86CPU *cpu)
 {
+#ifdef TARGET_X86_64
     CPUX86State *env = &cpu->env;
     CPUState *cs = CPU(cpu);
     SegmentCache *dt;
     int i, offset;
     target_ulong sm_state = env->smbase + 0x8000;
 
-#ifdef TARGET_X86_64
     for (i = 0; i < 6; i++) {
         dt = &env->segs[i];
         offset = 0x7e00 + i * 16;
@@ -92,9 +83,21 @@ static void sm_state_init(X86CPU *cpu)
     x86_stq_phys(cs, sm_state + 0x7f50, env->cr[3]);
     x86_stl_phys(cs, sm_state + 0x7f58, env->cr[0]);
 
-    x86_stl_phys(cs, sm_state + 0x7efc, SMM_REVISION_ID);
+    x86_stl_phys(cs, sm_state + 0x7efc, 0x00020064);    /* SMM revision ID */
     x86_stl_phys(cs, sm_state + 0x7f00, env->smbase);
 #else
+    g_assert_not_reached();
+#endif
+}
+
+static void sm_state_init_32(X86CPU *cpu)
+{
+    CPUX86State *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    SegmentCache *dt;
+    int i, offset;
+    target_ulong sm_state = env->smbase + 0x8000;
+
     x86_stl_phys(cs, sm_state + 0x7ffc, env->cr[0]);
     x86_stl_phys(cs, sm_state + 0x7ff8, env->cr[3]);
     x86_stl_phys(cs, sm_state + 0x7ff4, cpu_compute_eflags(env));
@@ -140,9 +143,8 @@ static void sm_state_init(X86CPU *cpu)
     }
     x86_stl_phys(cs, sm_state + 0x7f14, env->cr[4]);
 
-    x86_stl_phys(cs, sm_state + 0x7efc, SMM_REVISION_ID);
+    x86_stl_phys(cs, sm_state + 0x7efc, 0x00020000);   /* SMM revision ID */
     x86_stl_phys(cs, sm_state + 0x7ef8, env->smbase);
-#endif
 }
 
 void do_smm_enter(X86CPU *cpu)
@@ -160,13 +162,15 @@ void do_smm_enter(X86CPU *cpu)
         env->hflags2 |= HF2_NMI_MASK;
     }
 
-    sm_state_init(cpu);
+    if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        sm_state_init_64(cpu);
+        cpu_load_efer(env, 0);
+    } else {
+        sm_state_init_32(cpu);
+    }
 
     /* init SMM cpu state */
 
-#ifdef TARGET_X86_64
-    cpu_load_efer(env, 0);
-#endif
     cpu_load_eflags(env, 0, ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C |
                               DF_MASK));
     env->eip = 0x00008000;
@@ -197,15 +201,16 @@ void do_smm_enter(X86CPU *cpu)
                            DESC_G_MASK | DESC_A_MASK);
 }
 
-static void rsm_load_regs(CPUX86State *env)
+static void rsm_load_regs_64(CPUX86State *env)
 {
+#ifdef TARGET_X86_64
     CPUState *cs = env_cpu(env);
     target_ulong sm_state;
     int i, offset;
     uint32_t val;
 
     sm_state = env->smbase + 0x8000;
-#ifdef TARGET_X86_64
+
     cpu_load_efer(env, x86_ldq_phys(cs, sm_state + 0x7ed0));
 
     env->gdt.base = x86_ldq_phys(cs, sm_state + 0x7e68);
@@ -260,6 +265,19 @@ static void rsm_load_regs(CPUX86State *env)
         env->smbase = x86_ldl_phys(cs, sm_state + 0x7f00);
     }
 #else
+    g_assert_not_reached();
+#endif
+}
+
+static void rsm_load_regs_32(CPUX86State *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong sm_state;
+    int i, offset;
+    uint32_t val;
+
+    sm_state = env->smbase + 0x8000;
+
     cpu_x86_update_cr0(env, x86_ldl_phys(cs, sm_state + 0x7ffc));
     cpu_x86_update_cr3(env, x86_ldl_phys(cs, sm_state + 0x7ff8));
     cpu_load_eflags(env, x86_ldl_phys(cs, sm_state + 0x7ff4),
@@ -312,14 +330,17 @@ static void rsm_load_regs(CPUX86State *env)
     if (val & 0x20000) {
         env->smbase = x86_ldl_phys(cs, sm_state + 0x7ef8);
     }
-#endif
 }
 
 void helper_rsm(CPUX86State *env)
 {
     X86CPU *cpu = env_archcpu(env);
 
-    rsm_load_regs(env);
+    if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
+        rsm_load_regs_64(env);
+    } else {
+        rsm_load_regs_32(env);
+    }
 
     if ((env->hflags2 & HF2_SMM_INSIDE_NMI_MASK) == 0) {
         env->hflags2 &= ~HF2_NMI_MASK;
-- 
2.53.0


