Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9546DFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 09:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIjT-0007uG-LL; Mon, 27 Apr 2026 05:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIjG-0007kZ-7V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIj8-00085t-Dr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 05:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777283884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OySEBw7OSrSUacjoEY2SBEiR4NtuaOQb8Ns6qQXAJ4=;
 b=hS3Ylii0lCwI6leF3IcJtQ5n7AXxlv1Vm/bvpyvCtV2LQ+rga8FzHblVuNeW9K9/v2BxI9
 YOALnxMhPUSBhRLBY/h9OHqgNHXteLjR9g7YGCz2SmLJwdsl/ua8hyrWFgi5LZwqw2sgDP
 gcTMNMuJKtWXiWhV3jtS7or//r3dc8o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-lioZttSUPRK_L3oTGsTd4w-1; Mon,
 27 Apr 2026 05:58:02 -0400
X-MC-Unique: lioZttSUPRK_L3oTGsTd4w-1
X-Mimecast-MFC-AGG-ID: lioZttSUPRK_L3oTGsTd4w_1777283881
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4894819560B0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:58:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F16F03000707; Mon, 27 Apr 2026 09:57:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 02/10] target/i386/tcg/sysemu: Move target specific SMM code to
 separate functions
Date: Mon, 27 Apr 2026 11:57:39 +0200
Message-ID: <20260427095747.1070244-3-thuth@redhat.com>
In-Reply-To: <20260427095747.1070244-1-thuth@redhat.com>
References: <20260427095747.1070244-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Thomas Huth <thuth@redhat.com>

This code movement will make the next patch easier to read.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260325120944.29391-2-thuth@redhat.com>
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


