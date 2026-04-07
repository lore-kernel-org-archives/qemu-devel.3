Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CD6FF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXB-0008W3-AX; Tue, 07 Apr 2026 14:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wABTt-0003JL-OK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wA2Dg-0004BI-76
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 04:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775552132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i307vjdnMvOiMS2kxs7j0/JEpryl02BimWSj3mm9Bf8=;
 b=Z1qxJtD+gA0hHtwy1qqEOm6VhMM2WPm5g2wk5SrQLPVX1ENWWCAvjGm2w9JC2JpD5QFkMY
 2CDfs1ik24Cc+QukDmYKZleIZxsLZ/5MF3dkkDh0NA4XSp8rKyPFqQfN/3XHzJLrkejIc5
 7i6A+sRr0SdJZhFvd9bfuNFD+wOPvFY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-sEhFfFZlM4Cs8tZEx412BQ-1; Tue,
 07 Apr 2026 04:55:31 -0400
X-MC-Unique: sEhFfFZlM4Cs8tZEx412BQ-1
X-Mimecast-MFC-AGG-ID: sEhFfFZlM4Cs8tZEx412BQ_1775552130
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37B811956060
 for <qemu-devel@nongnu.org>; Tue,  7 Apr 2026 08:55:30 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31C6F300019F; Tue,  7 Apr 2026 08:55:28 +0000 (UTC)
Date: Tue, 7 Apr 2026 09:55:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 45/60] ui/vnc: fix vnc_display_init() leak on failure
Message-ID: <adTGflpDhFIB4W30@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-45-48eb1dcf7b76@redhat.com>
 <acKj-I6rEVPPXXry@redhat.com>
 <CAMxuvay1rU30_i7fkUjTUNgZiXqatxBio-WGzDtXTCAKBS+UNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvay1rU30_i7fkUjTUNgZiXqatxBio-WGzDtXTCAKBS+UNg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Apr 04, 2026 at 06:19:49PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Mar 24, 2026 at 6:47 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 12:50:59PM +0400, Marc-André Lureau wrote:
