Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA5CFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABVx-0007aW-MK; Tue, 07 Apr 2026 14:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTe-0002em-Iw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA5GK-00068Y-IW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 08:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775563829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gziNJcf1W1wvXNMbicWw4EFlLerE4qtzxYMH7DZX9/U=;
 b=jEtUP8NQqi2HeFi7cxjATYveDEf4ry7VHgtU1CRrQ7WjiPbMVPCjLdedA9fHPyhXbNQKy0
 hHLHtEFwq12aqeNVrbPqPPI0i19ZvzkjEDiQm10+lPISax7NxHVbjs5q/U8MtoT/BVjBUG
 eLue42SyzJYzSiCsR6/Gt3XpNhzlxh8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-4jpfw9dRMgWO4TKJ_qyuPw-1; Tue, 07 Apr 2026 08:10:27 -0400
X-MC-Unique: 4jpfw9dRMgWO4TKJ_qyuPw-1
X-Mimecast-MFC-AGG-ID: 4jpfw9dRMgWO4TKJ_qyuPw_1775563827
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35641c14663so5261850a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 05:10:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775563827; cv=none;
 d=google.com; s=arc-20240605;
 b=FXTSbbLtVK7o29CHfkjxpYp9vqvY7bB5HCt46KzzmS7PDqX1O/kJLUYag2FRpm/csU
 uDG+bsCQBYPIZMqwTrKdmTV64wSaIl2iymwGjybqgwf1EuWgx961ri7IV8w6eZQoxFP2
 SenRVVSKRqBSbQGNYHTQMUfQoRebijSE2PPrLOvtvS2uzoheuNU62lI0bzQSWFmNjI5i
 u7BT/2MdkvL9GoNcRWH+1QLmJLacWOkVdKiYGdpaWDjeEI0y98GIGbOf6O5L8GPnLM/p
 /4xbHns4sVgxMtXPOcbP71GIoYXT+2+yt/wp8ExmB7QXDNG1ObEQ1k4aHnet4GyfD5pR
 5Svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gziNJcf1W1wvXNMbicWw4EFlLerE4qtzxYMH7DZX9/U=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=VBlafCSabegVPd/IikNUaPouvkyxMHgA7h7Z4SA/UaFF5IlE8a+q8pOeLdk3XkqkNq
 tJ/0Pg5AYuny8Pg77OG2aB/lnIoxQAHoxImbDJMBg4W50RCZ0v66lqxaDsdyS/F1ITrN
 0si2q/qsESyObi3TV3PghOfL9nhDY6N/dB/SvkJ0OM+1syUyGqeyIuUTwcb5BE96PAWm
 np56jdAdC/PV1YNIpPgkMRgR3X2dbueWr/JenUN9yy7mdiJSY759SqjksCj4eLiCad+z
 jaIMEy9PnRd0gNdGElDoexTlJtOp3mgsYmu7QUOD1mXRxfYI37Jl+tpUOaNr1G2P2DPV
 8SVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775563827; x=1776168627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gziNJcf1W1wvXNMbicWw4EFlLerE4qtzxYMH7DZX9/U=;
 b=VW/WrtAXIbaTeLE+wOloEQDlb+AXTeEkrwIv0yVzktHPnUC/R9+DSd+KgJreIl44FU
 3ebUmOLa5UgrSAe+UAN7o9lXWlBIT4egrI5oJ9bVYxjFQHwNV6GsSHeJmjyT7XIeoSe6
 pzxC4xeOM+5vpCIuRQbeBB5Aoozwyv5p6HXIyeDQJiXxjNIK44cMksfo+jtYGhuvFWA0
 SZs7M8/NiTldl4yag4O8WLINvdj4GqPrtg69P/5VZL+zx5EiCK6r73D6Elm+WTxnKflT
 cpUmjC4FvfosuS7cUntEwNcF1HBKc1p39K2BSAbjRJCTSzujWOhYKtK4Sfz+B+5jmfG0
 c6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775563827; x=1776168627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gziNJcf1W1wvXNMbicWw4EFlLerE4qtzxYMH7DZX9/U=;
 b=pSPuKJdRTTIPK3SmYdu7BrFaLHgOu8FLSm2SeRH/hnNiAxS67L11xQ1dMP3P1bShxq
 /LxipyE3MHwrNbQ89tuAL2dUv29IDUdBXvrlcE+wUaabnRnxWAaTAIJBsAV11kTOz7Jd
 DIjdLQZhur4faY5o6xqsAev6gEQtfKHZBP6zjygFGbaTpAjSfzv66XODOrbojSxaLd1+
 /hvvU4OCBrwApZJS1tCnd5/bDFTxrtYm3LSoinOgR2JoIZEtdMIRuV48FQK7+ncPIEPF
 1JzFC9cGdB0nPph0UB3kLp1w9bF4dcpf+0rxf3bYevi4T9UzmQtmcjinDXnZGWLUUvN/
 tFAw==
