Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E857E77188
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2024 07:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRRAN-000573-5S; Sat, 28 Dec 2024 02:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRRAK-00056f-07
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 02:23:16 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tRRAH-0004Ll-B5
 for qemu-devel@nongnu.org; Sat, 28 Dec 2024 02:23:14 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3D41FA4014B;
 Sat, 28 Dec 2024 07:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CBC4CECD;
 Sat, 28 Dec 2024 07:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735370589;
 bh=qVBiZiQU7qm16mFrVGEswfPi1WlVAvEx7BPvNLCL5Gk=;
 h=Date:From:To:Subject:From;
 b=dQrF8Mk557eFEqHydqMVi7zX+M50SHOSsfk/YUGXqGziQ26Xc5+7cSGbN2qAWsz4c
 skbFmJifqEXvtNh032Nmxf+l7IghePgerI2LdJGfkpgrXJdWHcdF6hqVuJslEmrWgR
 q3OOSMPsTMMWWLGpXwWYzh591AMN/sjL2W9Vl5xR+/3MPn2EPKeJjVEXCoV8Mw143P
 4lYfmJ1OogpXFNSdnRf1S2/huBkkN4lcqCXCsLWaNGzQ79cAMX/q8xDBw0VtOI1thf
 ognygQ2See8BcjZAf6s15WAdQc9NQBR9Z1Je9P5cj1UOk+KM9rYsj7KfCN1IePy3mg
 yUSXC5Hms7Rog==
Date: Sat, 28 Dec 2024 08:23:05 +0100
From: Helge Deller <deller@kernel.org>
To: richard.henderson@linaro.org, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Subject: [PATCH] target/hppa: Speed up hppa_is_pa20()
Message-ID: <Z2-nWcZ5l6oklIZW@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a31dc32a9f..08ac1ec068 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -281,6 +281,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
     /* Create CPUs.  */
     for (unsigned int i = 0; i < smp_cpus; i++) {
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
+        cpu[i]->env.is_pa20 = object_dynamic_cast(OBJECT(cpu[i]), TYPE_HPPA64_CPU);
     }
 
     /*
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index e45ba50a59..c37a701f44 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -208,6 +208,7 @@ typedef struct CPUArchState {
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
 
+    bool is_pa20;
     uint32_t psw;            /* All psw bits except the following:  */
     uint32_t psw_xb;         /* X and B, in their normal positions */
     target_ulong psw_n;      /* boolean */
@@ -294,7 +295,7 @@ struct HPPACPUClass {
 
 static inline bool hppa_is_pa20(CPUHPPAState *env)
 {
-    return object_dynamic_cast(OBJECT(env_cpu(env)), TYPE_HPPA64_CPU) != NULL;
+    return env->is_pa20;
 }
 
 static inline int HPPA_BTLB_ENTRIES(CPUHPPAState *env)

