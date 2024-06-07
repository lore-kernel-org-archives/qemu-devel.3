Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB75EC27C5E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 01:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFOmX-00078K-Ev; Thu, 06 Jun 2024 21:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sFOmU-00077u-OK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 21:52:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sFOmR-0000WG-RC
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 21:52:38 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bxb+vaZ2JmF3gEAA--.18897S3;
 Fri, 07 Jun 2024 09:52:26 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxnsfVZ2Jmz6AXAA--.59504S3; 
 Fri, 07 Jun 2024 09:52:23 +0800 (CST)
Subject: Re: [PATCH v2 2/2] util/bufferiszero: Add loongarch64 vector
 acceleration
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240607002443.5820-1-richard.henderson@linaro.org>
 <20240607002443.5820-3-richard.henderson@linaro.org>
From: maobibo <maobibo@loongson.cn>
Message-ID: <2768b597-e144-2634-4c11-43e2a1ae302e@loongson.cn>
Date: Fri, 7 Jun 2024 09:52:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240607002443.5820-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxnsfVZ2Jmz6AXAA--.59504S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyxZrWrArWxGr47ur47ZFc_yoW7XF47pa
 yrurZYkr10grnxZryDGr4kKr45ZrWYyw1YgayayFnxXrZ5trn8Wrs8ur10gr47Jwn3Jryj
 vF4UGFs5C34kJrbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.266,
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



