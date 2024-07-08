Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6DCC3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 01:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQczK-0001Op-Q3; Sun, 07 Jul 2024 21:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sQczD-0001Ld-4M
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 21:16:13 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sQcz5-00061l-Tx
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 21:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720401349; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=grfwsvJ87AnHqsc+nt2YVGCxXqY2XtQaZSs90+xn3YQ=;
 b=sufPEmouwaYCG906afPELzu7CyFocYpxRCxanzY6P39I+7Pz+jybhMaF7RMtzupGnuHtzxxZbql0h1v4kgpzQL5WsUgBJSTWC/odcyw9f7SxYW2sa0mNzecmtllig2JuM9bXXcfqcurpkg+cVSqhUSE11ssAEF9x8kCVBZqGMhQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045220184;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0WA-XK3c_1720401346; 
Received: from 30.166.64.110(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WA-XK3c_1720401346) by smtp.aliyun-inc.com;
 Mon, 08 Jul 2024 09:15:46 +0800
Message-ID: <61177669-35fe-4482-8279-ff9fa0961fec@linux.alibaba.com>
Date: Mon, 8 Jul 2024 09:14:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Validate the mode in write_vstvec
To: Jiayi Li <lijiayi@eswincomputing.com>
References: <20240701022553.1982-1-lijiayi@eswincomputing.com>
Content-Language: en-US
Cc: qemu-devel@nongnu.org, bmeng.cn@gmail.com, dbarboza@ventanamicro.com,
 luweu1518@gmail.com
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240701022553.1982-1-lijiayi@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/7/1 10:25, Jiayi Li wrote:
> Base on the riscv-privileged spec, vstvec substitutes for the usual stvec.
> Therefore, the encoding of the MODE should also be restricted to 0 and 1.
>
> Signed-off-by: Jiayi Li <lijiayi@eswincomputing.com>
> ---
>   target/riscv/csr.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 432c59dc66..f9229d92ab 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3791,7 +3791,12 @@ static RISCVException read_vstvec(CPURISCVState *env, int csrno,
>   static RISCVException write_vstvec(CPURISCVState *env, int csrno,
>                                      target_ulong val)
>   {
> -    env->vstvec = val;
> +    /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
> +    if ((val & 3) < 2) {
> +        env->vstvec = val;
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "CSR_VSTVEC: reserved mode not supported\n");
> +    }

By the way,  you can get the all the reviewers mail by checking the 
patch with scripts/getmaintainer.pl.

Otherwise,

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>       return RISCV_EXCP_NONE;
>   }
>   

