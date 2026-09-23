Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58202C9830C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9NAL-0007w2-Ex; Wed, 23 Sep 2026 09:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1x9NAD-0007sv-NT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:37:35 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jbeulich@suse.com>) id 1x9NA9-0001cA-T9
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 09:37:33 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so6692185e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790170648; x=1790775448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fcrUh4n9/+wLrzrrVFpgROhaQUP011P1zLKET1PjOsk=;
 b=g4zVMhG8zY3D3hz2ofeOJXecGhUbXwbR338JZ4WPTe/2a6sRCMFXiuouUEUaNCLWpi
 hga3pKacU95B9BQPBUDynQ6Hv3h4VVqRH8mfUpBmx0vNCSw5/fGboM9devDBBBJpnpkT
 ntgxMcsn2eYr2NgFo8XHRPbkblD3JjuLyp16aN0n8uVDhOEwQ2p+jLUqELILyDnt9P8t
 oivl3rV0pVtdW+zHHEindR7rFEiQXusoJVHJK85UPJfT0jC8QOWw3AYWTMEAEbFzqM2q
 UPOJm2uVWTCXm155e4JAliV5283Juu/G5o+oYC4upGPciBhdI5gv8vc/AZoJmp+Dy2WK
 sOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790170648; x=1790775448;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fcrUh4n9/+wLrzrrVFpgROhaQUP011P1zLKET1PjOsk=;
 b=ka3imoOSWk+cRyz0pYYkcAA05RYV1T2MUMNGoKcwTeWtF6b7lI7RJ2hDQzw6jslvbL
 isHIgmtbBN9pu/7SVEYcP4RMgHpROjkrbolJ7Ldwf7f76EIfeTZ/nD/M2G68sVZsK+lM
 /JiHLZuTEp6WT+GYKjpd7XJYBzS4TTYZOSu3TcfYuUWwLnnwnUMhjr0B1gnbks+hNH/P
 DjMImypIlD3D2utJQF1lEl7o5zsc7bRYhDqXKAst/UJGNE5yClhZd7QIRWbzKnz0P6Ga
 yN0RY4wlA5MXUyDD+I9FczAYLkMLcRpTOQVsYLHd/HaA6GqntWmg/wYBrQSRxnyhtY1H
 FoRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxd+qrFWLuvDVOByagogrHYyiWDbu6nRut6Spce1Ly1Jc8E1/EhA3m9D27NNtMu8DXVh7VkdX2WpeVX@nongnu.org
X-Gm-Message-State: AFuF++nEAzTlHFwclRziD6MOBCAQw7ljDhcMuN6V1OOxwXqJxZjJryE1
 /QoqDsUWnAThyNOsaUslVUCmlmPrdBjcgvg17Ue29VZtK8bY05vcbq2jm5IUYp0n3w==
X-Gm-Gg: AYBFou11CNfXJu3BhwXVztIXaem89zNCoE21fFDhBkEB5+/yNLQI/JkieZRA25NhBZT
 gC9oggWAkDaGazAHxs/rWE4K2bT779LdhEC5apNpSyAoFLSFFHwhUVa74QD2pWGPLm9XfPbakgK
 /1t3VqWPMIMOH3ME6Lq39mO8i91A5h1oSCpal7qKOfVC+6SKk7O5+v0b3Y0pBSiLtXm7vCG39Dh
 d8j6UI9wHuLJsoNoiQOEpI1prX8WfXNzXEoguSdRFjmfrliQ7ZJYGfGbDxXsjD4rlGxn4Grc406
 d4K4pl3zmp46PJWlTgDZPhaJFAf02C8mky0nmfcLunE1RGJD2MYyDZQ3srPt3ZJP96CzlRZCYdh
 kN60WBUWWLdbNs/QTllfTLCqulnWKLpur/42eIpYKqlEQoE4OdrfuMrDqJTMfNx/VSIcOhQr5Kd
 Xyo8YVXabJg+DgfNRZiqFmWDKDon/CsL1YllghlvF4BlJ6HZUP4fvEJsi1XUuZ41UWsrBB/ozgr
 zL2Z80Q+ubBM0occ1Z/uBNSeqPbH8/NicvhhtR6SujPaH1ndmZfKyI+GKbw4k6L7JwSzLK/Xg==
X-Received: by 2002:a05:600c:8b88:b0:49c:fc6e:8cbd with SMTP id
 5b1f17b1804b1-49fdf152e3fmr34515245e9.33.1790170647957; 
 Wed, 23 Sep 2026 06:37:27 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de.
 [37.24.206.209]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde198f85sm82730105e9.8.2026.09.23.06.37.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 06:37:26 -0700 (PDT)
