Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5E7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6Dp-0005eo-Vb; Mon, 03 Jun 2024 07:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sE6Dn-0005cS-MI
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sE6Dj-0005dJ-W7
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717415482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DwgYgFE/kraSrjEJCVENxOcAtSBp/USaeWo7lx5maE=;
 b=AuWqsckIA7cc5ijlzfBoJiwHEVzD0jbRptU++fFhqzv68JMEy86iqsoAFTajDhKDTSmzTI
 QSVbgfSGqDWTSgwfCTrAuERqEohaZsugkpwtZfluNgSCT+uU8RgCq6emiMN4uqX5N2kIuQ
 nNUEDwmDRobq3Xk1p0+JcxBmM7wxZD8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-dfm7VLeFOUWIPF3lsqMSaw-1; Mon, 03 Jun 2024 07:51:21 -0400
X-MC-Unique: dfm7VLeFOUWIPF3lsqMSaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1460385A58C;
 Mon,  3 Jun 2024 11:51:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.239])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D8DDB5626;
 Mon,  3 Jun 2024 11:51:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 955BC1800985; Mon,  3 Jun 2024 13:51:19 +0200 (CEST)
Date: Mon, 3 Jun 2024 13:51:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH] stdvga: fix screen blanking
Message-ID: <h5xbnhrqfhuvqf5xef34h3rnfybwb5de4mxhlgta32vpuvqtpo@s7kx5h6c4k4x>
References: <20240530110417.1724583-1-kraxel@redhat.com>
 <CAJ+F1CJMjq6SSwuW3E3CweVH_ftGJL0qF3QqKgGQMvt=_t8tKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJMjq6SSwuW3E3CweVH_ftGJL0qF3QqKgGQMvt=_t8tKg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 03, 2024 at 02:24:52PM GMT, Marc-André Lureau wrote:
> Hi
> 
> On Thu, May 30, 2024 at 3:05 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> 
> > In case the display surface uses a shared buffer (i.e. uses vga vram
> > directly instead of a shadow) go unshare the buffer before clearing it.
> >
> > This avoids vga memory corruption, which in turn fixes unblanking not
> > working properly with X11.
> >
> > Cc: qemu-stable@nongnu.org
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2067
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  hw/display/vga.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/display/vga.c b/hw/display/vga.c
> > index 30facc6c8e33..34ab8eb9b745 100644
> > --- a/hw/display/vga.c
> > +++ b/hw/display/vga.c
> > @@ -1762,6 +1762,12 @@ static void vga_draw_blank(VGACommonState *s, int
> > full_update)
> >      if (s->last_scr_width <= 0 || s->last_scr_height <= 0)
> >          return;
> >
> > +    if (is_buffer_shared(surface)) {
> >
> 
> It might be a good time to rename this function. surface_is_borrowed() ?

"shared" means memory shared between guest and host (typically vga vram).

I doubt using the term "borrowed" instead clarifies things much,
especially as this isn't an rust-style "borrow" (which I guess you are
referring to).  Nothing prevents the host from writing to the surface as
the bug clearly shows.  Also qemu is a C project, so I wouldn't expect
developers being familiar with rust semantics and terminology.

> > +        /* unshare buffer, otherwise the blanking corrupts vga vram */
> > +        qemu_console_resize(s->con, s->last_scr_width,
> > s->last_scr_height);
> 
> If we want to guarantee that a new surface is created, we should leave a
> comment on qemu_console_resize(), 

I left the comment there exactly because it isn't obvious that the
qemu_console_resize() will create a new (not shared) surface.  So not
sure what exactly you are suggesting here?

> or perhaps make it take a new/alloc argument?

Right now qemu_console_resize() does a bunch of checks to figure
whenever it can take a shortcut (because width + height didn't change)
or not.

We could certainly pass a boolean in instead and have the caller decide
that way.  Didn't check whenever that makes sense, and IMHO that is well
beyond the scope of a 3-lines bugfix.

   kraxel@sirius ~/projects/qemu# git grep qemu_console_resize | wc -l
   35

take care,
  Gerd


