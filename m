Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FDFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZllK-0003vd-R8; Fri, 02 Aug 2024 02:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZllJ-0003tz-2b; Fri, 02 Aug 2024 02:27:37 -0400
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZllG-0006vn-39; Fri, 02 Aug 2024 02:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722580047; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=UnSvxLapEzxzxj0emspyzSBBL0uXgpnFq3i/uOdbcdc=;
 b=VSoe4qzy2LtJGK0uTYie87rx47lDlDp1TDQEA/LbOrONfBIPtl5aP7PHsmnDsFZslNB7corTbujBFhrAlVcFPgtPWv0DwWQUpikusZiv36lnP6ofjthG/sJ7eiVjq8eEiqg3jFMrBIDJCfRQT/GbZoUey6tWRcRldfScLNsScWE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R441e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBwQfiA_1722580045; 
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBwQfiA_1722580045) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 14:27:26 +0800
Message-ID: <eb6a4c26-dd25-4be6-aca7-e0ef1b133d7a@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:27:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] target/riscv: Relax fld alignment requirement
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-4-zhiwei_liu@linux.alibaba.com>
 <05d5a772-a7b9-4bfd-8ca0-f85dcf2d1505@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <05d5a772-a7b9-4bfd-8ca0-f85dcf2d1505@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/8/2 13:52, Richard Henderson wrote:
> On 8/2/24 13:16, LIU Zhiwei wrote:
>> According to the risc-v specification:
>> "FLD and FSD are only guaranteed to execute atomically if the effective
>> address is naturally aligned and XLEN≥64."
>>
>> We currently implement fld as MO_ATOM_IFALIGN when XLEN < 64, which does
>> not violate the rules. But it will hide some problems. So relax it to
>> MO_ATOM_NONE.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> ---
>>   target/riscv/insn_trans/trans_rvd.c.inc | 26 ++++++++++++++++++-------
>>   1 file changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvd.c.inc 
>> b/target/riscv/insn_trans/trans_rvd.c.inc
>> index dbe508c7e0..458d7db745 100644
>> --- a/target/riscv/insn_trans/trans_rvd.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvd.c.inc
>> @@ -48,12 +48,20 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>>       REQUIRE_EXT(ctx, RVD);
>>         /*
>> -     * Zama16b applies to loads and stores of no more than MXLEN 
>> bits defined
>> -     * in the F, D, and Q extensions. Otherwise, it falls through to 
>> default
>> -     * MO_ATOM_IFALIGN.
>> +     * FLD and FSD are only guaranteed to execute atomically if the 
>> effective
>> +     * address is naturally aligned and XLEN≥64.
>>        */
>> -    if ((ctx->misa_mxl_max >= MXL_RV64) && ctx->cfg_ptr->ext_zama16b) {
>> -        memop |= MO_ATOM_WITHIN16;
>> +    if (ctx->misa_mxl_max >= MXL_RV64) {
>> +        /*
>> +         * Zama16b applies to loads and stores of no more than MXLEN 
>> bits
>> +         * defined in the F, D, and Q extensions. Otherwise, it 
>> falls through
>> +         * to default MO_ATOM_IFALIGN.
>> +         */
>> +        if (ctx->cfg_ptr->ext_zama16b) {
>> +            memop |= MO_ATOM_WITHIN16;
>> +        }
>> +    } else {
>> +        memop |= MO_ATOM_NONE;
>>       }
>
> Does this really have byte atomicity, not atomic on two aligned 32-bit 
> loads (which would be MO_ATOM_IFALIGN_PAIR).
The specification doesn't rule it. I think we can choose either way. The 
byte atomicity may expose more problems on alignment.
>
> It's probably clearer to fill out the if-tree completely,
> rather than explain about defaults.
>
>     if (get_mxl(ctx) == MXL_RV32) {
>         memop |= MO_ATOM_NONE;
>     } else if (ctx->cfg_ptr->ext_zama16b) {
>         memop |= MO_ATOM_WITHIN16;
>     } else {
>         memop |= MO_ATOM_IFALIGN;
>     }

OK.

Thanks,
Zhiwei

>
>
> r~

