Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168A5C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVnH-0004yK-6d; Thu, 15 May 2025 06:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnD-0004q3-Ad
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnB-0008BW-F4
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:23 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a206845eadso427422f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304779; x=1747909579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qEjjZFV3p0k5EuEPSBS07Rotsbv4ZYzcl6u4h6fFTZI=;
 b=fqOr+uGuIOjoJ4wdZQZqSBW7rFVanps8EKpvpdStwutjwbo1w9yVRYmHqpkfQ0Rfai
 vmBY0Jh5NbeKYbbnIquX68BD86dhTNUu99k5DgykV9s4XDnSiMI+MfwJ5VKEbE/bxyYd
 F7IdRyZLiQ7HZf1n3Ai84oKHPCPZHJahpm70cS3Z5yOrI3mBEPyi6v7UpbKbPaGBD3jo
 V9olb2PIo5Bayma9wVY9ElPsKbUF9wS17tI2172IuwgZ6N58XGVf4D/+/DyWmpb0La2C
 EqfVB9xH6luAIDpB5Sw5eAoDgvAB2oyOV7o0zUM+86aFEd5M4B4MOortiiL0vvmanhzf
 XwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304779; x=1747909579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qEjjZFV3p0k5EuEPSBS07Rotsbv4ZYzcl6u4h6fFTZI=;
 b=uX141nZpgJ0DaQvao5g8F363WNcd/gZJimQKN1FP+ZctGpnT9FJ4wGyUlBiMTSuM7c
 tjpqD54O5ToB7/y8KhH+eNPOWY5hV7AkFxa7fIYgvi4ee1uRlUNOXP2tw52lGXkdX5Nm
 HH0FzyZWLJtkPqK4wERN+ITr3t3771lGseC0nQ3GqyPBKXg2ID4Ynik4+fWc1A7JdrF7
 Z2V3T1XtekLOuwIpX1nZ1Ht69hAd+Nhfclwj/wfE4S7gOXKFjWWz+NR9BrSWDbi3URGK
 XdHYx+whGTs4vVj77cQ6VtsHEKa1PbtxqGBuxfzTe1G4MNFeqeFu/lVxDsMGjL6vb8wn
 HlGQ==
X-Gm-Message-State: AOJu0Yz3umJXB0qYwG3TM6RndFwWbxdIaGS0zlYmLL0OMz7qvBLLpej4
 qE3gcyDa24fDDRLAoJ5KV+X0TfLyModTmgEkDX914jGi+D2GToFP8LtmzO4H5p31+pgbgJ7afrC
 ZWmk=
X-Gm-Gg: ASbGncu2ik/GeTmh+yq0e0jjWN0majlLSgaPNpFIyjymf6RuNT+wlOcpXSVfn10Cjc0
 h8bHguDWxwGdaZPZGGD6MY681WxC4/dIs9tFVmOha9BoJJuhfAq1ZMe/qsdDb1i8B9fqWNsE15E
 sQSDYtFYg1mr2EyLtLwMs/v+WfJMMH9U2dXCQbjLpCKVIxfZ2FWO+tys7nPKRnqhDDtp6B3vGO2
 0I62tkzzy6CbDaukypacoSJEtfR+wh0o0rXJOwcKfbatId5Nfsvigb2fLC0QIlIez9cou8hUFy2
 +c2TnTSrHBZxT81gX6gWkmyCnxwPstOjrWfwFim/Rv4k1FMXja/k1r4kmA==
X-Google-Smtp-Source: AGHT+IGvlgvPw6yXbey8PPcG6LMIii6dhIY3OYCRcH1Fb26QdpbXxxftHlzhH7BhyChYR8HOAXmKaw==
X-Received: by 2002:a05:6000:2504:b0:3a0:8298:143d with SMTP id
 ffacd0b85a97d-3a3537354e5mr1505269f8f.13.1747304779548; 
 Thu, 15 May 2025 03:26:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/58] target/arm/helper: use vaddr instead of target_ulong for
 exception_pc_alignment
Date: Thu, 15 May 2025 11:25:11 +0100
Message-ID: <20250515102546.2149601-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250512180502.2395029-14-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            | 2 +-
 target/arm/tcg/tlb_helper.c    | 2 +-
 target/arm/tcg/translate-a64.c | 2 +-
 target/arm/tcg/translate.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 09075058391..95b9211c6f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -49,7 +49,7 @@ DEF_HELPER_3(exception_with_syndrome, noreturn, env, i32, i32)
 DEF_HELPER_4(exception_with_syndrome_el, noreturn, env, i32, i32, i32)
 DEF_HELPER_2(exception_bkpt_insn, noreturn, env, i32)
 DEF_HELPER_2(exception_swstep, noreturn, env, i32)
-DEF_HELPER_2(exception_pc_alignment, noreturn, env, tl)
+DEF_HELPER_2(exception_pc_alignment, noreturn, env, vaddr)
 DEF_HELPER_1(setend, void, env)
 DEF_HELPER_2(wfi, void, env, i32)
 DEF_HELPER_1(wfe, void, env)
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 5ea4d6590f2..d9e6c827d43 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -276,7 +276,7 @@ void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
 }
 
-void helper_exception_pc_alignment(CPUARMState *env, target_ulong pc)
+void helper_exception_pc_alignment(CPUARMState *env, vaddr pc)
 {
     ARMMMUFaultInfo fi = { .type = ARMFault_Alignment };
     int target_el = exception_target_el(env);
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 52cf47e775f..ac80f572a2d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10242,7 +10242,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * start of the TB.
          */
         assert(s->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         s->base.is_jmp = DISAS_NORETURN;
         s->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index e773ab72685..9962f43b1d0 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7791,7 +7791,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
          * be possible after an indirect branch, at the start of the TB.
          */
         assert(dc->base.num_insns == 1);
-        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_tl(pc));
+        gen_helper_exception_pc_alignment(tcg_env, tcg_constant_vaddr(pc));
         dc->base.is_jmp = DISAS_NORETURN;
         dc->base.pc_next = QEMU_ALIGN_UP(pc, 4);
         return;
-- 
2.43.0


