Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0116CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 12:04:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEVR-0004R2-4h; Tue, 05 May 2026 08:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKEVP-0004Qr-HW
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:04:03 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKEVN-0006Ue-PA
 for qemu-devel@nongnu.org; Tue, 05 May 2026 08:04:03 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-651bc83e74aso4529039d50.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 05:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777982640; cv=none;
 d=google.com; s=arc-20240605;
 b=eAXQz7FopJgewt8VHhP1b7OTulwbgUKCO6oJnOq70q0xU2ojNto83D2Yq0/hhT3a3U
 UCEG1HpVQwMvDF21P6+HBuuLpu02WBzWS5PRPWtaQ4kb3WWP3KucLkdvtHi9AhFk/GVQ
 iguZBYE/jjYP8/t4vjD5nY8q3PwwCcoGKBkdMVZgK6T+CeJCk5IIHts0ltGSPnu15gJE
 LsYRFOn2vbfOjWYbPji9kR20o4GZxaQi+Vrt0OSx3QEE59isanx2g5benFRDcztjXtUC
 QgBnDpw/ldtdBu6scey66LrTlEOfWyFubJA6v8NKy2icAh4Dmm924JaUjDPj6L+8NnBx
 8YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QrGEKfVpRmzresmJVy4+pkzdvR+wIkSwhjy32Z36cJU=;
 fh=5Wv4duMH+rgimKaOVxwvVVg74khZ6ldBwL5uRPFajh8=;
 b=fPkUQ/J3Zj0tjLaRivzUihvWUovKyS0KEb/EJz8v0yTIO+uPcHH0zczsQCO5ri305R
 RB1U87FcWTqmgxv839gsrX2GGRYbkOMYs9bssBoy3Mv1Qhh82y+lxGMx/E+mUkZ9H9or
 lnEcsbg6ih9P+rZnTWTMEz2WqWZqpODYOMozNAgf4cylJ//MxNf6V7lCfJa3V4zayw0Y
 qmhL/IvrRiDqx5fS2Kw0e0iAxQmB64H3As9w7D4V0kk4OaLJzGOquuruvNpb60TIeIHQ
 1hX4wuQSGonguf5XOHhDEbT9KJqEqZt9byScoSshOcLTbvWub32xRHtEMtUDAp0CYOvU
 Lp6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777982640; x=1778587440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrGEKfVpRmzresmJVy4+pkzdvR+wIkSwhjy32Z36cJU=;
 b=uSFakWNnEdQfnXc+/0q+tGZz3PgCu5AC6T6yBAfPcgHjDpgD/LcvYsfl2vou/uAqzr
 552j0SYU7U9uzXmdPdO3+qJNOrW9K5O9c6jS0p69UExM2sx0i3FGbQ1aoeFUpWsC6UBt
 q8wFzjP77VcmOq2KeKPu4s9kq6Jm7k4RF9VnUkYUABHdIyYJVbAa7Ncfyv+sm1jK4W6G
 bYWiVR4mrW5WQ9MSAbGjyn+5j3pqLaFC2lPIPfXpb7f8ECXFrULTv4Bmt0NV4Bl/1i7P
 qGN8e5rJ40Efa/fX2/fVbLpptyAZj+zlZQAgzQAbvT9VobkqftV7uFd1g7Tcb/RHUN5F
 LjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777982640; x=1778587440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QrGEKfVpRmzresmJVy4+pkzdvR+wIkSwhjy32Z36cJU=;
 b=p5DYNooVy0Dgh1otWeyq3k0IXJnzAWdIHZ80R1l7fa5TtnqEUQqHuZkDwuh08bWQgY
 o5R9r9KbZkAMB3097YkJpM7hpimS+ZFh7pXL4yK9fGGUv5cUk4qs9Irajpq0kGNi7x+N
 tpBdQZeiRcJPk/2cyxJZeUWfiTvdI79bCvLSU+SeqJBtFVIH0md+7WHikTX/97jsgcAe
 kYx1+b5jiD94ZIqyXKrKvp/aMueg04X5c+sCPadMjGF+aylLOov4X7nmsj5J2net8nYX
 PSOrepGlC9bXsu9bWQ13oYbRpHS7ysB38Q6RR0vVTaRr+4ssLZ6MRqdTzhwQetKZxF+v
 GioA==
