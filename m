Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05BC83F1D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 02:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub8mp-0002Up-4S; Sun, 13 Jul 2025 22:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ub8lD-0001O5-GO; Sun, 13 Jul 2025 22:17:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1ub8lA-00080j-VQ; Sun, 13 Jul 2025 22:17:43 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxnOK7aHRoc+koAQ--.50089S3;
 Mon, 14 Jul 2025 10:17:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDx_8O5aHRoyDcWAA--.56259S3;
 Mon, 14 Jul 2025 10:17:31 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix valid virtual address checking
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20250714015446.746163-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <419f967a-dd43-52fa-fca7-adae747ea0c9@loongson.cn>
Date: Mon, 14 Jul 2025 10:20:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250714015446.746163-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDx_8O5aHRoyDcWAA--.56259S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw48KF18JrykZFyUZr1rKrX_yoW8Ary7pF
 93Ar1rKF4kGFZrJa1jvayYgrW5tr1DC3W7Xanrtryjkan8Xr1xuFWjkw4jgFsrZ348Cr4I
 q3WIkFW2vF15XagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CP
 fJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.992, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/7/14 ÉÏÎç9:54, Bibo Mao Ð´µÀ:
> On LoongArch64 system, the high 32 bit of 64 bit virtual address should be
> 0x00000[0-7]yyy or 0xffff8yyy. The bit from 47 to 63 should be all 0 or
> all 1.
>
> Function get_physical_address() only checks bit 48 to 63, there will be
> problem with the following test case. On physical machine, there is bus
> error report and program exits abnormally. However on qemu TCG system
> emulation mode, the program runs normally. The virtual address
> 0xffff000000000000ULL + addr and addr are treated the same on TLB entry
> checking. This patch fixes this issue.
>
> void main()
> {
>          void *addr, *addr1;
>          int val;
>
>          addr = malloc(100);
>          *(int *)addr = 1;
>          addr1 = 0xffff000000000000ULL + addr;
>          val = *(int *)addr1;
>          printf("val %d \n", val);
> }
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Acked-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index e172b11ce1..b5f732f15b 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -196,8 +196,8 @@ int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>       }
>   
>       /* Check valid extension */
> -    addr_high = sextract64(address, TARGET_VIRT_ADDR_SPACE_BITS, 16);
> -    if (!(addr_high == 0 || addr_high == -1)) {
> +    addr_high = (int64_t)address >> (TARGET_VIRT_ADDR_SPACE_BITS - 1);
> +    if (!(addr_high == 0 || addr_high == -1ULL)) {
>           return TLBRET_BADADDR;
>       }
>   
>
> base-commit: 9a4e273ddec3927920c5958d2226c6b38b543336


