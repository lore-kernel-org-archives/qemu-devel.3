Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1624CF9C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 13:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssihM-0004Sg-6u; Mon, 23 Sep 2024 09:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ssihG-0004S4-Gl
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 09:01:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ssihD-0001nE-KN
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 09:01:46 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxB+mwZvFmOD4NAA--.29359S3;
 Mon, 23 Sep 2024 21:01:36 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMBxOsavZvFm7pkPAA--.63495S3;
 Mon, 23 Sep 2024 21:01:35 +0800 (CST)
Subject: Re: [PATCH v4 2/2] target/loongarch: Implement lbt registers
 save/restore function
To: maobibo <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
References: <20240904061859.86615-1-maobibo@loongson.cn>
 <20240904061859.86615-3-maobibo@loongson.cn>
 <c14c8927-bb9b-9c3f-dca7-c86f79e73770@loongson.cn>
 <7ddb45a0-e685-2af0-749a-821cc08f22e8@loongson.cn>
 <a15a6f5d-5f9b-2bde-1300-81bd53ca25fa@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c7257d12-dad4-7d1e-2fb7-876599a820a8@loongson.cn>
Date: Mon, 23 Sep 2024 21:02:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a15a6f5d-5f9b-2bde-1300-81bd53ca25fa@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMBxOsavZvFm7pkPAA--.63495S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww18Kr1DCF4ftryftF1rZrc_yoW8Wryrpa
 sxAFn8KrWUJrZ7Gw4agw18Xr90qws7Gr1jq3Wftry8Grs0kr1Fqr48t39F9F9rX34rGF1j
 gr40g343WF1DZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.417,
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

在 2024/9/10 上午10:24, maobibo 写道:
>
>
> On 2024/9/9 下午9:13, gaosong wrote:
>> 在 2024/9/9 下午7:52, gaosong 写道:
>>>
>>>
>>> 在 2024/9/4 下午2:18, Bibo Mao 写道:
>>>> Six registers scr0 - scr3, eflags and ftop are added in percpu 
>>>> vmstate.
>>>> And two functions kvm_loongarch_get_lbt/kvm_loongarch_put_lbt are 
>>>> added
>>>> to save/restore lbt registers.
>>>>
>>>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>>>> ---
>>>>   target/loongarch/cpu.h     | 12 ++++++++
>>>>   target/loongarch/kvm/kvm.c | 60 
>>>> ++++++++++++++++++++++++++++++++++++++
>>>>   target/loongarch/machine.c | 24 +++++++++++++++
>>>>   3 files changed, 96 insertions(+)
>>>>
>>>
>>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>>>
>>> Thanks
>>> Song Gao
>> Hi,  this patch need rebase.
>>
>> Applying: target/loongarch: Implement lbt registers save/restore 
>> function
>> error: sha1 information is lacking or useless 
>> (target/loongarch/kvm/kvm.c).
>> error: could not build fake ancestor
>> Patch failed at 0001 target/loongarch: Implement lbt registers 
>> save/restore function
>
> Hi Song,
>
> It can apply with the latest qemu version on my side, only that it 
> fails to compile since kvm uapi header files need be updated.
>
> LBT patch on qemu side can be skipped here since it depends on LBT 
> patch merged on kernel side firstly.
>
Hi,

The LBT patches already merged on kernel side.
Could you update this series  and add a patch to support gdb LBT feature ?

Thanks.
Song Gao

> Regards
> Bibo Mao
>>
>>
>> Thanks.
>> Song Gao.
>>


