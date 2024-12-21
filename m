Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5703FE77188
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 02:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOpDR-0003CJ-Gz; Fri, 20 Dec 2024 21:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpDP-0003C5-9Q; Fri, 20 Dec 2024 21:27:39 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOpDL-000059-J7; Fri, 20 Dec 2024 21:27:38 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725ce7b82cbso3003371b3a.0; 
 Fri, 20 Dec 2024 18:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734748051; x=1735352851; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiDLvv4AbuKzZhFpV2nkOBZYGUZgUTlsluTNZoDe1TI=;
 b=MOFx0VUNOJfjVyjp/BtPXZJWWy6dTkMejNb9fPOXaqSJhOlNItBlCfyexaqywFYDAG
 SvSU6I/X+5N+FPwMnlaBzqVjC8D0pzuhhXYjcuBXdMIOFn8Lk98Rf+j21HTWADsHGNWx
 HZUv3UN4rHrt0VVwl/YCOs7xBDMhc+aOO6xwyUUqcTzfqUPLeynikFluPkRdpW6zDKU/
 +VVYCXbCU5+4ADPlEEi37F4fj5+DjAjBbdFsz34bUcSxtz1MBDs8QAtxWwx04z7+uSso
 20Yt/nBBgYT5bzcRQCfKcqxpBArWrMOH11zQTqqsMgWJLJwUweBx7HJSbBcw3+dE4Eo2
 OaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734748051; x=1735352851;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UiDLvv4AbuKzZhFpV2nkOBZYGUZgUTlsluTNZoDe1TI=;
 b=roxY2wKX6PjjmfRS2eEp1p/1DxFZ1TmlsFYXtvj7BWqJkjOqeGUKYf1nQf0iAM5M7R
 tku3EVa4X0eHLfjdrtHHNb36nE3Tqsh+8rN3Fc9NcgvxcTuJJShuzaZdmi1WvZun0XX1
 hZiZ20SonPNbXrqFV4CXBPScdafrKUoA3tBwhIhfrfViybS+OX4UL3yaXg1AlGPBnQot
 OxBitkhPDE9h47PodgFhkkeh9lrOoEIMCD2JTn+fXTLWyNVQTRxtqoNLUls/LcfL3/d8
 JjK6b803k5PDOElWkVzaYUEMzBtWHzeqCHhB/VUHllmf5ISiXNx/3o1OcUS+q03LDYBI
 pqVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvL0g+iLkV8QnpLftQQc40GSgYifG0g9/gK1hfJLoMjtS1BMDEZ7hYW8PPWE6ngFLrIV1HsFxcIQ==@nongnu.org
X-Gm-Message-State: AOJu0YzN8XuqAMkTpOFVpnmH6adW8mk9+dBLvybngh+XeSzp2cM8UF7K
 S1oZe/zzMUDyAtKL4jAFulyTQrHjoOo0vDCto5ZeWkEth6iV5/uG
X-Gm-Gg: ASbGncvdfB1zfvwQKJFaTLxhlTHLUXclXccpgilwuYpufEYkS+zfxRKcw6acobfPmiZ
 80ELEPWsPVdk7R8LeLIZ9mkYtghLyCAQgjN0zIqtHGfkW/Xm4vYtbTUUCFxuHZB3pEewPJjmoqg
 g7R/nsEmBbCNGpAim9rXip5U3gPFyS3oXMpDfuLd2ow6pj8UKfL8uODA5buVbNs9cO9G6X+ztzI
 vvL0yYd8xcQh48nPVHH+p7NUPFyNfxXbkGbkHC64e+TAYlT6VWX
X-Google-Smtp-Source: AGHT+IHrfrXS7PIciRnoSPyLV9PhxISfThdWXBSyAalkXFFUT1cBvZ4DBUJGJU/osIuIAwIvBxEHJw==
X-Received: by 2002:a05:6a21:e8d:b0:1e1:adcd:eae5 with SMTP id
 adf61e73a8af0-1e5e0846948mr8431540637.42.1734748050952; 
 Fri, 20 Dec 2024 18:27:30 -0800 (PST)
Received: from localhost ([203.221.215.169]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fccd5sm3806282b3a.168.2024.12.20.18.27.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 18:27:30 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Dec 2024 12:27:25 +1000
Message-Id: <D6H0UY56F3H4.3UNWHAFASX6WO@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Thomas Huth" <thuth@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Daniel
 Henrique Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 1/4] tests/functional: Don't fail the whole test if a
 pre-cache fetch fails
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc 0.18.2
References: <20241220024617.1968556-1-npiggin@gmail.com>
 <20241220024617.1968556-2-npiggin@gmail.com> <Z2VJQJTjmzlgT2uU@redhat.com>
In-Reply-To: <Z2VJQJTjmzlgT2uU@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

On Fri Dec 20, 2024 at 8:38 PM AEST, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Dec 20, 2024 at 12:46:14PM +1000, Nicholas Piggin wrote:
> > If any pre-cache downloads fail, the entire functional test run
> > is failed.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  tests/functional/qemu_test/asset.py | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qem=
u_test/asset.py
> > index f126cd5863a..f82b07e7027 100644
> > --- a/tests/functional/qemu_test/asset.py
> > +++ b/tests/functional/qemu_test/asset.py
> > @@ -102,7 +102,8 @@ def fetch(self):
> >              return str(self.cache_file)
> > =20
> >          if os.environ.get("QEMU_TEST_NO_DOWNLOAD", False):
> > -            raise Exception("Asset cache is invalid and downloads disa=
bled")
> > +            raise Exception("Failed to fetch asset %s, not found in ca=
che "
> > +                            "and downloads are disabled", self.url)
> > =20
> >          self.log.info("Downloading %s to %s...", self.url, self.cache_=
file)
> >          tmp_cache_file =3D self.cache_file.with_suffix(".download")
> > @@ -162,7 +163,13 @@ def precache_test(test):
> >          for name, asset in vars(test.__class__).items():
> >              if name.startswith("ASSET_") and type(asset) =3D=3D Asset:
> >                  log.info("Attempting to cache '%s'" % asset)
> > -                asset.fetch()
> > +                try:
> > +                    asset.fetch()
> > +                except:
> > +                    # Asset pre-cache should not be fatal. An error is=
 printed
> > +                    # and the test itself will fail if it is unable to=
 get the
> > +                    # assert.
> > +                    pass
> >          log.removeHandler(handler)
> > =20
> >      def precache_suite(suite):
>
> Asset fetching errors & skipping tests is being handled by a pending
> pull request:
>
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg04334.html
>   https://lists.nongnu.org/archive/html/qemu-devel/2024-12/msg04333.html

Oh thanks, it's merged now I should have looked more carefully. That
looks good thank you.

Thanks,
Nick

