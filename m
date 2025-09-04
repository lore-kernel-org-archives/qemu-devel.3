Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AFDCA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 09:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu6fo-0005ri-G5; Thu, 04 Sep 2025 05:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uu6fl-0005qC-Fg
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 05:54:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uu6fa-0002Qr-6q
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 05:54:29 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx6tHEYblob54GAA--.14101S3;
 Thu, 04 Sep 2025 17:54:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxXMHBYblozrV9AA--.15040S3;
 Thu, 04 Sep 2025 17:54:12 +0800 (CST)
Subject: Re: [PATCH v3 09/12] target/loongarch: Use loongarch_tlb_search_cb in
 helper_invtlb_page_asid
To: Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250903084827.3085911-1-maobibo@loongson.cn>
 <20250903084827.3085911-10-maobibo@loongson.cn>
 <6819c70b-57af-4155-baf1-8e9a6b8cb93b@linaro.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4a2a183c-ea45-72b5-3035-40982429e579@loongson.cn>
Date: Thu, 4 Sep 2025 17:52:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6819c70b-57af-4155-baf1-8e9a6b8cb93b@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxXMHBYblozrV9AA--.15040S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr4kWrWrurWxXw17KrW3urX_yoW8JFWDpr
 WfCFW7KFW8Jas3JFySgw1YqF9xXrWkJw4IqFn3t3WrAwnxJw1vqr4vq34v9Fy8JFWxWF1j
 qr4Yvr1UZFW2qacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8PCzJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.65,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/9/3 下午9:21, Richard Henderson wrote:
> On 9/3/25 10:48, Bibo Mao wrote:
>> With function helper_invtlb_page_asid(), currently it is to search
>> TLB entry one by one. Instead STLB can be searched at first with hash
>> method, and then search MTLB with one by one method
>>
>> Here common API loongarch_tlb_search_cb() is used in function
>> helper_invtlb_page_asid()
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/tcg/tlb_helper.c | 42 +++++++++++++++----------------
>>   1 file changed, 20 insertions(+), 22 deletions(-)
>>
>> diff --git a/target/loongarch/tcg/tlb_helper.c 
>> b/target/loongarch/tcg/tlb_helper.c
>> index 620de85a3a..c074c956a2 100644
>> --- a/target/loongarch/tcg/tlb_helper.c
>> +++ b/target/loongarch/tcg/tlb_helper.c
>> @@ -32,6 +32,15 @@ static bool tlb_match_any(int global, int asid, int 
>> tlb_asid)
>>       return false;
>>   }
>> +static bool tlb_match_asid(int global, int asid, int tlb_asid)
>> +{
>> +    if (!global && tlb_asid == asid) {
>> +        return true;
>> +    }
>> +
>> +    return false;
> 
> return !global && tlb_asid == asid;
will do.

Regards
Bibo Mao
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~


