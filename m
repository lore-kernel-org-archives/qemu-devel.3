Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E747FD7308D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 15:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w92Tb-00059Y-Bz; Sat, 04 Apr 2026 10:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w92TV-00059F-3x
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w92TS-0007au-NT
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775314784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMsb6lasisA5suDG0Zsoj00dH9twXxf2ScN0FrfClLI=;
 b=JQV0JvBXMX6oXu0g91SIhIup84cfdNjrLMVdiY53qtv69sKK1tviUXL7MVOCvrq/A057iT
 N0XQcZx5AMZp0ijZeY7Wn0aV+/Wup6rYrcokSjCBtrHIv71McuLlFvBaO7lons2IKBitpD
 WC2wxsUNe6Z3sof5NDBikLeuQM+tzzs=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-lYCKFQ4jNrWitYRKiwaXoA-1; Sat, 04 Apr 2026 10:59:43 -0400
X-MC-Unique: lYCKFQ4jNrWitYRKiwaXoA-1
X-Mimecast-MFC-AGG-ID: lYCKFQ4jNrWitYRKiwaXoA_1775314782
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8230d6d54a5so2435553b3a.1
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 07:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775314782; cv=none;
 d=google.com; s=arc-20240605;
 b=OjaYxrfNcz/xOvdh2ELFg5nJ0nEYUhN1U6u6do0P3/XqnRmyRW9WZ43kM35wbnZ5ym
 Cp3ohemLEwvP2bB0+FHYVsh+jUo9Bw85U0e5AyTg2Xpk0pKBS9j37EXWk95D/HQ4hnwY
 Bpk1zH+n+9Aar6QGxTpnkkY/IpfkSAIz5zwFKnpSYNZXuw3l//qMexpcnT0C1QZqw9GU
 meFz+OkoJEjiWfhj2+j1egFJnrYb7Cw7/PeXYvstIjp/xdlJJdlxpygYScvtL31STDg+
 buDj/I06Nvxjk8i6/S95D4IQGDx1t2PtxSAf3P14olwQVvjGanOgYR25rEhoJWk8DpC/
 kkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SMsb6lasisA5suDG0Zsoj00dH9twXxf2ScN0FrfClLI=;
 fh=1AedghrWfmWpwJgSv40d1VSkXxo09sTYmGNkJXFOGS0=;
 b=cFHiLHdgE8vc4T3rDMt9JPQx7qwl+UkDAPuLa0pla0Buyn7We1V/roiioU3lawXz9K
 UY3br+etPrzenNdx1ekevejTYaaOJyJu6cphHqcpM17Qmu4UrWGR/cN8VhPfpMQ+YAKk
 t77RJPWMYXZ8ZKrMLmpqhsM/e2rteXMbuy234a7nXlN2zXH/yah+OW13OFH5UcrFz6wr
 mSsGW+5GmKvimV4dAcaXSh9FWw9qm3a3CqrDvfBJKj5SOuF48hBD2b0q5b8fnVzAE0Sj
 93umxCvZP44EGEsDvmZCVSrMnGveExYtc5lqt3qeR1awpOfCPdFiSLrcpcwQu4tkmnHE
 582Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775314782; x=1775919582; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMsb6lasisA5suDG0Zsoj00dH9twXxf2ScN0FrfClLI=;
 b=rB9M033Jq08bhgMm8xl1BH6CmnHDf5+0TK1/IIhqxnmiLanCLbpxRKTG09qW9CCSN3
 4DPr0b5vs3dRz24KPTZc2M67MHjrrdHEallDQC5p64VQzeXYN6dNHnZKxl1AU5SA//4V
 Ew6jxUuWjanzu+/4WkFe6mPHuwFpWRPUUTOHksW+SVWKsUWViVoRsyqxhY0z/o6e/oA/
 ldiIC4NwQPbYHp6ZVbfKQq1YAxPFuSA+Yjs+kKEks4BBKvTDxSJbaTgKX6XIL+8HSzkR
 jFjqo1tNdx/id8NXcmJaRI+uxa3AVeU4GP/S64rr54KjznqLIz0NasJ1Qw+WtQK3DVGs
 MK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775314782; x=1775919582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SMsb6lasisA5suDG0Zsoj00dH9twXxf2ScN0FrfClLI=;
 b=SfH65zw37iq9KQrxnvs/Ktg6VXsC/dvCZzA12/IRxsFrMMegma/X80pf1yC0Qt11a/
 udgbyojYLzafMrshNkJpjtpevl044R7HD1LrM0fJHBWlXKTZGXGY2cH8D53aoYlwZirP
 r7zllkJaXtWO0CR5ESkQgIxFWxSj/UMSXTWEHkrScuNOghzCkSvNogRYhxo8p5W/Bc+i
 oGcZX46RhLHo6Mh4wryI18IXDQI5jRPXC+hNFsPf5kPe6Teoe5TTQbjaCVMTP8bEB70U
 fh95xdmSnbTHiGQquRmXK9HY504FDkp/hXO0gYzO1D9eOaWklLEKokfOwLhOIoiVcIyp
 re3Q==
