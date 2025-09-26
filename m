Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C5DCAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 17:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2CZW-0007CN-Do; Fri, 26 Sep 2025 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2CZC-00079s-FN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 13:49:15 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2CZ3-0000z5-KQ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 13:49:09 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-636d5cefab2so1726423d50.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 10:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758908931; x=1759513731; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7XQue5BQLoCllFYIVbu41xYDeAfrEoM9/FkoM+tryxw=;
 b=cYrQlTiVk44mhACsHR1V8mQnuwHFQIavUNtZ5brl2WdX85UdGLrJU6qu3VWpwa6b0E
 1vKJFi0/PwMGKNrCaIEZkA4Ey4px6dUmTrgj54DAs4UIDd4v857w7PczvOTsXGByfwbL
 qKXXQmGq7KGB6XrlM/Kb6ZwDln+pa7C8NkvyMQIrA3kgeBb+Vc2Rh9BOvEis2IRUdylK
 qL62+UgYwAsk3ik0/KZGzm4JMyfcNImBJJW9PU4ndRrbXdfkIwiYAja6p1Y0jUpqHu2q
 t/xsVeHV3n5TM2dhIbEhy5WMlr25x7ZbWHJWi9kdIYFvRshQoztNuw+y5buEGRkgxWHp
 ahKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758908931; x=1759513731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XQue5BQLoCllFYIVbu41xYDeAfrEoM9/FkoM+tryxw=;
 b=EnFTN7C9Au5YQhakPvGZfWyuf3ic0TxybQKDadEZj/hKA/rZbldzHvBZVZPdvF8Qtt
 gsTHWHbh7wVA3K8NXt6TWJ9C5XKYZroFHZ+BFFGvA2IUt5K4WCQ3ND1r+QknntYdl0/s
 auvxVJEJEM4GnBaiDNL/DBTT3KpKtNp96XwkGdx3rfEixmEW/ivzvNAFsIwIT1Rz01rh
 o3DbJEgr3QrVuGNYfCYrszrH6ridoBOUT0IxWJdxr0aAAsVxkdyzRZyvekF/95gBJNm0
 Wy0exdlg9XBMwXiwVkP4ZCSfD6KarjaevNC3ZHNJTT1E1QE5FeQQ0lzXt+hTz4xdATp1
 oufw==
X-Gm-Message-State: AOJu0Yx61FnAgx/o3eVNVFrlV2lqk7+lp0jGnqPETzp1TnovenFbndKi
 yNeT1a5bMiGeaIjjQjH+KIZRQUvyHX7iXve47CCWjQzpy51KezxL3L8EDjyNzBY9MEpoTPmJyYz
 PU4EsvWskfk959r0SY5adQNsUhICqsounCNkPcTN71A==
X-Gm-Gg: ASbGncuQ8Z+qPi4jrtYKFFTpXtxF6r4zDlHW2Rf1VkbzNYVfOtYghZ1lE5sMp6qNV4L
 RHjqNtTw1nMw/1xjvcJIpfpEVdImhRk+FQPzTx7OavRkdvsT5WKxEYulUCVJAliXLGytejgpblu
 11lDxiPFVoV0jp9aFf8XQf5we6J30sPs/s6ew9jgUYGy/jqwmOwx/K9dt1diqmxfWT7G/JuGLI7
 DnAD6NsYVDD4r+Knhg=
X-Google-Smtp-Source: AGHT+IGw9+L3N7DMyI9WhKaVC48g89VFRxgGRowOAVZwR9i3Oio6PQKdgWkN44ZBHSXttDA8YoLXFzL2sykHUaXkcNg=
X-Received: by 2002:a05:690e:2442:b0:628:2e16:6566 with SMTP id
 956f58d0204a3-6361a5ef399mr6249185d50.0.1758908931510; Fri, 26 Sep 2025
 10:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <20250913080943.11710-55-pbonzini@redhat.com>
In-Reply-To: <20250913080943.11710-55-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 18:48:40 +0100
X-Gm-Features: AS18NWDkZX_-lGYqaWaFMCJJHgRii1ulOK9d-dLiwojBN1NH8HHOYL1oDDSnGQc
Message-ID: <CAFEAcA_3kkZ+a5rTZGmK8W5K6J7qpYD31HkvjBnxWr-fGT2h_A@mail.gmail.com>
Subject: Re: [PULL 54/61] i386/cpu: Enable SMM cpu address space under KVM
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Kirill Martynov <stdcalllevi@yandex-team.ru>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sat, 13 Sept 2025 at 09:25, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Xiaoyao Li <xiaoyao.li@intel.com>
>
> Kirill Martynov reported assertation in cpu_asidx_from_attrs() being hit
> when x86_cpu_dump_state() is called to dump the CPU state[*]. It happens
> when the CPU is in SMM and KVM emulation failure due to misbehaving
> guest.
>
> The root cause is that QEMU i386 never enables the SMM address space for
> cpu since KVM SMM support has been added.
>
> Enable the SMM cpu address space under KVM when the SMM is enabled for
> the x86machine.
>
> [*] https://lore.kernel.org/qemu-devel/20250523154431.506993-1-stdcalllevi@yandex-team.ru/

Hi; I just noticed that this change seems to not account
for x86 CPU hotplug...

> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 89a79536594..1dc1ba9b486 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -13,6 +13,7 @@
>  #include "qapi/error.h"
>  #include "system/system.h"
>  #include "hw/boards.h"
> +#include "hw/i386/x86.h"
>
>  #include "kvm_i386.h"
>  #include "accel/accel-cpu-target.h"
> @@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>          kvm_set_guest_phys_bits(cs);
>      }
>
> +    /*
> +     * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
> +     *
> +     * Only initialize address space 0 here, the second one for SMM is
> +     * initialized at register_smram_listener() after machine init done.
> +     */
> +    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
> +    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);

In the KVM CPU realizefn we call cpu_address_space_init()
for AS 0. This happens both for the CPUs that exist with
QEMU starts up and also for any hotplugged CPU.

> +
>      return true;
>  }
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 34e74f24470..d191d7177f1 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
>
>  static void register_smram_listener(Notifier *n, void *unused)
>  {
> +    CPUState *cpu;
>      MemoryRegion *smram =
>          (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
>
> @@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier *n, void *unused)
>      address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
>      kvm_memory_listener_register(kvm_state, &smram_listener,
>                                   &smram_address_space, 1, "kvm-smram");
> +
> +    CPU_FOREACH(cpu) {
> +        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
> +    }
>  }

However, this code is in a machine_init_done notifier, so it
runs only once when QEMU starts up. So the CPUs initially
present on QEMU startup get their AS 1 initialized, but
any CPU hot-plugged later on while QEMU is running will
not ever call cpu_address_space_init() for AS 1.

I saw this with some work-in-progress patches I have that
try to free the AddressSpaces of the CPU (which crash
because the hot-plugged CPU claims to have 2 ASes but
the second one is NULL). You can probably also get a
crash for a variation of the reported crash that this
commit is trying to fix, if the CPU that we try to
x86_cpu_dump_state() for is a hot-plugged one in SMM state.

Where should we be initing the AS for hot-plugged CPUs?

thanks
-- PMM

