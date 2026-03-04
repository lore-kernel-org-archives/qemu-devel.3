Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30132EC1425
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhDw-0006Bx-6y; Wed, 04 Mar 2026 03:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhDu-0006Bi-Mm
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:04:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vxhDs-0005Yl-QI
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bBpBVi51Cl5nz9XFISreY4ctJoTNQKOS/mLkIxcJfA=;
 b=OpbEjzHwynt8j1ewTIE0X1DSIhtaHzpMgc3V9/6349bjmjhRVdfxepPdn39rcO8TGPcmc8
 XLs1Uji0tmB4H39rTeq124LtxDvRyhZjVy6mOeyEA9rnXWviDYTstR+HqTCWN9o7+m63zY
 XQvWcwkEuZutNJZ/oiUCfzAqDvM+O80=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-rgnY38TAOBmk8nQM3my_fg-1; Wed, 04 Mar 2026 03:04:46 -0500
X-MC-Unique: rgnY38TAOBmk8nQM3my_fg-1
X-Mimecast-MFC-AGG-ID: rgnY38TAOBmk8nQM3my_fg_1772611485
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35641c14663so6840070a91.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 00:04:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611485; cv=none;
 d=google.com; s=arc-20240605;
 b=InfDE+f09i8k4GLSaZkFR89MAEZEZum47Os9E50KOESahTF807E1DLEAOMFAxDfjq4
 uM3ul1XZ49AdlLCX4+wP5HIPICbabR7u8mNJyOd3j/yA33EDJvAZsZ21nP948dhFu/sX
 eFQpti4Y/UDFZn9fKYpdn3vN1Kirxen52BwwjvEb+AS+gna1O6XQRPntdtDrf5Za/BA5
 GWWLa5PI10xU+dBs/uwbS7xyK59HEirn5lG6PB8LBeh76qiwVlUBDtXooYSqyKNrKsJ6
 lbtkMo+3Klv8tFaOwNmF1L6xTCXZI5jqxF3FePasEfMiY6fYN3tkGakxG0SQmvV130gi
 89iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+bBpBVi51Cl5nz9XFISreY4ctJoTNQKOS/mLkIxcJfA=;
 fh=Hqd2TYVc/0jvjApXin4vmxCzBf4dLB+vSpVkLUlAFJ0=;
 b=NwsT+3jwYlHGqx1qCg2e+dbgdzvgr7jkHuNuik1qYveKhX+YgD2a/lVtZH2mQ6zgrP
 vHxAfhzBpDjOUTRK30phWlIl+405hdggOcd9USRyhtJ7lMhyBg/hiEl2cVX8v7nx/OlT
 d2lEv7q3YmRyYJnq7AADGXVgGOpZSzQy4eEy71c9Kdaz5404PfU41Vcgy/B/BShq2nC1
 tITaMhi5pGlvo9Yat+lnZffAtRi9jrokltNuzvHGGAZCGJo4Dskwg5Qp8FhBXjW28lzm
 kFKK3lZp4Y66Eg2KPbq3dMKlo0HS2Po0HPsKMCdZNdGnfR/NKJymKgobEic1hn4BtU+A
 Eubw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772611485; x=1773216285; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+bBpBVi51Cl5nz9XFISreY4ctJoTNQKOS/mLkIxcJfA=;
 b=s0ld99a1bVsmLnT17bjo5GXh7uJFR/REN4QsEsojp8LK54RPewySEBbKQaxbv6efr3
 6VS4wR/mvHbJJng2yKMyR8vYxxFZ9d1Y2pBquZm+SfgRCilzsYUpkNrbHkbauG23BK+G
 fMxjlFoPocFDpS4OOnH1NLYvnrjTOZVXKu9cIK00njaGvurEcYV0MuHuFTd6IxRQNfQs
 3SXSrSOgWKTAoP9DdBlqnjNrfJPKOBK9WFsviaSNR1ZuF2Ky5IH37mEwBMySA7+7QUiu
 +P+5B6RAV6VJ7DTLSLxhCKwJi6OrFqiiplJ2m0d1CCCqH/mJHdjBZJX+PDSgLWAD3rHC
 tplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772611485; x=1773216285;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+bBpBVi51Cl5nz9XFISreY4ctJoTNQKOS/mLkIxcJfA=;
 b=ji8+DX1Pp/5dxbv5eXCxGKHp8SDdRwQt7PE1kxpH34Gb0DUOdG0nEZaW0JgvUjpFBB
 r1zhtnjYk4p6B27rBwRvJUX570/I7DZ/c6TWhoWJHcTc07d9549DiyG6iOZJM8CvG84k
 fdj14lTTrAGwb+a5SBZRCy9Nl2ta0cBVTzf6YDKUFF5wfE3z83Jw6lS0PFEKCcRFeOmJ
 F/eg+yn0oIyRiseqnpZa5xUC/rXBD4bWZgz5Od2agMND5GRT7dY0MNa8smOv74hj5cqe
 aM8dHN7HzTTCsx0T/iou/djT+Z8WFGyAnssnQ89hZjriksqkam4roG0P1sjrpe5W3ZWz
 n4MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlAHYP81lR8I8wUKkZN4lGYbvEffw4YU9hZ379cFBYc1r1dq6tfjNFdBbUotC7qZZ81GL98LvJHHLd@nongnu.org
