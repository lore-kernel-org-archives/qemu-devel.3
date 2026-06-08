Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F32CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWczX-0005zc-Qv; Mon, 08 Jun 2026 12:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWczJ-0005xt-ID
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:38:09 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWczI-00023c-49
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:38:09 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68d232e119dso7277173a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780936686; cv=none;
 d=google.com; s=arc-20240605;
 b=NqJPJ0lk11/YSIQm1LZotvEa6aQvAxgDpglPIULtutUqzxvALcJad4x5kmJ9VWlsmh
 S5HXEcimL0WPh9iXToYmbsiRnJBPc85T5b3nSsySFXl2TLG/6XZ9Z+DzQytmHyq47r8P
 3NIrM5YXVo3gbWTuidA2DFNldXskrzLtIeF5XGb8jHovslnkfHjzaYf8Sd02SnurYWFT
 hucJ3V+Dr4yOwlBR+1Dvz0xGRaLsqul6my9pALtSmD4mPp8o1TdDeEbQQiXathyz5uPj
 LZbnoBRiUJS3T4o4ndg9aqEUns4OIPamXNFm7JdCm2wgNQ+KesiC85oC+uytwStZcSkP
 IK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LU/O22xhF9eujhgSHNvI1jakhAA/pQ6sANtgrbBeDCQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Lq+L6BexL7QsStMTISdXPyxgoI+FMG32QWcXHyGhLQ8ISdnHDvf17afk+BrlVA8F1v
 aKf3i2p89V7UoQrLxuBaPkNxXGSe7ioMjsLeiqOxwVkxxBftnvxe9NnWL43DDzhWd43o
 eUb5IoZni6R9rKl+T6BVhqQP7jCD1b5Njy+rGrAcuY3XxV6Niq4j+4wR3AzhHY5plauO
 zo5Tp98shFprJK2t6Syh6L6fFCTJNj6DaHrs/N4KzJlWXJksWzJhkqMr/+iA2DZDZV2r
 dgQBRnaVBOwE2qQhI2RA3gaA9lwa4GJVIqmNUXyWuLrhcosOtIDQyJE7NXsPILCXUWbx
 KIug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780936686; x=1781541486; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LU/O22xhF9eujhgSHNvI1jakhAA/pQ6sANtgrbBeDCQ=;
 b=MRTt3hD0LZciyPqZ8M+kndAaP7G5GUaB1Pwgeb+fIGzjnIFtOMIagMgsjnA0f54dRL
 c1BUX6Qs7Cf2YuvKT/rKIWkdHp/3Dude38kY1Nf4mmwHSnQHydd57CFuwmra92ZN3uRu
 IYnQyk6OVW/8gDQbXlCariCxkbVHcXiMKx4srjSQJP+aEyRw9IHmXX+52pVfhrG3yTKk
 qw5tPeWbTSWFD1uYS7j9gfA4JN7sT/JW9JuNurenxDgKUcm64YJy48YXdpDbQMKe/JBE
 g6w8YEqCCS7KdNyZFqi91uF5/rGYRXII5oPv6nHyEvknuc4buRPRR6aHNgJhCOEhUZCZ
 2M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936686; x=1781541486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LU/O22xhF9eujhgSHNvI1jakhAA/pQ6sANtgrbBeDCQ=;
 b=aTJtvDDkAhq+6fpVbXW5juNPvEqEJhPpnNqcn8dBcxCuwqzocF6k32Rv2NPi1j7o6N
 fwGwr2wmnAUniyaTpeMdbjcllMhc3VE3Lhckr9QILqKZwhqoMubub+xnqmo8/Xwz6peK
 y7mML9A98m6lYYMNAfYu9V3zb9rY9yqoF7l88LNSwwVvMdrQqFy3S+ZIBfjeDQvtpG9L
 ODlF4yRzoi3BLTgFZw6SAK9HOkIE6yFaYHnY1AtjNrZwugNkdP68ty50zivQQ9NbX17R
 zXbOa5nR0DSj7L+nKB5wuPGGYls03DhKRHSiPPbubTCFXwvaMVZwwqCxUN9E2JdVizQI
 Mi3A==
X-Gm-Message-State: AOJu0Yy9nLF5OLPIknqNQPuIu7vSZBjG7TaZpehWpI8r58ug+bafUD40
 /0gpFQdmBaBXqGC01H+0ifDt1v+gP+qKbYafp4o4Yuao0psB3NVy80wdpjuaJP+aviwzEAY3y88
 5n7B0F8ZZBtjBMF7cZlLlfH/dWEMz7LjP3Wn+PkR0Fwhf2tMJQMBH
X-Gm-Gg: Acq92OGk1JEHYCRpYxLuBh9z0ANFPlWfPWPdKJS7bbNblY3VhO1ZaJdxXNC388EidnQ
 xWevuVlC+j/9eIRJ4G+F7s8G0wScyfdF0TYTpojTP3tW/wn4jNAT3ja/ZvqclieePyNAppFDOcS
 mVGvRYelrZN2llN5Yp/hs4kKiFO3fzcG8x4jGu8XCQa8byj0EwBGwTAP/cT1LyQyLRR6RXoR5T1
 pLptmt1yFqUkvajuOWdidLuh02XooGl6VYNxK0eXlmgId2tb6Uj643/ekzDOpJ0pGxEncByZ4IO
 O/1TdCg/dtAI+J6KX1wk5wIH0bvASttWTDMni6lT3jyx0gXKNpogDe1B7l8kFQuDeovhKlRci+h
 Z6Q==
X-Received: by 2002:a17:907:944e:b0:bd3:1b13:7114 with SMTP id
 a640c23a62f3a-bf372d29b7cmr790782166b.37.1780936686241; Mon, 08 Jun 2026
 09:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-9-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 17:37:52 +0100
X-Gm-Features: AVVi8Ce0MyCIoVHZcnuuvN9yjbByCSgJWV5gRlvFuKlZT2wUrnnTJMJ5inF91mg
Message-ID: <CAFEAcA9wkOif_5dxU0xB2YGgcZiNZfY=d3YXvaM6sqc1dkDQUg@mail.gmail.com>
Subject: Re: [PATCH v9 08/45] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT, 
 BF2CVTLT for SVE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 3 Jun 2026 at 04:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  6 ++++++
>  target/arm/tcg/helper-fp8-defs.h |  1 +
>  target/arm/tcg/fp8_helper.c      | 16 ++++++++++++++++
>  target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
>  target/arm/tcg/sve.decode        |  6 ++++++
>  5 files changed, 52 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

