Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E89ACF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 07:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suoZS-0004rw-Bw; Sun, 29 Sep 2024 03:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1suoZP-0004rN-Jm
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 03:42:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1suoZL-00013t-6J
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 03:42:18 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx74vLBPlmprUDAA--.3309S3;
 Sun, 29 Sep 2024 15:42:03 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMCxRsXFBPlm8NQXAA--.14989S3;
 Sun, 29 Sep 2024 15:42:01 +0800 (CST)
Subject: Re: [PATCH v2] target/loongarch: Avoid bits shift exceeding width of
 bool type
To: Bibo Mao <maobibo@loongson.cn>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240914064645.2099169-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <950b2879-26b7-ad4b-a0f6-b448d3c3f268@loongson.cn>
Date: Sun, 29 Sep 2024 15:42:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240914064645.2099169-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMCxRsXFBPlm8NQXAA--.14989S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AFyDur4DCry5uryDZrWxKrX_yoW8Xryrpr
 W7uas8KF9rXFZrKa4DXa9xXF1DXr18Wr4293WSgF10kr4fXr1xXFykK3sFqFsxCw4UGw15
 Xr13uFs0yayDAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.165, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

ÔÚ 2024/9/14 ÏÂÎç2:46, Bibo Mao Ð´µÀ:
> Variable env->cf[i] is defined as bool type, it is treated as int type
> with shift operation. However the max possible width is 56 for the shift
> operation, exceeding the width of int type. And there is existing api
> read_fcc() which is converted to u64 type with bitwise shift, it can be
> used to dump fp registers into coredump note segment.
>
> Resolves: Coverity CID 1561133
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/arch_dump.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
Applied to loongarch-next.

Thanks.
Song Gao
> diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
> index 4986db970e..d9e1120333 100644
> --- a/target/loongarch/arch_dump.c
> +++ b/target/loongarch/arch_dump.c
> @@ -97,11 +97,7 @@ static int loongarch_write_elf64_fprpreg(WriteCoreDumpFunction f,
>   
>       loongarch_note_init(&note, s, "CORE", 5, NT_PRFPREG, sizeof(note.fpu));
>       note.fpu.fcsr = cpu_to_dump64(s, env->fcsr0);
> -
> -    for (i = 0; i < 8; i++) {
> -        note.fpu.fcc |= env->cf[i] << (8 * i);
> -    }
> -    note.fpu.fcc = cpu_to_dump64(s, note.fpu.fcc);
> +    note.fpu.fcc = cpu_to_dump64(s, read_fcc(env));
>   
>       for (i = 0; i < 32; ++i) {
>           note.fpu.fpr[i] = cpu_to_dump64(s, env->fpr[i].vreg.UD[0]);
>
> base-commit: 28ae3179fc52d2e4d870b635c4a412aab99759e7


