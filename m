Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72C5C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sETPi-00085a-BI; Tue, 04 Jun 2024 08:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sETPg-00084l-4P
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:37:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sETPd-0000FV-Hv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:37:15 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxHutxCl9mv2IDAA--.14416S3;
 Tue, 04 Jun 2024 20:37:05 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx68ZvCl9mqz4UAA--.50586S3; 
 Tue, 04 Jun 2024 20:37:05 +0800 (CST)
Subject: Re: [PATCH 3/5] hw/intc/loongson_ipi: Implement IOCSR address space
 for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, bibo mao <maobibo@loongson.cn>
References: <20240508-loongson3-ipi-v1-0-1a7b67704664@flygoat.com>
 <20240508-loongson3-ipi-v1-3-1a7b67704664@flygoat.com>
 <a3700c0c-889e-4bae-8a91-e374f8a5e03a@linaro.org>
 <78c0f76a-327a-4f67-a016-c9f73560494b@app.fastmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <492f08d2-b901-7a30-c434-065ff88ca41e@loongson.cn>
Date: Tue, 4 Jun 2024 20:37:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <78c0f76a-327a-4f67-a016-c9f73560494b@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx68ZvCl9mqz4UAA--.50586S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr17AFy3JFy7XFWxZrWDtrc_yoW3Zrb_Aw
 1aya97ZryvqFZ0qF4vqayUA343CFWxGrn0934xXr4xJw4SqFyqqr9akF12vaySga4xtr47
 tFyjqa4rZrWUuosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkU
 UUUU=
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

在 2024/6/4 下午6:35, Jiaxun Yang 写道:
>
> 在2024年6月3日六月 下午4:45，Philippe Mathieu-Daudé写道：
> [...]
>> LoongsonIPI should have an array of CPUState[] and MemoryRegion[].
>> (Or maybe add them to IPICore.)
>> Expose them as QOM link properties.
>>
>> Caller wire them while creating the LoongsonIPI.
>> Then loongson_ipi_realize() resolves them once.
>> No need to call get_cpu_iocsr_as() and ipi_getcpu() for each MMIO
>> access IMO.
> I was tempted to do so but realized that arch_id might be discontinuous
> for LoongArch.
>
> @Song, can you confirm if it's viable?
I confirmed from Bibo that the arch_id may not be continuous in the future.

Thanks.
Song Gao
> Thanks
> - Jiaxun
>>> +
>>> +    if (!iocsr_as) {
>>> +        return MEMTX_DECODE_ERROR;
>>> +    }


