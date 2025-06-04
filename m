Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F02C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 10:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMleY-0008Ph-UV; Wed, 04 Jun 2025 06:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uMleW-0008PD-6I
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:47:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uMleS-0008MN-Bl
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 06:47:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BC11E128360
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 13:47:06 +0300 (MSK)
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE2A321E925
 for <qemu-devel@nongnu.org>; Wed,  4 Jun 2025 13:47:16 +0300 (MSK)
Message-ID: <a4602427-7a12-4661-8d55-51698faf39d3@tls.msk.ru>
Date: Wed, 4 Jun 2025 13:47:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent race condition in mttcg memory handling
From: Michael Tokarev <mjt@tls.msk.ru>
To: QEMU Development <qemu-devel@nongnu.org>
References: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
Content-Language: en-US, ru-RU
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsFNBGYpLkcBEACsajkUXU2lngbm6RyZuCljo19q/XjZTMikctzMoJnBGVSmFV66kylUghxs
 HDQQF2YZJbnhSVt/mP6+V7gG6MKR5gYXYxLmypgu2lJdqelrtGf1XtMrobG6kuKFiD8OqV6l
 2M5iyOZT3ydIFOUX0WB/B9Lz9WcQ6zYO9Ohm92tiWWORCqhAnwZy4ua/nMZW3RgO7bM6GZKt
 /SFIorK9rVqzv40D6KNnSyeWfqf4WN3EvEOozMfWrXbEqA7kvd6ShjJoe1FzCEQ71Fj9dQHL
 DZG+44QXvN650DqEtQ4RW9ozFk3Du9u8lbrXC5cqaCIO4dx4E3zxIddqf6xFfu4Oa5cotCM6
 /4dgxDoF9udvmC36qYta+zuDsnAXrYSrut5RBb0moez/AR8HD/cs/dS360CLMrl67dpmA+XD
 7KKF+6g0RH46CD4cbj9c2egfoBOc+N5XYyr+6ejzeZNf40yjMZ9SFLrcWp4yQ7cpLsSz08lk
 a0RBKTpNWJdblviPQaLW5gair3tyJR+J1ER1UWRmKErm+Uq0VgLDBDQoFd9eqfJjCwuWZECp
 z2JUO+zBuGoKDzrDIZH2ErdcPx3oSlVC2VYOk6H4cH1CWr9Ri8i91ClivRAyVTbs67ha295B
 y4XnxIVaZU+jJzNgLvrXrkI1fTg4FJSQfN4W5BLCxT4sq8BDtwARAQABzSBNaWNoYWVsIFRv
 a2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLBlAQTAQoAPhYhBJ2L4U4/Kp3XkZko8WGtPZjs3yyO
 BQJmKS5HAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGGtPZjs3yyOZSAP
 /ibilK1gbHqEI2zR2J59Dc0tjtbByVmQ8IMh0SYU3j1jeUoku2UCgdnGKpwvLXtwZINgdl6Q
 cEaDBRX6drHLJFAi/sdgwVgdnDxaWVJO/ZIN/uJI0Tx7+FSAk8CWSa4IWUOzPNmtrDfb4z6v
 G36rppY8bTNKbX6nWFXuv2LXQr7g6+kKnbwv4QFpD+UFF1CrLm3byMq4ikdBXpZx030qBL61
 b7PrfXcBLao0357kWGH6C2Zu4wBnDUJwGi68pI5rzSRAFyAQsE89sjLdR1yFoBH8NiFnAQXP
 LA8Am9FMsC7D/bi/kwKTJdcZvzdGU1HG6tJvXLWC+nqGpJNBzRdDpjqtxNuL76vVd/JbsFMS
 JchLN+01fNQ5FHglvkd6md7vO+ULq+r9An5hMiDoRbYVUOBN8uiYNk+qKbdgSfbhsgPURqHi
 1bXkgMeMasqWbGMe7iBW/YH2ePfZ6HuKLNQDCkiWZYPQZvyXHvQHjuJJ5+US81tkqM+Q6Snq
 0L/O/LD0qLlbinHrcx0abg06VXBoYmGICJpf/3hhWQM4f+B/5w4vpl8q0B6Osz01pBUBfYak
 CiYCNHMWWVZkW9ZnY7FWiiPOu8iE1s5oPYqBljk3FNUk04SDKMF5TxL87I2nMBnVnvp0ZAuY
 k9ojiLqlhaKnZ1+zwmwmPmXzFSwlyMczPUMSzsFNBGYpLkcBEAC0mxV2j5M1x7GiXqxNVyWy
 OnlWqJkbkoyMlWFSErf+RUYlC9qVGwUihgsgEhQMg0nJiSISmU3vsNEx5j0T13pTEyWXWBdS
 XtZpNEW1lZ2DptoGg+6unpvxd2wn+dqzJqlpr4AY3vc95q4Za/NptWtSCsyJebZ7DxCCkzET
 tzbbnCjW1souCETrMy+G916w1gJkz4V1jLlRMEEoJHLrr1XKDdJRk/34AqXPKOzILlWRFK6s
 zOWa80/FNQV5cvjc2eN1HsTMFY5hjG3zOZb60WqwTisJwArjQbWKF49NLHp/6MpiSXIxF/FU
 jcVYrEk9sKHN+pERnLqIjHA8023whDWvJide7f1V9lrVcFt0zRIhZOp0IAE86E3stSJhZRhY
 xyIAx4dpDrw7EURLOhu+IXLeEJbtW89tp2Ydm7TVAt5iqBubpHpGTWV7hwPRQX2w2MBq1hCn
 K5Xx79omukJisbLqG5xUCR1RZBUfBlYnArssIZSOpdJ9wWMK+fl5gn54cs+yziUYU3Tgk0fJ
 t0DzQsgfd2JkxOEzJACjJWti2Gh3szmdgdoPEJH1Og7KeqbOu2mVCJm+2PrNlzCybOZuHOV5
 +vSarkb69qg9nU+4ZGX1m+EFLDqVUt1g0SjY6QmM5yjGBA46G3dwTEV0/u5Wh7idNT0mRg8R
 eP/62iTL55AM6QARAQABwsF8BBgBCgAmFiEEnYvhTj8qndeRmSjxYa09mOzfLI4FAmYpLkcC
 GwwFCRLMAwAACgkQYa09mOzfLI53ag/+ITb3WW9iqvbjDueV1ZHwUXYvebUEyQV7BFofaJbJ
 Sr7ek46iYdV4Jdosvq1FW+mzuzrhT+QzadEfYmLKrQV4EK7oYTyQ5hcch55eX00o+hyBHqM2
 RR/B5HGLYsuyQNv7a08dAUmmi9eAktQ29IfJi+2Y+S1okAEkWFxCUs4EE8YinCrVergB/MG5
 S7lN3XxITIaW00faKbqGtNqij3vNxua7UenN8NHNXTkrCgA+65clqYI3MGwpqkPnXIpTLGl+
 wBI5S540sIjhgrmWB0trjtUNxe9QcTGHoHtLeGX9QV5KgzNKoUNZsyqh++CPXHyvcN3OFJXm
 VUNRs/O3/b1capLdrVu+LPd6Zi7KAyWUqByPkK18+kwNUZvGsAt8WuVQF5telJ6TutfO8xqT
 FUzuTAHE+IaRU8DEnBpqv0LJ4wqqQ2MeEtodT1icXQ/5EDtM7OTH231lJCR5JxXOnWPuG6el
 YPkzzso6HT7rlapB5nulYmplJZSZ4RmE1ATZKf+wUPocDu6N10LtBNbwHWTT5NLtxNJAJAvl
 ojis6H1kRWZE/n5buyPY2NYeyWfjjrerOYt3er55n4C1I88RSCTGeejVmXWuo65QD2epvzE6
 3GgKngeVm7shlp7+d3D3+fAAHTvulQQqV3jOodz+B4yzuZ7WljkNrmrWrH8aI4uA98c=
In-Reply-To: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Here's a typical output with ASan enabled, fwiw:

$ ./qemu-system-x86_64 -smp 16 -m 256 -vga none -display none -kernel 
/boot/vmlinuz-6.12.29-amd64 -append "console=ttyS0" -serial 
file:/dev/tty -monitor stdio -initrd ~/debvm/initrd
==368707==WARNING: ASan doesn't fully support makecontext/swapcontext 
functions and may produce false positives in some cases!
QEMU 10.0.50 monitor - type 'help' for more information
(qemu) [    0.000000] Linux version 6.12.29-amd64 
(debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-14 (Debian 
14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP 
PREEMPT_DYNAMIC Debian 6.12.29-1 (2025-05-18)
[    0.000000] Command line: console=ttyS0
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000000ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000000ffe0000-0x000000000fffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] 
reserved
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] 
reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.000000] DMI: Memory slots populated: 1/1
[    0.000000] tsc: Fast TSC calibration failed
[    0.000000] AGP: No AGP bridge found
[    0.000000] last_pfn = 0xffe0 max_arch_pfn = 0x400000000
[    0.000000] MTRR map: 4 entries (3 fixed + 1 variable; max 19), built 
from 8 variable MTRRs
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- 
WT
[    0.000000] found SMP MP-table at [mem 0x000f5480-0x000f548f]
[    0.000000] RAMDISK: [mem 0x0ffdb000-0x0ffdffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F52A0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000000FFE28F3 000034 (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000000FFE272F 000074 (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000000FFE0040 0026EF (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x000000000FFE0000 000040
[    0.000000] ACPI: APIC 0x000000000FFE27A3 0000F0 (v03 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000000FFE2893 000038 (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: WAET 0x000000000FFE28CB 000028 (v01 BOCHS  BXPC 
00000001 BXPC 00000001)
[    0.000000] ACPI: Reserving FACP table memory at [mem 
0xffe272f-0xffe27a2]
[    0.000000] ACPI: Reserving DSDT table memory at [mem 
0xffe0040-0xffe272e]
[    0.000000] ACPI: Reserving FACS table memory at [mem 
0xffe0000-0xffe003f]
[    0.000000] ACPI: Reserving APIC table memory at [mem 
0xffe27a3-0xffe2892]
[    0.000000] ACPI: Reserving HPET table memory at [mem 
0xffe2893-0xffe28ca]
[    0.000000] ACPI: Reserving WAET table memory at [mem 
0xffe28cb-0xffe28f2]
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000000ffdffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x0ffb0680-0x0ffdafff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000000ffdffff]
[    0.000000]   Normal   empty
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000000ffdffff]
[    0.000000] Initmem setup node 0 [mem 
0x0000000000001000-0x000000000ffdffff]
[    0.000000] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.000000] On node 0, zone DMA: 97 pages in unavailable ranges
[    0.000000] On node 0, zone DMA32: 32 pages in unavailable ranges
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 
0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] CPU topo: Max. logical packages:   1
[    0.000000] CPU topo: Max. logical dies:       1
[    0.000000] CPU topo: Max. dies per package:   1
[    0.000000] CPU topo: Max. threads per core:   1
[    0.000000] CPU topo: Num. cores per package:    16
[    0.000000] CPU topo: Num. threads per package:  16
[    0.000000] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x00000000-0x00000fff]
[    0.000000] PM: hibernation: Registered nosave memory: [mem 
0x0009f000-0x000fffff]
[    0.000000] [mem 0x10000000-0xfffbffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff 
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 
nr_cpu_ids:16 nr_node_ids:1
[    0.000000] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.000000] Kernel command line: console=ttyS0
[    0.000000] Dentry cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.000000] Inode-cache hash table entries: 16384 (order: 5, 131072 
bytes, linear)
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 65406
[    0.000000] Policy zone: DMA32
[    0.000000] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.000000] AGP: Checking aperture...
[    0.000000] AGP: No AGP bridge found
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.000000] ftrace: allocating 45689 entries in 179 pages
[    0.000000] ftrace: allocated 179 pages with 5 groups
[    0.000000] Dynamic Preempt: voluntary
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to 
nr_cpu_ids=16.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.000000] RCU Tasks: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.000000] RCU Tasks Rude: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.000000] RCU Tasks Trace: Setting shift to 4 and lim to 1 
rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
[    0.000000] NR_IRQS: 524544, nr_irqs: 552, preallocated irqs: 16
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on 
contention.
[    0.000000] Console: colour *CGA 80x25
[    0.000000] printk: legacy console [ttyS0] enabled
[    0.000000] ACPI: Core revision 20240827
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 19112604467 ns
[    0.060000] APIC: Switch to symmetric I/O mode setup
[    0.136000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.172000] tsc: Unable to calibrate against PIT
[    0.172000] tsc: using HPET reference calibration
[    0.176000] tsc: Detected 2096.090 MHz processor
[    0.007755] clocksource: tsc-early: mask: 0xffffffffffffffff 
max_cycles: 0x1e36c30ca71, max_idle_ns: 440795294664 ns
[    0.019694] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 4192.18 BogoMIPS (lpj=8384360)
[    0.081754] Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
[    0.083138] Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
[    0.093255] Spectre V1 : Mitigation: usercopy/swapgs barriers and 
__user pointer sanitization
[    0.102414] Spectre V2 : Mitigation: Retpolines
[    0.105952] Spectre V2 : Spectre v2 / SpectreRSB: Filling RSB on 
context switch and VMEXIT
[    0.160434] x86/fpu: x87 FPU will use FXSAVE
[    3.002703] Freeing SMP alternatives memory: 40K
[    3.023274] pid_max: default: 32768 minimum: 301
[    3.122961] LSM: initializing 
lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ipe,ima,evm
[    3.172533] landlock: Up and running.
[    3.173855] Yama: disabled by default; enable with sysctl kernel.yama.*
[    3.269917] AppArmor: AppArmor initialized
[    3.275313] TOMOYO Linux initialized
[    3.305559] LSM support for eBPF active
[    3.381819] Mount-cache hash table entries: 512 (order: 0, 4096 
bytes, linear)
[    3.386196] Mountpoint-cache hash table entries: 512 (order: 0, 4096 
bytes, linear)
[    4.149559] smpboot: CPU0: AMD QEMU Virtual CPU version 2.5+ (family: 
0xf, model: 0x6b, stepping: 0x1)
[    4.326143] Performance Events: PMU not available due to 
virtualization, using software events only.
[    4.358224] signal: max sigframe size: 1440
[    4.378978] rcu: Hierarchical SRCU implementation.
[    4.382048] rcu: 	Max phase no-delay instances is 1000.
[    4.418254] Timer migration: 2 hierarchy levels; 8 children per 
group; 2 crossnode level
[    4.558206] NMI watchdog: Perf NMI watchdog permanently disabled
[    4.603431] smp: Bringing up secondary CPUs ...
[    4.702376] smpboot: x86: Booting SMP configuration:
[    4.703724] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7 
#8  #9 #10 #11 #12 #13 #14 #15
[    0.000000] calibrate_delay_direct() dropping max bogoMips estimate 4 
= 9105957
[    0.000000] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    0.000000] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    0.000000] calibrate_delay_direct() dropping max bogoMips estimate 1 
= 28440919
[    0.000000] calibrate_delay_direct() dropping max bogoMips estimate 3 
= 20962063
[    0.000000] calibrate_delay_direct() dropping max bogoMips estimate 4 
= 11352022
[    0.000000] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    0.000000] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969337] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969337] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969343] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969343] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969348] calibrate_delay_direct() dropping max bogoMips estimate 2 
= 27830974
[    5.969358] calibrate_delay_direct() dropping max bogoMips estimate 3 
= 30234130
[    5.969358] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969358] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969364] calibrate_delay_direct() dropping max bogoMips estimate 1 
= 21780255
[    5.969364] calibrate_delay_direct() dropping min bogoMips estimate 3 
= 7553311
[    5.969364] calibrate_delay_direct() dropping min bogoMips estimate 4 
= 8179132
[    5.969369] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969369] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969374] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969374] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969389] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969389] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969400] calibrate_delay_direct() dropping min bogoMips estimate 1 
= 1631122
[    5.969405] calibrate_delay_direct() dropping min bogoMips estimate 0 
= 8501104
[    5.969410] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969410] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    5.969415] calibrate_delay_direct() dropping max bogoMips estimate 1 
= 9766470
[    5.969415] calibrate_delay_direct() failed to get a good estimate 
for loops_per_jiffy.
[    5.969415] Probably due to long platform interrupts. Consider using 
"lpj=" boot option.
[    7.946795] smp: Brought up 1 node, 16 CPUs
[    7.949559] smpboot: Total of 16 processors activated (36914.04 BogoMIPS)
[    8.167796] Memory: 197656K/261624K available (16384K kernel code, 
2486K rwdata, 11780K rodata, 4148K init, 4956K bss, 54800K reserved, 0K 
cma-reserved)
[    8.433923] devtmpfs: initialized
[    8.547308] x86/mm: Memory block size: 128MB
[    8.751207] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    8.775080] futex hash table entries: 4096 (order: 6, 262144 bytes, 
linear)
[    8.868262] pinctrl core: initialized pinctrl subsystem
[    9.322265] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    9.434496] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic 
allocations
[    9.446267] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA pool for 
atomic allocations
[    9.450210] DMA: preallocated 128 KiB GFP_KERNEL|GFP_DMA32 pool for 
atomic allocations
[    9.455908] audit: initializing netlink subsys (disabled)
[    9.494877] audit: type=2000 audit(1749033951.660:1): 
state=initialized audit_enabled=0 res=1
[    9.622753] thermal_sys: Registered thermal governor 'fair_share'
[    9.623234] thermal_sys: Registered thermal governor 'bang_bang'
[    9.625842] thermal_sys: Registered thermal governor 'step_wise'
[    9.629649] thermal_sys: Registered thermal governor 'user_space'
[    9.633699] thermal_sys: Registered thermal governor 'power_allocator'
[    9.653949] cpuidle: using governor ladder
[    9.661815] cpuidle: using governor menu
[    9.696090] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    9.781559] PCI: Using configuration type 1 for base access
[    9.797961] mtrr: your CPUs had inconsistent fixed MTRR settings
[    9.801893] mtrr: your CPUs had inconsistent variable MTRR settings
[    9.806120] mtrr: your CPUs had inconsistent MTRRdefType settings
[    9.807416] mtrr: probably your BIOS does not setup all CPUs.
[    9.808407] mtrr: corrected configuration.
[    9.858380] kprobes: kprobe jump-optimization is enabled. All kprobes 
are optimized if possible.
[   10.012084] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[   10.013878] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[   10.348768] ACPI: Added _OSI(Module Device)
[   10.349947] ACPI: Added _OSI(Processor Device)
[   10.353682] ACPI: Added _OSI(3.0 _SCP Extensions)
[   10.357664] ACPI: Added _OSI(Processor Aggregator Device)
[   10.678343] ACPI: 1 ACPI AML tables successfully acquired and loaded
[   11.221996] ACPI: Interpreter enabled
[   11.262899] ACPI: PM: (supports S0 S3 S4 S5)
[   11.270094] ACPI: Using IOAPIC for interrupt routing
[   11.290614] PCI: Using host bridge windows from ACPI; if necessary, 
use "pci=nocrs" and report a bug
[   11.302139] PCI: Using E820 reservations for host bridge windows
[   11.353959] ACPI: Enabled 2 GPEs in block 00 to 0F
[   12.252675] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[   12.287708] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments 
MSI HPX-Type3]
[   12.290520] acpi PNP0A03:00: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[   12.326309] acpi PNP0A03:00: fail to add MMCONFIG information, can't 
access extended configuration space under this bridge
[   12.537420] acpiphp: Slot [2] registered
[   12.542702] acpiphp: Slot [3] registered
[   12.546456] acpiphp: Slot [4] registered
[   12.550273] acpiphp: Slot [5] registered
[   12.554307] acpiphp: Slot [6] registered
[   12.558329] acpiphp: Slot [7] registered
[   12.558515] acpiphp: Slot [8] registered
[   12.560865] acpiphp: Slot [9] registered
[   12.561559] acpiphp: Slot [10] registered
[   12.561559] acpiphp: Slot [11] registered
[   12.566400] acpiphp: Slot [12] registered
[   12.574391] acpiphp: Slot [13] registered
[   12.578194] acpiphp: Slot [14] registered
[   12.580588] acpiphp: Slot [15] registered
[   12.586418] acpiphp: Slot [16] registered
[   12.587678] acpiphp: Slot [17] registered
[   12.588808] acpiphp: Slot [18] registered
[   12.594504] acpiphp: Slot [19] registered
[   12.602435] acpiphp: Slot [20] registered
[   12.603927] acpiphp: Slot [21] registered
[   12.606341] acpiphp: Slot [22] registered
[   12.607797] acpiphp: Slot [23] registered
[   12.608969] acpiphp: Slot [24] registered
[   12.609559] acpiphp: Slot [25] registered
[   12.609559] acpiphp: Slot [26] registered
[   12.609559] acpiphp: Slot [27] registered
[   12.610162] acpiphp: Slot [28] registered
[   12.611594] acpiphp: Slot [29] registered
[   12.612960] acpiphp: Slot [30] registered
[   12.614401] acpiphp: Slot [31] registered
[   12.620799] PCI host bridge to bus 0000:00
[   12.630278] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[   12.639483] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[   12.641728] pci_bus 0000:00: root bus resource [mem 
0x000a0000-0x000bffff window]
[   12.644426] pci_bus 0000:00: root bus resource [mem 
0x10000000-0xfebfffff window]
[   12.645559] pci_bus 0000:00: root bus resource [mem 
0x100000000-0x17fffffff window]
[   12.659495] pci_bus 0000:00: root bus resource [bus 00-ff]
[   12.713130] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000 
conventional PCI endpoint
[   12.896856] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100 
conventional PCI endpoint
[   12.920028] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180 
conventional PCI endpoint
[   12.991922] pci 0000:00:01.1: BAR 4 [io  0xc040-0xc04f]
[   13.005559] pci 0000:00:01.1: BAR 0 [io  0x01f0-0x01f7]: legacy IDE quirk
[   13.005559] pci 0000:00:01.1: BAR 1 [io  0x03f6]: legacy IDE quirk
[   13.005559] pci 0000:00:01.1: BAR 2 [io  0x0170-0x0177]: legacy IDE quirk
[   13.013769] pci 0000:00:01.1: BAR 3 [io  0x0376]: legacy IDE quirk
[   13.026884] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000 
conventional PCI endpoint
[   13.045860] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by 
PIIX4 ACPI
[   13.055916] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by 
PIIX4 SMB
[   13.059147] pci 0000:00:01.3: quirk_piix4_acpi+0x0/0x180 took 19531 usecs
[   13.079357] pci 0000:00:02.0: [8086:100e] type 00 class 0x020000 
conventional PCI endpoint
=================================================================
==368707==ERROR: AddressSanitizer: heap-use-after-free on address 
0x6060003d5f80 at pc 0x55ae8aeb437f bp 0x7f96d99f5500 sp 0x7f96d99f54f8
READ of size 8 at 0x6060003d5f80 thread T10
     #0 0x55ae8aeb437e in address_space_lookup_region 
../../home/mjt/qemu/master/system/physmem.c:350
     #1 0x55ae8aeb4648 in address_space_translate_internal 
../../home/mjt/qemu/master/system/physmem.c:374
     #2 0x55ae8aeb65b6 in address_space_translate_for_iotlb 
../../home/mjt/qemu/master/system/physmem.c:698
     #3 0x55ae8b0c938f in tlb_set_page_full 
../../home/mjt/qemu/master/accel/tcg/cputlb.c:1052
     #4 0x55ae8b0ca499 in tlb_set_page_with_attrs 
../../home/mjt/qemu/master/accel/tcg/cputlb.c:1199
     #5 0x55ae8b2370c0 in x86_cpu_tlb_fill 
../../home/mjt/qemu/master/target/i386/tcg/system/excp_helper.c:628
     #6 0x55ae8b0caa74 in tlb_fill_align 
../../home/mjt/qemu/master/accel/tcg/cputlb.c:1257
     #7 0x55ae8b0cfc75 in mmu_lookup1 
../../home/mjt/qemu/master/accel/tcg/cputlb.c:1658
     #8 0x55ae8b0d0534 in mmu_lookup 
../../home/mjt/qemu/master/accel/tcg/cputlb.c:1761
     #9 0x55ae8b0d3a3b in do_ld4_mmu 
