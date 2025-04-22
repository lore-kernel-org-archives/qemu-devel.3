Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17679C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 13:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Da0-0001Lz-OG; Tue, 22 Apr 2025 09:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u7DZz-0001Lh-6Q
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:22:27 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u7DZw-0002nS-VK
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 09:22:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5f63ac6ef0fso5269303a12.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745328143; x=1745932943; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YC2zh+7fsMo+S2wOj6mFWADhXqSooycnVG+gh2Genk=;
 b=CGKKtKXIBXqxBG9+zMVIdGd2Ek64jnstcF2UOsyaDYKXRAL5a4Lz7HoRAYiUXP/4Va
 h41r1FIQiyxNuHYjudWEd3AuI4Xg35d9jBcgkbU6maUe+RZ+4vWjFUkwrHa/Rxv+1tOH
 jgEQL98MI5Vo+7L6itn2xZm5iKbSA7ysVKMs8kWRLgOusPGhahBBW2p2q3dn6lx+4XdB
 jgHBEI9ztgGrsQZAc6KQQ12ZFN10i/IclOWN5c94AxnqWskIqAogULL2nJVYsExBUZpC
 qvKfZ2FQgb75WZ18OZC/02+SeMJ+MRv0K8YGHuuF8WpJTXAxvPquvU/5HBLUCb0sR4g2
 G6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745328143; x=1745932943;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YC2zh+7fsMo+S2wOj6mFWADhXqSooycnVG+gh2Genk=;
 b=Zst67US0xyFQqW+zGX1LhAkhobZO3wyIDeqgH/8cDZQB28+to+dTgdKzjLXjv/2R3s
 4/aAhoterw/jLHw5EDGbJQ47J4qh/B/3f+IHspd6zaMoAB7HYFtcJiAwlra5gBwOLWhN
 V14MGnpf+MHKwA647QncmabpYyAyWuVX2IKO8JXg0Mxq5oXCjqFbXkQEYnUxFxFVFVd8
 3GWDsoTpZbifRA8WtdObX65RtZv+ljSIXQWh2HXd4QobXyWcLo+UTBsbEzx6arzaJKVF
 cA1CzInkoQiiH12t73AnlJGxugv9d+dtDRA2Gg6VfYfDkyjLkn7bsDNCQ41kxpR7RAwy
 7ufA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuBRpq8vvrjXIbJq1auSBDF4wHYc0RyAnccIj4eAJhByxhS3NLHqeqFonDHJ5zDTZHz5URwVbbMvrI@nongnu.org
X-Gm-Message-State: AOJu0Yzp/p2A5vFKbVziB7hilSs86c5fmGg1k7tvUAFRpcwiCsYXe4B8
 INjMzIV/394oaQb9ERIJ7Ro+hIHkZK/CELWaYMtfdoy+z7IUzRKFqKoCDG/1YhppJqSYIIuFGYw
 zUwiOJdmYmBFHFSNaw3o/FMMikt8=
X-Gm-Gg: ASbGnctopWIdrfYNBgGixzPu4big4G22B7dZaVKZXAQCjiB/ihVIYj+LKzztjnpFHoq
 n9d4alaxxWjmHAp6xIIuCLP9vYSmg6eecLJdGYRNjvka57x0hveyiWBCI/Eu/8eX/6+/aJddYzh
 AuRCN0BzYh9KaEql3B91U3
X-Google-Smtp-Source: AGHT+IHmKCoXLHxixXSdwAgHkIOlh27FQs7qxzBSXHwe1P+mZucD+4QEXpPVYgkRS1kdIJNxjLWQ73liOCbpMaElDlI=
X-Received: by 2002:a05:6402:5253:b0:5e5:ba77:6f42 with SMTP id
 4fb4d7f45d1cf-5f6239b986amr13215277a12.4.1745328142743; Tue, 22 Apr 2025
 06:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250422125626.72907-1-thuth@redhat.com>
 <aAeUx41_yHq8QA1s@redhat.com>
In-Reply-To: <aAeUx41_yHq8QA1s@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 22 Apr 2025 09:22:10 -0400
X-Gm-Features: ATxdqUGDlck16kjXn87onRJBYslBx2SMpQpE6UGKIu6_B7k_-gGM998QjpIk3pA
Message-ID: <CAJSP0QUAUss1aGSYbcyprzuxQv4bEQGc_Owv557hK-Te0PKSaA@mail.gmail.com>
Subject: Re: [PATCH] tests/docker/dockerfiles: Use Fedora 41 for the python
 container file
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x529.google.com
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

On Tue, Apr 22, 2025 at 9:09=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Apr 22, 2025 at 02:56:26PM +0200, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >
> > Using "fedora:latest" now fails with Fedora 42:
> >
> >   Failed to resolve the transaction:
> >   No match for argument: python3.8
> >
> > Switch back to Fedora 41 for the time being, to be able to still
> > test with Python 3.8.
>
> This page details why it is was removed:
>
>   https://fedoraproject.org/wiki/Changes/RetirePython3.8
>
> Based on the explanation there, it seems doubtful that any of our
> targetted build platforms have python 3.8. Thus I'd question whether
> we should test 3.8 at all.
>
> IOW, rather than pin to fedora:41, it seems better to drop
> python3.8 from the dockerfile.

I'm in favor of pinning so that the test is reproducible. A test that
passed on a given git commit should pass again when it is re-run.

It's very inconvenient when tests fail arbitrarily due to unpinned
dependencies. Often the person who has to debug a non-reproducible
test failure is not knowledgeable about the test setup. They shouldn't
have to debug failures unrelated to their patch series.

Stefan

>
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  tests/docker/dockerfiles/python.docker | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dock=
erfiles/python.docker
> > index 8f0af9ef25f..1245523320d 100644
> > --- a/tests/docker/dockerfiles/python.docker
> > +++ b/tests/docker/dockerfiles/python.docker
> > @@ -1,6 +1,6 @@
> >  # Python library testing environment
> >
> > -FROM fedora:latest
> > +FROM fedora:41
> >  MAINTAINER John Snow <jsnow@redhat.com>
> >
> >  # Please keep this list sorted alphabetically
> > --
> > 2.49.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>

