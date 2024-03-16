Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51261C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlIhm-00059q-1Q; Fri, 15 Mar 2024 21:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rlIhg-00059H-UZ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:19:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rlIha-0001h2-6H
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:19:16 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dx6uiG8_Rlz7UZAA--.41994S3;
 Sat, 16 Mar 2024 09:19:03 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx7xOE8_Rl519bAA--.3931S2; 
 Sat, 16 Mar 2024 09:19:02 +0800 (CST)
Subject: Re: [PATCH V4 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn,
 yijun@loongson.cn, wuruiyang@loongson.cn
References: <cover.1710379781.git.lixianglai@loongson.cn>
 <0e940b2aee9a5c29bb41d6a9611955482d250325.1710379781.git.lixianglai@loongson.cn>
 <60733d71-daba-4f4a-a184-357526a3b3a0@linaro.org>
 <05a4b109-6e86-6ecf-4399-c0f9d5fd1a6f@loongson.cn>
 <90bde2c9-46fd-458c-9c32-22dac25bb069@linaro.org>
 <874eb7af-d1a0-0777-bc10-555381b85118@loongson.cn>
 <553e5eee-7af5-4ecf-b994-1bdd6ca8a820@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <44ca631d-dae0-0e5d-1566-986a602d3c29@loongson.cn>
Date: Sat, 16 Mar 2024 09:19:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <553e5eee-7af5-4ecf-b994-1bdd6ca8a820@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx7xOE8_Rl519bAA--.3931S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar1UGF1xuFy5JF1rAFy5GFX_yoW8uFyfpr
 n5JF98Kr98Grn3GFnrKw1jqry5tr1UJ3WUXr1UAFyUJr4Dtrn0qr48Zr1jgF1UJr48Jr4U
 Zr15Jr13Zr1UGrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.686,
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



在 2024/3/16 上午1:06, Richard Henderson 写道:
> On 3/14/24 23:01, lixianglai wrote:
>> Hi Richard :
>>
>>> On 3/14/24 20:22, lixianglai wrote:
>>>> Hi Richard:
>>>>> On 3/13/24 15:33, Xianglai Li wrote:
>>>>>> +    if (unlikely((level == 0) || (level > 4))) {
>>>>>> +        return base;
>>>>>> +    }
>>> ...
>>>>> Perhaps it would be worthwhile to add another for the level==0 or > 4 case above?
>>>>>
>>>> A normal level 4 page table should not print an error log,
>>>>
>>>> only if a level 4 page is large, so we should put it in
>>>>
>>>>      if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>>>>          if (unlikely(level == 4)) {
>>>>              qemu_log_mask(LOG_GUEST_ERROR,
>>>>                            "Attempted use of level %lu huge page\n", level);
>>>>          }
>>>>
>>>>          if (FIELD_EX64(base, TLBENTRY, LEVEL)) {
>>>>              return base;
>>>>          } else {
>>>>              return  FIELD_DP64(base, TLBENTRY, LEVEL, level);
>>>>          }
>>>>      }
>>>
>>> A level 5 page table is not normal, nor is a level 0 lddir.
>>>
>>
>> We communicate with the hardware guys that the behavior above level 4 and lddir 0 is undefined behavior.
>>
>> The result of our test on 3A5000 is that it has no any effect on "base",
>>
>> however in future chips the behavior may change since it may support 5-level page table and width for level[13:14] may change also.
>>
>>
>> So in this context,I am not sure which level to use to print logs,
>>
>> which content to print, and where to add these prints,
>>
>> any more detailed advice?
>
> Yes, right there in the IF that I quoted at the top.
> What I was trying to spell out is
>
>     if (unlikely(level == 0 || level > 4)) {
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "Attepted LDDIR with level %"PRId64"\n", level);
>         return base;
>     }
>
Thank you very much, I will modify it in V6 version of patch.

Thanks,
Xianglai.
>
> r~


