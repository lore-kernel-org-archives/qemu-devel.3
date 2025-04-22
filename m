Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03766C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JP4-0005II-Ki; Tue, 22 Apr 2025 15:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLr-00015P-2A
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:16 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLp-0006g6-0f
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22da3b26532so317465ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350330; x=1745955130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4XK59Un/F/cXTQA+raQ2QBk7p5qcqGVyAJ27nWp3Cg=;
 b=CnRLD6eJbhgUxz63P2OIojcfQHp1hO6SM5v5hsSbfOsxn611+uGUu1SLCOWd0C0wWL
 djaimbKIIYxQ3Lf9EwFjfqFCV1Iq7m3haTLoxWKDokL5+fIDv4pYPs+6QamzCdAc78J1
 4SApk2q2n2kXdmRuP4eMotvuhWfI3AELOCyb4z+KTNKCbPEUBr28/UKOJQSJaUmOQ9Eo
 z2RaIMB3Pn3NYTPv8PBkOGRP70Gnub7cmP+/DiF3w0OjpWS6HYzRDpyh4mbK5aLWBYys
 wAlY85EeauqRtrWWCJvqZpSaGpZ4TqyKx0VVu6pMIeC4McNHUMSH3O2tV42oWdggbGId
 w0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350330; x=1745955130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4XK59Un/F/cXTQA+raQ2QBk7p5qcqGVyAJ27nWp3Cg=;
 b=RWyQB6gshsIKC31Ycr2gDMKi76E1FetdYRyugcfDF5YwWuWtUo+9B28H6tuXCzeIEC
 OulVu5wWuFRaK9zmKhu30+zG7WeTK8Jkb8EAEAAsvv3rsf1u/LeierguamBTH/7nBYVl
 1slwTStGPtTfSLpy03vrna/6MVGiOojRJK1gITwNgpewXUcrtSYVDIrN9ZNw1wbXfVI0
 D5vUXtAf9lbIuLkjF9AOQ8al+ueHim/yAJ2f3clZwqxM9gYIYyP8wV0gQUYgyPsBN3K8
 jrcayBOixbqO6lWK5p120kFjBtci6o2JI7tnGz+5JmE8GqI8rBJAgfqP62myER2cqSfU
 rvrg==
X-Gm-Message-State: AOJu0YwPRSVKZHNqFkaKB31tDcPyHvBLo8vdxF0eDqelxw86WU31e6P0
 cTVcae19N/+lhZ8pFSPTtdaexxgDeWDRrydkBXrDZ+EK0mBx+2NXCPIj93tjd29JURjuHHDscpj
 Q
X-Gm-Gg: ASbGncvMDqOTTeHFLqKdfef0Kuc3oz1vk39tyPS7fG4MZDS+NRBgv2SgMRgiMkTfqgo
 1zmakcIXhYRmABv48E0SlRf8iF0g0YpoHykcl+viaknaK+fqh89h3c9jHrnrXnyeCTCdYIn0mPT
 nl/N5QMuOhiHJ5oCA/aAz9nr9Hlo0SMViWUV5yX0BMqsFdtzPHrdvzaTfqwvEdsDeMAd0a0ZHWQ
 lbUd1z7NBg+3brzdBxua9BXS+cZVBo0yHMkceOujuDs/tFbsxfxiHT+tawivv0p2nzT0/WsdpuR
 iLfralMScEYiX4qQFw2lcfcGIZ6ddg/sSEZ1OZyVK3TdpKll2xhxjwf8iM0Nt72pRQBaNQhGnOA
 =
X-Google-Smtp-Source: AGHT+IHe/TCmfJYmB8jQ/5VlOyvmVIE1iGL9qNsR2v8W+ZX/XSMCCB9GMr8cy2EwKju7Ifa9hKTIjw==
X-Received: by 2002:a17:902:ce01:b0:224:1943:c65 with SMTP id
 d9443c01a7336-22c535813e8mr240974565ad.14.1745350329802; 
 Tue, 22 Apr 2025 12:32:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 075/147] target/arm: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:04 -0700
Message-ID: <20250422192819.302784-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Move arm_cpu_mmu_index() within CONFIG_TCG #ifdef'ry,
convert CPUClass::mmu_index() to TCGCPUOps::mmu_index().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-5-philmd@linaro.org>
---
 target/arm/internals.h   |  1 +
 target/arm/cpu.c         | 13 +++++++------
 target/arm/tcg/cpu-v7m.c |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 28585c0755..8756c24c08 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -373,6 +373,7 @@ void arm_cpu_synchronize_from_tb(CPUState *cs, const TranslationBlock *tb);
 
 /* Our implementation of TCGCPUOps::cpu_exec_halt */
 bool arm_cpu_exec_halt(CPUState *cs);
+int arm_cpu_mmu_index(CPUState *cs, bool ifetch);
 #endif /* CONFIG_TCG */
 
 typedef enum ARMFPRounding {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01786ac787..21e8cf1400 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -121,6 +121,12 @@ void arm_restore_state_to_opc(CPUState *cs,
         env->exception.syndrome = data[2] << ARM_INSN_START_WORD2_SHIFT;
     }
 }
+
+int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return arm_env_mmu_index(cpu_env(cs));
+}
+
 #endif /* CONFIG_TCG */
 
 #ifndef CONFIG_USER_ONLY
@@ -144,11 +150,6 @@ static bool arm_cpu_has_work(CPUState *cs)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return arm_env_mmu_index(cpu_env(cs));
-}
-
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -2674,6 +2675,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .mmu_index = arm_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
@@ -2708,7 +2710,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = arm_cpu_class_by_name;
-    cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c4dd309272..1a913faa50 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -237,6 +237,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
+    .mmu_index = arm_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
-- 
2.43.0