Message-ID: <b7d1510e-ce88-4e1f-8ac2-f9c33eed0c67@suse.com>
Date: Wed, 23 Sep 2026 15:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 000/114] single-binary: link multi-targets into
 qemu-system
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: xen-devel@lists.xenproject.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260923131635.1894-1-luoyonggang@gmail.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20260923131635.1894-1-luoyonggang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=jbeulich@suse.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

(reducing Cc list to mailing lists)

On 23.09.2026 15:14, Yonggang Luo wrote:
> This series produces one qemu-system binary that can run ARM (32 and
> 64), RISC-V (32 and 64), and MicroBlaze.
> Upstream filters machines with TypeInfo.is_available. This series
> passes a TargetInfo into that callback, uniquifies QOM names that
> collide in one process, and compiles those targets once so they can
> share qemu-system.
> 
> A combined link cannot keep C symbols or QOM type names that were
> unique only because each qemu-system-$arch was a separate binary.
> These patches remove those collisions:
> 
> - TYPE_ACCEL_CPU is the fixed abstract type accel-cpu, registered
>   once next to TYPE_ACCEL. Leaf names still encode the CPU type so
>   accel_init_cpu_interfaces() can look up "<accel>-" plus
>   target_cpu_type() (tcg-accel-arm-cpu).
> - virt QOM names are prefixed: arm-virt, riscv-virt, and the same
>   for or1k, hexagon, loongarch, m68k, and xtensa. Boards keep
>   -machine virt via machine_class_set_name(). query-machines returns
>   the QOM type in MachineInfo typename.
> - virt ACPI helpers and RISC-V TCG crc32/crc32c/wfi helpers get an
>   arch prefix so the combined link does not need meson -D name
>   mangling. LoongArch virt_acpi_setup is renamed in the same pass.
> 
> Target selection has to work with more than one TargetInfo:
> 
> - The combined binary takes arch:name on -M/-machine and in a
>   [machine] type (aarch64:virt). arch: binds the target. microblaze:
>   runs that target's default machine. arm, aarch64, riscv32, and
>   riscv64 have no default. No -M leaves target none and the empty
>   none machine. qemu-system-$arch keeps the historic -M name.
>   -M help lists every target; arch:help lists one. query-targets
>   lists each linked target, including none.
> - TargetInfo is a constructor list. target_info_select() picks the
>   entry, including SYS_EMU_TARGET_NONE. is_available takes const
>   TargetInfo *. While the target is still none, QOM skips the
>   unavailable filter so grouped -M help can list every machine.
> - query-cpu-definitions, dump notes, and Angel semihosting sit on
>   TargetCpuOps indexed by target_arch(). Registration uses a
>   QEMU_ARCH_* bitmask so one object can fill ARM and AARCH64. The
>   table is target-ops.h / target-ops.c.
> 
> qemu-system-$TARGET is still built, including the Windows *w twin.
> qemu-system is extra. It links each target whose arch sources are
> only target-info-def.c: arm, aarch64, riscv32, riscv64, and
> microblaze. Do not add qemu-systemw for that binary. A GUI
> twin would keep QEMU exporting data from the .exe into DLLs, and
> those data exports cannot be delay-loaded (qdev_prop_array and
> other qdev_prop_*). That would block enabling modules globally on
> Windows.
> 
> Examples:
> 
>   qemu-system -M aarch64:virt ...
>   qemu-system -M microblaze:petalogix-s3adsp1800 ...
>   qemu-system-riscv64 -M virt ...
> 
> A bare machine name on qemu-system needs an arch: prefix. An unknown
> target fails with "target '...' is not available".
> 
> Prerequisites:
>   [PATCH v2 0/9] machine: uniquify virt QOM names
>   https://patchew.org/QEMU/20260922215533.641-1-luoyonggang@gmail.com/
>   [PATCH 00/21] accel/tcg: share raise_excp across TCG targets
>   https://patchew.org/QEMU/20260918004225.827-1-luoyonggang@gmail.com/
>   [PATCH v5 00/11] single-binary: Compile hw/riscv once
>   https://patchew.org/QEMU/20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng/
> 
> v1: https://patchew.org/QEMU/20260823150731.896-1-luoyonggang@gmail.com/
> v2: https://patchew.org/QEMU/20260826184229.1145-1-luoyonggang@gmail.com/
> branch: https://gitlab.com/lygstate-qemu/qemu/-/tree/single-binary-arm-riscv?ref_type=heads
> x86_64 and i386: https://gitlab.com/lygstate-qemu/qemu/-/tree/combined-binary-multi-targets?ref_type=heads
> 
> Changes v2 -> v3:
> - Drop -target. v2 parsed a target_name token and required it on
>   bare qemu-system, with -target ? to list names. v3 selects the
>   target with arch:name on -M. No -M leaves target none. -M help
>   and arch:help list machines.
> - Rebased onto current master. Upstream is_available(void) replaces
>   TYPE_TARGET_SPECIFIC. v3 passes const TargetInfo * into
>   is_available. The v2 patches that registered TYPE_TARGET_SPECIFIC
>   on ARM and RISC-V virt are dropped.
> - TargetInfo is a constructor list, not chosen from argv[0].
>   target_info_select() sets the current entry. Add SysEmuTarget
>   none. A single-target binary does not switch TargetInfo; arch:
>   must match that binary or the machine is rejected.
> - Drop -Dsingle_binary. qemu-system is built from
>   single_binary_supported_targets once arch_srcs are only
>   target-info-def.c. microblaze joins ARM and RISC-V. Per-target
>   binaries stay. Still no qemu-systemw for the combined binary.
> - Unique virt QOM names extend past ARM and RISC-V to or1k,
>   hexagon, loongarch, m68k, and xtensa. query-machines returns
>   MachineInfo typename.
> - TargetCpuOps is an array indexed by target_arch(), registered
>   with a QEMU_ARCH_* bitmask. The header moves from
>   target-info-qom.h to target-ops.h.
> - Those targets are compiled once: ARM, RISC-V, and MicroBlaze fold
>   into common source sets, TARGET_* ifdefs become runtime checks, and
>   KVM moves to system_ss.
> 
> Pierrick Bouvier (2):
>   configs/targets: remove target info definitions
>   target-info: rename target-info-stub.c in target-info-def.c
> 
> Yonggang Luo (112):
>   meson: stale qemu-version.h only when .git exists
>   target-info: rename target-info-impl.h to target-info-def.h
>   target-info: set cpu_type from TARGET_BASE_ARCH
>   target: remove CPU_RESOLVING_TYPE
>   vl: parse early options before target-info init
>   target-info: replace QOM registration with a constructor list
>   tests/unit: add test-target-info
>   tests/qtest: prepare machine-list-test for combined qemu-system
>   kconfig: rename REGISTER to HW_REGISTER
>   target-info: add TargetKconfig
>   target-info: add target_is_* helpers for each architecture
>   target-info: add i386 and x86_64 helpers
>   qom: pass TargetInfo to is_available
>   module: use static ModuleEntry and per-type DSO lists
>   module: add before/after hooks and module_call_init_fn
>   qom: register late types through module_call_init_fn
>   qom: inherit is_available and filter after MODULE_INIT_QOM
>   tests/unit: add module-init and qom is-available tests
>   hw/arm/virt: prefix ACPI helpers with arm_virt_
>   hw/riscv/virt: prefix ACPI helpers with riscv_virt_
>   hw/loongarch/virt: prefix ACPI helper with loongarch_virt_
>   target/riscv: uniquify TCG crc32, crc32c, and wfi helper names
>   hw/riscv: gate boards with target_is_base_riscv
>   hw/intc: use target_long_bits in IMSIC geilen
>   hw/misc/riscv_cmgcr: replace target_ulong with uint64_t
>   hw/intc: use kvm_enabled() in APLIC AIA helpers
>   hw/intc: send IMSIC MSI via kvm_irqchip_send_msi()
>   target/riscv: add kvm stubs source set
>   tcg: fix off-by-one in helper extend-free assert
>   gdbstub: drop per-target cpu-param.h from helpers.h
>   hw/riscv: expand boston-aia and microblaze-v-generic to TypeInfo
>   target/riscv: Include migration/vmstate.h instead of migration/cpu.h
>     in machine.c
>   target/riscv: gate CPU types with TargetInfo
>   target/riscv: select ELF dump class from target_riscv64
>   target/riscv: replace TARGET_* macros in CSR helpers
>   target/riscv: use target_long_bits in pmpaddr granule checks
>   target/riscv: preserve signed XLEN semantics without target_long
>   target/riscv: replace leftover TARGET_LONG_BITS
>   target/riscv: select monitor width at runtime
>   target/riscv: replace target-width format macros
>   target/riscv: replace TARGET_LONG_BITS in translate
>   target-info: add tl_is_64() and target_is_tl32/64 helpers
>   target-info: dispatch CPU QMP, dump, and Angel semihosting
>   tcg: give TCGv its own type and runtime tl ops
>   exec: allow target_long.h, abi_ptr.h and cpu-ldst.h from common code
>   migration: add TargetInfo-gated vmstate fields
>   target/i386: always compile XMM, YMMH, and Hi16 VMSD
>   target/i386: replace VMSTATE_UINTTL with 32/64 TI fields
>   target/ppc: replace VMSTATE_UINTTL with 32/64 TI fields
>   target/sparc: replace VMSTATE_UINTTL with 32/64 TI fields
>   target/mips: replace VMSTATE_UINTTL with 32/64 TI fields
>   hw/hexagon: drop unused migration/cpu.h include
>   migration: remove unused cpu.h
>   target/riscv: gate KVM CPU VMSDs with target_has_kconfig_kvm
>   target/riscv: use tcg_imm_tl in translate
>   target/riscv: select FP and amocas width at runtime
>   target/riscv: drop TARGET_RISCV XL shortcuts in translate
>   target/riscv: select KVM host CPU width at runtime
>   accel: use a shared TYPE_ACCEL_CPU parent
>   kvm: always compile guest debug
>   hw/i386: move APIC_DEFAULT_ADDRESS to apic.h
>   kvm: stop including cpu.h from kvm.h
>   kvm: default kvm_arch_reset_parked_vcpu in stubs
>   kvm: drop COMPILING_PER_TARGET wrap around kvm_arch APIs
>   kvm: add split irqchip and send_msi stubs
>   kvm: replace TARGET_S390X and TARGET_PPC hints
>   kvm: move kvm_ss to system_ss
>   system: add qemu_host_arch() and reject unavailable -accel
>   kvm: add AccelClass is_available for host/guest pairing
>   hvf: add AccelClass is_available for host/guest pairing
>   xen: add AccelClass is_available for host/guest pairing
>   nitro: add AccelClass is_available for host/guest pairing
>   mshv: add AccelClass is_available for host/guest pairing
>   whpx: add AccelClass is_available for host/guest pairing
>   target/i386/nvmm: add AccelClass is_available for host/guest pairing
>   accel: replace ACCEL_CPU_NAME with accel_cpu_register_type
>   whpx: move whpx_ss to system_ss
>   hw/riscv: move boards and irqchip onto hw_common_arch
>   target/riscv: include target_long.h in TCG helpers
>   target/riscv: compile CPU and TCG once
>   target/arm: replace target_long in A64 translate
>   target/arm: use 64-bit TCG addresses in A64 translate
>   target/arm: move kvm_arm_set_cpreg_mig_tolerances to kvm.c
>   target/arm: allow -cpu host with Nitro
>   target/arm: gate -cpu host with TypeIsAvailable
>   target/arm: fix family-common KVM compile
>   tests/qtest: raise aspeed_smc-test timeout to 12 minutes
>   hw/intc: move ARM GIC kvm/hvf/whpx onto arm_common_ss
>   target/arm: fold arm_ss into common source sets
>   meson: link shared objects into qemu-system
>   target/microblaze: fold system sources into common source sets
>   meson: add microblaze-softmmu to the combined qemu-system list
>   boards: remove unused DEFINE_MACHINE_WITH_INTERFACES
>   hw/arm: set virt TypeInfo.is_available
>   hw/arm: set remaining 32-bit machine TypeInfo.is_available
>   hw/arm: set aarch64-only machine TypeInfo.is_available
>   hw/microblaze: set petalogix-s3adsp1800 TypeInfo.is_available
>   hw/arm: expand leftover 32-bit DEFINE_MACHINE to TypeInfo
>   hw/arm: expand imx8mm-evk DEFINE_MACHINE to TypeInfo
>   hw/microblaze: expand petalogix-ml605 and xlnx-zynqmp-pmu to TypeInfo
>   hw/i386: set TYPE_X86_MACHINE TypeInfo.is_available
>   hw/block/dataplane: move xen-block onto system_ss
>   hw/remote: move multiprocess memory onto remote_ss
>   hw/remote: set x-remote TypeInfo.is_available
>   target-info: add SysEmuTarget none
>   accel/tcg: tolerate NULL target_cpu_type for -M none
>   qom: skip unavailable filter when target_none()
>   module: load every arch-tagged module when target is none
>   target-info: select combined qemu-system target by name
>   vl: parse arch: machine types on combined qemu-system
>   qapi: add query-targets
>   tests/qtest: cover combined qemu-system machines and accel-cpu

Now this is really excessive: You mail out a huge series (a fair part
of which apparently still needs to make it through), cross posting to
lists covering components which are touched only in very few places of
the series. I consider such rude already for much smaller series; here
you definitely should have made per-patch Cc lists. I wouldn't be
surprised if xen-devel@ isn't the only list which is being spammed for
no good reason.

Jan

