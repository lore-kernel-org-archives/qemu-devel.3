Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316B3D17157
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 02:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t34wa-0007US-LA; Mon, 21 Oct 2024 22:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t34wY-0007UE-2r; Mon, 21 Oct 2024 22:48:23 -0400
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t34wV-0004ef-Mo; Mon, 21 Oct 2024 22:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1729565289; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=pwjK1CLOh6KAeT03TXuBevborJcYlZBoOMKj9NF9dHU=;
 b=vLQQV23JT8bXaceloBuaQIlm5rs1+JY2rLACB5jNhMJNpxcqYBRVGGDpINknBNtn2ukwuOZHKgh47kBxBMfAWhGCwuSOfb/2IgjyY8mb4lkaeMzYhPCOuAuMJkKOMP0QX7fvYeLAMwiEkKoJkoSBxoyRniFGK9LdS2O80BneAj0=
Received: from 30.166.64.99(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WHgJT.1_1729565288 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 22 Oct 2024 10:48:08 +0800
Message-ID: <1de83c56-fae4-4082-b55d-f48f04313ee0@linux.alibaba.com>
Date: Tue, 22 Oct 2024 10:48:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] tcg: Reset data_gen_ptr correctly
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, qemu-stable@nongnu.org
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-2-richard.henderson@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241016193140.2206352-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.100;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-100.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


On 2024/10/17 03:31, Richard Henderson wrote:
> This pointer needs to be reset after overflow just like
> code_buf and code_ptr.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 57a269469db ("tcg: Infrastructure for managing constant pools")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 5decd83cf4..0babae1b88 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -1399,7 +1399,6 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
>           goto retry;
>       }
>       qatomic_set(&s->code_gen_ptr, next);
> -    s->data_gen_ptr = NULL;
>       return tb;
>   }
>   
> @@ -6172,6 +6171,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
>        */
>       s->code_buf = tcg_splitwx_to_rw(tb->tc.ptr);
>       s->code_ptr = s->code_buf;
> +    s->data_gen_ptr = NULL;
>   
>   #ifdef TCG_TARGET_NEED_LDST_LABELS
>       QSIMPLEQ_INIT(&s->ldst_labels);

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei


