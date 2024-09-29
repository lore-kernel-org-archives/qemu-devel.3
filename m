Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103A5CF6497
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 04:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sulDa-0005li-PX; Sun, 29 Sep 2024 00:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sulDY-0005l7-Po
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 00:07:32 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sulDW-00005s-8A
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 00:07:32 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxjnN10vhmX5cDAA--.3130S3;
 Sun, 29 Sep 2024 12:07:18 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxL9Zz0vhmN58UAA--.47472S3;
 Sun, 29 Sep 2024 12:07:17 +0800 (CST)
Subject: Re: [PATCH v4 2/2] target/loongarch: Implement lbt registers
 save/restore function
To: gaosong <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
References: <20240904061859.86615-1-maobibo@loongson.cn>
 <20240904061859.86615-3-maobibo@loongson.cn>
 <c14c8927-bb9b-9c3f-dca7-c86f79e73770@loongson.cn>
 <7ddb45a0-e685-2af0-749a-821cc08f22e8@loongson.cn>
 <a15a6f5d-5f9b-2bde-1300-81bd53ca25fa@loongson.cn>
 <c7257d12-dad4-7d1e-2fb7-876599a820a8@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <4a97ff6e-6225-ceab-74b2-b274cd2fbae5@loongson.cn>
Date: Sun, 29 Sep 2024 12:07:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c7257d12-dad4-7d1e-2fb7-876599a820a8@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxL9Zz0vhmN58UAA--.47472S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw4xGw15XrW5AF4kuw17urX_yoW8Zw45p3
 sxAF15KF45J397Aw4aq3WrJrWaqrs7Gr12q3s3Jry8Cws8Kr1Fqr18t39FkasrX34rGF1j
 qF45W343uFn8ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.165,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 2024/9/23 下午9:02, gaosong wrote:
> 在 2024/9/10 上午10:24, maobibo 写道:
>>
>>
>> On 2024/9/9 下午9:13, gaosong wrote:
>>> 在 2024/9/9 下午7:52, gaosong 写道:
>>>>
>>>>
>>>> 在 2024/9/4 下午2:18, Bibo Mao 写道:
>>>>> Six registers scr0 - scr3, eflags and ftop are added in percpu 
>>>>> vmstate.
>>>>> And two functions kvm_loongarch_get_lbt/kvm_loongarch_put_lbt are 
>>>>> added
>>>>> to save/restore lbt registers.
>>>>>
>>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>>> ---
>>>>>   target/loongarch/cpu.h     | 12 ++++++++
>>>>>   target/loongarch/kvm/kvm.c | 60 
>>>>> ++++++++++++++++++++++++++++++++++++++
>>>>>   target/loongarch/machine.c | 24 +++++++++++++++
>>>>>   3 files changed, 96 insertions(+)
>>>>>
>>>>
>>>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>>>>
>>>> Thanks
>>>> Song Gao
>>> Hi,  this patch need rebase.
>>>
>>> Applying: target/loongarch: Implement lbt registers save/restore 
>>> function
>>> error: sha1 information is lacking or useless 
>>> (target/loongarch/kvm/kvm.c).
>>> error: could not build fake ancestor
>>> Patch failed at 0001 target/loongarch: Implement lbt registers 
>>> save/restore function
>>
>> Hi Song,
>>
>> It can apply with the latest qemu version on my side, only that it 
>> fails to compile since kvm uapi header files need be updated.
>>
>> LBT patch on qemu side can be skipped here since it depends on LBT 
>> patch merged on kernel side firstly.
>>
> Hi,
> 
> The LBT patches already merged on kernel side.
> Could you update this series  and add a patch to support gdb LBT feature ?
Hi Song,

QEMU TCG does not support LBT, and kernel does not use LBT and it is 
only saved and restored in kernel mode. gdb can be used to debug user 
app if there is such requirements.

There is no obvious requirement to debug kernel with LBT function, how 
about adding the function if there is such requirement in future.

Regards
Bibo Mao
> 
> Thanks.
> Song Gao
> 
>> Regards
>> Bibo Mao
>>>
>>>
>>> Thanks.
>>> Song Gao.
>>>


