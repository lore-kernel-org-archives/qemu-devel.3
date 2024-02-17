Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE32C48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIwd-0005IF-Jy; Sat, 17 Feb 2024 06:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rbIwb-0005FE-Hr
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:33:21 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rbIwY-0005RY-RJ
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 06:33:21 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 24FD040F1DE6;
 Sat, 17 Feb 2024 11:33:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 24FD040F1DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708169596;
 bh=BtJssNpKG4/m4GRWMRHRhKkS1nCwJUEkXLwEzEtT7as=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=Cwr0Gx4Pi5YpQtq1wkmEJwRHlBZjQnZNNdMJL3Ua72ynhfYl5wQb6wJelx9IkMMg/
 mi53bYHZ2XhpFxMsbEuC+kkP0vfF+iZsbZ43qYeMr1z/D/r4aJTaxtK8WwIY0ysZMo
 rutUEgTjMIFfwUSTb0kUTRitjh85u6D4cDK3LAzA=
Date: Sat, 17 Feb 2024 14:33:16 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v5 09/10] util/bufferiszero: Add simd acceleration for
 aarch64
In-Reply-To: <20240217003918.52229-10-richard.henderson@linaro.org>
Message-ID: <61d2e428-5829-ec12-da2c-57736b9af86f@ispras.ru>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-10-richard.henderson@linaro.org>
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


On Fri, 16 Feb 2024, Richard Henderson wrote:

> Because non-embedded aarch64 is expected to have AdvSIMD enabled, merely
> double-check with the compiler flags for __ARM_NEON and don't bother with
> a runtime check.  Otherwise, model the loop after the x86 SSE2 function,
> and use VADDV to reduce the four vector comparisons.

Commit message will need a refresh (s/VADDV/UMAXV/, and there are no
vector comparisons anymore, "reduce the four vector components" perhaps).

It appears AdvSIMD types do not carry the may_alias attribute, unlike
x86 immintrin.h types. This does not matter for Qemu since it is built
with -fno-strict-aliasing anyway, just mentioning for completeness.

(for aliasing-safe reuse of this code elsewhere, I'd suggest

  typedef uint32x4_t uint32x4_a __attribute__((may_alias));

and using the new type in declarations of 'p' and 'e')

Alexander

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/bufferiszero.c | 77 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 9b338f7be5..77db305bb0 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -214,7 +214,84 @@ bool test_buffer_is_zero_next_accel(void)
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
> +        /*
> +         * Reduce via UMAXV.  Whatever the actual result,
> +         * it will only be zero if all input bytes are zero.
> +         */
> +        if (unlikely(vmaxvq_u32(t0) != 0)) {
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
> +    return vmaxvq_u32(t0) == 0;
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

