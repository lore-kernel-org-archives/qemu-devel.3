Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5831CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 08:31:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1KuB-0007e1-W8; Wed, 24 Sep 2025 04:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v1Ku9-0007di-I6
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:31:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v1Ku5-0005gL-JR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 04:31:12 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxbNJDrNNo7gAOAA--.30259S3;
 Wed, 24 Sep 2025 16:30:59 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJAxvsFArNNoGQKrAA--.41804S3;
 Wed, 24 Sep 2025 16:30:58 +0800 (CST)
Subject: Re: [PATCH v4 05/13] target/loongarch: Fix page size set issue with
 CSR_STLBPS
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250906070441.3749413-1-maobibo@loongson.cn>
 <20250906070441.3749413-6-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e82355ce-d3e6-a336-63b9-1a67fae211b1@loongson.cn>
Date: Wed, 24 Sep 2025 16:30:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250906070441.3749413-6-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxvsFArNNoGQKrAA--.41804S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrW7Zr4fWry5CryxGF47WrX_yoW8Cr17pr
 W7CrWDKFWkKrWDA3Z2qa4Yqw1DursrGw4vqan3Gry8CwnxXrWIgry8t392gFyfJayrCF18
 XFnayry0vF47XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.829, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

ÔÚ 2025/9/6 ÏÂÎç3:04, Bibo Mao Ð´µÀ:
> When modify register CSR_STLBPS, the page size should come from
> input parameter rather than old value.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-csr.h        | 1 +
>   target/loongarch/tcg/csr_helper.c | 5 +++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index 0834e91f30..1a311bf06a 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -106,6 +106,7 @@ FIELD(CSR_PWCH, DIR4_WIDTH, 18, 6)
>   
>   #define LOONGARCH_CSR_STLBPS         0x1e /* Stlb page size */
>   FIELD(CSR_STLBPS, PS, 0, 5)
> +FIELD(CSR_STLBPS, RESERVE, 5, 27)
>   
>   #define LOONGARCH_CSR_RVACFG         0x1f /* Reduced virtual address config */
>   FIELD(CSR_RVACFG, RBITS, 0, 4)
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 0d99e2c92b..eb60fefa82 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -26,13 +26,14 @@ target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
>        * The real hardware only supports the min tlb_ps is 12
>        * tlb_ps=0 may cause undefined-behavior.
>        */
> -    uint8_t tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> +    uint8_t tlb_ps = FIELD_EX64(val, CSR_STLBPS, PS);
>       if (!check_ps(env, tlb_ps)) {
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "Attempted set ps %d\n", tlb_ps);
>       } else {
>           /* Only update PS field, reserved bit keeps zero */
> -        env->CSR_STLBPS = FIELD_DP64(old_v, CSR_STLBPS, PS, tlb_ps);
> +        val = FIELD_DP64(val, CSR_STLBPS, RESERVE, 0);
> +        env->CSR_STLBPS = val;
>       }
>   
>       return old_v;


