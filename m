Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E5BCD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMckO-0006Zc-Vt; Mon, 11 May 2026 22:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMckN-0006Z2-Nz; Mon, 11 May 2026 22:21:23 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMckI-0005MP-Ul; Mon, 11 May 2026 22:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778552474; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=r8Kil+QZWe8n1RocnzjJCM658Jq05EZM98eE13O+gNU=;
 b=WbNVvdg6ZlGVPELWCetSF6926TRQBPzjU2zYsvhPrcY3/zpwBiuBAArD+QrTUUZ5RqTntHpNBUrO7TFhJh/6cGgfa/+vrgw+uCuQE13b8ngrstEcQXQz+LQVTkp2Jsqm9w3L4SdHeR7bEmCjmv8tfNSK/jW16gBkA55BAM27OfQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0X2op1Ae_1778552472; 
Received: from 30.166.64.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2op1Ae_1778552472 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 12 May 2026 10:21:13 +0800
Message-ID: <28b0c31a-7e80-47f4-bcad-2f7c81bfdcd4@linux.alibaba.com>
Date: Tue, 12 May 2026 10:21:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] target/riscv: Implement core SMMPT lookup logic
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
 <90009760-e20d-485f-b2e1-d33f73b9d887@oss.qualcomm.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <90009760-e20d-485f-b2e1-d33f73b9d887@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Daniel,

