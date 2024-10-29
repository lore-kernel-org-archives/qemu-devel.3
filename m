Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD20D2AB11
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 10:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5j5R-0000cS-H6; Tue, 29 Oct 2024 06:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5j5K-0000bz-Q7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:04:22 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5j5I-0000LD-NG
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 06:04:22 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cb6ca2a776so7027558a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730196256; x=1730801056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TGQzTH7cvAXMRunlAKMoaanSSwnYgM4Ity1oRMAKsj8=;
 b=Td0Tt94jPu4qRMtqph8+AFzJXMK16KG1OjQEJGdv6IpzL6Pl9rP2FvFZmNiwKnVFjc
 t4nUc0FQDN25EhKHHT+7MHYrBVJdU249sJyyPYl5riPk7aXfTO31VP1XBJdkCmEqOMEO
 MAuNDllw/nHEtP4zwe9ZIM1hgm9hu6UZFlI9okCLJltv565n9UTPDdGz+v22VYWrYoAl
 5/rwK3PSSpbky0++Rr7IWhI6kwOLNlDOiTAkQbpF/Agp/E4apxD/KonX7E4rAnOXo+m+
 rhruReaKRImyTtCeZkEJKxzLvQQo3WrmAIJkzgrx8t7U7lcLj0eppF5eAcKKnGyq3/K0
 /21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730196256; x=1730801056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGQzTH7cvAXMRunlAKMoaanSSwnYgM4Ity1oRMAKsj8=;
 b=LXSjwcQVkIjOfVPuyB2B2zhXtwAMg2fkgvlsZgojn5BiwQ72oVm27ksAky6ucN8ZwT
 VREvmRqFAidU3/1jR8ohosCuaDi5JaWctTkFWC3OwwzuMB977xCiqjuNCbwTWSRpTIL6
 QUoCKwPkfF7Adrmt7kBQAHek9X6lKdRUwVc+efEVsAbdkqW7wiDvKMEd+B5R2wLbtcuw
 OYeu33NauIGNp1QopxKm++2LVKnYvtdWM9WCZyknaRRLKnwyMoRgEDLJaWbxxEELI924
 Qarj6QBCxu90M4/6DFzu8ftmuyt57QitcXyRPKtEdEv69tjfmQUgQnBni54U0Ieik0Cm
 p6rQ==
X-Gm-Message-State: AOJu0YzIPrvfgyNsL8xuVM4ZQ3bZqMinnrcW9ypkodJUJPQGYrcf7eER
 o/Ngjv7iH5k2I0sapqzSy7LohCRZbnC+0+93liLRl6dROi6oJouH59n8Hv2INJK2Sun6d6Dp9wq
 s8K7VOsTHZlodBGAHQMTjq0lNQCB5BnxTYiKtmw==
X-Google-Smtp-Source: AGHT+IEtqvjk/uM+3Pc+5/ku12OgVS1YMi4Wy3ARsVIMlyGecyJsdXptv2hsSRvb+6u6mIJzAAqwFxF4Sgb2l58erGE=
X-Received: by 2002:a05:6402:42c6:b0:5c5:cbfd:b3a8 with SMTP id
 4fb4d7f45d1cf-5cbbf87607dmr8138469a12.1.1730196256019; Tue, 29 Oct 2024
 03:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20241018130852.931509-1-peter.maydell@linaro.org>
 <153648b2-1978-45ca-9731-b922da98d81d@linaro.org>
In-Reply-To: <153648b2-1978-45ca-9731-b922da98d81d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 10:04:04 +0000
Message-ID: <CAFEAcA-s4uji7rufaE394=kWMxEtWA3+XQMozfjx0uHscpnO5Q@mail.gmail.com>
Subject: Re: [PATCH v4] scripts/symlink-install-tree.py: Fix MESONINTROSPECT
 parsing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Christophe Lyon <christophe.lyon@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 28 Oct 2024 at 19:43, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 10/18/24 06:08, Peter Maydell wrote:
> > From: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> > must be parsed with shlex.split().  Otherwise the script will fail if
> > the build directory has a character like "~" in it.
> >
> > Note: this fix cannot be backported directly to any stable branch
> > that doesn't require Meson version 1.4.0 or better; otherwise it will
> > work OK on Linux but will break on Windows hosts.
> >
> > (Unfortunately, Meson prior to version 1.4.0 was inconsistent between
> > host OSes about how it quoted arguments, and used a different quoting
> > process on Windows hosts.  Our current git trunk already requires
> > 1.5.0 as of commit 07f0d32641e ("Require meson version 1.5.0"), but
> > the stable branches are still on older Meson.)
> >
> > Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> > Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > [PMM: Updated commit message to give all the detail about the
> > Meson version compability requirements.]
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > This is essentially back to version 1 of Akihiko's patch, now we
> > have a new enough Meson; I just updated the commit message.
> >   https://patchew.org/QEMU/20230812061540.5398-1-akihiko.odaki@daynix.com/
> > (I have dropped the various reviewed-by and tested-by headers because
> > I figured the passage of time was enough to make them moot.)
> >
> >   scripts/symlink-install-tree.py | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
> > index 8ed97e3c943..b72563895c5 100644
> > --- a/scripts/symlink-install-tree.py
> > +++ b/scripts/symlink-install-tree.py
> > @@ -4,6 +4,7 @@
> >   import errno
> >   import json
> >   import os
> > +import shlex
> >   import subprocess
> >   import sys
> >
> > @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
> >       return str(PurePath(d1, *PurePath(d2).parts[1:]))
> >
> >   introspect = os.environ.get('MESONINTROSPECT')
> > -out = subprocess.run([*introspect.split(' '), '--installed'],
> > +out = subprocess.run([*shlex.split(introspect), '--installed'],
> >                        stdout=subprocess.PIPE, check=True).stdout
> >   for source, dest in json.loads(out).items():
> >       bundle_dest = destdir_join('qemu-bundle', dest)
>
> Hi,
>
> would that be possible to pull this patch please?
> It's currently blocking the devs who reported it initially.

Yes, I'll put it in my upcoming pullreq.

thanks
-- PMM

