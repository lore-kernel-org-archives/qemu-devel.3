Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B761AE7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 02:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPujg-0003kD-Pn; Mon, 23 Dec 2024 21:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tPuja-0003gk-NW
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 21:33:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tPujW-0000Hy-Vn
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 21:33:22 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dxfa9VHWpnketZAA--.21768S3;
 Tue, 24 Dec 2024 10:32:54 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxYMZQHWpnQGUHAA--.40551S3;
 Tue, 24 Dec 2024 10:32:49 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix vldi inst
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: ghy <2247883756@qq.com>, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Song Gao <gaosong@loongson.cn>
References: <20241219122311.3254940-1-lixianglai@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <cd1c7d91-3a92-9425-8034-a8796858f6f2@loongson.cn>
Date: Tue, 24 Dec 2024 10:32:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241219122311.3254940-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxYMZQHWpnQGUHAA--.40551S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWxGr4kJryDuFWxAw48Zrc_yoW8GF1fp3
 y3Cw4DKry8trZ7A3y3X3yUtr17Ka95Kws2gF4xt3s3ZrZ8X3saqF4FqwnFgF13J3W8GF1U
 ZFnY9ry5GayUu3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ36c02F40EFcxC0VAKzVAqx4xG6I80ewCIccxYrVCFb4Uv73VFW2AGmfu7
 bjvjm3AaLaJ3UjIYCTnIWjp_UUUYf7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4
 CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0
 c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2
 IY6xkF7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280
 aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
 0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_Jryl
 Yx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
 0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
 AKxVWUAVWUtwCIccxYrVCFb41lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU5N18DUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.856,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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



On 2024/12/19 下午8:23, Xianglai Li wrote:
> From: ghy <2247883756@qq.com>
> 
> Refer to the link below for a description of the vldi instructions:
> https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/#synopsis_88
> Fixed errors in vldi instruction implementation.
> 
> Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Hongyu Guo <guohongyu24@mails.ucas.ac.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
>   target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> index 92b1d22e28..d317dfcc1c 100644
> --- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
> @@ -3480,7 +3480,7 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
>           break;
>       case 1:
>           /* data: {2{16'0, imm[7:0], 8'0}} */
> -        data = (t << 24) | (t << 8);
> +        data = (t << 40) | (t << 8);
>           break;
>       case 2:
>           /* data: {2{8'0, imm[7:0], 16'0}} */
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


