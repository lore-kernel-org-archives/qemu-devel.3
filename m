Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0FDCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpIa-0008NL-S9; Fri, 31 Oct 2025 09:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpIY-0008N9-2K
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:36:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpIQ-0007pY-5f
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:36:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-474975af41dso16613105e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761917756; x=1762522556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8wYllJX+8Nh3f2EMtEdvCdGmt1PGFxxnD1Isjp5E048=;
 b=d0b77vo+0QNKSxtNUJQoehHWgipkQpxYA/xzoh85Bmr1acavjn+/KxEl7CDiNt/WhU
 +QpPw+XRLn8SxRjZ5wiwpD1S7Y11Iw7DKfzwrmaIgWQ5ZWC2j0zHS3imhrzwZekydS49
 1Nuo5Qyqd9JkwBYmYa+7BMu833g+uObQr70Y5jjrRYP1266alaLkCPy5ils17Idz/YjN
 0Vlf5g1FaQ7t7+wkOa7kMeZIl5ohCL8HR6qDEosRRz0ZxBoHEZWMkjQRuJSLr3VNWA7H
 Wvqm3BVIDpE9pzxP4ynnIBI9KHIsO1FKIbnjt3MngDN9jGpLJ3KB5Ot+AOeXH1yhe3Yx
 oTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761917756; x=1762522556;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8wYllJX+8Nh3f2EMtEdvCdGmt1PGFxxnD1Isjp5E048=;
 b=e3vimQ083LAF5qpTC8/T/TS6eG8RmLiLa5rxr+hjvao0F7NIPPTFTQP6egczXOBb4M
 EAy/Pr9MXBK1pdTQvDS3P+Gj38LHL/MWI6DmZa6uXQTabVSg5KVPw/35h+p9TEbW6rAD
 ppBb7xPZATqrojVlIHj9yNRDk0sN+B34P++w3+HgCd9mneQByruIKCvZ5vQM6CqcKIqd
 uW3fq2bM8zC+F1WtLRQjDKnifsk0KaO8XBMDeDOQKEnnAwUG5jQycTZzOhEjdoWSp3US
 JF2N++Z+JirLq08kKuGtoMY44RGrJks673w1ZnycwYSqmHewBrp1VF/aSmpPNasYzCe7
 smgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHgFYnAxenGLe/PoTktaBPO4PlLUQKuOLJ2SiAhSPDVFP83/WE/2phVD/SQTx0JHaXQT5Bq00pXzOk@nongnu.org
X-Gm-Message-State: AOJu0YwfTH42x6APRTPjEJe/KMv3FElAZW6M/RnN93innHtVTmzICmvh
 rqlZ773cKMJ5ydFMXWVqXMjESYvhCIk8wvVlOhef3YjiYdXkDLecWs0ta//Q2HMGQco=
X-Gm-Gg: ASbGncvQrsC9VBVU4IlGhN86DGAANvIKpz6KVu31v+O+XJnqY4ISixpXjc88Eeik1gf
 J/Xmpr4m2cRptyLzHYiEwOGLmIcuQu49lATxV761e6Q6Xl8mb0erW/tVD+ibxjQqjR2Fcz//PTb
 2e5CdYfyP0FSq41JsaxerEKYrUCFwBrV3xakwUUAveTH1s3CazkSZQaksLc40dTVIgfCb7pts9d
 YtJ1cB8qs2O3sGz/PJ+XpDSjbPjpDnNuvjuApy73mCku9TG33+1xumpCCK3uw1XGrIVxAdnijB0
 xP99tAOQ1S+uxiscbeYhxpUnVPUblSCsGPWH3R1spEp4VBtrfxXl6eocdFTWxMy0V/0FtzWYq4d
 DGfWl0pJpoB4KP8S4R/tCUvtOof52o/h6V4OnesugJECL2UZDkwFnEgPZhVRReUgzOadYQ5fgNM
 CBBoREJsGvj0W7N3DHVKeYWom4r/5tu5DpicltD8BuJGzFX+9eP9yBMuUXAu3S/lcKoQ==
