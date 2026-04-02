Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ADCD3942B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 13:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ITi-0004UR-0f; Thu, 02 Apr 2026 09:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8ITZ-0004EQ-4G
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w8ITX-0001ja-1j
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 09:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775137965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SqaJLNqwRXe1Jh31TCzPZv2+gQIqq6F2anS9WhSdUx8=;
 b=O6aDrIxeQx5IaYnjQz8fPbVyCJOxw9WqAUb/ksxYBf0co3KIQg0QDlMffRrjZkAePX66GH
 WmUCiSW0IS8RzyFjQXv5DgKQlI/bKHqI1LwDuna/6h4VBSLX0gf3DK48Q8z1bA1bm9Vzsk
 lNPW4Hrl4yZsDRBDPQop+GVugvD74IQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-NnHGOsUnNFqaqWO3VwTpxw-1; Thu, 02 Apr 2026 09:52:44 -0400
X-MC-Unique: NnHGOsUnNFqaqWO3VwTpxw-1
X-Mimecast-MFC-AGG-ID: NnHGOsUnNFqaqWO3VwTpxw_1775137963
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so515278a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 06:52:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775137963; cv=none;
 d=google.com; s=arc-20240605;
 b=QbDpFfHotGK6X410c/ap5W46ZLMDgV8xpXdEU9M7jLZuGfmIuh2u0Mq/csKCjADFq5
 bMGiolFcFwzKhuOHU/9vmsmOVnVFkUA4n4YaPzbnVfiYFTjsDpSEuGMuyDVv61w+hhy0
 krWwDJA9/WvQH+GgHTt9eRbs0YoHAYhUlToRFzjHGR75tzi8UWJMvxAr9Jgft7syVWWh
 8iJOGnX6jDpy8w25wCTN4tuz3QxUdgoP7a0/cWjiyg1qXU5xxiYo4uZ+4n6POuV5FLX7
 fa4IlwdoGvTjnXEB6n0HP0taCxN6C9CqWVKFoX2kjTzJJ74QIiucyWxb4oBBO6rzp/wS
 nduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SqaJLNqwRXe1Jh31TCzPZv2+gQIqq6F2anS9WhSdUx8=;
 fh=zpiKzW8LH3ELwKzluQ3AheUCgrr23INy4hQ6ZjBUBr4=;
 b=O3ttQ3518iyKimqAzq6PnkhqY1LDUg4weGpdt8wHbD/VkAvjEF40wCtrXhUxT35j1E
 6uI3dSpJsEl3EC/CEhOngHn0qg5UCVmyl1z/lM6Av65buAzUnspWJY4fFg3M/OOTqSrj
 5VHRuLF42ruj4d10oAdll40i7sC4c/pJLAInJAD+BvLTf6GJQZjXzydYg1ZIn83hHsTN
 LYPRHtRkpz1L8WUnc4ciSgOxI8n6a8RYBLE9d4+Eury2j2ocSFdhS2e4gHnqBbDIvwRf
 nnvqVyecS1wG6AGjvXMa908D1SaIaeGsVpGw/dj2V70a2NGqS0yhKOmyzyKMz8VqAEx9
 yeOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775137963; x=1775742763; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SqaJLNqwRXe1Jh31TCzPZv2+gQIqq6F2anS9WhSdUx8=;
 b=PIehFBEM7asinP6fkpotk5q5TMVKtFeJLFMsS3MkkCCPQJ1l9B3RC7yXNcQW+Tf0ZE
 ZoshHmW7ShBCMrMxbRJCLL3/b3lOjHuE3+Kf7WCS6ezP/Z6yaUsiN+Vp3pDbryBx37pG
 7lu9mpfQLb/ILevVQIdYovBkhZQjLP3OIoHTnYmomfcRaEzQoniiauAS4a8jqFncDsCq
 EtRdwWRdyRaCc44vVkcSaRVYwmPjB/SCC3EuU1Ehqpkz67CbAlze0eVph+67L1PEjdnB
 T9gb4YkWXUp0wD9GJdd/tbb1ZnXna9yxhNeErB6O04jePgNwj/9H65e1AP/2xC1Nhnu4
 8cEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775137963; x=1775742763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SqaJLNqwRXe1Jh31TCzPZv2+gQIqq6F2anS9WhSdUx8=;
 b=HlfmtKr2ANXXi/prT9nz1FWN/Z6X0jfioleENLMIE3l3G6aE9eHGzsqys8DFCRZw6d
 VROPmmqqjm6+5F01fxSanAtPl7FtZKAyTUGBsfDGSqAHoMnn49ET0lKozGRvYU+WtE9h
 I0StrKU3cHuaJJXuWz1VX29gjtiobW0VqIOa6PabtKZeMnjPNHp8M4Kf6KAfif9U2k5A
 kpQVaW/gLJoGcr8q9uxqql0ErGj+HrJHgZ6Lc90Zs2Kcx5iQbtZUQZJV6rPbqzRFpqdW
 CRHINyNT6EDucMRrt4PbngD3EA66zyd+uU3oqL0tS+aAwYPbj8oQDqhWZG91B+0hO2ph
 axeA==
