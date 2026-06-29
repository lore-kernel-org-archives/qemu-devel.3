Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548C2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 02:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we286-0002SL-RY; Sun, 28 Jun 2026 22:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1we284-0002Rx-7u
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 22:53:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1we281-0003Jc-Hr
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 22:53:48 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxX+su3kFq6QAZAA--.63511S3;
 Mon, 29 Jun 2026 10:53:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxB8Er3kFqDh23AA--.6626S3;
 Mon, 29 Jun 2026 10:53:33 +0800 (CST)
Subject: Re: [PATCH v2 1/4] target/loongarch/kvm: fix uninitialized val and
 unchecked GET in cpucfg2 check
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
References: <20260626052742.810726-1-cui.tao@linux.dev>
 <20260626052742.810726-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <48e32310-1c70-8e84-5055-0d8d773fd004@loongson.cn>
Date: Mon, 29 Jun 2026 10:50:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260626052742.810726-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxB8Er3kFqDh23AA--.6626S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWxAFWkuF43KF4kGr4ftFc_yoW8uF15pr
 n3Cw4YgFWrtrZ7Can7tw1qg34UZw1UKrsrZasxAwnakr43Kr17AFyIkanrWF15G34xJa10
 qF4jqrs8Zwn8XwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYSoJU
 UUUU=
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
> kvm_check_cpucfg2() discards the return value of KVM_GET_DEVICE_ATTR and
> uses the local val (the host cpucfg2 mask) without checking whether the
> read succeeded. val is also declared without an initializer, so on a GET
> failure env->cpucfg[2] &= val reads an uninitialized value.
> 
> The &= mask is best-effort feature negotiation: if KVM_HAS_DEVICE_ATTR
> succeeds, a GET failure is most likely a copy_{from,to}_user issue, not a
> reason to fail the whole register sync. Check the GET return value, warn and
> skip the mask on failure (the guest keeps the cpucfg2 it already has), and
> initialize val to 0.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   target/loongarch/kvm/kvm.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index d6539c12ac..5bd5e268b9 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -725,7 +725,7 @@ static int kvm_loongarch_get_cpucfg(CPUState *cs)
>   static int kvm_check_cpucfg2(CPUState *cs)
>   {
>       int ret;
> -    uint64_t val;
> +    uint64_t val = 0;
>       struct kvm_device_attr attr = {
>           .group = KVM_LOONGARCH_VCPU_CPUCFG,
>           .attr = 2,
> @@ -736,8 +736,17 @@ static int kvm_check_cpucfg2(CPUState *cs)
>       ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>   
>       if (!ret) {
> -        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> -        env->cpucfg[2] &= val;
> +        /*
> +         * The &= mask is best-effort feature negotiation. If HAS succeeded,
> +         * a GET failure is most likely a copy_{from,to}_user issue; warn and
> +         * keep the cpucfg2 the guest already has rather than failing the sync.
> +         */
> +        int r = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> +        if (r) {
> +            warn_report("CPUCFG2: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
> +        } else {
> +            env->cpucfg[2] &= val;
> +        }
>   
>           if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
>               /* The FP minimal version is 1. */
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


