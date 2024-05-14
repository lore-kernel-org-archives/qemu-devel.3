Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064CAC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6r3P-0004KN-OM; Tue, 14 May 2024 08:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s6r3K-00045z-6B
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:14:44 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s6r3H-0004IJ-Ao
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:14:41 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxK+qsVUNmhagMAA--.18545S3;
 Tue, 14 May 2024 20:14:36 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxXN6rVUNmxWseAA--.54264S3; 
 Tue, 14 May 2024 20:14:35 +0800 (CST)
Subject: Re: [PATCH] target/loongarch/kvm: fpu save the vreg registers high
 192bit
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhaotianrui@loongson.cn,
 richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
References: <20240514110752.989572-1-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <afdc3473-a447-6e10-0665-7c1c5faa9df5@loongson.cn>
Date: Tue, 14 May 2024 20:14:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240514110752.989572-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxXN6rVUNmxWseAA--.54264S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFyrJFy5KFyrtrWrJF1DJwc_yoW8JF4fp3
 yIvrn09FWrGFZrCFsxZa4DXrnFq3ZxGrn2ga1xKryxtr45tryayFykKws2qrnrCw4xKF10
 vF1rAF4Y9FnrAacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.127,
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

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2024/5/14 下午7:07, Song Gao wrote:
> On kvm side, get_fpu/set_fpu save the vreg registers high 192bits,
> but QEMU missing.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/kvm/kvm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index a9f9020071..0b5dbb7ed8 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -436,6 +436,9 @@ static int kvm_loongarch_get_regs_fp(CPUState *cs)
>       env->fcsr0 = fpu.fcsr;
>       for (i = 0; i < 32; i++) {
>           env->fpr[i].vreg.UD[0] = fpu.fpr[i].val64[0];
> +        env->fpr[i].vreg.UD[1] = fpu.fpr[i].val64[1];
> +        env->fpr[i].vreg.UD[2] = fpu.fpr[i].val64[2];
> +        env->fpr[i].vreg.UD[3] = fpu.fpr[i].val64[3];
>       }
>       for (i = 0; i < 8; i++) {
>           env->cf[i] = fpu.fcc & 0xFF;
> @@ -455,6 +458,9 @@ static int kvm_loongarch_put_regs_fp(CPUState *cs)
>       fpu.fcc = 0;
>       for (i = 0; i < 32; i++) {
>           fpu.fpr[i].val64[0] = env->fpr[i].vreg.UD[0];
> +        fpu.fpr[i].val64[1] = env->fpr[i].vreg.UD[1];
> +        fpu.fpr[i].val64[2] = env->fpr[i].vreg.UD[2];
> +        fpu.fpr[i].val64[3] = env->fpr[i].vreg.UD[3];
>       }
>   
>       for (i = 0; i < 8; i++) {
> 


