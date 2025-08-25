Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E78CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 10:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqUif-0004yY-If; Mon, 25 Aug 2025 06:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUiV-0004w3-Uy
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:46:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqUiK-00085k-SJ
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 06:46:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b00f23eso23875275e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756118769; x=1756723569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDzSIhe55Fz7N6xVWKs9w4Vwa72FIocHi6Kb3R0zpxk=;
 b=ZQ5naKg9zrtoze4GHzvkshpsos7eKw83QHaRsMgapR/v9uAdbF1vh3SXAo07LUtzq+
 mEcuDjNT9vVAtLYJN0ohNDB+gDW8+J9FUZScjl9DXWGkffJaNSW8AC3SB7JtOGXDVCg9
 EnJ36tjbt5n7TP9MsDhzEz5W7LRckdBeXZOPLaJv/bEbWkpWi1ux33kEyaxXd+MwLwhQ
 YacnXE/lCb5YB0XKBjLuYL9JJaDUs+RV6fr3mp2eAPeVBOgiOvjcCcXKZr11PFojz6vY
 w1EfPyp+dCgTLiIcGwlAQfo4bHahCyHhFApT9uPl/YoUNwi9rOwty02Qq3g74LA/VmCm
 N2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756118769; x=1756723569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDzSIhe55Fz7N6xVWKs9w4Vwa72FIocHi6Kb3R0zpxk=;
 b=tWcWSRd8npq7rpAxpYvd4XU+GsPJT5kwcjx5QkxUulzScevmqTTP0hDdx4FHFEfwO3
 9xf7n80l6VT+vYwmqYX+OMtKj0FZNVYuK6fzzoba+VVkvwNplI5EAhns07ivCd4zF2t2
 z+aE/o6xr1tpoJE94+SkpF5Ufldn/MRjzJ+ULo//4WCEj3fZMJ1qj/8JqDXIx8CwxKxF
 txjF+r5knMn+UWgSeSkflvB1tc5UVGRu0SMZ95WQdmzVuFoboLxUM3HiJmN2ZIhkB5CJ
 PjjII/ja5GKQ1EUCeMEDmelFchC+rT2IkJ3LfrfnWBmZoQJsqx2XN0aVeCExHmYNfqa6
 jCxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0wXUfAzDGwEw1BIAuKCaP4h/szPheZTjqkLS/tz4evFebwYSyFHjQcWVcOnVNWM6LFhjmipnBvSud@nongnu.org
X-Gm-Message-State: AOJu0YwXlM78Y2QlZlb6C3wS6cFWvhA/WT4OptuxaR15dlBs3iCq3Di7
 lS3Ay7ZpymNzl4dfflCVDnD8LBym15USpHqTRVcu5AxXRnRU63PYSvgIqavu5fQg/+o=
X-Gm-Gg: ASbGncshgcKnR/FtYFcWNyHio3rzizpgDNYupLaiQqDH3mCeWBufhG/NE76gLzFEJu5
 u0ycQDYK8LM1I2NqOwqfRnKwJumYrB+o/ez+cikqVkQN3Uq0MpjLlguX1+bjceBwr4wI0Zn85DW
 R6B9gSWmgeseL20k5FR4pooUAfQ2heysQCO+1PHyxgAJt9ZuBN/2GVulAI+Wrh2pzhvn3Vk0xtI
 G3jvoAAp9aq+r865qojDITBLwXZugoJvyKc5PYL2qwWWd40EHQ7ESyq+1uLrpBtgs88W/JJsJY9
 M6md61msHWhjbfwhttrOUQuzUK1DvhO+bN4NTKgr1rqGqIbsdN2LohYRnR6QZZFaA2NscE6I/tB
 A/qExP5qC8rubwyt4ph/tgowg9yixYU4S8LqAQo6lHFk4QEhUt/n1aoiy2CgCX41OG/qYK4BQ3E
 Mf
X-Google-Smtp-Source: AGHT+IGgVB4w3qbfsI7YCj54Xh0HWSAA0kZmpIKBZIhtzDqrmkIiJkeoaT1bK+cvYjeaOaw/Bs4RGg==
X-Received: by 2002:a05:600c:19cd:b0:458:be62:dcd3 with SMTP id
 5b1f17b1804b1-45b517c2fc0mr123865575e9.17.1756118769428; 
 Mon, 25 Aug 2025 03:46:09 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b57444b3asm106348125e9.4.2025.08.25.03.46.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 03:46:08 -0700 (PDT)
