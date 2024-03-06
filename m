Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E1CC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 02:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgg9-0004iq-KA; Tue, 05 Mar 2024 21:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgg8-0004ii-HC
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:06:44 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgg5-0005Iu-F7
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 21:06:44 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7d130979108so3449914241.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 18:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709690800; x=1710295600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyR8PObAyGC0ZZugWj2pxEMXVKgbD6ai1+gsSKnuYg8=;
 b=GwhkPvC23R204d7+MKxwFhAcnX4wFNoFh1qQIOWzLsMVkQO4v6BjItaXz6K2WOZZCX
 XIz2K1zgPZp2brTgHCYbvYVRvacyhUYpcbCOZuHf+SiNhtn5vNjGt5WxtWdOtpUaVyOP
 FIIJlcqDfotLJgDHZ5zAsonD9QHzT0oFX47PjAGIvPcMJMjsvpzckf+nkaixRzjh/FgX
 dmVFZRD5kxyKxFkNOt6iLNzqDYDNYJlVtg2o4DPYPFWJtaPgKZXDrNRs5j96osJqstoN
 fKtta4KNXxP0MXJrq4dV1L4DtkfRGn1ij7pxoe/jeNaODhM4AGcAPEUHV8Ltk/t0FE0D
 zU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709690800; x=1710295600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyR8PObAyGC0ZZugWj2pxEMXVKgbD6ai1+gsSKnuYg8=;
 b=mrHWRl92IUW1OZ6gHBuyfdSZ5V42FFnsUPVgFc82Tk8wUoyLSHkZ7r5Opp96X5Etm9
 VVrGHolBT4uV4RF0hFhR+hLCpnkU0mhjunt0xwTLdhYjgbi1ZdeRammXfppi3JVzXdW0
 bA8EGXXF3EuRWxVuA1WHyj+gbFRtjKMjrxg9nkqs5/sbqzSXoc8iIzevV6W5APTnTPZE
 oAxINGNVZMdtSPxYzOsLEkg/DUy1+OuT0jyzFcQr3HdtPT6E9Qg+HB/AyO3Tm43K8xLi
 sNDktHbfFeSt37+LsvpyEFqvf5WorshcqHVMqFVFuaT4ipMD3X8iuzTpkGjwrHxTXwJJ
 ohaQ==
X-Gm-Message-State: AOJu0YzlJip0cc1bzWfC/q2/m9xS5o9MT/+MQZg/g41NED1rO+nw4syq
 n2FqKQreuzdwoTjb3578Vpl8GQ3UQjiUqdXwnonLD7fN5a5d6Gf9jh9Bh1NHlQ/FvCH1swuXGF7
 5exM/xLle9qZlaykN5pGWuZxotn+SgK4k4h0=
X-Google-Smtp-Source: AGHT+IHAm7uIGu+WJ7yhdMrIMFbb+4M3axgLLKHE6tEknzTH9g3XwNJquqEAoirAVnG7GPK+LgiUrh/vARyhuWyDNX4=
X-Received: by 2002:a05:6122:4c86:b0:4d3:499a:830c with SMTP id
 fg6-20020a0561224c8600b004d3499a830cmr3500429vkb.13.1709690800125; Tue, 05
 Mar 2024 18:06:40 -0800 (PST)
