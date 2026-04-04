Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BC3E88D9D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 14:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w91rF-0004Eg-Fu; Sat, 04 Apr 2026 10:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w91r6-0004AB-Q8
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:20:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1w91r4-00031I-4I
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 10:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775312404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sd9/CID0fSfcM4k1Y8hCEjDTUEBCVE3ETrKtbGnPFg=;
 b=OjpllIZVjGHGYTm7g+XUnJzZ8Q7TO5n+G3UYbUqXLyv+eYp5ORUvPGXFzOBtYarLD+f35z
 C8TeO4TPXxaVqPtG1M/vi+vISZPbQckqJEQs3uCXBwFAtEOtNo1QykoQTSD8cTzYDR0IDD
 1BfUraEqYjtMZ0QWBZp+sWpEnhuO1/Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-iBRWeOWdNgCrFQJEYE2Fhg-1; Sat, 04 Apr 2026 10:20:02 -0400
X-MC-Unique: iBRWeOWdNgCrFQJEYE2Fhg-1
X-Mimecast-MFC-AGG-ID: iBRWeOWdNgCrFQJEYE2Fhg_1775312402
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d9010602bso2563707a91.3
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 07:20:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775312401; cv=none;
 d=google.com; s=arc-20240605;
 b=YQ/aC1qw32MyRpvmfT2qZN2PArMqdumt+VW/D6G98u43xolIgK+zh3Jfl4FdrZsZTw
 zL1NvifAm+Y5lxsV9RQ35RoXt+Ud3fokUTJT6p27u8GPQ0jPR6Tq8GwQnfoyo+Xgluc/
 s6jDn4c6Ly7so4dX2NavhMfx/mX5vItMSwjVYHguiOcGR5SbudnA5ZY3Eel0XcEP6HVX
 bgiF36qWJbKyPOMavN3KTFAEjmCm8z4MW0dxupDNrPCUahmtK7G3KtQrf+ttTXlqODXp
 kZUZDDSyHxsj5zdR8wGpEmJ8EGF7uiMNXjm91QCugZSC6Rb/Ev5Ex+yl3cGCur2t07+e
 gcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2sd9/CID0fSfcM4k1Y8hCEjDTUEBCVE3ETrKtbGnPFg=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=hiJjY9snAXLI/PAS1OZjuZResMd1ciGvt40dhSEd2D0PQVLUclTIdNnGSH9n/7b6CV
 HOrulZhedIOym6yieWnMThgnsC1Zg8iki9EmAZtoO3TJEsV+sYuKUV1aKTWflPJA/9hS
 GlUIkklLLNv5cesOBs2oeAu9ncg5ADcYpTznWqS6x+CpSvMaiQqQyXIYJWoiafkojx07
 jEKWhUafgGMYLqW26sBOTcZO3Yg47XrhYozkLFNznyBVkttuUCWwkn22Y2Ain0PX90Pq
 Qjx2PLzyifdXKV5xmU25cxuFrwopfmsrRhFalrpu9rC6cgZvJu5HZwDCBALxvZ4xAnai
 uJuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775312401; x=1775917201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sd9/CID0fSfcM4k1Y8hCEjDTUEBCVE3ETrKtbGnPFg=;
 b=VtIdYdOUOC7vqi7GsLTkcDB72bhMWnKhRQwasixo0VVlq8i4hwZpsdIwlXU++ccyAu
 +cebfs3XGrnYl/rTY4Vjx7WqREyoh1TFM+/Iw8D59Ec3VLAyD4nCj8eJxHFsbx05lB7+
 g658rmz/KFIqMz896kRr0kcL2Zkp8eGGe0+uAfwCck3TtFAVUIJG+MUFVua50T7shPAq
 J93MQiRqiXLce2M6XBhJQUlfR6gSeue3ko9zqDslJeJ9HRsD4twPk/TbnCcY6Ji0+6gi
 3VY0Qyg7ofn+FqCQhbv5eGZHce2zPRN6qBmJNeSqKm7KHIl01O16cUN7O/b2riECivnh
 lcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775312401; x=1775917201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2sd9/CID0fSfcM4k1Y8hCEjDTUEBCVE3ETrKtbGnPFg=;
 b=K0skrFXrdz6joFwWj9qhO/M533rAzSMtJbYxKdIAqF8ye5IgkU5lmn76+dlmVPMSfC
 WzTDaH6AolwAd3Lstgg7fCIpULHg7ku8eM7PUgk3wLmy2UV5jogpHLkDnlcT2LcIgZDC
 MlmB8a6GCKB0LI5ophSHvkHwX9sAnqR61cwSyq7Eza/sBMRevJ4Fn3wMfKzEd6xvQ4oK
 feggI17UaA7A+Ep57VG5ce52ht2+AbfPbd81UEKjNv7C0aXWgA4sCXk01xQCnq6irsHz
 cj7LS8jvsyha14u13Krxph2jWDc7IRC3vdrf0ZsIoeTizLke083eC4aVQTO3sXdh5VVM
 ZswA==
