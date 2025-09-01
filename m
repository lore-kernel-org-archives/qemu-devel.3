Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F0CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4OR-0002pT-8y; Mon, 01 Sep 2025 09:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4OD-00020w-LW
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4OB-0007v8-0s
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756732561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9mHvc5P43//szp4XzxvQFFLfC4Y352Ej51eCDvbXqmo=;
 b=Tb9oSDGBs3vu6ntW7VQUEHoK0j9Mqhdm4NSOYCYd6CsAAv9VkxPc/v0Q/LHVD30A+72JyI
 l80j9jrCsznNtNK7YQiq1fLdk9mal7Cgt7shqxGZfEFKNp1uLHHssL+kBe8UVAT4gWFIuZ
 SEKWLzzqQiXTU+zQFWBO30+rmlkpXXM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-Qa-tqwkNO_2V8z8lWJLvgQ-1; Mon, 01 Sep 2025 09:16:00 -0400
X-MC-Unique: Qa-tqwkNO_2V8z8lWJLvgQ-1
X-Mimecast-MFC-AGG-ID: Qa-tqwkNO_2V8z8lWJLvgQ_1756732560
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b3349c2c38so22245981cf.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756732559; x=1757337359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9mHvc5P43//szp4XzxvQFFLfC4Y352Ej51eCDvbXqmo=;
 b=UJCzx5NDOSga82FmN1g8nmYD9nTluthy7qTkPiQ8vIl8IavgsukKeH5MDdCM6Vp/hq
 J+cfE9f5Kfy3xTwXqPnnX+a61lyjtmaoG4nMFMwAW7tmLsKVzlQ+EDZioI/pJ4OAvD2S
 ELN9TzAyAj4TDavtS4u8gO37YJ2AkCujt/rXUZV/IMbq7bUhMHLEOe5pHDGQALRGVr6r
 nnhA/2K0y21sg6r4U95XMA69nRni15TMOEKx+vjJrsaPfGe3067jmhiaHMkFXEtaqQZo
 p/WZQlepAqCToWC+4sL8vhcVGsH+maqVGRVBIfiMa75FYzBmyU9NXURWmoSxDEgnTWJo
 4FMw==
X-Gm-Message-State: AOJu0Yx/7To7LrlWV0rGvvb3OUzrA3mN6rwy624BVy6th8fGmWdHE1c/
 L42wIc256uCQYODjVwLoFT7VnZYv20OmABvMGI3tRM/gEdUhURnNhf8GGgazK4I5YBznExA10TI
 nkZgqpU9hUrRnswd7ZI9r1jskQe/VnG2pMBdU+nFCJJUZRDC3ZzIWpT8W
X-Gm-Gg: ASbGnctLT8FyNwsIHVplITROaX/nXig5xAHMjJqzxtute1zEW+fF16OC8NCcYht5fOt
 oSNCONG0Ta4OdANvuUF0Ni6n8dn/F7cEFyj4AHUGW1uyFIJ89E24TE8dAWYsj0p16yXMTg6J5YT
 CuITCaxhG42T0LjgsSbqqsPOvyZXu8aarCYbqJRQR7mvj0bz1vPqsg+6X+a8THP0JZ9SULm0/HX
 LS7p57H6eZzvIC+LOHr/Xduc0G91qAJwhJ/QBaeQic6GyRIniZeUWrDXZ4k3yU3gofWFENBNmzp
 nLfu+mDKRAQtWHwTnBR0SBPm2OIbgw==
X-Received: by 2002:a05:622a:111:b0:4b3:11db:26a5 with SMTP id
 d75a77b69052e-4b31d843295mr102172441cf.22.1756732559399; 
 Mon, 01 Sep 2025 06:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YaD3xCElkl0gftt1U1cLdT66OtHrMrLoYlJgBK/lveEeuFx2hC4AZ77mcBusDbNpVviFjQ==
