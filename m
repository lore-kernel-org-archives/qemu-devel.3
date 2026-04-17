Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6309F436A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 13:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDjbv-00029i-2g; Fri, 17 Apr 2026 09:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDjbt-00029Z-8H
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:51:53 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDjbr-0003Uo-BN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 09:51:53 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-652fcd5a6d7so900045d50.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 06:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776433910; cv=none;
 d=google.com; s=arc-20240605;
 b=VM56juJUrs08iSQAgRwFMeKFEJBx6pzaCUIsxAZjzxwSMUoLHoo4WNUTswkr6HmvLp
 lsB6qtwbs1ZzBnpAd5gPE7IiMi7SzQME/6eDgp3I0qyRyNvPbr3ffKH2wD6Qp2FzCuiD
 Dm2i5nqI/jp7AQAK+B3/RIpiiJaZdujbDvWbGzDfRC+RL2u0Mh6xgHUN+F/vmJ94a3vP
 d/ftQbT+Bgfzh4ny3T8OxdDmQEAK7LyOb7xxpFakJIqRFFyx5gpUjUATFw7FL+SNT8kl
 QmJ2XmNpsqPNr6Y6jav0yQTZLhoy4Z6xIBRIXwM7ke77C09jweEEmArPmguEJmZZDpix
 IH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UGzMdPmooc4crl711aDL3SR1pBew9RJ50/omtb+hpzY=;
 fh=L0+NiO1dk2svgH8TdO1hLVvvgiN+SVSZdG3CsBcLNBc=;
 b=T34Kr8NShBfn9wkvIoZoAUF+DhbDz1129oB3DgoWnAPQ5sKEFoX+3xWTVjsosH0/xl
 35VDPpR/8gnQXzHGut4PM4PsjGxuBH+pHDryigAIhItSRYryO0D3+qBipxX19zSm6ZUD
 QP1HI0G/LBrqmAU4S4ZG9d2/laXsOEaHb0bc1Oh8xCzmAhIB6dIMYj6WatrrZCYGucge
 SnRbP3IiPgz60BtRPOS3lL/T06iq3Jw/RzKpoc6qDb4cFIRs2cbG4XYKgiIna1pTnQbV
 XBNPD56Yy1lInKnyLYymyfhuUFyUwDsnYvKNsmDxs2XuUOUV9xr8gGhPSGGeSaiT/aF9
 Maxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776433910; x=1777038710; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGzMdPmooc4crl711aDL3SR1pBew9RJ50/omtb+hpzY=;
 b=jaCFdPn+GkmXV1qko9iR1tK9/xTEBCb6HP5rSuo0ZPwy6hHWYJUEDd/bV3uw2kIuZZ
 rh04xinOcFOdnf4cEIK3GgdHh2n7YMVqbI6/SOh7gXgHAWwAU8mYnlYO8kUPADeqDtcA
 TIKdQ33cUImoOOZnIjhOIuSfo9MX6ao6MmMqXCUZgKYfyJwFBYXifxN3lAB754ffy/dV
 lcoGTt6vWSv3OOTND6yvOaPOLgxh4z4xnkBHe7+7vMSnbv+xyE/NlVDHyVPIYQeaumue
 0HXTgwbUdgzexhvNbTOWlvtQ9p0Bzuh+R0zRTso24GmzUCfGW1PyDFt+hpp2zSGhjox9
 UafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776433910; x=1777038710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UGzMdPmooc4crl711aDL3SR1pBew9RJ50/omtb+hpzY=;
 b=a/X38F1CKkP54L7pZY189o6VKM/7o3f3lGh5qEf59n8Paf1E6qIfKz92agNgOLmgcZ
 UKtGaYbybx3+PeofEnpITEaq/iD85cvlOq0/wIMfwMFpDS4og+dqENpoHxlB2Agq/UEx
 CEsb8rQZHrK0Nbe9WbAj2saABXANe8QUeMrDWDDOhxCT8+vwLRKEHUHPuS0BwFsGQT8d
 O5lIdPGKpRzfXwv3L4zDaROjMrjIMouxNKjY6Bqpxue/NICmW5iQcp7EZqk/BIbNa6OE
 CPFZjLAsl+rgyQZQegQSJCmHRNJ4LaZmlG1o5ePYa8qlkiVaBhHrTvB42Dbu0z1iXDl2
 0zNg==
