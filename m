Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421C4C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 05:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnBOV-0000Xr-AF; Thu, 21 Mar 2024 01:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rnBOT-0000Wy-00; Thu, 21 Mar 2024 01:55:13 -0400
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rnBOP-0003kd-Rr; Thu, 21 Mar 2024 01:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1711000496; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Yo5DBRQmmubqbV+E+YJ4w22GLhmuNyQY27Y5R5Un3uQ=;
 b=vLLEQ6YFRu8mr3P1m6qG2c7tiTdhMHjBl1U5t4Z7OYQCro0bKUZ3co9MS6nfKrCyxuMer66b9JrD176+KHZMIkPDE+GY2WYG3lCePsJpadNcaRNEOrOQRZAfFAox28vVbJlc6atImMnw1UhU40xd+FFULLvdZRljx7pvG8WrhaA=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2zadUx_1711000493; 
Received: from 30.198.0.180(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2zadUx_1711000493) by smtp.aliyun-inc.com;
 Thu, 21 Mar 2024 13:54:54 +0800
Message-ID: <d58afdd1-257e-457f-ae28-52507431d2a6@linux.alibaba.com>
Date: Thu, 21 Mar 2024 13:54:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix the element agnostic function problem
Content-Language: en-US
To: Huang Tao <eric.huang@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 bin.meng@windriver.com, alistair.francis@wdc.com, palmer@dabbelt.com,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240321035816.99983-1-eric.huang@linux.alibaba.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240321035816.99983-1-eric.huang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/3/21 11:58, Huang Tao wrote:
> In RVV and vcrypto instructions, the masked and tail elements are set to 1s
> using vext_set_elems_1s function if the vma/vta bit is set. It is the element
> agnostic policy.
>
> However, this function can't deal the big endian situation. This patch fixes
> the problem by adding handling of such case.
>
> Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Changes in v2:
> - Keep the api of vext_set_elems_1s
> - Reduce the number of patches.
> ---
>   target/riscv/vector_internals.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
>
> diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
> index 12f5964fbb..3e45b9b4a7 100644
> --- a/target/riscv/vector_internals.c
> +++ b/target/riscv/vector_internals.c
> @@ -30,6 +30,28 @@ void vext_set_elems_1s(void *base, uint32_t is_agnostic, uint32_t cnt,
>       if (tot - cnt == 0) {
>           return ;
>       }
> +
> +#if HOST_BIG_ENDIAN
> +    /*
> +     * Deal the situation when the elements are insdie
> +     * only one uint64 block including setting the
> +     * masked-off element.
> +     */
> +    if ((tot - 1) ^ cnt < 8) {
> +        memset(base + H1(tot - 1), -1, tot - cnt);
> +        return;
> +    }
> +    /*
> +     * Otherwise, at least cross two uint64_t blocks.
> +     * Set first unaligned block.
> +     */
> +    if (cnt % 8 != 0) {
> +        uint32_t j = ROUND_UP(cnt, 8);
> +        memset(base + H1(j - 1), -1, j - cnt);
> +        cnt = j;
> +    }
> +    /* Set other 64bit aligend blocks */
> +#endif

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>       memset(base + cnt, -1, tot - cnt);
>   }
>   

