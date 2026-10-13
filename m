Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D16DCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGa7P-0004ws-Eu; Tue, 13 Oct 2026 06:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGa7I-0004tN-03
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:52:20 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xGa7F-00066r-0s
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:52:19 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-35c76e9614aso564813eec.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791888734; cv=none;
 d=google.com; s=arc-20260327;
 b=D/QX4HUsEf4D5dbqNQLIYr6vOX+FMRnWAmHkzpf37Z3/PkPN+cvv+m8QLTFCXfRof6
 Rlc/XHQTB3bpSz4mCothngGVlP0N+TG5XkCCtolRbnd2HXSzHHCBuLQQC/NPd955e2WG
 v3PsuoIdejRIGAj9AYX7Amm8+U3AG2VtA/xtfLXMWrqxN+YK3ZhI8JfXgzN/4LfsnDmj
 tRstetDPbBmL2+zC++cvNVNrNS0/1LJx1lD9Ab8ouxROrIOqESbV0TlMoL7saSepvoIu
 x4WDcy4XJPLuL5fnW6z/BfdPm+mXaZHvQf1jXSRiXVTDyajXgFroy4JWpSWAOG/xC0Bm
 rRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h4VWW2ZDCYIOYwGiuLp/larwJgitriahXflwnYjIQlQ=;
 fh=qut9WCGoiumS8buQKfV4VTgRMJrLq2rWzZgt13Ew7uM=;
 b=gUEx5sEwS0zH6IywGESZvyRBcruongAtImRtq7cKSX1SKj5TprXQuYfOqTbpf2jcX3
 QEB43EziuBx3aS+0AHnl/X7Tmh+vfFS7ytjVAKkotIeMxpzV3iV4kOhXg5rgtfig/HJX
 daSknv2rnXX2PkXJQkogkt2gnB3tAFCu4HFwZqMvSY3mjt1IPjshOo+dHzO7bVc4iiXc
 85xY0vwWp3sSfnx6CpVV9iq5Ni7k6Sje2LP/fHJcqDJVTB4MQI2TKAZp4mMBJgYWSbsT
 RZRAQfaIV1XQHFb7nOhQq+xt6+C8MGCc0p7vJQe1TJy75fe1PwbUBqqYt3uzIBQDzjyS
 KPMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791888734; x=1792493534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h4VWW2ZDCYIOYwGiuLp/larwJgitriahXflwnYjIQlQ=;
 b=XDUFcq77AMdwtXEGnfvCzmLJACMu4PSkBbvIsz4jyp3jZN7VvgVAjFSlV+3VKcQsAo
 cLDV+Ob/9NgiHjMSTBsbyBQ3k5LIGYQ02WrbY+JUa+hPMdUGPSSuWO4z05LwaeM0Mmb0
 kg55Pn+uVtnz9FUFc0PcEwzJ/yuxcLJHhwTp1eiX0xEOZOFVtOSPiRBzO6kRkOBb6piu
 ku12151YKNREsi04Zu5ZVJ+biZcQzpGHkTdEZQLK0OLaGk5YXcFiYBXT8J9g5AL9IuYV
 hqPHkSohBzblgcxt4ao38X0ppECHHx2sDwN6r1d7VQwwSL5BJrg5wNQsdyAd8jthxP3G
 HkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791888734; x=1792493534;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h4VWW2ZDCYIOYwGiuLp/larwJgitriahXflwnYjIQlQ=;
 b=YmhH1HbAv0e7qe6JQERq8wnACnRpyXvl/n7oJQf85TZLJIoPpihQe5zP3xjatEz55R
 x4iGGmCWt+phvmo5Mz4WRzlNKXZ+5yJ7pLgg4gFhybkt/kx6fdZz80fEvXpDscV1Yibe
 29pHAbv7O9kVYinXcHM+IXNrPyY9+eG1HyU0RflnZTAATVZfQkaTbszvLmS67A1LmhmS
 prEYWtAqbpoWhjbVgeYfOsveGIFUo/CZOp93mEO6C+8B2y3eiXdm8vgxc39nQtIJ2zgA
 o/8dOjyxunwsc8QdoflCbyNwkUj6d9K9CGnNOzr7rDd0CgRmeyWmoqLYRyieZ9NoMMdy
 uebw==
X-Gm-Message-State: AFq9FYL1wlOuKxOTMjdEtiGFW7UtAUvN3TVQIUw9Cfyd9jPPYFHXUETr
 F4kYvNy2lAOmMAmE7GMTJX/x22qHfjv0nMxa/ghmDh4qavx4KcMJckkYlJ4+emWp3coBlrT5mPk
 zXPGX885Q5SXpwugMJdHGn7lVobBJbFM=