X-Gm-Message-State: AOJu0YyweX7or2O+XSkVeYFW5nqEII0fBxiOxHSK4LrxB++TQpUTkg7G
 +jLCmQSvWmYDW8QkSsoNaFL+H6lajh3C7sTXzZeArA7ppOPU8PViOakqPkjQeOIidvmPDmywJ2p
 wfD3op88YVVGXLCw1YLxKFAgD/pehXCyOeMbiT1Xh2yVucKU0gOZUdFG9E+CaAr2OxyPZA89lc4
 slUkB4+muLQ5Dgcmy+oxwGILg2ssLo/Xw=
X-Gm-Gg: AeBDietlheJ+coUjCI+F0ZZ98pXs2H+0lve2i7Tq42kLpHYpDSTr16M7sh9cFSq8OSV
 OVLJCFNSyT7An0u0CFmEnN9iQrmOtYT9zuvqMjvTKwZSwCz3jDBe+ZIp33hypW1p/RDzHF0/ZCb
 XF9owROnb7bgRTfVESAd27zD7DYRhe+rQNs9ERIWtf/LWqNA4yYFnEwyIl0NTKXfOZsytVFbCTH
 wun3uH4BOiZSuqIrxrIKj2U1YZoqM+5WyTt86igQrx+ZFAVumRlRB/Wt3vuR9NP4ekQ3FMVluZx
 a8Kt4lNte8QVuEJOuoNAmG8=
X-Received: by 2002:a17:90b:2e0d:b0:35d:982d:96c7 with SMTP id
 98e67ed59e1d1-35de6980b71mr6502090a91.27.1775312401474; 
 Sat, 04 Apr 2026 07:20:01 -0700 (PDT)
X-Received: by 2002:a17:90b:2e0d:b0:35d:982d:96c7 with SMTP id
 98e67ed59e1d1-35de6980b71mr6502064a91.27.1775312400900; Sat, 04 Apr 2026
 07:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-45-48eb1dcf7b76@redhat.com>
 <acKj-I6rEVPPXXry@redhat.com>
In-Reply-To: <acKj-I6rEVPPXXry@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 4 Apr 2026 18:19:49 +0400
X-Gm-Features: AQROBzASSNSL5wqTPxZAs9wR2tv2Ybax9A9k2H_NmFQmcuOXwqk1zyTi3cWV0_I
Message-ID: <CAMxuvay1rU30_i7fkUjTUNgZiXqatxBio-WGzDtXTCAKBS+UNg@mail.gmail.com>
Subject: Re: [PATCH 45/60] ui/vnc: fix vnc_display_init() leak on failure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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

