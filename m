Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3615FF53D6E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2AOJ-0000Oa-V6; Mon, 16 Mar 2026 12:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2AOI-0000Nd-EZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:02:02 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2AOG-0000h8-7S
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:02:02 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-64ad019bbd4so4827303d50.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 09:01:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773676919; cv=none;
 d=google.com; s=arc-20240605;
 b=dCUrjl2O2L91wFeaJIRWQa0MT/ZsQUpmt5IAgYMq4GJ8XMC53TGB8Lkkk8/rp0ZlNW
 cPlIk7xWMx0OPdBe46innPbQh8MiaqHOoD65PJ1W5ZYP7yQQqkG1SnsbM+jPtuhv8Ybx
 t4NwzcK9TP3F/xKL6lwhS6O7Z+Fok8zOHNhB8tpUWWXCmOcosnx7hTUUUyIX9WTZ4HBm
 S283dDhXI1pz4Er7LCkO74fMqDtnaoY7i37McElvfeUC9yy2sGnIEng3M/1RvDJSy7sT
 30yi0T/mwQ8w/K9bqij8T5HM7Vbn1x9y5JnX1DfJxBOIcHCIGnOBweAgc3smSHNlAx1T
 SY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GN4ErEzsX70Hn1AmxS7IMIG2FMGVna6MRmkHvyQZ9Hw=;
 fh=e7KFnIxW3CrgInXi6CJ+oK9Px3SvDPamNMp8OesOSuY=;
 b=Vxm9G7drX33++Pgknz2BzMU7gaB3APBL/dOYpTQWHiRG8Ddi2xnfFA4HeNRHLlelTE
 KNMljZ1LLFQhNFUc1ov1Ge0elrgMo6e1G6cEOrgJYgQ0899zIYqhkKSDBEWxEA6KCwm7
 sf4aJ9Ma/SE/4YQlRJnOo2eYe+n0UPQxCw8qKQjGY2L/Y1XfykTRDv0j/TaOdPRfeNEQ
 88WxDJSSrPctbY0jcOKlEJYB+9ONbzhLHbpPFQOkfhh42n5Lca5AHOeOPBUW7NdaalR7
 nGdvLGQ4aZGvzpiwVF0lwdyOLfz0y85ceORRF25AqgTxFNekFDhhUanoBomOeTsG6g+G
 vdlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773676919; x=1774281719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GN4ErEzsX70Hn1AmxS7IMIG2FMGVna6MRmkHvyQZ9Hw=;
 b=I3RpazTRKdCP+FSqJhMSwnRv1Ls8wGDPtr+gtRYdpjn+zMWoMXfXW8ZI613CiMhiYT
 alBmGXxRrx8IeHoqIO76NdgODAcpWirLEPyIsI52Uur8uEV/5SZKtS4U0cAnijamrh9S
 ljWCL32EKaWX0w8kVCLBwbgZJUi6sAUpGzYiAbpgcktQOMDgq0SY77T0YTO1tQseRt+k
 buOyYHXBTZznpWvISQbULw7XL9ubYUuvuDhCO3A6l2UsxrkiXMncJIzANAPQ7GIdTgGB
 rL96ocS5NIdtVkf7kYSd6pk3G0HZfXK+ZolZOHRohL/PHcQhKGcSfcGy1aMEAviW2NNs
 rxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773676919; x=1774281719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GN4ErEzsX70Hn1AmxS7IMIG2FMGVna6MRmkHvyQZ9Hw=;
 b=f7uL0CX4lI0Ld9TlP4iSU51jqaf0WjYIY5Jsh6RLj3mhxbkhwK9W2gQczy3ABRHZYQ
 EwJI1yPffelgLKwLY5QftSb/ce6lrivcki5NsudN/aU/CPnEGXfsKUn/ealrLMuqUuRz
 q0CzA+9x4qlN7ZpojjjuFECas+Iix6N/8+jkYLqjPF02rOiOE/DmRsjhVvzlJvI6fZJM
 B+5b9QJY1AtTYMfFjE8h7u+UrjHS3ThJGsUKKipULfa3tCwJQyLa1OMU8/y4YMytRHZ/
 R7S8/EAj0QOztn/6eGHfA8umGN+dQ7OI2/pzZ7d+mXcymCoxnokN2MxJ7rV8+q/UyvAf
 t/Qw==
X-Gm-Message-State: AOJu0YxvpJETDnwzT+wLQxhq8HFSWZo+Ocern+f1mtbp8ikd8iQWOa+L
 ztRTE0WYNK7DGKocDd+3mX7Ei1Feko+5sSJ1h3fe9bC4cWbGskbFELwXOQRNIEUHql5pOM4Hhuu
 6MeJSUKSEdm5RCwbB3sN9hT4W8s+2IfpZP2skFZzabg==
