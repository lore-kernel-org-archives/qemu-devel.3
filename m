Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1667CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 19:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMW7I-0006S6-Rs; Mon, 11 May 2026 15:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMW7G-0006Rt-VZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:16:35 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMW7F-0002yu-3y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 15:16:34 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bcd3c190f71so316752766b.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 12:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778526991; cv=none;
 d=google.com; s=arc-20240605;
 b=e3btZjEGs+ID+wFTbLqIQ+b/oiOVTZSqFUkgHwZnz4rQVXWHcuF4eKtm/GeSk8rUsY
 vdUmZoY2viqZt4kMJxuNSf3iq0URybTZeLgkmxfq5JdQREMGxJ5TTLMtQZnKEZeFIvJA
 xFwZrydl+6KCMX2takvCZ1jj/bqv4kKJ24xDg2d70EZ1oZmgGLJSdAJ8jKlJdzjh135L
 fQ1AHKi9poOy+K5ZrAV/AxwFxyJlcRfE8UeUmYC6jX61bQH93x584YEA8lq0GqY+vvCv
 MVb4izTVf0ieZW/3ay9ZaepBp1H9vzFm70ILXrWQiZtHvyRyCw1JPT7RD+i3uNUhKMcQ
 8FnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JOBuJtjKXQTs3DRJN0jDdPCRoaxuGqetCFqldlCJV+g=;
 fh=aYT0Dte32zScO0z23mE8usKARXq3g0LPBKVr7DfkjMg=;
 b=GOuJgI1il1mKew6oeLxlwLv8C60ghmL+2Gw6NvnfQWOtNKs3Dq42+AigFm1v7+N9wj
 phcuhNHiyGj4BeJ5nT5TCyF5J4Ww6qwRe6epjhe1FPSXCl1hsLLACRft4snDYNBbdeXa
 hRu3ikTBD8oYdABS6ATWLClClENJT19CJch4QCbNkPkXY2S5cE/hvre0yww3/lAOHTox
 0TIma8wL/reLPPc0sk7XichyFTHOblaAa+soTjBXkoGuarsFayUAl/TJ6vb7P752G4ey
 mXorj54tkwxvWq3+sscsZAcuaR3s9i4gWOwSuqTzni401yy2HMRTkXhn0Z0A79+8iwKW
 86/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778526991; x=1779131791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOBuJtjKXQTs3DRJN0jDdPCRoaxuGqetCFqldlCJV+g=;
 b=MAN1mfQhQbLVvhfPXI6pad4GAiWPmkm7Ln56wsNdnYdxJdQPIkjRo8Jq3j4S4/FIC1
 nNSW4r3rsAGVJZ/mzADRBUYDP080fpico4ShQU2ab8nzvzct1KThlu+AVi8AkJnjtSs3
 CMn1HcDjWplyXMm8s2LraJnq8sm/OS7pR+AG6vfo+Nx0myBq24td/Sh7lHBZ5ymrp4OF
 58/bp6C263zvsiEIUH/BDf/yQbWky6bAN8zVpZoaq7TpnIutiHr3k3iohzf7HYbiX2Aa
 S/yi6r2EO6sWVjrodUbWN/z7PNT565JiuzW1BtSuVZysr8md4BAm7sfyAtrYETLQpn3l
 vSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778526991; x=1779131791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JOBuJtjKXQTs3DRJN0jDdPCRoaxuGqetCFqldlCJV+g=;
 b=COW4Bqeb4+QThHzZ8TL6KTQc4XJgXPgG/b5U3knfCYWtEIk7FBqJj3y38K/765hH1V
 aVawzpiGo7aVUUtxP5jaXZ0Eh/NIhDeNugfYP8SPHV54yXI8OykONu7wKSr5BLGbh4C3
 sDisbpVh0YO06j4Cxhkn5xSeN4tJlX0zLOonjJriH6hLsce4iL0EOb8eHZZhv2MbFRso
 PjC2tLVer6EGn9jkra2Qz7N7KtMvnBPfxfhkX40y+yhc5dtjEUGz9QmoxOl4iU96kH5J
 SSYckU7fTNdRyV0+4vogCtjtOI79acnsidpIsDKfSPgsYUeytiMVQl+qY5at6oLxoWwr
 4C7w==
X-Gm-Message-State: AOJu0YzPsX1qzSdQf7VSP6CGlM39LKi8HX2QNbbK5qotszHBdpMgCMZg
 vAg+nbTfvaLfZvxFLsotl9zzSYQtiEs0GsYR7FZMl+duj9RJn309lC3oB7XPZF45vskBVJnxM3w
 g5dhz06jX2YhmnIHuc1JUyVpMWLQY/5A=
