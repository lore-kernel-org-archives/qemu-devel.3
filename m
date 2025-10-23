Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3170CCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuFB-0007jL-Ru; Thu, 23 Oct 2025 08:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBuEx-0007Hn-P3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:16:26 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBuEu-0006Gy-Ef
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:16:22 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-78488cdc20aso9131887b3.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221778; x=1761826578; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYqjNLINwpX2szmtdaLJYoEeEau05KENv0pqi0ZBucM=;
 b=zKn0CMER9JhHhgRoehgTy09N3ZefyH/z8TESd/Gfsn/59RlBeThPYTAyXAG/+9/CNP
 ETRxt7xHUVnb4ojAiv7OAU1SsDvFtlqqPPmNlx/ljMGd4509BXPI3x96aQlcUpvnLGea
 O3T28nRgvwPd3pY6i1iA3WpZ1E7xU0/F8Xu0aAdgAeNnM5fPLiM7/DD+1qPEptWp2fmQ
 C+MEqNNU63AjoUMpuzmp46S10TmbxLwRp6ukmtHWU/H7OmO+dm2zFh+Nkkv4q5n8aTGt
 ZRLZa1o7sblsyF3W2R3yfBfKvZhxzp5yGlQf1L73omxngvvVel7x3B72l6QKLfQUqP0a
 F0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221778; x=1761826578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYqjNLINwpX2szmtdaLJYoEeEau05KENv0pqi0ZBucM=;
 b=ZNQrxjGr5wMH+1ErCinkGQ2Y6jmcCf1Ys5kJhJL88N2UQWL2tbgL87pFwhOMcaeivu
 0jSAfgQXPxdnZzQeLXZwARTLRlMzqz9HuhUGv8CCz4TMy7UUtNdHElMOysYWSICk1A6V
 JJAENOHZZOxm/rqsvWk2Y1k/n3tO7ObuxYPM0E4jP/357wEBAIJ9//9QVc5ydorIC++B
 cLeaydjVROjlC6W8autmWvpGNfZ/vXX+TlRyTXPyw8jCZFb2x3K+68PGik82AMwV6z4j
 hYbsy4E0T7GpLRPVNje0TUTLna961Ye6AtxXhoaAYTM9qaX1afbekiEzu5csL0tpFZ5t
 PYwQ==
X-Gm-Message-State: AOJu0YwOjT5+Lm74HFgYRIVhQ8Xcdyi29j9z1vv4QKgMB3oTsdtl3+Cn
 LWuxa8UtHUx7s8/LkkTr+YLI2TW4hqjmvQs4vfFVkdefBUpvxZN1ZmFpAs15FEfgAgrwCnxHiw9
 m5oAZcSWFvuq1BbO0CaAwpbJ6atcuKyVetreCL0erlg==
X-Gm-Gg: ASbGnct/hKnHysgVmmpUJVv0ao56OIlBhjPA4ft19ctSvxVYFrw5wGGq6B6/gT8Fhzc
 9J4D2QL7gJSFVFfqIf7gyB8VRG04aqDcZnrVvhTrNCAzDAW5dAYmJ9ewh2kACTQngwlW/FvshvS
 WEvI+uIWM9j7AgwSLrmwDAnI9pGUG2mvzYG9Zz/RH7uRZSkrG+4zyzglOxPYkfHupZ0AMve1QP4
 XZHPYPaMbsfUxtOBXapVUPW/bTJ9V7kuzpYmurhSeB9GuDJKmqwO0+mOzz8y5xUCiAzpgra
X-Google-Smtp-Source: AGHT+IEiLIIW68V1fqzLte4oP+NWpVEw+rvK+ML1Dh5hEK9jBH1bTjqE33rdxMrVMpKhGJ+jvReQFWrLaxt5CvrToSE=
X-Received: by 2002:a05:690e:4197:b0:63f:255e:a45f with SMTP id
 956f58d0204a3-63f255ea65dmr7174570d50.38.1761221778461; Thu, 23 Oct 2025
 05:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20251021205741.57109-1-philmd@linaro.org>
 <CAFEAcA8A5xa0nJUczM_BDCvVu+sP-tdbt_CxDGos6hKW27qEZA@mail.gmail.com>
 <a244a654-7bd8-46cf-bc55-87ab5287bda5@linaro.org>
In-Reply-To: <a244a654-7bd8-46cf-bc55-87ab5287bda5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Oct 2025 13:16:07 +0100
X-Gm-Features: AS18NWCNEC6VA1mKUI9demB1yaNupA9PEd2LQywVJM_36-n8rsw2v5RhCitQEOU
Message-ID: <CAFEAcA9y29qsC4UQLjO+sJ5TLiA7FqtBTKwUAaQhq8Bz+WX+2g@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] single-binary: Make hw/arm/ common
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Wed, 22 Oct 2025 at 15:03, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 22/10/25 13:50, Peter Maydell wrote:
> > On Tue, 21 Oct 2025 at 21:57, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> >>
> >> Series fully reviewed.
> >>
> >> Since v6:
> >> - Addressed Jan comment
> >> - Removed aspeed/raspi meson patches
> >
> > I'm assuming you'll take this via your own tree like the
> > other single-binary stuff -- let me know if you want me
> > to take it into target-arm instead.
>
> Since most files are hw/arm/ related, I tried to get it fully reviewed
> before the last Tuesday before soft freeze so you could queue it;
> however it is based on my hw-misc-20251021 pull request, which isn't
> yet merged. I'm happy to merge myself, but would you mind to provide
> your Acked-by tag?

Sure:

Acked-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

