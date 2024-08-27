Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833EC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisQ1-0006FG-5H; Tue, 27 Aug 2024 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sisPy-0006E7-Iu
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:23:14 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sisPw-0005Hu-VM
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:23:14 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f3f0a31ab2so58213511fa.0
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724750591; x=1725355391; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nIt4kSxqd7ZYQS0KnAI/2ZApSg8g5Uyqp4Sm9+3zFhI=;
 b=HH9p8ElvOJ2bztOQ7pxUrGSPAP1BJFmCThSTNo0ivVrOFi6/i19U07BwX6S6yTTkzA
 RGngS/9GiobALbzHDzm4blag584r0MuM8cE+LbTKUIu0LSbxdpTFkB32hn5GRYVS/g8Y
 pqt2JHDrgW1gVzuXenGzM2X4qNo9UsDL6Fcd31YvI28IH4ybYlShrAaob+yJvhfJWzxv
 mB/YA/zLnyHjftXg9ZTdfeyQzcTxO0l9qLnmas0A13t2K5PKkiJrvHGP/vPatkGQ4d9R
 NJRoBzDDqbOPtYgnO+rjnK+EdqlhD1LQr19vKQQFMT0ZUhvv1Vq3iKtYQ4EZq49P//MD
 p4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724750591; x=1725355391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nIt4kSxqd7ZYQS0KnAI/2ZApSg8g5Uyqp4Sm9+3zFhI=;
 b=O0lW0M1bmuVq9iooppN1j+cReGC6Kmuxtu3Qdm4gn5CIwqVzhjUhh4H452IRcxxyiQ
 IPK6EL1aVJGwt5bfw4F1xsXKSQAPGhYHz8z2sTzSfhvrz0QC+xeRU2GoxCT841enFovi
 SO/BphaKS8ua4V66g1fDOeMYRnWK/LNM8gS2mrYGEV4gAG4WIHXxCCwRaXbgk7VHTtT1
 3GH7peClprnE3vfGvuN6ejbCpffxm7D6wFN4YNqYtXH4aA6VCkgB1vH/1PaLeLjoCgfZ
 2HuJ5peP3tmLWWva7mXtvY+UDPjgKR7TvEFnmaWQeaNQxJYRI6GqdZn1tq4MjjCnXQY6
 5/Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4DMP3eEndug50kh/KLF/SJEuWVdS1xnQEvyy5BzWOH8HVgUvlTWFz7e+XEpLFKXpmkUuYCWgokMu6@nongnu.org
X-Gm-Message-State: AOJu0YyyjGdi55aoW5iWetjv35QVbV3DKMTZ9mbkD/ODSW32HmNCYCEh
 /U8kc8TjuvQR866s3ov53IcuLtc2k4iJGHWXgHf0hfixm6Y3jFf/KuOs2rD7iQiT225881iQxR1
 td2S03X+mtHIthrKiY/4uCd30mdb5l5rVXC7J9w==
X-Google-Smtp-Source: AGHT+IFo4Ax9VHoZ60o6U89d/r6lvHSUXD6Wzw2RSYWntIjsQ0kSvjT7l2U8GLxN0EltsV1zvlrz/nPB3Ot2S+CIFE0=
X-Received: by 2002:a2e:be04:0:b0:2f3:e2fd:7de9 with SMTP id
 38308e7fff4ca-2f4f571f7d4mr97440121fa.5.1724750590908; Tue, 27 Aug 2024
 02:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240826204628.3541850-1-fanjason@google.com>
 <20240826204628.3541850-2-fanjason@google.com>
In-Reply-To: <20240826204628.3541850-2-fanjason@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Aug 2024 10:22:59 +0100
Message-ID: <CAFEAcA_ErHypGHM_Gbh3dt35WSuAn5CworUiE5OcY9M2dDOGmA@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu/bitops.h: Add deposit8 for uint8_t bit
 operation
To: Jason Fan <fanjason@google.com>
Cc: philmd@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Aug 2024 at 22:01, Jason Fan <fanjason@google.com> wrote:
>
> Signed-off-by: Jason Fan <fanjason@google.com>
> ---
>  include/qemu/bitops.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 2c0a2fe751..d01c4b42f2 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -459,6 +459,32 @@ static inline int64_t sextract64(uint64_t value, int start, int length)
>      return ((int64_t)(value << (64 - length - start))) >> (64 - length);
>  }
>
> +/**
> + * deposit8:
> + * @value: initial value to insert bit field into
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + * @fieldval: the value to insert into the bit field
> + *
> + * Deposit @fieldval into the 8 bit @value at the bit field specified
> + * by the @start and @length parameters, and return the modified
> + * @value. Bits of @value outside the bit field are not modified.
> + * Bits of @fieldval above the least significant @length bits are
> + * ignored. The bit field must lie entirely within the 8 bit word.
> + * It is valid to request that all 8 bits are modified (ie @length
> + * 8 and @start 0).
> + *
> + * Returns: the modified @value.
> + */
> +static inline uint8_t deposit8(uint8_t value, int start, int length,
> +                               uint8_t fieldval)
> +{
> +    uint8_t mask = 0xFF;
> +    assert(start >= 0 && length > 0 && length <= 8 - start);
> +    mask = (mask >> (8 - length)) << start;
> +    return (value & ~mask) | ((fieldval << start) & mask);
> +}

What's the use case for this? Where would you need this
and not be able to use "deposit32" instead?

thanks
-- PMM