X-Gm-Message-State: AOJu0Yw1Albc0lnj8k7RvwVBFBFB9RgiI8VtiM1/aJS/grwLtGlvWXtr
 O7tWSeYMFigITh3uL3avxQLcyzpUgICQ3xHyMYCgWKnAECtcOeP+dbFHMuVefrJyYxCSkG/YcHf
 t/qw5u2ildBNipPliXrzngo3Xb1tFyppBKVWsH0BWcRtDfiETmybrRJ7u3BqozlTIWlMafYkC0L
 hDUIag4TaWrzPlUXNgdLK+CB+/Y2r9R941fN6Bbjk=
X-Gm-Gg: AeBDieuC6oWo8YaauJb8uQXuRKFV5os1/Dlyy+EcPXhibVJhRFZYI6kVBjn5TtYm0zG
 curwoB6BFqojRYS6PchXocV9hcrDehqbx1iZgIEi7dnkQogHXEgc71R4YWm4xAfwYm7LOnBBFis
 6Owglsy3ie83KjOQo2Uno5gdoochHre4O4MmslfFrRHoqcxRbyj7kTdn8Yjf3RR6H0UJbMVkXjR
 nxwW9tRn9ITdecosScckOQ4/ZzSeCTVHMex1RYOWOH7XTS0SHQceGmm7wJCon/88MDDIlXB/TzO
 VHhZIPqoN2zhefglElSVrtE=
X-Received: by 2002:a05:6a00:1ad3:b0:82a:6e4b:5b4d with SMTP id
 d2e1a72fcca58-82d0035bd98mr8126057b3a.23.1775314781718; 
 Sat, 04 Apr 2026 07:59:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ad3:b0:82a:6e4b:5b4d with SMTP id
 d2e1a72fcca58-82d0035bd98mr8126041b3a.23.1775314781122; Sat, 04 Apr 2026
 07:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-53-48eb1dcf7b76@redhat.com>
 <e18e7a83-0c7c-5d83-a000-146c23d6c350@eik.bme.hu>
