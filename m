Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAA2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 02:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we2BM-00035f-Ph; Sun, 28 Jun 2026 22:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1we2BK-00035X-Ko
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 22:57:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1we2BI-0004OY-D0
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 22:57:10 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cx9OgC30FqKgEZAA--.57782S3;
 Mon, 29 Jun 2026 10:57:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxjcIB30FqDB63AA--.16609S3;
 Mon, 29 Jun 2026 10:57:05 +0800 (CST)
Subject: Re: [PATCH v2 4/4] target/loongarch/kvm: fix cpucfg sync error
 handling
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
References: <20260626052742.810726-1-cui.tao@linux.dev>
 <20260626052742.810726-5-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c3347155-cf4d-75e1-6ba4-173871a17344@loongson.cn>
Date: Mon, 29 Jun 2026 10:53:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260626052742.810726-5-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxjcIB30FqDB63AA--.16609S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWfGF45GrW8CFWftF18Zwc_yoW8Cr4fp3
 4ayF4YqFy8tr97Xan2v3s0gFy5Xr4xGwsrZFyxK3s3CrsxJr1xtFy8tanrZas8A3s7C3WF
 qFWSkF9I9FnrXabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
 xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
 6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
 1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
 JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
 vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
 x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
 xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
 wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/6/26 下午1:27, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> In kvm_loongarch_get_cpucfg() and kvm_loongarch_put_cpucfg(), ret is
> overwritten on each iteration, so only the last register's result is
> returned and earlier failures are lost. On a failed read, env->cpucfg[i]
> is stored from a stale or uninitialized val.
> 
> Accumulate errors with ret |=, matching kvm_loongarch_get_csr()/put_csr(),
> and only update env->cpucfg[i] on a successful read. Keep the cpucfg2
> negotiation check in put_cpucfg() on a separate variable so its early
> return does not overwrite the accumulated result.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   target/loongarch/kvm/kvm.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index a504cfaaf7..9f1ee41ef6 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -713,8 +713,11 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>       CPULoongArchState *env = cpu_env(cs);
>   
>       for (i = 0; i < 21; i++) {
> -        ret = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
> -        env->cpucfg[i] = (uint32_t)val;
> +        int r = kvm_get_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
> +        ret |= r;
> +        if (!r) {
> +            env->cpucfg[i] = (uint32_t)val;
> +        }
>       }
>       return ret;
>   }
> @@ -767,13 +770,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
>   
>       for (i = 0; i < 21; i++) {
>   	if (i == 2) {
> -            ret = kvm_check_cpucfg2(cs);
> -            if (ret) {
> -                return ret;
> +            int r = kvm_check_cpucfg2(cs);
> +            if (r) {
> +                return r;
>               }
>   	}
>           val = env->cpucfg[i];
> -        ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
> +        ret |= kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
>       }
>       return ret;
>   }
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


