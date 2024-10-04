Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC8ACF34D7
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 00:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swWJ2-0004Mi-Mv; Thu, 03 Oct 2024 20:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swWIz-0004Lo-J7
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 20:36:25 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1swWIx-0005tv-Hb
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 20:36:25 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2e1bfa9ddb3so1076183a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 17:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728002181; x=1728606981;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/MFfB4q8izso0/HXm1SZlNmo7GAp+rQZtUeNXDZQm+Y=;
 b=jsVTImU+fKMuFIO8Mdslgt+UEF3C18js0onE0LLhpLleF2XniE1TMEVg1LflFl+Aca
 WfCv1upg6xUS+hu8ufZrm4M/lx0tD/kdjbwEGqJGBFLZOL3kjtRnuJVpM/gZcPiuVGzW
 P6BEEiLZ8FFXj/ufYs59uDwETfbCwMsxQjrKiL8Vwm2QFXCkxPQGzhVE8P2YjH4RTQz8
 ZW8vgaJaE8pqqBsKofg+5h60FC8mJhKoLejRebolL7JlSr+rj+WspdVIRJ0+dC7F9SD3
 ctyCZRR8VT0/6xOIzijWflug+ULV0EDaJudTMAVRuhrps7Cl2zqrsCPib3Z3YmbE2gFQ
 UKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728002181; x=1728606981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MFfB4q8izso0/HXm1SZlNmo7GAp+rQZtUeNXDZQm+Y=;
 b=Km116udirTjLn/fiVXmDdRU6FP1A2UnIvNJuL6ktH9b17ntdYmDN+GqahYsYKZWEet
 BN0klJ0NVBjdzUrXPQOMzVwmbkzuF03ijOKQYrr0Ml5ufA9UlnDE5zzQfZWqPu56fnHe
 wVCubvtDKbE5MMbPzlIqTSx/8RYkOfaJL/mZ5dhGoj+jJvF9Q28bibXCVlr4J5AsSMkE
 NuS3RMcA7bZFbbR+xq6LqTnedf2pH96G8Ot7QDmyS57Hco6odlJBtAtaFm7cEbCvO9HH
 zdBgIbAyYdqRvdpHYj2ydw1nB8ShJwzFVOw+IB4lUsTRtd74evpxKKIPBaoJI/au0ZFK
 6YSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXS79EdBy9nhvT28JRFkgSgPGCX2S5OjehatevLrPD+675p1fZ0dT1R595ORUJthfq9OOwIDX5xIn73@nongnu.org
X-Gm-Message-State: AOJu0YxnQxjrx38GqIlEePgb20WAeH2FUKn3s/fXaspV03319xGPQj3X
 bvG5tvcGxcKuMr2MrZ1uMHBgoytvNavWfiK9Mi6MfMHP3rHVRW7ICWvPJb0kOLY=
X-Google-Smtp-Source: AGHT+IFzlRbujHTH/uM+D0RWrqHnxAj60ytKlOgOg8yqjM3UgQu7KIS62LEakQimR8qKIMDfIvYUlw==
X-Received: by 2002:a17:90b:b83:b0:2e0:8719:5efa with SMTP id
 98e67ed59e1d1-2e1e621e79bmr1105313a91.13.1728002181567; 
 Thu, 03 Oct 2024 17:36:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e1e86657casm151245a91.43.2024.10.03.17.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 17:36:21 -0700 (PDT)
Date: Thu, 3 Oct 2024 17:36:19 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com
Subject: Re: [PATCH v15 14/21] target/riscv: disallow probe accesses to
 shadow stack
Message-ID: <Zv84gz6RPTuIkAWw@debug.ba.rivosinc.com>
References: <20241003183342.679249-1-debug@rivosinc.com>
 <20241003183342.679249-15-debug@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241003183342.679249-15-debug@rivosinc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 03, 2024 at 11:33:35AM -0700, Deepak Gupta wrote:
>`check_zicbom_access` (`cbo.clean/flush/inval`) may probe shadow stack
>memory and must always raise store/AMO access fault because it has store
>semantics.
>
>For non-shadow stack memory even though `cbo.clean/flush/inval` have
>store semantics, it will not fault if read is allowed (probably to follow
>`clflush` on x86). Although if read is not allowed, eventually
>`probe_write` will do store page (or access) fault (if permissions don't
>allow it).
>
>cbo operations on shadow stack memory must always raise store access fault.
>Thus extending `get_physical_address` to recieve `probe` parameter as well.
>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>---
> target/riscv/cpu_helper.c | 22 +++++++++++++---------
> 1 file changed, 13 insertions(+), 9 deletions(-)
>
>diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>index 5580f5f3f3..ab46f694b5 100644
>--- a/target/riscv/cpu_helper.c
>+++ b/target/riscv/cpu_helper.c
>@@ -884,7 +884,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>                                 target_ulong *fault_pte_addr,
>                                 int access_type, int mmu_idx,
>                                 bool first_stage, bool two_stage,
>-                                bool is_debug)
>+                                bool is_debug, bool is_probe)
> {
>     /*
>      * NOTE: the env->pc value visible here will not be
>@@ -1030,7 +1030,7 @@ restart:
>             int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
>                                                  base, NULL, MMU_DATA_LOAD,
>                                                  MMUIdx_U, false, true,
>-                                                 is_debug);
>+                                                 is_debug, false);
>
>             if (vbase_ret != TRANSLATE_SUCCESS) {
>                 if (fault_pte_addr) {
>@@ -1117,8 +1117,11 @@ restart:
>         /* if bcfi enabled, PTE_W is not reserved and shadow stack page */
>         if (cpu_get_bcfien(env) && first_stage) {
>             sstack_page = true;
>-            /* if ss index, read and write allowed. else only read allowed */
>-            rwx = is_sstack_idx ? PTE_R | PTE_W : PTE_R;
>+            /*
>+             * if ss index, read and write allowed. else if not a probe
>+             * then only read allowed
>+             */
>+            rwx = is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? rwx :  PTE_R);

hmm... there is a bug here. Above would allow writes to go through if probed.

It should be 


               rwx = is_sstack_idx ? (PTE_R | PTE_W) : (is_probe ? 0 :  PTE_R);

I'll fix it in next version.
Still need higher level feedback on patch that if it's okay to extend
`get_physical_address` to recieve `probe` parameter.


>             break;
>         }
>         return TRANSLATE_FAIL;
>@@ -1327,13 +1330,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>     int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
>
>     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
>-                             true, env->virt_enabled, true)) {
>+                             true, env->virt_enabled, true, false)) {
>         return -1;
>     }
>
>     if (env->virt_enabled) {
>         if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
>-                                 0, MMUIdx_U, false, true, true)) {
>+                                 0, MMUIdx_U, false, true, true, false)) {
>             return -1;
>         }
>     }
>@@ -1447,7 +1450,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>         /* Two stage lookup */
>         ret = get_physical_address(env, &pa, &prot, address,
>                                    &env->guest_phys_fault_addr, access_type,
>-                                   mmu_idx, true, true, false);
>+                                   mmu_idx, true, true, false, probe);
>
>         /*
>          * A G-stage exception may be triggered during two state lookup.
>@@ -1470,7 +1473,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>
>             ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
>                                        access_type, MMUIdx_U, false, true,
>-                                       false);
>+                                       false, probe);
>
>             qemu_log_mask(CPU_LOG_MMU,
>                           "%s 2nd-stage address=%" VADDR_PRIx
>@@ -1507,7 +1510,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>     } else {
>         /* Single stage lookup */
>         ret = get_physical_address(env, &pa, &prot, address, NULL,
>-                                   access_type, mmu_idx, true, false, false);
>+                                   access_type, mmu_idx, true, false, false,
>+                                   probe);
>
>         qemu_log_mask(CPU_LOG_MMU,
>                       "%s address=%" VADDR_PRIx " ret %d physical "
>-- 
>2.45.0
>