../../home/mjt/qemu/master/accel/tcg/cputlb.c:2374
     #10 0x55ae8b0d8ad0 in cpu_ldl_mmu 
../../home/mjt/qemu/master/accel/tcg/ldst_common.c.inc:165
     #11 0x55ae8b3b11d9 in cpu_ldl_le_mmuidx_ra 
/home/mjt/qemu/master/include/accel/tcg/cpu-ldst.h:142
     #12 0x55ae8b3b8373 in do_interrupt64 
../../home/mjt/qemu/master/target/i386/tcg/seg_helper.c:979
     #13 0x55ae8b3ba0bd in do_interrupt_all 
../../home/mjt/qemu/master/target/i386/tcg/seg_helper.c:1238
     #14 0x55ae8b3ba2bf in do_interrupt_x86_hardirq 
../../home/mjt/qemu/master/target/i386/tcg/seg_helper.c:1270
     #15 0x55ae8b245071 in x86_cpu_exec_interrupt 
../../home/mjt/qemu/master/target/i386/tcg/system/seg_helper.c:209
     #16 0x55ae8b0a067c in cpu_handle_interrupt 
../../home/mjt/qemu/master/accel/tcg/cpu-exec.c:821
     #17 0x55ae8b0a15e4 in cpu_exec_loop 