X-Gm-Message-State: AOJu0YxMBj2gxh2WBb8N+4AOTex+cDH8ysZpdFOpZ3iuo5HE5w8v+J/5
 xsC6E3Qs/fsJ+hApkgFTJlNp7HlvbJQsEsb5AnZ/iu995vDcOCath4ZFICt98JqCT1fRneCOstf
 wFw52BN4ncb9Pg7o1g3YkNk4ovOPz+fzjMshSRL9ozuT9sMN0S0ABE9NcRNpUqY1D7jK3NyBUZS
 hBI47hm7Ek24/KbY4D81mDX30SSBAP9XM=
X-Gm-Gg: ATEYQzxc3xfpldLCClDETujEOt1w3LZKokfpn0akgoKPwZARSg5MdEUyifQ6P2vR4mf
 hZBeJ03LvXRTDE+vTR859zOpfEuvtGGYZmlSD8uquQF0vPJYAUP/uixesqy4xcf+sF75KDoysUL
 Nu6D3X4wgXtW2DyFQlhUaPWGn7yqg004M5b/S2eXNmBl5E/ZXc1INEYQ3qVZIRs1uU3whtEF2/7
 1ABnztxfgJ1FmT3qCswDwmGbhzmR8tMTvo+3+g4NJiu/gOZQGo4VW+eKpFwYwUFfABIEkf+tpve
 IAzii1JgTu8jQKz7Z6TNnD0=
X-Received: by 2002:a05:6a20:3d89:b0:399:831:cc29 with SMTP id
 adf61e73a8af0-39f170a81efmr2617270637.23.1775137963416; 
 Thu, 02 Apr 2026 06:52:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d89:b0:399:831:cc29 with SMTP id
 adf61e73a8af0-39f170a81efmr2617037637.23.1775137958969; Thu, 02 Apr 2026
 06:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-31-48eb1dcf7b76@redhat.com>
 <a30b8c59-995b-4761-b4ea-d55ae2b63b48@linaro.org>
In-Reply-To: <a30b8c59-995b-4761-b4ea-d55ae2b63b48@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 2 Apr 2026 17:52:26 +0400
X-Gm-Features: AQROBzDURnflELfQs-gPj2YKtHrnuqE9SBszxJq91KUuEuBMfadTpdJfYm1QUOg
Message-ID: <CAMxuvax144DzUPPRUw_Y-3LohL68qPCUA24NjozmG8K2naqRDw@mail.gmail.com>
Subject: Re: [PATCH 31/60] ui/console: remove console_ch_t typedef and
 console_write_ch()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Apr 1, 2026 at 5:49=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 17/3/26 09:50, Marc-Andr=C3=A9 Lureau wrote:
> > Since commit e2f82e924d05 ("console: purge curses bits from
> > console.h"), console_ch_t is a plain uint32_t typedef and
> > console_write_ch() is a trivial assignment (*dest =3D ch). These
> > abstractions were originally needed because console_ch_t was the
> > curses chtype when CONFIG_CURSES was enabled, and console_write_ch()
> > handled VGA-to-curses character translation. That commit moved the
> > curses logic into curses_update(), making the typedef and helper
> > dead abstractions.
> >
> > Replace console_ch_t with uint32_t and console_write_ch() calls
> > with direct assignments.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/console.h         | 11 ++---------
> >   hw/display/jazz_led.c        | 10 +++++-----
> >   hw/display/vga.c             | 16 ++++++++--------
> >   hw/display/virtio-gpu-base.c |  2 +-
> >   hw/display/virtio-vga.c      |  2 +-
> >   hw/display/vmware_vga.c      |  2 +-
> >   ui/console-vc.c              | 11 +++++------
> >   ui/console.c                 |  2 +-
> >   ui/curses.c                  |  6 +++---
> >   9 files changed, 27 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 401e5a010fd..152333d60fc 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -350,13 +350,6 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMU=
GLContext ctx);
> >
> >   bool console_has_gl(QemuConsole *con);
> >
> > -typedef uint32_t console_ch_t;
> > -
> > -static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
> > -{
> > -    *dest =3D ch;
> > -}
>
> Why not just remove console_write_ch() but keep the typedef which is
> simpler to relate than 'uint32_t *'?

Honestly, I don't think this typedef gives us much clarity. ymmv :)

>
> >   enum {
> >       GRAPHIC_FLAGS_NONE     =3D 0,
> >       /* require a console/display with GL callbacks */
> > @@ -370,7 +363,7 @@ typedef struct GraphicHwOps {
> >       void (*invalidate)(void *opaque);
> >       void (*gfx_update)(void *opaque);
> >       bool gfx_update_async; /* if true, calls graphic_hw_update_done()=
 */
> > -    void (*text_update)(void *opaque, console_ch_t *text);
> > +    void (*text_update)(void *opaque, uint32_t *text);
> >       void (*ui_info)(void *opaque, uint32_t head, QemuUIInfo *info);
> >       void (*gl_block)(void *opaque, bool block);
> >   } GraphicHwOps;
> > @@ -386,7 +379,7 @@ void graphic_console_close(QemuConsole *con);
> >   void graphic_hw_update(QemuConsole *con);
> >   void graphic_hw_update_done(QemuConsole *con);
> >   void graphic_hw_invalidate(QemuConsole *con);
> > -void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata);
> > +void graphic_hw_text_update(QemuConsole *con, uint32_t *chardata);
> >   void graphic_hw_gl_block(QemuConsole *con, bool block);
>


