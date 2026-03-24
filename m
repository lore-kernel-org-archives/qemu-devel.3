Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5C3FEC0F6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 19:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w575G-000149-Qb; Tue, 24 Mar 2026 15:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w575F-00013Z-MU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:06:33 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w575E-0008FH-4S
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 15:06:33 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-794719afcd4so51026527b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 12:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774379191; cv=none;
 d=google.com; s=arc-20240605;
 b=eCr9flgL4xlDG8kyjHjkqTP10TAKffcB81YE99dQrXth9kTLOQQjU5o+8HkMpBzg/I
 rXAIo4N28SUwbybWwl1Dni0sLZ39tpyZahKmN4Yy/vefHnlnMFFBIfoRe+GeHrsu0MOJ
 s4dnGm5BdSKGNEjzY2YSRizAxUsFx7O2rG4eSkdWO7Ikuli4xi5mJiBAgyqEz516kPKp
 BbDMv1rf6jXmzIi3rdSCQUK30SjjzJhnwpTUolJxZbKUFwEUdVVe+WTR/0R8iAswwKVR
 gPLSvBeN5nw1bJcPahtQKL6EGDj54dYg2TWJcJCbFwn4tILyw7ekVjMsKPfkjk9mnOWR
 Auqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wfjRUlHoEzD8aG+KSCZs4+KMf/9/RO5GYYO7ekuyq6Q=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=L3n6Bdz7pXwRUhhZtexfOKwg0V9rVl5qxGckj7ouhFk0zk7Q2QazohQhMWktBXBYgV
 ldfoG558tEyH3H1WXs+bd+CidBzPUOEiACWHBbNSTsjffOuDRh6uyYc68VEpOHKZ/gbX
 8JZUX0F0Ed1V+HQqPiKt6/WU4chdOc4tLeGMQ8qhWpqFoIEz3znQ1JiYYXu2M7pjK0qW
 2G1RmCMQaep+ogj16YmUqbT4K9UCp0d2nd01pcl9eW80rg7ACJs5jLX7uHIn248v0TcD
 V4qbfipkx7U4JvkkTNp9QX7S/caxux1j6IwP9CQTGiZnLpq895dqqPz5ZzqZNE01rfSq
 Zjkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774379191; x=1774983991; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfjRUlHoEzD8aG+KSCZs4+KMf/9/RO5GYYO7ekuyq6Q=;
 b=PSKh6qj2NlsRohimLKzPGQHqvm3zGlkOuA7JRvrEUgt4pZxPW8mEN8QQVT87/kr9yW
 vp7VMtms3R8zBxYRtku5Pct2qbDWhKL0NqN2zcpMQuHpst6I3VCAUyW6RbGuNsVd3IdT
 PY6TgnOddah70OG7/texnC8t9rCGCWSlXn+hCOmJH431Q88k24MOOL2/JRFxn9oEMu2p
 PGDash65dlI7FyjqUQERCyRaSTI4l3HUkOsHm7DrhKqhkuD5uF5uwtb1tgU7EbDlyqFe
 dPJvfWw/ttQgVLKNXBlMl8P6XkTrmIXg4HcK0ZXDK7dOp2bkn7ds3RJVd6IXV+rQnbK3
 oOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774379191; x=1774983991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfjRUlHoEzD8aG+KSCZs4+KMf/9/RO5GYYO7ekuyq6Q=;
 b=KpBpMda9YY7LJ1RAZ/3kJhXuyJdr494lxQpyXE8t4Dadl/+Jp6xKnWehrzw/xqcFrY
 OPtXz6L15Pxq1J2fhDnO8RaXEIyC77tiSAnv0khNbKrXCuul7UJuD7wUb6ia3HzkNas9
 M8/kLJUdsgM1zr8i/qQy0OrCncWjsFlw6QMyM/ewbXlwWITN9fFoWr/noj1b5LjzNWjp
 dK2jm2t1Mrwaoke3EGX4AP5NxfZs2cTm70tTsIeMc1QIKDpOIm5HuE+dAybCCafbbxlT
 LmZo/QUWvpFBlToZ3o2B6O1ijnXTwWTrgvjK5aoS+Px1VNuCjHMk1hYYw/6IQQ9deaNa
 MM0g==