../../home/mjt/qemu/master/accel/tcg/cpu-exec.c:925
     #18 0x55ae8b0a173b in cpu_exec_setjmp 
../../home/mjt/qemu/master/accel/tcg/cpu-exec.c:999
     #19 0x55ae8b0a1905 in cpu_exec 
../../home/mjt/qemu/master/accel/tcg/cpu-exec.c:1025
     #20 0x55ae8b0f0e48 in tcg_cpu_exec 
../../home/mjt/qemu/master/accel/tcg/tcg-accel-ops.c:81
     #21 0x55ae8b0f2b12 in mttcg_cpu_thread_fn 
../../home/mjt/qemu/master/accel/tcg/tcg-accel-ops-mttcg.c:94
     #22 0x55ae8ba9c4d5 in qemu_thread_start 
../../home/mjt/qemu/master/util/qemu-thread-posix.c:541
     #23 0x7f97736c11f4 in start_thread nptl/pthread_create.c:442
     #24 0x7f977374189b in clone3 
../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

0x6060003d5f80 is located 0 bytes inside of 64-byte region 
[0x6060003d5f80,0x6060003d5fc0)
freed by thread T1 here:
     #0 0x7f9774eb76a8 in __interceptor_free 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:52
     #1 0x55ae8aec5bc1 in address_space_dispatch_free 
