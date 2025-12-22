Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AD6D68BD5
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 03:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXWaA-0005iz-IV; Sun, 21 Dec 2025 22:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vXWa7-0005iP-TM
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 22:27:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vXWa5-0000bE-EK
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 22:27:35 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dx+8KXukhp_sUBAA--.5321S3;
 Mon, 22 Dec 2025 11:27:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxfcKOukhp4y8DAA--.7182S3;
 Mon, 22 Dec 2025 11:27:13 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: Permit bytes/half access to IOCSR
To: Yao Zi <me@ziyao.cc>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org
References: <20251221122205.56463-2-me@ziyao.cc>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <ad1e33d6-8568-e050-f7d8-eb656a4af729@loongson.cn>
Date: Mon, 22 Dec 2025 11:24:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251221122205.56463-2-me@ziyao.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxfcKOukhp4y8DAA--.7182S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF1UZF1DXr48GF47GFW8KrX_yoW8Xw4fpr
 yDuwnYkrW8Kr9rXas0ga43XF15CrZrGr42gay29rWUurn3Xr1YvFWYv3s09FZ7Zr97ZF1q
 vr1kW34fXF48ZwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.354,
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



On 2025/12/21 下午8:22, Yao Zi wrote:
> IOCSRs could be accessed in any sizes from 1 to 8 bytes as long as the
> address is aligned, regardless whether through MMIO or iocsr{rd,wr}
> instructions. Lower min_access_size to 1 byte for IOCSR memory region to
> match real-hardware behavior.
Hi Yao,

What is the detailed problem you encountered? Or just look through code 
and think that it should be so.

IOCSR supports 1/2/4/8 byte access like MMIO, however here is IOCSR MISC 
device rather than IOCSR bus emulation. What is the usage and scenery to 
read IOCSR MISC device with one byte?

It is similar with other device emulation with MMIO, such as e1000e with 
4 bytes aligned rather than any byte:
static const MemoryRegionOps mmio_ops = {
     .read = e1000e_mmio_read,
     .write = e1000e_mmio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
};


Regards
Bibo Mao
> 
> Fixes: f84a2aacf5d1 ("target/loongarch: Add LoongArch IOCSR instruction")
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>   hw/loongarch/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 49434ad1828b..5cc57e9b5aa7 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -692,7 +692,7 @@ static const MemoryRegionOps virt_iocsr_misc_ops = {
>       .write_with_attrs = virt_iocsr_misc_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
> -        .min_access_size = 4,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> 


