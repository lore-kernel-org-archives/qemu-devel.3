Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B72CD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwmb-0004jN-To; Thu, 21 May 2026 02:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPwmW-0004h3-9l
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:21:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPwmT-0002al-ED
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:21:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso1340665e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 23:21:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779344476; cv=none;
 d=google.com; s=arc-20240605;
 b=MmuXmXsGO6JF8vWiSNaMo1ZK9Oa4Er5hsObYFDHYXeP9ciIas1nWB5PfPjh1Z6WjSJ
 aRvRvT/yY8evZihi2Ea12bUTkKWXXLpyXNWHOmuqt/Dzkdv18s/gWJ3MF4ur1GaMyxAa
 5vqVaNQbZmgwteLLoSEvF6pMIAbdIx+szkYtturo3e59RXm5P9r4cPX+hsgDojr26XRn
 bGeu6kHGxGCF4IXE9BgycQQhcptor+hixskbYeKCq5oxZjQaw9xKVHaq76sDk3pUynYS
 ixIUqcSwfQVDkUi6UDonE2zHcT62E2KZPFWMt01XW5+Wz54THdekEaQrWD+aL2+85XtH
 qWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MgTkSMnd5Q3egIFmHH53W7yxrwa7HB3QVHPiaJAXNuk=;
 fh=n6m6vbDeKKRuSV7rb0MDiXiou2CG/48BqC50vcP49pM=;
 b=aYNQ/H4GxT7fWTJixj8eA40hZEPfENij6NxteLgI72ocuVmNVjtXt1aZFmJvn/GdqT
 ckA4bRZgyGkdvUyXwKdfT4ek2ehHmwRuO6gP8LvGiSbeDgDz20WNmtGzvyP+t0AEP0ip
 x/zkIzfjDYn8MY03kea84VdeNC1kkRYDVtY0grifZW99rwYLNKgIqgtn2l+xZx37rQSN
 p8/35EjYeJyb5PkEkCTNnPGFpdu9tCc+OFbzP7C5V14eQP/eEL4q5xK3zs9h3m0vRj4L
 QxMO8/BRufx4E19iMQIonm5N17Q2xYfuu9YzOIr44eOfxTJiGRGdI8MqWJ2RAe9o57LV
 WAIQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779344476; x=1779949276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MgTkSMnd5Q3egIFmHH53W7yxrwa7HB3QVHPiaJAXNuk=;
 b=m+n2mETG7mBHVW0iOH1CiyrXOblDPLeAeyCg0Uco3P2tW96tmKfvzPmsDFfV8sDHdQ
 p1PxoviTE+XFD3ZfVfW0pmqX6Y99X5O/R06mUzRkEx5b+Ajqc1YsgTSrhWi7LNoyMqck
 yuhnk8+J6BIwvmtfA5DKnSHEjh4gLkw0jVIZlMOg/oTL4ek6u2Wars3IuWflIrY9Amk5
 4o/eDjn/cpyaKm0AMIF++F2KXKZp1KVy7XpOk7MAMWhAUgh9kyms2pJmi7yeFW+RVe+2
 CKyQ5I0GTz2w4duaujO1V0CItTBVxZiWf50e8F1HUEBF3FClDZN7Cb3pCfWgvQ/dLsnt
 qDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779344476; x=1779949276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MgTkSMnd5Q3egIFmHH53W7yxrwa7HB3QVHPiaJAXNuk=;
 b=SFlKjnEyJNlMGijKYbZXre/aJ0pRjWIhuYt9larvkZnh3wUXp+pSNBLaeoMKEfEPUL
 niZ1W6VbOhJqME4DDbT/Ktjf2QVPnd7ArngkytN5BpdIwJg3R6x/AsWvSMykITpM3CiP
 23QJJj/D+kIMVSsSDcxpYlvg6sPeM12/cf3DnaeDs8S5PT7vSpKSGEuLea43/J2kB4Mg
 /jzcUh898nIZWWz6lMorRDXyEgZotMBxyp0eKqy8ppelmVE/g+FIY29JmXypoaLvYP0y
 3to2DDI6nM9NWx4Rl3cTIZFOGzFaPe8SrnltAAuCc57Z8gkDxO9N5xMFuL8Np4XMu/QV
 zEGA==