../../home/mjt/qemu/master/system/physmem.c:2716
     #2 0x55ae8ae92afc in flatview_destroy 
../../home/mjt/qemu/master/system/memory.c:295
     #3 0x55ae8bab996c in call_rcu_thread 
../../home/mjt/qemu/master/util/rcu.c:301
     #4 0x55ae8ba9c4d5 in qemu_thread_start 
../../home/mjt/qemu/master/util/qemu-thread-posix.c:541
     #5 0x7f97736c11f4 in start_thread nptl/pthread_create.c:442

previously allocated by thread T4 here:
     #0 0x7f9774eb83b7 in __interceptor_calloc 
../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:77
     #1 0x7f97746e3670 in g_malloc0 
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5a670)
     #2 0x55ae8ae96bd4 in generate_memory_topology 
../../home/mjt/qemu/master/system/memory.c:758
     #3 0x55ae8ae9ad9b in flatviews_reset 
../../home/mjt/qemu/master/system/memory.c:1074
     #4 0x55ae8ae9b2cf in memory_region_transaction_commit 
../../home/mjt/qemu/master/system/memory.c:1150
     #5 0x55ae8aea612b in memory_region_del_subregion 
../../home/mjt/qemu/master/system/memory.c:2700
     #6 0x55ae8ab3fae5 in pci_update_mappings 
../../home/mjt/qemu/master/hw/pci/pci.c:1717
     #7 0x55ae8ab4044d in pci_default_write_config 
../../home/mjt/qemu/master/hw/pci/pci.c:1790
     #8 0x55ae8a9e5e60 in e1000_write_config 
