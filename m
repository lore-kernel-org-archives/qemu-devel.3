Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F329EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMc-0006bd-3X; Mon, 21 Jul 2025 12:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udtJ9-00066d-4Y
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1udtJ3-0001cR-8M
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23694cec0feso42080675ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753115039; x=1753719839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1q0VBZQ3xt+OCFbLS8rIG1ovGTmvWGaWt5TIxIgWWU=;
 b=TifzXYeUlpknQS23dneSHtoRsSVCRmroLFwkKgKb6satbKWsPQebz9iU1PyS2g6X9i
 giXakx9QbCUcVachdLf3e1a+E/g0v8zCvSfZql8G5qHOIVpbO6+8phNFDiJmsKKgJMx4
 53BiAgsq8Ob4522UjNbHis7mD5g1a3irZh/PPxquuh2o+6M6qx58GENTsbylMEV9oGsG
 9Fgf67Lz+PDgPvfByy59d2nlfaUecUhuSO7JnFHqJ2ZWuxCWpMTJm2fwtgcK76CkTBtB
 EovWgYA8KRlOjD8bEUg/0i8FNWjWgNV24O1yT7ii4QC6RqdUFOEpB0jB5uUcxQ47la3c
 NWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753115039; x=1753719839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1q0VBZQ3xt+OCFbLS8rIG1ovGTmvWGaWt5TIxIgWWU=;
 b=ryH/5Pv7v9v/5U8VLPtFsdqhKhX/t0FWFh9vFDex0at4Ivnw3chhDPthYZxrelp8EF
 beUaWoOWMOLEcv4n7ldGCKDzNjIVP4okZcbTREsEopiY1ioM27wmCNm+mG4+rRILRrUG
 r0rT4oxTz8mtZ/vUzfupk40HdRlt0LeHNNkdqvIitL6yoNAb1APfmyvHOh7nPiNenvDl
 o2GEvw/ubn5hgwDAgrzRCKFi03T12OoJqpscMrpEV4Ch/kGM3F8yY6pe69zgoi2D9aKv
 tCz4ExLpK+gCF6MFhUJxhYktFON4shDF3jbRoLVa+uQ8FT3ci7mt7uHZZYNdX1B6nv98
 JDyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUL1/TMCZPXb9n1aEB9BrCoxil0XQ+lDcbsnl+ruEnjEqoLpODni4C5F101SKs2+pyAbCvFcXpuaXd@nongnu.org
X-Gm-Message-State: AOJu0Yzt8jbulDIiMdZT5s3euQXBmJpQEgXkTIg1kZbnxUk4GkPqKusE
 JbhXTgLM5a/FBmDeVx6xad0aGWxd7orPHuXhTkgjzyTHyrcXdJyFXCWgdSrfAajTJ8ltnaE1czC
 y00RQ
X-Gm-Gg: ASbGnctu8YSYthiMtBbTeFlTjkL4u4ISENsjcRctcSpSPe9AThjkszqBm2qSO1PViEZ
 xt6n0ah/C2B83rm49qk6dxkekt5ioZdwzh0BoB5tByQ0P+utTYoaBTer45RaJgZJQooOZXzz4+w
 ibntZ5wMUpPgo5OALTuuHw4iu0kDkmMcnw5WVS3drL13kSAuCPsc/5A7TbjQ1BOEFVQBvrrCbyl
 e1+45ClDRAdKY19yB+aR6xpocaC5PF1OUN+U7NZR+mbpe9LrlqBQme26eQvZw99hTwZQgBOv17o
 0gZpdWy4k3HGeUSVTJ4+JBm/iITyAlcTTyuOi/mlLC5Q9E00wlQDkqLJDByZ2hdNg7kvbWhrZ4Y
 rnDUAYriQuNVtKSpl0yTGRWYyIKngLSNdiVI=
X-Google-Smtp-Source: AGHT+IHMQ1nYlhmhxEHt2uYSv5Vin7dkKjQ1MNOP67+HIfCxPmViiqiX5VaNKyRcns89AkeliwRVcA==
X-Received: by 2002:a17:903:b8d:b0:234:986c:66bf with SMTP id
 d9443c01a7336-23e24ec7396mr273255025ad.11.1753115038674; 
 Mon, 21 Jul 2025 09:23:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b6cfdbdsm60678545ad.150.2025.07.21.09.23.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 09:23:58 -0700 (PDT)
Message-ID: <c0878723-62e3-47cc-810e-6ba8a0bd30cd@linaro.org>
Date: Mon, 21 Jul 2025 09:23:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent race condition in mttcg memory handling
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
 <96201a23-784b-4268-b011-a6912175d237@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <96201a23-784b-4268-b011-a6912175d237@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Hi Michael,

