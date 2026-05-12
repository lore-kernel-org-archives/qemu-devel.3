Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C9CD4846
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 02:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMch5-0005F8-5m; Mon, 11 May 2026 22:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMch0-0005Ef-Jd; Mon, 11 May 2026 22:17:55 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wMcgv-0002bD-3V; Mon, 11 May 2026 22:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1778552253; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=gzlxTxUEJVCM2smrZKhukYVpRToxanBnpMDL/T96W0I=;
 b=j+Xt2ZnMQL1RWjk4CsYQBPv3Rv3Jv3edyZu+5SKk9LR2fur68nehWZlAjWfLaqCKfAooGxPiHdaPjDnXrvJRiDw/SVqN9KvOM4rtzcDHLSXhcebG2Q4EzJK9luLx5C4LBVcjjan0z3RFZ8smwIJFSpaeVagaKP6ejZ4ihTJqEsM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0X2ofL5x_1778552251; 
Received: from 30.166.64.212(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X2ofL5x_1778552251 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 12 May 2026 10:17:32 +0800
Message-ID: <987c2615-b023-41b1-b7d0-572c7f74b373@linux.alibaba.com>
Date: Tue, 12 May 2026 10:17:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] target/riscv: Implement core SMMPT lookup logic
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com,
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKOCRdD5cUvux6W9Z_9fMXiZ0g5s1n6iWp7RkTmZBGvHXw@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKOCRdD5cUvux6W9Z_9fMXiZ0g5s1n6iWp7RkTmZBGvHXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

Hi Alistair,

On 4/10/26 9:36 AM, Alistair Francis wrote:
> On Thu, Apr 9, 2026 at 12:07 AM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>> This patch introduces the core implementation for the Memory Protection Table
>> (MPT) walk, which is the central mechanism of the SMMPT extension.
>>
>> A new file, `riscv_smmpt.c`, is added to encapsulate the MPT logic. It
>> implements the `smmpt_lookup()` function, which performs a multi-level
>> page table-like walk starting from the physical address specified in the
>> `mptppn` CSR field. This walk determines the access permissions (read,
>> write, execute) for a given physical address.
>>
>> The implementation supports various SMMPT modes (SMMPT34, SMMPT43, etc.) and
>> correctly handles leaf and non-leaf entries, including reserved bit
>> checks. Helper functions for parsing MPT entries and converting access
>> permissions are also included in the new `riscv_smmpt.h` header.
>>
>> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
>> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu_helper.c  |   5 +-
>>   target/riscv/meson.build   |   1 +
>>   target/riscv/pmp.h         |   3 +
>>   target/riscv/riscv_smmpt.c | 274 +++++++++++++++++++++++++++++++++++++
>>   target/riscv/riscv_smmpt.h |  15 ++
>>   5 files changed, 295 insertions(+), 3 deletions(-)
>>   create mode 100644 target/riscv/riscv_smmpt.c
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index dd6c861a90..e3361fadae 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -1089,9 +1089,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
>>    * @access_type: The type of MMU access
>>    * @mode: Indicates current privilege level.
>>    */
>> -static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>> -                                    int size, MMUAccessType access_type,
>> -                                    int mode)
>> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>> +                             int size, MMUAccessType access_type, int mode)
>>   {
>>       pmp_priv_t pmp_priv;
>>       bool pmp_has_privs;
>> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
>> index 3842c7c1a8..bd1c2e8fad 100644
>> --- a/target/riscv/meson.build
>> +++ b/target/riscv/meson.build
>> @@ -34,6 +34,7 @@ riscv_system_ss = ss.source_set()
>>   riscv_system_ss.add(files(
>>     'arch_dump.c',
>>     'pmp.c',
>> +  'riscv_smmpt.c',
>>     'debug.c',
>>     'monitor.c',
>>     'machine.c',
>> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
>> index 467fb6b4b1..1ed574227c 100644
>> --- a/target/riscv/pmp.h
>> +++ b/target/riscv/pmp.h
>> @@ -86,6 +86,9 @@ void pmp_update_rule_nums(CPURISCVState *env);
>>   uint32_t pmp_get_num_rules(CPURISCVState *env);
>>   int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
>>   void pmp_unlock_entries(CPURISCVState *env);
>> +int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>> +                             int size, MMUAccessType access_type,
>> +                             int mode);
>>
>>   #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
>>   #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
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
>> +                               MemTxAttrs, MemTxResult *);
>> +
>> +static uint64_t load_entry_32(AddressSpace *as, hwaddr addr,
>> +                              MemTxAttrs attrs, MemTxResult *result)
>> +{
>> +    return address_space_ldl(as, addr, attrs, result);
>> +}
>> +
>> +static uint64_t load_entry_64(AddressSpace *as, hwaddr addr,
>> +                              MemTxAttrs attrs, MemTxResult *result)
>> +{
>> +    return address_space_ldq(as, addr, attrs, result);
>> +}
>> +
>> +typedef union {
>> +    uint64_t raw;
>> +    struct {
>> +        uint32_t v:1;
>> +        uint32_t l:1;
>> +        uint32_t rsv1:5;
>> +        uint32_t perms:24;
>> +        uint32_t n:1;
>> +    } leaf32;
>> +    struct {
>> +        uint32_t v:1;
>> +        uint32_t l:1;
>> +        uint32_t rsv1:8;
>> +        uint32_t ppn:22;
>> +    } nonleaf32;
>> +    struct {
>> +        uint64_t v:1;
>> +        uint64_t l:1;
>> +        uint64_t rsv1:8;
>> +        uint64_t perms:48;
>> +        uint64_t rsv2:5;
>> +        uint64_t n:1;
>> +    } leaf64;
>> +    struct {
>> +        uint64_t v:1;
>> +        uint64_t l:1;
>> +        uint64_t rsv1:8;
>> +        uint64_t ppn:52;
>> +        uint64_t rsv2:1;
>> +        uint64_t n:1;
>> +    } nonleaf64;
>> +} mpte_union_t;
> There is no guarantee in C that these bit fields are packed and laid
> out like you are expecting
Good catch! Thanks for pointing it out. I have used the explicit 
extraction method for bit fields in mpte in v6 patch set.

Thanks,
Zhiwei
>
>> +
>> +static inline bool mpte_is_leaf(uint64_t mpte)
>> +{
>> +   return mpte & 0x2;
>> +}
>> +
>> +static inline bool mpte_is_valid(uint64_t mpte)
>> +{
>> +    return mpte & 0x1;
>> +}
>> +
>> +static uint64_t mpte_get_rsv(CPURISCVState *env, uint64_t mpte)
>> +{
>> +    RISCVMXL mxl = riscv_cpu_mxl(env);
>> +    bool leaf = mpte_is_leaf(mpte);
>> +    mpte_union_t *u = (mpte_union_t *)&mpte;
> So this cast
>
>> +
>> +    if (mxl == MXL_RV32) {
>> +        return leaf ? u->leaf32.rsv1 : u->nonleaf32.rsv1;
> and these accesses are not valid.
>
> On some platforms this will work, but on others it won't
>
> See the notes here
> https://en.cppreference.com/w/cpp/language/bit_field.html for more
> details
>
> Alistair

