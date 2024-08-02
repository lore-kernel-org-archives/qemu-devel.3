Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C186C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 03:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZidV-00035E-R4; Thu, 01 Aug 2024 23:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sZidT-00034Y-Bx
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:07:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sZidQ-0005rh-Gv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 23:07:19 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx6elZTaxmrT4GAA--.21712S3;
 Fri, 02 Aug 2024 11:07:05 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxmcVVTaxmAR8LAA--.54278S3;
 Fri, 02 Aug 2024 11:07:03 +0800 (CST)
Subject: Re: [PATCH v5 00/19] Reconstruct loongson ipi driver
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bibo Mao <maobibo@loongson.cn>,
 QEMU devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20240718133312.10324-1-philmd@linaro.org>
 <c7e11721-812f-4ca5-9115-1ae060b4ff25@app.fastmail.com>
 <7c2c14e9-d6eb-4a8d-bb87-57ec289756d4@linaro.org>
 <1ca32405-41e1-423e-81e3-07e8569911c1@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <c41baa5b-dc9f-7838-1c23-0a7ad9a9fb8c@loongson.cn>
Date: Fri, 2 Aug 2024 11:07:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1ca32405-41e1-423e-81e3-07e8569911c1@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxmcVVTaxmAR8LAA--.54278S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFy8Jr4rZrWxZrWkAr4fWFX_yoWkCrc_Ww
 4FkasxAF1DJr4Uurs7WFn5Arn7KrZrJw1rX345JF1Yv3s3Jr4Yvws3Gry0qa4ayr4fArZx
 JFZayas3Z34j9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.288,
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

在 2024/7/23 下午6:19, Philippe Mathieu-Daudé 写道:
> On 19/7/24 15:04, Philippe Mathieu-Daudé wrote:
>> On 19/7/24 14:56, Jiaxun Yang wrote:
>>>
>>>
>>> 在2024年7月18日七月 下午9:32，Philippe Mathieu-Daudé写道：
>>>> Since v4:
>>>> - Fix build failure due to rebase (Song)
>>>> - Loongarch -> LoongArch (Song)
>>>> - Added Song's tags
>>>>
>>>> Since v3:
>>>> - Use DEFINE_TYPES() macro (unreviewed patch #1)
>>>> - Update MAINTAINERS
>>>> - Added Bibo's tags
>>>
>>> For the whole series:
>>>
>>> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>
>> Yeah!
>>
>>> Thanks! Tested on MIPS loongson3-virt with 2, 4 CPUs, all working fine.
>>>
>>> I'll get this covered by CI later.
>>
>> Thanks,
>>
>> I'm queuing this series.
>
> Due to pre-existing bug I have to drop this series :(
>
> See 
> https://lore.kernel.org/qemu-devel/492e9968-a05d-44b2-b374-1d839e49b6e3@linaro.org/.
Hi,  Philippe

This series is not merged, the bug still exists, if you don't want to 
merge this series for 9.1, can you fix this bug first?

Thanks.
Song Gao


