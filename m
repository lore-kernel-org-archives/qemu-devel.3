Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B7FCEE8A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:39:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDEC-000713-Li; Wed, 25 Feb 2026 06:38:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vvDEB-00070i-Jo
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:38:51 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vvDE9-0008LL-Hb
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:38:51 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-65f9a875eabso539766a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772019528; cv=none;
 d=google.com; s=arc-20240605;
 b=Zd3WW1QY7Am1GcGFvtQs6lFVoewox29PzbYkVxZpVGy9YDQuhqPbHQoPHn1A8jFyxL
 Bcp7ozpZ+EDyNOYxzj+QEFe0vXMOZzgd+8LgEmc7DpxA1MX8BLKGbreCjpJQSRaxQwat
 t4yTy/dvySnFETx5ijV3QxYonGQwtVtMAcUsNG622Ie8za0wGAETjchTKy+bRoD0XPXO
 JLD5UCA2BhhVp0HsWuZqbvC4rmYIXS24xriedL1FxsAOAN8hLhpVn2J4WESFpyOTl9Tx
 n/Bax0XquWi3mqhSeZweyYLQ6b9+FvYN5JY+lPdz9xKfK1SkIRxBafh6pj4hFph5z+CM
 0+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c2f46g0r/403OHRPfAI6BUM+n1xC0eON63LuCM9szSc=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=jv3NWBMFYoUQUrjC3S4bcGuvj20n9QBae96zFQlPokCSONvT7Oky5BZV6Q4uEJzNKb
 X4erVwFb3I9goFfvj3VUZGVmRr1svFS61Uqu7gJAJr532Uzv/OkyapCtoz6RUkOOJtbd
 u+lc+b3+p8g/mwcvR1Nf0uw9a39BFoLH5I4tChf3AmPWsJoa6RdeBaUpEWZMaxiFqZb0
 V3WcguxNFfPLAniHjoxYK0mH61l+Pbio3J33y5C0imG6dlOSx+WQn5NbHaTjarHkcleP
 w2uzw+BLPZQOI9af+ER4GW6dc9/HnK3ooWhcZ2LR234FmNjP6GfecodxqaRMsLR/x5ky
 HJOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772019528; x=1772624328; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2f46g0r/403OHRPfAI6BUM+n1xC0eON63LuCM9szSc=;
 b=c6o5E8JuNYgr2x+Jmp4Jmuz7j7Bmu/jGos/NpKExXGWpQ4gQrzBXdWkflj3OdvxvpI
 Ugpw6gg1E9lny7Sz0Dn0CVXx5EU4SQxFfMUG7FSJaBNehvZ7b/i5fus/VnTlerlKkdql
 yp+P2Ye1X0szthmed82kztPHopVDhGwpnJcdiR2T1/QtzPOn/buavbjs+WhhWU1T5hho
 P+s5EV1+H2QYaEynULegW7oVWmTqN1fEh5KqzPiGeirDn05gV2TUcnt2kNXNJEve2wSK
 StwpYFWPARE3ZGHaRDxTxaYiXGEPhupHlPdBpZVd7yuzy+K6zk3qrJlhClQAE+MnIMBE
 1CwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772019528; x=1772624328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c2f46g0r/403OHRPfAI6BUM+n1xC0eON63LuCM9szSc=;
 b=xHbxmaBzzib+TiDZ4CLnMwGcxuh2yCpVRvWPryezrD5j2qb+2JMz0m2GbCg0o43Fjn
 p8940YvANwDiuTRKZznDsNzaqb6M4cvKZ3vL9WcQLmIoyDwcbyFGh2TZ+EaYzizGz2G8
 9kunpZD/ucsYy+Z1hMxaJbSIYDSKmeHByZYoPJy/HAVNRLZp4ErvJXg4ZFapCnJ0n6Zb
 DPh9cc2gNw+76FM32xWasgoztO7sWx47aoBdHkZiCkokMenc6rJKBslqbsoT54BLQQKK
 L8Xn1twy9Xsov32TGr/pMVC86mN3fwapisUpaBWFz2Zo5JDmgH2zKbbj/IkXedqs7Zpu
 eObA==