X-Gm-Message-State: AOJu0YwhfXjHkW3y8RjaBGNjpGvUfxPvys6osdLCs5+E1OOQth08YFjw
 /T1Kb0fUGhayCZz2X22Uz31Xrxl4sdG2DKnoOvHT63mXuOIWeErwEszZaRRPBJjnhW//rgizA8D
 XnkFQd/E3slPT5pDValQhsYP3Nkar6dA62uc4bCCAzA==
X-Gm-Gg: Acq92OHY70feJVTe9aRQRcKtL29E2jX6e3JPqvlr/nnkXYUeN9c0VEPvH79cQwbtB3M
 85h1fiYenF7FUUZgEgkIC148YmXLftZf5+XJh8P8PMq8W0ntynXHpUWUSnhg7wLuK8lkLy7jKvM
 VEAbA5GDGEwLF+rYS7ftz1wImPinqzZYH4fm45jBWh8WGZyUpHAfI40wr2zTEE/Wk6k7KGS8z4Z
 M9T4VcFAvTaj9BaDwk1GDfe2D4DlDCU7wBqYv3XtQmUkvbRQ7krODloUaMBZ32+6GL4LiZhadDz
 6BYS9vpThOgII3rZbhgHO7fSstaJRs/382q+WTiSzxSM2ZhKQA==
X-Received: by 2002:a05:600c:6c8:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-490360c52e4mr10040985e9.29.1779344475549; Wed, 20 May 2026
 23:21:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260520195206.40679-1-philmd@linaro.org>
In-Reply-To: <20260520195206.40679-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 21 May 2026 09:20:49 +0300
X-Gm-Features: AVHnY4LH-UKy_R4cPxGO7_cFNpV8s_PaPMYrwSM7FQcUB9kfYiTlCPyAl176F9k
Message-ID: <CAAjaMXZMKbah6TrvSA2qy7ofp-eVyvuVxyOLo=-T+VaKcJc7Hw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Remove PhilMD redirect entries
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 20, 2026 at 10:52=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Our ./scripts/get_maintainer.pl uses git .mailmap as a fallback:
>
>   $ ./scripts/get_maintainer.pl -h
>   usage: ./scripts/get_maintainer.pl [options] patchfile
>          ./scripts/get_maintainer.pl [options] -f file|directory
>
>     --git-fallback =3D> use git when no exact MAINTAINERS pattern (defaul=
t: 1)
>     --git-since =3D> git history to use (default: 1-year-ago)
>     --mailmap =3D> use .mailmap file (default: 1)
>     ...
>
>   Default options:
>     [--email --nogit --git-fallback --m --r --n --l --multiline
>      --pattern-depth=3D0 --remove-duplicates --rolestats]
>
> (see the '--git-fallback' used as default option).
>
> Per gitmailmap(5) man page:
>
>   ... the file .mailmap [...] is used to map author and
>   committer names and email addresses to canonical real
>   names and email addresses.
>
> I added my entries in the "replace old addresses by a more recent
> one" section for this script use case, but we have been doing a
> good cleanup at having all files covered in MAINTAINERS, so with
> retrospective these entries aren't needed anymore (besides, using
> them retroactively credits all my contributions to the latest
> employer).
>


Hey Philippe,

As I posted here
https://lore.kernel.org/qemu-devel/3104a00e-4c13-4bf7-95a0-1f2840bec50d@lin=
aro.org/T/#t

> People who wish to use git log for employer attribution reasons must
> use --no-mailmap.

mailmap is for updating names/emails, not attribution. I do not think
your patch is necessary.

> Simply remove my mappings of that "old -> recent" section.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  .mailmap | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index ce569d83f4a..82ff20b8ddb 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -104,9 +104,6 @@ Paul Burton <paulburton@kernel.org> <paul.burton@mips=
.com>
>  Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>  Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>  Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
> -Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <f4bug@amsat.org>
> -Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@redhat.com>
> -Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@fungible.com>
>  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> <pierrick.bouvier@l=
inaro.org>
>  Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
>  Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@es=
t.tech>
> --
> 2.53.0
>
>

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

