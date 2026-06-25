Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E9CDB47C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 02:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcaCM-0007MT-P3; Wed, 24 Jun 2026 22:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wcaCK-0007ML-Fs
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 22:52:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wcaCH-0002di-Of
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 22:52:12 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxncDNlzxqcKwXAA--.37007S3;
 Thu, 25 Jun 2026 10:51:57 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBx78LMlzxqHk6yAA--.11889S3;
 Thu, 25 Jun 2026 10:51:56 +0800 (CST)
Subject: Re: [PATCH 1/4] target/loongarch/kvm: fix uninitialized val and
 unchecked GET in cpucfg2 check
To: Tao Cui <cui.tao@linux.dev>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@mailo.com>,
 Qiang Ma <maqianga@uniontech.com>, Tao Cui <cuitao@kylinos.cn>
References: <20260625015835.678819-1-cui.tao@linux.dev>
 <20260625015835.678819-2-cui.tao@linux.dev>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <0cf985f8-f109-bc7b-3353-3432dc017e59@loongson.cn>
Date: Thu, 25 Jun 2026 10:48:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260625015835.678819-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx78LMlzxqHk6yAA--.11889S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWxAw13XF15CF18ur1ktFc_yoW8uFyfpF
 4fCr4vgrWrtrZ7Kws7t34DWw1UZw1UGrsrCa4rAr97ArnxGr12kFyIkw4DGF15Z3s3JayS
 qF4Utan8Z3WDXwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l3
 8UUUUUU==
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



On 2026/6/25 上午9:58, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> kvm_check_cpucfg2() discards the return value of KVM_GET_DEVICE_ATTR and
> then uses the local val (the host cpucfg2 mask) without checking whether
> the read succeeded. val is also declared without an initializer.
> 
> If GET fails, env->cpucfg[2] &= val uses an uninitialized value and can
> silently clear feature bits (FP / LLFTP / LSX / LASX), since bitwise-AND
> can only turn bits off.
> 
> Check the GET return value, report the failure with error_report(), and
> initialize val to 0.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>   target/loongarch/kvm/kvm.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index d6539c12ac..b7176ce53a 100644
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
> @@ -736,7 +736,11 @@ static int kvm_check_cpucfg2(CPUState *cs)
>       ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
>   
>       if (!ret) {
> -        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
> +        if (ret) {
> +            error_report("CPUCFG2: KVM_GET_DEVICE_ATTR: %s", strerror(errno));
> +            return ret;
if it is successful with KVM_HAS_DEVICE_ATTR, however error with 
KVM_GET_DEVICE_ATTR. There should be mempy_from/to_user problem, maybe 
VM can continue to run without the following logic and operation. How 
about something like this?
-        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
-        env->cpucfg[2] &= val;
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+        if (!ret)
+            env->cpucfg[2] &= val;

Regards
Bibo Mao


sentence
feature and operation env->cpucfg[2] &= val;
> +        }
>           env->cpucfg[2] &= val;
>   
>           if (FIELD_EX32(env->cpucfg[2], CPUCFG2, FP)) {
> 


