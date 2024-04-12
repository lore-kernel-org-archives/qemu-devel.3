Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68898C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJWO-0006mm-64; Fri, 12 Apr 2024 12:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJWK-0006mM-UX
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:12:57 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJWJ-0005tD-3M
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:12:56 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-516d1c8dc79so1420671e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938373; x=1713543173; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3852QV6s65GqgCR2vPGXyOMOsR4FSOJ5DvcnjCol3c=;
 b=HT6bXfzXWau8AUam0Vv4frATlHjqDbkQ9iB1Pxxax+fOPc9cocPRRSN313XCI7HDJI
 0VYdWp/l+AVQ1116nOI44ey1wjnZoU/NllI/9x7zhznpQQaLv71SsMjk1b7l28OB6rWT
 e3qGxKRuxHNzxrJWOyD0P10+h6FdQHtJKjrzgAdEWxdkRsfe25lU/P6qtDZ0hEmDXCSy
 E0v8VUaCG+sFkK6bLwC2+wVC21AVaVmahXGfqaepouSrZZLxGTJQ5tP8EDl8qsZuMbJ9
 970+NNwnAfuyA+tu5WxiugXWHXqhqLDEjZeO4EYCSHg598+O5ink/WzZWUHh36rmj7kP
 xzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938373; x=1713543173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3852QV6s65GqgCR2vPGXyOMOsR4FSOJ5DvcnjCol3c=;
 b=Q/VAuh+HcLe8j4XK4c00i85vrvUhcrkBOJ4+fTHURLt+qwgZYQt76mTxQi8B7e9+ng
 sURi+JZ5+aPBxsnazOwYFAHCv5xjUP9iEgpmfXxJjucIFa7cLW+g55hELz5Bu47SXIKu
 KheFls8ix1nE+bJ4GJb91wacFgrXXlpq45CnsWUriVIX+zX/V5KKK2o7tP6Wpb7RqrwJ
 e3lyhVWxOIvCr5Da9bSfkWdPwjs/Zn9Y4U7XUbYgLR/zWd65Cjvi2iZhfex1BLsOaYia
 Wj52zmRBSmoHwdL95uVsYOlMNRgKlvh8mwYU56ErkC0D/8HiTnc5aGMuwIxCUnK1r7tP
 xD/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ws87SQlwnwKNHAWAGddSpp3AXmF+2ERYejxQGw0e+m/j/Yf+LGEd78ylocqyB6tE72Ue4lP6O7AL1+6c3HATYU2lYF0=
X-Gm-Message-State: AOJu0YwwtoW/xUWFkZEgRMWj+9v8DXLHt0S8HwN5HUs1ofD3B6s4D44A
 aN4OPDmPCjZ2X0Tr9DXtVWmzUj0SMI6fn2gZMhaE+GzbtfvQb6X++yT/rZIbM7tr7/gROvW9QqQ
 zlAjN0xTDopRmCG708msc9zhglRlcgdfRYk/a9A==
X-Google-Smtp-Source: AGHT+IGxWoDTXj46aIEXnKXZ6rIxwCK0oKN7m+LqlpR8gA9KSiRjaw1j0PYrojUfKT5rGH2WbTMHMfyD24Y7LznQt64=
X-Received: by 2002:ac2:555c:0:b0:513:bf92:79ad with SMTP id
 l28-20020ac2555c000000b00513bf9279admr2108941lfk.45.1712938372957; Fri, 12
 Apr 2024 09:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <CAFEAcA8FUgmnq0-QfutpbN=xkeKxRe75b56Fu2zoXknXczwnvA@mail.gmail.com>
 <6b384586-c7ad-4b6c-a1f1-8a8d8b0ad526@linaro.org>
 <CAFEAcA9+LXUg_u2QFuYMbhxeqofD3iC4CGHo5WXL77QMCOYy8Q@mail.gmail.com>
 <CAJy5ezqkz9RLytkysd8RKvVGP6oSc-xd-mjdv9K0E=7W7xMBxA@mail.gmail.com>