X-Gm-Message-State: AOJu0YzE2QOorqcBrnJGu0to8WK11vgir8RiFf5LMk3W5EgJEpnUK9ai
 Drnf1ezjMQ7h3e0lEQgRr//p0j82XS5OPdxPonZNzP1ayB3S70Jmf1je4THvo95QToPX4f1kPF/
 1hImAyrZQ87Eb62mDlEnPM3DMAPNWFsfMaLbrgRxGKrG3YmgaWPcorBgMmFjMocqvdpjNWQhQQY
 XcWaMvWjwY7HkaUujST3FUDvl63H7QRUM=
X-Gm-Gg: AeBDieuJWRsrzk1PaCdUpwDpnOLHcQOggf3CeyWXp3YvWnaff/If4XZ85f69AR9Qfh6
 giMvPWIztfu3pEzP0CaDd4D3nUTZnYIHBxuUELdMchCt0PNkZ1HjgRik0w/uYCWZMa5G3kKv8Qi
 rWBoswnugSaFq3H+cpa22ePEGHnjtwzTdjJyA7NQ6Ev3yQFiGaTq2uZha/YlWL+kRjRYxYRZ5VE
 hPDf69iJLXmiaSl0VUDKjZAkbBMBAGrUnvvAe8cczTvLGfYvIUBwDFTwjNl5PSTnfLvXFhJp4N5
 x7CNSvV63VBW7yb9CupIZwU=
X-Received: by 2002:a05:6a20:9192:b0:39f:96e:8eb3 with SMTP id
 adf61e73a8af0-39f2efaf83amr16917102637.37.1775563826660; 
 Tue, 07 Apr 2026 05:10:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:9192:b0:39f:96e:8eb3 with SMTP id
 adf61e73a8af0-39f2efaf83amr16917075637.37.1775563825976; Tue, 07 Apr 2026
 05:10:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-45-48eb1dcf7b76@redhat.com>
 <acKj-I6rEVPPXXry@redhat.com>
 <CAMxuvay1rU30_i7fkUjTUNgZiXqatxBio-WGzDtXTCAKBS+UNg@mail.gmail.com>
 <adTGflpDhFIB4W30@redhat.com>
In-Reply-To: <adTGflpDhFIB4W30@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 16:10:13 +0400
X-Gm-Features: AQROBzDwqHIvFyp96HaQeJ6kJjN0-opwel165WLTOSbStgZVO2Qij8DiDkALolY
Message-ID: <CAMxuvayJC2HxEdCpo2AFfyzKeH3Tbnr2cFjeZ6rbiKGYMs+vJg@mail.gmail.com>
Subject: Re: [PATCH 45/60] ui/vnc: fix vnc_display_init() leak on failure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Tue, Apr 7, 2026 at 12:55=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sat, Apr 04, 2026 at 06:19:49PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Tue, Mar 24, 2026 at 6:47=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > >
> > > On Tue, Mar 17, 2026 at 12:50:59PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Do not add the display state to the vnc list, if the initialization
> > > > failed. Add vnc_display_free(), to free the display state and assoc=
iated
> > > > data in such case. The function is meant to be public and reused in=
 the