X-Gm-Message-State: AOJu0YzPt2CX8J+N0zV+Z0FQFSKmJaDD8VnEeMVDMBUGQRmrBcgGygNj
 uucljJpnHAH//vk5KKK+63KRtLs/etMFZVn19gQuVnpsXdb9x0Y1ZDMWCHD00K2iPdRAzF3VVnA
 8NxSYT3Zk0gAZs22sj2O+x3IX9SZvk5/TXRQFxgLDbQ==
X-Gm-Gg: ATEYQzyQtWcEBAvmcmwmaXs8HxvNyz2RCW9BQOKg+VlSrvFUBvET2ueZLyb9HkOSnK5
 451mXEl9XsisXUqXFf1uL5qsMrbo9PiuI3PetpvjT6SXYjCQRONiwgwVckKeimfydIueEZTWw03
 W0esVIldOZH/KLhCnLaLonxrdutKUenCpCdxRRQUmBIVUqUKsY4gtPrbQClb5ZEqlO7x28vJ7js
 Z7X8C+3JhOoRw6MxTkeP8jVw9H0jOmVMordEwtY7XcsiunkPVJc+SpPYPRX3hHxQXPEB2JBAZ4Y
 LM9TqNa1/O1sfrawpUsobPlvjMd3I2virhKN3PsFqrqMeJQkDb7i0ICJjz2l/GrIH6Y=
X-Received: by 2002:a05:690c:d88:b0:79a:bbe0:8cae with SMTP id
 00721157ae682-79acf3352a5mr10410557b3.1.1774379190413; Tue, 24 Mar 2026
 12:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260323165218.96607-1-philmd@linaro.org>
 <20260323165218.96607-18-philmd@linaro.org>
In-Reply-To: <20260323165218.96607-18-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 19:06:19 +0000
X-Gm-Features: AaiRm53oHw-CyFSjBFb7mUaapXBH4RyWdUy9wg0Kr8XZ0bXYC5OWw5N1juwKJE8
Message-ID: <CAFEAcA-SKjjEyYVi0myBa9akLJJpV9auPxrNmzU=wL=CK-RAaQ@mail.gmail.com>
Subject: Re: [PULL 17/27] ati-vga: Fix colors when frame buffer endianness
 does not match host
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Mon, 23 Mar 2026 at 16:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> When writing pixels we have to take into account if the frame buffer
> endianness matches the host endianness or we need to swap to correct
> endianness. This caused wrong colors e.g. with PPC Linux guest that
> uses big endian frame buffer when running on little endian host.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Tested-by: Chad Jablonski <chad@jablonski.xyz>
> Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
> Message-ID: <759ed5e3b019cce94e9a4ef003f1fc2e0cea2ec1.1774110169.git.bala=
ton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Hi; Coverity flags this as possibly-wrong code (CID 1645969:

> @@ -89,6 +90,7 @@ static void setup_2d_blt_ctx(const ATIVGAState *s, ATI2=
DCtx *ctx)
>      ctx->host_data_active =3D s->host_data.active;
>      ctx->left_to_right =3D s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT;
>      ctx->top_to_bottom =3D s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM;
> +    ctx->need_swap =3D HOST_BIG_ENDIAN !=3D s->vga.big_endian_fb ? true =
: false;

The issue is that !=3D is higher priority than ?:, and people often
write "X !=3D A ? B : C" when they wanted "X !=3D (A ? B : C)" but they
get "(X !=3D A) ? B : C". Either way, using parentheses helps clarify
for readers.

The priority is actually right for this particular case, but the
expression is unnecessarily complex: we could write more simply:

  ctx->need_swap =3D (HOST_BIG_ENDIAN !=3D s->vga.big_endian_fb);

I've marked the issue in Coverity as false-positive, but we might
consider changing the code also.

-- PMM

