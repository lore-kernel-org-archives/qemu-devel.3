Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ED8CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJKH-00018F-UK; Thu, 18 Jun 2026 16:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1waJKD-00017X-Sf
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:26:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1waJKC-0002R7-5E
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:26:57 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so2687469a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781814414; cv=none;
 d=google.com; s=arc-20240605;
 b=QQAtMCYaM90n53m0QFF3hMt4C29hkt+LcHjEsCwAldZf/g4sFOKHJa+yAsA2+8pQiO
 r7GCKOopLq+Y97Szv7pYS7ikaGlFpR2EFGDsHv/p1s09wolDiEqFvvuCxiA35h/Zwhdu
 0r4rF7BzOHO/Lq2sCVZuebl78RzW8K00qkykTR9hMU0BzbnFMPImxhJKlBrlyn9mlstI
 rBWZlxR9ExO6+qG7GjoHbAhAbwhWqwWVzjs3qekesVj4xa07PGx7j/9CjxHUGm3QZE5C
 Y8NlGUto+9moEjTdxOrMijNNaM54R4xbqtvI2UKAZqDu1tBtCFu8TCWTqQq8RfhzOHxr
 9h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5U6abxzYqXqTkNqOWo8a5DjfAn/2Ke1zbVIrUoGxctw=;
 fh=WvAZIdnWVTd1GrEeYPLgZHgJYqCQ7zMxjiFpXrm7D88=;
 b=HCt1o7LDKyNsVcky9Bs4R0QWVEg+HFMLfxWbe54A5/Mou25skFgvhO/vmex0zJn90J
 nKjFX+W7ckys2/b9WCxQDfLjLugnpjsgnZe/iECzUbt5HR2nxEkizsEeJi/ZMDnLuNRl
 RBHzaQpVkLhUcVPdQxJkuK9qgjy6k4UJVrS7bGOUIOx80JvNQWYocfmmjVIbsvkAEt5k
 YXjkl7/8gZ0+pxogJygxrPmXf9Q5PGX10TseLGEKAQpPf3ZOq3NEExzvGi41XY5PYeH9
 i7oIrCoggQa1mFxmHBoplYmtwMYCQAR5TLx4PD1xosZuNjmJYSiyz1jwT7fn8OFwrUlo
 12SQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781814414; x=1782419214; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5U6abxzYqXqTkNqOWo8a5DjfAn/2Ke1zbVIrUoGxctw=;
 b=Nb6MCpixohWJpIblwOMfErAT6wScMFzadz5rymw2Zvu19wDnR5IXKkKPI664KEXMUB
 Wa8GMH2jF4WyQ6PPAf314/lmhDqPBLv+zEqFmQAHS37+y5UzIgd1VtQT9Jv0Kzfvnu+k
 v4TqvMJakMX89ja8T87bQw96PoRIoU2GHv+rjVIsZOVAi2XOd9RDudEp4LhZVBklcq9N
 UiI9tW+Mvki6xl7bf/GAjR9XG9phlka729IJd6n7z8ohNTAveF6tobbLJEeHqiA+KMRL
 EKUGBcXqe/ETo+RKx6kTkSRQ6DwyzB78pVoE8DB2UF1fqOvqzILrHZ/s779hjxOK4suY
 MH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781814414; x=1782419214;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5U6abxzYqXqTkNqOWo8a5DjfAn/2Ke1zbVIrUoGxctw=;
 b=HiKg635nJc3msbIBjFlvFHjz7Jwf7pvfJ27qj+Ow+SUC5pW0eZdF4ea9om/FLVoxvB
 jQ3aM40hqlEU2BcOkl+Mxo4mvMO2N6mDoKsq4ChXoqdLkAZbiXlwgoh0WnMszkdeHfXB
 LvD8jID05iUBhheTJSsEaCO8X5dahDQrZgyEBN9yNVqdWVcl0aKOgHsgVkC3CTbEyZs6
 R2GkrKK2zOJl5da73m11ruqKNkGIwma24hPEbWHs924lBdy0CY51XrS6WNKsKhkYr7Lb
 HC0JkmzzniJIXSJrGY4gdNGms6ylhZuc3Dpky4nX+YcsQIxk5XobBplquIKBrI0+TR45
 hfOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YEKtR6X1dvIkTd024r9LwwULhzS6cUeoLlGFv/Qew/vc2zGsC0kj9W5DMnyhtK717eko58oaXD8cK@nongnu.org
