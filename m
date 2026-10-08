Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C34CCA6002
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 05:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEh4T-0002kz-OW; Thu, 08 Oct 2026 01:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEh3b-0002hn-U3; Thu, 08 Oct 2026 01:52:44 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEh3W-0007R5-Qe; Thu, 08 Oct 2026 01:52:43 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6985qGai096018
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 8 Oct 2026 14:52:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=mRcbI5KxehEiaB+U0zC/BBNJ/DaSg8JqIn5ZUB3Yo7M=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791438736; v=1;
 b=OTGWG5flLvvCT5A9mZUi1SRAyBechFEYRh1pCdclsj23h4NeMyUAO7Y8a3vsTXB1
 ouKvCRbBRr4rTnrEKMo855YiGRk0DwMnmik+P6bk6gNq7RVSmQ+Mo2l+0CCvCzbA
 YfgCp1Vgz5YTNsLzzq4+4Fs1MlHQhE1KoDkv9D4wi+t4o+OgVJ+Rqav6kZayMJbp
 dWY+yBWwcLegjxu2o3UVUEZ4yZELaV31x9sTVRS0TYvuhrwJWqsArv+7ggwjsyLp
 +zQCGm18D+7gyeN7F2YXAYiuPDqCGFnaXPK8AQTtp70Hbn8SZ9FFOpXU6/fj6BQS
 F9/SR7rMWgtOuSGPhPofdQ==
Message-ID: <be98c53b-d01f-4beb-8915-cc73f22e839a@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 8 Oct 2026 14:52:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/hvf: Retry RAM write faults only for dirty
 logging
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 "Scott J . Goldman" <scottjgo@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-stable@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20261007093001.74476-1-philmd@oss.qualcomm.com>
 <f0c07762-c115-41a0-b713-a47bdaa1f218@rsg.ci.i.u-tokyo.ac.jp>
 <478c0311-b31e-4d38-af65-79508fca3021@oss.qualcomm.com>
 <6f694401-3cc9-4c76-aa2d-3625773823c7@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <6f694401-3cc9-4c76-aa2d-3625773823c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/08 7:05, Philippe Mathieu-Daudé wrote:
> On 7/10/26 21:50, Philippe Mathieu-DaudÃ© wrote:
>> On 2026-10-07 16:50, Akihiko Odaki wrote:
>>> On 2026/10/07 18:30, Philippe Mathieu-Daudé wrote:
>>>> From: Mark Burton <mburton@qti.qualcomm.com>
>>>>
>>>> Dirty-page logging handles a RAM write fault by marking the page dirty,
>>>> restoring write permission, and retrying the guest instruction.
>>>>
>>>> The handler also retried when the resolved RAM region had no dirty-log
>>>> client.  This path neither restores permission nor advances the PC, so
>>>> the instruction can repeatedly exit to QEMU.
>>>>
>>>> Retry only after marking the page dirty and restoring write permission.
>>>> Otherwise, use the existing emulation path to complete the access and
>>>> advance the guest PC.
>>>
>>> I can identify three cases of RAM write faults. The existing code
>>> handles all three, but this patch breaks the third:
>>>
>>> 1. The RAM is read-only. assert(!mr->readonly) trips in this case.
>>>
>>> 2. Dirty logging is enabled. The vCPU marks the page dirty, restores
>>>     write permission, and retries the write.
>>>
>>> 3. Dirty logging is enabled when the fault occurs, but another thread
>>>     disables it before the vCPU acquires the BQL. The vCPU then observes
>>>     a zero dirty-log mask. The write still needs to be retried because
>>>     write permission has already been restored. The existing code does
>>>     this correctly, but this patch falls through to emulation instead.
>>>
>>> This patch is useful only if there is another case that the existing
>>> code does not handle correctly. Please describe that case and preserve
>>> the retry behavior in case 3.
>> Thanks for the deep review.
>>
>> The reporter said:
>>
>>    We reproduced is a level-2 translation fault, DFSC 0x06, on a
>>    dynamic DMI RAM leaf that has no corresponding HVF mapping.
>>    address_space_translate() resolves the leaf as RAM, but the dirty-log
>>    mask is zero, no page is marked or unprotected, and the unconditional
>>    retry makes no progress.
>>
>> That would be another case:
>>
>>    4. FlatView says RAM, but HVF has no mapping (nothing has changed
>>       to make retry succeed).
>>
>> So to prevent retrying a known translation miss that cannot make any
>> progress checking DFSC could be sufficient:
>>
>> -- >8 --
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index b00a7e1a84..4faa21caa1 100644
>>       case EC_DATAABORT: {
>>           bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
>>           bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
>>           bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
>>           bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
>>           uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
>>           uint32_t len = 1 << sas;
>>           uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
>>           uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
>> +        uint32_t fsc = FIELD_EX32(syndrome, DABORT_ISS, DFSC);
>> +        bool l2_translation_fault = fsc == 0b000110;
>>           uint64_t val = 0;
>>           uint64_t ipa = excp->physical_address;
>>           AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
>>
>>           trace_hvf_data_abort(excp->virtual_address, ipa, isv,
>>                                iswrite, s1ptw, len, srt);
>>
>>           if (cm) {
>>               /* We don't cache MMIO regions */
>>               advance_pc = true;
>>               break;
>>           }
>>
>>           /* Handle dirty page logging for ram. */
>>           if (iswrite) {
>>               hwaddr xlat;
>>               MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
>>                                                          NULL, true,
>>
>> MEMTXATTRS_UNSPECIFIED);
>> -            if (memory_region_is_ram(mr)) {
>> +            if (memory_region_is_ram(mr) && !s1ptw && ! 
>> l2_translation_fault) {
>>                   uintptr_t page_size = qemu_real_host_page_size();
>>                   intptr_t page_mask = -(intptr_t)page_size;
>>                   uint64_t ipa_page = ipa & page_mask;
>>
>>                   /* TODO: Inject exception to the guest. */
>>                   assert(!mr->readonly);
>>
>>                   if (memory_region_get_dirty_log_mask(mr)) {
>>                       memory_region_set_dirty(mr, xlat, page_size);
>>                       hvf_unprotect_dirty_range(ipa_page, page_size);
>>                   }
>>
>>                   /* Retry with page writes enabled. */
>>                   break;
>>               }
>>           }
>>
>>           /*
>>            * TODO: If s1ptw, this is an error in the guest os page 
>> tables.
>>            * Inject the exception into the guest.
>>            */
>>           assert(!s1ptw);
>> ---
>> (the !s1ptw guard is independent of the zero-mask race,
>>   this is to ensure we cannot accidentally take the dirty-log retry
>>   path when the page-table memory is RAM).
>>
>> But be wary because I'm way out of area of understanding here...

Checking DFSC specifically for a translation fault feels arbitrary. The 
broader lesson from case 3 is that the faulting condition can be 
resolved concurrently before acquiring the BQL. That same race window 
applies to case 4. Instead of matching on DFSC, we should re-check 
whether the faulting condition persists after acquiring the BQL.

Filtering out s1ptw also seems extraneous. If the page-table memory 
requires dirty logging, we should handle dirty-page tracking for it 
rather than skipping it with an additional guard.

>>
>> Anyway I asked the reporter for more info and possible reproducer;
>> and might add comments to the code to better follow the 1/2/3/4 paths.
>> But after some sleep :)
> Still here... Asked AI for reproducer:
> 
> -- >8 --
> AI-used-for: tests
> diff --git a/tests/tcg/aarch64/system/hvf-unmapped-ram.c b/tests/tcg/ 
> aarch64/system/hvf-unmapped-ram.c
> new file mode 100644
> index 00000000000..45721134710
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/hvf-unmapped-ram.c
> @@ -0,0 +1,110 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * Reproducer for an HVF data abort on a RAM FlatView leaf without an HVF
> + * mapping.  Run manually on Apple Silicon (whose host page size is 16 
> KiB):
> + *
> + *   qemu-system-aarch64 -accel hvf -cpu host -nodefaults -M 
> virt,highmem-ecam=off -m 128M \
> + *     -display none -serial stdio -kernel aarch64-softmmu-hvf- 
> unmapped-ram.test \
> + *     -device pci-testdev,bus=pcie.0,addr=0x1,membar=4K,membar-backed=on
> + *
> + * The 4 KiB pci-testdev BAR2 is RAM, but its size and programmed 
> address are not
> + * host-page aligned.  HVF therefore leaves it unmapped.  A write to 
> the BAR
> + * takes a level-2 translation fault (DFSC 0x06); the handler must 
> emulate the
> + * access and advance PC instead of retrying it forever.
> + */
> +
> +#include <stdint.h>
> +
> +#define ECAM_BASE           UINT64_C(0x3f000000)
> +#define TESTDEV_CONFIG      (ECAM_BASE + UINT64_C(0x8000))
> +#define PCI_COMMAND         UINT64_C(0x04)
> +#define PCI_COMMAND_MEMORY  UINT16_C(0x0002)
> +#define PCI_BAR2_LO         UINT64_C(0x18)
> +#define PCI_BAR2_HI         UINT64_C(0x1c)
> +
> +#define RAM_BAR             UINT64_C(0x10001000)
> +#define BAR_ADDRESS_MASK    UINT32_C(0xfffffff0)
> +#define SENTINEL            UINT32_C(0x1badb002)
> +
> +#define PL011_DR            UINT64_C(0x09000000)
> +#define PL011_FR            (PL011_DR + UINT64_C(0x18))
> +#define PL011_FR_TXFF       UINT32_C(0x20)
> +
> +#define PSCI_SYSTEM_OFF     UINT64_C(0x84000008)
> +
> +static inline uint16_t mmio_read16(uint64_t addr)
> +{
> +    return *(volatile uint16_t *)(uintptr_t)addr;
> +}
> +
> +static inline uint32_t mmio_read32(uint64_t addr)
> +{
> +    return *(volatile uint32_t *)(uintptr_t)addr;
> +}
> +
> +static inline void mmio_write16(uint64_t addr, uint16_t value)
> +{
> +    *(volatile uint16_t *)(uintptr_t)addr = value;
> +}
> +
> +static inline void mmio_write32(uint64_t addr, uint32_t value)
> +{
> +    *(volatile uint32_t *)(uintptr_t)addr = value;
> +}
> +
> +static inline void dsb_sy(void)
> +{
> +    asm volatile("dsb sy" : : : "memory");
> +}
> +
> +static void uart_puts(const char *str)
> +{
> +    while (*str) {
> +        while (mmio_read32(PL011_FR) & PL011_FR_TXFF) {
> +        }
> +        mmio_write32(PL011_DR, *str++);
> +    }
> +}
> +
> +static __attribute__((noreturn)) void system_off(void)
> +{
> +    register uint64_t x0 asm("x0") = PSCI_SYSTEM_OFF;
> +
> +    asm volatile("hvc #0" : "+r"(x0) : : "memory");
> +    for (;;) {
> +        asm volatile("wfi");
> +    }
> +}
> +
> +static __attribute__((noreturn)) void finish(int passed)
> +{
> +    uart_puts(passed ? "PASS\n" : "FAIL\n");
> +    system_off();
> +}
> +
> +int main(void)
> +{
> +    uint32_t bar;
> +
> +    /* Verify the fixed BDF exists before programming its 64-bit BAR2. */
> +    if (mmio_read16(TESTDEV_CONFIG) == UINT16_MAX) {
> +        finish(0);
> +    }
> +
> +    mmio_write32(TESTDEV_CONFIG + PCI_BAR2_HI, 0);
> +    mmio_write32(TESTDEV_CONFIG + PCI_BAR2_LO, RAM_BAR);
> +    mmio_write16(TESTDEV_CONFIG + PCI_COMMAND,
> +                 mmio_read16(TESTDEV_CONFIG + PCI_COMMAND) |
> +                 PCI_COMMAND_MEMORY);
> +    dsb_sy();
> +
> +    bar = mmio_read32(TESTDEV_CONFIG + PCI_BAR2_LO);
> +    if ((bar & BAR_ADDRESS_MASK) != RAM_BAR) {
> +        finish(0);
> +    }
> +
> +    mmio_write32(RAM_BAR, SENTINEL);
> +    dsb_sy();
> +    finish(mmio_read32(RAM_BAR) == SENTINEL);
> +}
> diff --git a/tests/tcg/aarch64/system/hvf-boot.S b/tests/tcg/aarch64/ 
> system/hvf-boot.S
> new file mode 100644
> index 00000000000..bf9be89ee6d
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/hvf-boot.S
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +/*
> + * Minimal bootstrap for hvf-unmapped-ram.c.
> + *
> + * Unlike boot.S, this must not issue a semihosting call before 
> entering C:
> + * HVF does not handle the semihosting HLT exception.  Direct -kernel 
> boot on
> + * the non-virtualized virt machine starts this ELF at EL1 with the MMU 
> off.
> + */
> +
> +    .text
> +    .align  4
> +    .global __start
> +    .type   __start, %function
> +__start:
> +    /* Use SP_EL1 and provide the C code a private stack. */
> +    msr     spsel, #1
> +    ldr     x0, =stack_end
> +    mov     sp, x0
> +    bl      main
> +
> +1:  wfi
> +    b       1b
> +    .size   __start, . - __start
> +
> +    .bss
> +    .align  12
> +stack:
> +    .space  4096
> +stack_end:
> diff --git a/tests/tcg/aarch64/system/hvf-unmapped-ram.out b/tests/tcg/ 
> aarch64/system/hvf-unmapped-ram.out
> new file mode 100644
> index 00000000000..7ef22e9a431
> --- /dev/null
> +++ b/tests/tcg/aarch64/system/hvf-unmapped-ram.out
> @@ -0,0 +1 @@
> +PASS
> diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/ 
> system/meson.build
> index f51feb253f9..0ee6ffeb527 100644
> --- a/tests/tcg/aarch64/system/meson.build
> +++ b/tests/tcg/aarch64/system/meson.build
> @@ -14,6 +14,14 @@ qemu_base_args = ['-display', 'none',
>                     '-kernel']
>   qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
> 
> +# This payload must not use boot.S: that bootstrap invokes semihosting 
> before
> +# main(), while the manual HVF run needs to start without any 
> semihosting exits.
> +hvf_unmapped_ram_cflags = ['-nostdlib',
> +                           '-ffreestanding',
> +                           '-Wa,--noexecstack',
> +                           files('hvf-boot.S')[0],
> +                           '-Wl,-T', link_script]
> +
>   # Multi arch tests - add cflags only once per src
>   multi_src = []
>   foreach t: tcg_tests['multiarch-softmmu']['tests']
> @@ -42,6 +50,14 @@ tests += {
>   tests += {
>     'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
>     'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
> +  'hvf-unmapped-ram.c': {
> +    'cflags': hvf_unmapped_ram_cflags,
> +    'qemu_args': ['-nodefaults', '-M', 'virt,highmem-ecam=off', '-cpu', 
> 'max', '-m', '128M',
> +                  '-serial', 'stdio',
> +                  '-device', 'pci- 
> testdev,bus=pcie.0,addr=0x1,membar=4K,membar-backed=on',
> +                  qemu_base_args],
> +    'expected_output': 'hvf-unmapped-ram.out',
> +  },
>     'gpc-test.c': {
>       'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
>                  '-Wno-main', '-Wno-unused-but-set-variable'],
> ---
> 
> ./qemu-system-aarch64 -accel hvf -cpu host -nodefaults \
>    -M virt,highmem-ecam=off -m 128M -display none -serial stdio \
>    -kernel ~/hvf-unmapped-mem-repro \
>    -device pci-testdev,bus=pcie.0,addr=0x1,membar=4K,membar-backed=on \
>    -trace hvf\*
> hvf_vm_map paddr:0x0000000000000000 size:0x04000000 vaddr:0x118000000 
> flags:0x05/R-X
> hvf_vm_map paddr:0x0000000004000000 size:0x04000000 vaddr:0x129904000 
> flags:0x05/R-X
> hvf_vm_map paddr:0x0000000040000000 size:0x08000000 vaddr:0x121900000 
> flags:0x07/RWX
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_data_abort data abort: [va=0x000000003f008000 pa=0x000000003f008000 
> isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
> hvf_data_abort data abort: [va=0x000000003f00801c pa=0x000000003f00801c 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x000000003f008018 pa=0x000000003f008018 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
> isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
> hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
> isv=1 iswrite=1 s1ptw=0 len=2 srt=1]
> hvf_data_abort data abort: [va=0x000000003f008018 pa=0x000000003f008018 
> isv=1 iswrite=0 s1ptw=0 len=4 srt=0]
> hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x0000000010001000 pa=0x0000000010001000 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x0Quit: 3
> (looping)
> 
> However I had to do this change in hvf_set_phys_mem():
> 
> -- >8 --
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 8bd9154a50b..7b34a5f586d 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -113,8 +113,14 @@ static void hvf_set_phys_mem(MemoryRegionSection 
> *section, bool add)
> 
>       if (!QEMU_IS_ALIGNED(size, page_size) ||
>           !QEMU_IS_ALIGNED(gpa, page_size)) {
> -        /* Not page aligned, so we can not map as RAM */
> -        add = false;
> +        return;
>       }
> 
>       if (!add) {
> ---
> 
> because otherwise I was getting:
> 
> hvf_vm_map paddr:0x0000000000000000 size:0x04000000 vaddr:0x114b80000 
> flags:0x05/R-X
> hvf_vm_map paddr:0x0000000004000000 size:0x04000000 vaddr:0x118b84000 
> flags:0x05/R-X
> hvf_vm_map paddr:0x0000000040000000 size:0x08000000 vaddr:0x10cb7c000 
> flags:0x07/RWX
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_kick_vcpu_thread cpu:0 stop:0
> hvf_data_abort data abort: [va=0x000000003f008000 pa=0x000000003f008000 
> isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
> hvf_data_abort data abort: [va=0x000000003f00801c pa=0x000000003f00801c 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x000000003f008018 pa=0x000000003f008018 
> isv=1 iswrite=1 s1ptw=0 len=4 srt=1]
> hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
> isv=1 iswrite=0 s1ptw=0 len=2 srt=0]
> hvf_data_abort data abort: [va=0x000000003f008004 pa=0x000000003f008004 
> isv=1 iswrite=1 s1ptw=0 len=2 srt=1]
> hvf_vm_unmap paddr:0x0000000010001000 size:0x00001000
> qemu-system-aarch64: Error: ret = HV_BAD_ARGUMENT (0xfae94003, at ../../ 
> accel/hvf/hvf-all.c:123)
> Abort trap: 6
> 
> (I'll look at that hvf_set_phys_mem change after some rest).

The change to hvf_set_phys_mem() fixes error handling for misaligned
memory mappings and is worth submitting as a separate patch.

This also implies case 4 isn't fully understood yet. Ideally, whenever 
FlatView resolves a region as RAM, HVF should have a mapping for it. A 
host-page-misaligned region is one scenario where HVF cannot create a 
mapping, but that previously triggered an assert (HV_BAD_ARGUMENT), 
ruling it out as the reporter's original root cause.

Please investigate why case 4 occurs and whether HVF can map the RAM
directly. If emulation is required, we should check for the specific
condition that requires it rather than treating a translation fault
alone as sufficient.

Please investigate why case 4 occurs in practice and consider adding a 
missing mapping rather than relying on emulation. If emulation is 
genuinely required, we should check for that specific condition rather 
than assuming it for a translation fault.

Regards,
Akihiko Odaki