> > > Do not add the display state to the vnc list, if the initialization
> > > failed. Add vnc_display_free(), to free the display state and associated
> > > data in such case. The function is meant to be public and reused in the
> > > following changes.
> > >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  ui/keymaps.h |  1 +
> > >  ui/keymaps.c | 13 ++++++++++---
> > >  ui/vnc.c     | 30 ++++++++++++++++++++++++++----
> > >  3 files changed, 37 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/ui/keymaps.h b/ui/keymaps.h
> > > index 3d52c0882a1..e8917e56404 100644
> > > --- a/ui/keymaps.h
> > > +++ b/ui/keymaps.h
> > > @@ -54,6 +54,7 @@ typedef struct kbd_layout_t kbd_layout_t;
> > >
> > >  kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> > >                                     const char *language, Error **errp);
> > > +void kbd_layout_free(kbd_layout_t *k);
> > >  int keysym2scancode(kbd_layout_t *k, int keysym,
> > >                      QKbdState *kbd, bool down);
> > >  int keycode_is_keypad(kbd_layout_t *k, int keycode);
> > > diff --git a/ui/keymaps.c b/ui/keymaps.c
> > > index 2359dbfe7e6..d1b3f43dc8a 100644
> > > --- a/ui/keymaps.c
> > > +++ b/ui/keymaps.c
> > > @@ -178,6 +178,14 @@ out:
> > >      return ret;
> > >  }
> > >
> > > +void kbd_layout_free(kbd_layout_t *k)
> > > +{
> > > +    if (!k) {
> > > +        return;
> > > +    }
> > > +    g_hash_table_unref(k->hash);
> > > +    g_free(k);
> > > +}
> > >
> > >  kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> > >                                     const char *language, Error **errp)
> > > @@ -185,10 +193,9 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> > >      kbd_layout_t *k;
> > >
> > >      k = g_new0(kbd_layout_t, 1);
> > > -    k->hash = g_hash_table_new(NULL, NULL);
> > > +    k->hash = g_hash_table_new_full(NULL, NULL, NULL, g_free);
> > >      if (parse_keyboard_layout(k, table, language, errp) < 0) {
> > > -        g_hash_table_unref(k->hash);
> > > -        g_free(k);
> > > +        kbd_layout_free(k);
> > >          return NULL;
> > >      }
> > >      return k;
> >
> > This is fixing a memory leak in init_keyboard_layout that's separate
> > from the VNC leak, so these ui/keymaps.c should be their own commit.
> 
> ok
> 
> >
> >
> > > diff --git a/ui/vnc.c b/ui/vnc.c
> > > index 763b13acbde..115ff8a988e 100644
> > > --- a/ui/vnc.c
> > > +++ b/ui/vnc.c
> > > @@ -3421,6 +3421,8 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
> > >      update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
> > >  }
> > >
> > > +static void vnc_display_free(VncDisplay *vd);
> > > +
> > >  void vnc_display_init(const char *id, Error **errp)
> > >  {
> > >      VncDisplay *vd;
> > > @@ -3430,8 +3432,9 @@ void vnc_display_init(const char *id, Error **errp)
> > >      }
> > >      vd = g_malloc0(sizeof(*vd));
> > >
> > > +    qemu_mutex_init(&vd->mutex);
> > >      vd->id = g_strdup(id);
> > > -    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > > +    vd->dcl.ops = &dcl_ops;
> > >
> > >      QTAILQ_INIT(&vd->clients);
> > >      vd->expires = TIME_MAX;
> > > @@ -3445,22 +3448,22 @@ void vnc_display_init(const char *id, Error **errp)
> > >      }
> > >
> > >      if (!vd->kbd_layout) {
> > > +        vnc_display_free(vd);
> > >          return;
> > >      }
> > >
> > >      vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> > >      vd->connections_limit = 32;
> > >
> > > -    qemu_mutex_init(&vd->mutex);
> > >      vnc_start_worker_thread();
> > >
> > > -    vd->dcl.ops = &dcl_ops;
> > >      register_displaychangelistener(&vd->dcl);
> > >      vd->kbd = qkbd_state_init(vd->dcl.con);
> > >      vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
> > >          &vmstate_change_handler, vd);
> > > -}
> > >
> > > +    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > > +}
> > >
> > >  static void vnc_display_close(VncDisplay *vd)
> > >  {
> > > @@ -3504,6 +3507,25 @@ static void vnc_display_close(VncDisplay *vd)
> > >  #endif
> > >  }
> > >
> > > +static void vnc_display_free(VncDisplay *vd)
> > > +{
> > > +    if (!vd) {
> > > +        return;
> > > +    }
> > > +    vnc_display_close(vd);
> > > +    unregister_displaychangelistener(&vd->dcl);
> > > +    qkbd_state_free(vd->kbd);
> > > +    qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
> > > +    kbd_layout_free(vd->kbd_layout);
> > > +    qemu_mutex_destroy(&vd->mutex);
> > > +    if (QTAILQ_IN_USE(vd, next)) {
> > > +        QTAILQ_REMOVE(&vnc_displays, vd, next);
> > > +    }
> > > +    g_free(vd->id);
> > > +    g_free(vd);
> > > +}
> >
> > If we're introducing this we need to answer the earlier questions
> > in this series about killing off the VNC worker thread, as IMHO,
> > we should not leave the thread running if we're claiming to be
> > able to free VncDisplay state.
> 
> Well, the worker thread is not directly associated with a VncDisplay.
> Various VncState (VNC clients) share it. We could delay starting it
> until jobs are actually submitted.

If that lack of association creates problems, perhaps we should
change that to be more explicit, with one worker thread per
VncDisplay, or one worker thread per VncState, whichever is most
effective.

> It is the caller's responsibility to ensure the VncDisplay has no
> pending clients (and thus jobs) before calling vnc_display_free().
> I'll add an assert() precondition.

This feels like it is creating a pre-condition that it is impractical
for the caller to comply with, to avoid having to write code to do
the right cleanup.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