X-Google-Smtp-Source: AGHT+IH0uR6eY7YhQQx+KwvdfYtkGbntN0ACfjQOTd13AGEJ9o/JSbslSCz4p0sy9mn+8LSDAwPnUw==
X-Received: by 2002:a05:600c:4447:b0:475:de68:3c2e with SMTP id
 5b1f17b1804b1-477308b0a80mr31910075e9.40.1761917756070; 
 Fri, 31 Oct 2025 06:35:56 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c10ff20esm3754940f8f.1.2025.10.31.06.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 06:35:55 -0700 (PDT)
Message-ID: <31c80bf4-32d5-49a0-a543-fa4a93b469a7@linaro.org>
Date: Fri, 31 Oct 2025 14:35:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/functional: Mark the MIPS Debian Wheezy tests
 as flaky
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20251031094118.28440-1-philmd@linaro.org>
 <20251031094118.28440-3-philmd@linaro.org>
 <171d963f-9543-4a1d-9852-3ba48e9e7310@redhat.com>
 <507f6a8f-6d1e-4146-b318-db342e870b3b@linaro.org>
In-Reply-To: <507f6a8f-6d1e-4146-b318-db342e870b3b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
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

On 31/10/25 14:30, Philippe Mathieu-Daudé wrote:
> On 31/10/25 12:33, Thomas Huth wrote:
>> On 31/10/2025 10.41, Philippe Mathieu-Daudé wrote:
>>> test_malta.py sometimes times out (likely hang) under GitLab CI:
>>>
>>>    1/57 qemu:func-thorough+func-mips-thorough+thorough / func-mips- 
>>> malta    TIMEOUT   480.11s   killed by signal 15 SIGTERM
>>
>> Do you have an URL from a test job where this happened? I clicked 
>> through a bunch of failed pipelines in the qemu-project, but I only 
>> saw failures of the replay test in recent runs...
> 
> I was thinking of https://gitlab.com/philmd/qemu/-/jobs/11869641060
> 
> ▶  1/21 test_malta.MaltaMachineConsole.test_wheezy                    FAIL
>   1/21 qemu:func-thorough+func-mips64el-thorough+thorough / func- 
> mips64el-malta              ERROR           25.11s   exit status 1
> 
> 2025-10-28 07:06:59,425: [?25l[?1cSearching for RedBoot partition 
> table in physmap-flash.0 at offset 0x1003f0000
> 2025-10-28 07:06:59,602: 7Creating 3 MTD partitions on "physmap-flash.0":
> 2025-10-28 07:06:59,603: 0x000000000000-0x000000100000 : "YAMON"
> 2025-10-28 07:06:59,605: 0x000000100000-0x0000003e0000 : "User FS"
> 2025-10-28 07:06:59,607: 0x0000003e0000-0x000000400000 : "Board Config"
> 2025-10-28 07:06:59,876: [1G[[32m ok [39;49mCPU 0 Unable to handle 
> kernel paging request at virtual address 0000000000000028, epc == 
> ffffffffc00ed234, ra == ffffffffc00ed210

Full console.log FTR (before GitLab artifact is removed):

2025-10-28 07:06:49,741: [    0.000000] Initializing cgroup subsys cpuset
2025-10-28 07:06:49,742: [    0.000000] Initializing cgroup subsys cpu
2025-10-28 07:06:49,742: [    0.000000] Linux version 3.2.0-4-5kc-malta 
(debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-14) ) 
#1 Debian 3.2.51-1
2025-10-28 07:06:49,743: [    0.000000] bootconsole [early0] enabled
2025-10-28 07:06:49,743: [    0.000000] CPU revision is: 000182a0 (MIPS 
20Kc)
2025-10-28 07:06:49,743: [    0.000000] FPU revision is: 000f8200
2025-10-28 07:06:49,744: [    0.000000] Checking for the multiply/shift 
bug... no.
2025-10-28 07:06:49,744: [    0.000000] Checking for the daddiu bug... no.
2025-10-28 07:06:49,745: [    0.000000] Determined physical RAM map:
2025-10-28 07:06:49,746: [    0.000000]  memory: 0000000000001000 @ 
0000000000000000 (reserved)
2025-10-28 07:06:49,746: [    0.000000]  memory: 00000000000ef000 @ 
0000000000001000 (ROM data)
2025-10-28 07:06:49,746: [    0.000000]  memory: 0000000000740000 @ 
00000000000f0000 (reserved)
2025-10-28 07:06:49,747: [    0.000000]  memory: 00000000077d0000 @ 
0000000000830000 (usable)
2025-10-28 07:06:49,748: [    0.000000] Wasting 117376 bytes for 
tracking 2096 unused pages
2025-10-28 07:06:49,750: [    0.000000] Initrd not found or empty - 
disabling initrd
2025-10-28 07:06:49,751: [    0.000000] Zone PFN ranges:
2025-10-28 07:06:49,751: [    0.000000]   DMA      0x00000000 -> 0x00001000
2025-10-28 07:06:49,751: [    0.000000]   Normal   0x00001000 -> 0x00008000
2025-10-28 07:06:49,752: [    0.000000] Movable zone start PFN for each node
2025-10-28 07:06:49,752: [    0.000000] early_node_map[1] active PFN ranges
2025-10-28 07:06:49,752: [    0.000000]     0: 0x00000000 -> 0x00008000
2025-10-28 07:06:49,759: [    0.000000] Built 1 zonelists in Zone order, 
mobility grouping on.  Total pages: 32320
2025-10-28 07:06:49,759: [    0.000000] Kernel command line: 
printk.time=0 console=ttyS0 root=/dev/sda1
2025-10-28 07:06:49,760: PID hash table entries: 512 (order: 0, 4096 bytes)
2025-10-28 07:06:49,761: Dentry cache hash table entries: 16384 (order: 
5, 131072 bytes)
2025-10-28 07:06:49,761: Inode-cache hash table entries: 8192 (order: 4, 
65536 bytes)
2025-10-28 07:06:49,767: Primary instruction cache 32kB, VIVT, 4-way, 
linesize 32 bytes.
2025-10-28 07:06:49,768: Primary data cache 32kB, 4-way, PIPT, no 
aliases, linesize 32 bytes
2025-10-28 07:06:49,773: Enable cache parity protection for MIPS 
20KC/25KF CPUs.
2025-10-28 07:06:49,780: Memory: 120652k/122688k available (4808k kernel 
code, 2036k reserved, 1752k data, 244k init, 0k highmem)
2025-10-28 07:06:49,784: NR_IRQS:256
2025-10-28 07:06:51,727: CPU frequency 320.00 MHz
2025-10-28 07:06:51,737: Console: colour dummy device 80x25
2025-10-28 07:06:51,764: Calibrating delay loop... 635.90 BogoMIPS 
(lpj=1271808)
2025-10-28 07:06:51,764: pid_max: default: 32768 minimum: 301
2025-10-28 07:06:51,765: Security Framework initialized
2025-10-28 07:06:51,767: AppArmor: AppArmor disabled by boot time parameter
2025-10-28 07:06:51,768: Mount-cache hash table entries: 256
2025-10-28 07:06:51,775: Initializing cgroup subsys cpuacct
2025-10-28 07:06:51,776: Initializing cgroup subsys memory
2025-10-28 07:06:51,777: Initializing cgroup subsys devices
2025-10-28 07:06:51,777: Initializing cgroup subsys freezer
2025-10-28 07:06:51,777: Initializing cgroup subsys net_cls
2025-10-28 07:06:51,777: Initializing cgroup subsys blkio
2025-10-28 07:06:51,778: Initializing cgroup subsys perf_event
2025-10-28 07:06:51,779: Checking for the daddi bug... no.
2025-10-28 07:06:51,795: devtmpfs: initialized
2025-10-28 07:06:51,805: print_constraints: dummy:
2025-10-28 07:06:51,807: NET: Registered protocol family 16
2025-10-28 07:06:51,819: bio: create slab <bio-0> at 0
2025-10-28 07:06:51,822: vgaarb: loaded
2025-10-28 07:06:51,824: SCSI subsystem initialized
2025-10-28 07:06:51,830: pci 0000:00:0a.3: address space collision: [io 
0x1100-0x110f] conflicts with GT-64120 PCI I/O [io  0x1000-0x1fffff]
2025-10-28 07:06:51,833: pci 0000:00:0a.3: BAR 14: [io  0x1100-0x110f] 
has bogus alignment
2025-10-28 07:06:51,834: pci 0000:00:12.0: BAR 6: assigned [mem 
0x10000000-0x1003ffff pref]
2025-10-28 07:06:51,834: pci 0000:00:0a.2: BAR 4: assigned [io 
0x1000-0x101f]
2025-10-28 07:06:51,835: pci 0000:00:12.0: BAR 0: assigned [io 
0x1020-0x103f]
2025-10-28 07:06:51,835: pci 0000:00:12.0: BAR 1: assigned [mem 
0x10040000-0x1004001f]
2025-10-28 07:06:51,835: pci 0000:00:0a.1: BAR 4: assigned [io 
0x1040-0x104f]
2025-10-28 07:06:51,841: Switching to clocksource MIPS
2025-10-28 07:06:51,877: NET: Registered protocol family 2
2025-10-28 07:06:51,881: IP route cache hash table entries: 1024 (order: 
1, 8192 bytes)
2025-10-28 07:06:51,885: TCP established hash table entries: 4096 
(order: 4, 65536 bytes)
2025-10-28 07:06:51,885: TCP bind hash table entries: 4096 (order: 3, 
32768 bytes)
2025-10-28 07:06:51,886: TCP: Hash tables configured (established 4096 
bind 4096)
2025-10-28 07:06:51,886: TCP reno registered
2025-10-28 07:06:51,886: UDP hash table entries: 128 (order: 0, 4096 bytes)
2025-10-28 07:06:51,887: UDP-Lite hash table entries: 128 (order: 0, 
4096 bytes)
2025-10-28 07:06:51,889: NET: Registered protocol family 1
2025-10-28 07:06:51,891: RPC: Registered named UNIX socket transport module.
2025-10-28 07:06:51,891: RPC: Registered udp transport module.
2025-10-28 07:06:51,892: RPC: Registered tcp transport module.
2025-10-28 07:06:51,892: RPC: Registered tcp NFSv4.1 backchannel 
transport module.
2025-10-28 07:06:51,893: PCI: Enabling device 0000:00:0a.2 (0000 -> 0001)
2025-10-28 07:06:51,901: audit: initializing netlink socket (disabled)
2025-10-28 07:06:51,902: type=2000 audit(1761635209.160:1): initialized
2025-10-28 07:06:51,905: HugeTLB registered 2 MB page size, 
pre-allocated 0 pages
2025-10-28 07:06:51,908: VFS: Disk quotas dquot_6.5.2
2025-10-28 07:06:51,908: Dquot-cache hash table entries: 512 (order 0, 
4096 bytes)
2025-10-28 07:06:51,912: nfs4filelayout_init: NFSv4 File Layout Driver 
Registering...
2025-10-28 07:06:51,913: msgmni has been set to 235
2025-10-28 07:06:51,921: alg: No test for stdrng (krng)
2025-10-28 07:06:51,921: Block layer SCSI generic (bsg) driver version 
0.4 loaded (major 253)
2025-10-28 07:06:51,922: io scheduler noop registered
2025-10-28 07:06:51,922: io scheduler deadline registered
2025-10-28 07:06:51,923: io scheduler cfq registered (default)
2025-10-28 07:06:51,924: Serial: 8250/16550 driver, 4 ports, IRQ sharing 
enabled
2025-10-28 07:06:51,952: serial8250.0: ttyS0 at I/O 0x3f8 (irq = 4) is a 
16550A
2025-10-28 07:06:51,954: console [ttyS0] enabled, bootconsole disabled
2025-10-28 07:06:51,955: console [ttyS0] enabled, bootconsole disabled
2025-10-28 07:06:51,977: serial8250.0: ttyS1 at I/O 0x2f8 (irq = 3) is a 
16550A
2025-10-28 07:06:52,000: serial8250.0: ttyS2 at MMIO 0x1f000900 (irq = 
18) is a 16550A
2025-10-28 07:06:52,002: PCI: Enabling device 0000:00:0a.1 (0000 -> 0001)
2025-10-28 07:06:52,009: scsi0 : ata_piix
2025-10-28 07:06:52,010: scsi1 : ata_piix
2025-10-28 07:06:52,011: ata1: PATA max UDMA/33 cmd 0x1f0 ctl 0x3f6 
bmdma 0x1040 irq 14
2025-10-28 07:06:52,012: ata2: PATA max UDMA/33 cmd 0x170 ctl 0x376 
bmdma 0x1048 irq 15
2025-10-28 07:06:52,014: pcnet32: pcnet32.c:v1.35 21.Apr.2008 
tsbogend@alpha.franken.de
2025-10-28 07:06:52,019: PCI: Enabling device 0000:00:12.0 (0000 -> 0003)
2025-10-28 07:06:52,021: pcnet32: PCnet/PCI II 79C970A at 0x1020, 
52:54:00:12:34:56 assigned IRQ 11
2025-10-28 07:06:52,023: pcnet32: eth0: registered as PCnet/PCI II 79C970A
2025-10-28 07:06:52,024: pcnet32: 1 cards_found
2025-10-28 07:06:52,026: serio: i8042 KBD port at 0x60,0x64 irq 1
2025-10-28 07:06:52,027: serio: i8042 AUX port at 0x60,0x64 irq 12
2025-10-28 07:06:52,029: mousedev: PS/2 mouse device common for all mice
2025-10-28 07:06:52,033: rtc_cmos rtc_cmos: rtc core: registered 
rtc_cmos as rtc0
2025-10-28 07:06:52,034: rtc0: alarms up to one day, 242 bytes nvram
2025-10-28 07:06:52,035: TCP cubic registered
2025-10-28 07:06:52,035: NET: Registered protocol family 17
2025-10-28 07:06:52,037: Registering the dns_resolver key type
2025-10-28 07:06:52,039: registered taskstats version 1
2025-10-28 07:06:52,040: rtc_cmos rtc_cmos: setting system clock to 
2025-10-28 07:06:51 UTC (1761635211)
2025-10-28 07:06:52,041: Initializing network drop monitor service
2025-10-28 07:06:52,133: input: AT Raw Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input0
2025-10-28 07:06:52,180: ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
2025-10-28 07:06:52,182: ata2.00: configured for UDMA/33
2025-10-28 07:06:52,183: ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
2025-10-28 07:06:52,184: ata1.00: 52428800 sectors, multi 16: LBA48
2025-10-28 07:06:52,186: ata1.00: configured for UDMA/33
2025-10-28 07:06:52,196: scsi 0:0:0:0: Direct-Access     ATA      QEMU 
HARDDISK    2.5+ PQ: 0 ANSI: 5
2025-10-28 07:06:52,201: scsi 1:0:0:0: CD-ROM            QEMU     QEMU 
DVD-ROM     2.5+ PQ: 0 ANSI: 5
2025-10-28 07:06:52,204: sd 0:0:0:0: [sda] 52428800 512-byte logical 
blocks: (26.8 GB/25.0 GiB)
2025-10-28 07:06:52,206: sd 0:0:0:0: [sda] Write Protect is off
2025-10-28 07:06:52,207: sd 0:0:0:0: [sda] Write cache: enabled, read 
cache: enabled, doesn't support DPO or FUA
2025-10-28 07:06:52,219: sda: sda1 sda2 < sda5 >
2025-10-28 07:06:52,226: sd 0:0:0:0: [sda] Attached SCSI disk
2025-10-28 07:06:52,231: EXT4-fs (sda1): couldn't mount as ext3 due to 
feature incompatibilities
2025-10-28 07:06:52,233: EXT4-fs (sda1): couldn't mount as ext2 due to 
feature incompatibilities
2025-10-28 07:06:52,245: EXT4-fs (sda1): mounted filesystem with ordered 
data mode. Opts: (null)
2025-10-28 07:06:52,245: VFS: Mounted root (ext4 filesystem) readonly on 
device 8:1.
2025-10-28 07:06:52,247: Freeing prom memory: 956k freed
2025-10-28 07:06:52,265: Freeing unused kernel memory: 244k freed
2025-10-28 07:06:52,567: INIT: version 2.88 booting
2025-10-28 07:06:53,066: [[36minfo[39;49m] Using makefile-style 
concurrent boot in runlevel S.
2025-10-28 07:06:53,458: findfs: unable to resolve 
'UUID=e21e0e27-e8b7-4aaa-ac5f-fa6a2f558daf'
2025-10-28 07:06:56,285: [....] Starting the hotplug events dispatcher: 
udevd[?25l[?1c7[1G[[32m ok [39;49m8[?25h[?0c.
2025-10-28 07:06:57,684: [....] Synthesizing the initial hotplug 
events...piix4_smbus 0000:00:0a.3: SMBus Host Controller at 0x1100, 
revision 0
2025-10-28 07:06:57,807: sr0: scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
2025-10-28 07:06:57,808: cdrom: Uniform CD-ROM driver Revision: 3.20
2025-10-28 07:06:57,877: physmap platform flash device: 00400000 at 1e000000
2025-10-28 07:06:58,039: usbcore: registered new interface driver usbfs
2025-10-28 07:06:58,040: usbcore: registered new interface driver hub
2025-10-28 07:06:58,042: usbcore: registered new device driver usb
2025-10-28 07:06:58,049: ehci_hcd: USB 2.0 'Enhanced' Host Controller 
(EHCI) Driver
2025-10-28 07:06:58,052: uhci_hcd: USB Universal Host Controller 
Interface driver
2025-10-28 07:06:58,076: uhci_hcd 0000:00:0a.2: UHCI Host Controller
2025-10-28 07:06:58,078: uhci_hcd 0000:00:0a.2: new USB bus registered, 
assigned bus number 1
2025-10-28 07:06:58,104: uhci_hcd 0000:00:0a.2: irq 10, io base 0x00001000
2025-10-28 07:06:58,158: usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0001
2025-10-28 07:06:58,158: usb usb1: New USB device strings: Mfr=3, 
Product=2, SerialNumber=1
2025-10-28 07:06:58,158: usb usb1: Product: UHCI Host Controller
2025-10-28 07:06:58,159: usb usb1: Manufacturer: Linux 3.2.0-4-5kc-malta 
uhci_hcd
2025-10-28 07:06:58,159: usb usb1: SerialNumber: 0000:00:0a.2
2025-10-28 07:06:58,186: hub 1-0:1.0: USB hub found
2025-10-28 07:06:58,206: hub 1-0:1.0: 2 ports detected
2025-10-28 07:06:58,323: physmap-flash.0: Found 1 x32 devices at 0x0 in 
32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
2025-10-28 07:06:58,335: sd 0:0:0:0: Attached scsi generic sg0 type 0
2025-10-28 07:06:58,335: sr 1:0:0:0: Attached scsi generic sg1 type 5
2025-10-28 07:06:58,352: input: ImExPS/2 Generic Explorer Mouse as 
/devices/platform/i8042/serio1/input/input1
2025-10-28 07:06:58,757: Intel/Sharp Extended Query Table at 0x0031
2025-10-28 07:06:58,759: Using buffer write method
2025-10-28 07:06:59,425: [?25l[?1cSearching for RedBoot partition 
table in physmap-flash.0 at offset 0x1003f0000
2025-10-28 07:06:59,602: 7Creating 3 MTD partitions on "physmap-flash.0":
2025-10-28 07:06:59,603: 0x000000000000-0x000000100000 : "YAMON"
2025-10-28 07:06:59,605: 0x000000100000-0x0000003e0000 : "User FS"
2025-10-28 07:06:59,607: 0x0000003e0000-0x000000400000 : "Board Config"
2025-10-28 07:06:59,876: [1G[[32m ok [39;49mCPU 0 Unable to handle 
kernel paging request at virtual address 0000000000000028, epc == 
ffffffffc00ed234, ra == ffffffffc00ed210

> 
> Is it different that the GitLab issue report?
> 
>>
>> Also, does it happen for all mips targets, or only for specific flavors?
> 
> I can't tell so far.
> 
>>
>>   Thomas
>>
> 