MIME-Version: 1.0
References: <PH7PR11MB8551419922FD4495F89B9655FB592@PH7PR11MB8551.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB8551419922FD4495F89B9655FB592@PH7PR11MB8551.namprd11.prod.outlook.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 12:06:14 +1000
Message-ID: <CAKmqyKO3FpTu-t0o8rLKvjW77aA0j2CSNvDV=oGF7h+RjUopGQ@mail.gmail.com>
Subject: Re: Qemu sdhci-pci device can't be recognized by Linux kernel
To: "Li, Yong" <yong.li@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:19=E2=80=AFAM Li, Yong <yong.li@intel.com> wrote=
:
>
> Hello,
>
> QEMU virt platform of RISCV-64 can emulate the mmc device by using below =
parameters:
> -device sdhci-pci,sd-spec-version=3D3 \
> -drive if=3Dnone,file=3Ddisk.img,format=3Draw,id=3DMMC1 \
> -device sd-card,drive=3DMMC1
>
> And as to u-boot, it do can recognize the mmc device and load the linux k=
ernel from the sdcard partition.
> But the mmc device can't be recognized by the linux kernel so that the ro=
ot filesystem in the sdcard can't be loaded.
>
> The logs are as below, any thoughts ? Thanks
>
>
> Starting kernel ...
>
> [    0.000000] Linux version 6.7.0-rc3-g2bb52284d571-dirty (intel@intel-O=
ptiPlex-7090) (riscv64-linux-gnu-gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0, G=
NU ld (GNU Binutils for Ubuntu) 2.34) #11 SMP Tue Feb 27 16:04:26 CST 2024
> [    0.000000] random: crng init done
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] SBI specification v1.0 detected
> [    0.000000] SBI implementation ID=3D0x1 Version=3D0x10003
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] earlycon: ns16550a0 at MMIO 0x0000000010000000 (options ''=
)
> [    0.000000] printk: legacy bootconsole [ns16550a0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] OF: reserved mem: 0x0000000080000000..0x000000008003ffff (=
256 KiB) nomap non-reusable mmode_resv1@80000000
> [    0.000000] OF: reserved mem: 0x0000000080040000..0x000000008005ffff (=
128 KiB) nomap non-reusable mmode_resv0@80040000
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x000000008005ffff]
> [    0.000000]   node   0: [mem 0x0000000080060000-0x000000017fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000017ff=
fffff]
> [    0.000000] SBI HSM extension detected
> [    0.000000] CPU with hartid=3D1 is not available
> [    0.000000] Falling back to deprecated "riscv,isa"
> [    0.000000] riscv: base ISA extensions acdfhim
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 20 pages/cpu s41976 r8192 d31752 u81920
> [    0.000000] Kernel command line: root=3D/dev/vda1 ro earlycon console=
=3DttyS0,115200n8
> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 419430=
4 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 =
bytes, linear)
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 103=
2192
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] software IO TLB: area num 1.
> [    0.000000] software IO TLB: mapped [mem 0x00000000faec6000-0x00000000=
feec6000] (64MB)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0xff1bfffffea00000 - 0xff1bffffff000000   (=
6144 kB)
> [    0.000000]       pci io : 0xff1bffffff000000 - 0xff1c000000000000   (=
  16 MB)
> [    0.000000]      vmemmap : 0xff1c000000000000 - 0xff20000000000000   (=
1024 TB)
> [    0.000000]      vmalloc : 0xff20000000000000 - 0xff60000000000000   (=
16384 TB)
> [    0.000000]      modules : 0xffffffff01589000 - 0xffffffff80000000   (=
2026 MB)
> [    0.000000]       lowmem : 0xff60000000000000 - 0xff60000100000000   (=
4096 MB)
> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (=
2047 MB)
> [    0.000000] Memory: 4016708K/4194304K available (9472K kernel code, 49=
86K rwdata, 4096K rodata, 2222K init, 502K bss, 177596K reserved, 0K cma-re=
served)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_=
ids=3D1.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D1
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped using AIA
> [    0.000000] riscv-imsic: imsics@28000000: invalid cpuid for parent irq=
1
> [    0.000000] riscv-imsic: imsics@28000000: providing IPIs using interru=
pt 1
> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on content=
ion.
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff m=
ax_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
> [    0.000084] sched_clock: 64 bits at 10MHz, resolution 100ns, wraps eve=
ry 4398046511100ns
> [    0.000338] riscv-timer: Timer interrupt in S-mode is available via ss=
tc extension
> [    0.005139] Console: colour dummy device 80x25
> [    0.008888] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 20.00 BogoMIPS (lpj=3D40000)
> [    0.009171] pid_max: default: 32768 minimum: 301
> [    0.010237] LSM: initializing lsm=3Dcapability,integrity
> [    0.014518] Mount-cache hash table entries: 8192 (order: 4, 65536 byte=
s, linear)
> [    0.014778] Mountpoint-cache hash table entries: 8192 (order: 4, 65536=
 bytes, linear)
> [    0.033936] CPU node for /cpus/cpu@1 exist but the possible cpu range =
is :0
> [    0.044500] RCU Tasks Trace: Setting shift to 0 and lim to 1 rcu_task_=
cb_adjust=3D1.
> [    0.045051] riscv: ELF compat mode supported
> [    0.045275] ASID allocator using 16 bits (65536 entries)
> [    0.046454] rcu: Hierarchical SRCU implementation.
> [    0.046577] rcu:     Max phase no-delay instances is 1000.
> [    0.048704] EFI services will not be available.
> [    0.050031] smp: Bringing up secondary CPUs ...
> [    0.051095] smp: Brought up 1 node, 1 CPU
> [    0.063329] devtmpfs: initialized
> [    0.074382] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    0.074689] futex hash table entries: 256 (order: 2, 16384 bytes, line=
ar)
> [    0.076688] pinctrl core: initialized pinctrl subsystem
> [    0.080864] sse: Missing SBI SSE extension
> [    0.082410] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.090488] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic alloc=
ations
> [    0.091007] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for at=
omic allocations
> [    0.091370] audit: initializing netlink subsys (disabled)
> [    0.094571] thermal_sys: Registered thermal governor 'step_wise'
> [    0.095183] audit: type=3D2000 audit(0.084:1): state=3Dinitialized aud=
it_enabled=3D0 res=3D1
> [    0.095906] cpuidle: using governor menu
> [    0.120192] cpu0: Ratio of byte access time to unaligned word access i=
s 7.30, unaligned accesses are fast
> [    0.121054] riscv-rpxy: SBI RPXY extension detected
> [    0.143014] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> [    0.143168] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    0.147680] ACPI: Interpreter disabled.
> [    0.148204] iommu: Default domain type: Translated
> [    0.148299] iommu: DMA domain TLB invalidation policy: strict mode
> [    0.150202] SCSI subsystem initialized
> [    0.152031] usbcore: registered new interface driver usbfs
> [    0.152332] usbcore: registered new interface driver hub
> [    0.152545] usbcore: registered new device driver usb
> [    0.154011] Advanced Linux Sound Architecture Driver Initialized.
> [    0.164653] vgaarb: loaded
> [    0.168952] clocksource: Switched to clocksource riscv_clocksource
> [    0.170805] pnp: PnP ACPI: disabled
> [    0.187515] NET: Registered PF_INET protocol family
> [    0.188635] IP idents hash table entries: 65536 (order: 7, 524288 byte=
s, linear)
> [    0.196372] tcp_listen_portaddr_hash hash table entries: 2048 (order: =
4, 65536 bytes, linear)
> [    0.196668] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
> [    0.196857] TCP established hash table entries: 32768 (order: 6, 26214=
4 bytes, linear)
> [    0.197276] TCP bind hash table entries: 32768 (order: 9, 2097152 byte=
s, linear)
> [    0.201318] TCP: Hash tables configured (established 32768 bind 32768)
> [    0.202392] UDP hash table entries: 2048 (order: 5, 196608 bytes, line=
ar)
> [    0.202904] UDP-Lite hash table entries: 2048 (order: 5, 196608 bytes,=
 linear)
