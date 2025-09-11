Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B73CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwh2d-0007VW-FB; Thu, 11 Sep 2025 09:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwh2X-0007UC-Sn; Thu, 11 Sep 2025 09:08:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uwh2U-0006zu-Vb; Thu, 11 Sep 2025 09:08:41 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxztLMycJouj0JAA--.19659S3;
 Thu, 11 Sep 2025 21:08:28 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxocLLycJorRaOAA--.57042S3;
 Thu, 11 Sep 2025 21:08:28 +0800 (CST)
Subject: Re: [PULL 1/2] target/loongarch: Guard 64-bit-only insn translation
 with TRANS64 macro
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, WANG Rui <wangrui@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>,
 Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250828120218.1227427-1-gaosong@loongson.cn>
 <20250828120218.1227427-2-gaosong@loongson.cn>
 <fe6cc32a-1586-47bf-9ecc-ec8100372240@tls.msk.ru>
 <84a347ed-3ad1-45d0-af08-1bb187390c0c@tls.msk.ru>
From: gaosong <gaosong@loongson.cn>
Message-ID: <35f2ab55-3b40-e93f-606e-a3f8e7ebc932@loongson.cn>
Date: Thu, 11 Sep 2025 21:08:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <84a347ed-3ad1-45d0-af08-1bb187390c0c@tls.msk.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxocLLycJorRaOAA--.57042S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF1xtr1kXF15GrWfWrW7trc_yoWkArb_Wr
 yxAryDC343Ca13Xa1Ykw1rX3ZrJw1IqF1fArZxXr47J34fZw1ruF4Ygr1Yvr97ta4fJa98
 Cw40ga95Aw12gosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
 oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F4
 0EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_
 Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbI
 xvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
 xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrx
 kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
 6r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
 CI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1LvtUUUUU
 =
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.551,
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

在 2025/9/11 下午6:30, Michael Tokarev 写道:
> On 11.09.2025 13:04, Michael Tokarev wrote:
> ...
>> The same applies to the second patch in this series, btw, -- the second
>> patch also does not apply to 10.0.x directly because 10.0 lacks commit
>> ab9bbee3c7da3 "hw/intc/loongarch_pch: Modify name of some registers" --
>> the commit is just some code renames, it does not change actual code, so
>> it is a no-op, but it makes subsequent changes to not apply directly.
>> I think I'll pick ab9bbee3c7da3 and the next one, 4f0f2ab5640ef
>> "hw/intc/loongarch_pch: Modify register name PCH_PIC_xxx_OFFSET..",
>> to 10.0.x too.
>
> And nope, the second patch ("loongarch_pch_pic: Fix ubsan warning and
> endianness issue") is a bit more involved in 10.0.x, since 10.0 also
> misses a6fdd0032ce5c7c "loongarch_pch: Use generic write callback for
> iomem8 region", which is one from larger refactoring series. Sigh.
>
hi,

If these patches introduce too many dependencies, feel free to ignore them. This isn't a critical bug:-).

Thanks.
Song Gao

> loongarch is a fast-moving target still.. :)
>
> Thanks,
>
> /mjt


