Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E041606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=bzVOLprg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Jv-0006vL-JE; Mon, 16 Nov 2026 15:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Jl-0006D2-Fv; Mon, 16 Nov 2026 15:28:45 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Jj-0001Xk-2H; Mon, 16 Nov 2026 15:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860764; bh=eDNxkS+dA+OK+lwCj+mOVXnuoXLtsmNMw6UQXxiovGw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bzVOLprgzUaJvmDTWsc3RX4N6mKQZw5x+V4LhuBDLhGGOEjvTkszmuAcTsYMbrRyl
 9WXLeQInEb6V64fzc4jZpmi5gbiotxKDfmIpz/1tNSCO8/yLaWpCZgdeh2ey42/MNU
 cgCqvpnlKsYX45dr5KpJwD36KLxoU4z/0QUqHsEcw16xfVoefn2FUst4kwTqPQoa3D
 0BdEpRGWELZ20s2pQEKXeQGO0g7Btz1yVbiWHryA5sXW9IAq/XF7SJ9hLdSM7QManw
 Td5yzGl7D5sYrWVelucrEm71SSAjdSkhBMdgxkC96efVif3VhprJg5g8wqD/OmA1H4
 f2jvoz5h8VgJQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58ACD1E71B3;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5631F45FBDF;
 Mon, 16 Nov 2026 23:26:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C1114B8E82; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Lorand Marton <lorandmarton.dev@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 30/63] target/arm: hold bql when SEV sets the
 event_register
Date: Mon, 16 Nov 2026 23:25:09 +0300
Message-ID: <20261116202554.535325-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Bennée <alex.bennee@linaro.org>

There is a race in qemu_process_cpu_events and sleeping on halt_cond
where we can miss the setting of the event_register which would cause
arm_cpu_has_work to report we shouldn't sleep. As by definition the
bql has to be held when we go to sleep against halt_cond guard the
kicking of the cpus by the SEV helper with the BQL to ensure things
are properly serialised.

The other places that set event_register are fine as they are either
in the same vCPU context or are already serialised by the BQL.

Also use qemu_cond_wait_bql like the other halt_cond users.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4660
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4670
Cc: qemu-stable@nongnu.org
Fixes: d238858bff60 ("target/arm: Implement WFE, SEV and SEVONPEND for Cortex-M")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Lorand Marton <lorandmarton.dev@gmail.com>
Message-id: 20261030141046.2710206-2-alex.bennee@linaro.org
Message-ID: <20261029161310.2065290-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 8def1f30d5d4429abe163173debd06f160198350)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/cpus.c b/system/cpus.c
index 97e5a5edee2..04005ae5595 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -471,7 +471,7 @@ void qemu_process_cpu_events(CPUState *cpu)
             slept = true;
             qemu_plugin_vcpu_idle_cb(cpu);
         }
-        qemu_cond_wait(cpu->halt_cond, &bql);
+        qemu_cond_wait_bql(cpu->halt_cond);
     }
     if (slept) {
         qemu_plugin_vcpu_resume_cb(cpu);
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 56d79836209..38ba515bef4 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -475,7 +475,10 @@ void HELPER(wfit)(CPUARMState *env, uint32_t rd)
 
 void HELPER(sev)(CPUARMState *env)
 {
-    CPUState *cs = env_cpu(env);
+    CPUState *cs;
+
+    BQL_LOCK_GUARD();
+
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
         target_cpu->env.event_register = true;
-- 
2.47.3