X-Received: by 2002:a05:622a:111:b0:4b3:11db:26a5 with SMTP id
 d75a77b69052e-4b31d843295mr102171771cf.22.1756732558706; 
 Mon, 01 Sep 2025 06:15:58 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb25c82f4sm40328726d6.7.2025.09.01.06.15.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:15:58 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:15:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH 10/18] accel: use atomic accesses for exit_request
Message-ID: <20250901151554.355ad47a@fedora>
In-Reply-To: <20250829153115.1590048-6-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-6-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 29 Aug 2025 17:31:07 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> CPU threads write exit_request as a "note to self" that they need to
> go out to a slow path.  This write happens out of the BQL and can be
> a data race with another threads' cpu_exit(); use atomic accesses
> consistently.
>=20
> While at it, change the source argument from int ("1") to bool ("true").
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/core/cpu.h             | 9 +++++++++
>  accel/kvm/kvm-all.c               | 2 +-
>  accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
>  accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
>  hw/ppc/spapr_hcall.c              | 6 +++---
>  target/i386/kvm/kvm.c             | 6 +++---
>  target/i386/nvmm/nvmm-accel-ops.c | 2 +-
>  target/i386/nvmm/nvmm-all.c       | 2 +-
>  target/i386/whpx/whpx-all.c       | 6 +++---
>  9 files changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 8b57bcd92c9..338757e5254 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -422,6 +422,15 @@ struct qemu_work_item;
>   * valid under cpu_list_lock.
>   * @created: Indicates whether the CPU thread has been successfully crea=
ted.
>   * @halt_cond: condition variable sleeping threads can wait on.
> + * @exit_request: Another thread requests the CPU to call qemu_wait_io_e=
vent().
> + *   Should be read only by CPU thread with load-acquire, to synchronize=
 with
