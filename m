Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C06CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 13:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v67lm-00011K-UC; Tue, 07 Oct 2025 09:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1v67lj-00010f-Ct
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:30:19 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1v67la-000580-7b
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 09:30:18 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-42f67e91ae7so35269165ab.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 06:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759843803; x=1760448603; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5u6Ur4oT6s0jXoCTIiLRdpi+SLDQablwl5SIadoUr04=;
 b=X8nYhkhqYW1IoNADw7W8kDtPSfzz/uRw7PnWp20U9WCNNE1RXHj9Uwyk0keLL2QBA/
 m57Egtn1n2IVu9OnVvp61PYd843UMJ+15GWybz8J8m+XLk9miWzVOMOyEYBMuUufnglz
 5LqcjJXjqwcxh9EQn3TvsLN8qAIZXfroSWHWUNJpteIlOoROolW8YI6riHFoolD01/NM
 8IWXzUmJAY+uwhMyRnfrdUNiTQHvh9t3NlacZvp4i6jZSwOoSH1j4GdJSMHLuitTLGzh
 I95F8WJeppz4WVs0mCDh8/wPeMW/hWuD5RYW3ZlDMWsfWuUE8aQIUHiz4RKt4OaTwyX+
 UziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759843803; x=1760448603;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5u6Ur4oT6s0jXoCTIiLRdpi+SLDQablwl5SIadoUr04=;
 b=La5v9GsMqnqR6qQoO1FrPvHOKe/6FAPBuZlH3LXSwclzjFTC90T18/RF8h9vbF0A+j
 nr98JG8kT0svtPaBFTAtumseLX6PyNdg4PdiaAZnahhcYPE+skNag53TkjfBuRqK4ic5
 laAmEKazOgTgul4Rqat2rkECsA2iA2CVgkvlwkeS02I7SQ6gPf8XA45ObxUQaaRloYUG
 aqIeXyVzodkINUiKaO49hoJvkl1atU/T0hSbvb8VhCy9bAWBT5HVz9kdSi+PCCcneD/U
 ZUGEDErII31DTl2wpaQBBB4kCIw+iMh5zeYEb7pt36u5BATa+bM3iL+xK4Glhu2uDeVa
 4fEw==
X-Gm-Message-State: AOJu0YxEpc+FFSoPowotxDpWkpDsKdXvVWC3/KK7uFeo5aYHar4ocfSu
 mOVQ1ZTeWaByCnY36J0UaDmyGRzGtPoyVM3/J/uhJMNE92aM8FaNA5CJ4gXb49wnW4Y=
X-Gm-Gg: ASbGnct++342NXLMmSiY9jBF4pBG9958ptrYU+yFp0HLHZgtzwvBXlpW/7MO0Yj3Jc1
 L0I53XehgufIcplgHT7yoAm7pw7XlGAmkE5YPbFP5oFh5q0O/urI8CmKXs7tWL+wEiPbw5ul+Rk
 6MSLQi3uFydiMn1nl4pbm4mT2Cmz2Yz5LrUmJIY9YAaC5hNby/Xoj1S9NFKxMdu0Ehnz3p+D2Pa
 18q3VGagvR7nvpr9OK9E5QXy92fz1YmBd5kN69Fo93j9BwujqJaLqixANQEiyfoi6xjgN7Rid7l
 7MHD6cRX4fBd2MgAcRVYJpkECgUX5DK2IUBICwJ0dxpdMLf+0WPrW6A7VOuwuU+9MXniqbIBjtK
 jTs00TivFmDgRx93w3yxeVEbdjV7QBssFQQkLCo7U9cJYD5M5
X-Google-Smtp-Source: AGHT+IH4v0smDXGJoO2/bNfPuuXziacLVjQ6SQwubdaf2LC1SFVxIjbd2i4GmNAZcFHgw8u2RhgIHw==
X-Received: by 2002:a05:6e02:168e:b0:424:14a4:5064 with SMTP id
 e9e14a558f8ab-42e7ac437a1mr208082325ab.0.1759843802699; 
 Tue, 07 Oct 2025 06:30:02 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec0b026sm6035706173.59.2025.10.07.06.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 06:30:02 -0700 (PDT)
