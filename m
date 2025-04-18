Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2CDC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 08:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5hCr-0006XT-9D; Fri, 18 Apr 2025 04:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u5hCi-0006X6-5R
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:36:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u5hCf-0006dp-Sr
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 04:36:07 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxdWnwDgJoGJzBAA--.58629S3;
 Fri, 18 Apr 2025 16:36:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMDxvhvtDgJoEDKJAA--.25918S3;
 Fri, 18 Apr 2025 16:35:59 +0800 (CST)
Subject: Re: [PATCH v4 2/3] target/loongarch: Guard BCEQZ/BCNEZ instructions
 with FP feature
To: WANG Rui <wangrui@loongson.cn>, Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu@hev.cc
References: <20250418082103.447780-1-wangrui@loongson.cn>
 <20250418082103.447780-3-wangrui@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <6e3b736f-6d07-750e-1dd4-a86092b886c0@loongson.cn>
Date: Fri, 18 Apr 2025 16:34:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250418082103.447780-3-wangrui@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxvhvtDgJoEDKJAA--.25918S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kw1kWr1xJFy3XFW3uFy5ZFc_yoW8GFWkpr
 1UCw10kFW7Jr93Cw1rXrWjyFy3Xrs0kw47WFs7twn3Zr45XryvqFy8Kr1DKFsxZa40vF40
 vFWS9ryjga1UXacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.272,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/4/18 下午4:21, WANG Rui wrote:
> The BCEQZ and BCNEZ instructions depend on access to condition codes
> from floating-point comparisons. Previously, these instructions were
> unconditionally enabled for 64-bit targets.
> 
> This patch updates their translation to be gated under the `FP` feature
> flag instead, ensuring they are only available when the floating-point
> unit is present.
> 
> This improves correctness for CPUs lacking floating-point support.
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>
> ---
>   target/loongarch/tcg/insn_trans/trans_branch.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_branch.c.inc b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
> index 221e5159db..f94c1f37ab 100644
> --- a/target/loongarch/tcg/insn_trans/trans_branch.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_branch.c.inc
> @@ -80,5 +80,5 @@ TRANS(bltu, ALL, gen_rr_bc, TCG_COND_LTU)
>   TRANS(bgeu, ALL, gen_rr_bc, TCG_COND_GEU)
>   TRANS(beqz, ALL, gen_rz_bc, TCG_COND_EQ)
>   TRANS(bnez, ALL, gen_rz_bc, TCG_COND_NE)
> -TRANS(bceqz, 64, gen_cz_bc, TCG_COND_EQ)
> -TRANS(bcnez, 64, gen_cz_bc, TCG_COND_NE)
> +TRANS(bceqz, FP, gen_cz_bc, TCG_COND_EQ)
> +TRANS(bcnez, FP, gen_cz_bc, TCG_COND_NE)
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


