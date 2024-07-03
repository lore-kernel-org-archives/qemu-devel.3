Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF462C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOq31-0000oh-6o; Tue, 02 Jul 2024 22:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOq2y-0000oT-2a; Tue, 02 Jul 2024 22:48:40 -0400
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOq2u-0003wv-1Y; Tue, 02 Jul 2024 22:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719974902; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=oZQfr0Jy5PLi0K+/m6W0/6hdH8dA03lJTjwO0NUJGI8=;
 b=gi8GxTccdGKKUtfBEPNwcjzOEdsWJK5+Jokal5xV/xsDhwk+3iZK7dqhJEFFgLC66qxdChRXqj2ECo4tjHBrAZ7Ca9XIjitR82J5z++7SyAm4j62bAm/5aOzLWkGsuwbxkoYGCWU/Qua5TH3o2RQpHG4buW2v1ErG7eDQT+SgjA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W9kOmtV_1719974901; 
Received: from 30.166.64.126(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9kOmtV_1719974901) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 10:48:21 +0800
Message-ID: <8b300457-7cf6-4a43-9f4a-521dd8725f44@linux.alibaba.com>
Date: Wed, 3 Jul 2024 10:46:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/riscv: Detect sxl to set bit width for RV32 in
 RV64
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
 <20240701033722.954-5-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKPsCWRy2Fwpnv3LB5QXVujBHVBHqLUNrVDnG4rfXH5TVA@mail.gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <CAKmqyKPsCWRy2Fwpnv3LB5QXVujBHVBHqLUNrVDnG4rfXH5TVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.99;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-99.freemail.mail.aliyun.com
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


On 2024/7/3 10:33, Alistair Francis wrote:
> On Mon, Jul 1, 2024 at 1:41 PM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>>
>> Ensure correct bit width based on sxl when running RV32 on RV64 QEMU.
>> This is required as MMU address translations run in S-mode.
>>
>> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/cpu_helper.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index 6709622dd3..1af83a0a36 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -887,12 +887,14 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>>
>>       CPUState *cs = env_cpu(env);
>>       int va_bits = PGSHIFT + levels * ptidxbits + widened;
>> +    int sxlen = 16UL << riscv_cpu_sxl(env);
>> +    int sxlen_bytes = sxlen / 8;
>>
>>       if (first_stage == true) {
>>           target_ulong mask, masked_msbs;
>>
>> -        if (TARGET_LONG_BITS > (va_bits - 1)) {
>> -            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
>> +        if (sxlen > (va_bits - 1)) {
>> +            mask = (1L << (sxlen - (va_bits - 1))) - 1;
>>           } else {
>>               mask = 0;
>>           }
>> @@ -961,7 +963,7 @@ restart:
>>
>>           int pmp_prot;
>>           int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
>> -                                               sizeof(target_ulong),
>> +                                               sxlen_bytes,
>>                                                  MMU_DATA_LOAD, PRV_S);
>>           if (pmp_ret != TRANSLATE_SUCCESS) {
>>               return TRANSLATE_PMP_FAIL;
>> @@ -1113,7 +1115,7 @@ restart:
>>            *   it is no longer valid and we must re-walk the page table.
>>            */
>>           MemoryRegion *mr;
>> -        hwaddr l = sizeof(target_ulong), addr1;
>> +        hwaddr l = sxlen_bytes, addr1;
>>           mr = address_space_translate(cs->as, pte_addr, &addr1, &l,
>>                                        false, MEMTXATTRS_UNSPECIFIED);
>>           if (memory_region_is_ram(mr)) {
>> @@ -1126,6 +1128,11 @@ restart:
>>               *pte_pa = pte = updated_pte;
>>   #else
>>               target_ulong old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
> I think you missed removing this line

Good catch.  We will fix this in v2 patch set.

Thanks,
Zhiwei

>
> Alistair
>
>> +            if (riscv_cpu_sxl(env) == MXL_RV32) {
>> +                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
>> +            } else {
>> +                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
>> +            }
>>               if (old_pte != pte) {
>>                   goto restart;
>>               }
>> --
>> 2.43.0
>>
>>

