Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE838C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 08:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhkvj-00030B-LZ; Fri, 01 Aug 2025 04:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uhkve-0002tZ-9t; Fri, 01 Aug 2025 04:15:51 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1uhkvb-0006IO-Gb; Fri, 01 Aug 2025 04:15:49 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxnOKmd4xoNZ02AQ--.7496S3;
 Fri, 01 Aug 2025 16:15:34 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxT+ajd4xoBcowAA--.45397S3;
 Fri, 01 Aug 2025 16:15:33 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_pch_pic: Fix ubsan warning and
 endianness issue
To: Thomas Huth <thuth@redhat.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20250801060152.22224-1-thuth@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <b2440540-76ac-c4da-03ca-2e4aaf07251e@loongson.cn>
Date: Fri, 1 Aug 2025 16:18:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250801060152.22224-1-thuth@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxT+ajd4xoBcowAA--.45397S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFy7Kr1rJFy5Jr1fXF1rXwc_yoW5uFykpF
 W3CryYvr4kJFZFgas7A34UZrW7Wrn7W34agws0k340k39rZrykZFyUJFZ7XFyYk348JryU
 XF45Ww1YvasrWabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.789, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2025/8/1 ÏÂÎç2:01, Thomas Huth Ð´µÀ:
> From: Thomas Huth <thuth@redhat.com>
>
> When booting the Linux kernel from tests/functional/test_loongarch64_virt.py
> with a QEMU that has been compiled with --enable-ubsan, there is
> a warning like this:
>
>   .../hw/intc/loongarch_pch_pic.c:171:46: runtime error: index 512 out of
>    bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
>    .../hw/intc/loongarch_pch_pic.c:171:46
>   .../hw/intc/loongarch_pch_pic.c:175:45: runtime error: index 256 out of
>    bounds for type 'uint8_t[64]' (aka 'unsigned char[64]')
>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior
>    .../hw/intc/loongarch_pch_pic.c:175:45
>
> It happens because "addr" is added first before substracting the base
> (PCH_PIC_HTMSI_VEC or PCH_PIC_ROUTE_ENTRY).
> Additionally, this code looks like it is not endianness safe, since
> it uses a 64-bit pointer to write values into an array of 8-bit values.
>
> Thus rework the code to use the stq_le_p / ldq_le_p helpers here
> and make sure that we do not create pointers with undefined behavior
> by accident.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/intc/loongarch_pch_pic.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index c4b242dbf41..32f01aabf0e 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -110,10 +110,10 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
>           val = s->int_polarity;
>           break;
>       case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> -        val = *(uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
> +        val = ldq_le_p(&s->htmsi_vector[addr - PCH_PIC_HTMSI_VEC]);
>           break;
>       case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> -        val = *(uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
> +        val = ldq_le_p(&s->route_entry[addr - PCH_PIC_ROUTE_ENTRY]);
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,
> @@ -129,7 +129,8 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
>   {
>       LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
>       uint32_t offset;
> -    uint64_t old, mask, data, *ptemp;
> +    uint64_t old, mask, data;
> +    void *ptemp;
>   
>       offset = addr & 7;
>       addr -= offset;
> @@ -168,12 +169,12 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
>           s->int_polarity = (s->int_polarity & ~mask) | data;
>           break;
>       case PCH_PIC_HTMSI_VEC ... PCH_PIC_HTMSI_VEC_END:
> -        ptemp = (uint64_t *)(s->htmsi_vector + addr - PCH_PIC_HTMSI_VEC);
> -        *ptemp = (*ptemp & ~mask) | data;
> +        ptemp = &s->htmsi_vector[addr - PCH_PIC_HTMSI_VEC];
> +        stq_le_p(ptemp, (ldq_le_p(ptemp) & ~mask) | data);
>           break;
>       case PCH_PIC_ROUTE_ENTRY ... PCH_PIC_ROUTE_ENTRY_END:
> -        ptemp = (uint64_t *)(s->route_entry + addr - PCH_PIC_ROUTE_ENTRY);
> -        *ptemp = (*ptemp & ~mask) | data;
> +        ptemp = (uint64_t *)&s->route_entry[addr - PCH_PIC_ROUTE_ENTRY];
> +        stq_le_p(ptemp, (ldq_le_p(ptemp) & ~mask) | data);
>           break;
>       default:
>           qemu_log_mask(LOG_GUEST_ERROR,