X-Gm-Gg: ATEYQzzR6nt7CktY/ztBw7U/FzpscOHGASi6BQ6IreHaLGQnOfxXgWrj+XYvLCcU30+
 vnzA9cWuzwtLHpQXX0aul+SMBg/fe4Er/1qYvrszOA2TBwlD7Vzsem0pRLOaoFSpHFpPvGzMeek
 6z665b+fV0LB8CBamhooujRHi57XnrdYbH7jzA3n7tubGydxGns7qocd5J4y23vL+QpvmDFNga6
 f21A5iOLKQo4xZhjZamf5va1UkNgaAhio9QhSnPQBLBn8NvEL+mpz3A7M/x+mCZNfw0q4EszABj
 h2Wjs6QorLIpZsbxa+KoPvp4qdXw96fDSM5dEs0RDlvAzzxg53BKEsnTHhA2odZztec=
X-Received: by 2002:a53:b3c3:0:b0:64d:29a2:6933 with SMTP id
 956f58d0204a3-64e62f32bc2mr10599564d50.17.1773676918685; Mon, 16 Mar 2026
 09:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260212144244.22579-1-pbonzini@redhat.com>
 <20260212144244.22579-5-pbonzini@redhat.com>
In-Reply-To: <20260212144244.22579-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 16:01:45 +0000
X-Gm-Features: AaiRm51KN8IVbYs2MEvQdiFu_SzMzr8EOnfhdZenTF3dcZEUIubIqjvZ5avcUr8
Message-ID: <CAFEAcA-O4g5ZrRdK1s5kBjMfRbWhPnD0hLZwhpVHVHVbE7LKdQ@mail.gmail.com>
Subject: Re: [PULL 04/41] pc: Start with modern CPU hotplug interface by
 default
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 12 Feb 2026 at 14:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Zhao Liu <zhao1.liu@intel.com>
>
> For compatibility reasons PC/Q35 will start with legacy CPU hotplug
> interface by default but with new CPU hotplug AML code since 2.7
> machine type (in commit 679dd1a957df ("pc: use new CPU hotplug interface
> since 2.7 machine type")). In that way, legacy firmware that doesn't use
> QEMU generated ACPI tables was able to continue using legacy CPU hotplug
> interface.
>
> While later machine types, with firmware supporting QEMU provided ACPI
> tables, generate new CPU hotplug AML, which will switch to new CPU
> hotplug interface when guest OS executes its _INI method on ACPI tables
> loading.
>
> Since 2.6 machine type is now gone, and consider that the legacy BIOS
> (based on QEMU ACPI prior to v2.7) should be no longer in use, previous
> compatibility requirements are no longer necessary. So initialize
> 'modern' hotplug directly from the very beginning for PC/Q35 machines
> with cpu_hotplug_hw_init(), and drop _INIT method.
>
> Additionally, remove the checks and settings around cpu_hotplug_legacy
> in cpuhp VMState (for piix4 & ich9), to eliminate the risk of
> segmentation faults, as gpe_cpu no longer has the opportunity to be
> initialized. This is safe because all hotplug now start with the modern
> way, and it's impossible to switch to legacy way at runtime (even the
> "cpu-hotplug-legacy" properties does not allow it either).

Hi. This commit seems (according to git bisect) to have broken
"savevm" for the MIPS malta board (which uses piix4): it now
segfaults when you run the command from the monitor. Repro:

$ qemu-img create -f qcow2 dummy.qcow2 32M

Build QEMU with
'--target-list=mips-linux-user,mips64-linux-user,mipsel-linux-user,mipsn32-linux-user,mipsn32el-linux-user,mips-softmmu,mipsel-softmmu,mips64-softmmu,mips64el-softmmu'.

$ ./build/mips/qemu-system-mipsel -nographic -drive
if=none,format=qcow2,file=dummy.qcow2
[Type "C-a c" to get the "(qemu)" monitor prompt)]
(qemu) savevm foo

Backtrace from doing this under gdb:

#0  0x0000555555df7d4d in vmsd_can_compress (field=0x5555564f78a0
<__compound_literal.3>) at ../../migration/vmstate.c:339
#1  0x0000555555df7dbb in vmsd_desc_field_start
    (vmsd=0x555556431ba0 <vmstate_cpuhp_state>, vmdesc=0x555556918690,
field=0x5555564f78a0 <__compound_literal.3>, i=0, max=1) at
../../migration/vmstate.c:362
#2  0x0000555555df85a7 in vmstate_save_state_v
    (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
opaque=0x555556c9aac0, vmdesc=0x555556918690, version_id=1,
errp=0x7fffffffc948) at ../../migration/vmstate.c:528
#3  0x0000555555df8032 in vmstate_save_state
    (f=0x555556b5a0c0, vmsd=0x555556431ba0 <vmstate_cpuhp_state>,
opaque=0x555556c9aac0, vmdesc_id=0x555556918690, errp=0x7fffffffc948)
at ../../migration/vmstate.c:427
#4  0x0000555555df8f83 in vmstate_subsection_save
    (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
opaque=0x555556c9aac0, vmdesc=0x555556918690, errp=0x7fffffffc948)
    at ../../migration/vmstate.c:695
