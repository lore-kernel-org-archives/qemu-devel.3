Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EB6C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkK8Q-00080R-6A; Wed, 13 Mar 2024 04:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rkK8H-000805-0s; Wed, 13 Mar 2024 04:38:42 -0400
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rkK8D-0006U9-QL; Wed, 13 Mar 2024 04:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710319102; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=mn345pKhc48JP8shvQPWdOY1zWmG8wfRyHOjI0n2VqE=;
 b=b1ORzfEMNeScAeAZ9UW+sg9qBfgA6w1GA8yQ35hZ4A3FW4oJ/m0UKhJz5+ocZvWE7GX9xPS6zcFLZOv68KR88PvDOt08r0JND9LV4fZla3kSqwmIq1s1V9ed94Yc6W/gZkKntc2xD6GMcUj8+PavI5T/5/YpPjgPI3N/eaWAejw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W2ObjtA_1710319099; 
Received: from 30.21.185.204(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W2ObjtA_1710319099) by smtp.aliyun-inc.com;
 Wed, 13 Mar 2024 16:38:20 +0800
Message-ID: <b97ceb4f-e284-411c-aeb9-228ef8c92144@linux.alibaba.com>
Date: Wed, 13 Mar 2024 16:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Implement dynamic establishment of
 custom decoder
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20240312054553.11811-1-eric.huang@linux.alibaba.com>
 <8f23924f-af5c-4bc1-94f1-143bc5c8184d@linaro.org>
From: Huang Tao <eric.huang@linux.alibaba.com>
In-Reply-To: <8f23924f-af5c-4bc1-94f1-143bc5c8184d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

I'm sorry for making this mistake and thank you for your patience.

In the next version, I will use GPtrArray you mentioned earlier to solve 
the problem.

Thanks,

Huang Tao

On 2024/3/12 21:57, Richard Henderson wrote:
> On 3/11/24 19:45, Huang Tao wrote:
>> +static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
>> +{
>> +    decode_fn *dynamic_decoders;
>> +    dynamic_decoders = g_new0(decode_fn, decoder_table_size);
>
> Allocating ARRAY_SIZE(decoder_table)...
>
>> +    int j = 0;
>> +    for (size_t i = 0; i < decoder_table_size; ++i) {
>> +        if (decoder_table[i].guard_func &&
>> +            decoder_table[i].guard_func(&cpu->cfg)) {
>> +            dynamic_decoders[j] = decoder_table[i].decode_fn;
>> +            j++;
>> +        }
>
> Potentially enabling all elements...
>
>> +        for (size_t i = 0; ctx->decoders[i]; ++i) {
>
> Reading past the end of the array expecting an extra NULL entry.
>
>
> r~

