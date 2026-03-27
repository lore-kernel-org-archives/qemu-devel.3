Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29C510BA42B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 05:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w607U-0007Kh-SR; Fri, 27 Mar 2026 01:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w607T-0007JY-6G
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 01:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w607R-0001A9-GF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 01:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774590748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LszN5P6jVn0H14bJVSy0s+bOfCq5WIq8Jn96jKLaWl4=;
 b=DEYXPLbTDUDTjfOSYhqsO0Vm+0112ZKNJ+CuIZRb+B5nyP9o0ZbWBBWMZi1XcH2QOH72dK
 lwxRc+o9A4wNlDwL7I7qSNx+E3i7X9fa/bsOYP+Izol4JRWo93bmYPNWl+WawemlyZVWlp
 gtr1T0hxkyTadLWrF8E6CigEfLI2Geo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-V-QD601HOK-w09rWcCWExg-1; Fri, 27 Mar 2026 01:52:26 -0400
X-MC-Unique: V-QD601HOK-w09rWcCWExg-1
X-Mimecast-MFC-AGG-ID: V-QD601HOK-w09rWcCWExg_1774590745
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48534941525so22700655e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 22:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774590745; cv=none;
 d=google.com; s=arc-20240605;
 b=A1YiyQEdXJ+dXC8XfC6h8WyEPULD/RL8/b726HAd1+4kMp0dHMUd+f5QR+T+EjTMkS
 7BflJ0v5pmz7zeHfknjMaMumwSZ6xCL6DWp5cXpO+v/J2IIpPk4ejBDNq8gJi1XVujVh
 brg/m19w7oi2tIVkA9iIrFQiKf63NmGq4VdlWFhn39Wp22kJACdBCJ279Yb8YTgPmDbd
 /s1jb71fg9Z5lKBvWXP4nX8CVFIDwsUpBP/HMNYdtrD3qI3ufUcZv+BF3m1+HlQgPXJW
 wYp6tAy67kRX6nkPWGEf0CdSg1gkFHiufKAS365Ixtkxt0z3tUYGL3zW0zW9jvGAp/de
 ZN5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LszN5P6jVn0H14bJVSy0s+bOfCq5WIq8Jn96jKLaWl4=;
 fh=PTo7vYI/fvT8S7TY8mDfPmnWLdN1TQnbbWvDzdrLGGI=;
 b=Za+z2jhbYdtRlqdPpjBZswwITHx7z/Gz83LACQytHndnQoXziAwIVW22YlL/DbaLxC
 DAiXeDA5ZI7R/g4d/VIEFVz8S7YoyZKj+wJntGef0mgJ7m3Ah7hrpX37R3UztDDdCO8B
 ZHnllZDtRpw+m/zJUkpd4aupqaNnKwTh9jBFhleXQ9gYFAXzriUGI8klZQ7UEjSK09og
 C2bFWj3ude0EKH/EYV3MbvBeltlA99YkBAPywmsPWi1evn+hTbhUkUFn+exjNKj/SM3p
 qecaVFCa89GXwI20vSBMq4441Nia5fl0YD5V6dZLFFNX1n8k/MwdtlYKfTX1D6386sKm
 KDIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774590745; x=1775195545; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LszN5P6jVn0H14bJVSy0s+bOfCq5WIq8Jn96jKLaWl4=;
 b=ZrFw1NpxgHm+out8weuzvIHyUB9T2xKqSPH+urpxpiBVLIMrEDLynkh2pj+1RChXBr
 uSfwLTK84WZm9Vt05LQffuryXww4rQWU1KWWq2RgnaaNZOYKVlQ8Gt0LI1fZpLqQ5Q/E
 Zyor1cQFHap02EPHoRa5Psua1G7uTEqID/tP3sc6iUYu275fMRuoBjGLC1kZP0JzaP8G
 wDVAKYkjBYlC+E9K0rUNlNlTNw9vVhDotiRrqLbCkR26teBldPowtLzCw331YaKmMGg2
 BEr5pYkbAg9jpbRjrHANjibsmiFhy6DB7Foa31J+sNR1Drr2Ph6fdIErZVE8tCf8BOWw
 TZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774590745; x=1775195545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LszN5P6jVn0H14bJVSy0s+bOfCq5WIq8Jn96jKLaWl4=;
 b=ROsjb22dPxowpS4vfJ5KpMHonjW0Fz9jx5KyWf19MYIU1I1dh/22Sy2UZu8lvHuKn8
 XiZNolPxjQjkHcDPkusIPftzVFx77w4Dq6sn1v1YbDaU7C9aVLUmda1ooaMbkk5fPPdp
 rJy+Q+mfLFkq4WPd6hep+IdUtU22CSt+yQy3gny4XA3WMpzt2wsawL5KlZwkMgS1O7+v
 doTyuxkRNZrW8JrCyqcwBVj5ds2QfHmro7QKIAWLkWtmU/f1RfGGikG6tuewTuzxaIbO
 IHMDepSkPd+WL+vAox/ZYKKybRFRzMA22Ko4KtvTh6zR6F34GV1ikfo3VGBBq8g3VvPs
 1XFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeFxQAw0Ec0QYnhu2xfaX/kGOUmI3kGr2d+onOkg3wvtauFRLuZT8kc3ntinlaTcldjqp59uCdsNpz@nongnu.org