X-Gm-Message-State: AOJu0YylOH0bOnajqfdY0zuj82XkesO8V/CEiwbS+5NfblZ5KUGOyta0
 uJCRq9bzqWXBwBiEtLP4/sdAzcFyotNFwFi53l+3VI8r2BbOnu4MQ6P9o8sgluVGVValHqCAolf
 aVJG7FRPyHBlxCr+No/j1XaWKR2LLqSVwhZEeuP3ljQ==
X-Gm-Gg: AeBDiet2M/fxhP0gnYJ0+X6Eg2Qad/TbujkTndGESePW5wp4CEIeRMDLyCORdbwImRe
 itFFAeVkTpvfghUEMcGWG5MH+w2dMC5CnNueAAF/aC9LA7GbuJyJWLlWxcwE1LYqY+fundWIZFj
 +VckoDAVuSSirODJWxHWMOHMVZT1W68gBSctk80JuNt0JJRuO9m8t+iLGGBpgiCXalznvJkH5GB
 DGjqis8nrrVJRSAeGjfvFE0EwFFZs9IlLEzePXvIqQWcWpcfWs36T6NyYFki5O50RVoLj97uVlx
 e3D0FG/qrX4cfftujeVjE1aOBvBuC92fpfdahDuwMksgEDb2YNhj5ohLXRsFzKk23Yt8NHjROGp
 wBQ==
X-Received: by 2002:a05:690e:d49:b0:651:8944:c0de with SMTP id
 956f58d0204a3-65310b9478dmr2401511d50.63.1776433909618; Fri, 17 Apr 2026
 06:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
 <20251109134141.ur2s3bk5e6dgquxv@pali>
In-Reply-To: <20251109134141.ur2s3bk5e6dgquxv@pali>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2026 14:51:38 +0100
X-Gm-Features: AQROBzARdogvX8285Q7m7vaG2qTvoLetPol_Jt1gBg5kpKZUtRFgjle9tpQ_V0k
Message-ID: <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowang@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Sun, 9 Nov 2025 at 13:42, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Any comments?
>
> On Sunday 10 August 2025 15:09:48 Pali Roh=C3=A1r wrote:
> > +cc slirp & network maintainers
> >
> > On Saturday 02 August 2025 13:05:49 Pali Roh=C3=A1r wrote:
> > > Add #PRE and #NOFNR flags to LMHOSTS example line.
> > > Include information about LMHOSTS path on Windows 3.x.
> > >
> > > Windows NT 3.1 requires #NOFNR flag for successful hostname resolving=
 as
> > > described in MS article Q103765 because qemu/smbd does not respond to
> > > netbios name verification queries. #PRE is suggested in that article =
too
> > > and decrease delay on Windows 3.x for the first connection.
> > >
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > ---
> > >  qemu-options.hx | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index ab23f14d2178..d5654756f125 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -3307,10 +3307,10 @@ SRST
> > >
> > >          ::
> > >
> > > -            10.0.2.4 smbserver
> > > +            10.0.2.4 smbserver #PRE #NOFNR
> > >
> > > -        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for window=
s
> > > -        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
> > > +        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for Window=
s
> > > +        3x/9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Wind=
ows
> > >          NT/2000).
> > >
> > >          Then ``dir`` can be accessed in ``\\smbserver\qemu``.

Apologies for this not having been picked up earlier. The problem (as I
mentioned in our IRC conversation) I think is the lack of anybody who knows
anything about SMB or old Windows versions who felt competent to review it.
But since nobody has, and as you say you've tested it with this, I guess
we should take it.

My only concern is whether the "#PRE #NOFNR" advice is still valid
for newer Windows versions, or whether it really is only something that
NT 3.1 and Windows 3x needed. In particular this more recent LMHOSTS
documentation from MS:
https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-nbte/01f85=
bfc-cfa3-4be0-b659-4ca0eddb5996
includes #PRE in its list of LMHOSTS known keywords, but not #NOFNR.

I think also we could probably helpfully explain what those two tags do,
something like:

   (The #PRE tag tells Windows to pre-cache the mapping to speed up initial
   connection. The #NOFNR tag tells Windows not to attempt to send QEMU
   Name Queries, because QEMU doesn't understand them.)

Then anybody who finds they need to adapt this to some other version
of Windows will have a better idea whether they can just drop them
or what they might need to change them to.

thanks
-- PMM

