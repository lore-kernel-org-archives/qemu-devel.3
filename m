Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E056ED65522
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyha-0003FW-Un; Tue, 26 Nov 2024 11:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyhY-0003Eo-Px
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:46:13 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyhW-0007LT-OP
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:46:12 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cfd28222f9so3141351a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732639569; x=1733244369; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zE04q7b457xT71pVD4Ufr5C7nwSk/7sow4mENwtg0mE=;
 b=dY7hms0J/XjM8BzSLz8G2C9pIOrqbBL6Q1SZ0a7l+u3jmqiZK7U+ZyGdmc19G2btBW
 r8WACYjSbATDBpeCjc8x5UrT1J69EgmYFYxtOvPZJrrvMulMGJ2rW9ts4ocdwrt0nkgp
 afEzOR0EBi6vWprXJA+mFq3/Dd25XYiK219b6ZzPZc4Ha0qf2fn2iYI7z77wQXhS121q
 rjFFIC3WL4+Y9FWeoW28g+vdPv/YxBXlXot5QiH4GuTsiRwtqsviz3evIWWhzl7ySafE
 UYOG2ZuAEB1GRX0/wSxrFV3+BN4O5EzGqp2ceF9WxX4JtQCmGs+rD01NYMKPWrjjGEbK
 mS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732639569; x=1733244369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zE04q7b457xT71pVD4Ufr5C7nwSk/7sow4mENwtg0mE=;
 b=QVG80laDugRiO+vcCBJ5XKknQ6MDHcL4GWUzQqk+wtzBL8TkuRKR70Xuc0fJfTNNdI
 MbUUnr7OcqhP72OlkdxFATlTX1OR9VPCrIxBbRLuBbcOG/NWIwDZBU3kiZGT8nbT/a26
 5pocnw/9nfNEzBgpGmGTE3lZ/7VNhfWuTF+BRzkfKPRZ3fNWPGUHdzJ3b95cJFYPt+2j
 ERlEgQ0/UW+TLf/eC6kXnvEvjfZ4wAiCI9A3PVJOAKkhM0/ftUjx2cbUrcOsNQ2o3f4l
 PlyEdCnT7p+hX8nbcgyqoV2l03GZyXNdsMiqcYFww1Hs18F71pLx+yRvqnPP6/p0+Z2l
 9U+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbR3LuNr9u9hf0aQ1Zr5VViZJ1o5C7CM/M5VZxv76+KuY4x92jaadt1oa/hyhRZ8hISZt2+EcYshy9@nongnu.org
X-Gm-Message-State: AOJu0Yy0mf7hnN6EPMwHYj3jl4qHhwdoe6vSaHm00qXZ3ROT5Tz0QaSi
 9cYRoReWuU3yq8v/oQcZ9S94iN2Aczwze8Vz+C9F3anU5f//RHhA8UUHpH7xKdz4ZJJkaBu/Bnp
 5YpB6dNMcnfDkgCPt3t5EbF4MgNUYWTa2uKTumw==
X-Gm-Gg: ASbGncsXnYq8BJs1MIXZLubFWHZVVhgWfSUGWpNFMSY1CV3Llc2QS2nDLUFgU7a0yLH
 61oNI3mSEGSmaWf2b+xrLQSGYUkvXxlkX
X-Google-Smtp-Source: AGHT+IESgI7yfkcEFP2yVi5fyXux5qznZQBWjvNcc7AWfougkoCjFUNwj+W1n+BuCiUB7P+kdVa4C9NSqecql6jebu8=
X-Received: by 2002:a05:6402:3511:b0:5cf:cfa8:d6cf with SMTP id
 4fb4d7f45d1cf-5d02066288emr22005458a12.17.1732639568918; Tue, 26 Nov 2024
 08:46:08 -0800 (PST)
