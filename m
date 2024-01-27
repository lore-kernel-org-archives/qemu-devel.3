Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F01C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 19:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTo65-00076L-TS; Sat, 27 Jan 2024 14:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rTo5z-000760-Dx; Sat, 27 Jan 2024 14:12:03 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rTo5x-0005Gr-5D; Sat, 27 Jan 2024 14:12:03 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-59a2f28ea59so39744eaf.2; 
 Sat, 27 Jan 2024 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706382718; x=1706987518; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=peiO/kJX4daBXJe+AQREwFu4kiAYkIpVzu3PvN0udrU=;
 b=muYSIAoVGZpUTZVMpOEwj6FSp+FQEaNkP3012SD63HlT0lTYEy1wbWUZH4qzATYWrq
 UqXipr5mhSD1fxGuMaW48sQTzkCcniNX8SW9pqekI3ND0Ob3Z9n6dmEcyCaHH2dNZLhE
 2XMmI2E2Hy2EDaqcx8O/CTV22BXBR3WNHMxU8O0z0aJtoOzVTb6U8gtFX2asSGf4Kz/B
 roKlN1Fi+PR9MhRJ6e1HNZXq4oZTOWFRNyymxkW9Z+bcXAFHCftcdBRZCzc1On34uej0
 nMu2ij0mFyx0KL25jcGE2d7rUUp1Gxb8O9z/f6Hu7lyQpYbgXF+TceWimwtbUM+VP/xT
 9fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706382718; x=1706987518;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=peiO/kJX4daBXJe+AQREwFu4kiAYkIpVzu3PvN0udrU=;
 b=Pj33hGbpKLNaDrJKN53AclBJP/bwsknVWVh7d8GZWZwFe5OQvJEYBCgLxeYmzZ+4fs
 WxEQmir3dtzjiGrGKI1fRgEQ1dX+1JInnOuH2/BB9nDzXv9wupNRgtPnmmaAl1rKu3Wa
 pUhansoxgPdASy/rLC7IvW+7sE3HwIvowJp+0MIVX6fft4wj/WniTMtIOoiJMfGPunXA
 ZpRqKSrQ2a5nGFFa62SIxl2X3MaRRrdCm3j4IcFSYr64R1nfK2oAo0ofiOi8N6HrQJCX
 D47UOveDmK9wvoD79tl4nQzU08omsuHdf2yvJXkvQzYTfqqUw/3HuD6ga1zhgiU77Mzj
 2NBA==
X-Gm-Message-State: AOJu0YxAZp+ijpYES7I0NM1hr7GUhpJq8+EPVnjLkxk1/xlJnNj3DvM6
 0YZMy6dMDYialhsYJ4TZh/3IPL7IsT7wFn2C+v22Tj+cWdvmJEaI
X-Google-Smtp-Source: AGHT+IFJpnvjtP0uRl/QtoztDjaZ3KG3afOC3k0m25fx6kTYujgEkHVWtSkQv6ViMb197y+LXmhGHQ==
X-Received: by 2002:a05:6358:725:b0:176:8a8e:213c with SMTP id
 e37-20020a056358072500b001768a8e213cmr1604074rwj.3.1706382718132; 
 Sat, 27 Jan 2024 11:11:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 bz11-20020a056a02060b00b005cdad153d84sm2609443pgb.90.2024.01.27.11.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 11:11:57 -0800 (PST)
Date: Sat, 27 Jan 2024 11:11:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v2] hw/arm: add PCIe to Freescale i.MX6
Message-ID: <9ee6eee8-2135-48f3-99a3-d572699fa4f7@roeck-us.net>
References: <20240108140325.1291-1-n.ostrenkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108140325.1291-1-n.ostrenkov@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=groeck7@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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

Hi,

On Mon, Jan 08, 2024 at 02:03:25PM +0000, Nikita Ostrenkov wrote:
> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---

This patch, with the "sabrelite" emulation and the Linux upstream kernel
(v6.8-rc1, using imx_v6_v7_defconfig), results in:

