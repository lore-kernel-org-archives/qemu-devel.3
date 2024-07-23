Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F711C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWCJu-0004lq-N6; Tue, 23 Jul 2024 06:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sWCJs-0004lK-6E
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:00:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sWCJp-0005vj-7x
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:00:31 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxi+owf59mGnEAAA--.1914S3;
 Tue, 23 Jul 2024 18:00:16 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxacYof59mco9VAA--.58361S3; 
 Tue, 23 Jul 2024 18:00:13 +0800 (CST)
Subject: Re: [PATCH v5 04/19] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <20240718133312.10324-5-philmd@linaro.org>
 <492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <2431160c-5f6e-cc99-5b3f-701ae352ba83@loongson.cn>
Date: Tue, 23 Jul 2024 18:00:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxacYof59mco9VAA--.58361S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxCry3AF1ruFyDAF1kJFc_yoW8Zw4kpr
 n2ya1Y9rW3Gr1kArs3GayDWFy3GrZ5J34DWFW7KFyUWrZ8Xw109a4jqayI9347ur4FvF1Y
 vrnYkrW09a1UCrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
 Z7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.04,
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

在 2024/7/23 下午4:41, Philippe Mathieu-Daudé 写道:
> On 18/7/24 15:32, Philippe Mathieu-Daudé wrote:
>> From: Bibo Mao <maobibo@loongson.cn>
>>
>> In preparation to extract common IPI code in few commits,
>> extract loongson_ipi_common_finalize().
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> [PMD: Extracted from bigger commit, added commit description]
>> Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> Tested-by: Bibo Mao <maobibo@loongson.cn>
>> Acked-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/intc/loongson_ipi.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
>> index d870af39c1..960d1e604f 100644
>> --- a/hw/intc/loongson_ipi.c
>> +++ b/hw/intc/loongson_ipi.c
>> @@ -357,13 +357,18 @@ static void loongson_ipi_class_init(ObjectClass 
>> *klass, void *data)
>>       dc->vmsd = &vmstate_loongson_ipi;
>>   }
>>   -static void loongson_ipi_finalize(Object *obj)
>> +static void loongson_ipi_common_finalize(Object *obj)
>>   {
>>       LoongsonIPIState *s = LOONGSON_IPI(obj);
>>         g_free(s->cpu);
>
> Unfortunately the current code is bogus, @cpu is allocated in
> loongson_ipi_realize(), a DeviceRealize handler, so must be
> de-allocated in a DeviceUnrealize equivalent. Not at the instance
> finalize cleanup which is too late because we could leak after
> UNREALIZE -> REALIZE sequences.
>
Yes,  we should use  DeviecUnrealize to free s->cpu.

I will send a patch to correct it.

Thanks.
Song Gao
>>   }
>>   +static void loongson_ipi_finalize(Object *obj)
>> +{
>> +    loongson_ipi_common_finalize(obj);
>> +}
>> +
>>   static const TypeInfo loongson_ipi_types[] = {
>>       {
>>           .name               = TYPE_LOONGSON_IPI,


