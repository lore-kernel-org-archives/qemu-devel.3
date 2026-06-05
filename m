Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B807CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVU2I-00029v-4e; Fri, 05 Jun 2026 08:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVU2G-00029n-55
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 08:52:28 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.kanavin@gmail.com>)
 id 1wVU2E-0002Ia-4j
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 08:52:27 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-8ce9df4732cso18873846d6.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 05:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780663944; cv=none;
 d=google.com; s=arc-20240605;
 b=NEUmGL+aEILZBf+ia2mWFhCcdcbzG7SkBRphLibORKyDT7rQM8Dc+CPVxwCv6RPLsD
 5LO3EzJdU24E9U1rxN009HJzfwIxT9sIO2mwrEYJxtNtHWVp/kTRJGHcilk9Zh9Fm2Ok
 NHolOqddRY39zrJPXV6T4P2t1Zh+6wLZbQEHX62m0YWNh3Om1F81Ki/A3Voq0jp4Xbzs
 atY3SoWVHb4OhdDULzeD9DRoPGEzJmmLWE0hORCyIzFNg4tvamJJWOR23TWGWb0M95pn
 QzDnRAIglWoFRqgx56zqTqcDgSviqmw1P98GhEcJr72JT8wCG+04cB4fkkV+ZVDj5qsx
 g1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hfyUXaV8fYonHCF9sKR7nIyEL7TWseR6jZxI3At3V1w=;
 fh=7XtKzC3BYFAz1Xnzx0rsDKKQ1sq9jG/i5Ev2EG1TSqg=;
 b=j3w4NtVXh/2LWTzlH8jSX3flpT40uQs45nrTT/KPzK3mJdc5hMyIu1dkulFsSbN4rY
 hqpemkdGeullAPQyMey9sXqAhxntBEfspACljgDOCf6MvR/QciTMCbOUHSNKbTAMJ+b8
 ++byg7RomKToUTdaUeI/w/Lt2SApjjKmYFvpJg+6k9NwqqMBDD/SQSPTn7rHv9y0xvXd
 ls3KQYccWUAKdXShhIISttGWvapyMZKHrbE/tJXSyBxYDDIEQJMw2pe82WNr33WNTwUh
 e68RRlp4iF5I+VWu/5vFM/7djpx/dU1ENIXRO2G6WLXrMDCcvK8ZxLtyxCll0UgTV2Sf
 5e9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780663944; x=1781268744; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfyUXaV8fYonHCF9sKR7nIyEL7TWseR6jZxI3At3V1w=;
 b=cG3o9HPMM2K9NKN2m+FUZR2G6gLCSFJT1PPV0BJKzJBHudSAaOpWHuth4KHPwCcpwD
 LCulrUc/LgT39NNCr6/q896GGF3NpNTyQSpIWCZOT1nlVxRzI4+KWL6gveYEFqr/f3oK
 b06fSHAL/4Sewy+5ICYFq4BSph7+rIb5ev1mh+0QLiKlxu1ouuNWO94Rv1WwWaqTAICS
 akFow89pxyWpCMoufNLCN6EdDxIecuJ5a+RNb9BraMpfb0Vsd1HwwXugjowf+X2E7RSq
 6+kXjufCvAb/dFogqYUv7kGFCk5ssYgobNswGE83clFmDWc7gHVxqe6IF7semlqT+aSh
 Z4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780663944; x=1781268744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hfyUXaV8fYonHCF9sKR7nIyEL7TWseR6jZxI3At3V1w=;
 b=JkFsUCapkbtFdfR8C1OKfeIkWOYm90YGaqI6FtPKeecnCP1FhE0ZkkfAvdyTAThuYa
 Sf3+F8DnPqxAQ/PpSMN1rvAa+mHCC+lM0z4TZQ/mkMK99YP/WZGPXbJQ+boZ3rkpMavb
 MqVbgh6UDe7MzU+Pnz87jZxkqzIIC+GqRSrI8Wg3VB/F4LQubI0uQSiykb/z7/2l5bX5
 GdViQXiq1QmVuAcl3zxpPpHhqC9eqRlSGiuMq5U0B5TTMO/45M1Tv3z/bJbuCMtfafLb
 8PqXFRCHqNqrQZjl7j01HxaH1K4uyfGbxFN+PZPA0bWy5fWigdm/k//P/g8msvheDXrH
 b0uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OayQ82BHiIiRTOydFWtY+yowSNguwv+U7W4qYH6UP/jS1vwZdFruakkc/zxJzm7yjdi92ef09IKzx@nongnu.org