Message-ID: <c16db8b9-9b73-49c4-8233-370c1b46a382@linaro.org>
Date: Mon, 25 Aug 2025 12:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] kvm: i386: irqchip: take BQL only if there is an
 interrupt
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 qemu-ppc <qemu-ppc@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Peter Collingbourne <pcc@google.com>, Alexander Graf <agraf@csgraf.de>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Sergio Lopez <slp@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-8-imammedo@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250814160600.2327672-8-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 14/8/25 18:05, Igor Mammedov wrote:
> when kernel-irqchip=split is used, QEMU still hits BQL
> contention issue when reading ACPI PM/HPET timers
> (despite of timer[s] access being lock-less).
> 
> So Windows with more than 255 cpus is still not able to
> boot (since it requires iommu -> split irqchip).
> 
> Problematic path is in kvm_arch_pre_run() where BQL is taken
> unconditionally when split irqchip is in use.
> 
> There are a few parts that BQL protects there:
>    1. interrupt check and injecting
> 
>      however we do not take BQL when checking for pending
>      interrupt (even within the same function), so the patch
>      takes the same approach for cpu->interrupt_request checks
>      and takes BQL only if there is a job to do.
> 
>    2. request_interrupt_window access
>        CPUState::kvm_run::request_interrupt_window doesn't need BQL
>        as it's accessed by its own vCPU thread.
> 
>    3. cr8/cpu_get_apic_tpr access
>        the same (as #2) applies to CPUState::kvm_run::cr8,
>        and APIC registers are also cached/synced (get/put) within
>        the vCPU thread it belongs to.
> 
> Taking BQL only when is necessary, eleminates BQL bottleneck on
> IO/MMIO only exit path, improoving latency by 80% on HPET micro
> benchmark.
> 
> This lets Windows to boot succesfully (in case hv-time isn't used)
> when more than 255 vCPUs are in use.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
> v3:
>    * drop net needed pair of () in cpu->interrupt_request & CPU_INTERRUPT_HARD
>      check
>    * Paolo Bonzini <pbonzini@redhat.com>
>       * don't take BQL when setting exit_request, use qatomic_set() instead
>       * after above simplification take/release BQL unconditionally
>       * drop smp_mb() after run->cr8/run->request_interrupt_window update
> ---
>   target/i386/kvm/kvm.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)


>       /* Force the VCPU out of its inner loop to process any INIT requests
>        * or (for userspace APIC, but it is cheap to combine the checks here)
> @@ -5489,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>       if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
>           if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
>               !(env->hflags & HF_SMM_MASK)) {
> -            cpu->exit_request = 1;
> +            qatomic_set(&cpu->exit_request, 1);
>           }
>           if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> -            cpu->exit_request = 1;
> +            qatomic_set(&cpu->exit_request, 1);
>           }
>       }

Interesting. IMHO to avoid future similar problems, we should declare
CPUState::exit_request a "private" field and access it via a helper,
where atomicity is enforced.

The only non-accelerator use is in PPC sPAPR:

hw/ppc/spapr_hcall.c:512:        cs->exit_request = 1;
hw/ppc/spapr_hcall.c:534:    cs->exit_request = 1;
hw/ppc/spapr_hcall.c:627:    cs->exit_request = 1;

FYI last week we noticed a similar problem with CPUState::thread_kicked
when using HVF and I'll post in a few days a series containing this
change:

-- >8 --
diff --git a/system/cpus.c b/system/cpus.c
index 26fb3bd69c3..39daf85bae7 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -464,10 +464,10 @@ void qemu_wait_io_event(CPUState *cpu)

  void cpus_kick_thread(CPUState *cpu)
  {
-    if (cpu->thread_kicked) {
+    if (qatomic_read(&cpu->thread_kicked)) {
          return;
      }
-    cpu->thread_kicked = true;
+    qatomic_set(&cpu->thread_kicked, true);

---

It only affects HVF because this is the single access to thread_kicked
out of accelerator code:

$ git grep -w thread_kicked
include/hw/core/cpu.h:484:    bool thread_kicked;
system/cpus.c:449:    qatomic_set_mb(&cpu->thread_kicked, false);
system/cpus.c:476:    if (cpu->thread_kicked) {
system/cpus.c:479:    cpu->thread_kicked = true;
target/arm/hvf/hvf.c:1825:    qatomic_set_mb(&cpu->thread_kicked, false);

(Call introduced in commit 219c101fa7f "arm/hvf: Add a WFI handler").

