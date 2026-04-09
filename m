Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72FEA3C55
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAoea-0000Fe-1U; Thu, 09 Apr 2026 08:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAoeS-0000FE-QB
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:38:30 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAoeQ-0001FA-V7
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 08:38:28 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6500040ef83so630370d50.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 05:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775738305; cv=none;
 d=google.com; s=arc-20240605;
 b=WXtPwGogYgKZCmMk7CxMpPyBvaqeRdZ5d4cw686/d6BmTNJXNi0alZzEazNF+J2GvX
 U9gT+NaTrWzB3dPwD/Qlwmwytdpz6CXuVsIuZAAJScJq9vUO9svQBMSSk/OW2HAjAleQ
 Mo50pIw1nnVQLNXVXKtqWnCdpglkBH9qp5kMvati0ftRC6cjzwlH4mfnY5U3ZFmAt5u9
 IcJmNbc8nnLsNcfLnvE9pC7z7+dRHonqu1XhVdAD7b2UBXqUn+SffOWN00rr6i6/6sx7
 6bwnXOHFvkMiA+yR8sn2Fx45bSZVQRH1H4uhyoMX9sdDw+Eh6oLcQNSQ8+l4urK3ZJ1t
 P90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dUo6gleOowfXneHkzzcdVYsGZIakpznXHIV3SYunSEg=;
 fh=U6R6/MSqUIq026Rbe7sxKyi3PXmnuVZRGLkIqXxupeg=;
 b=Qhz8h9h1a2vUhjLVjFXH5/mZRKVBJnT+tZ3vhgfu3iTRsV9HvTV6Xs6wWQe5Co5zmj
 MVaBJmu7S3KVGFTo41iM/osmAr7mmHC6FMsXzxSYoOcjVM5elDBzeIA1lf1fuZetrPvM
 fQCC2yZOhDlWfw5VypCY89TAjflOMiafrdgqWIGJGarjQgpQqbvYNPaUDeG7KOgn8GpH
 sEAjtIxJBtKD4wmYUUEIsSuTL59kukTAwrkFpFURRGWvqYTVRsCSvubLTBluoT6VHl1w
 4o0aR3StfK5slQtlx21OiVheZtWm4U84UuIAIv7yTjG3sLIqPiFQVZkbaMtjME2wUmkd
 ypJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775738305; x=1776343105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUo6gleOowfXneHkzzcdVYsGZIakpznXHIV3SYunSEg=;
 b=Fsxu0AyUc3ETz+CkSYrfl6Q9fB6Ad3Uq6+OgsZ1cSuUvobEQs8r+JJ3DliHxKAjOa2
 QKjGQWuGqfRCOCoq8LqVEFH1zGbThMIGoa5k1ON5PeqTAb4qIkOdFzoOtOjPaCyZZYaX
 w+663ll9GmHAI5NRoN+KlpzbWtmGpzUmKaHTT2gZxuqaXHRE7W9pYWzag1YemzKC+OX9
 aktYVTJb6w5vn541QEcWh7h+KDZPtQbc15/Qzg0tFi9eFJYIkgVt3nQwyfondAVQv6S4
 bFRq2uDujQ1HsnV7hQjTd70Bv8rDUyfKnsNgZvewEtD0xPAtOycwAsvBlGdqkTPIvDgM
 j9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775738305; x=1776343105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dUo6gleOowfXneHkzzcdVYsGZIakpznXHIV3SYunSEg=;
 b=Ai/jDBxuneXi0B7QX4z+qfV70jbhiug7RKi5dwhW7ihEnEyP6m6aNiKQKfbZmBuOp9
 ikywndjq0ejrgEWtJdNlV6FtWeVtnh33j0+MABqyUrvjB7O6AebGvSl8mwWacD9NVAun
 7vJrQHKYz96HBzsw8I8stiqodv7Cx1xifxuI25dHG97ZzzmxYi8L8EzAEnJwj6S2NWdD
 K8+YZhqvrNSIcsqgq+RjkK0pjC2DmJhkUcr2waPo0dOqsZl8gfpjIlrvD3Zbba+VH1GZ
 JmlLFl0qHaUogxORV+52WWnNfGiLl99DOPxjzhEIGiMB62uV1GKxzkf892QUrMUn8qzw
 1+fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKNHolTYhBGRhxl5CIbEVFwAl9z2uMEVs8Qt8bqFiPTWTZD4bUbKqXvCrHg/vD04v1vMZvaQqBwLTu@nongnu.org
X-Gm-Message-State: AOJu0YzAdNpfrv2mzVnvhGs/gY7meRlDS9mPrzPhi/MttajpoPq1ROUM
 g7a6Hz33Qnvej4T9zOHeQurClcTutyhzLORRKjhSOlQvyFGV0Qw2NoN0WiORLmpC/tfWuXsVKZZ
 b2Bw3Yhll6q86Zseuga/AiQHsnTdjwMiaNnxT8DUtIg==
X-Gm-Gg: AeBDieuLfY6RUBjLD+cCZqeGe5Ea27nWEAmraF1nsNNQpT0q6zF5gimynVfz+TMg355
 RqMt8iyw9quXTIGkQsduhd9EYHBZwpT/HEXh8Uc40783wgl6NzWw3vWz3b/kxkDiFr4fYPo+DJ5
 E4Mr9aKt8VF/NObJ98rBGsIVy0y0fQtisGXzJHf/G/KfEsv05eNtQ7lZEGhqwUdyuYPKWFq9++J
 rHOhGZvtH2wRbEEtiLL7RyN9yXUrxo7CqGIEwCsu6kN+nSAix00j4U2veHcWOjUtTeXDUAuYyAu
 uD9d5LQlpGgGQrDOB13mfnYlHSnD46jj0OdWel/8OG7t2QRPFwh5RAXP3/4PC3ag7W0=
X-Received: by 2002:a05:690e:485:b0:650:314f:1108 with SMTP id
 956f58d0204a3-6504888209cmr17961923d50.59.1775738304854; Thu, 09 Apr 2026
 05:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260408073403.3410541-1-kraxel@redhat.com>
 <addoU4vf41wQg2x6@redhat.com>
In-Reply-To: <addoU4vf41wQg2x6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 13:38:13 +0100
X-Gm-Features: AQROBzD_OCZNAUxA7btQhWB4vU46BP7Vh71l4yAB8DleVw3Bmt-1QBdQRH4XQ4Q
Message-ID: <CAFEAcA8njz5C7e4W84HCEGydvnt5BoihgcSHextMqZELj7B5=g@mail.gmail.com>
Subject: Re: [PATCH for 11.0] hw/uefi: fix heap overflow (CVE-2026-5744)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Yuma Kurogome <yumak@ricsec.co.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Thu, 9 Apr 2026 at 09:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>
> On Wed, Apr 08, 2026 at 09:34:02AM +0200, Gerd Hoffmann wrote:
> > When copying the request response into the pio transfer buffer the code
> > skips the 'struct mm_header' but does not consider that when calculatin=
g
> > transfer size, so it will copy 24 (=3D=3D sizeof(struct mm_header)) ext=
ra
> > bytes, which can overflow uv->pio_xfer_buffer.
> >
> > Fix that by copying the complete buffer, including the header, which
> > also makes the pio code path consistent with the (unaffected) dma code
> > path.
> >
> > Fixes: CVE-2026-5744
> > Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
> > Reported-by: Yuma Kurogome <yumak@ricsec.co.jp>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/uefi/var-service-core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Thanks; I'm applying this one directly to git so we can
get it into today's RC.

-- PMM

