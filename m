Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CBCE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 23:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tS2vH-0003sQ-E5; Sun, 29 Dec 2024 18:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS2vC-0003rn-CU
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 18:42:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tS2vA-0001fR-O0
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 18:42:10 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 43A845C110C;
 Sun, 29 Dec 2024 23:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766C8C4CED7;
 Sun, 29 Dec 2024 23:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735515720;
 bh=ZFuZeCs3Orq8OXoUrzXYPv+DEcb9GFUxfEBGQdRF4wg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vLBm77XAN+fsXPEAFbF2pI/KdwzxOkt8QhDCIyVUfuSlcROQu9BAr4kK2abKbkG7a
 guAO/FbKx+F2nZ2i98Qpwzg1sa8QO8SPdR2jeVfHay2aKUIQIlSBIEd96xwTEYfGux
 He0KJjdHcd4Q7H8lnMWaL8+Z6tbKFBFs407PLxKkTS+FOut+wO224JEZHSKmZhcDta
 820UEzSVYHzM+/qsbXvs6xRP16SMFes/wrJBWCLakvFBlSXvxAoVpCRwZZRwV4rKkC
 F2yg5Xonkh8mb+EW/YHtwHcj/1IKDXvpoO7p5dNR9JTVyza7V9yKqxKvvZri9taU6M
 tSrBlGkdzYEXw==
From: deller@kernel.org
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] target/hppa: Speed up hppa_is_pa20()
Date: Mon, 30 Dec 2024 00:41:54 +0100
Message-ID: <20241229234154.32250-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241229234154.32250-1-deller@kernel.org>
References: <20241229234154.32250-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -92
X-Spam_score: -9.3
X-Spam_bar: ---------
X-Spam_report: (-9.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.187,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Although the hppa_is_pa20() helper is costly due to string comparisons
in object_dynamic_cast(), it is called quite often during memory lookups
and at each start of a block of instruction translations.
Speed hppa_is_pa20() up by calling object_dynamic_cast() only once at
CPU creation and store the result in the is_pa20 of struct CPUArchState.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

v3:
- use !!object_dynamic_cast()
- typo fix in commit message
  (feedback by Philippe Mathieu-Daudé)

v2:
- moved init to hppa_cpu_initfn() and is_pa20 to end of CPUArchState struct
  (feedback by Richard Henderson)
---
 target/hppa/cpu.c | 1 +
 target/hppa/cpu.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index cb1b5191a4..64a762b410 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -197,6 +197,7 @@ static void hppa_cpu_initfn(Object *obj)
     HPPACPU *cpu = HPPA_CPU(obj);
     CPUHPPAState *env = &cpu->env;
 
+    env->is_pa20 = !!object_dynamic_cast(obj, TYPE_HPPA64_CPU);
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
-- 
2.47.0


