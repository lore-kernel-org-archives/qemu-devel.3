Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54033CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUmyq-0000pu-F3; Wed, 03 Jun 2026 10:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUmyo-0000pa-Tx
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:54:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wUmyn-0004ME-Fz
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 10:54:02 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-68d232ed3f9so5706539a12.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 07:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780498440; cv=none;
 d=google.com; s=arc-20240605;
 b=YuZOZuaTWYzDx9K/3qa1fC486JFPYeBDkEuw0ffBz/2xba4lz+D5EjBbacX3UA4UBu
 VU40P/cb4QA8JonjJplpVO2wSazo04GQ1nWrI6BNqUHHGNODz0AMM1TzU4tePrpC6TtD
 iiYorgtvGnqsMa2gyaYs1v9M8QP2uHdGaw+ksrX0+kjwIvD1K+0HYCrAsQI/A5NxKy9x
 AiqGwSXlctOEA5lzxHdCi4x2hXqeZxD+jqQ7cJRgmtWeSzhOrIwPA70+8PYzK79L1J1N
 w0PzhBUJauAfr+LiMm3F8RyZVl++aQFevy+j3ZSSg9E/GsMPtq6VY6CLUnm71AvfvNSh
 Mmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CcAil5XNg7ZGpEtXIynu9OSocdkAwXt37xUP9Wd1/vY=;
 fh=5V3hMYH+Zd3jcS+n3RYyHyQSkZNj7y4hRHBPhccdWp0=;
 b=k3+ipfH+1woPuIp7Om7YoP6wBe1dZQOW965gPKZO58YQvd+IlKcteHzrHJvc2Ib8Xw
 feQ9PjwuD97nzRo93Gxh18GQht/GfBt9IU4k3Wj+4aLCGks5xwccwXdGevPAjzvdKBN5
 BsKICW7E6FDuMutUU5nuklXlWXexhOg19C3dG03xhoQ2rgORLlRZ/j0g+KCUe/2WAns4
 sEScY0Mfdmti/AZvwuRIF2PNbtks6ozZXBcMEd9EEdIAdPR9fFs9Cvzpn09vHqmCvFyh
 Kv5CKqVZuMjyxtd3vvyS6LsHPEp17QY+VYsfVXsxb3rmnNm78P0dKBK31ITmXCb3Eum7
 MDYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780498440; x=1781103240; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcAil5XNg7ZGpEtXIynu9OSocdkAwXt37xUP9Wd1/vY=;
 b=e00yUJbR0nzb06FSz5w3GrP5VqJ8jbJY/V/kfEuPuGLcTPrvX0qOrlJ+7Z385JRBz/
 XoqrVUkGKybqDCBtavEPjXvaqojyfCEAKvtkll/vxtJ+AvPs5SrJ7K6vYE79EUgaT9RL
 vxrJP4IvEZJXGqCAnlTv9Q1WXDsofe7lRPoPNYU/Y8ZcFdaAqtqUmLoZABWQkoQq5pjE
 IwdbLuxOMFzIIgea/7yXSfOneKWVivBJthRrcVRyTZzx+FA0NvF0e82RNZQqDDLN7ACV
 HsLOV1UWH4OQMocmfvXoYZmyX61lord8kjB93fb2TutUB/VMvIZ4gHaeDSRgHmwnw5i1
 e61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498440; x=1781103240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CcAil5XNg7ZGpEtXIynu9OSocdkAwXt37xUP9Wd1/vY=;
 b=elhMEKMrzyXS65ZL6Uyy6vNg9cNNuBoPazgo4Z7mq6k9AVXe6XOB9JXLDc11j+8KlP
 rtZxJpMF/sHahzrwXfEkY1SyN/syBnDfgK8Zsmu10l427RabuJMk8OrP0h+Y1bicek7u
 2C0YaG5p0yNxiQXV/QoC30LEfp2HQURZRdnxZhzVYC3TAZKlPeyF5x2AvvGLYGYGAAEG
 yLuvQiO7sxoOULfUuygupCpKO3oFicQwaDu4p6Qz9Dlr7xynrybQUdjnjea08YhY8eiL
 JyLybr7l3j1tjQ0lAvv8vucdjNAX2Oq9Q7jreDoAbwES4t1c7q4bqqGiB0ClO7l5yV6z
 sggQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nWruGQrjPVtNtV8anaV8QAdnc69Qxs/1Ra8hox/8UhiBYNLCEh1doauuI+d7PdwMiwOJp2qgTDE8t@nongnu.org