X-Gm-Gg: Acq92OGixHZ+I715RmzjpzFrPchryrbAHGPw99hR4pI6q0a+DzOZ2B04su9dcRxeZH7
 Bt8EgW3q7j3B/8wygeuqgANrn2Hw0Apv9c/NOOTh0R6jdxYmPJw3r3VJ92E3m820sn8cRcdzz11
 kZJ9zt/2I76maco+G7sWyb/4yWZTrkv09E+laeBjt1sRC3u28tNdd8WH9qAdBHXYuXC8XwE7H+l
 M1tBgxfS7rfujAf2RPG2FoshXqr+zctUtX23ehufGuCJ/rvuonIkMPtxpCQYjMLvpRr39/9pjhI
 rIlfn/N1GkPP9wyW8v8=
X-Received: by 2002:a17:907:3e21:b0:bd2:6d40:3f6a with SMTP id
 a640c23a62f3a-bd26d4044e9mr4031066b.45.1778526991269; Mon, 11 May 2026
 12:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-3-zhangckid@gmail.com>
 <20260511181425.GD536999@fedora>
In-Reply-To: <20260511181425.GD536999@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 12 May 2026 03:15:54 +0800
X-Gm-Features: AVHnY4KztAqZKKnQTMX2qR04-Nksc78N8A9xsX8xBz0ILsbhW_EaG0khpUHsC5M
Message-ID: <CAK3tnvL58ZSrydG6soXc1iv058nmizsd25Cqnj5CSWb-B+5-9w@mail.gmail.com>
Subject: Re: [PATCH V7 02/14] iothread: introduce iothread_ref/unref to track
 attached devices
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62b.google.com
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

On Tue, May 12, 2026 at 2:14=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Mon, May 11, 2026 at 10:04:04PM +0800, Zhang Chen wrote:
> > Currently, IOThreads do not maintain a record of which devices are
> > associated with them. This makes it difficult to monitor the
> > workload distribution of IOThreads, especially in complex
> > hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
> >
> > This patch introduces a reference counting and tracking mechanism
> > within the IOThread object:
> >
> > - iothread_ref(): Prepends the device's QOM path to a list.
> > - iothread_unref(): Searches for the device path using a custom
> >   string comparison (g_strcmp0), releases the associated memory
> >   upon a successful match.
> > - holders: A GList storing the QOM paths of attached devices
> >   for runtime introspection.
> >
> > A later commit will add QMP commands to let management applications
> > query the attachment status of IOThreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  5 +++
> >  iothread.c                | 67 +++++++++++++++++++++++++++++++++++++++
> >  qapi/misc.json            | 48 ++++++++++++++++++++++++++++
> >  3 files changed, 120 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index a1ef7696cb..2871b06edc 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -50,6 +50,11 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    /*
> > +     * The list elements are of type IoThreadHolder, which can
> > +     * represent either a QOM path or a block node name.
> > +     */
> > +    GList *holders;
> >
> >      /* AioContext poll parameters */
> >      int64_t poll_max_ns;
> > diff --git a/iothread.c b/iothread.c
> > index 3558535b40..b805e4f97d 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -25,6 +25,66 @@
> >  #include "qemu/rcu.h"
> >  #include "qemu/main-loop.h"
> >
> > +/*
> > + * Add the @holder path to the iothread's tracking list.
> > + * The @holder is a QOM path if it starts with '/', else a block node =
name.
> > + */
>
> It would be cleaner to use IoThreadHolder in the iothread_ref() and
> iothread_unref() APIs instead of a string:
>
>   static void iothread_ref(IOThread *iothread, const IoThreadHolder *hold=
er);
>   static void iothread_unref(IOThread *iothread, const IoThreadHolder *ho=
lder);
>
> That way the caller already uses IO_THREAD_HOLDER_KIND_QOM_OBJECT or
> IO_THREAD_HOLDER_KIND_BLOCK_NODE to clearly distinguish QOM paths from
> block node names. No string parsing is necessary.
>

Good idea.
Will optimize it in the next version.