X-Gm-Gg: AYBFou0/1ErY+M1vWXf2pu4o96xmK36PB3wKyeF/bhbZHrY4LgSRcRofZRxCXTVV/a2
 vZAbVMMgDcy05DWzOPJrQzAnrXR27rbQvNoF/PGhGkWrLW0ly9TaD4KekHxB5OIdi3VXcw1VC5W
 QB6XmTW+IJ+fA0Hu1mtV/mnrbMM/pPK7UPuf07NhMP8IlTWASeiZgpxLiv215uwPb9zO1QNlD87
 NzVewoLYosxujosvdwOZn7CAcznhaX20os4JBNuQlhGAer+Z98ZUtQZSChJ+cruza6Ycnnl6fil
 9SF7zTI0JbLARt5iZYbfEtTVX57L4FeJIwM+T3PTPOhb13uOmXG0HL8BxF3s+YygGjLxTnjcXwP
 sC0JjqaSO3ZA=
X-Received: by 2002:a05:693c:20c9:20b0:35c:ceb0:8bf8 with SMTP id
 5a478bee46e88-35cceb09071mr1083979eec.9.1791888734156; Tue, 13 Oct 2026
 03:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260811102426.35538-1-dongwon.kim@intel.com>
 <EA2SPRMB00066DA87286CD23F17260CDFA942@EA2SPRMB0006.namprd11.prod.outlook.com>
In-Reply-To: <EA2SPRMB00066DA87286CD23F17260CDFA942@EA2SPRMB0006.namprd11.prod.outlook.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 14:52:01 +0400
X-Gm-Features: AclHuK-j5djpbfynXm8ruPq1LpoFIB2n0GFan79aMwBL09LdxphBLYwaUpnOeA0
Message-ID: <CAJ+F1CJo9Q0hUPRhSQYw3AMbvkH-4LRSsouXuAczk=0VcEv9UQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ui/gtk: Hotkey and fullscreen handling fixes
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Wed, Oct 7, 2026 at 11:10=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:
>
> Hi Marc-Andr=C3=A9,
>
> > -----Original Message-----
> > From: qemu-devel-bounces+dongwon.kim=3Dintel.com@nongnu.org <qemu-
> > devel-bounces+dongwon.kim=3Dintel.com@nongnu.org> On Behalf Of
> > dongwon.kim@intel.com
> > Sent: Tuesday, August 11, 2026 3:24 AM
> > To: qemu-devel@nongnu.org
> > Subject: [PATCH v2 0/3] ui/gtk: Hotkey and fullscreen handling fixes
> >
> > From: Dongwon Kim <dongwon.kim@intel.com>
> >
> > This series resolves several issues regarding keyboard shortcuts and fu=
llscreen
> > behavior in the QEMU GTK UI.
> >
> >  1. Detached (untabified) windows properly support fullscreen and zoom
> >     accelerators.
> >  2. The "Grab Input" accelerator remains functional in fullscreen mode =
when
> >     the menubar is hidden.
> >  3. Initial fullscreen setup is deferred until the window is properly
> >     realized to avoid display configuration race conditions.
> >
> > v2:
> >  - Return TRUE in accelerator callbacks (gd_accel_grab_input, gd_win_*)=
 to
> >    comply with the GtkAccelGroupActivate prototype.
> >  - Restore scale to preferred_scale and trigger gd_update_cursor() on
> >    fullscreen exit.
> >  - Deduplicate zoom handling by sharing gd_win_zoom_* across menu
> > actions.
> >  - Guard zoom helpers against NULL / non-GFX consoles.
> >  - Remove leftover debug fprintf in gd_win_grab.
> >
> > Dongwon Kim (3):
> >   ui/gtk: Enable fullscreen and zoom hotkeys for detached windows
> >   ui/gtk: Register "Grab Input" shortcut to accel_group
> >   ui/gtk: Defer initial fullscreen activation until window is mapped
> >
> >  ui/gtk.c | 188 ++++++++++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 146 insertions(+), 42 deletions(-)
> >
> > --
> > 2.43.0
> >
>
> Friendly ping on this series when you get a chance.

Sorry for the late reply, for some reason I didn't receive the series.

It would need a helper gd_is_fullscreen() because 5 functions still
only check s->full_screen. Please introduce a preliminary helper for
it

Second patch looks good.

thanks

