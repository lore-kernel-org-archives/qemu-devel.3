Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B6FCFD63A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTy1-0006fE-8o; Wed, 07 Jan 2026 08:52:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cuiyunhui@bytedance.com>)
 id 1vdO87-0000lv-2W
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:38:55 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cuiyunhui@bytedance.com>)
 id 1vdO82-0000Lu-CS
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:38:54 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-459a258561cso405117b6e.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 23:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1767771526; x=1768376326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PrTDVaGhmCs4Aaj1D9bnz1MnrGGVDBkTwhwy74ACSzA=;
 b=Ru4C+c8ev5MiHEy0ARt0Kr9ovmTt2wd4fI5qtR5fMY96URp0qGS4L+Gd7oOq956Pp8
 OjxAoKqVGotDbTSRL8hY3T/fF1+FrZS10Ea73PtfQRMrcDYqHy4R30H/M6ebpcpxeLxV
 KDts+JuyImck5vRQZWeCcVFDlekhbfdEoZ3FeXZ//bsAzKhKKn8VNatIJ7MVALzPHNhZ
 z9rBXS+DQ09WR0Ucl3kiM3HvsEozxyw3dwhpjsv1K21aqckUbgsl4c1T1nPUzJv/pNYB
 Pit3Za3Bqgjr03O+k0DJnd0EXVDouValiCF718UrKEKtXlI6N0W31Eg0WjDvaJGIQhK6
 Ip4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767771526; x=1768376326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PrTDVaGhmCs4Aaj1D9bnz1MnrGGVDBkTwhwy74ACSzA=;
 b=tSR2Kxq5vvkplbpAJIS9yT0vBnpiAoprULDoHypxr4AVdUC8ooulMV1BX053NbpqBa
 wmZ7PJgEcJxVy1cSI+exwY+fOv3ZRM6wTzob3FDje1flCiLRT5On0p9IfeybvzwZwyk1
 84eTAUJ/m7CkrYSZbdQtmOuNBNyOd6EeR/kxyMRAyeZ6KqWeCa4yaoAhH1Qri4KoOl4d
 OgW58O9+P2DxwHMXvfMgQyvfGgP0eGw/sj1b/YMNCtS5T4ajjGo2tzaoj4AdFcDtdYb4
 w35WdKEN9C0/t8BI5jo3pgI3gQ1LC54YsGK3agm0ToI6SJqaY8jXYnnms/Q0/78Cjx3W
 uJFw==
X-Gm-Message-State: AOJu0Yx1bf5/XHyar84mKfgjj/WqneQ+FLmJQmP7MC47ZiLrmJGTxbG8
 kr3UVhZswH75TQRAiorh3PEDTnsXnTvK9IHEciA9hDcb8mHdY2jkJTBKTPi/lF4iK0add3qetEd
 eLdr8KtghYGcAMurBlLThogsNiKLp9hSBUf+3/e3H9w==
X-Gm-Gg: AY/fxX7SVb5cokjpUkmbLzEdJjnIepSyFKy7HwGxRt06QY2dd1t8yLkoUQq+nPnjwO3
 TrESGIwTZfICcxhDcVugBpIsvlfadQ2lLR9MVo/uBfgAwYMQVUClVmJ7mcjkKHyN4OV1XWFJMqd
 9mbS3ZjVeUksKVAN5Kb6bc+tcVhuzkBSKeB6BVLKYSOsLBKKEWWiIuM6Ynstg13cOE+VkzAuTKR
 vuICx4fTOI29jfVp/Fm1z1jSqG350+HjlTVMcBHkj0TLOPj7fk1s06xGFcYyoCoH8R0nybyqRM2
 Lg==
X-Google-Smtp-Source: AGHT+IEKlF01qnE9rGAWC03SkBk71wolanMtWoHqX/0yuwIKdLFq6pZmXBTrJ5kSLeMaM7yG894uT6uOmDGpWf3dUVw=
X-Received: by 2002:a05:6808:3096:b0:455:eba2:9efa with SMTP id
 5614622812f47-45a6b7371e4mr812668b6e.4.1767771525678; Tue, 06 Jan 2026
 23:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
