Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FDCECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sneCh-000108-VF; Mon, 09 Sep 2024 09:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sneCe-0000za-5r
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:13:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sneCa-0004xS-B4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:13:11 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxPute9N5m8tcCAA--.7278S3;
 Mon, 09 Sep 2024 21:13:02 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMDx_OVc9N5mmoYCAA--.11830S3;
 Mon, 09 Sep 2024 21:13:01 +0800 (CST)
Subject: Re: [PATCH v4 2/2] target/loongarch: Implement lbt registers
 save/restore function
From: gaosong <gaosong@loongson.cn>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, qemu-devel@nongnu.org
References: <20240904061859.86615-1-maobibo@loongson.cn>
 <20240904061859.86615-3-maobibo@loongson.cn>
 <c14c8927-bb9b-9c3f-dca7-c86f79e73770@loongson.cn>
Message-ID: <7ddb45a0-e685-2af0-749a-821cc08f22e8@loongson.cn>
Date: Mon, 9 Sep 2024 21:13:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <c14c8927-bb9b-9c3f-dca7-c86f79e73770@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMDx_OVc9N5mmoYCAA--.11830S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWruw1DAryDJr18WFW3Kr1ktFc_yoWDWrcEya
 4IkrykWr1UWa18GFyYv3y5Ja45Ja18t3Z0vFWDXr48Kry8XrZ8Gws0q3Z5Z3W0gr48Arn8
 AFnaqr1fAr13KosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.396,
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

在 2024/9/9 下午7:52, gaosong 写道:
>
>
> 在 2024/9/4 下午2:18, Bibo Mao 写道:
>> Six registers scr0 - scr3, eflags and ftop are added in percpu vmstate.
>> And two functions kvm_loongarch_get_lbt/kvm_loongarch_put_lbt are added
>> to save/restore lbt registers.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   target/loongarch/cpu.h     | 12 ++++++++
>>   target/loongarch/kvm/kvm.c | 60 ++++++++++++++++++++++++++++++++++++++
>>   target/loongarch/machine.c | 24 +++++++++++++++
>>   3 files changed, 96 insertions(+)
>>
>
> Reviewed-by: Song Gao <gaosong@loongson.cn>
>
> Thanks
> Song Gao
Hi,  this patch need rebase.

Applying: target/loongarch: Implement lbt registers save/restore function
error: sha1 information is lacking or useless (target/loongarch/kvm/kvm.c).
error: could not build fake ancestor
Patch failed at 0001 target/loongarch: Implement lbt registers 
save/restore function


Thanks.
Song Gao.


