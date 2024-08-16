Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4E0C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 01:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1selp4-00058l-0V; Thu, 15 Aug 2024 21:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1selp2-00057V-F6; Thu, 15 Aug 2024 21:32:08 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1seloz-0006Q5-V1; Thu, 15 Aug 2024 21:32:08 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxHJsLrL5mt7gVAA--.13677S3;
 Fri, 16 Aug 2024 09:31:56 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMBxNOIJrL5mp1QWAA--.37769S3;
 Fri, 16 Aug 2024 09:31:54 +0800 (CST)
Subject: Re: [PATCH for-9.1] linux-user: Handle short reads in mmap_h_gt_g
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240815213231.303424-1-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <67c74443-43ee-e432-c05c-9e1c7c27ccb0@loongson.cn>
Date: Fri, 16 Aug 2024 09:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240815213231.303424-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxNOIJrL5mp1QWAA--.37769S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw18trW5JF43Zr4kJF4fZwc_yoW8Gw47pF
 90q3Z5Jr45t3W7ZFsxCry0gFnYqF48t3WUK3srJ34rZ3yvqF1fWrn8G3Z0qFWkXFy8AF45
 ZFsIyFsFka1q9rgCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.843, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/8/16 ÉÏÎç5:32, Richard Henderson Ð´µÀ:
> In particular, if an image has a large bss, we can hit
> EOF before reading all host_len bytes of the mapping.
>
> Cc: qemu-stable@nongnu.org
> Fixes: eb5027ac618 ("linux-user: Split out mmap_h_gt_g")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2504
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 6418e811f6..de9ab13754 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -853,10 +853,21 @@ static abi_long mmap_h_gt_g(abi_ulong start, abi_ulong len,
>       }
>   
>       if (misaligned_offset) {
> -        /* TODO: The read could be short. */
> -        if (pread(fd, p, host_len, offset + real_start - start) != host_len) {
> -            do_munmap(p, host_len);
> -            return -1;
> +        size_t o = 0;
> +        while (1) {
> +            ssize_t r = pread(fd, p + o, host_len - o,
> +                              o + offset + real_start - start);
> +            if (likely(r == host_len - o) || r == 0) {
> +                /* Complete or EOF */
> +                break;
> +            }
> +            if (unlikely(r == -1)) {
> +                /* Error */
> +                do_munmap(p, host_len);
> +                return -1;
> +            }
> +            /* Short read -- iterate */
> +            o += r;
>           }
>           if (!(host_prot & PROT_WRITE)) {
>               mprotect(p, host_len, host_prot);