On 7/21/25 4:47 AM, Philippe Mathieu-Daudé wrote:
> (Cc'ing few more developers)
> 
> On 30/5/25 21:20, Michael Tokarev wrote:
>> Hi!
>>
>> For quite some time (almost whole day yesterday) I'm trying to find out
>> what's going on with mmtcg in qemu.  There's apparently a race condition
>> somewhere, like a use-after-free or something.
>>
>> It started as an incarnation of
>> https://gitlab.com/qemu-project/qemu/-/issues/1921 -- the same assertion
>> failure, but on an x86_64 host this time (it's also mentioned in that
>> issue).
>>
>> However, that particular assertion failure is not the only possible
>> outcome.  We're hitting multiple assertion failures or SIGSEGVs in
>> physmem.c and related files, - 4 or 5 different places so far.
>>
>> The problem here is that the bug is rather difficult to reproduce.
>> What I've been using so far was to make most host cores busy, and
>> specify amount of virtual CPUs close to actual host cores (threads).
>>
>> For example, on my 4-core, 8-threads notebook, I used `stress -c 8`
>> and ran qemu with -smp 10, to trigger this issue. However, on this
>> very notebook it is really difficult to trigger it, - it happens
>> every 30..50 runs or so.
>>
>> The reproducer I was using - it was just booting kernel, no user-
>> space is needed. Qemu crashes during kernel init, or it runs fine.
>>
>> I used regular kernel from debian sid:
>>    http://deb.debian.org/debian/pool/main/l/linux-signed-amd64/linux-
>> image-amd64_6.12.29-1_amd64.deb
>> Extract vmlinuz-6.12.29-amd64 from there.
>>
>> In order to simplify the reproducing, I created a tiny initrd with
>> just one executable in there, which does a poweroff:
>>
>> cat >poweroff.c <<'EOF'
>> #include <sys/reboot.h>
>> #include <unistd.h>
>>
>> int main(void) {
>>     reboot(RB_POWER_OFF);
>>     sleep(5);
>>     return 0;
>> }
>> EOF
>> diet gcc -static -o init poweroff.c
>> echo init | cpio -o -H newc > initrd
>>
>> (it uses dietlibc, optional, just to make the initrd smaller).
>>
>> Now, the qemu invocation I used:
>>
>>    qemu-system-x86_64 -kernel vmlinuz -initrd initrd \
>>      -append "console=ttyS0" \
>>      -vga none -display none \
>>      -serial file:/dev/tty \
>>      -monitor stdio \
>>      -m 256 \
>>      -smp 16
>>
>> This way, it either succeeds, terminating normally due to
>> the initrd hating the system, or it will segfault or assert
>> as per the issue.
>>
>> For a 64-core machine, I used -smp 64, and had 16..40 cores
>> being busy with other stuff.  Also, adding `nice' in front
>> of that command apparently helps.
>>
>> Now, to the various issues/places I've hit.  Here's a typical
>> output:
>>
>> ...
>> [    3.129806] smpboot: x86: Booting SMP configuration:
>> [    3.135789] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
>> #8  #9
>> [    0.000000] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    0.000000] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    0.000000] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    0.000000] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    0.000000] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    0.000000] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    0.000000] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    0.000000] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    4.494389] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    4.494389] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    4.494396] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    4.494396] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    4.494401] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    4.494401] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    4.494408] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    4.494408] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    4.494415] calibrate_delay_direct() failed to get a good estimate
>> for loops_per_jiffy.
>> [    4.494415] Probably due to long platform interrupts. Consider using
>> "lpj=" boot option.
>> [    5.864038] smp: Brought up 1 node, 10 CPUs
>> [    5.865772] smpboot: Total of 10 processors activated (25983.25
>> BogoMIPS)
>> [    6.119683] Memory: 200320K/261624K available (16384K kernel code,
>> 2486K rwdata, 11780K rodata, 4148K init, 4956K bss, 53176K reserved, 0K
>> cma-reserved)
>> [    6.591933] devtmpfs: initialized
>> [    6.635844] x86/mm: Memory block size: 128MB
>> [    6.756849] clocksource: jiffies: mask: 0xffffffff max_cycles:
>> 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [    6.774545] futex hash table entries: 4096 (order: 6, 262144 bytes,
>> linear)
>> [    6.840775] pinctrl core: initialized pinctrl subsystem
>> [    7.117085] NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> [    7.165883] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic
>> allocations
>> [    7.184243] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for
>> atomic allocations
>> [    7.188322] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for
>> atomic allocations
>> [    7.195902] audit: initializing netlink subsys (disabled)
>> [    7.223865] audit: type=2000 audit(1748628013.324:1):
>> state=initialized audit_enabled=0 res=1
>> [    7.290904] thermal_sys: Registered thermal governor 'fair_share'
>> [    7.291980] thermal_sys: Registered thermal governor 'bang_bang'
>> [    7.295875] thermal_sys: Registered thermal governor 'step_wise'
>> [    7.299817] thermal_sys: Registered thermal governor 'user_space'
>> [    7.303804] thermal_sys: Registered thermal governor 'power_allocator'
>> [    7.316281] cpuidle: using governor ladder
>> [    7.331907] cpuidle: using governor menu
>> [    7.348199] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
>> [    7.407802] PCI: Using configuration type 1 for base access
>> [    7.417386] mtrr: your CPUs had inconsistent fixed MTRR settings
>> [    7.418244] mtrr: your CPUs had inconsistent variable MTRR settings
>> [    7.419048] mtrr: your CPUs had inconsistent MTRRdefType settings
>> [    7.419938] mtrr: probably your BIOS does not setup all CPUs.
>> [    7.420691] mtrr: corrected configuration.
>> [    7.461270] kprobes: kprobe jump-optimization is enabled. All kprobes
>> are optimized if possible.
>> [    7.591938] HugeTLB: registered 2.00 MiB page size, pre-allocated 0
>> pages
>> [    7.595986] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
>> [    7.816900] ACPI: Added _OSI(Module Device)
>> [    7.819950] ACPI: Added _OSI(Processor Device)
>> [    7.823873] ACPI: Added _OSI(3.0 _SCP Extensions)
>> [    7.827683] ACPI: Added _OSI(Processor Aggregator Device)
>> [    8.000944] ACPI: 1 ACPI AML tables successfully acquired and loaded
>> [    8.355952] ACPI: Interpreter enabled
>> [    8.406604] ACPI: PM: (supports S0 S3 S4 S5)
>> [    8.416143] ACPI: Using IOAPIC for interrupt routing
>> [    8.448173] PCI: Using host bridge windows from ACPI; if necessary,
>> use "pci=nocrs" and report a bug
>> [    8.468051] PCI: Using E820 reservations for host bridge windows
>> [    8.562534] ACPI: Enabled 2 GPEs in block 00 to 0F
>> [    9.153432] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
>> [    9.166585] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments
>> MSI HPX-Type3]
>> [    9.168452] acpi PNP0A03:00: _OSC: not requesting OS control; OS
>> requires [ExtendedConfig ASPM ClockPM MSI]
>> [    9.181933] acpi PNP0A03:00: fail to add MMCONFIG information, can't
>> access extended configuration space under this bridge
>> [    9.297562] acpiphp: Slot [2] registered
>> ...
>> [    9.369007] PCI host bridge to bus 0000:00
>> [    9.376590] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7
>> window]
>> [    9.379987] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff
>> window]
>> [    9.383826] pci_bus 0000:00: root bus resource [mem
>> 0x000a0000-0x000bffff window]
>> [    9.387818] pci_bus 0000:00: root bus resource [mem
>> 0x10000000-0xfebfffff window]
>> [    9.393681] pci_bus 0000:00: root bus resource [mem
>> 0x100000000-0x17fffffff window]
>> [    9.396987] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    9.414378] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
>> conventional PCI endpoint
>> [    9.477179] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
>> conventional PCI endpoint
>> [    9.494836] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
>> conventional PCI endpoint
>> [    9.527173] pci 0000:00:01.1: BAR 4 [io  0xc040-0xc04f]
>> Segmentation fault
>>
>>
>> So it breaks somewhere in PCI init, after SMP/CPUs has been inited
>> by the guest kernel.
>>
>> Thread 21 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555e2e9c0 in section_covers_addr (section=0x7fff58307,
>> addr=182591488) at ../system/physmem.c:309
>> 309         return int128_gethi(section->size) ||
>> (gdb) p *section
>> Cannot access memory at address 0x7fff58307
>>
>> This one has been seen multiple times.
>>
>> Thread 53 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x7ffe8a7fc6c0 (LWP 104067)]
>> 0x0000555555e30382 in memory_region_section_get_iotlb
>> (cpu=0x5555584e0a90, section=0x7fff58c3eac0) at
>>                ../system/physmem.c:1002
>> 1002        return section - d->map.sections;
>> d is NULL here
>>
>>
>> Thread 22 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x7fff0bfff6c0 (LWP 57595)]
>> 0x0000555555e42c9a in memory_region_get_iommu (mr=0xffffffc1ffffffc1) at
>> include/exec/memory.h:1756
>> 1756        if (mr->alias) {
>> (gdb) p *mr
>> Cannot access memory at address 0xffffffc1ffffffc1
>> (gdb) frame 1
>> #1  0x0000555555e42cb9 in memory_region_get_iommu (mr=0x7fff54239a10) at
>> include/exec/memory.h:1757
>> 1757            return memory_region_get_iommu(mr->alias);
>> (gdb) p mr
>> $1 = (MemoryRegion *) 0x7fff54239a10
>>
>>
>> [    9.222531] pci 0000:00:02.0: BAR 0 [mem 0xfebc0000-0xfebdffff]
>> [
>> Thread 54 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x7ffebeffd6c0 (LWP 14977)]
>>
>> (gdb) l
>> 1004    /* Called from RCU critical section */
>> 1005    hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>> 1006                                           MemoryRegionSection
>> *section)
>> 1007    {
>> 1008        AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
>> 1009        return section - d->map.sections;
>> 1010    }
>> 1011
>> 1012    static int subpage_register(subpage_t *mmio, uint32_t start,
>> uint32_t end,
>> 1013                                uint16_t section);
>>
>> (gdb) p *section
>> $1 = {size = 4940204083636081308795136, mr = 0x7fff98739760, fv =
>> 0x7fff998f6fd0,
>>     offset_within_region = 0, offset_within_address_space = 0, readonly =
>> false,
>>     nonvolatile = false, unmergeable = 12}
>>
>> (gdb) p *section->fv
>> $2 = {rcu = {next = 0x0, func = 0x20281}, ref = 2555275280, ranges =
>> 0x7fff99486a60, nr = 0,
>>     nr_allocated = 0, dispatch = 0x0, root = 0xffffffc1ffffffc1}
>>
>> (gdb) bt
>> #0  0x0000555555e5118c in memory_region_section_get_iotlb
>> (cpu=cpu@entry=0x55555894fdf0,
>>       section=section@entry=0x7fff984e6810) at system/physmem.c:1009
>> #1  0x0000555555e6e07a in tlb_set_page_full (cpu=cpu@entry=0x55555894fdf0,
>>       mmu_idx=mmu_idx@entry=6, addr=addr@entry=151134208,
>> full=full@entry=0x7ffebeffbd60)
>>       at accel/tcg/cputlb.c:1088
>> #2  0x0000555555e70a92 in tlb_set_page_with_attrs
>> (cpu=cpu@entry=0x55555894fdf0,
>>       addr=addr@entry=151134208, paddr=paddr@entry=151134208, attrs=...,
>> prot=<optimized out>,
>>       mmu_idx=mmu_idx@entry=6, size=4096) at accel/tcg/cputlb.c:1193
>> #3  0x0000555555d4ae44 in x86_cpu_tlb_fill (cs=0x55555894fdf0,
>> addr=151138272,
>>       size=<optimized out>, access_type=MMU_DATA_STORE, mmu_idx=6,
>> probe=<optimized out>,
>>       retaddr=0) at target/i386/tcg/system/excp_helper.c:624
>> #4  0x0000555555e6e8cf in tlb_fill_align (cpu=0x55555894fdf0,
>> addr=151138272,
>>       type=MMU_DATA_LOAD, type@entry=MMU_DATA_STORE, mmu_idx=6,
>> memop=memop@entry=MO_8,
>>       size=-1739692016, size@entry=151138272, probe=true, ra=0) at accel/
>> tcg/cputlb.c:1251
>> #5  0x0000555555e6eb0d in probe_access_internal
>> (cpu=cpu@entry=0x55555894fdf0,
>>       addr=addr@entry=151138272, fault_size=fault_size@entry=0,
>>       access_type=access_type@entry=MMU_DATA_STORE, mmu_idx=<optimized out>,
>>       nonfault=nonfault@entry=true, phost=0x7ffebeffc0a8,
>> pfull=0x7ffebeffbfa0, retaddr=0,
>>       check_mem_cbs=false) at accel/tcg/cputlb.c:1371
>> #6  0x0000555555e70c84 in probe_access_full_mmu (env=0x5555589529b0,
>> addr=addr@entry=151138272,
>>       size=size@entry=0, access_type=access_type@entry=MMU_DATA_STORE,
>> mmu_idx=<optimized out>,
>>       phost=phost@entry=0x7ffebeffc0a8, pfull=0x7ffebeffbfa0) at accel/
>> tcg/cputlb.c:1439
>> #7  0x0000555555d497c9 in ptw_translate (inout=0x7ffebeffc090,
>> addr=151138272)
>>       at target/i386/tcg/system/excp_helper.c:68
>> #8  0x0000555555d49988 in mmu_translate (env=env@entry=0x5555589529b0,
>>       in=in@entry=0x7ffebeffc140, out=out@entry=0x7ffebeffc110,
>> err=err@entry=0x7ffebeffc120,
>>       ra=ra@entry=0) at target/i386/tcg/system/excp_helper.c:198
>> #9  0x0000555555d4aece in get_physical_address (env=0x5555589529b0,
>> addr=18446741874686299840,
>>       access_type=MMU_DATA_LOAD, mmu_idx=4, out=0x7ffebeffc110,
>> err=0x7ffebeffc120, ra=0)
>>       at target/i386/tcg/system/excp_helper.c:597
>> #10 x86_cpu_tlb_fill (cs=0x55555894fdf0, addr=18446741874686299840,
>> size=<optimized out>,
>>       access_type=MMU_DATA_LOAD, mmu_idx=4, probe=<optimized out>,
>> retaddr=0)
>>       at target/i386/tcg/system/excp_helper.c:617
>> #11 0x0000555555e6e8cf in tlb_fill_align (cpu=0x55555894fdf0,
>> addr=18446741874686299840,
>>       type=type@entry=MMU_DATA_LOAD, mmu_idx=4, memop=MO_8,
>> memop@entry=MO_32, size=-1739692016,
>>       size@entry=3776, probe=false, ra=0) at accel/tcg/cputlb.c:1251
>> #12 0x0000555555e6ed4d in mmu_lookup1 (cpu=cpu@entry=0x55555894fdf0,
>>       data=data@entry=0x7ffebeffc310, memop=memop@entry=MO_32,
>> mmu_idx=mmu_idx@entry=4,
>>       access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at
>> accel/tcg/cputlb.c:1652
>> #13 0x0000555555e6eea5 in mmu_lookup (cpu=cpu@entry=0x55555894fdf0,
>>       addr=addr@entry=18446741874686299840, oi=oi@entry=36, ra=ra@entry=0,
>>       type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffebeffc310) at accel/
>> tcg/cputlb.c:1755
>> #14 0x0000555555e6f2f3 in do_ld4_mmu (cpu=cpu@entry=0x55555894fdf0,
>>       addr=addr@entry=18446741874686299840, oi=oi@entry=36, ra=ra@entry=0,
>>       access_type=access_type@entry=MMU_DATA_LOAD) at accel/tcg/
>> cputlb.c:2364
>> #15 0x0000555555e71dba in cpu_ldl_mmu (env=0x5555589529b0,
>> addr=18446741874686299840, oi=36,
>>       ra=0) at accel/tcg/ldst_common.c.inc:165
>> #16 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555589529b0,
>> addr=addr@entry=18446741874686299840,
>>       mmu_idx=<optimized out>, ra=ra@entry=0) at accel/tcg/
>> ldst_common.c.inc:308
>> #17 0x0000555555db72da in do_interrupt64 (env=0x5555589529b0, intno=236,
>> is_int=0, error_code=0,
>>       next_eip=<optimized out>, is_hw=0) at target/i386/tcg/seg_helper.c:954
>> #18 do_interrupt_all (cpu=cpu@entry=0x55555894fdf0, intno=236,
>> is_int=is_int@entry=0,
>>       error_code=error_code@entry=0, next_eip=next_eip@entry=0,
>> is_hw=is_hw@entry=1)
>>       at target/i386/tcg/seg_helper.c:1213
>> #19 0x0000555555db884a in do_interrupt_x86_hardirq
>> (env=env@entry=0x5555589529b0,
>>       intno=<optimized out>, is_hw=is_hw@entry=1) at target/i386/tcg/
>> seg_helper.c:1245
>> #20 0x0000555555d4f06f in x86_cpu_exec_interrupt (cs=0x55555894fdf0,
>>       interrupt_request=<optimized out>) at target/i386/tcg/system/
>> seg_helper.c:209
>> #21 0x0000555555e660ed in cpu_handle_interrupt (cpu=0x55555894fdf0,
>> last_tb=<synthetic pointer>)
>>       at accel/tcg/cpu-exec.c:851
>> #22 cpu_exec_loop (cpu=cpu@entry=0x55555894fdf0,
>> sc=sc@entry=0x7ffebeffc580)
>>       at accel/tcg/cpu-exec.c:955
>> #23 0x0000555555e663f1 in cpu_exec_setjmp (cpu=cpu@entry=0x55555894fdf0,
>>       sc=sc@entry=0x7ffebeffc580) at accel/tcg/cpu-exec.c:1033
>>       type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffebeffc310) at accel/
>> tcg/cputlb.c:1755
>> #14 0x0000555555e6f2f3 in do_ld4_mmu (cpu=cpu@entry=0x55555894fdf0,
>>       addr=addr@entry=18446741874686299840, oi=oi@entry=36, ra=ra@entry=0,
>>       access_type=access_type@entry=MMU_DATA_LOAD) at accel/tcg/
>> cputlb.c:2364
>> #15 0x0000555555e71dba in cpu_ldl_mmu (env=0x5555589529b0,
>> addr=18446741874686299840, oi=36,
>>       ra=0) at accel/tcg/ldst_common.c.inc:165
>> #16 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555589529b0,
>> addr=addr@entry=18446741874686299840,
>>       mmu_idx=<optimized out>, ra=ra@entry=0) at accel/tcg/
>> ldst_common.c.inc:308
>> #17 0x0000555555db72da in do_interrupt64 (env=0x5555589529b0, intno=236,
>> is_int=0, error_code=0,
>>       next_eip=<optimized out>, is_hw=0) at target/i386/tcg/seg_helper.c:954
>> #18 do_interrupt_all (cpu=cpu@entry=0x55555894fdf0, intno=236,
>> is_int=is_int@entry=0,
>>       error_code=error_code@entry=0, next_eip=next_eip@entry=0,
>> is_hw=is_hw@entry=1)
>>       at target/i386/tcg/seg_helper.c:1213
>> #19 0x0000555555db884a in do_interrupt_x86_hardirq
>> (env=env@entry=0x5555589529b0,
>>       intno=<optimized out>, is_hw=is_hw@entry=1) at target/i386/tcg/
>> seg_helper.c:1245
>> #20 0x0000555555d4f06f in x86_cpu_exec_interrupt (cs=0x55555894fdf0,
>>       interrupt_request=<optimized out>) at target/i386/tcg/system/
>> seg_helper.c:209
>> #21 0x0000555555e660ed in cpu_handle_interrupt (cpu=0x55555894fdf0,
>> last_tb=<synthetic pointer>)
>>       at accel/tcg/cpu-exec.c:851
>> #22 cpu_exec_loop (cpu=cpu@entry=0x55555894fdf0,
>> sc=sc@entry=0x7ffebeffc580)
>>       at accel/tcg/cpu-exec.c:955
>> #23 0x0000555555e663f1 in cpu_exec_setjmp (cpu=cpu@entry=0x55555894fdf0,
>>       sc=sc@entry=0x7ffebeffc580) at accel/tcg/cpu-exec.c:1033
>> --Type <RET> for more, q to quit, c to continue without paging--
>> #24 0x0000555555e66a5d in cpu_exec (cpu=cpu@entry=0x55555894fdf0) at
>> accel/tcg/cpu-exec.c:1059
>> #25 0x0000555555d2bdc7 in tcg_cpu_exec (cpu=cpu@entry=0x55555894fdf0)
>>       at accel/tcg/tcg-accel-ops.c:80
>> #26 0x0000555555d2c1c3 in mttcg_cpu_thread_fn
>> (arg=arg@entry=0x55555894fdf0)
>>       at accel/tcg/tcg-accel-ops-mttcg.c:94
>> #27 0x0000555556056d90 in qemu_thread_start (args=0x5555589cdba0) at
>> util/qemu-thread-posix.c:541
>> #28 0x00007ffff60e0b7b in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #29 0x00007ffff615e7b8 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>>
>>
>> qemu-system-x86_64: ./include/exec/ram_addr.h:91: ramblock_ptr:
>> Assertion `offset_in_ramblock(block, offset)' failed.
>>
>> (gdb) bt
>> #0  0x00007ffff6076507 in abort () from /lib/x86_64-linux-gnu/libc.so.6
>> #1  0x00007ffff6076420 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #2  0x0000555555a047fa in ramblock_ptr (offset=281471527758833,
>> block=<optimized out>)
>>       at ./include/exec/ram_addr.h:91
>> #3  0x0000555555a04c83 in ramblock_ptr (block=<optimized out>,
>> offset=<optimized out>)
>>       at system/physmem.c:2238
>> #4  qemu_ram_ptr_length (lock=false, is_write=true, block=<optimized
>> out>, addr=<optimized out>,
>>       size=0x0) at system/physmem.c:2430
>> #5  qemu_map_ram_ptr (ram_block=<optimized out>, addr=<optimized out>)
>> at system/physmem.c:2443
>> #6  0x0000555555e4af6b in memory_region_get_ram_ptr (mr=<optimized out>)
>> at system/memory.c:2452
>> #7  0x0000555555e6e024 in tlb_set_page_full (cpu=cpu@entry=0x5555589f9f50,
>>       mmu_idx=mmu_idx@entry=4, addr=addr@entry=18446741874686296064,
>>       full=full@entry=0x7ffebd7f90b0) at accel/tcg/cputlb.c:1065
>> #8  0x0000555555e70a92 in tlb_set_page_with_attrs
>> (cpu=cpu@entry=0x5555589f9f50,
>>       addr=addr@entry=18446741874686296064, paddr=paddr@entry=206749696,
>> attrs=...,
>>       prot=<optimized out>, mmu_idx=mmu_idx@entry=4, size=4096) at accel/
>> tcg/cputlb.c:1193
>> #9  0x0000555555d4ae44 in x86_cpu_tlb_fill (cs=0x5555589f9f50,
>> addr=18446741874686299840,
>>       size=<optimized out>, access_type=MMU_DATA_LOAD, mmu_idx=4,
>> probe=<optimized out>, retaddr=0)
>>       at target/i386/tcg/system/excp_helper.c:624
>> #10 0x0000555555e6e8cf in tlb_fill_align (cpu=0x5555589f9f50,
>> addr=18446741874686299840,
>>       type=type@entry=MMU_DATA_LOAD, mmu_idx=4, memop=MO_8,
>> memop@entry=MO_32, size=-1115714056,
>>       size@entry=3776, probe=false, ra=0) at accel/tcg/cputlb.c:1251
>> #11 0x0000555555e6ed4d in mmu_lookup1 (cpu=cpu@entry=0x5555589f9f50,
>>       data=data@entry=0x7ffebd7f9310, memop=memop@entry=MO_32,
>> mmu_idx=mmu_idx@entry=4,
>>       access_type=access_type@entry=MMU_DATA_LOAD, ra=ra@entry=0) at
>> accel/tcg/cputlb.c:1652
>> #12 0x0000555555e6eea5 in mmu_lookup (cpu=cpu@entry=0x5555589f9f50,
>>       addr=addr@entry=18446741874686299840, oi=oi@entry=36, ra=ra@entry=0,
>>       type=type@entry=MMU_DATA_LOAD, l=l@entry=0x7ffebd7f9310) at accel/
>> tcg/cputlb.c:1755
>> #13 0x0000555555e6f2f3 in do_ld4_mmu (cpu=cpu@entry=0x5555589f9f50,
>>       addr=addr@entry=18446741874686299840, oi=oi@entry=36, ra=ra@entry=0,
>>       access_type=access_type@entry=MMU_DATA_LOAD) at accel/tcg/
>> cputlb.c:2364
>> #14 0x0000555555e71dba in cpu_ldl_mmu (env=0x5555589fcb10,
>> addr=18446741874686299840, oi=36,
>>       ra=0) at accel/tcg/ldst_common.c.inc:165
>> #15 cpu_ldl_le_mmuidx_ra (env=env@entry=0x5555589fcb10,
>> addr=addr@entry=18446741874686299840,
>>       mmu_idx=<optimized out>, ra=ra@entry=0) at accel/tcg/
>> ldst_common.c.inc:308
>> #16 0x0000555555db72da in do_interrupt64 (env=0x5555589fcb10, intno=236,
>> is_int=0, error_code=0,
>>       next_eip=<optimized out>, is_hw=0) at target/i386/tcg/seg_helper.c:954
>> #17 do_interrupt_all (cpu=cpu@entry=0x5555589f9f50, intno=236,
>> is_int=is_int@entry=0,
>>       error_code=error_code@entry=0, next_eip=next_eip@entry=0,
>> is_hw=is_hw@entry=1)
>>       at target/i386/tcg/seg_helper.c:1213
>> #18 0x0000555555db884a in do_interrupt_x86_hardirq
>> (env=env@entry=0x5555589fcb10,
>>       intno=<optimized out>, is_hw=is_hw@entry=1) at target/i386/tcg/
>> seg_helper.c:1245
>> #19 0x0000555555d4f06f in x86_cpu_exec_interrupt (cs=0x5555589f9f50,
>>       interrupt_request=<optimized out>) at target/i386/tcg/system/
>> seg_helper.c:209
>> #20 0x0000555555e660ed in cpu_handle_interrupt (cpu=0x5555589f9f50,
>> last_tb=<synthetic pointer>)
>>       at accel/tcg/cpu-exec.c:851
>> #21 cpu_exec_loop (cpu=cpu@entry=0x5555589f9f50,
>> sc=sc@entry=0x7ffebd7f9580)
>>       at accel/tcg/cpu-exec.c:955
>> #22 0x0000555555e663f1 in cpu_exec_setjmp (cpu=cpu@entry=0x5555589f9f50,
>>       sc=sc@entry=0x7ffebd7f9580) at accel/tcg/cpu-exec.c:1033
>> #23 0x0000555555e66a5d in cpu_exec (cpu=cpu@entry=0x5555589f9f50) at
>> accel/tcg/cpu-exec.c:1059
>> #24 0x0000555555d2bdc7 in tcg_cpu_exec (cpu=cpu@entry=0x5555589f9f50)
>>       at accel/tcg/tcg-accel-ops.c:80
>> #25 0x0000555555d2c1c3 in mttcg_cpu_thread_fn
>> (arg=arg@entry=0x5555589f9f50)
>>       at accel/tcg/tcg-accel-ops-mttcg.c:94
>> #26 0x0000555556056d90 in qemu_thread_start (args=0x55555856bf60) at
>> util/qemu-thread-posix.c:541
>> #27 0x00007ffff60e0b7b in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>> #28 0x00007ffff615e7b8 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
>>
>> (gdb) frame 2
>> #2  0x0000555555a047fa in ramblock_ptr (offset=281471527758833,
>> block=<optimized out>)
>>       at ./include/exec/ram_addr.h:91
>> 91          assert(offset_in_ramblock(block, offset));
>>
>> (gdb) l
>> 86          return (b && b->host && offset < b->used_length) ? true :
>> false;
>> 87      }
>> 88
>> 89      static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t
>> offset)
>> 90      {
>> 91          assert(offset_in_ramblock(block, offset));
>> 92          return (char *)block->host + offset;
>> 93      }
>> 94
>> 95      static inline unsigned long int ramblock_recv_bitmap_offset(void
>> *host_addr,
>>
>>
>> [    9.439487] pci 0000:00:02.0: BAR 1 [io  0xc000-0xc03f]
>>
>> Thread 65 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> [Switching to Thread 0x7ffe9cff96c0 (LWP 15472)]
>> phys_page_find (d=d@entry=0x7fff905ec880, addr=addr@entry=111288320) at
>> system/physmem.c:337
>> 337         if (section_covers_addr(&sections[lp.ptr], addr)) {
>> (gdb) l
>> 332             }
>> 333             p = nodes[lp.ptr];
>> 334             lp = p[(index >> (i * P_L2_BITS)) & (P_L2_SIZE - 1)];
>> 335         }
>> 336
>> 337         if (section_covers_addr(&sections[lp.ptr], addr)) {
>> 338             return &sections[lp.ptr];
>> 339         } else {
>> 340             return &sections[PHYS_SECTION_UNASSIGNED];
>> 341         }
>> (gdb)
>>
>>
>> I was doing a bisection between 9.2.0 and 10.0.0, since we observed
>> this issue happening wiht 10.0 but not - with 9.2.  So some of the
>> above failures might be somewhere from the middle between 9.2 and
>> 10.0.  However, I was able to trigger some of the failures with
>> 9.2.0, though with much less probability.  And some can be triggered
>> in current master too, with much better probability.
>>
>> On my 4-core notebook, the above command line fails every 20..50 run.
>>
>> I was never able to reproduce the assertion failure as shown in !1921.
>>
>> As of now, this issue is hitting debian trixie, - in debci, when a
>> package which creates a guest image tries to run qemu but in the
>> debci environment there's no kvm available, so it resorts to tcg.
>>
>> On IRC, Manos Pitsidianakis noted that he was debugging use-after-free
>> with MemoryRegion recently, and posted a patch which can help a bit:
>> https://people.linaro.org/~manos.pitsidianakis/backtrace.diff
>>
>> I'm not sure where to go from here.
>>
>> Just collecting everything we have now.
>>
>> Thanks,
>>
>> /mjt
>>
> 

looks like a good target for TSAN, which might expose the race without 
really having to trigger it.
https://www.qemu.org/docs/master/devel/testing/main.html#building-and-testing-with-tsan

Else, you can reproduce your run using rr record -h (chaos mode) [1], 
which randomly schedules threads, until it catches the segfault, and 
then you'll have a reproducible case to debug.

[1] https://github.com/rr-debugger/rr

Regards,
Pierrick