X-Gm-Message-State: AOJu0YyBmERcjJMyYroMK1I69MjKf1j3805RxTX0fcurE+2in00iyxpp
 NYZUlRY6OQhOMNFRIQKSRRTxneIwSUDh4TyxYPWpY+8UwpQasF2zAPSkstHhKqfKbi4Y+w7NK4X
 hM/Q4gZdJzpFvpqJtEBMEqgAotwm/jPg=
X-Gm-Gg: ATEYQzxDNBCyznY9bT9ZpRnTmdQ5cUQCSn/QenIlHph1j16F3NzQ2kQkZ8a6WQx3Y1/
 i2M4VOK3HMOxnqSU/c3OBKM0aPzXLkZ2mOdJG4Y9pL+lX/FmcIDsQWWPobAMsEzvKSxAfJoa9dV
 jqpcB7GnkDMncNFP4gU2rAprSjWbRp0lvh0cRB7vwHDuCzeBPxbpKwUU/ovQTUZkV8Fj7o3zqHE
 uWfs/FbwrNVZCrvLF1HVWc6YPtlbdi48v9cZa/uZrnAh+dcQCkP6WPJiOeCtru+6ftBU9iJ41OE
 dNM83CdK
X-Received: by 2002:a05:6402:3547:b0:658:191a:31b9 with SMTP id
 4fb4d7f45d1cf-65ea4efb7dfmr8824815a12.27.1772019527547; Wed, 25 Feb 2026
 03:38:47 -0800 (PST)
MIME-Version: 1.0
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-2-zhangckid@gmail.com>
 <20260218205328.GB620422@fedora>
In-Reply-To: <20260218205328.GB620422@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 25 Feb 2026 19:38:10 +0800
X-Gm-Features: AaiRm535cX7LMLDOvQ9w3PbirdDQzzhvXqou0Rdx5sLw9CC6g2HKrqvXrUBA1rI
Message-ID: <CAK3tnvKB+ZQPXjts2LZqji5v2fgbM0AcQfE=WS3eSTPnuVW3hg@mail.gmail.com>
Subject: Re: [PATCH V4 2/4] iothread: introduce iothread_ref/unref to track
 attached devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 19, 2026 at 4:53=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Feb 14, 2026 at 01:16:20AM +0800, Zhang Chen wrote:
> > Currently, IOThreads do not maintain a record of which devices are
> > associated with them. This makes it difficult to monitor the
> > workload distribution of IOThreads, especially in complex
> > hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
> >
> > This patch introduces a reference counting and tracking mechanism
> > within the IOThread object:
> >
> > - iothread_ref(): Increments the attachment counter and prepends the
> >   device's QOM path to a list. Note: The IOThread takes ownership of
> >   the passed 'holder' string.
> > - iothread_unref(): Searches for the device path using a custom
> >   string comparison (g_strcmp0), decrements the counter, and
> >   releases the associated memory upon a successful match.
> > - attached_cnt: Tracks the number of active device attachments.
> > - attached_dev: A GList storing the QOM paths of attached devices
> >   for runtime introspection.
> >
> > This infrastructure allows management tools and QMP commands to
> > query the attachment status of IOThreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  4 ++++
> >  iothread.c                | 35 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index e26d13c6c7..4a2ffdb9bd 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -33,6 +33,8 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    int attached_cnt;
>
> Is this field necessary given that the user can see the list of holders?

Will remove it in next version.

>
> > +    GList *attached_dev;
>
> IOThreads are general eventloop concept in QEMU and not limited to
> device emulation. Non-device code may also wish to add itself (e.g.
> block/export/export.c). Please call this GList *holders.

OK, will change the name next version.


