Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC01E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 04:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQfPd-0006VV-AM; Wed, 25 Dec 2024 23:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tQfPa-0006V8-RC
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 23:23:50 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tQfPX-00016g-Mc
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 23:23:50 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxuuBI2mxn3IZaAA--.48423S3;
 Thu, 26 Dec 2024 12:23:36 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAx7+VF2mxnp5AJAA--.51052S3;
 Thu, 26 Dec 2024 12:23:34 +0800 (CST)
Subject: Re: [PULL 1/6] target/loongarch: Fix vldi inst
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 ghy <2247883756@qq.com>, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20241225024008.486236-1-maobibo@loongson.cn>
 <20241225024008.486236-2-maobibo@loongson.cn>
 <b691d979-848e-4fc9-8ede-3b16c6de732f@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <db21ace6-a4b1-adaf-7f7b-6d4aae312de9@loongson.cn>
Date: Thu, 26 Dec 2024 12:22:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b691d979-848e-4fc9-8ede-3b16c6de732f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7+VF2mxnp5AJAA--.51052S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr1rAr1xKryUKw4UZF1kWFX_yoWkXFgEgF
 WIkr1kuw1UWwn3CF9YqFWDJFy8u3yrXan8Ca1DXrWfX34jgayDCFn5trn3Za4YyrW0yr13
 Ars7XrW8u343ZosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqE5I8CrVACY4xI64kE6c02F40Ex7xfMIIYY7kG6xAYrbIjqfuFe4nvWSU5
 nxnvy29KBjDU0xBIdaVrnRJUUUvlb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zV
 CF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY
 1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20x
 vEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE
 c7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I
 8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj
 6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7
 IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
 0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
 0_JF0_Jw1lIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
 xhVjvjDU0xZFpf9x07b7BT5UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.536,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



On 2024/12/25 下午7:32, Philippe Mathieu-Daudé wrote:
> Hi Bibo,
> 
> On 25/12/24 03:40, Bibo Mao wrote:
>> From: ghy <2247883756@qq.com>
> 
> Is this authorship correct? Should it be:
> From: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
yes, this is better.
> 
>>
>> Refer to the link below for a description of the vldi instructions:
>> https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/#synopsis_88 
>>
>> Fixed errors in vldi instruction implementation.
>>
>> Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
> 
> to match the S-o-b?
Guo Hongyu submits the first version with attachment, xianglai tests it 
and submit again with plain text. I added them both with S-o-b -:)

What to do in this condition?

Regards
Bibo Mao
> 
>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 


