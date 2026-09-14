Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDF1C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x606h-0004pA-HT; Mon, 14 Sep 2026 02:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x606c-0004oh-Rf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 02:23:54 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x606b-0003FH-8C
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 02:23:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8692be1cda4so2315085b3a.1
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 23:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789367030; cv=none;
 d=google.com; s=arc-20260327;
 b=hdSwDb6gTkxhWP9CPm+VDc8829GSX9ruxWLBEXcNflvJMKiJ7tb25jFSevxKfiI4ml
 G8GuQFMPpN9gSy1q2ry8KAJ+czE71/WZetYsV4F/eXeJC1WYxuTn6YpvuUv0YESMiD1x
 NLX/o0QgzLXUXfkJanfVtoOJRDryUNSAfZtLx3dNxrFv80hPVAlm6jhGeT+yThJIrQCZ
 Tu3ApB0c2NZLB5JlQ1dat/pUdxCj53DhNcSTsY4pIHEbOk4ArkoY2vNXNrE85S+AOXSW
 zpmLF53qmEJ1Fy2yR9SUsqKRO2ODZqKCIvKc2EVAScxaBz7dA3LMIjZmviIVzXputweU
 PrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dbwiCjppbGq8pqD4c1TYg9PyQO5sYMDYzdZw6+roRVY=;
 fh=W9DMdrjHkxrXpAJhu3CQvnDyj7IVlhsopZZ0i/b79yU=;
 b=KL4lDJ+hM3aPlqUHc53Jy/tgLs+s6+Jkw5zYdvXQpj/oxgKdbvUYMqiL5MEsu+J/Sl
 Lyizeq6O1C/6fmmkptr4dsaWBv0RB6mz+9KBV/qykUiFMhm35D35YvJdF43DDXQUACsw
 nPvk8dKHPwcVTQRubkUTkuHlbcb2mY2kS0IpMEEaDDBZ5xjJAjb6A6H8Y2RuDd4/14CN
 yVh2RyRS8vjrzPa1Fp/Klclq3RosvXn5PEd3gu9Qws/NBq2VXiksxeAqCDxfMAYGh/we
 mO/SWxMyFmN+9CJXjEx/GuLdetWILnITk7OrbIaqhGwyoFJTW14jebtF2btPJxwcJVm4
 Of3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789367030; x=1789971830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dbwiCjppbGq8pqD4c1TYg9PyQO5sYMDYzdZw6+roRVY=;
 b=CSZi74JxAkR9TG7/chsyI8SIyLFXOybuM4Fdl4n6M3j0fw1mWkiPaVO8g99Y1stKt4
 1q7NDK6iFXuPLceCVboPmbzsbW7gF5fNoEXNX6VGRlsL82NIqwfmAtMlHvMVPSMlEpcV
 FeGN6QuIJ1rlUTTwTiut+eNGNbGx0p+uLQjuY5mzCtXdWDu5O8oo5Zj0jrcohpCxtu/y
 PZag/BjxJTiE4Zl0YzOqmRAXjzhyttci/eEYjyuLxlMdqY2o0TDF4c5I/qU2cFZ9DIpW
 akEYd5R4DzlmHrtjJ7REJgieNpx2dLsR0Q8sXpFTlDWV4WHwvxttbCW8GBeuTGIsU80U
 pemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789367030; x=1789971830;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dbwiCjppbGq8pqD4c1TYg9PyQO5sYMDYzdZw6+roRVY=;
 b=m17RfUE8vwwzUU80UxOzHkvzyzZp7y3Ym6RotDuQ7yYRulkgVaUIhEXP3NjVnEC8iD
 rqbq72ch9DxFvLoseSDX8Bs0Yh1S2Rg/SOv22Iz8OVpEw56WeIQ7wp66wJMy+QTy1fxy
 sKILrkIHsyjtOsuQLzpNMfih6Q2xp3H2Y/RwXd85I674NwZO1fxbhH5etBFpMWI8XuwD
 gCh5g1bxJ1PevQMYVvjzSK3sWqASyBtl1m6WbF8NTgcX94RxJWHFMXxHNosIvj/vo9H2
 5aLMPwR7Z69WVRJi8SLCIsB9czpPHc6AaXr1F0xHq3GIpeCQh/v3H41HvJqaTlbkBqWq
 RdrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVlKoCWVnEAi507rfoZDrPZRsD6ez6v9hCfGmEi9HDlxKeA1Z2cnJOHAP/rGfh7AErT2UVn06jk17V@nongnu.org
X-Gm-Message-State: AFuF++l55COV0OiSIu91FGmaBly0gVLtxajVCnipAcnpQ5AtrAEXAO8G
 TGF3eLR82F9H0SUkxlTA2axuedxoAGCs5m+WpIrKiAgxt0zlxHp0MeFD8BFByoyGg7eVJgswkcT
 A2e3f3Cji1Pn4m0vHxzBL9CB0Ju+pocg=
