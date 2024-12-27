Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0377DE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 06:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR3iY-0002cB-7T; Fri, 27 Dec 2024 01:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tR3iU-0002bg-9W
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:20:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tR3iR-0000HF-IL
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:20:58 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxmeA9R25nkdlaAA--.48063S3;
 Fri, 27 Dec 2024 14:20:45 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxXcc4R25nKJ4KAA--.56179S3;
 Fri, 27 Dec 2024 14:20:43 +0800 (CST)
Subject: Re: [PULL 1/6] target/loongarch: Fix vldi inst
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 ghy <2247883756@qq.com>, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20241225024008.486236-1-maobibo@loongson.cn>
 <20241225024008.486236-2-maobibo@loongson.cn>
 <b691d979-848e-4fc9-8ede-3b16c6de732f@linaro.org>
 <db21ace6-a4b1-adaf-7f7b-6d4aae312de9@loongson.cn>
 <0083ebbd-2f94-4212-b138-8839630ea9c3@linaro.org>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <ae85aeca-20b3-9aff-6dd8-2bae4e062f6b@loongson.cn>
Date: Fri, 27 Dec 2024 14:19:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0083ebbd-2f94-4212-b138-8839630ea9c3@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXcc4R25nKJ4KAA--.56179S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr15Xr4DJry5GFW7ZFy7urX_yoW8WrykpF
 WfJ3WjkFWDKrZ09F4aga4xJr17KrWDGrn7X3Z7tryruF9Iqrn3tF12vr1jkFyDJr1xG3WU
 AFyUK34fWFWDZFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.896,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2024/12/27 上午1:38, Philippe Mathieu-Daudé wrote:
> On 26/12/24 05:22, bibo mao wrote:
>>
>>
>> On 2024/12/25 下午7:32, Philippe Mathieu-Daudé wrote:
>>> Hi Bibo,
>>>
>>> On 25/12/24 03:40, Bibo Mao wrote:
>>>> From: ghy <2247883756@qq.com>
>>>
>>> Is this authorship correct? Should it be:
>>> From: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
>> yes, this is better.
>>>
>>>>
>>>> Refer to the link below for a description of the vldi instructions:
>>>> https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/ 
>>>> #synopsis_88
>>>> Fixed errors in vldi instruction implementation.
>>>>
>>>> Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
>>>
>>> to match the S-o-b?
>> Guo Hongyu submits the first version with attachment, xianglai tests 
>> it and submit again with plain text. I added them both with S-o-b -:)
>>
>> What to do in this condition?
> 
> IIUC the technical issue, you can fix the authorship using:
> 
> git commit --amend --author='Guo Hongyu <guohongyu24@mails.ucas.ac.cn>'
oh, I see now. Mail author should be consistent with SOB. I had thought 
there could not be multiple SOBs :)

Thanks for pointing it out.

Regards
Bibo Mao
> 
>>
>> Regards
>> Bibo Mao
>>>
>>>> Tested-by: Xianglai Li <lixianglai@loongson.cn>
>>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
> 