> > > > following changes.
> > > >
> > > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > > ---
> > > >  ui/keymaps.h |  1 +
> > > >  ui/keymaps.c | 13 ++++++++++---
> > > >  ui/vnc.c     | 30 ++++++++++++++++++++++++++----
> > > >  3 files changed, 37 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/ui/keymaps.h b/ui/keymaps.h
> > > > index 3d52c0882a1..e8917e56404 100644
> > > > --- a/ui/keymaps.h
> > > > +++ b/ui/keymaps.h
> > > > @@ -54,6 +54,7 @@ typedef struct kbd_layout_t kbd_layout_t;
> > > >
> > > >  kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> > > >                                     const char *language, Error **e=
rrp);
> > > > +void kbd_layout_free(kbd_layout_t *k);
> > > >  int keysym2scancode(kbd_layout_t *k, int keysym,
> > > >                      QKbdState *kbd, bool down);
> > > >  int keycode_is_keypad(kbd_layout_t *k, int keycode);
> > > > diff --git a/ui/keymaps.c b/ui/keymaps.c
> > > > index 2359dbfe7e6..d1b3f43dc8a 100644
> > > > --- a/ui/keymaps.c
> > > > +++ b/ui/keymaps.c
> > > > @@ -178,6 +178,14 @@ out:
> > > >      return ret;
> > > >  }
> > > >
> > > > +void kbd_layout_free(kbd_layout_t *k)
> > > > +{
> > > > +    if (!k) {
> > > > +        return;
> > > > +    }
> > > > +    g_hash_table_unref(k->hash);
> > > > +    g_free(k);
> > > > +}
> > > >
> > > >  kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> > > >                                     const char *language, Error **e=
rrp)
> > > > @@ -185,10 +193,9 @@ kbd_layout_t *init_keyboard_layout(const name2=
keysym_t *table,
> > > >      kbd_layout_t *k;
> > > >
> > > >      k =3D g_new0(kbd_layout_t, 1);
> > > > -    k->hash =3D g_hash_table_new(NULL, NULL);
> > > > +    k->hash =3D g_hash_table_new_full(NULL, NULL, NULL, g_free);
> > > >      if (parse_keyboard_layout(k, table, language, errp) < 0) {
> > > > -        g_hash_table_unref(k->hash);
> > > > -        g_free(k);
> > > > +        kbd_layout_free(k);
> > > >          return NULL;
> > > >      }
> > > >      return k;
> > >
> > > This is fixing a memory leak in init_keyboard_layout that's separate
> > > from the VNC leak, so these ui/keymaps.c should be their own commit.
> >
> > ok
> >
> > >
> > >
> > > > diff --git a/ui/vnc.c b/ui/vnc.c
> > > > index 763b13acbde..115ff8a988e 100644
> > > > --- a/ui/vnc.c
> > > > +++ b/ui/vnc.c
> > > > @@ -3421,6 +3421,8 @@ static void vmstate_change_handler(void *opaq=
ue, bool running, RunState state)
> > > >      update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BA=
SE);
> > > >  }
> > > >
> > > > +static void vnc_display_free(VncDisplay *vd);
> > > > +
> > > >  void vnc_display_init(const char *id, Error **errp)
> > > >  {
> > > >      VncDisplay *vd;
> > > > @@ -3430,8 +3432,9 @@ void vnc_display_init(const char *id, Error *=
*errp)
> > > >      }
> > > >      vd =3D g_malloc0(sizeof(*vd));
> > > >
> > > > +    qemu_mutex_init(&vd->mutex);
> > > >      vd->id =3D g_strdup(id);
> > > > -    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > > > +    vd->dcl.ops =3D &dcl_ops;
> > > >
> > > >      QTAILQ_INIT(&vd->clients);
> > > >      vd->expires =3D TIME_MAX;
> > > > @@ -3445,22 +3448,22 @@ void vnc_display_init(const char *id, Error=
 **errp)
> > > >      }
> > > >
> > > >      if (!vd->kbd_layout) {
> > > > +        vnc_display_free(vd);
> > > >          return;
> > > >      }
> > > >
> > > >      vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> > > >      vd->connections_limit =3D 32;
> > > >
> > > > -    qemu_mutex_init(&vd->mutex);
> > > >      vnc_start_worker_thread();
> > > >
> > > > -    vd->dcl.ops =3D &dcl_ops;
> > > >      register_displaychangelistener(&vd->dcl);
> > > >      vd->kbd =3D qkbd_state_init(vd->dcl.con);
> > > >      vd->vmstate_handler_entry =3D qemu_add_vm_change_state_handler=
(
> > > >          &vmstate_change_handler, vd);
> > > > -}
> > > >
> > > > +    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > > > +}
> > > >
> > > >  static void vnc_display_close(VncDisplay *vd)
> > > >  {
> > > > @@ -3504,6 +3507,25 @@ static void vnc_display_close(VncDisplay *vd=
)
> > > >  #endif
> > > >  }
> > > >
> > > > +static void vnc_display_free(VncDisplay *vd)
> > > > +{
> > > > +    if (!vd) {
> > > > +        return;
> > > > +    }
> > > > +    vnc_display_close(vd);
> > > > +    unregister_displaychangelistener(&vd->dcl);
> > > > +    qkbd_state_free(vd->kbd);
> > > > +    qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
> > > > +    kbd_layout_free(vd->kbd_layout);
> > > > +    qemu_mutex_destroy(&vd->mutex);
> > > > +    if (QTAILQ_IN_USE(vd, next)) {
> > > > +        QTAILQ_REMOVE(&vnc_displays, vd, next);
> > > > +    }
> > > > +    g_free(vd->id);
> > > > +    g_free(vd);
> > > > +}
> > >
> > > If we're introducing this we need to answer the earlier questions
> > > in this series about killing off the VNC worker thread, as IMHO,
> > > we should not leave the thread running if we're claiming to be
> > > able to free VncDisplay state.
> >
> > Well, the worker thread is not directly associated with a VncDisplay.
> > Various VncState (VNC clients) share it. We could delay starting it
> > until jobs are actually submitted.
>
> If that lack of association creates problems, perhaps we should
> change that to be more explicit, with one worker thread per
> VncDisplay, or one worker thread per VncState, whichever is most
> effective.
>
> > It is the caller's responsibility to ensure the VncDisplay has no
> > pending clients (and thus jobs) before calling vnc_display_free().
> > I'll add an assert() precondition.
>
> This feels like it is creating a pre-condition that it is impractical
> for the caller to comply with, to avoid having to write code to do
> the right cleanup.
>
>

For all pending clients, the caller should do vnc_disconnect_start()
and main-loop wait until all clients are gone before calling
vnc_display_free().

I am adding a patch to associate the worker thread with the VncDisplay
and tear it down properly.