Date: Tue, 7 Oct 2025 08:30:01 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Huacai Chen <chenhuacai@kernel.org>, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 3/3] accel/kvm: Factor kvm_cpu_synchronize_put() out
Message-ID: <20251007-650e7ef70cc4591d1ef647f1@orel>
References: <20251007081616.68442-1-philmd@linaro.org>
 <20251007081616.68442-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251007081616.68442-4-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=ajones@ventanamicro.com; helo=mail-il1-x129.google.com
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

On Tue, Oct 07, 2025 at 10:16:16AM +0200, Philippe Mathieu-Daudé wrote:
> The same code is duplicated 3 times: factor a common method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/kvm/kvm-all.c | 47 ++++++++++++++++++---------------------------
>  1 file changed, 19 insertions(+), 28 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 9060599cd73..de79f4ca099 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2935,22 +2935,32 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
>      }
>  }
>  
> -static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
> +static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
> +                                    const char *desc)
>  {
>      Error *err = NULL;
> -    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err);
> +    int ret = kvm_arch_put_registers(cpu, state, &err);
>      if (ret) {
>          if (err) {
> -            error_reportf_err(err, "Restoring resisters after reset: ");
> +            error_reportf_err(err, "Restoring resisters %s: ", desc);
>          } else {
> -            error_report("Failed to put registers after reset: %s",
> +            error_report("Failed to put registers %s: %s", desc,
>                           strerror(-ret));
>          }
> -        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
> -        vm_stop(RUN_STATE_INTERNAL_ERROR);
> +        return false;
>      }
>  
>      cpu->vcpu_dirty = false;
> +
> +    return true;
> +}
> +
> +static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
> +{
> +    if (kvm_cpu_synchronize_put(cpu, KVM_PUT_RESET_STATE, "after reset")) {

This should be !kvm_cpu_synchronize_put() and same comment for the other
calls below.

Thanks,
drew

> +        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
> +        vm_stop(RUN_STATE_INTERNAL_ERROR);
> +    }
>  }
>  
>  void kvm_cpu_synchronize_post_reset(CPUState *cpu)
> @@ -2964,19 +2974,9 @@ void kvm_cpu_synchronize_post_reset(CPUState *cpu)
>  
>  static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
>  {
> -    Error *err = NULL;
> -    int ret = kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE, &err);
> -    if (ret) {
> -        if (err) {
> -            error_reportf_err(err, "Putting registers after init: ");
> -        } else {
> -            error_report("Failed to put registers after init: %s",
> -                         strerror(-ret));
> -        }
> +    if (kvm_cpu_synchronize_put(cpu, KVM_PUT_FULL_STATE, "after init")) {
>          exit(1);
>      }
> -
> -    cpu->vcpu_dirty = false;
>  }
>  
>  void kvm_cpu_synchronize_post_init(CPUState *cpu)
> @@ -3166,20 +3166,11 @@ int kvm_cpu_exec(CPUState *cpu)
>          MemTxAttrs attrs;
>  
>          if (cpu->vcpu_dirty) {
> -            Error *err = NULL;
> -            ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE, &err);
> -            if (ret) {
> -                if (err) {
> -                    error_reportf_err(err, "Putting registers after init: ");
> -                } else {
> -                    error_report("Failed to put registers after init: %s",
> -                                 strerror(-ret));
> -                }
> +            if (kvm_cpu_synchronize_put(cpu, KVM_PUT_RUNTIME_STATE,
> +                                        "at runtime")) {
>                  ret = -1;
>                  break;
>              }
> -
> -            cpu->vcpu_dirty = false;
>          }
>  
>          kvm_arch_pre_run(cpu, run);
> -- 
> 2.51.0
> 
> 

