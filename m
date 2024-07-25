Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D254C3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 01:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWnh6-0002T7-BW; Wed, 24 Jul 2024 21:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sWnh4-0002S7-BF; Wed, 24 Jul 2024 21:54:58 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sWnh1-000347-UX; Wed, 24 Jul 2024 21:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1721872490; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=R3Kypw52qooCC6nc83+Qu+Bo2NdspjaGZFUzhoyektY=;
 b=w6k/m13q9CFWtsDvcGW4yfBaCwibemJkEo8jSH4OI/jXQY8vY29y/TPF1YN2f8CwKhTHtpJq28HXXrkMmdcudmUwUaj5wZFk47+x1rtcY48PhNjTcqqp9eVbYSO8pRjQf1zdMinqV5A3o6TF8JjFmQS4NCdW9MVlMbY0iv/Eadw=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0WBFtI-t_1721872489; 
Received: from 30.166.64.206(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WBFtI-t_1721872489) by smtp.aliyun-inc.com;
 Thu, 25 Jul 2024 09:54:49 +0800
Message-ID: <a260b957-d2bc-4ac6-8b7c-97e8b47a0200@linux.alibaba.com>
Date: Thu, 25 Jul 2024 09:53:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] target/riscv: Add any32 and max32 CPU for RV64 QEMU
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 bmeng.cn@gmail.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20240719231149.1364-1-zhiwei_liu@linux.alibaba.com>
 <20240719231149.1364-8-zhiwei_liu@linux.alibaba.com>
 <20240724-ef8cf69388fb767b6710b48f@orel>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240724-ef8cf69388fb767b6710b48f@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
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


On 2024/7/24 23:01, Andrew Jones wrote:
> On Sat, Jul 20, 2024 at 07:11:48AM GMT, LIU Zhiwei wrote:
>> We may need 32-bit max or 32-bit any CPU for RV64 QEMU. Thus we add
>> these two CPUs for RV64 QEMU.
>>
>> The reason we don't expose them to RV32 QEMU is that we already have
>> max or any cpu with the same configuration. Another reason is that
>> we want to follow the RISC-V custom where addw instruction doesn't
>> exist in RV32 CPU.
>>
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu-qom.h |  2 ++
>>   target/riscv/cpu.c     | 13 ++++++++-----
>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
>> index 3670cfe6d9..9f91743b78 100644
>> --- a/target/riscv/cpu-qom.h
>> +++ b/target/riscv/cpu-qom.h
>> @@ -31,6 +31,8 @@
>>   
>>   #define TYPE_RISCV_CPU_ANY              RISCV_CPU_TYPE_NAME("any")
>>   #define TYPE_RISCV_CPU_MAX              RISCV_CPU_TYPE_NAME("max")
>> +#define TYPE_RISCV_CPU_ANY32            RISCV_CPU_TYPE_NAME("any32")
> 'any' is on its way out[1], so we probably shouldn't bother adding any32
> at all with this series
>
> [1] https://lore.kernel.org/all/20240724130717.95629-1-philmd@linaro.org/

Agree.

Thanks,
Zhiwei

>
> Thanks,
> drew