#5  0x0000555555df88a0 in vmstate_save_state_v
    (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
opaque=0x555556c9aac0, vmdesc=0x555556918690, version_id=3,
errp=0x7fffffffc948) at ../../migration/vmstate.c:582
#6  0x0000555555df8032 in vmstate_save_state
    (f=0x555556b5a0c0, vmsd=0x555556431c40 <vmstate_acpi>,
opaque=0x555556c9aac0, vmdesc_id=0x555556918690, errp=0x7fffffffc948)
at ../../migration/vmstate.c:427
#7  0x0000555555bd379e in vmstate_save (f=0x555556b5a0c0,
se=0x555557090ff0, vmdesc=0x555556918690, errp=0x7fffffffc948)
    at ../../migration/savevm.c:1054
#8  0x0000555555bd5133 in qemu_savevm_state_non_iterable
(f=0x555556b5a0c0, errp=0x7fffffffc948)
    at ../../migration/savevm.c:1726
#9  0x0000555555bd5226 in qemu_savevm_state_complete_precopy
(s=0x5555567a1d00) at ../../migration/savevm.c:1753
#10 0x0000555555bd5615 in qemu_savevm_state (f=0x555556b5a0c0,
errp=0x7fffffffcbf0) at ../../migration/savevm.c:1855
#11 0x0000555555bd8b83 in save_snapshot
    (name=0x555557497150 "foo", overwrite=true, vmstate=0x0,
has_devices=false, devices=0x0, errp=0x7fffffffcbf0)
    at ../../migration/savevm.c:3267
#12 0x0000555555ba9a62 in hmp_savevm (mon=0x55555691d950,
qdict=0x5555574973a0) at ../../migration/migration-hmp-cmds.c:481

The problem is that the vmstate_cpu_hotplug VMStateDescription
that is being used has a NULL "fields" (it is the "stub" one).
This used to be OK because the "piix4_pm/cpuhp" vmstate had
a "needed" function that would return false for Malta, so we
never tried to use the stub code.

What's the intention here ? Shouldn't we still have a "needed"
function that returns "false" for the cases where we would be
using the stub version of vmstate_cpu_hotplug ? Otherwise we
would be changing the migration data. We can permit a compat
break for MIPS boards, but the commit message suggests that
this wasn't intended to be a compat break.

In this thread Fabiano suggests a fix which is probably OK
if we want to take the "break migration compat" route:
https://lore.kernel.org/qemu-devel/CAFEAcA9BzSp9F8yv4eZv5eeUM4JXSy9T-QnRr_UbJZpNmhtHyw@mail.gmail.com/T/#m6f4a672ddfa8a0a34dfdf9b57bb04e529ab5c9a4


