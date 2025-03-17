Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9D2C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 09:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu6Lm-0002wH-3U; Mon, 17 Mar 2025 05:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tu6Lb-0002tF-Gz; Mon, 17 Mar 2025 05:01:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>)
 id 1tu6LW-0001G4-Vs; Mon, 17 Mar 2025 05:01:22 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxlnDS5Ndnk7yZAA--.63385S3;
 Mon, 17 Mar 2025 17:01:06 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxPsfP5NdnzGhPAA--.32040S3;
 Mon, 17 Mar 2025 17:01:05 +0800 (CST)
Subject: Re: [PULL v2 1/6] target/loongarch: Fix vldi inst
To: Bibo Mao <maobibo@loongson.cn>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Guo Hongyu <guohongyu24@mails.ucas.ac.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 bibo mao <maobibo@loongson.cn>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20241227062208.1232281-1-maobibo@loongson.cn>
 <20241227062208.1232281-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <85afdc11-d931-bbe2-9d7d-fb5836456d5c@loongson.cn>
Date: Mon, 17 Mar 2025 17:03:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20241227062208.1232281-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxPsfP5NdnzGhPAA--.32040S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw4UAF1kJr18JF1DAryUtwc_yoW8GrWkp3
 y3CF4DKryrtFZ3C3yfX3y5Jr17KaykKan2qF1xt3s3ZFZxJwnaqa1ktwsFgF17Ja48WF1U
 ZFnY9ry5KayYv3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.664, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Cc: qemu-stable@nongnu.org

Fix : https://gitlab.com/qemu-project/qemu/-/issues/2865

ÔÚ 2024/12/27 ÏÂÎç2:22, Bibo Mao Ð´µÀ:
> From: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
>
> Refer to the link below for a description of the vldi instructions:
> https://jia.je/unofficial-loongarch-intrinsics-guide/lsx/misc/#synopsis_88
> Fixed errors in vldi instruction implementation.
>
> Signed-off-by: Guo Hongyu <guohongyu24@mails.ucas.ac.cn>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
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