X-Gm-Message-State: AOJu0YzBi+sBJtoPnIbD5y8efrujAesV6GaLf0ODvWOCzt7jp3XYE8Jc
 NLB1yvEByp2j9ejWJQR81j5AIn/mwViZkUsDFDfC6a6VglO7e7PJHAHzdDvHoyMtiR7H49fUT2A
 uszRW1oQ+wWeGfSDjuwucSmr3Ty/dYlw=
X-Gm-Gg: AfdE7ckXmpu2cwQ3Vmgzv7EJM/kWxj5SAsDGefPfcjS//M6ud57EIgsjGxd4Ah95egn
 D4EpFCfismGEpoTE3fgjl2LmZcQ9okGV3uKcY+/KptBCd5+bXVzZZ4K8e1M01ghmn7jDxhYyNwu
 02k0g1kRtZeHa5ohztHyu4r5jOLcOy29LjtpLmMfzqoADrkYqaPZYJjzYZQpKTqKWqkQuPIDA+1
 9+yyYXtWSTVwJX69hytIhyGliVKZZBBDLoC9hNcJ4OAJ8Q3spn+zV3RY8jqVuuZvW5hgkIgfI2u
 dcvqpzGVDj80Q/JWSf069FRKFbs5mZM=
X-Received: by 2002:a05:6402:915:b0:687:261a:3391 with SMTP id
 4fb4d7f45d1cf-696dde36911mr601256a12.6.1781814414389; Thu, 18 Jun 2026
 13:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260618082623.345255-1-th.huth@posteo.eu>
 <20260618175353.GA748600@fedora>
 <CAFEAcA93R4UXit4UNLf36RXS3k4MaBWOXwqP8rNFzC47B_wAoA@mail.gmail.com>
 <CAJSP0QWkjc_rjJ8-=5_fFce1JriFsLnWwGiF9=qWQAZKRz8jHQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWkjc_rjJ8-=5_fFce1JriFsLnWwGiF9=qWQAZKRz8jHQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 18 Jun 2026 16:26:41 -0400
X-Gm-Features: AVVi8CfNFcEPsDW3sDyfxVpOJlqqeNxtFCjgZiPqaxrp6n850g1N4iPm1LIh-SE
Message-ID: <CAJSP0QWutQ6o7037sXqv3goAmNFRQqVE6L+Hq7QztHT9nW4e8g@mail.gmail.com>
Subject: Re: [PULL SUBSYSTEM pseries 0/1] pseries: Update SLOF firmware image
 to release 20260618
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <th.huth@posteo.eu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
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

On Thu, Jun 18, 2026 at 3:01=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Thu, Jun 18, 2026 at 2:36=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 18 Jun 2026 at 18:54, Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> > >
> > > Applied, thanks.
> > >
> > > Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 f=
or any user-visible changes.
> >
> > "PULL SUBSYSTEM" pullreqs are our marker for the oddball ones
> > that are for a subsystem maintainer, not direct application to
> > master. It also says "not for master" in the cover letter.
> >
> > cf: https://www.qemu.org/docs/master/devel/submitting-a-pull-request.ht=
ml
> > (last bullet point)
> >
> > FWIW, my gmail filter for pull requests is
> >   "for you to fetch changes up to" list:(qemu-devel.nongnu.org) -{"not
> > for master" "PULL SUBSYSTEM"}
>
> Oops. I will filter out "PULL SUBSYSTEM" pull requests, thanks for sharin=
g that.

I haven't pushed to master yet, so I will drop this pull request.
Please take it through the ppc subsystem as originally intended.

Thanks,
Stefan

