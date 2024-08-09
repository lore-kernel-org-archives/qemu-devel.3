Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11705C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 19:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scVII-00070l-3f; Fri, 09 Aug 2024 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1scVIG-0006xI-KW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 15:28:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tavip@google.com>) id 1scVID-00011Z-Va
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 15:28:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-368712acb8dso1390423f8f.2
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723231731; x=1723836531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfqI07Mq5XGJm324B949qGeZKcnG6wqL+yz7+BuRvb0=;
 b=K9/Am/fChBYtjpicF9QwAQMnEIhzTAPCv+5B1HoBbhQA4ffKfvFgqF79klSGonRQbx
 vxSpsT6wwVb1NEo1oBn+KJknw2aZF/A0hwDyN9C4xIsqdbvSFvIfD1QJpnWcJTpGDEUN
 L6BsDMdyzTdz4OLvKBwC9Z/r92ZSAHwZoLXUpDezhmUSAJzrOkGwQCVq4tmpbdO6UmdZ
 6yISK07K2IO66hm1wcdzxsUqR5XTNy3vsFeGFuWF6vlVZ+Uytc5Dh1MRZOywijhJCFdr
 HiFYHVIEkdPLPT6mTCRIdVv8lhOUWw1x9L73JeCqSIMOcp1tjVkEDuiNNInM4aKHTq5a
 mr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723231731; x=1723836531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfqI07Mq5XGJm324B949qGeZKcnG6wqL+yz7+BuRvb0=;
 b=fwHvg5pKnwMZu5+V/7V1kHVCxNxPdIy6Pc2kWFPs8gSStcEe6qPI5oPHV5PlHMTex6
 8bOPlJyCwlR/qejwnIgZ0+V9wD9gxvnO/6WYPc2Yu/OPv5pt/clsLTg6E7KA11g2RkkF
 7TRwG51OS9L6ErFbNuMp5nk72LiGK2TfhFkrEHPBpsukjDZyHiilP5SEdQO5K1tJ3yZ7
 NIudExXAekDT2oSx/egZgtpvRMYU9tZlr7JlL2pzY8JwhGZjeVpJaYqoTXEhJ8LO25JE
 PeFU8URoOzikOVE7ZkY1rEtyS862mTapKyA+3i/Cc1wlFdljGKlE/VWJoG55EczM+7V/
 E+vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4KIGOXF14n3S227yIQQ8WpW4oeckKUFxGGBLTp3cO9OhG/0XVFOtQNAmo9h5Isdyt+BvC2GZoJMvVFpe+3mvbw9ur0z4=
X-Gm-Message-State: AOJu0YzTTgTOLfBkXJoWFkFrmxT2kRTPVBCCxn6p8cMVCqGmjdUfTxhA
 uZ8cSKRK8Q/SWcwRIh1VKfxKptCfvzjFHoJKJBBKwV1pV6G/ERg40seOEy2cnvfNHLv/v6aj/by
 WErC9KzfhCUrnPVNQ1y/0I4tthC4vT1duhYk3
X-Google-Smtp-Source: AGHT+IGw6E/Puw/l6sN8kmtdImn36GWYnoUi1j8CyNpJvJwjGTwHh6vnHHHz5g0qbwsHnfNDui5LAE3BSjkFNBnZ11s=
X-Received: by 2002:a05:6000:b02:b0:367:89b0:f58a with SMTP id
 ffacd0b85a97d-36d6053e7e8mr1629737f8f.58.1723231730731; Fri, 09 Aug 2024
 12:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
 <20240805201719.2345596-4-tavip@google.com>
 <CAFn=p-abeXP+dUtp_gwH3dcD5DT-sTAFg=udVugrzcU1r8fXpA@mail.gmail.com>
 <96cc6b27-751c-4420-b661-871a09aaf316@redhat.com>
In-Reply-To: <96cc6b27-751c-4420-b661-871a09aaf316@redhat.com>
From: Octavian Purdila <tavip@google.com>
Date: Fri, 9 Aug 2024 12:28:39 -0700
Message-ID: <CAGWr4cThLpkCA-hC2gf_cViX5dRGe7F-KFcFGepHsYZf0QVuOg@mail.gmail.com>
Subject: Re: [RFC PATCH 03/23] scripts: add script to generate C header files
 from SVD XML files
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 stefanst@google.com, alex.bennee@linaro.org, thuth@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, alistair@alistair23.me, 
 berrange@redhat.com, philmd@linaro.org, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=tavip@google.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 8, 2024 at 11:34=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 8/8/24 23:56, John Snow wrote:
> > I haven't read the rest of this series; I'm chiming in solely from the
> > build/python maintainer angle. Do we *always* need pysvd, no matter how
> > QEMU was configured? Adding it to the meson line here is a very big ham=
mer.
>
> In general I'd agree, though for a 7.5 kB package with no other
> dependencies I'm willing to make an exception.
>
> The alternative would be pretty complex:
>
> - check if pysvd is installed in the host
>
> - check if a machine type that needs pysvd is enabled, defaulting to y
> or n depending on the previous step and --enable-download
>
> - use that to decide between doing nothing, installing pysvd or erroring =
out
>
> - pass the availability of pysvd to Kconfig
>
> - use that to make the final determination on whether to enable those
> machine types that use pysvd
>
> This is quite obviously overengineered compared to the alternative.
>
> Another possibility is to ship the generated file, skip regeneration if
> pysvd is not installed (on the host), and not touch pythondeps.toml at
> all.  Whether shipping a generated file is acceptable should be decided
> by Peter as ARM maintainer, personally I would go the way that Octavian
> is going already and I'm mentioning the rest only for completeness and
> education.
>
> However...
>
> > We also need to provide a way for pysvd to be available offline; some
> > packages are available via distro libs and if this package is available
> > for every distro we officially support, that's sufficient (but requires
> > updates to our various docker and VM test configuration files to add th=
e
> > new dependency). Otherwise, like we do for meson, we need to vendor the
> > wheel in the tree so offline tarball builds will continue to work.
> >
> > It looks like pysvd is a pure python package with no dependencies, so i=
t
> > should be OK to vendor it in qemu.git/python/wheels/ - look at
> > qemu.git/python/scripts/vendor.py and consider updating and running thi=
s
> > script.
>
> ... this is indeed correct.  It's not hard and it helps building on
> older distros.  Future versions of Debian or Fedora might package pysvd,
> but right now it's not included anywhere
> (https://repology.org/project/python:pysvd/history).
>
> > That said, you might be the first person I've seen outside of Paolo and
> > I to brave mucking around with the python build venv. You deserve a
> > bravery sticker :)
>
> It's not that bad, come on. :)  But yeah, I'm positively surprised by
> the effort to include pysvd in the virtual environment, and any
> suggestions to improve the documentation and discoverability of the venv
> setup are welcome.  I'm curious whether you figured it out yourself or
> found https://www.qemu.org/docs/master/devel/build-system.html.
>

A combination of reading the docs above and looking at how things are
done for other packages (meson, sphinx). It really was
straightforward.

> One thing I heard from others is that pythondeps.toml looks "too much
> like" a fringe standard Python feature that no one has heard about.  In
> some sense that's a great compliment, but I can see how it can be a bit
> disconcerting.
>

Now that you mentioned it I can see how people might think that :) But
the build system docs are pretty clear IMO.