In-Reply-To: <20260105-riscv-ssqosid-cbqri-v4-0-9ad7671dde78@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 7 Jan 2026 15:38:34 +0800
X-Gm-Features: AQt7F2qTK3rZjh59Qtkvhac4HUpvBw3FtSJL58r8F3k_L6920G893yy8NpkKl_U
Message-ID: <CAEEQ3wkM9h0kJNE4yTtN5ms2JgRBp6b_530KM8irbGKzjMkrgg@mail.gmail.com>
Subject: Re: [External] [PATCH v4 0/6] riscv: implement Ssqosid extension and
 CBQRI controllers
To: Drew Fustini <fustini@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicolas Pitre <npitre@baylibre.com>,
 =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, Atish Patra <atish.patra@linux.dev>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
 Chen Pei <cp0613@linux.alibaba.com>, guo.wenjia23@zte.com.cn,
 liu.qingtao2@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=cuiyunhui@bytedance.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Jan 2026 08:52:50 -0500
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

Hi Drew,

On Tue, Jan 6, 2026 at 5:55=E2=80=AFAM Drew Fustini <fustini@kernel.org> wr=
ote:
>
> This series implements the RISC-V Quality-of-Service Identifiers
> (Ssqosid) extension [1] which adds the srmcfg register. It also
> implements the RISC-V Capacity and Bandwidth Controller QoS Register
> Interface (CBQRI) specification [2]. Quality of Service (QoS) in this
> context is concerned with shared resources on an SoC such as cache
> capacity and memory bandwidth.
>
> Sssqosid srmcfg CSR
> -------------------
> The srmcfg CSR configures a hart with two identifiers:
>
>  - Resource Control ID (RCID)
>  - Monitoring Counter ID (MCID)
>
> These identifiers accompany each request issued by the hart to shared
> resource controllers. This allows the capacity and bandwidth resources
> used by a software workload (e.g. a process or a set of processes) to be
> controlled and monitored.

1. The CBQRI specification does not mandate 64-byte access width for
its registers. Therefore, is it necessary to add a field in the ACPI
RQSC table?
2. In addition, although CBQRI does not require configuring a specific
number of RMIDs for each CLOSID like MPAM does, creating a control
group will by default create a monitoring group. So on RISC-V, the
number of MCIDs should be at least no less than that of RCIDs, right?
3. By the way, for Linux, could you also release a version of the
CBQRI/Ssqosid patchset with ACPI support?