X-Gm-Message-State: AOJu0Yy9+pzCIlWtp83iCDAH5UwHhNHIAmr55y+uoKQT7243t2qpHkl2
 b9siWBFHj2lm4JKMkYMcUtVPLXuWYw0b4KJbmmjEHb/ZxPjI1XvM6zfp4ZVQ4OjInRzBOl7NY1E
 fKw1DRSY2PBcZRjjRpkgNMGESP2wtF11y+ukICS5O+g==
X-Gm-Gg: AeBDietURr9b8V+8xDU/ox6rWOTxI965Vgwal2xW3OVUqQ3V37CyZGZqRdUWDs48jbh
 XIeZUkDh96DzrZtaaAEQPz2I7Xx9mGrZDcBaa3XwUhXIAPGKOUA1Tw5g487PKImNDqkxUnrmRmp
 wUAK60mT4ORrdIV7qzsClv9s84kPJK80PcjnE1SeMcoCyfw/X80YvCaWlsD54qOT71XXi6DMoAL
 wneSD5jiLVI8nVYNro2pPX/wDfgHw9s3noBwI9SPsq4WHet6A/r9jd4gJ6aVfKiK4yd7aJB22TD
 3IZ7/jBvPnCWMuMfX6AkN77lusROMXLZLN/443BUBhbbbOZWzGihIHp12wpFFqUSfbTHixV9h+S
 LgQ==
X-Received: by 2002:a05:690e:43c7:b0:65c:468:7b6f with SMTP id
 956f58d0204a3-65c3da37c17mr9452600d50.25.1777982640401; Tue, 05 May 2026
 05:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-2-alex.bennee@linaro.org>
 <CAFEAcA-rFhHmS2+ToEZkr1+HE_e710-ZyyPESHLzCeW0QopY_A@mail.gmail.com>
 <87bjeunmth.fsf@draig.linaro.org>
In-Reply-To: <87bjeunmth.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 13:03:47 +0100
X-Gm-Features: AVHnY4IuCK5keaiByhhJOVrbHq3FzU5QtBRyYqah58nhqdA9D9RJ-Z6oVpqzwz0
Message-ID: <CAFEAcA_txOHPLK+J546yjCmOEv0-ptaVkCEk5GfeL13DdqQd-w@mail.gmail.com>
Subject: Re: [PATCH 1/5] configure: report unsigned qemu binaries for check-tcg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, 
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 5 May 2026 at 12:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 5 May 2026 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> >>
> >> On MacOS the initial binaries are created with the unsigned suffix.
> >> The user is expected to sign them before they can access the
> >> hypervisor APIs. However for TCG testing we can run the unsigned
> >> binaries so lets make sure the make variable is correctly set so we
> >> can run the TCG tests.
> >
> > We have a scripts/entitlement.sh, and this seems to have
> > at least some plumbing into meson.build. What stops us from
> > running this at build time so that macos users, like everybody
> > else, have a working "qemu-system-foo" in the build tree ?
> > Having to work around this by knowing that you have an
> > "-unsigned" suffix until install is awkward for our own
> > scripts and for humans.
>
> Hmm it gets built if you do:
>
>   =E2=9E=9C  make qemu-system-aarch64
>   [1/6] Generating qemu-version.h with a custom command (wrapped by meson=
 to capture output)
>
> and there seems to be logic in that refers to test_emulator =3D
> emulators['qemu-system-' + target_base] which ensures the other targets
> have it built. I'll see if there is a good place to hook that
> requirement in for check-tcg.

We should build it on just "make". Neither check-tcg nor the
user ought to have to do anything special here. This seems
like a bug in the meson.build file handling to me.

-- PMM

