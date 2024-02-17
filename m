Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AADEC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 12:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbJZd-0002S5-RA; Sat, 17 Feb 2024 07:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rbJZb-0002Rc-R3
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 07:13:39 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amonakov@ispras.ru>)
 id 1rbJZS-00043o-4q
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 07:13:39 -0500
Received: from [10.10.3.121] (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 505C540F1DE6;
 Sat, 17 Feb 2024 12:13:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 505C540F1DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1708172006;
 bh=aFnytfp6UkY0a3CF2CG0x5zQKHb2ayP8WRjq7dhhEB0=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=a7RfGEUqU6avSurQrYvfQTdxf/d4lS3YbqrX+KJtnXGMox3fAy+1hD97Fi6ThyHan
 NgOr9q/vIrDCGcqEw77PpX4uO9h5vl3g5RAX16GdYqMjnJwmwyCpmrjSil/6C8GXtg
 72qZvd9SZn5WjkIbmBfdTdZ9FwAQPP2/2xmvif88=
Date: Sat, 17 Feb 2024 15:13:26 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Richard Henderson <richard.henderson@linaro.org>
cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
Subject: Re: [PATCH v5 06/10] util/bufferiszero: Improve scalar variant
In-Reply-To: <20240217003918.52229-7-richard.henderson@linaro.org>
Message-ID: <0a4bd5d4-8632-78ec-e68f-be349fff2ed6@ispras.ru>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-7-richard.henderson@linaro.org>
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

> Split less-than and greater-than 256 cases.
> Use unaligned accesses for head and tail.
> Avoid using out-of-bounds pointers in loop boundary conditions.

I guess it did not carry

  typedef uint64_t uint64_a __attribute__((may_alias));

along the way, not a big deal since Qemu builds with -fno-strict-aliasing,
but I felt it was nice to be explicit in the code about that.

Am I expected to give Reviewed-by's to you? I did read the code to the
best of my ability and did not spot any issues.

Copies of the old comment will need updating:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/bufferiszero.c | 86 +++++++++++++++++++++++++++------------------
>  1 file changed, 52 insertions(+), 34 deletions(-)
> 
> diff --git a/util/bufferiszero.c b/util/bufferiszero.c
> index 02df82b4ff..a904b747c7 100644
> --- a/util/bufferiszero.c
> +++ b/util/bufferiszero.c
> @@ -28,40 +28,58 @@
>  
>  static bool (*buffer_is_zero_accel)(const void *, size_t);
>  
> -static bool buffer_is_zero_integer(const void *buf, size_t len)
> +static bool buffer_is_zero_int_lt256(const void *buf, size_t len)
>  {
[snip]
> +    /*
> +     * Use unaligned memory access functions to handle
> +     * the beginning and end of the buffer, with a couple
> +     * of loops handling the middle aligned section.
> +     */

... here, there is only one loop now, not two,

> +    if (unlikely(len <= 8)) {
> +        return (ldl_he_p(buf) | ldl_he_p(buf + len - 4)) == 0;
>      }
> +
> +    t = ldq_he_p(buf) | ldq_he_p(buf + len - 8);
> +    p = QEMU_ALIGN_PTR_DOWN(buf + 8, 8);
> +    e = QEMU_ALIGN_PTR_DOWN(buf + len - 1, 8);
> +
> +    while (p < e) {
> +        t |= *p++;
> +    }
> +    return t == 0;
> +}
> +
> +static bool buffer_is_zero_int_ge256(const void *buf, size_t len)
> +{
> +    /*
> +     * Use unaligned memory access functions to handle
> +     * the beginning and end of the buffer, with a couple
> +     * of loops handling the middle aligned section.
> +     */

... and likewise here.

Alexander