X-Gm-Message-State: AOJu0YwiKKu3a0FaHPKe3W50cItsmsM+tvM9g7yW1ePMkG5LTOR7JdZ4
 wlvyUMq4k0lpO9NBNsk6HoJSxQcuvkeFpxd7C/5UaYVQ3fGKLxAEmOa3MM8sQ2qjB5DJv+3mBTL
 P+/y6xmm93VWmGcpBparMUhtMtIj0ymI=
X-Gm-Gg: Acq92OHxI0XR1/oxbNqMDqgQxpFt9ruMJP2/28gAsywUeXdYi0XS/MlOHgEO5hFO/Lu
 V8xpkdmvRF6HR3xk1xqJ/kyw5IPZe/UVzixbSySkhgzNlmfAYDftEKXw3OBKHa0z/wvHoSDDdfE
 8yLdB/PaHrYawxru67tn2X/ujnEOS8DgBDF6K9eMK2q9SqeZgA8VwWaVLaFjTOt0Wf818fLmmNp
 X0q3G742j+4sMim8e8RAFl51+3YXdhaYhnJD/sh6D1CtCD8vN03D/zQvulwB7M/uf1XaRU76qqP
 kv+ALvnk/4oas/LybMMqCA1pLiYpdDEQR1Aj9y1kpzRxoezvBGXL
X-Received: by 2002:a05:6214:4904:b0:8ca:268b:13b2 with SMTP id
 6a1803df08f44-8cee61597a5mr60696296d6.32.1780663943782; Fri, 05 Jun 2026
 05:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com> <aiKEeH2UZgdePzjX@redhat.com>
In-Reply-To: <aiKEeH2UZgdePzjX@redhat.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 5 Jun 2026 14:52:12 +0200
X-Gm-Features: AVVi8CcR5KsWpI7uOyNhPpbQvEgUZiTknSJbHZMgUqw4a3XtxMJ61nz8_kCBsd4
Message-ID: <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
Subject: Re: ui: Regression calling eglInitialize() since v11.0.0
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=alex.kanavin@gmail.com; helo=mail-qv1-xf30.google.com
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

On Fri, 5 Jun 2026 at 10:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> > > It's the same issue, I assure you. Qemu 10.x prints nothing and simpl=
y
> > > starts, while qemu 11.x first tries glx/dri3 , then wayland/egl/vgem
> > > (even though there's no wayland running on the build hosts), and then
> > > finally crashes, with the traceback that RP provided.
> > >
> > > I don't think it's a race condition, as the failure is deterministic,
> > > but I agree that something has changed in qemu's GL initialization
> > > sequence.
> >
> > Cc'ing Marc-Andr=C3=A9 & Akihiko
> >
> > Context:
> >
> > https://lore.kernel.org/openembedded-core/7da33301e8a0bae93a33695b4fd41=
f67a08e1b9f.camel@linuxfoundation.org/
>
> If it is an suspected regression between 10.2 and 11.0, then
> I'd suggest someone who is able to reproduce the issue reliably
> should do a 'git bisect' to narrow it down precisely.

I've done additional testing, and I can confirm:

1. Reverting the following commit fixes the issue:

commit 52053b7e0a0e285ce3448b830053b05fb0a9b1a8
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Date:   Wed Mar 4 16:50:30 2026 +0000

    ui/sdl2: Implement dpy dmabuf functions

2. Updating to 11.0.1 does not fix the issue. It includes a fix for a
different, but related problem:

674221887f ui/sdl2: Fix assumption of EGL presence at runtime

Note that the environment we run in is X11 without wayland, e.g. a
XTigervnc server that provides a X11 display.

Thanks,
Alex