On Tue, Mar 24, 2026 at 6:47=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 17, 2026 at 12:50:59PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Do not add the display state to the vnc list, if the initialization
> > failed. Add vnc_display_free(), to free the display state and associate=
d
> > data in such case. The function is meant to be public and reused in the
> > following changes.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  ui/keymaps.h |  1 +
> >  ui/keymaps.c | 13 ++++++++++---
> >  ui/vnc.c     | 30 ++++++++++++++++++++++++++----
> >  3 files changed, 37 insertions(+), 7 deletions(-)
> >
> > diff --git a/ui/keymaps.h b/ui/keymaps.h
> > index 3d52c0882a1..e8917e56404 100644
> > --- a/ui/keymaps.h
> > +++ b/ui/keymaps.h
> > @@ -54,6 +54,7 @@ typedef struct kbd_layout_t kbd_layout_t;
> >
> >  kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> >                                     const char *language, Error **errp)=
;
> > +void kbd_layout_free(kbd_layout_t *k);
> >  int keysym2scancode(kbd_layout_t *k, int keysym,
> >                      QKbdState *kbd, bool down);
> >  int keycode_is_keypad(kbd_layout_t *k, int keycode);
> > diff --git a/ui/keymaps.c b/ui/keymaps.c
> > index 2359dbfe7e6..d1b3f43dc8a 100644
> > --- a/ui/keymaps.c
> > +++ b/ui/keymaps.c
> > @@ -178,6 +178,14 @@ out:
> >      return ret;
> >  }
> >
> > +void kbd_layout_free(kbd_layout_t *k)
> > +{
> > +    if (!k) {
> > +        return;
> > +    }
> > +    g_hash_table_unref(k->hash);
> > +    g_free(k);
> > +}
> >
> >  kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
> >                                     const char *language, Error **errp)
> > @@ -185,10 +193,9 @@ kbd_layout_t *init_keyboard_layout(const name2keys=
ym_t *table,
> >      kbd_layout_t *k;
> >
> >      k =3D g_new0(kbd_layout_t, 1);
> > -    k->hash =3D g_hash_table_new(NULL, NULL);
> > +    k->hash =3D g_hash_table_new_full(NULL, NULL, NULL, g_free);
> >      if (parse_keyboard_layout(k, table, language, errp) < 0) {
> > -        g_hash_table_unref(k->hash);
> > -        g_free(k);
> > +        kbd_layout_free(k);
> >          return NULL;
> >      }
> >      return k;
>
> This is fixing a memory leak in init_keyboard_layout that's separate
> from the VNC leak, so these ui/keymaps.c should be their own commit.

ok

>
>
> > diff --git a/ui/vnc.c b/ui/vnc.c
> > index 763b13acbde..115ff8a988e 100644
> > --- a/ui/vnc.c
> > +++ b/ui/vnc.c
> > @@ -3421,6 +3421,8 @@ static void vmstate_change_handler(void *opaque, =
bool running, RunState state)
> >      update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
> >  }
> >
> > +static void vnc_display_free(VncDisplay *vd);
> > +
> >  void vnc_display_init(const char *id, Error **errp)
> >  {
> >      VncDisplay *vd;
> > @@ -3430,8 +3432,9 @@ void vnc_display_init(const char *id, Error **err=
p)
> >      }
> >      vd =3D g_malloc0(sizeof(*vd));
> >
> > +    qemu_mutex_init(&vd->mutex);
> >      vd->id =3D g_strdup(id);
> > -    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > +    vd->dcl.ops =3D &dcl_ops;
> >
> >      QTAILQ_INIT(&vd->clients);
> >      vd->expires =3D TIME_MAX;
> > @@ -3445,22 +3448,22 @@ void vnc_display_init(const char *id, Error **e=
rrp)
> >      }
> >
> >      if (!vd->kbd_layout) {
> > +        vnc_display_free(vd);
> >          return;
> >      }
> >
> >      vd->share_policy =3D VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
> >      vd->connections_limit =3D 32;
> >
> > -    qemu_mutex_init(&vd->mutex);
> >      vnc_start_worker_thread();
> >
> > -    vd->dcl.ops =3D &dcl_ops;
> >      register_displaychangelistener(&vd->dcl);
> >      vd->kbd =3D qkbd_state_init(vd->dcl.con);
> >      vd->vmstate_handler_entry =3D qemu_add_vm_change_state_handler(
> >          &vmstate_change_handler, vd);
> > -}
> >
> > +    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
> > +}
> >
> >  static void vnc_display_close(VncDisplay *vd)
> >  {
> > @@ -3504,6 +3507,25 @@ static void vnc_display_close(VncDisplay *vd)
> >  #endif
> >  }
> >
> > +static void vnc_display_free(VncDisplay *vd)
> > +{
> > +    if (!vd) {
> > +        return;
> > +    }
> > +    vnc_display_close(vd);
> > +    unregister_displaychangelistener(&vd->dcl);
> > +    qkbd_state_free(vd->kbd);
> > +    qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
> > +    kbd_layout_free(vd->kbd_layout);
> > +    qemu_mutex_destroy(&vd->mutex);
> > +    if (QTAILQ_IN_USE(vd, next)) {
> > +        QTAILQ_REMOVE(&vnc_displays, vd, next);
> > +    }
> > +    g_free(vd->id);
> > +    g_free(vd);
> > +}
>
> If we're introducing this we need to answer the earlier questions
> in this series about killing off the VNC worker thread, as IMHO,
> we should not leave the thread running if we're claiming to be
> able to free VncDisplay state.

Well, the worker thread is not directly associated with a VncDisplay.
Various VncState (VNC clients) share it. We could delay starting it
until jobs are actually submitted.

It is the caller's responsibility to ensure the VncDisplay has no
pending clients (and thus jobs) before calling vnc_display_free().
I'll add an assert() precondition.

>
> > +
> > +
> >  int vnc_display_password(const char *id, const char *password, Error *=
*errp)
> >  {
> >      VncDisplay *vd =3D vnc_display_find(id);
> >
> > --
> > 2.53.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