X-Gm-Gg: AYBFou2D4E872Y/YsL2ubfrJqpj1+l2z44HM4d6tYqR67Jfh/vF8RVq7g3DkUY6DM1p
 Oxind35tUQ2C2irpRDnK3HpoZ7IrOoFdUCz/Ram+oOVmBz/HvTlzgc6p3BbJWNZJ0Z1W7A4fLAe
 zBhN8WInDby0+IrYC9Xdy6O3uK7+k/FBZBdAqld6ZWjmvhG1WbCT1p3S4mRs0qUEm3eBtodRmhA
 MZiO+sXkBoiPKKDRtBGc5sIknXAyn6BDd+2lAyl4/EkKqfG9IzSXF+DCPfVvSWe+tW9qdbFoPrT
 p7WhcCWaeJauZZI8b0UvxL9nTNKM6UNKQFFlzl7Ou1kLrGMqRCGlXuhiw4AN82UtxDryLgy6oCD
 Agur6tkPXrD4=
X-Received: by 2002:a05:6300:4049:b0:3d3:ae1f:d7f8 with SMTP id
 adf61e73a8af0-3db405e68eemr2288714637.24.1789367029953; Sun, 13 Sep 2026
 23:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260903192647.2677279-1-den@openvz.org>
 <dbfd28b4-8beb-4af5-a9e2-72a296ce41cc@virtuozzo.com>
In-Reply-To: <dbfd28b4-8beb-4af5-a9e2-72a296ce41cc@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 14 Sep 2026 10:23:38 +0400
X-Gm-Features: AcwNN1XgN__whjCPr4tdqtwPHpC8ovx-qR2lMMudNe0EcyUJZx6GQ9Ai5ZbRy6Y
Message-ID: <CAJ+F1CJEE28EtWTn9pvmMt2cddwy+NSgLP8DAGjdGOkYtPN0kg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ui/cursor: fix two races that free a cursor early
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x434.google.com
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

Hi Denis

On Sun, Sep 13, 2026 at 11:58=E2=80=AFPM Denis V. Lunev <den@virtuozzo.com>=
 wrote:
>
> On 9/3/26 21:26, Denis V. Lunev wrote:
> > This email originated from an IP that might not be authorized by the do=
main it was sent from.
> > Do not click links or open attachments unless it is an email you expect=
ed to receive.
> > A guest with a qxl display can make QEMU drop more references to a
> > QEMUCursor than were taken. The cursor is freed while another owner
> > still points at it, and that owner's later cursor_unref() decrements
> > four bytes of a chunk the allocator has handed out again. Nothing
> > aborts and nothing is logged; QEMU dies later in an unrelated
> > allocation, in another thread.
> >
> > Two defects get there, and neither fix is sufficient alone:
> >
> >  - qxl_spice_reset_cursor() replaces qxl->ssd.cursor with no lock held,
> >    while every other writer of that field takes ssd.lock. It runs on a
> >    vCPU thread from QXL_IO_DESTROY_PRIMARY and, unlike qxl_hard_reset()=
,
> >    leaves the SPICE display worker running.
> >
> >  - QEMUCursor.refcount is a plain int, taken and dropped from the main
> >    loop, the SPICE worker, ui/cocoa.m and ui/dbus-listener.c, with no
> >    lock common to all of them, so an increment can be lost.
> >
> > A qxl device starts a spice-server instance for local rendering even
> > with no -spice, so this is not limited to SPICE console setups.
> >
> > Patch 2 also asserts that the refcount was positive. Only qxl was
> > exercised here, so if another display backend drops a reference it
> > never took, that assert turns a silent leak into an abort.
> >
> > Reproducer: a libdrm program in the guest queues cursor SET commands,
> > then disables the CRTC so the driver issues QXL_IO_DESTROY_PRIMARY.
> > Unpatched QEMU dies within seconds; with the series it does not. Happy
> > to post it.
> >
> > This is independent of the pending "ui/console: fix use-after-free in
> > qemu_console_set_cursor", which fixes a self-assignment ordering bug at
> > the same line. With that applied the crash here is unchanged.
> >
> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Denis V. Lunev <den@openvz.org>
> >
> > Denis V. Lunev (2):
> >   hw/display/qxl: hold ssd.lock while replacing ssd.cursor
> >   ui/cursor: make the cursor refcount atomic
> >
> >  hw/display/qxl.c     |  2 ++
> >  include/ui/console.h |  9 +++++++++
> >  ui/cursor.c          | 17 +++++++++++------
> >  3 files changed, 22 insertions(+), 6 deletions(-)
> >
> Hi, Marc-Andre!
>
> You have not posted the notification that patches
> have been queued. Are you going to accept them?
> Unfortunately I see your review without any further
> actions and patches were not landed yet.

They are merged upstream now.
thanks

