Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9225CC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8NP-0007fT-96; Wed, 29 Jan 2025 08:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NC-0007Zb-41
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:44:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NA-00088x-Ld
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkvyWq9gMdhHkrlDqEitBjOsFmj5r+wCqGb0Udd7APQ=;
 b=QQD6kvfv4V5bPEGUHDWF1HObyzlEVlFdqUKLFSGKYPAJYHKgRnx59FTAUynDApNywxooG6
 nyzKXPKWQazX4tYSv7nivqZ43SAa1Qh4pBpXcT8xKKDB2yppeNPz+0diNm29fDoqpWrJrf
 9RWmf0jt23nLFSgaSMb1f4tY2hhjJu0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-Zax800zAPbq89YtUxSvS9w-1; Wed,
 29 Jan 2025 08:44:49 -0500
X-MC-Unique: Zax800zAPbq89YtUxSvS9w-1
X-Mimecast-MFC-AGG-ID: Zax800zAPbq89YtUxSvS9w
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAF2918009F5; Wed, 29 Jan 2025 13:44:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3EBB1800961; Wed, 29 Jan 2025 13:44:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu
Subject: [PATCH 1/6] bsd-user: drop not longer used target_reset_cpu()
Date: Wed, 29 Jan 2025 14:44:31 +0100
Message-ID: <20250129134436.1240740-2-imammedo@redhat.com>
In-Reply-To: <20250129134436.1240740-1-imammedo@redhat.com>
References: <20250129134436.1240740-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

target_reset_cpu() static inlines have no user,
remove them.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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