> + *   other threads' store-release operation.
> + *
> + *   In some cases, accelerator-specific code will write exit_request fr=
om
> + *   within the same thread, to "bump" the effect of qemu_cpu_kick() to
> + *   the one provided by cpu_exit(), especially when processing interrupt
> + *   flags.  In this case, the write and read happen in the same thread
> + *   and the write therefore can use qemu_atomic_set().
>   * @interrupt_request: Indicates a pending interrupt request.
>   *   Only used by system emulation.
>   * @halted: Nonzero if the CPU is in suspended state.
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index bd9e5e3886d..e4167d94b4f 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3730,7 +3730,7 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, voi=
d *addr)
>      have_sigbus_pending =3D true;
>      pending_sigbus_addr =3D addr;
>      pending_sigbus_code =3D code;
> -    qatomic_set(&cpu->exit_request, 1);
> +    qatomic_set(&cpu->exit_request, true);
>      return 0;
>  #else
>      return 1;
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mt=
tcg.c
> index 337b993d3da..b12b7a36b5d 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -85,7 +85,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
> =20
>      /* process any pending work */
> -    cpu->exit_request =3D 1;
> +    qatomic_set(&cpu->exit_request, true);
> =20
>      do {
>          if (cpu_can_run(cpu)) {
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 1e551e92d6d..c2468d15d4f 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -212,7 +212,7 @@ static void *rr_cpu_thread_fn(void *arg)
>      cpu =3D first_cpu;
> =20
>      /* process any pending work */
> -    cpu->exit_request =3D 1;
> +    qatomic_set(&cpu->exit_request, true);
> =20
>      while (1) {
>          /* Only used for icount_enabled() */
> @@ -286,7 +286,7 @@ static void *rr_cpu_thread_fn(void *arg)
>          /* Does not need a memory barrier because a spurious wakeup is o=
kay.  */
>          qatomic_set(&rr_current_cpu, NULL);
> =20
> -        if (cpu && cpu->exit_request) {
> +        if (cpu && qatomic_read(&cpu->exit_request)) {
>              qatomic_set_mb(&cpu->exit_request, 0);
>          }
> =20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 1e936f35e44..51875e32a09 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -509,7 +509,7 @@ static target_ulong h_cede(PowerPCCPU *cpu, SpaprMach=
ineState *spapr,
>      if (!cpu_has_work(cs)) {
>          cs->halted =3D 1;
>          cs->exception_index =3D EXCP_HLT;
> -        cs->exit_request =3D 1;
> +        qatomic_set(&cs->exit_request, true);
>          ppc_maybe_interrupt(env);
>      }
> =20
> @@ -531,7 +531,7 @@ static target_ulong h_confer_self(PowerPCCPU *cpu)
>      }
>      cs->halted =3D 1;
>      cs->exception_index =3D EXCP_HALTED;
> -    cs->exit_request =3D 1;
> +    qatomic_set(&cs->exit_request, true);
>      ppc_maybe_interrupt(&cpu->env);
> =20
>      return H_SUCCESS;
> @@ -624,7 +624,7 @@ static target_ulong h_confer(PowerPCCPU *cpu, SpaprMa=
chineState *spapr,
>      }
> =20
>      cs->exception_index =3D EXCP_YIELD;
> -    cs->exit_request =3D 1;
> +    qatomic_set(&cs->exit_request, true);
>      cpu_loop_exit(cs);
> =20
>      return H_SUCCESS;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 8420c4090ef..34e74f24470 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5486,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_r=
un *run)
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR))=
 {
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
>              !(env->hflags & HF_SMM_MASK)) {
> -            qatomic_set(&cpu->exit_request, 1);
> +            qatomic_set(&cpu->exit_request, true);
>          }
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> -            qatomic_set(&cpu->exit_request, 1);
> +            qatomic_set(&cpu->exit_request, true);
>          }
>      }
> =20
> @@ -5604,7 +5604,7 @@ int kvm_arch_process_async_events(CPUState *cs)
>          if (env->exception_nr =3D=3D EXCP08_DBLE) {
>              /* this means triple fault */
>              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> -            cs->exit_request =3D 1;
> +            qatomic_set(&cs->exit_request, true);
>              return 0;
>          }
>          kvm_queue_exception(env, EXCP12_MCHK, 0, 0);
> diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-ac=
cel-ops.c
> index 3799260bbde..86869f133e9 100644
> --- a/target/i386/nvmm/nvmm-accel-ops.c
> +++ b/target/i386/nvmm/nvmm-accel-ops.c
> @@ -77,7 +77,7 @@ static void nvmm_start_vcpu_thread(CPUState *cpu)
>   */
>  static void nvmm_kick_vcpu_thread(CPUState *cpu)
>  {
> -    cpu->exit_request =3D 1;
> +    qatomic_set(&cpu->exit_request, true);
>      cpus_kick_thread(cpu);
>  }
> =20
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 10bd51d9b59..7e36c42fbb4 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -414,7 +414,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
>       * or commit pending TPR access.
>       */
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR))=
 {
> -        cpu->exit_request =3D 1;
> +        qatomic_set(&cpu->exit_request, true);
>      }
> =20
>      if (!has_event && cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 2106c29c3a0..00fb7e23100 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -1489,10 +1489,10 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR))=
 {
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
>              !(env->hflags & HF_SMM_MASK)) {
> -            cpu->exit_request =3D 1;
> +            qatomic_set(&cpu->exit_request, true);
>          }
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> -            cpu->exit_request =3D 1;
> +            qatomic_set(&cpu->exit_request, true);
>          }
>      }
> =20
> @@ -1539,7 +1539,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
>      if (tpr !=3D vcpu->tpr) {
>          vcpu->tpr =3D tpr;
>          reg_values[reg_count].Reg64 =3D tpr;
> -        cpu->exit_request =3D 1;
> +        qatomic_set(&cpu->exit_request, true);
>          reg_names[reg_count] =3D WHvX64RegisterCr8;
>          reg_count +=3D 1;
>      }