X-Gm-Message-State: AOJu0Yy65J6cxJH+8FLrdkZsyNmc0297FWzuMbK84xNkr4oG8vu1FspK
 ZgieXygE081f+sCrUKgHR0pG/3rJvqx3YchAK6tB2E3sIyqcHVx7e4I4F9PQESBzFfoA3snxk5M
 3MGWbEZeQaym1fbrG8F4Rt65VvLw3+fE=
X-Gm-Gg: Acq92OGOvnKYHHXED1JwDcwKuMVyQ0LunJhwjJhvbzcU8kEk29MARa97nj3sMvOOj3t
 4GpN+oTo/WRFTtRHBQ3afZ+Q2828GfV/29UiOkZh6LmoWadI3uV5om7DP3X15H1x2edQ7H0+O9W
 DSMUBi/2hrA0RqxFrnXDymXBZgD3tgKFWfJdh5cPBdvkhzDFaqAtgl+7NA5y4/eB2UItHoT0W1A
 ft8raVbvtn/LjkIFLDFBx8jS0J4m7YvsfepGi2MrllAfP2cNRP95F+GNfpfEqfpXQ4cs5ePIxYY
 akyE5Og2AewpWIpv0sOZFvDrMY/F7QAmZfZ78KxPtRAlWauoVKNw
X-Received: by 2002:a05:6402:35cd:b0:684:70a:4506 with SMTP id
 4fb4d7f45d1cf-68e714d8db1mr2055329a12.15.1780498439610; Wed, 03 Jun 2026
 07:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-4-stefanha@redhat.com>
 <87mrxckl3m.fsf@pond.sub.org>
In-Reply-To: <87mrxckl3m.fsf@pond.sub.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 3 Jun 2026 10:53:47 -0400
X-Gm-Features: AVHnY4KBvdhe5JPTtbxMkhhN8zTe0zdBbYIVLrWUVi16qVPnaI8MQe3gUBGlN_A
Message-ID: <CAJSP0QXMJhJ1US4UrCa_HjfFNFvN6Os-iBipFn_g6K8J2rMvrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: remove stale Cirrus macOS build job path
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Warner Losh <imp@bsdimp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jun 3, 2026 at 5:52=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Stefan Hajnoczi <stefanha@redhat.com> writes:
>
> > Commit 984b192bdf37 ("ci: drop cirrus MacOS build") removed the Cirrus
> > macOS build job. The MAINTAINERS file now contains a stale path that
> > should be removed.
> >
> > Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4ff33eb630..0c0c8c0a37 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -701,7 +701,6 @@ F: scripts/nsis.py
> >  Darwin (macOS, iOS)
> >  M: Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>
> >  S: Odd Fixes
> > -F: .gitlab-ci.d/cirrus/macos-*
>
> We also need
>
>   +F: .gitlab-ci.d/macos*
>
> >  F: */*.m
> >  F: scripts/entitlement.sh
>
> I posted this as
>
>     Subject: [PATCH v2 10/38] MAINTAINERS: Fix F: in "Darwin (macOS, iOS)=
"
>     Date: Wed, 3 Jun 2026 08:40:04 +0200
>     Message-ID: <20260603064032.3733394-11-armbru@redhat.com>
>
> I wasn't aware of your patch until Philippe pointed it out to me in his
> review of mine.

Your patch is better, thanks. I request that the .gitlab-ci.d/
maintainers drop this patch from my series when merging.

Stefan

