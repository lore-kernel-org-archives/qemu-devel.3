Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B69DC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 16:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgR6Q-0000rf-WE; Fri, 07 Feb 2025 11:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6I-0000pk-Gg
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tgR6F-00076t-So
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 11:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738945263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N03awIb2eI1qk2yMXI8q9zCFYR3RK4VcbdhuUDRDRwg=;
 b=bJs4VvKEc1no3C8jODTCvTd/uaiZUFmlg43Nplmifqb2uH6MatnNsyRNEt2hQvk3DIcIWQ
 8HXi+V+TUUp/FmZlTOoq3RQjD1WdrKqdtEUgwi5fbRBhFEMMUQlmYpPqRc3/PT1+x4JhM0
 Hs2aU51Sqdl4WzV2IrW/jelvf5EbT8I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-BbEn1iR1NCSybegUAf3Mdw-1; Fri,
 07 Feb 2025 11:20:59 -0500
X-MC-Unique: BbEn1iR1NCSybegUAf3Mdw-1
X-Mimecast-MFC-AGG-ID: BbEn1iR1NCSybegUAf3Mdw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 693AB1956094; Fri,  7 Feb 2025 16:20:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD49D1800878; Fri,  7 Feb 2025 16:20:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v2 01/10] bsd-user: drop not longer used target_reset_cpu()
Date: Fri,  7 Feb 2025 17:20:39 +0100
Message-ID: <20250207162048.1890669-2-imammedo@redhat.com>
In-Reply-To: <20250207162048.1890669-1-imammedo@redhat.com>
References: <20250207162048.1890669-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

target_reset_cpu() static inlines have no user,
remove them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Warner Losh <imp@bsdimp.com>
CC: Kyle Evans <kevans@freebsd.org>
---
 bsd-user/aarch64/target_arch_cpu.h | 5 -----
 bsd-user/arm/target_arch_cpu.h     | 4 ----
 bsd-user/i386/target_arch_cpu.h    | 5 -----
 bsd-user/riscv/target_arch_cpu.h   | 4 ----
 bsd-user/x86_64/target_arch_cpu.h  | 5 -----
 5 files changed, 23 deletions(-)

diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index 87fbf6d677..46a448e93f 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -181,9 +181,4 @@ static inline void target_cpu_clone_regs(CPUARMState *env, target_ulong newsp)
     pstate_write(env, 0);
 }
 
-static inline void target_cpu_reset(CPUArchState *env)
-{
-}
-
-
 #endif /* TARGET_ARCH_CPU_H */
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
index bc2eaa0bf4..b9583b0f92 100644
--- a/bsd-user/arm/target_arch_cpu.h
+++ b/bsd-user/arm/target_arch_cpu.h
@@ -206,8 +206,4 @@ static inline void target_cpu_clone_regs(CPUARMState *env, target_ulong newsp)
     env->regs[0] = 0;
 }
 
-static inline void target_cpu_reset(CPUArchState *env)
-{
-}
-
 #endif /* TARGET_ARCH_CPU_H */
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index 5d4c931dec..371e702799 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -194,9 +194,4 @@ static inline void target_cpu_clone_regs(CPUX86State *env, target_ulong newsp)
     env->regs[R_EAX] = 0;
 }
 
-static inline void target_cpu_reset(CPUArchState *env)
-{
-    cpu_reset(env_cpu(env));
-}
-
 #endif /* TARGET_ARCH_CPU_H */
diff --git a/bsd-user/riscv/target_arch_cpu.h b/bsd-user/riscv/target_arch_cpu.h
index ef92f00480..d3cc5adbf4 100644
--- a/bsd-user/riscv/target_arch_cpu.h
+++ b/bsd-user/riscv/target_arch_cpu.h
@@ -141,8 +141,4 @@ static inline void target_cpu_clone_regs(CPURISCVState *env, target_ulong newsp)
     env->gpr[xT0] = 0;
 }
 
-static inline void target_cpu_reset(CPUArchState *env)
-{
-}
-
 #endif /* TARGET_ARCH_CPU_H */
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
index f82042e30a..8ec5c65fab 100644
--- a/bsd-user/x86_64/target_arch_cpu.h
+++ b/bsd-user/x86_64/target_arch_cpu.h
@@ -169,9 +169,4 @@ static inline void target_cpu_clone_regs(CPUX86State *env, target_ulong newsp)
     env->regs[R_EAX] = 0;
 }
 
-static inline void target_cpu_reset(CPUArchState *env)
-{
-    cpu_reset(env_cpu(env));
-}
-
 #endif /* TARGET_ARCH_CPU_H */
-- 
2.43.0