>  include/hw/acpi/cpu.h          |  1 -
>  hw/acpi/cpu.c                  | 10 ----------
>  hw/acpi/ich9.c                 | 22 +++-------------------
>  hw/acpi/piix4.c                | 21 +++------------------
>  hw/i386/acpi-build.c           |  2 +-
>  hw/loongarch/virt-acpi-build.c |  1 -
>  6 files changed, 7 insertions(+), 50 deletions(-)
>
> diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
> index 557219d2c63..2809dd8a911 100644
> --- a/include/hw/acpi/cpu.h
> +++ b/include/hw/acpi/cpu.h
> @@ -54,7 +54,6 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>
>  typedef struct CPUHotplugFeatures {
>      bool acpi_1_compatible;
> -    bool has_legacy_cphp;
>      bool fw_unplugs_cpu;
>      const char *smi_path;
>  } CPUHotplugFeatures;
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 6f1ae79edbf..d63ca83c1bc 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -408,16 +408,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>          aml_append(field, aml_reserved_field(4 * 8));
>          aml_append(field, aml_named_field(CPU_DATA, 32));
>          aml_append(cpu_ctrl_dev, field);
> -
> -        if (opts.has_legacy_cphp) {
> -            method = aml_method("_INI", 0, AML_SERIALIZED);
> -            /* switch off legacy CPU hotplug HW and use new one,
> -             * on reboot system is in new mode and writing 0
> -             * in CPU_SELECTOR selects BSP, which is NOP at
> -             * the time _INI is called */
> -            aml_append(method, aml_store(zero, aml_name(CPU_SELECTOR)));
> -            aml_append(cpu_ctrl_dev, method);
> -        }
>      }
>      aml_append(sb_scope, cpu_ctrl_dev);
>
> diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
> index 2b3b493c014..54590129c69 100644
> --- a/hw/acpi/ich9.c
> +++ b/hw/acpi/ich9.c
> @@ -183,26 +183,10 @@ static const VMStateDescription vmstate_tco_io_state = {
>      }
>  };
>
> -static bool vmstate_test_use_cpuhp(void *opaque)
> -{
> -    ICH9LPCPMRegs *s = opaque;
> -    return !s->cpu_hotplug_legacy;
> -}
> -
> -static int vmstate_cpuhp_pre_load(void *opaque)
> -{
> -    ICH9LPCPMRegs *s = opaque;
> -    Object *obj = OBJECT(s->gpe_cpu.device);
> -    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
> -    return 0;
> -}
> -
>  static const VMStateDescription vmstate_cpuhp_state = {
>      .name = "ich9_pm/cpuhp",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .needed = vmstate_test_use_cpuhp,
> -    .pre_load = vmstate_cpuhp_pre_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
>          VMSTATE_END_OF_LIST()
> @@ -338,8 +322,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
>      pm->powerdown_notifier.notify = pm_powerdown_req;
>      qemu_register_powerdown_notifier(&pm->powerdown_notifier);
>
> -    legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
> -        OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
> +    cpu_hotplug_hw_init(pci_address_space_io(lpc_pci),
> +        OBJECT(lpc_pci), &pm->cpuhp_state, ICH9_CPU_HOTPLUG_IO_BASE);
>
>      acpi_memory_hotplug_init(pci_address_space_io(lpc_pci), OBJECT(lpc_pci),
>                               &pm->acpi_memory_hotplug,
> @@ -419,7 +403,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
>  {
>      static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
>      pm->acpi_memory_hotplug.is_enabled = true;
> -    pm->cpu_hotplug_legacy = true;
> +    pm->cpu_hotplug_legacy = false;
>      pm->disable_s3 = 0;
>      pm->disable_s4 = 0;
>      pm->s4_val = 2;
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 19d4d4be932..0eda692084d 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -195,25 +195,10 @@ static const VMStateDescription vmstate_memhp_state = {
>      }
>  };
>
> -static bool vmstate_test_use_cpuhp(void *opaque)
> -{
> -    PIIX4PMState *s = opaque;
> -    return !s->cpu_hotplug_legacy;
> -}
> -
> -static int vmstate_cpuhp_pre_load(void *opaque)
> -{
> -    Object *obj = OBJECT(opaque);
> -    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
> -    return 0;
> -}
> -
>  static const VMStateDescription vmstate_cpuhp_state = {
>      .name = "piix4_pm/cpuhp",
>      .version_id = 1,
>      .minimum_version_id = 1,
> -    .needed = vmstate_test_use_cpuhp,
> -    .pre_load = vmstate_cpuhp_pre_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
>          VMSTATE_END_OF_LIST()
> @@ -573,12 +558,12 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>          qbus_set_hotplug_handler(BUS(pci_get_bus(PCI_DEVICE(s))), OBJECT(s));
>      }
>
> -    s->cpu_hotplug_legacy = true;
> +    s->cpu_hotplug_legacy = false;
>      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
>                               piix4_get_cpu_hotplug_legacy,
>                               piix4_set_cpu_hotplug_legacy);
> -    legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gpe_cpu,
> -                                 PIIX4_CPU_HOTPLUG_IO_BASE);
> +    cpu_hotplug_hw_init(parent, OBJECT(s), &s->cpuhp_state,
> +                        PIIX4_CPU_HOTPLUG_IO_BASE);
>
>      if (s->acpi_memory_hotplug.is_enabled) {
>          acpi_memory_hotplug_init(parent, OBJECT(s), &s->acpi_memory_hotplug,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 19c62362e31..cdd72cbcaa0 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -964,7 +964,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
>          CPUHotplugFeatures opts = {
> -            .acpi_1_compatible = true, .has_legacy_cphp = true,
> +            .acpi_1_compatible = true,
>              .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
>              .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
>          };
> diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
> index 54ac94e17d3..3e34bedcd6f 100644
> --- a/hw/loongarch/virt-acpi-build.c
> +++ b/hw/loongarch/virt-acpi-build.c
> @@ -369,7 +369,6 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
>
>      if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
>          opts.acpi_1_compatible = false;
> -        opts.has_legacy_cphp = false;
>          opts.fw_unplugs_cpu = false;
>          opts.smi_path = NULL;
>
> --
> 2.52.0

thanks
-- PMM