On 2024/6/7 上午8:24, Richard Henderson wrote:
> Use inline assembly because no release compiler allows
> per-function selection of the ISA.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   .../loongarch64/host/bufferiszero.c.inc       | 143 ++++++++++++++++++
>   1 file changed, 143 insertions(+)
>   create mode 100644 host/include/loongarch64/host/bufferiszero.c.inc
> 
> diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
> new file mode 100644
> index 0000000000..69891eac80
> --- /dev/null
> +++ b/host/include/loongarch64/host/bufferiszero.c.inc
> @@ -0,0 +1,143 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * buffer_is_zero acceleration, loongarch64 version.
> + */
> +
> +/*
> + * Builtins for LSX and LASX are introduced by gcc 14 and llvm 18,
> + * but as yet neither has support for attribute target, so neither
> + * is able to enable the optimization without globally enabling
> + * vector support.  Since we want runtime detection, use assembly.
> + */
> +
> +static bool buffer_is_zero_lsx(const void *buf, size_t len)
> +{
> +    const void *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
> +    const void *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16) - (7 * 16);
> +    const void *l = buf + len;
> +    bool ret;
> +
> +    asm("vld $vr0,%2,0\n\t"             /* first: buf + 0 */
> +        "vld $vr1,%4,-16\n\t"           /* last: buf + len - 16 */
> +        "vld $vr2,%3,0\n\t"             /* e[0] */
> +        "vld $vr3,%3,16\n\t"            /* e[1] */
> +        "vld $vr4,%3,32\n\t"            /* e[2] */
> +        "vld $vr5,%3,48\n\t"            /* e[3] */
> +        "vld $vr6,%3,64\n\t"            /* e[4] */
> +        "vld $vr7,%3,80\n\t"            /* e[5] */
> +        "vld $vr8,%3,96\n\t"            /* e[6] */
> +        "vor.v $vr0,$vr0,$vr1\n\t"
> +        "vor.v $vr2,$vr2,$vr3\n\t"
> +        "vor.v $vr4,$vr4,$vr5\n\t"
> +        "vor.v $vr6,$vr6,$vr7\n\t"
> +        "vor.v $vr0,$vr0,$vr2\n\t"
> +        "vor.v $vr4,$vr4,$vr6\n\t"
> +        "vor.v $vr0,$vr0,$vr4\n\t"
> +        "vor.v $vr0,$vr0,$vr8\n\t"
> +        "or %0,$r0,$r0\n"               /* prepare return false */
> +    "1:\n\t"
> +        "vsetnez.v $fcc0,$vr0\n\t"
> +        "bcnez $fcc0,2f\n\t"
> +        "vld $vr0,%1,0\n\t"             /* p[0] */
> +        "vld $vr1,%1,16\n\t"            /* p[1] */
> +        "vld $vr2,%1,32\n\t"            /* p[2] */
> +        "vld $vr3,%1,48\n\t"            /* p[3] */
> +        "vld $vr4,%1,64\n\t"            /* p[4] */
> +        "vld $vr5,%1,80\n\t"            /* p[5] */
> +        "vld $vr6,%1,96\n\t"            /* p[6] */
> +        "vld $vr7,%1,112\n\t"           /* p[7] */
> +        "addi.d %1,%1,128\n\t"
> +        "vor.v $vr0,$vr0,$vr1\n\t"
> +        "vor.v $vr2,$vr2,$vr3\n\t"
> +        "vor.v $vr4,$vr4,$vr5\n\t"
> +        "vor.v $vr6,$vr6,$vr7\n\t"
> +        "vor.v $vr0,$vr0,$vr2\n\t"
> +        "vor.v $vr4,$vr4,$vr6\n\t"
> +        "vor.v $vr0,$vr0,$vr4\n\t"
> +        "bltu %1,%3,1b\n\t"
> +        "vsetnez.v $fcc0,$vr0\n\t"
> +        "bcnez $fcc0,2f\n\t"
> +        "ori %0,$r0,1\n"
> +    "2:"
> +        : "=&r"(ret), "+r"(p)
> +        : "r"(buf), "r"(e), "r"(l)
> +        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +
> +    return ret;
> +}
> +
> +static bool buffer_is_zero_lasx(const void *buf, size_t len)
> +{
> +    const void *p = QEMU_ALIGN_PTR_DOWN(buf + 32, 32);
> +    const void *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 32) - (7 * 32);
> +    const void *l = buf + len;
> +    bool ret;
> +
> +    asm("xvld $xr0,%2,0\n\t"             /* first: buf + 0 */
> +        "xvld $xr1,%4,-32\n\t"           /* last: buf + len - 32 */
> +        "xvld $xr2,%3,0\n\t"             /* e[0] */
> +        "xvld $xr3,%3,32\n\t"            /* e[1] */
> +        "xvld $xr4,%3,64\n\t"            /* e[2] */
> +        "xvld $xr5,%3,96\n\t"            /* e[3] */
> +        "xvld $xr6,%3,128\n\t"           /* e[4] */
> +        "xvld $xr7,%3,160\n\t"           /* e[5] */
> +        "xvld $xr8,%3,192\n\t"           /* e[6] */
> +        "xvor.v $xr0,$xr0,$xr1\n\t"
> +        "xvor.v $xr2,$xr2,$xr3\n\t"
> +        "xvor.v $xr4,$xr4,$xr5\n\t"
> +        "xvor.v $xr6,$xr6,$xr7\n\t"
> +        "xvor.v $xr0,$xr0,$xr2\n\t"
> +        "xvor.v $xr4,$xr4,$xr6\n\t"
> +        "xvor.v $xr0,$xr0,$xr4\n\t"
> +        "xvor.v $xr0,$xr0,$xr8\n\t"
> +        "or %0,$r0,$r0\n\t"              /* prepare return false */
> +        "bgeu %1,%3,2f\n"
> +    "1:\n\t"
> +        "xvsetnez.v $fcc0,$xr0\n\t"
> +        "bcnez $fcc0,3f\n\t"
> +        "xvld $xr0,%1,0\n\t"             /* p[0] */
> +        "xvld $xr1,%1,32\n\t"            /* p[1] */
> +        "xvld $xr2,%1,64\n\t"            /* p[2] */
> +        "xvld $xr3,%1,96\n\t"            /* p[3] */
> +        "xvld $xr4,%1,128\n\t"           /* p[4] */
> +        "xvld $xr5,%1,160\n\t"           /* p[5] */
> +        "xvld $xr6,%1,192\n\t"           /* p[6] */
> +        "xvld $xr7,%1,224\n\t"           /* p[7] */
> +        "addi.d %1,%1,256\n\t"
> +        "xvor.v $xr0,$xr0,$xr1\n\t"
> +        "xvor.v $xr2,$xr2,$xr3\n\t"
> +        "xvor.v $xr4,$xr4,$xr5\n\t"
> +        "xvor.v $xr6,$xr6,$xr7\n\t"
> +        "xvor.v $xr0,$xr0,$xr2\n\t"
> +        "xvor.v $xr4,$xr4,$xr6\n\t"
> +        "xvor.v $xr0,$xr0,$xr4\n\t"
> +        "bltu %1,%3,1b\n"
> +    "2:\n\t"
> +        "xvsetnez.v $fcc0,$xr0\n\t"
> +        "bcnez $fcc0,3f\n\t"
> +        "ori %0,$r0,1\n"
> +    "3:"
> +        : "=&r"(ret), "+r"(p)
> +        : "r"(buf), "r"(e), "r"(l)
> +        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +
> +    return ret;
> +}
> +
> +static biz_accel_fn const accel_table[] = {
> +    buffer_is_zero_int_ge256,
> +    buffer_is_zero_lsx,
> +    buffer_is_zero_lasx,
> +};
> +
> +static unsigned best_accel(void)
> +{
> +    unsigned info = cpuinfo_init();
> +    if (info & CPUINFO_LASX) {
> +        return 2;
> +    }
> +    if (info & CPUINFO_LSX) {
> +        return 1;
> +    }
> +    return 0;
> +}
> 

This is better than mine, there is no dependency on compiler option any 
more.

Tested-by: Bibo Mao <maobibo@loongson.cn>