On 5/7/26 7:14 PM, Daniel Henrique Barboza wrote:
> Hi Zhiwei,
>
> On 4/8/2026 11:06 AM, LIU Zhiwei wrote:
>> This patch introduces the core implementation for the Memory 
>> Protection Table
>> (MPT) walk, which is the central mechanism of the SMMPT extension.
>>
>> A new file, `riscv_smmpt.c`, is added to encapsulate the MPT logic. It
>> implements the `smmpt_lookup()` function, which performs a multi-level
>> page table-like walk starting from the physical address specified in the
>> `mptppn` CSR field. This walk determines the access permissions (read,
>> write, execute) for a given physical address.
>>
>> The implementation supports various SMMPT modes (SMMPT34, SMMPT43, 
>> etc.) and
>> correctly handles leaf and non-leaf entries, including reserved bit
>> checks. Helper functions for parsing MPT entries and converting access
>> permissions are also included in the new `riscv_smmpt.h` header.
>>
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu_helper.c  |   5 +-
>>   target/riscv/meson.build   |   1 +
>>   target/riscv/pmp.h         |   3 +
>>   target/riscv/riscv_smmpt.c | 274 +++++++++++++++++++++++++++++++++++++
>>   target/riscv/riscv_smmpt.h |  15 ++
>>   5 files changed, 295 insertions(+), 3 deletions(-)
>>   create mode 100644 target/riscv/riscv_smmpt.c
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index dd6c861a90..e3361fadae 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1089,9 +1089,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, 
>> target_ulong newpriv, bool virt_en)
>>    * @access_type: The type of MMU access
>>    * @mode: Indicates current privilege level.
>>    */
>> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, 
>> hwaddr addr,
>> -                                    int size, MMUAccessType 
>> access_type,
>> -                                    int mode)
>> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr 
>> addr,
>> +                             int size, MMUAccessType access_type, 
>> int mode)
>>   {
>>       pmp_priv_t pmp_priv;
>>       bool pmp_has_privs;
>> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
>> index 3842c7c1a8..bd1c2e8fad 100644
>> --- a/target/riscv/meson.build
>> +++ b/target/riscv/meson.build
>> @@ -34,6 +34,7 @@ riscv_system_ss = ss.source_set()
>>   riscv_system_ss.add(files(
>>     'arch_dump.c',
>>     'pmp.c',
>> +  'riscv_smmpt.c',
>>     'debug.c',
>>     'monitor.c',
>>     'machine.c',
>> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
>> index 467fb6b4b1..1ed574227c 100644
>> --- a/target/riscv/pmp.h
>> +++ b/target/riscv/pmp.h
>> @@ -86,6 +86,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
>>   uint32_t pmp_get_num_rules(CPURISCVState *env);
>>   int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
>>   void pmp_unlock_entries(CPURISCVState *env);
>> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr 
>> addr,
>> +                             int size, MMUAccessType access_type,
>> +                             int mode);
>>     #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
>>   #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
>> diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
>> new file mode 100644
>> index 0000000000..b7b47c5ae1
>> --- /dev/null
>> +++ b/target/riscv/riscv_smmpt.c
>> @@ -0,0 +1,274 @@
>> +/*
>> + * QEMU RISC-V Smmpt (Memory Protection Table)
>> + *
>> + * Copyright (c) 2024 Alibaba Group. All rights reserved.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "riscv_smmpt.h"
>> +#include "pmp.h"
>> +#include "system/memory.h"
>> +
>> +typedef uint64_t load_entry_fn(AddressSpace *, hwaddr,
>> +                               MemTxAttrs, MemTxResult *);
>> +
>> +static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
>> +                              MemTxAttrs attrs, MemTxResult *result)
>> +{
>> +    return address_space_ldl(as, addr, attrs, result);
>> +}
>> +
>> +static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
>> +                              MemTxAttrs attrs, MemTxResult *result)
>> +{
>> +    return address_space_ldq(as, addr, attrs, result);
>> +}
>> +
>
> So it seems like we have upstream changes that impacted this code.
>
> (Phil, feel free to chime in).
>
> When building this series I face this error:
>
>
> FAILED: libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o
> cc -Ilibqemu-riscv64-softmmu.a.p -I. -I.. -Itarget/riscv 
> -I../target/riscv -Isubprojects/libvduse -I../subprojects/libvduse 
> -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 
> -I/usr/include/glib-2.0 -I/usr/lib/aarch64-linux-gnu/glib-2.0/include 
> -I/usr/include/libmount -I/usr/include/blkid 
> -I/usr/include/gio-unix-2.0 -I/usr/include/slirp 
> -fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g 
> -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE 
> -fno-strict-aliasing -fno-common -fwrapv -ftrivial-auto-var-init=zero 
> -fzero-call-used-regs=used-gpr -fstack-protector-strong -Wempty-body 
> -Wendif-labels -Wexpansion-to-defined -Wformat-overflow=2 
> -Wformat-security -Wformat-y2k -Wignored-qualifiers 
> -Wimplicit-fallthrough=2 -Winit-self -Wmissing-format-attribute 
> -Wmissing-prototypes -Wnested-externs -Wold-style-declaration 
> -Wold-style-definition -Wredundant-decls -Wshadow=local 
> -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-strings 
> -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value 
> -isystem /home/dbarboza/work/qemu/linux-headers -isystem linux-headers 
> -iquote . -iquote /home/dbarboza/work/qemu -iquote 
> /home/dbarboza/work/qemu/include -iquote 
> /home/dbarboza/work/qemu/host/include/aarch64 -iquote 
> /home/dbarboza/work/qemu/host/include/generic -iquote 
> /home/dbarboza/work/qemu/tcg/aarch64 -pthread -fPIE -D_DEFAULT_SOURCE 
> -D_XOPEN_SOURCE=600 -DNCURSES_WIDECHAR=1 -isystem../linux-headers 
> -isystemlinux-headers -DCOMPILING_PER_TARGET 
> '-DCONFIG_TARGET="riscv64-softmmu-config-target.h"' 
> '-DCONFIG_DEVICES="riscv64-softmmu-config-devices.h"' -MD -MQ 
> libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o -MF 
> libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o.d -o 
> libqemu-riscv64-softmmu.a.p/target_riscv_riscv_smmpt.c.o -c 
> ../target/riscv/riscv_smmpt.c
> ../target/riscv/riscv_smmpt.c: In function ‘load_entry_32’:
> ../target/riscv/riscv_smmpt.c:20:12: error: implicit declaration of 
> function ‘address_space_ldl’; did you mean ‘address_space_ldub’? 
> [-Werror=implicit-function-declaration]
>    20 |     return address_space_ldl(as, addr, attrs, result);
>       |            ^~~~~~~~~~~~~~~~~
>       |            address_space_ldub
> ../target/riscv/riscv_smmpt.c:20:12: error: nested extern declaration 
> of ‘address_space_ldl’ [-Werror=nested-externs]
> ../target/riscv/riscv_smmpt.c: In function ‘load_entry_64’:
> ../target/riscv/riscv_smmpt.c:26:12: error: implicit declaration of 
> function ‘address_space_ldq’; did you mean ‘address_space_ldub’? 
> [-Werror=implicit-function-declaration]
>    26 |     return address_space_ldq(as, addr, attrs, result);
>       |            ^~~~~~~~~~~~~~~~~
>       |            address_space_ldub
> ../target/riscv/riscv_smmpt.c:26:12: error: nested extern declaration 
> of ‘address_space_ldq’ [-Werror=nested-externs]
> cc1: all warnings being treated as errors
> [1638/2623] Generating docs/QEMU manual with a custom command
> ninja: build stopped: subcommand failed.
>
>
> I'm not sure why that is since the (seemly) appropriate header 
> system/memmory.h
> is included.
>
> With this change I can get it to build:
>
>
> $ git diff
> diff --git a/target/riscv/riscv_smmpt.c b/target/riscv/riscv_smmpt.c
> index b7b47c5ae1..ddc8cd9932 100644
> --- a/target/riscv/riscv_smmpt.c
> +++ b/target/riscv/riscv_smmpt.c
> @@ -17,13 +17,13 @@ typedef uint64_t load_entry_fn(AddressSpace *, 
> hwaddr,
>  static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
>                                MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return address_space_ldl(as, addr, attrs, result);
> +    return address_space_ldl_le(as, addr, attrs, result);
>  }
>
>  static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
>                                MemTxAttrs attrs, MemTxResult *result)
>  {
> -    return address_space_ldq(as, addr, attrs, result);
> +    return address_space_ldq_le(as, addr, attrs, result);
>  }
>
>  typedef union {
>
>
>
> I ***think*** this is a fair change since we're reading/writing memory 
> using
> the same endianess, and our memory operations are usually LE, e.g. in
> get_physical_address:
>
>
>         if (riscv_cpu_mxl(env) == MXL_RV32) {
>             pte = address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>         } else {
>             pte = address_space_ldq_le(cs->as, pte_addr, attrs, &res);
>         }
>
>
> I'll defer to you what we should do here.  Thanks,
I see the same build issue based on the community master branch. And 
fixed as you suggested in V6 patch set.

Thanks,
Zhiwei
>
> Daniel
>
>> +typedef union {
>> +    uint64_t raw;
>> +    struct {
>> +        uint32_t v:1;
>> +        uint32_t l:1;
>> +        uint32_t rsv1:5;
>> +        uint32_t perms:24;
>> +        uint32_t n:1;
>> +    } leaf32;
>> +    struct {
>> +        uint32_t v:1;
>> +        uint32_t l:1;
>> +        uint32_t rsv1:8;
>> +        uint32_t ppn:22;
>> +    } nonleaf32;
>> +    struct {
>> +        uint64_t v:1;
>> +        uint64_t l:1;
>> +        uint64_t rsv1:8;
>> +        uint64_t perms:48;
>> +        uint64_t rsv2:5;
>> +        uint64_t n:1;
>> +    } leaf64;
>> +    struct {
>> +        uint64_t v:1;
>> +        uint64_t l:1;
>> +        uint64_t rsv1:8;
>> +        uint64_t ppn:52;
>> +        uint64_t rsv2:1;
>> +        uint64_t n:1;
>> +    } nonleaf64;
>> +} mpte_union_t;
>> +
>> +static inline bool mpte_is_leaf(uint64_t mpte)
>> +{
>> +   return mpte & 0x2;
>> +}
>> +
>> +static inline bool mpte_is_valid(uint64_t mpte)
>> +{
>> +    return mpte & 0x1;
>> +}
>> +
>> +static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
>> +{
>> +    RISCVMXL mxl = riscv_cpu_mxl(env);
>> +    bool leaf = mpte_is_leaf(mpte);
>> +    mpte_union_t *u = (mpte_union_t *)&mpte;
>> +
>> +    if (mxl == MXL_RV32) {
>> +        return leaf ? u->leaf32.rsv1 : u->nonleaf32.rsv1;
>> +    }
>> +    return leaf ? (u->leaf64.rsv1 << 5) | u->leaf64.rsv2
>> +                : (u->nonleaf64.rsv1 << 1) | u->nonleaf64.rsv2;
>> +}
>> +
>> +static uint64_t mpte_get_perms(CPURISCVState *env, uint64_t mpte)
>> +{
>> +    RISCVMXL mxl = riscv_cpu_mxl(env);
>> +    mpte_union_t *u = (mpte_union_t *)&mpte;
>> +
>> +    return (mxl == MXL_RV32) ? u->leaf32.perms : u->leaf64.perms;
>> +}
>> +
>> +static bool mpte_check_nlnapot(CPURISCVState *env, uint64_t mpte, 
>> bool *nlnapot)
>> +{
>> +    RISCVMXL mxl = riscv_cpu_mxl(env);
>> +    mpte_union_t *u = (mpte_union_t *)&mpte;
>> +    if (mxl == MXL_RV32) {
>> +        *nlnapot = false;
>> +        return true;
>> +    }
>> +    *nlnapot = u->nonleaf64.n;
>> +    return u->nonleaf64.n ? (u->nonleaf64.ppn & 0x1ff) == 0x100 : true;
>> +}
>> +
>> +static uint64_t mpte_get_ppn(CPURISCVState *env, uint64_t mpte, int pn,
>> +                             bool nlnapot)
>> +{
>> +    RISCVMXL mxl = riscv_cpu_mxl(env);
>> +    mpte_union_t *u = (mpte_union_t *)&mpte;
>> +
>> +    if (nlnapot) {
>> +        return deposit64(u->nonleaf64.ppn, 0, 9, pn & 0x1ff);
>> +    }
>> +    return (mxl == MXL_RV32) ? u->nonleaf32.ppn : u->nonleaf64.ppn;
>> +}
>> +
>> +/* Caller should assert i before call this interface */
>> +static int mpt_get_pn(hwaddr addr, int i, mpt_mode_t mode)
>> +{
>> +    if (mode == SMMPT34) {
>> +        return i == 0
>> +            ? extract64(addr, 15, 10)
>> +            : extract64(addr, 25, 9);
>> +    } else {
>> +        int offset = 16 + i * 9;
>> +        if ((mode == SMMPT64) && (i == 4)) {
>> +            return extract64(addr, offset, 12);
>> +        } else {
>> +            return extract64(addr, offset, 9);
>> +        }
>> +    }
>> +}
>> +
>> +/* Caller should assert i before call this interface */
>> +static int mpt_get_pi(hwaddr addr, int i, mpt_mode_t mode)
>> +{
>> +    if (mode == SMMPT34) {
>> +        return i == 0
>> +            ? extract64(addr, 12, 3)
>> +            : extract64(addr, 22, 3);
>> +    } else {
>> +        int offset = 16 + i * 9;
>> +        return extract64(addr, offset - 4, 4);
>> +    }
>> +}
>> +
>> +static bool smmpt_lookup(CPURISCVState *env, hwaddr addr, mpt_mode_t 
>> mode,
>> +                         mpt_access_t *allowed_access,
>> +                         MMUAccessType access_type)
>> +{
>> +    MemTxResult res;
>> +    MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>> +    CPUState *cs = env_cpu(env);
>> +    hwaddr mpte_addr, base = (hwaddr)env->mptppn << PGSHIFT;
>> +    load_entry_fn *load_entry;
>> +    uint32_t mptesize, levels, xwr;
>> +    int pn, pi, pmp_prot, pmp_ret;
>> +    uint64_t mpte, perms;
>> +
>> +    switch (mode) {
>> +    case SMMPT34:
>> +        load_entry = &load_entry_32; levels = 2; mptesize = 4; break;
>> +    case SMMPT43:
>> +        load_entry = &load_entry_64; levels = 3; mptesize = 8; break;
>> +        break;
>> +    case SMMPT52:
>> +        load_entry = &load_entry_64; levels = 4; mptesize = 8; break;
>> +    case SMMPT64:
>> +        load_entry = &load_entry_64; levels = 5; mptesize = 8; break;
>> +    case SMMPTBARE:
>> +        *allowed_access = ACCESS_ALLOW_RWX;
>> +        return true;
>> +    default:
>> +        g_assert_not_reached();
>> +        break;
>> +    }
>> +    for (int i = levels - 1; i >= 0 ; i--) {
>> +        /* 1. Get pn[i] as the mpt index */
>> +        pn = mpt_get_pn(addr, i, mode);
>> +        /* 2. Get mpte address and get mpte */
>> +        mpte_addr = base + pn * mptesize;
>> +        pmp_ret = get_physical_address_pmp(env, &pmp_prot, mpte_addr,
>> +                                           mptesize, MMU_DATA_LOAD, 
>> PRV_M);
>> +        if (pmp_ret != TRANSLATE_SUCCESS) {
>> +            return false;
>> +        }
>> +        mpte = load_entry(cs->as, mpte_addr, attrs, &res);
>> +        /* 3. Check valid bit and reserve bits of mpte */
>> +        if (!mpte_is_valid(mpte) || mpte_get_rsv(env, mpte)) {
>> +            return false;
>> +        }
>> +
>> +        /* 4. Process non-leaf node */
>> +        if (!mpte_is_leaf(mpte)) {
>> +            bool nlnapot = false;
>> +            if (i == 0) {
>> +                return false;
>> +            }
>> +            if (!mpte_check_nlnapot(env, mpte, &nlnapot)) {
>> +                return false;
>> +            }
>> +            base = mpte_get_ppn(env, mpte, pn, nlnapot) << PGSHIFT;
>> +            continue;
>> +        }
>> +
>> +        /* 5. Process leaf node */
>> +        pi = mpt_get_pi(addr, i, mode);
>> +        perms = mpte_get_perms(env, mpte);
>> +        xwr = (perms >> (pi * 3)) & 0x7;
>> +        switch (xwr) {
>> +        case ACCESS_ALLOW_R:
>> +            *allowed_access = ACCESS_ALLOW_R;
>> +            return access_type == MMU_DATA_LOAD;
>> +        case ACCESS_ALLOW_X:
>> +            *allowed_access = ACCESS_ALLOW_X;
>> +            return access_type == MMU_INST_FETCH;
>> +        case ACCESS_ALLOW_RX:
>> +            *allowed_access = ACCESS_ALLOW_R;
>> +            return (access_type == MMU_DATA_LOAD ||
>> +                    access_type == MMU_INST_FETCH);
>> +        case ACCESS_ALLOW_RW:
>> +            *allowed_access = ACCESS_ALLOW_RW;
>> +            return (access_type == MMU_DATA_LOAD ||
>> +                    access_type == MMU_DATA_STORE);
>> +        case ACCESS_ALLOW_RWX:
>> +            *allowed_access = ACCESS_ALLOW_RWX;
>> +            return true;
>> +        default:
>> +            return false;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
>> +                        mpt_access_t *allowed_access, MMUAccessType 
>> access_type)
>> +{
>> +    bool mpt_has_access;
>> +    mpt_mode_t mode = env->mptmode;
>> +
>> +    mpt_has_access = smmpt_lookup(env, addr, mode,
>> +                                  allowed_access, access_type);
>> +    return mpt_has_access;
>> +}
>> +
>> +/*
>> + * Convert MPT access to TLB page privilege.
>> + */
>> +int smmpt_access_to_page_prot(mpt_access_t mpt_access)
>> +{
>> +    int prot;
>> +    switch (mpt_access) {
>> +    case ACCESS_ALLOW_R:
>> +        prot = PAGE_READ;
>> +        break;
>> +    case ACCESS_ALLOW_X:
>> +        prot = PAGE_EXEC;
>> +        break;
>> +    case ACCESS_ALLOW_RX:
>> +        prot = PAGE_READ | PAGE_EXEC;
>> +        break;
>> +    case ACCESS_ALLOW_RW:
>> +        prot = PAGE_READ | PAGE_WRITE;
>> +        break;
>> +    case ACCESS_ALLOW_RWX:
>> +        prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>> +        break;
>> +    default:
>> +        prot = 0;
>> +        break;
>> +    }
>> +
>> +    return prot;
>> +}
>> diff --git a/target/riscv/riscv_smmpt.h b/target/riscv/riscv_smmpt.h
>> index 74dcccf4be..0d0597f8eb 100644
>> --- a/target/riscv/riscv_smmpt.h
>> +++ b/target/riscv/riscv_smmpt.h
>> @@ -9,6 +9,9 @@
>>   #ifndef RISCV_SMMPT_H
>>   #define RISCV_SMMPT_H
>>   +#include "cpu.h"
>> +#include "exec/mmu-access-type.h"
>> +
>>   typedef enum {
>>       SMMPTBARE = 0,
>>       SMMPT34   = 1,
>> @@ -18,4 +21,16 @@ typedef enum {
>>       SMMPTMAX
>>   } mpt_mode_t;
>>   +typedef enum {
>> +    ACCESS_ALLOW_R = 0b001,
>> +    ACCESS_ALLOW_X = 0b100,
>> +    ACCESS_ALLOW_RX = 0b101 ,
>> +    ACCESS_ALLOW_RW = 0b011,
>> +    ACCESS_ALLOW_RWX = 0b111,
>> +} mpt_access_t;
>> +
>> +int smmpt_access_to_page_prot(mpt_access_t mpt_access);
>> +bool smmpt_check_access(CPURISCVState *env, hwaddr addr,
>> +                        mpt_access_t *allowed_access,
>> +                        MMUAccessType access_type);
>>   #endif
>

