Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8616E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 21:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRe2x-0002rG-4t; Sat, 28 Dec 2024 16:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRe2u-0002nG-T9
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 16:08:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRe2p-0003JW-D5
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 16:08:28 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5BAA75C04FA;
 Sat, 28 Dec 2024 21:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46961C4CECD;
 Sat, 28 Dec 2024 21:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735420092;
 bh=RjYK6xgqn4kxlkr1ONGz9XaXRiqQVE3WZ9dQakx0Ve8=;
 h=Date:From:To:Subject:From;
 b=YeU/Rtt/Yd4hKFSpGB21XMalW9D5/GITJQ0z0E3rss+41XMCPSSSmXD2DjDB7Xk0p
 4U4kxUrDluaEctNxGQueiCLyvnWksQiy77PHaHlyimsfqtMErRwe+5xqFO89rlBVkE
 1UxF/FUsGro3GtNvNQ0XI1hfz0blafo1PWDMdb7z17xxtL8y584pUdJ3depH3x2WSM
 13sulvoi1Tmy9aODDcqksdP+ot/2EOfV5UjsBuUb0/G71q+mhlr9KWm9O6kuSra/RY
 ToDk/s0VKYWk3dT55yYNsE9QvxUyQDz/dSgN0k252mnHMCizIFf1LKC6GrwM1+6+3o
 1jRO8GE2AyHMA==
Date: Sat, 28 Dec 2024 22:08:08 +0100
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: [PATCH v2] target/hppa: Speed up hppa_is_pa20()
Message-ID: <Z3BouGUFFP87PJyx@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Although the hppa_is_pa20() helper is costly due to string comparisms in
object_dynamic_cast(), it is called quite often during memory lookups
and at each start of a block of instruction translations.
Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
CPU creation and store the result in the is_pa20 of struct CPUArchState.

Signed-off-by: Helge Deller <deller@gmx.de>

v2:
- moved init to hppa_cpu_initfn() and is_pa20 to end of CPUArchState struct
  (feedback by Richard)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b908cf65c6..05de952a87 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -199,6 +199,7 @@ static void hppa_cpu_initfn(Object *obj)
     CPUHPPAState *env = &cpu->env;
 
     cs->exception_index = -1;
+    env->is_pa20 = object_dynamic_cast(obj, TYPE_HPPA64_CPU);
     cpu_hppa_loaded_fr0(env);
     cpu_hppa_put_psw(env, PSW_W);
 }
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 32a674a8b8..288ce6d98a 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -266,6 +266,8 @@ typedef struct CPUArchState {
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
+
+    bool is_pa20;
 } CPUHPPAState;
 
 /**
@@ -299,7 +301,7 @@ struct HPPACPUClass {
 
 static inline bool hppa_is_pa20(CPUHPPAState *env)
 {
-    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
+    return env->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)