> [    0.204091] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.206864] RPC: Registered named UNIX socket transport module.
> [    0.207015] RPC: Registered udp transport module.
> [    0.207090] RPC: Registered tcp transport module.
> [    0.207181] RPC: Registered tcp-with-tls transport module.
> [    0.207256] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.207489] PCI: CLS 0 bytes, default 64
> [    0.213042] workingset: timestamp_bits=3D46 max_order=3D20 bucket_orde=
r=3D0
> [    0.214484] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.216473] NFS: Registering the id_resolver key type
> [    0.217281] Key type id_resolver registered
> [    0.217377] Key type id_legacy registered
> [    0.217680] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
..
> [    0.217865] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regi=
stering...
> [    0.218602] 9p: Installing v9fs 9p2000 file system support
> [    0.221381] NET: Registered PF_ALG protocol family
> [    0.221731] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 244)
> [    0.221978] io scheduler mq-deadline registered
> [    0.222128] io scheduler kyber registered
> [    0.222306] io scheduler bfq registered
> [    0.224296] riscv-imsic: imsics@28000000: hart-index-bits: 0,  guest-i=
ndex-bits: 0
> [    0.224426] riscv-imsic: imsics@28000000: group-index-bits: 1, group-i=
ndex-shift: 24
> [    0.224566] riscv-imsic: imsics@28000000: per-CPU IDs 255 at base PPN =
0x0000000028000000
> [    0.224711] riscv-imsic: imsics@28000000: total 254 interrupts availab=
le
> [    0.227558] pci-host-generic 30000000.pci: host bridge /soc/pci@300000=
00 ranges:
> [    0.228230] pci-host-generic 30000000.pci:       IO 0x0003000000..0x00=
0300ffff -> 0x0000000000
> [    0.228676] pci-host-generic 30000000.pci:      MEM 0x0040000000..0x00=
7fffffff -> 0x0040000000
> [    0.228857] pci-host-generic 30000000.pci:      MEM 0x0400000000..0x07=
ffffffff -> 0x0400000000
> [    0.229362] pci-host-generic 30000000.pci: Memory resource size exceed=
s max for 32 bits
> [    0.229814] pci-host-generic 30000000.pci: ECAM at [mem 0x30000000-0x3=
fffffff] for [bus 00-ff]
> [    0.232176] pci-host-generic 30000000.pci: PCI host bridge to bus 0000=
:00
> [    0.232487] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.232634] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> [    0.232765] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7ffff=
fff]
> [    0.232899] pci_bus 0000:00: root bus resource [mem 0x400000000-0x7fff=
fffff]
> [    0.234091] pci 0000:00:00.0: [1b36:0008] type 00 class 0x060000
> [    0.236786] pci 0000:00:01.0: [1b36:0007] type 00 class 0x080501
> [    0.237291] pci 0000:00:01.0: reg 0x10: [mem 0x40000000-0x400000ff]
> [    0.239022] pci 0000:00:02.0: [1af4:1000] type 00 class 0x020000
> [    0.239705] pci 0000:00:02.0: reg 0x10: [io  0x1000-0x101f]
> [    0.240324] pci 0000:00:02.0: reg 0x14: [mem 0x40001000-0x40001fff]
> [    0.242455] pci 0000:00:02.0: reg 0x20: [mem 0x40004000-0x40007fff 64b=
it pref]
> [    0.243046] pci 0000:00:02.0: reg 0x30: [mem 0x40040000-0x4007ffff pre=
f]
> [    0.245209] pci 0000:00:02.0: BAR 6: assigned [mem 0x40000000-0x4003ff=
ff pref]
> [    0.245492] pci 0000:00:02.0: BAR 4: assigned [mem 0x400000000-0x40000=
3fff 64bit pref]
> [    0.245989] pci 0000:00:02.0: BAR 1: assigned [mem 0x40040000-0x40040f=
ff]
> [    0.246294] pci 0000:00:01.0: BAR 0: assigned [mem 0x40041000-0x400410=
ff]
> [    0.246655] pci 0000:00:02.0: BAR 0: assigned [io  0x0020-0x003f]
> [    0.252094] clk-sbi-rpxy soc:sbi-rpxy-clk: RPMI Clock Service Group Pr=
obe Failed
> [    0.255411] irq: no irq domain found for aplic@d008000 !
> [    0.338181] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.347886] SuperH (H)SCI(F) driver initialized
> [    0.363037] loop: module loaded
> [    0.373271] genirq: irq_chip IMSIC-PCI did not update eff. affinity ma=
sk of irq 11
> [    0.378037] e1000e: Intel(R) PRO/1000 Network Driver
> [    0.378140] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    0.380675] usbcore: registered new interface driver uas
> [    0.380903] usbcore: registered new interface driver usb-storage
> [    0.381666] mousedev: PS/2 mouse device common for all mice
> [    0.384073] sdhci: Secure Digital Host Controller Interface driver
> [    0.384182] sdhci: Copyright(c) Pierre Ossman
> [    0.384361] sdhci-pltfm: SDHCI platform and OF driver helper
> [    0.385528] usbcore: registered new interface driver usbhid
> [    0.385646] usbhid: USB HID core driver
> [    0.386192] riscv-pmu-sbi: SBI PMU extension is available
> [    0.386646] riscv-pmu-sbi: 16 firmware and 18 hardware counters
> [    0.386789] riscv-pmu-sbi: Perf sampling/filtering is not supported as=
 sscof extension is not available
> [    0.387628] irq: no irq domain found for aplic@d008000 !
> [    0.387809] sdhci-pci 0000:00:01.0: SDHCI controller found [1b36:0007]=
 (rev 0)
> [    0.417829] mmc0: Failed to request IRQ 0: -22
> [    0.421338] sdhci-pci: probe of 0000:00:01.0 failed with error -22

It seems like interrupts aren't getting set up correctly.

You could try a different interrupt controller. It looks like you are
using the aplic, you could try the aplic-imsic maybe [1]?

Otherwise having a look at the kernel driver and trying to figure out
what is failing is probably the best bet.

1: https://www.qemu.org/docs/master/system/riscv/virt.html

Alistair

>
>
> Thanks,
> Yong Li
>
>

