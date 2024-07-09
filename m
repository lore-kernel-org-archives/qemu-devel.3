Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306E3C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9em-0002it-BM; Tue, 09 Jul 2024 08:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sR9ek-0002aX-2X
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:09:14 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sR9eg-0001Vc-J0
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:09:12 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-58c947a6692so6264927a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720526949; x=1721131749; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Bq5n00imy9rQIePz4fJTbXX2aNjXlQDi1uni+2ghOk=;
 b=yc4l3IKWneiPYcMx/tWpA4JTlb20QrNuk1t6ly64mBH6kUjmvaiA9u7CsROqZdIMOj
 Dvc2Rm7iTMRUZ1qUTpVW0AohsVs2+P1cy26EX8qowtmvJA4O0qF7FDubnGiTVKzc/VDh
 TG0w/B9/H7pYLEv7Ci7QgKCwDkys0p/kfUA94Agn/GP/2cHh3uF0AcA7HkeurXmwpssX
 8UajImB1W7ruQyOxBgStwjU79963pcQzgLgyySj0lHZJDUBVyFUIe7H2XP7THkdX8kfG
 B4bcOlaky+YSM62G6ynPGP5p7InwQrBSU1YwzVUiuXLA9h9HgR/jdrBmpuBYd3xkmrns
 GqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720526949; x=1721131749;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Bq5n00imy9rQIePz4fJTbXX2aNjXlQDi1uni+2ghOk=;
 b=Nqhh37mbNIXfyXWXJcmGvnRmvlR0ec9s7o0fCMU+Ku1D08UlZyt8gXX39fAGdvnxF9
 HJhuOPdMIXe2XTAvahgV8T6Nv34W0hft8J1r2Owi4HJH0DqEk+fjCUQPVCSwnFE+l1zw
 /qZykqHXgdEYH6/hHBbLszSSolBFzYJeGAkEniUK+V34IXOYLnpGPUn+QNsOVyIKaJ9H
 VQoxNsWzx0KjeoHLgvshJEIcOLknQPWqn2hl9ztOib64lX4hKpE2zND8MFG5LawT55+V
 bYzQDoQMVh9oDgShHvoQXCjUG5khBJ8+kfiaAHWlcn3gbuMVa88SYzvTTN+Q7jeUobK3
 kU6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVoAeVH3pbVSdD7LCMszeqUrvsbz/mWxLwSrDo9v/duexYjtx9wRb0cxF9Sf02RXM9ukx9Yj3Lxb2FYA79VJSgqjT6WeY=
X-Gm-Message-State: AOJu0YzclyWMkCI0zxbsTZcyhtlB3aU9VfoEWnIV++KBBvVXlHnR8A/K
 KSERso3zhtnkNQWGCEGyopVDr8vreSoey9VVfeZKnJM6Ha7f8c1PQJzQ1iUCGryXiTARQGQnjqc
 g8ZWKsrH75E2dwwHSQjKURwH4Ue8fJLrgpS/5fQ==
X-Google-Smtp-Source: AGHT+IEtXz3cJitTuHnCXkuiq/aPaAGE54sUrON3/9GuzUdw37cV3jB/IkdpNZrbAA9+UG37Urm/WJVrdGl8EI6x9F4=
X-Received: by 2002:aa7:d717:0:b0:58c:8c06:74c8 with SMTP id
 4fb4d7f45d1cf-594bb869e18mr1404038a12.33.1720526948580; Tue, 09 Jul 2024
 05:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <4ce5a7330f594c6c94c8cc3aabceb061095bb855.1720094395.git.manos.pitsidianakis@linaro.org>
 <87msmqsunu.fsf@draig.linaro.org>
In-Reply-To: <87msmqsunu.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2024 13:08:57 +0100
Message-ID: <CAFEAcA9X0564R7V=EsN2qxj51FNNkot3Pfev6mMgUbr35WYFZw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] rust: add bindgen step as a meson dependency
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 9 Jul 2024 at 11:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> > +msrv =3D {
> > +  'rustc': '1.77.2',
> > +  'cargo': '1.77.2',
> > +  'bindgen': '0.69.4',
> > +}
>
> This is still pretty bleeding edge (it even tripped up on the
> .cargo/bin/cargo I have installed). This needs to be set to the
> baseline which from:
>
>   https://wiki.qemu.org/RustInQemu/2022
>
> Looks to be 1.24.0 for rustc and I guess even lower for cargo (Debian
> says 0.66.0). While it might make sense to delay merging if we are
> waiting for one distro to produce a new LTS we shouldn't be needing
> rustup by default.

I suspect that some of the older distro releases in that chart
have already fallen off the end of our supported-platforms set,
so the minimum is probably newer than 1.24.0 now.

My take on this one is that (at some point, not necessarily
right now) we want to look at:

 * what is the actual baseline requirement? We definitely want
   to support "using rustup on an older system" (should be no
   problem) and "current distro building QEMU using the distro's
   rust", I assume. It would certainly be nice to have "building
   QEMU on the older-but-still-in-our-support-list distro releases
   with that distro's rust", but this probably implies not just
   a minimum rust version but also a limited set of crates.
   I think (but forget the details) that some of what we've done
   with Python where we accept that the older-but-still-supported
   distro will end up taking the "download at build time" path
   in the build system might apply also for Rust.
 * what, on the Rust side, is the version requirement? Presumably
   there's some features that are pretty much "we really need
   this and can't do without it" and some which are "this would
   be pretty awkward not to have but if we have to we can implement
   some kind of fallback/alternative with a TODO note to come
   back and clean up when our baseline moves forwards".

At that point we have more information to figure out what
if any tradeoff we want to make.

thanks
-- PMM

