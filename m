Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0250ECE9D48
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSJn-0003ua-9a; Wed, 07 Jan 2026 07:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJf-0003tL-OH
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdSJX-00029f-4R
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767787617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hLlmpCqjMLS/1h4rjwz0ms3yxBNexM20/Mur+rs/jOA=;
 b=PROOzQMGMRto8EQ8zbITS/1Jozl6GHCB6XpeRUX3ZPz2OCrlQWZV/QA1X6yKaGD1QN3p/v
 KtLenpDvDmMDabvAkJunYtQszKZXucO7zGp48GiqysGaMkyUnJHFWdabQeJCD+wCKvIGxk
 x5w+12LFDA20UyunZrt6adTUklvLPVg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-UhUrx0H-MVSh5K3xwpUiGQ-1; Wed,
 07 Jan 2026 07:06:53 -0500
X-MC-Unique: UhUrx0H-MVSh5K3xwpUiGQ-1
X-Mimecast-MFC-AGG-ID: UhUrx0H-MVSh5K3xwpUiGQ_1767787612
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 495761800350; Wed,  7 Jan 2026 12:06:52 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6AFD1956053; Wed,  7 Jan 2026 12:06:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 07/14] target/s390x: Use explicit big-endian LD/ST API
Date: Wed,  7 Jan 2026 13:06:31 +0100
Message-ID: <20260107120638.56735-8-thuth@redhat.com>
In-Reply-To: <20260107120638.56735-1-thuth@redhat.com>
References: <20260107120638.56735-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The S390x architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/s390x/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251224162036.90404-3-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu-system.c      |  2 +-
 target/s390x/kvm/kvm.c         |  8 ++++----
 target/s390x/mmu_helper.c      |  3 ++-
 target/s390x/tcg/excp_helper.c | 16 ++++++++--------
 target/s390x/tcg/mem_helper.c  |  5 +++--
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index c7a6fd7e751..881171d71a2 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -63,7 +63,7 @@ static void s390_cpu_load_normal(CPUState *s)
     uint64_t spsw;
 
     if (!s390_is_pv()) {
-        spsw = ldq_phys(s->as, 0);
+        spsw = ldq_be_phys(s->as, 0);
         cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
         /*
          * Invert short psw indication, so SIE will report a specification
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index fe3bf408dda..bd6c440aefb 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1667,10 +1667,10 @@ static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
     CPUState *cs = CPU(cpu);
     PSW oldpsw, newpsw;
 
-    newpsw.mask = ldq_phys(cs->as, cpu->env.psa +
-                           offsetof(LowCore, program_new_psw));
-    newpsw.addr = ldq_phys(cs->as, cpu->env.psa +
-                           offsetof(LowCore, program_new_psw) + 8);
+    newpsw.mask = ldq_be_phys(cs->as, cpu->env.psa +
+                              offsetof(LowCore, program_new_psw));
+    newpsw.addr = ldq_be_phys(cs->as, cpu->env.psa +
+                              offsetof(LowCore, program_new_psw) + 8);
     oldpsw.mask  = run->psw_mask;
     oldpsw.addr  = run->psw_addr;
     /*
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 7063f1a905f..026502a3e40 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,7 +44,8 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
     } else {
         CPUState *cs = env_cpu(env);
         if (type != PGM_ADDRESSING) {
-            stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
+            stq_be_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code),
+                        tec);
         }
         trigger_pgm_exception(env, type);
     }
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 54f051ae9e1..d4a096f5998 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -55,8 +55,8 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     g_assert(dxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Store the DXC into the lowcore */
-    stl_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, data_exc_code), dxc);
+    stl_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, data_exc_code), dxc);
 #endif
 
     /* Store the DXC into the FPC if AFP is enabled */
@@ -72,8 +72,8 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
     g_assert(vxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
-    stl_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, data_exc_code), vxc);
+    stl_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, data_exc_code), vxc);
 #endif
 
     /* Always store the VXC into the FPC, without AFP it is undefined */
@@ -651,10 +651,10 @@ void monitor_event(CPUS390XState *env,
                    uint8_t monitor_class, uintptr_t ra)
 {
     /* Store the Monitor Code and the Monitor Class Number into the lowcore */
-    stq_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, monitor_code), monitor_code);
-    stw_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, mon_class_num), monitor_class);
+    stq_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, monitor_code), monitor_code);
+    stw_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, mon_class_num), monitor_class);
 
     tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
 }
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 9e5bd3ed07f..157ad95b23f 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -958,8 +958,9 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
 inject_exc:
 #if !defined(CONFIG_USER_ONLY)
     if (exc != PGM_ADDRESSING) {
-        stq_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, trans_exc_code),
-                 env->tlb_fill_tec);
+        stq_be_phys(env_cpu(env)->as,
+                    env->psa + offsetof(LowCore, trans_exc_code),
+                    env->tlb_fill_tec);
     }
     if (exc == PGM_PAGE_TRANS) {
         stb_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, op_access_id),
-- 
2.52.0