X-Gm-Message-State: AOJu0YxKpzOwspLUuPgbRTjb3gjshPYm+XzEBcR0wYDE2o6jGR5cAgve
 XG3cecBPcqz5nENIh8xG/2kYZMJQOZ3bl7yPwiDXbgwUGHz0+VB7hRBwzUXI6dul9RDHDNkW84r
 OlaHLdpyBzDxSjbHWj1RBxvAP6nQZ4NrmMHw6ZB1znUuC7r4lit6FUQJGIIV7lkBovk2iESVAJl
 j1WFLRlSNP9H9UReEOVy0impUST3Fnc80=
X-Gm-Gg: ATEYQzz3dFAvm47+mhqC3z3nrzhdHaI1cyAQLoOvzD88TrKop6oeCD2ytJ5dOA78p/9
 VlsFNLz/l8rDWwFdOnZXP0BT4vVf/Fchv2X71Q7oLZqltmwBtC+Z5tK+KSeFioJN8ar+jQl1SSU
 Ynk6Q4oyuJiiErLdpAD9n6T186WF0LuBYtQj6w8fZ6zghFrC4S9+zrJ8AsUKxH7SvcVS3jaFLFW
 QGxboL7WPfEYcctl/3282q8eLTw2onjCMNMaDukPV3KEvt17MlBdlSgh/uuk+0qN+YahfZxmp7p
 fO7yqRXLDee8Jfgo2Q4XFuBs
X-Received: by 2002:a17:90b:2888:b0:359:7906:d996 with SMTP id
 98e67ed59e1d1-359a6a66a94mr1307566a91.23.1772611484955; 
 Wed, 04 Mar 2026 00:04:44 -0800 (PST)
X-Received: by 2002:a17:90b:2888:b0:359:7906:d996 with SMTP id
 98e67ed59e1d1-359a6a66a94mr1307550a91.23.1772611484623; Wed, 04 Mar 2026
 00:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20260304-zoom-v2-1-2eebf2b51106@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-zoom-v2-1-2eebf2b51106@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Mar 2026 09:04:32 +0100
X-Gm-Features: AaiRm52czqEDabEzCND8b6Dc7avUXTNZQZ8Fr50gnJJSqfk1ZsNUazvme4NHCac
Message-ID: <CAMxuvazTM20U9jAvD5oQ1rHi0uYxnPJK1KH0-KUvbcEZAhL2zg@mail.gmail.com>
Subject: Re: [PATCH v2] ui/cocoa: Do not automatically zoom for HiDPI
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 4, 2026 at 7:40=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> Cocoa automatically zooms for a HiDPI display like Retina and makes
> the display blurry. Revert the automatic zooming.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
> Changes in v2:
> - Rebased.
> - Link to v1: https://lore.kernel.org/r/20240318-zoom-v1-1-07ad14fcde19@d=
aynix.com
> ---
>  ui/cocoa.m | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 23b7a736d700..7c46a16968ed 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -627,7 +627,10 @@ - (void) resizeWindow
>      [[self window] setContentAspectRatio:NSMakeSize(screen.width, screen=
.height)];
>
>      if (!([[self window] styleMask] & NSWindowStyleMaskResizable)) {
> -        [[self window] setContentSize:NSMakeSize(screen.width, screen.he=
ight)];
> +        CGFloat width =3D screen.width / [[self window] backingScaleFact=
or];
> +        CGFloat height =3D screen.height / [[self window] backingScaleFa=
ctor];
> +
> +        [[self window] setContentSize:NSMakeSize(width, height)];
>          [[self window] center];
>      } else if ([[self window] styleMask] & NSWindowStyleMaskFullScreen) =
{
>          [[self window] setContentSize:[self fixAspectRatio:[self screenS=
afeAreaSize]]];
> @@ -685,8 +688,8 @@ - (void) updateUIInfoLocked
>
>      info.xoff =3D 0;
>      info.yoff =3D 0;
> -    info.width =3D frameSize.width;
> -    info.height =3D frameSize.height;
> +    info.width =3D frameSize.width * [[self window] backingScaleFactor];
> +    info.height =3D frameSize.height * [[self window] backingScaleFactor=
];
>
>      dpy_set_ui_info(dcl.con, &info, TRUE);
>  }
>
> ---
> base-commit: afe653676dc6dfd49f0390239ff90b2f0052c2b8
> change-id: 20240318-zoom-df4d6834e56b
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>


