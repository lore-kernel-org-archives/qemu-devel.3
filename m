Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A7FC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 07:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmUGr-0007af-26; Tue, 19 Mar 2024 03:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmUGn-0007aR-PE; Tue, 19 Mar 2024 03:52:26 -0400
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmUGl-00042S-3z; Tue, 19 Mar 2024 03:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710834731; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=XpDStMmscSKUsrbDqMfPXLY/L9Ji35OnClbYlj+KC4s=;
 b=RSbrIXMUDp4iCrH0HlTvuu97fGpv0hWRy2QiRutqGZCmIa5d5YimPVZq7dxGmyJwFa4D0twzGAXS3d25Tbr8M6KDWcXFaQBWDdBLrGomuLU16+2vVHZkXuQvS3wu29M9N5azgI06dym/Ksf0kLbqYW4H/igp69kxh6Dj8or/O3s=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2sMRIs_1710834728; 
Received: from 30.198.0.148(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2sMRIs_1710834728) by smtp.aliyun-inc.com;
 Tue, 19 Mar 2024 15:52:09 +0800
Message-ID: <9578e895-f4b3-4d2b-8f95-1fc07868846c@linux.alibaba.com>
Date: Tue, 19 Mar 2024 15:52:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 03/10] target/riscv/vector_helper.c: fix
 'vmvr_v' memcpy endianess
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, max.chou@sifive.com,
 richard.henderson@linaro.org
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-4-dbarboza@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240314175704.478276-4-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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


On 2024/3/15 1:56, Daniel Henrique Barboza wrote:
> vmvr_v isn't handling the case where the host might be big endian and
> the bytes to be copied aren't sequential.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Fixes: f714361ed7 ("target/riscv: rvv-1.0: implement vstart CSR")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/vector_helper.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index ca79571ae2..34ac4aa808 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -5075,9 +5075,17 @@ void HELPER(vmvr_v)(void *vd, void *vs2, CPURISCVState *env, uint32_t desc)
>       uint32_t startb = env->vstart * sewb;
>       uint32_t i = startb;
>   
> +    if (HOST_BIG_ENDIAN && i % 8 != 0) {
> +        uint32_t j = ROUND_UP(i, 8);
> +        memcpy((uint8_t *)vd + H1(j - 1),
> +               (uint8_t *)vs2 + H1(j - 1),
> +               j - i);
> +        i = j;
> +    }
> +
>       memcpy((uint8_t *)vd + H1(i),
>              (uint8_t *)vs2 + H1(i),
> -           maxsz - startb);
> +           maxsz - i);

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>   
>       env->vstart = 0;
>   }