>
> This raises questions:
> - Is it mandatory for users of the IOThread's AioContext to add
>   themselves?
> - How does it relate to object_ref()/object_unref()?
>
> I would prefer to set things up as follows:
>
> It is mandatory for users of the IOThread's AioContext to add
> themselves. This is enforced by modifying iothread_get_aio_context() to
> take a string argument with the name of the holder.
>
> iothread_get_aio_context() is also extended to call
> object_ref(OBJECT(iothread)). This guarantees that the IOThread and its
> AioContext remain alive as long as there is a holder. (Some users
> already do this themselves, so I think it makes sense to build this
> behavior into the API so that all users get it automatically.)
>
> A new iothread_put_aio_context() function is introduced to remove the
> hold and object_unref(OBJECT(iothread)).
>
> All existing callers of iothread_get_aio_context() need to be updated to
> pass in their QOM object path as the name of the holder, remove their own
> object_ref() call (if present), and call iothread_put_aio_context() at
> the appropriate point.

Make sense, I will implement it in next version.

>
> >
> >      /* AioContext poll parameters */
> >      int64_t poll_max_ns;
> > @@ -48,6 +50,8 @@ char *iothread_get_id(IOThread *iothread);
> >  IOThread *iothread_by_id(const char *id);
> >  AioContext *iothread_get_aio_context(IOThread *iothread);
> >  GMainContext *iothread_get_g_main_context(IOThread *iothread);
> > +void iothread_ref(IOThread *iothread, const char* holder);
> > +void iothread_unref(IOThread *iothread, const char* holder);
> >
> >  /*
> >   * Helpers used to allocate iothreads for internal use.  These
> > diff --git a/iothread.c b/iothread.c
> > index caf68e0764..b869637497 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -36,6 +36,41 @@
> >  #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
> >  #endif
> >
> > +/*
> > + * Increment iothread's reference count,
> > + * and add holder device path to the list.
> > + */
> > +void iothread_ref(IOThread *iothread, const char *holder)
> > +{
> > +    iothread->attached_cnt++;
> > +    iothread->attached_dev =3D g_list_prepend(iothread->attached_dev,
> > +                                           (gpointer)holder);
>
> It's safer to g_strdup(holder) so the caller doesn't need to worry about
> the lifetime of the argument. This is not a performance-critical code
> path so the cost of the strdup is acceptable.

OK.

>
> > +}
> > +
> > +/*
> > + * Decrement iothread's reference count,
> > + * and delete holder device path from the list.
> > + */
> > +void iothread_unref(IOThread *iothread, const char *holder)
> > +{
> > +    if (iothread->attached_cnt > 0) {
> > +        GList *link =3D g_list_find_custom(iothread->attached_dev,
> > +                                         holder, (GCompareFunc)g_strcm=
p0);
> > +
> > +        if (link) {
> > +            g_free(link->data);
>
> iothread_ref() originally took a _const_ char * so it must not free the
> pointer here. The reason why the compiler didn't complain was because
> iothread_ref() cast the pointer to non-const gpointer. In any case, as
> mentioned above, it's probably best to use g_strdup() and avoid placing
> constraints on the lifetime of the caller's string.

OK, will use the g_strdup() in ref side next version.

>
> > +            iothread->attached_dev =3D g_list_delete_link(iothread->at=
tached_dev,
> > +                                                        link);
> > +            iothread->attached_cnt--;
> > +        } else {
> > +            error_report("iohtread_unref can't find device. attached_d=
ev=3D%s",
>
> "iohtread" typo here and in the line below.

Good catch.

Thanks
Chen

>
> > +                        holder);
> > +        }
> > +    } else {
> > +        error_report("iohtread_unref counter error. attached_dev=3D%s"=
, holder);
> > +    }
> > +}
> > +
> >  static void *iothread_run(void *opaque)
> >  {
> >      IOThread *iothread =3D opaque;
> > --
> > 2.49.0
> >

