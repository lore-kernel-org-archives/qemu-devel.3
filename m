Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE493C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 01:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1cXr-0007Vt-RD; Mon, 29 Apr 2024 21:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s1cXp-0007Vj-TU
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 21:44:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s1cXn-0004KD-CD
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 21:44:33 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxN+n7TDBmqjoFAA--.5165S3;
 Tue, 30 Apr 2024 09:44:28 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axjlf4TDBmYbwKAA--.20852S3; 
 Tue, 30 Apr 2024 09:44:26 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Put cpucfg operation before CSR register
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20240428031651.1354587-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <7a2553ca-8283-63f0-427b-8dfe12d3c96b@loongson.cn>
Date: Tue, 30 Apr 2024 09:44:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240428031651.1354587-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axjlf4TDBmYbwKAA--.20852S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw48ury5CryUZrWxGry8Zwc_yoW8Cw1Upr
 9xCan0gr15tryvkw4UZa9xXr98Wr4Sgw47WFy7t3s3Cr45Wr1kXr4rKrZFvF15J3yFgFyj
 qF43JFs093WUXagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.127, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/4/28 ÉÏÎç11:16, Bibo Mao Ð´µÀ:
> On Loongarch, cpucfg is register for cpu feature, some other registers
> depend on cpucfg feature such as perf CSR registers. Here put cpucfg
> read/write operations before CSR register, so that KVM knows how many
> perf CSR registers are valid from pre-set cpucfg feature information.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/kvm/kvm.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 8224d94333..bc75552d0f 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -587,22 +587,22 @@ int kvm_arch_get_registers(CPUState *cs)
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_get_csr(cs);
> +    ret = kvm_loongarch_get_cpucfg(cs);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_get_regs_fp(cs);
> +    ret = kvm_loongarch_get_csr(cs);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_get_mpstate(cs);
> +    ret = kvm_loongarch_get_regs_fp(cs);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_get_cpucfg(cs);
> +    ret = kvm_loongarch_get_mpstate(cs);
>       return ret;
>   }
>   
> @@ -615,22 +615,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_put_csr(cs, level);
> +    ret = kvm_loongarch_put_cpucfg(cs);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_put_regs_fp(cs);
> +    ret = kvm_loongarch_put_csr(cs, level);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_put_mpstate(cs);
> +    ret = kvm_loongarch_put_regs_fp(cs);
>       if (ret) {
>           return ret;
>       }
>   
> -    ret = kvm_loongarch_put_cpucfg(cs);
> +    ret = kvm_loongarch_put_mpstate(cs);
>       return ret;
>   }
>   
>
> base-commit: a118c4aff4087eafb68f7132b233ad548cf16376