../../home/mjt/qemu/master/hw/net/e1000.c:1618
     #9 0x55ae8ab4ca87 in pci_host_config_write_common 
../../home/mjt/qemu/master/hw/pci/pci_host.c:96
     #10 0x55ae8ab4cf39 in pci_data_write 
../../home/mjt/qemu/master/hw/pci/pci_host.c:138
     #11 0x55ae8ab4d1cf in pci_host_data_write 
../../home/mjt/qemu/master/hw/pci/pci_host.c:188
     #12 0x55ae8ae94551 in memory_region_write_accessor 
../../home/mjt/qemu/master/system/memory.c:488
     #13 0x55ae8ae94beb in access_with_adjusted_size 
../../home/mjt/qemu/master/system/memory.c:564
     #14 0x55ae8ae9d6aa in memory_region_dispatch_write 
../../home/mjt/qemu/master/system/memory.c:1544
     #15 0x55ae8aecc896 in address_space_stw_internal 
../../home/mjt/qemu/master/system/memory_ldst.c.inc:415
     #16 0x55ae8aeccad7 in address_space_stw 
../../home/mjt/qemu/master/system/memory_ldst.c.inc:446
     #17 0x55ae8b2391a1 in helper_outw 
../../home/mjt/qemu/master/target/i386/tcg/system/misc_helper.c:45
     #18 0x7f96eef65a4d  (/memfd:tcg-jit (deleted)+0x1166a4d)

Thread T10 created by T0 here:
     #0 0x7f9774e49726 in __interceptor_pthread_create 
../../../../src/libsanitizer/asan/asan_interceptors.cpp:207
     #1 0x55ae8ba9c9a7 in qemu_thread_create 
../../home/mjt/qemu/master/util/qemu-thread-posix.c:581
     #2 0x55ae8b0f2f94 in mttcg_start_vcpu_thread 
../../home/mjt/qemu/master/accel/tcg/tcg-accel-ops-mttcg.c:143
     #3 0x55ae8ae7ba65 in qemu_init_vcpu 
../../home/mjt/qemu/master/system/cpus.c:709
     #4 0x55ae8b329362 in x86_cpu_realizefn 
../../home/mjt/qemu/master/target/i386/cpu.c:8865
     #5 0x55ae8b5a621f in device_set_realized 
../../home/mjt/qemu/master/hw/core/qdev.c:494
     #6 0x55ae8b5bd362 in property_set_bool 
../../home/mjt/qemu/master/qom/object.c:2375
     #7 0x55ae8b5b86af in object_property_set 
../../home/mjt/qemu/master/qom/object.c:1450
     #8 0x55ae8b5c22fd in object_property_set_qobject 
../../home/mjt/qemu/master/qom/qom-qobject.c:28
     #9 0x55ae8b5b8c29 in object_property_set_bool 
../../home/mjt/qemu/master/qom/object.c:1520
     #10 0x55ae8b5a50d4 in qdev_realize 
../../home/mjt/qemu/master/hw/core/qdev.c:276
     #11 0x55ae8b26fe3f in x86_cpu_new 
../../home/mjt/qemu/master/hw/i386/x86-common.c:64
     #12 0x55ae8b2701ff in x86_cpus_init 
../../home/mjt/qemu/master/hw/i386/x86-common.c:115
     #13 0x55ae8b267d90 in pc_init1 
../../home/mjt/qemu/master/hw/i386/pc_piix.c:185
     #14 0x55ae8b2695f7 in pc_i440fx_init 
../../home/mjt/qemu/master/hw/i386/pc_piix.c:451
     #15 0x55ae8b2699b3 in pc_i440fx_machine_10_1_init 
../../home/mjt/qemu/master/hw/i386/pc_piix.c:492
     #16 0x55ae8a7fa936 in machine_run_board_init 
../../home/mjt/qemu/master/hw/core/machine.c:1669
     #17 0x55ae8ae6fc53 in qemu_init_board 
../../home/mjt/qemu/master/system/vl.c:2710
     #18 0x55ae8ae7043b in qmp_x_exit_preconfig 
../../home/mjt/qemu/master/system/vl.c:2804
     #19 0x55ae8ae751b3 in qemu_init 
../../home/mjt/qemu/master/system/vl.c:3840
     #20 0x55ae8b8ba5d7 in main ../../home/mjt/qemu/master/system/main.c:71
     #21 0x7f977365f249 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58

Thread T1 created by T0 here:
     #0 0x7f9774e49726 in __interceptor_pthread_create 
../../../../src/libsanitizer/asan/asan_interceptors.cpp:207
     #1 0x55ae8ba9c9a7 in qemu_thread_create 
../../home/mjt/qemu/master/util/qemu-thread-posix.c:581
     #2 0x55ae8baba213 in rcu_init_complete 