qemu-system-arm: ../system/memory.c:2750: memory_region_set_alias_offset: Assertion `mr->alias' failed.

with the backtrace below. Any idea what might be wrong ?

Thanks,
Guenter

---
#0  __pthread_kill_implementation (no_tid=0, signo=6, threadid=140737237087808) at ./nptl/pthread_kill.c:44
#1  __pthread_kill_internal (signo=6, threadid=140737237087808) at ./nptl/pthread_kill.c:78
#2  __GI___pthread_kill (threadid=140737237087808, signo=signo@entry=6) at ./nptl/pthread_kill.c:89
#3  0x00007ffff6242476 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#4  0x00007ffff62287f3 in __GI_abort () at ./stdlib/abort.c:79
#5  0x00007ffff622871b in __assert_fail_base
    (fmt=0x7ffff63dd130 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=0x5555565712bd "mr->alias", file=0x555556570da4 "../system/memory.c", line=2750, function=<optimized out>)
    at ./assert/assert.c:92
#6  0x00007ffff6239e96 in __GI___assert_fail
    (assertion=0x5555565712bd "mr->alias", file=0x555556570da4 "../system/memory.c", line=2750, function=0x555556571bf0 <__PRETTY_FUNCTION__.8> "memory_region_set_alias_offset")
    at ./assert/assert.c:101
#7  0x00005555560192ce in memory_region_set_alias_offset (mr=0x555557a77ce0, offset=286326784) at ../system/memory.c:2750
#8  0x0000555555b8bc9f in designware_pcie_update_viewport (root=0x555557a74d50, viewport=0x555557a77bc0) at ../hw/pci-host/designware.c:280
#9  0x0000555555b8c06d in designware_pcie_root_config_write (d=0x555557a74d50, address=2312, val=0, len=4) at ../hw/pci-host/designware.c:375
#10 0x0000555555b78488 in pci_host_config_write_common (pci_dev=0x555557a74d50, addr=2312, limit=4096, val=0, len=4) at ../hw/pci/pci_host.c:96
#11 0x0000555555b8c7ee in designware_pcie_host_mmio_write (opaque=0x555557a746c0, addr=2312, val=0, size=4) at ../hw/pci-host/designware.c:635
#12 0x0000555556012388 in memory_region_write_accessor (mr=0x555557a780a0, addr=2312, value=0x7ffff105a628, size=4, shift=0, mask=4294967295, attrs=...) at ../system/memory.c:497
#13 0x00005555560126c1 in access_with_adjusted_size
     (addr=2312, value=0x7ffff105a628, size=4, access_size_min=4, access_size_max=4, access_fn=0x55555601228e <memory_region_write_accessor>, mr=0x555557a780a0, attrs=...) at ../system/memory.c:573
#14 0x00005555560159cd in memory_region_dispatch_write (mr=0x555557a780a0, addr=2312, data=0, op=MO_32, attrs=...) at ../system/memory.c:1521
#15 0x000055555607351f in int_st_mmio_leN (cpu=0x555557a47150, full=0x7fffe841fe80, val_le=0, addr=3500312840, size=4, mmu_idx=7, ra=140734908258821, mr=0x555557a780a0, mr_offset=2312)
    at ../accel/tcg/cputlb.c:2545
#16 0x0000555556073697 in do_st_mmio_leN (cpu=0x555557a47150, full=0x7fffe841fe80, val_le=0, addr=3500312840, size=4, mmu_idx=7, ra=140734908258821) at ../accel/tcg/cputlb.c:2581
#17 0x0000555556073f14 in do_st_4 (cpu=0x555557a47150, p=0x7ffff105a7c0, val=0, mmu_idx=7, memop=1282, ra=140734908258821) at ../accel/tcg/cputlb.c:2758
#18 0x00005555560742d7 in do_st4_mmu (cpu=0x555557a47150, addr=3500312840, val=0, oi=20519, ra=140734908258821) at ../accel/tcg/cputlb.c:2834
#19 0x0000555556074df3 in helper_stl_mmu (env=0x555557a49910, addr=3500312840, val=0, oi=20519, retaddr=140734908258821) at ../accel/tcg/ldst_common.c.inc:100
#20 0x00007fff6636da46 in code_gen_buffer ()
#21 0x00005555560587e8 in cpu_tb_exec (cpu=0x555557a47150, itb=0x7fffa636d900, tb_exit=0x7ffff105adf0) at ../accel/tcg/cpu-exec.c:458
#22 0x0000555556059565 in cpu_loop_exec_tb (cpu=0x555557a47150, tb=0x7fffa636d900, pc=3230581304, last_tb=0x7ffff105ae00, tb_exit=0x7ffff105adf0) at ../accel/tcg/cpu-exec.c:920
#23 0x00005555560598da in cpu_exec_loop (cpu=0x555557a47150, sc=0x7ffff105ae80) at ../accel/tcg/cpu-exec.c:1041
#24 0x00005555560599ab in cpu_exec_setjmp (cpu=0x555557a47150, sc=0x7ffff105ae80) at ../accel/tcg/cpu-exec.c:1058
#25 0x0000555556059a47 in cpu_exec (cpu=0x555557a47150) at ../accel/tcg/cpu-exec.c:1084
#26 0x00005555560838c2 in tcg_cpus_exec (cpu=0x555557a47150) at ../accel/tcg/tcg-accel-ops.c:76
#27 0x000055555608403d in mttcg_cpu_thread_fn (arg=0x555557a47150) at ../accel/tcg/tcg-accel-ops-mttcg.c:95
#28 0x00005555562b32d7 in qemu_thread_start (args=0x555557c06360) at ../util/qemu-thread-posix.c:541
#29 0x00007ffff6294ac3 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
#30 0x00007ffff6326850 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

