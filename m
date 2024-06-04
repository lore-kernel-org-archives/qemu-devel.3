Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E3FC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEThH-0006GP-Jz; Tue, 04 Jun 2024 08:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sEThE-0006FA-T8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:55:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sEThB-0007ZV-F8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:55:24 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxUPCyDl9mRmQDAA--.14701S3;
 Tue, 04 Jun 2024 20:55:14 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axw8SwDl9m_0IUAA--.40003S3; 
 Tue, 04 Jun 2024 20:55:14 +0800 (CST)
Subject: Re: [PATCH 0/5] hw/mips/loongson3_virt: Implement IPI support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <a9717e72-9de2-469f-89c1-8ae969b0031e@linaro.org>
 <75c78b9e-4a18-4faf-9b80-a497d3401dba@app.fastmail.com>
 <96870199-5782-4d87-ba10-f4b886936a96@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <3836d4b2-ed2d-3a4c-7092-54d0d9e1429d@loongson.cn>
Date: Tue, 4 Jun 2024 20:55:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <96870199-5782-4d87-ba10-f4b886936a96@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axw8SwDl9m_0IUAA--.40003S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZry5Kw18GrW3Cw15Gw1Utwc_yoW8JrW7pr
 9ay3WFyF47Gr18Crs7t345WFyjk3ykZw12qFnagFy8Wrn0qr10gr1kWF1qgas8Zws5Gr12
 9F43KasruF4UJrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8vA
 pUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.522,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

在 2024/6/3 下午11:35, Philippe Mathieu-Daudé 写道:
> On 16/5/24 12:53, Jiaxun Yang wrote:
>>
>>
>> 在2024年5月8日五月 下午10:41，Philippe Mathieu-Daudé写道：
>>> On 8/5/24 15:06, Jiaxun Yang wrote:
>>>> Hi all,
>>>>
>>>> This series enabled IPI support for loongson3 virt board, loosely
>>>> based on my previous work[1].
>>>> It generalized loongarch_ipi device to share among both loongarch
>>>> and MIPS machines.
>>>
>>>
>>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>>> ---
>>>> Jiaxun Yang (5):
>>>>         hw/intc/loongarch_ipi: Remove pointless MAX_CPU check
>>>>         hw/intc/loongarch_ipi: Rename as loongson_ipi
>>>>         hw/intc/loongson_ipi: Implement IOCSR address space for MIPS
>>>
>>> So far patches 1-3 queued to hw-misc tree, thanks.
>>
>> Hi Philippe,
>>
>> Thanks! What's your plan with the rest of the series
>
> Patches LGTM, but I'd like an Acked-by from Song Gao ;)
>
Patch 1 - 4:
Acked-by: Song Gao <gaosong@loongson.cn>

and patch2 missed to delete the file loongarch_ipi.c.

Thanks.
Song Gao
>> and earlier MIPS CPS SMP series?
>
> No plan, just lack of time :/
>
>> Let me know if you need help on testing etc.
>>
>> Thanks


