Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97F5C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 08:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXPZ-0007No-Fe; Thu, 15 Feb 2024 03:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1raXPY-0007Ne-5y
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:48:04 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1raXPW-0002eb-1X
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 03:48:03 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 4736040F1DF3;
 Thu, 15 Feb 2024 08:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 4736040F1DF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1707986856;
 bh=Ui9/8fx+RzWIY+snO+UzbNmhxOCBZUUrDAMkccw4ddA=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Nw6PEE7QhSVwdgQ7UFBgOJ91xAx2wZ6S6VUP/Hd16hlwDx1rorMjgkmx0ytqozKdu
 Tusmd0KyymOe29M/yhItuar4DZMy4ynDOeCWj/ugemk7pyce7JCn5n/lJRgeo4Uy2U
 mYgPEt1MiX2C1Wjae751cQ+5Ccc1RAD0t41OhaQE=
Date: Thu, 15 Feb 2024 11:47:36 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v4 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
In-Reply-To: <20240215081449.848220-10-richard.henderson@linaro.org>
Message-ID: <1f038576-5121-e84c-8196-ae5f9ca3a75b@ispras.ru>
References: <20240215081449.848220-1-richard.henderson@linaro.org>
 <20240215081449.848220-10-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=83.149.199.84; envelope-from=amonakov@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On Wed, 14 Feb 2024, Richard Henderson wrote:

> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
> double-check with the compiler flags for __ARM_NEON and don't bother with
> a runtime check.  Otherwise, model the loop after the x86 SSE2 function,
> and use VADDV to reduce the four vector comparisons.

I am not very familiar with Neon but I wonder if this couldn't use SHRN
for the final 128b->64b reduction similar to 2022 Glibc optimizations:
https://inbox.sourceware.org/libc-alpha/20220620174628.2820531-1-danilak@google.com/

In git history I see the previous Neon buffer_is_zero was removed because
it was not faster. Is it because integer LDP was as good as vector loads
at saturating load bandwidth on older cores, and things are different now?

Alexander

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/bufferiszero.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 4eef6d47bc..2809b09225 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -214,7 +214,81 @@ bool test_buffer_is_zero_next_accel(void)
>      }
>      return false;
>  }
> +
> +#elif defined(__aarch64__) && defined(__ARM_NEON)
> +#include <arm_neon.h>
> +
> +#define REASSOC_BARRIER(vec0, vec1) asm("" : "+w"(vec0), "+w"(vec1))
> +
> +static bool buffer_is_zero_simd(const void *buf, size_t len)
> +{
> +    uint32x4_t t0, t1, t2, t3;
> +
> +    /* Align head/tail to 16-byte boundaries.  */
> +    const uint32x4_t *p = QEMU_ALIGN_PTR_DOWN(buf + 16, 16);
> +    const uint32x4_t *e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 16);
> +
> +    /* Unaligned loads at head/tail.  */
> +    t0 = vld1q_u32(buf) | vld1q_u32(buf + len - 16);
> +
> +    /* Collect a partial block at tail end.  */
> +    t1 = e[-7] | e[-6];
> +    t2 = e[-5] | e[-4];
> +    t3 = e[-3] | e[-2];
> +    t0 |= e[-1];
> +    REASSOC_BARRIER(t0, t1);
> +    REASSOC_BARRIER(t2, t3);
> +    t0 |= t1;
> +    t2 |= t3;
> +    REASSOC_BARRIER(t0, t2);
> +    t0 |= t2;
> +
> +    /*
> +     * Loop over complete 128-byte blocks.
> +     * With the head and tail removed, e - p >= 14, so the loop
> +     * must iterate at least once.
> +     */
> +    do {
> +        /* Each comparison is [-1,0], so reduction is in [-4..0]. */
> +        if (unlikely(vaddvq_u32(vceqzq_u32(t0)) != -4)) {
> +            return false;
> +        }
> +
> +        t0 = p[0] | p[1];
> +        t1 = p[2] | p[3];
> +        t2 = p[4] | p[5];
> +        t3 = p[6] | p[7];
> +        REASSOC_BARRIER(t0, t1);
> +        REASSOC_BARRIER(t2, t3);
> +        t0 |= t1;
> +        t2 |= t3;
> +        REASSOC_BARRIER(t0, t2);
> +        t0 |= t2;
> +        p += 8;
> +    } while (p < e - 7);
> +
> +    return vaddvq_u32(vceqzq_u32(t0)) == -4;
> +}
> +
> +static biz_accel_fn const accel_table[] = {
> +    buffer_is_zero_int_ge256,
> +    buffer_is_zero_simd,
> +};
> +
> +static unsigned accel_index = 1;
> +#define INIT_ACCEL buffer_is_zero_simd
> +
> +bool test_buffer_is_zero_next_accel(void)
> +{
> +    if (accel_index != 0) {
> +        buffer_is_zero_accel = accel_table[--accel_index];
> +        return true;
> +    }
> +    return false;
> +}
> +
>  #else
> +
>  bool test_buffer_is_zero_next_accel(void)
>  {
>      return false;
> 

