Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A050C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZlpU-0000UO-Kl; Fri, 02 Aug 2024 02:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZlpT-0000TP-BN; Fri, 02 Aug 2024 02:31:55 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sZlpR-0007sw-0V; Fri, 02 Aug 2024 02:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1722580307; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=WorRIyfHANUNVChl27EAqZrr3eW+4BiwMnlfHPYZkps=;
 b=dMba42yf2oEAvKReGyyxzaqZecLi9wi0g/1SCNH6DEeqW99vImgTJaJ+KdHCm1iin9vmgi5Mk3Ao7wn9mZyPErp384xssrirj4ZMLajplSBqcwsnmw/I649aQxaUBO7kGuQl/ZEgtSeYN+X5Puh9EvMStrTfE7uaCtJFXq499rc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R751e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0WBwTE4n_1722580305; 
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBwTE4n_1722580305) by smtp.aliyun-inc.com;
 Fri, 02 Aug 2024 14:31:46 +0800
Message-ID: <fb0fa6bc-5a4d-45be-b495-f11caf3acfb9@linux.alibaba.com>
Date: Fri, 2 Aug 2024 14:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/riscv: Remove redundant insn length check
 for zama16b
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802031612.604-1-zhiwei_liu@linux.alibaba.com>
 <20240802031612.604-2-zhiwei_liu@linux.alibaba.com>
 <6a533a62-ed00-49bf-8922-fe1d30ce0857@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <6a533a62-ed00-49bf-8922-fe1d30ce0857@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
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


On 2024/8/2 13:38, Richard Henderson wrote:
> On 8/2/24 13:16, LIU Zhiwei wrote:
>> @@ -47,7 +47,12 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
>>       REQUIRE_FPU;
>>       REQUIRE_EXT(ctx, RVD);
>>   -    if (ctx->cfg_ptr->ext_zama16b && (ctx->cur_insn_len != 2)) {
>> +    /*
>> +     * Zama16b applies to loads and stores of no more than MXLEN 
>> bits defined
>> +     * in the F, D, and Q extensions. Otherwise, it falls through to 
>> default
>> +     * MO_ATOM_IFALIGN.
>> +     */
>> +    if ((ctx->xl >= MXL_RV64) && (ctx->cfg_ptr->ext_zama16b)) {
>
> I think you meant to add the mxlen check in the next patch,
> because you modify this line again.
>
Oh, I didn't notice it.  I once split the whole patch into two patches. 
But obviously I did only a half.

Thanks,
Zhiwei

>
> r~