>
> CBQRI controllers
> -----------------
> CBQRI defines operations to configure resource usage limits, in the form
> of capacity or bandwidth, for an RCID. CBQRI also defines operations to
> configure counters to track the resource utilization per MCID.
>
> This series implements an CBQRI capacity controller and an CBQRI
> bandwidth controller which can be configured from the command line:
>
>   $ qemu-system-riscv64 -M virt ... \
>       -device riscv.cbqri.capacity,mmio_base=3D0x04828000[,...] \
>       -device riscv.cbqri.bandwidth,mmio_base=3D0x04829000[,...]
>
> The mmio_base option is mandatory, the others are optional.
>
> As many -device arguments as wanted can be provided as long as their
> mmio regions don't conflict.
>
> To see all possible options:
>
>   $ qemu-system-riscv64 -device riscv.cbqri.capacity,help
>   riscv.cbqri.capacity options:
>     alloc_op_config_limit=3D<bool> -  (default: true)
>     alloc_op_flush_rcid=3D<bool> -  (default: true)
>     alloc_op_read_limit=3D<bool> -  (default: true)
>     at_code=3D<bool>         -  (default: true)
>     at_data=3D<bool>         -  (default: true)
>     max_mcids=3D<uint16>     -  (default: 256)
>     max_rcids=3D<uint16>     -  (default: 64)
>     mmio_base=3D<uint64>     -  (default: 0)
>     mon_evt_id_none=3D<bool> -  (default: true)
>     mon_evt_id_occupancy=3D<bool> -  (default: true)
>     mon_op_config_event=3D<bool> -  (default: true)
>     mon_op_read_counter=3D<bool> -  (default: true)
>     ncblks=3D<uint16>        -  (default: 16)
>     target=3D<str>
>
>   $ qemu-system-riscv64 -device riscv.cbqri.bandwidth,help
>   riscv.cbqri.bandwidth options:
>     alloc_op_config_limit=3D<bool> -  (default: true)
>     alloc_op_read_limit=3D<bool> -  (default: true)
>     at_code=3D<bool>         -  (default: true)
>     at_data=3D<bool>         -  (default: true)
>     max_mcids=3D<uint16>     -  (default: 256)
>     max_rcids=3D<uint16>     -  (default: 64)
>     mmio_base=3D<uint64>     -  (default: 0)
>     mon_evt_id_none=3D<bool> -  (default: true)
>     mon_evt_id_rdonly_count=3D<bool> -  (default: true)
>     mon_evt_id_rdwr_count=3D<bool> -  (default: true)
>     mon_evt_id_wronly_count=3D<bool> -  (default: true)
>     mon_op_config_event=3D<bool> -  (default: true)
>     mon_op_read_counter=3D<bool> -  (default: true)
>     nbwblks=3D<uint16>       -  (default: 1024)
>     target=3D<str>
>
> Boolean options correspond to hardware capabilities that can be disabled
>
> Example SoC for CBQRI
> ---------------------
> An example SoC with the following CBQRI controller configuration can be
> used to test the implementation:
>
>   - L2 cache controllers
>     - Resource type: Capacity
>     - Number of capacity blocks (NCBLKS): 12
>         - In the context of a set-associative cache, the number of
>           capacity blocks can be thought of as the number of ways
>     - Number of access types: 2 (code and data)
>     - Usage monitoring not supported
>     - Capacity allocation operations: CONFIG_LIMIT, READ_LIMIT
>
>   - Last-level cache (LLC) controller
>     - Resource type: Capacity
>     - Number of capacity blocks (NCBLKS): 16
>     - Number of access types: 2 (code and data)
>     - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>     - Event IDs supported: None, Occupancy
>     - Capacity allocation ops: CONFIG_LIMIT, READ_LIMIT, FLUSH_RCID
>
>   - Memory controllers
>     - Resource type: Bandwidth
>     - Number of bandwidth blocks (NBWBLKS): 1024
>        - Bandwidth blocks do not have a unit but instead represent a
>          portion of the total bandwidth resource. For NWBLKS of 1024,
>          each block represents about 0.1% of the bandwidth resource.
>     - Maximum reserved bandwidth blocks (MRBWB): 819 [80% of NBWBLKS]
>     - Number of access types: 1 (no code/data differentiation)
>     - Usage monitoring operations: CONFIG_EVENT, READ_COUNTER
>     - Event IDs supported: None, Total read/write byte count, Total
>                            read byte count, Total write byte count
>     - Bandwidth allocation operations: CONFIG_LIMIT, READ_LIMIT
>
> The memory map used for the example SoC:
>
>   Base addr  Size
>   0x4820000  4KB  Cluster 0 L2 cache controller
>   0x4821000  4KB  Cluster 1 L2 cache controller
>   0x4828000  4KB  Memory controller 0
>   0x4829000  4KB  Memory controller 1
>   0x482a000  4KB  Memory controller 2
>   0x482b000  4KB  Shared LLC cache controller
>
> This configuration is meant to provide a "concrete" example for software
> (like Linux) to test against. It represents just one of many possible
> ways for hardware to implement the CBQRI spec.
>
> The example SoC configuration is created with the following:
>
>   qemu-system-riscv64 \
>         -M virt \
>         -nographic \
>         -smp 8 \
>         -device riscv.cbqri.capacity,max_mcids=3D256,max_rcids=3D64,ncblk=
s=3D12,alloc_op_flush_rcid=3Dfalse,mon_op_config_event=3Dfalse,mon_op_read_=
counter=3Dfalse,mon_evt_id_none=3Dfalse,mon_evt_id_occupancy=3Dfalse,mmio_b=
ase=3D0x04820000 \
>         -device riscv.cbqri.capacity,max_mcids=3D256,max_rcids=3D64,ncblk=
s=3D12,alloc_op_flush_rcid=3Dfalse,mon_op_config_event=3Dfalse,mon_op_read_=
counter=3Dfalse,mon_evt_id_none=3Dfalse,mon_evt_id_occupancy=3Dfalse,mmio_b=
ase=3D0x04821000 \
>         -device riscv.cbqri.capacity,max_mcids=3D256,max_rcids=3D64,ncblk=
s=3D16,mmio_base=3D0x0482B000 \
>         -device riscv.cbqri.bandwidth,max_mcids=3D256,max_rcids=3D64,nbwb=
lks=3D1024,mrbwb=3D819,mmio_base=3D0x04828000 \
>         -device riscv.cbqri.bandwidth,max_mcids=3D256,max_rcids=3D64,nbwb=
lks=3D1024,mrbwb=3D819,mmio_base=3D0x04829000 \
>         -device riscv.cbqri.bandwidth,max_mcids=3D256,max_rcids=3D64,nbwb=
lks=3D1024,mrbwb=3D819,mmio_base=3D0x0482a000
>
> In addition, please note that this series only implements the register
> interface that CBQRI specifies. It does not attempt to emulate the
> performance impact of configuring limits on shared resources like cache
> and memory bandwidth. Similarly, the code does not attempt to emulate
> cache and memory bandwidth utilization, like what would be observed on a
> real hardware system implementing CBQRI.
>
> There is a branch of Linux [3] which adds support for Ssqosid and CBQRI
> along with resctrl integration. I still need to do some more cleanup of
> the code and intend to post the Linux patch series soon.
>
> Open issue:
>  - Support 32-bit operation as the spec states that "CBQRI registers are
>    defined so that software can perform two individual 4 byte accesses."
>    The MemoryRegionOps have .valid.min_access_size =3D 4 but the read and
>    write hooks have assert(size =3D=3D 8). I need to figure out how to
>    correctly handle accesses of size 4.
>
> Despite the open issue above, I am sending out this new revision as I
> believe I have addressed all the other feedback.
>
> Changes since v3:
>  - NOTE: I should have used version v3 for the previous version posted
>    on Nov 19, 2025 given there was already v1/v2 back in 2023. Therefore
>    I am using v4 in this new revision.
>  - Rebase on current master as of Dec 29 (942b0d378a1d) and update
>    include paths for qdev-properties.h and sysbus.h
>  - Add Rb tags from Daniel
>  - Squash the Kconfig and meson.build patches together per Daniel
>  - Use riscv_cpu_cfg() instead of env_archcpu() in check_srmcfg()
>  - Add check for mstateen0.SRMCFG in check_srmcfg()
>  - Increase ISA_EXT_DATA_ENTRY() for ssqosid from PRIV_VERSION_1_12_0
>    to PRIV_VERSION_1_13_0 as it was added in Privileged Arch 1.13
>  - Calculate the size of the capacity controller MMIO space based on
>    on cc->ncblks and roundup to be aligned to the 4KB page boundary.
>  - Remove rpfx, p and cunits properties that were added in the previous
>    revision as I have decided to not support those optional features in
>    this capacity controller implementation.
>  - Update riscv_cbqri_cc_read to set 0 for RPFX, P and CUNITS in
>    cc_capabilities. This indicates that this capacity controller
>    implementation does not support RCID-prefixed mode and nor does it
>    support capacity unit limits.
>  - Add cc_cunits register after cc_block_mask register in the
>    alloc_blockmasks array and adjust logic in get_blockmask_offset,
>    riscv_cbqri_cc_read, riscv_cbqri_cc_write. Since capacity units is
>    not supported, the cc_cunits register will always be 0.
>  - Only assign capacity for rcid 0 in riscv_cbqri_cc_reset and do not
>    touch allocation for other rcid values as they are unspecified
>    following a reset.
>  - Change CC_ALLOC_OP_FLUSH_RCID to be a no-op instead of calling
>    alloc_blockmask_init() as the spec states that the configured
>    capacity block allocation or the capacity unit limit is not
>    changed by the flush operation.
>  - Add comment to explain that, while the spec only requires the busy
>    field to be reset to 0, the entire contents of the cc->cc_mon_ctl
>    abd cc->cc_alloc_ctl registers are set to 0 simplify the code in
>    riscv_cbqri_cc_reset().
>  - Simplify the access type logic for blockmask initialization in
>    riscv_cbqri_cc_reset().
>  - Add static inline helpers get_bmw() and get_slots().
>  - Add check to bandwidth_config() that rbwb is not greater than mrbwb.
>  - Link to v3: https://lore.kernel.org/qemu-devel/20251119-riscv-ssqosid-=
cbqri-v1-0-3392fc760e48@kernel.org
>
> Changes since v2:
>  - NOTE: I should have used version v3 for this version posted on Nov 19
>    as there were already v1 and v2 back in 2023.
>  - Rebase on master which is currently at version v10.1.50
>  - Add fields that were not in the draft used for the proof of concept
>    and introduced in final CBQRI 1.0 spec: capacity units (cunits) and
>    RCID-prefixed mode (RPFX) along with parameter P (prefixed bits)
>  - Fix check_srmcfg() to check if virtualization is enabled, and if so,
>    return virt instruction fault, otherwise return smode()
>  - Fix indentation in read_srmcfg()
>  - Add SPDX headers
>  - Add MAINTAINERS enteries
>  - Link to v2: https://lore.kernel.org/qemu-devel/20230425203834.1135306-=
1-dfustini@baylibre.com/
>
> Changes since v1:
>  - Rebase on current master (8.0.50) instead of 8.0.0-rc4
>  - Configure CBQRI controllers based on device properties in command
>    line arguments instead of a fixed example SoC configuration.
>  - Move TYPE_RISCV_CBQRI_BC and TYPE_RISCV_CBQRI_CC into header so that
>    machines may use it (suggested by Alistair).
>  - Change 'select RISC_CBQRI' to 'imply RISCV_CBQRI' for RISCV_VIRT.
>  - Patches 8/9 could be dropped as they are not needed for the CBQRI
>    proof-of-concept to work. They are only meant to serve as an example
>    for those implementing new machines.
>  - Link to v1: https://lore.kernel.org/qemu-devel/20230416232050.4094820-=
1-dfustini@baylibre.com/
>
> [1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
> [2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/fustini/linux.git/log=
/?h=3Db4/ssqosid-cbqri
>
> Signed-off-by: Drew Fustini <fustini@kernel.org>
> ---
> Kornel Dul=C4=99ba (1):
>       riscv: implement Ssqosid extension and srmcfg CSR
>
> Nicolas Pitre (5):
>       hw/riscv: define capabilities of CBQRI controllers
>       hw/riscv: implement CBQRI capacity controller
>       hw/riscv: implement CBQRI bandwidth controller
>       hw/riscv: add CBQRI to Kconfig and build if enabled
>       hw/riscv: add CBQRI controllers to virt machine
>
>  MAINTAINERS                       |   9 +
>  disas/riscv.c                     |   1 +
>  hw/riscv/Kconfig                  |   4 +
>  hw/riscv/cbqri_bandwidth.c        | 612 ++++++++++++++++++++++++++++++++=
+
>  hw/riscv/cbqri_capacity.c         | 706 ++++++++++++++++++++++++++++++++=
++++++
>  hw/riscv/meson.build              |   1 +
>  hw/riscv/virt.c                   |   3 +
>  include/hw/riscv/cbqri.h          |  82 +++++
>  target/riscv/cpu.c                |   2 +
>  target/riscv/cpu.h                |   3 +
>  target/riscv/cpu_bits.h           |   9 +
>  target/riscv/cpu_cfg_fields.h.inc |   1 +
>  target/riscv/csr.c                |  37 ++
>  13 files changed, 1470 insertions(+)
> ---
> base-commit: 942b0d378a1de9649085ad6db5306d5b8cef3591
> change-id: 20251229-riscv-ssqosid-cbqri-aee2271532ff
>
> Best regards,
> --
> Drew Fustini <fustini@kernel.org>
>

Thanks,
Yunhui