X-Gm-Message-State: AOJu0YwypShEH9gPuSqdR3wkpw4XpOQBCfAa8lpEVvKkPl1jTzfoKr6E
 xLzEre9T8KlBvTeIm9uNEPf2QqMznWhd24g1dkFHCTUR/BMK9Wrm1o7krEW6xZx8uHe//db/x/m
 0UXgrEpGgn9Brpded2THRVUnicS6Noh0TRDQ7KcfmMyvMcGo0CwT4vUL0nTMCG5OrbX1TftFq3t
 AiDASdiSXXAp6Qb2jilUaIhE6ttMPTZKE=
X-Gm-Gg: ATEYQzxLEDe9phaMC6qlehhbOpAXEq6Tc0GB2E+raHNi17CQZ9s6ZSUNfLFDeE6Y37y
 8a/1sqXkz7kIpHNIlIk3UUx3nphkQNQ6HClo9xzlqS4Fr/xSAPai+mDDdp+bKiRDEcDDUwXT2IY
 oOEzv6pOBzcXP/xH99tz4PPN/CtWLYU+/ijyd+wXNQVAq8ojh3s7fkWapQ488Nnw44NqhdWM6Z6
 gw2hGmF31oRJm2CsD2Ks5T9dHG5SysW+EjaUG8I9klRsLJ4wuTmKcAeItsXsFHIPdi5VyAlDom8
 bR3y
X-Received: by 2002:a05:600c:c086:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-48727d6aec6mr12953825e9.5.1774590744566; 
 Thu, 26 Mar 2026 22:52:24 -0700 (PDT)
X-Received: by 2002:a05:600c:c086:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-48727d6aec6mr12953615e9.5.1774590744147; Thu, 26 Mar 2026
 22:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-2-kkostiuk@redhat.com>
 <CAFEAcA_QcibXPCDpYPNTeO6RAZPaSAkFKMTnd8Uf0rK-FKLnQg@mail.gmail.com>
In-Reply-To: <CAFEAcA_QcibXPCDpYPNTeO6RAZPaSAkFKMTnd8Uf0rK-FKLnQg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Mar 2026 06:52:12 +0100
X-Gm-Features: AQROBzA7_dHwfuvVmV4vIjbH_hb7j_nljgMaaUaH8kXD2srBTkN0gzgncaRN2qk
Message-ID: <CABgObfZ80KXeHUcpVrwjg0R66uZ-GjHwF2LguMkVpfegV+ce_A@mail.gmail.com>
Subject: Re: [PATCH 1/7] meson: Use stddef.h instead of unistd.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ed4f60064dfb1a7b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000ed4f60064dfb1a7b
Content-Type: text/plain; charset="UTF-8"

Il gio 26 mar 2026, 17:34 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> POSIX says stddef.h provides size_t, which is the only thing
> we care about here. (But it also says that unistd.h provides
> it, so your platform is broken.)
>

It's not POSIX to begin with. :) There are other small differences between
MSVC and Mingw runtimes but the main one is exactly that it doesn't have
unistd.h at all.

Having taken a peek at the full set of changes needed to build qemu-ga with
MSVC runtime, most of them are cleanups like these ones that (review
comments aside) make sense on their own anyway. In some cases... a bit less.

Paolo

This is the kind of detail that should be in the commit message:
> you need to explain why it is OK to make the change and why
> the previous code is wrong.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>
>

--000000000000ed4f60064dfb1a7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 26 mar 2026, 17:34 Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">POSIX says stddef.h provides size_t, which is the only thing<br>
we care about here. (But it also says that unistd.h provides<br>
it, so your platform is broken.)<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">It&#39;s not POSIX to begin with. :) There =
are other small differences between MSVC and Mingw runtimes but the main on=
e is exactly that it doesn&#39;t have unistd.h at all.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Having taken a peek at the full set of chang=
es needed to build qemu-ga with MSVC runtime, most of them are cleanups lik=
e these ones that (review comments aside) make sense on their own anyway. I=
n some cases... a bit less.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"=
gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
This is the kind of detail that should be in the commit message:<br>
you need to explain why it is OK to make the change and why<br>
the previous code is wrong.<br>
<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000ed4f60064dfb1a7b--


