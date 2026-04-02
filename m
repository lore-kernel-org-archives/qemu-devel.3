Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A606D39406
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8EiP-0006u8-IW; Thu, 02 Apr 2026 05:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiO-0006sm-9o
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w8EiM-0008QG-9X
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775123509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2SkktuFniNpBHFMckJQz4idYM3YsD8QVsvB/+MsLBM=;
 b=BiPIvhiTDAyy8+l5Nh4w6ZsvXcKJivX9voraPVvdAyL6B5hBeceh4P1KZCC5wAd9H6UGpx
 nzXAJ30qGskh9+mQS5nyRjtMs3275BNXk/3ep9Ia/7Uc81vATirBkKZiBiTlh4XMhivlR2
 6ONdnIXcFOcX1i/9ZEz+dHASwFAa+W4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-NVRJ0cGjMjqJTSZzuaJv-Q-1; Thu,
 02 Apr 2026 05:51:46 -0400
X-MC-Unique: NVRJ0cGjMjqJTSZzuaJv-Q-1
X-Mimecast-MFC-AGG-ID: NVRJ0cGjMjqJTSZzuaJv-Q_1775123505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE15A180044D; Thu,  2 Apr 2026 09:51:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.44])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63C391978D41; Thu,  2 Apr 2026 09:51:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 01/10] target/i386/tcg/sysemu: Move target specific SMM code
 to separate functions
Date: Thu,  2 Apr 2026 11:51:23 +0200
Message-ID: <20260402095132.29245-2-thuth@redhat.com>
In-Reply-To: <20260402095132.29245-1-thuth@redhat.com>
References: <20260402095132.29245-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