MIME-Version: 1.0
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
In-Reply-To: <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 16:45:58 +0000
Message-ID: <CAFEAcA_iem8QN+BDUJPzMrhbYRNmq5GRbX-bqaACdUS1BAkpwQ@mail.gmail.com>
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 26 Nov 2024 at 16:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 4/9/24 12:38, Thomas Huth wrote:
> > From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >
> > Many tests need to access assets stored on remote sites. We don't want
> > to download these during test execution when run by meson, since this
> > risks hitting test timeouts when data transfers are slow.
> >
> > Add support for pre-emptive caching of assets by setting the env var
> > QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> > instead of running the test, the assets will be downloaded and saved
> > to the cache, then the timestamp file created.
> >
> > A meson custom target is created as a dependency of each test suite
> > to trigger the pre-emptive caching logic before the test runs.
> >
> > When run in caching mode, it will locate assets by looking for class
> > level variables with a name prefix "ASSET_", and type "Asset".
> >
> > At the ninja level
> >
> >     ninja test --suite functional
> >
> > will speculatively download any assets that are not already cached,
> > so it is advisable to set a timeout multiplier.
> >
> >     QEMU_TEST_NO_DOWNLOAD=3D1 ninja test --suite functional
> >
> > will fail the test if a required asset is not already cached
> >
> >     ninja precache-functional
> >
> > will download and cache all assets required by the functional
> > tests
> >
> > At the make level, precaching is always done by
> >
> >     make check-functional
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Tested-by: Richard Henderson <richard.henderson@linaro.org>
> > [thuth: Remove the duplicated "path =3D os.path.basename(...)" line]
> > Message-ID: <20240830133841.142644-16-thuth@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   tests/Makefile.include                 |  3 ++-
> >   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
> >   tests/functional/qemu_test/asset.py    | 34 +++++++++++++++++++++++++=
+
> >   tests/functional/qemu_test/testcase.py |  7 ++++++
> >   4 files changed, 74 insertions(+), 3 deletions(-)
>
>
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qem=
u_test/asset.py
> > index c0e675d847..b329ab7dbe 100644
> > --- a/tests/functional/qemu_test/asset.py
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -9,6 +9,8 @@
> >   import logging
> >   import os
> >   import subprocess
> > +import sys
> > +import unittest
> >   import urllib.request
> >   from pathlib import Path
> >   from shutil import copyfileobj
> > @@ -62,6 +64,9 @@ def fetch(self):
> >                              self.cache_file, self.url)
> >               return str(self.cache_file)
> >
> > +        if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> > +            raise Exception("Asset cache is invalid and downloads disa=
bled")
> > +
> >           self.log.info("Downloading %s to %s...", self.url, self.cache=
_file)
> >           tmp_cache_file =3D self.cache_file.with_suffix(".download")
> >
> > @@ -95,3 +100,32 @@ def fetch(self):
> >
> >           self.log.info("Cached %s at %s" % (self.url, self.cache_file)=
)
> >           return str(self.cache_file)
> > +
> > +    def precache_test(test):
> > +        log =3D logging.getLogger('qemu-test')
> > +        log.setLevel(logging.DEBUG)
> > +        handler =3D logging.StreamHandler(sys.stdout)
> > +        handler.setLevel(logging.DEBUG)
> > +        formatter =3D logging.Formatter(
> > +            '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
> > +        handler.setFormatter(formatter)
> > +        log.addHandler(handler)
> > +        for name, asset in vars(test.__class__).items():
> > +            if name.startswith("ASSET_") and type(asset) =3D=3D Asset:
> > +                log.info("Attempting to cache '%s'" % asset)
> > +                asset.fetch()
>
> fetch() can fail [*] (see previous patch, various Exceptions returned).
>
> What should we do in this case? If we ignore a missing artifact,
> the tests will eventually fail. Better bail out early and save
> credit minutes?

And more generally, can we arrange to cache these images
in a way that lets us share them across k8s CI runners?
Store to local disk doesn't help much there...

thanks
-- PMM

