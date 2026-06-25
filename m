Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC669CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 03:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcabP-0004BW-Mn; Wed, 24 Jun 2026 23:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wcabJ-0004Ah-N9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 23:18:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wcabG-0006WV-57
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 23:18:00 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axp3jenTxqfq4XAA--.36135S3;
 Thu, 25 Jun 2026 11:17:50 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCxPMLdnTxqHFOyAA--.8913S3;
 Thu, 25 Jun 2026 11:17:49 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/kvm: set pv features per vCPU in
 kvm_arch_init_vcpu
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
References: <20260625015317.678762-1-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <39029c52-b386-f5b3-4cfb-e912121d224d@loongson.cn>
Date: Thu, 25 Jun 2026 11:14:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260625015317.678762-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPMLdnTxqHFOyAA--.8913S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFW3Gw48uFW3Kr1fKF48GrX_yoW8ZFy3pa
 y7CayYgr1rXrW0ywn7XayDXF45JrWxGw47ZF1UG34rAFn8WrnFqFy0kanFqF98C3s5WrWF
 qF4rJr9xu3WUAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
 SoJUUUUU=
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



On 2026/6/25 上午9:53, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> kvm_set_pv_features() programs the KVM_FEATURE cpucfg attribute, which is a
> per-vCPU setting. It was called from kvm_arch_put_registers() under a
> function-local static guard, so it ran only once for the whole VM and only
> the first vCPU actually got its pv features pushed to KVM.
> 
> Move the call to kvm_arch_init_vcpu(), which runs once per vCPU, right
> after the pv features are computed, and drop the static guard.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   target/loongarch/kvm/kvm.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index d6539c12ac..985812c828 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -816,7 +816,6 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>   int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>   {
>       int ret;
> -    static int once;
>   
>       ret = kvm_loongarch_put_regs_core(cs);
>       if (ret) {
> @@ -843,14 +842,6 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>           return ret;
>       }
>   
> -    if (!once) {
> -        ret = kvm_set_pv_features(cs);
> -        if (ret) {
> -            return ret;
> -        }
> -        once = 1;
> -    }
> -
>       if (level >= KVM_PUT_FULL_STATE) {
>           /*
>            * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
> @@ -1209,6 +1200,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           return ret;
>       }
>   
> +    /* pv_features is a per-vCPU attribute; set it here, once per vCPU. */
> +    ret = kvm_set_pv_features(cs);
> +    if (ret < 0) {
> +        return ret;
> +    }
I prefer the old method. The pv_features is one vCPU state instead, and 
it will be added in vCPU VMState if migration is supported on different 
host kernel version.

Here is host feature detection, not vCPU state setting.

Regards
Bibo Mao
> +
>       ret = kvm_cpu_check_ptw(cs, &local_err);
>       if (ret < 0) {
>           error_report_err(local_err);
> 