In-Reply-To: <e18e7a83-0c7c-5d83-a000-146c23d6c350@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 4 Apr 2026 18:59:29 +0400
X-Gm-Features: AQROBzA1u0y3KsY1wahzmxgIyTWGhxZelz8JVhA5QFmkAXAWY_M1xSjLXy_6cao
Message-ID: <CAMxuvax8LBcRwrJhThYZaHW=N=8fQTcDcobXpU4obFPMssHoYA@mail.gmail.com>
Subject: Re: [PATCH 53/60] ui/console: return completion status from
 gfx_update callback
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Tue, Mar 17, 2026 at 3:43=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 17 Mar 2026, Marc-Andr=C3=A9 Lureau wrote:
> > Replace the two-field design (gfx_update void callback + gfx_update_asy=
nc
> > flag) with a single bool return value from gfx_update. Returning true
> > means the update completed synchronously and graphic_hw_update_done()
> > should be called by the console layer. Returning false means the update
> > is deferred and the device will call graphic_hw_update_done() itself
> > later (as done by QXL/SPICE and Apple GFX).
> >
> > This simplifies the interface and makes the async contract explicit at
> > each call site rather than relying on a separate struct field.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > hw/display/qxl.h              |  2 +-
> > include/ui/console.h          |  3 +--
> > hw/arm/musicpal.c             |  3 ++-
> > hw/display/artist.c           |  4 +++-
> > hw/display/bcm2835_fb.c       |  7 ++++---
> > hw/display/bochs-display.c    |  6 ++++--
> > hw/display/cg3.c              |  5 +++--
> > hw/display/dm163.c            |  4 +++-
> > hw/display/exynos4210_fimd.c  |  6 ++++--
> > hw/display/g364fb.c           |  9 ++++++---
> > hw/display/jazz_led.c         |  6 ++++--
> > hw/display/macfb.c            |  6 ++++--
> > hw/display/next-fb.c          |  4 +++-
> > hw/display/omap_lcdc.c        | 14 ++++++++------
> > hw/display/pl110.c            |  5 +++--
> > hw/display/qxl-render.c       |  6 +++---
> > hw/display/qxl.c              |  7 +++----
> > hw/display/ramfb-standalone.c |  4 +++-
> > hw/display/sm501.c            |  8 +++++---
> > hw/display/ssd0303.c          | 10 ++++++----
> > hw/display/ssd0323.c          | 11 ++++++-----
> > hw/display/tcx.c              |  6 ++++--
> > hw/display/vga.c              |  4 +++-
> > hw/display/virtio-gpu-base.c  |  3 ++-
> > hw/display/virtio-vga.c       |  6 +++---
> > hw/display/vmware_vga.c       |  7 ++++---
> > hw/display/xenfb.c            |  6 ++++--
> > hw/display/xlnx_dp.c          | 10 ++++++----
> > hw/vfio/display.c             | 17 ++++++++++-------
> > ui/console.c                  |  7 +------
> > hw/display/apple-gfx.m        | 10 +++++-----
> > 31 files changed, 121 insertions(+), 85 deletions(-)
> >
> > diff --git a/hw/display/qxl.h b/hw/display/qxl.h
> > index e0a85a5ca49..ad8a9128785 100644
> > --- a/hw/display/qxl.h
> > +++ b/hw/display/qxl.h
> > @@ -187,7 +187,7 @@ int qxl_log_command(PCIQXLDevice *qxl, const char *=
ring, QXLCommandExt *ext);
> >
> > /* qxl-render.c */
> > void qxl_render_resize(PCIQXLDevice *qxl);
> > -void qxl_render_update(PCIQXLDevice *qxl);
> > +bool qxl_render_update(PCIQXLDevice *qxl);
> > int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext);
> > void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie);
> > void qxl_render_update_area_bh(void *opaque);
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index c695b433fe3..2ac9c59e151 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -363,8 +363,7 @@ enum {
> > typedef struct GraphicHwOps {
> >     int (*get_flags)(void *opaque); /* optional, default 0 */
> >     void (*invalidate)(void *opaque);
> > -    void (*gfx_update)(void *opaque);
> > -    bool gfx_update_async; /* if true, calls graphic_hw_update_done() =
*/
> > +    bool (*gfx_update)(void *opaque); /* false if deferred update_done=
 */
>
> This short comment (and the commit message) seems to be the only
> documentation. Is it worth documenting better somewhere or at least make
> the comment more descriptive such as "true: graphic_hw_update_done() is
> needed, false: deferred update_done" or something more easily understood
> by somebody not familiar with console internal working.

Adding a more descriptive comment above.

> Also when returning from update functions from an error at the beginning
> without any update is graphic_hw_update_done needed when nothing changed?

Yes, a QMP screendump coroutine might be waiting to be resumed.