In-Reply-To: <CAJy5ezqkz9RLytkysd8RKvVGP6oSc-xd-mjdv9K0E=7W7xMBxA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2024 17:12:41 +0100
Message-ID: <CAFEAcA_vgb7MDEXrgJsmgbwQj-2zqwbjTSLfFnZATM+J=znPtg@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, berrange@redhat.com, 
 david@gibson.dropbear.id.au, Damien Hedde <damien.hedde@dahe.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Fri, 12 Apr 2024 at 14:38, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> On Fri, Apr 12, 2024 at 3:05=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 11 Apr 2024 at 18:23, Philippe Mathieu-Daud=C3=A9 <philmd@linar=
o.org> wrote:
> > >
> > > On 11/4/24 15:43, Peter Maydell wrote:
> > > > On Wed, 21 Aug 2019 at 17:34, Damien Hedde <damien.hedde@greensocs.=
com> wrote:
> > > >>
> > > >> This commit defines an interface allowing multi-phase reset. This =
aims
> > > >> to solve a problem of the actual single-phase reset (built in
> > > >> DeviceClass and BusClass): reset behavior is dependent on the orde=
r
> > > >> in which reset handlers are called. In particular doing external
> > > >> side-effect (like setting an qemu_irq) is problematic because rece=
iving
> > > >> object may not be reset yet.
> > > >
> > > > So, I wanted to drag up this ancient patch to ask a couple
> > > > of Resettable questions, because I'm working on adding a
> > > > new ResetType (the equivalent of SHUTDOWN_CAUSE_SNAPSHOT_LOAD).
> > > >
> > > >> +/**
> > > >> + * ResetType:
> > > >> + * Types of reset.
> > > >> + *
> > > >> + * + Cold: reset resulting from a power cycle of the object.
> > > >> + *
> > > >> + * TODO: Support has to be added to handle more types. In particu=
lar,
> > > >> + * ResetState structure needs to be expanded.
> > > >> + */
> > > >
> > > > Does anybody remember what this TODO comment is about? What
> > > > in particular would need to be in the ResetState struct
> > > > to allow another type to be added?
> > >
> > > IIRC this comes from this discussion:
> > > https://lore.kernel.org/qemu-devel/7c193b33-8188-2cda-cbf2-fb54525445=
8b@greensocs.com/
> > > Updated in this patch (see after '---' description):
> > > https://lore.kernel.org/qemu-devel/20191018150630.31099-9-damien.hedd=
e@greensocs.com/
> >
> > Hmm, I can't see anything in there that mentions this
> > TODO or what we'd need more ResetState fields to handle.
> > I guess I'll go ahead with adding my new ResetType and ignore
> > this TODO, because I can't see any reason why we need to
> > do anything in particular for a new ResetType...
> >
> > > >
> > > >> +typedef enum ResetType {
> > > >> +    RESET_TYPE_COLD,
> > > >> +} ResetType;
> > > >
> > > >> +typedef void (*ResettableInitPhase)(Object *obj, ResetType type);
> > > >> +typedef void (*ResettableHoldPhase)(Object *obj);
> > > >> +typedef void (*ResettableExitPhase)(Object *obj);
> > > >
> > > > Was there a reason why we only pass the ResetType to the init
> > > > phase method, and not also to the hold and exit phases ?
> > > > Given that many devices don't need to implement init, it
> > > > seems awkward to require them to do so just to stash the
> > > > ResetType somewhere so they can look at it in the hold
> > > > or exit phase, so I was thinking about adding the argument
> > > > to the other two phase methods.
> > >
> > > You are right, the type should be propagated to to all phase
> > > handlers.
> >
> > I have some patches which do this; I'll probably send them out
> > in a series next week once I've figured out whether they fit
> > better in with other patches that give the motivation.

> I don't remember the details on your first questions but I also agree
> with adding the type to the other callbacks!

I've now posted the series that adds the type the the hold
and exit callbacks, and adds a new RESET_TYPE_SNAPSHOT_LOAD:

https://patchew.org/QEMU/20240412160809.1260625-1-peter.maydell@linaro.org/

thanks
-- PMM