> > +static void iothread_ref(IOThread *iothread, const char *holder)
> > +{
> > +    IoThreadHolder *h =3D g_new0(IoThreadHolder, 1);
>
> IoThreadHolder vs IOThread. Name it IOThreadHolder for consistency?

OK, will change the "IoThreadHolder" to "IOThreadHolder".

>
> > +
> > +    assert(holder);
> > +
> > +    if (holder[0] =3D=3D '/') {
> > +        h->type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT;
> > +        h->u.qom_object.data =3D g_strdup(holder);
> > +    } else {
> > +        h->type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE;
> > +        h->u.block_node.data =3D g_strdup(holder);
> > +    }
> > +
> > +    iothread->holders =3D g_list_prepend(iothread->holders, h);
> > +}
> > +
> > +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    const IoThreadHolder *holder_node =3D a;
> > +    const char *target_name =3D b;
> > +    const char *current_name;
> > +
> > +    if (holder_node->type =3D=3D IO_THREAD_HOLDER_KIND_QOM_OBJECT) {
> > +        current_name =3D holder_node->u.qom_object.data;
> > +    } else if (holder_node->type =3D=3D IO_THREAD_HOLDER_KIND_BLOCK_NO=
DE) {
> > +        current_name =3D holder_node->u.block_node.data;
> > +    } else {
> > +        /*
> > +         * This should not happen. If it does, current_name remains
> > +         * NULL and g_strcmp0 will handle it safely.
> > +         */
> > +        current_name =3D NULL;
> > +    }
> > +
> > +    return g_strcmp0(current_name, target_name);
> > +}
> > +
> > +/*
> > + * This function removes the @holder from the @iothread's tracking lis=
t.
> > + * The @holder string must match the one used previously in iothread_r=
ef().
> > + * It is a programming error to call this with a @holder that is not
> > + * currently associated with the @iothread.
> > + */
> > +static void iothread_unref(IOThread *iothread, const char *holder)
> > +{
> > +    GList *link =3D g_list_find_custom(iothread->holders, holder,
> > +                                     (GCompareFunc)iothread_holder_com=
pare);
> > +
> > +    assert(link);
> > +
> > +    IoThreadHolder *h =3D (IoThreadHolder *)link->data;
> > +    qapi_free_IoThreadHolder(h);
> > +    iothread->holders =3D g_list_delete_link(iothread->holders, link);
> > +}
> > +
> >  static void *iothread_run(void *opaque)
> >  {
> >      IOThread *iothread =3D opaque;
> > @@ -108,6 +168,9 @@ static void iothread_instance_finalize(Object *obj)
> >
> >      iothread_stop(iothread);
> >
> > +    /* We don't support finalize without holders */
>
> The double-negative is confusing and the logic seems incorrect: we don't
> support finalize while there are holders. A clearer comment would be:
>
>   /* All holders must have called iothread_unref() */
>

Sure.

Thanks
Chen

> > +    assert(iothread->holders =3D=3D NULL);
> > +
> >      /*
> >       * Before glib2 2.33.10, there is a glib2 bug that GSource context
> >       * pointer may not be cleared even if the context has already been
> > @@ -356,6 +419,10 @@ char *iothread_get_id(IOThread *iothread)
> >
> >  AioContext *iothread_get_aio_context(IOThread *iothread)
> >  {
> > +    /* Remove in next patch for build */
> > +    iothread_ref(iothread, "tmp");
> > +    iothread_unref(iothread, "tmp");
> > +
> >      return iothread->ctx;
> >  }
> >
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index c71a5fe657..5fb7dcfcad 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -67,6 +67,54 @@
> >  ##
> >  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': t=
rue }
> >
> > +
> > +##
> > +# @IoThreadHolderBlockNode:
> > +#
> > +# @data: Block node name.
> > +#
> > +# Since: 11.1
> > +#
> > +##
> > +{ 'struct': 'IoThreadHolderBlockNode',
> > +  'data': { 'data': 'str' } }
> > +
> > +##
> > +# @IoThreadHolderQomObject:
> > +#
> > +# @data: Absolute @qom-path.
> > +#
> > +# Since: 11.1
> > +#
> > +##
> > +{ 'struct': 'IoThreadHolderQomObject',
> > +  'data': { 'data': 'str' } }
> > +
> > +##
> > +# @IoThreadHolderKind:
> > +#
> > +# @block-node: Block node name.
> > +# @qom-object: Absolute @qom-path.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'enum': 'IoThreadHolderKind',
> > +  'data': [ 'block-node', 'qom-object' ] }
> > +
> > +##
> > +# @IoThreadHolder:
> > +#
> > +# @type: the kind of I/O thread holder.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'union': 'IoThreadHolder',
> > +  'base': { 'type': 'IoThreadHolderKind' },
> > +  'discriminator': 'type',
> > +  'data': {
> > +    'block-node': 'IoThreadHolderBlockNode',
> > +    'qom-object': 'IoThreadHolderQomObject' } }
> > +
> >  ##
> >  # @IOThreadInfo:
> >  #
> > --
> > 2.49.0
> >