../../home/mjt/qemu/master/util/rcu.c:415
     #3 0x55ae8baba42c in rcu_init ../../home/mjt/qemu/master/util/rcu.c:471
     #4 0x7f977365f375 in call_init ../csu/libc-start.c:145
     #5 0x7f977365f375 in __libc_start_main_impl ../csu/libc-start.c:347

Thread T4 created by T0 here:
     #0 0x7f9774e49726 in __interceptor_pthread_create 
../../../../src/libsanitizer/asan/asan_interceptors.cpp:207
     #1 0x55ae8ba9c9a7 in qemu_thread_create 
../../home/mjt/qemu/master/util/qemu-thread-posix.c:581
     #2 0x55ae8b0f2f94 in mttcg_start_vcpu_thread 
../../home/mjt/qemu/master/accel/tcg/tcg-accel-ops-mttcg.c:143
     #3 0x55ae8ae7ba65 in qemu_init_vcpu 
../../home/mjt/qemu/master/system/cpus.c:709
     #4 0x55ae8b329362 in x86_cpu_realizefn 
../../home/mjt/qemu/master/target/i386/cpu.c:8865
     #5 0x55ae8b5a621f in device_set_realized 
../../home/mjt/qemu/master/hw/core/qdev.c:494
     #6 0x55ae8b5bd362 in property_set_bool 
../../home/mjt/qemu/master/qom/object.c:2375
     #7 0x55ae8b5b86af in object_property_set 
../../home/mjt/qemu/master/qom/object.c:1450
     #8 0x55ae8b5c22fd in object_property_set_qobject 
../../home/mjt/qemu/master/qom/qom-qobject.c:28
     #9 0x55ae8b5b8c29 in object_property_set_bool 
../../home/mjt/qemu/master/qom/object.c:1520
     #10 0x55ae8b5a50d4 in qdev_realize 
../../home/mjt/qemu/master/hw/core/qdev.c:276
     #11 0x55ae8b26fe3f in x86_cpu_new 
../../home/mjt/qemu/master/hw/i386/x86-common.c:64
     #12 0x55ae8b2701ff in x86_cpus_init 
../../home/mjt/qemu/master/hw/i386/x86-common.c:115
     #13 0x55ae8b267d90 in pc_init1 
../../home/mjt/qemu/master/hw/i386/pc_piix.c:185
     #14 0x55ae8b2695f7 in pc_i440fx_init 
../../home/mjt/qemu/master/hw/i386/pc_piix.c:451
     #15 0x55ae8b2699b3 in pc_i440fx_machine_10_1_init 
../../home/mjt/qemu/master/hw/i386/pc_piix.c:492
     #16 0x55ae8a7fa936 in machine_run_board_init 
../../home/mjt/qemu/master/hw/core/machine.c:1669
     #17 0x55ae8ae6fc53 in qemu_init_board 
../../home/mjt/qemu/master/system/vl.c:2710
     #18 0x55ae8ae7043b in qmp_x_exit_preconfig 
../../home/mjt/qemu/master/system/vl.c:2804
     #19 0x55ae8ae751b3 in qemu_init 
../../home/mjt/qemu/master/system/vl.c:3840
     #20 0x55ae8b8ba5d7 in main ../../home/mjt/qemu/master/system/main.c:71
     #21 0x7f977365f249 in __libc_start_call_main 
../sysdeps/nptl/libc_start_call_main.h:58

SUMMARY: AddressSanitizer: heap-use-after-free 
../../home/mjt/qemu/master/system/physmem.c:350 in 
address_space_lookup_region
Shadow bytes around the buggy address:
   0x0c0c80072ba0: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fa
   0x0c0c80072bb0: fa fa fa fa fd fd fd fd fd fd fd fd fa fa fa fa
   0x0c0c80072bc0: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
   0x0c0c80072bd0: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
   0x0c0c80072be0: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
=>0x0c0c80072bf0:[fd]fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
   0x0c0c80072c00: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
   0x0c0c80072c10: fa fa fa fa fd fd fd fd fd fd fd fd fa fa fa fa
   0x0c0c80072c20: fd fd fd fd fd fd fd fd fa fa fa fa fd fd fd fd
   0x0c0c80072c30: fd fd fd fd fa fa fa fa fd fd fd fd fd fd fd fd
   0x0c0c80072c40: fa fa fa fa fd fd fd fd fd fd fd fd fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
   Addressable:           00
   Partially addressable: 01 02 03 04 05 06 07
   Heap left redzone:       fa
   Freed heap region:       fd
   Stack left redzone:      f1
   Stack mid redzone:       f2
   Stack right redzone:     f3
   Stack after return:      f5
   Stack use after scope:   f8
   Global redzone:          f9
   Global init order:       f6
   Poisoned by user:        f7
   Container overflow:      fc
   Array cookie:            ac
   Intra object redzone:    bb
   ASan internal:           fe
   Left alloca redzone:     ca
   Right alloca redzone:    cb
==368707==ABORTING


