Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372B3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we5xk-0002oG-S7; Mon, 29 Jun 2026 02:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1we5xg-0002nY-TH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:59:22 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1we5xa-0001aZ-20
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 02:59:17 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c12645364a5so88921566b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 23:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782716352; cv=none;
 d=google.com; s=arc-20260327;
 b=HHt/Ugj/Wln/Zm/9UL7Ex5zP8eksd0OU56F8irxgwaMATWeT780dvhDVdwnwC2mUVT
 9F6QUdbecWhZ5oQOJesCAdjrSahnSxjzXVK4anrUfBFdxKcFuD3iqk4/2vpxIrLI+yu7
 sZrm2ebzn/I8io3Jivz8T9yHeEl3QuUKv4IPSGYOPtLDNoHXhfrPAyKEVhoc4uWPbsem
 80VrpQ1SGlyYwlXMxG9C9mYxgXFQ1am9Fej8BGSL6PmTNJAfqyVJN14q4TrkOGcEUK8B
 ezEgILqAbtgE+kGo+7/N7nXNXU2swasOGw4VHD3wvxzrgqG2aoKNh4js8M/xGkcvZCd3
 iInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BZxkkY/dp9RRaaOZpfRHysVbXlydr1Zcw9rHjYUuQPg=;
 fh=hCe7fhTvWgm7aze1oINXwc4Q2ljHDCj1vM1faYlyM2g=;
 b=TMWBYMJzW81RJu0ASCxZA5Li4rvrXDp6dESUkUwsUvOtHQj0f3G2IZAWNaW+Ol75C7
 0ltwE8kWkl8P/wyLWkEnsGhMl1o7JN9AddRe2O5EXDN1d6STWfunvKsrHYWWPHLN6lr8
 BHYx07zAo1v+0FYTcpdJj6ysDnE3MOzVhwQZqZPsduyc/ceiI8rtsBqisaMqgmO7r2SR
 D3Xxywto9lOZDOJP9k6SkKEwq2aWUdOSapGnZhYR1IWbZPk+9a1iwgfJlQGtZFdhiKBG
 ZSMUxjP1jtUoJTnNhhjyRSTQ5geey8689xolo6pMdGnRk6OLgbZlvWcXE0RN+IvYO1FM
 HdCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782716352; x=1783321152; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZxkkY/dp9RRaaOZpfRHysVbXlydr1Zcw9rHjYUuQPg=;
 b=LVGMkYknxEV66rB/ov+8TkD/zprDPfMjkJd20BGtEShZp1Vjk3u2qkaEHanWUuRBHt
 Sy1e5m0BmIWSH5xxo5GWSCWU79ZQr3NY5bQBKl+02zP0NluFll5Ctl6L2YWpMrfQvYtp
 nC0j3JDwxQH2nZrcMBLpaRr3aKPBCj3U/TfRM6bo6sPevTcm5FGiqdTh0G2KsJo/98D3
 y0vGV8LkjmAwnXbEu96pkKpOptjafNbVnNvJlK6CkOeKEXHJdZmEu1Ib1AoxlX+zI+KD
 BMOO+9pR5V80ydXisygH6bY/aNfQfO2N47Euk+9cRA3Hpd5Cm+XZ2kj97t56FAZpZHv1
 LXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782716352; x=1783321152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BZxkkY/dp9RRaaOZpfRHysVbXlydr1Zcw9rHjYUuQPg=;
 b=mxKNB7ZwlEwunUdYIh4j+22Kt1fHRVp0bpv392o44rGfZ+rr6lcIYFoZFUcFO74iPo
 NgIgikZQgyD2+DBdoZv3VJFMkEgaIz5zrc+i6BVtV+ZYqR3na7Dl1ZaSpeMDqgTsA7MK
 R8BN4JCwgcvcUuoLXCzXTf3HFm5br86avckVGY0+cEY/XVz3vD8jeb+8I6oMhJupe2MJ
 +yrE/tdCTgF6cJsqXHpvqJXb6VrOQUTWfCOwFFqvT7pjtwfiC+pqAkrmegk0kF7q1Ijz
 f12/O+J+HzI6a5q6o4LvRPcmtyOW9Y0DKZ9R65WuCPlfjFCPp3drNEN6qmmYWaiBm/MB
 xuEw==
X-Gm-Message-State: AOJu0Yy5KPHWzxOJFJXaknMH+eeOlReA/5kXwdxXjF0gqqBlJM4COLYD
 CrWGrAia5W9hOwSqm1NjpU0HcpSkv3WOp+y9GPlGCxZ8I5lWnvL/CdmIrEQFh/YqAd3Y1xPLf3v
 fMNKU7hkIDTGD5JidKUGgbYHpBWZtnlA=
X-Gm-Gg: AfdE7cmIghMABUev/+LnAQ4fV1ObGPVaW8A83WSzAcavYlhJNlc7+/ElAze5FEIZDAm
 eSFtvNECCGE1s1rH9k+oWC7NI/5EvB9YDvQkfqxLVeYkDbyNzZDZgv4acS9Zr2uewRG3hyQWucn
 basyPnZKKt150ypoHCS8ApnUNpGZuy+8qGB1o8+xv37SJ1HoZMjQWx9Jk1TXRDnck2I3gSfrpdB
 skowf5phum6jYcxzZPmeyjal7NyThzqp4XD0FOoitEnovasa0TgToEONKno4oyWguFBuiT+Aw==
X-Received: by 2002:a17:907:7a94:b0:c12:5f4e:4b17 with SMTP id
 a640c23a62f3a-c125f4e4d98mr149747766b.11.1782716351793; Sun, 28 Jun 2026
 23:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-3-zhangckid@gmail.com>
 <87o6gx1yg4.fsf@pond.sub.org>
In-Reply-To: <87o6gx1yg4.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 29 Jun 2026 14:58:35 +0800
X-Gm-Features: AVVi8Cdk13AnNBgbLIWkm8hRq9v_8KrXo4wBdhOaXiBmE4JRJEpuszPW629AGUQ
Message-ID: <CAK3tnv+YGdTPOgGSwz-KO22E_-UaaABmEKwTqrsuE7no91pXEQ@mail.gmail.com>
Subject: Re: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to track
 attached devices
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
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

On Fri, Jun 26, 2026 at 4:46=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Looks like you missed my review of v8.  I'm replaying my review
> comments.

Oh, my fault, very sorry about that, focused on other patch's comments fixe=
s.
Thank you for your detailed explanation.

I will address your comments in next version.
Expect the:
  IOThreadHolder *h =3D QAPI_CLONE(IOThreadHolder, holder);

Same as your estimate, this doesn't seem worthwhile.

And the same issue in the [ PATCH V8 14/15] comments:
static IOThreadHolderList *iothread_get_holders_list(IOThread *iothread)

> If iothread->holders was a IOThreadHolderList instead of a GList, this
> loop could be QAPI_CLONE(IOThreadHolderList, iothread->holders) instead.

If we change the GList *holders to the IOThreadHolderList *holders,
This means that we have to reimplement the  GList related API,
for example the "g_list_prepend", "g_list_find_custom" and the
"g_list_delete_link"

This doesn't seem worthwhile.

Thanks
Chen



>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Currently, IOThreads do not maintain a record of which devices are
> > associated with them. This makes it difficult to monitor the
> > workload distribution of IOThreads, especially in complex
> > hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
> >
> > This patch introduces a reference counting and tracking mechanism
> > within the IOThread object:
> >
> > - iothread_ref(): Prepends the device's IOThreadHolder to a list.
> > - iothread_unref(): Searches for the IOThreadHolder using a custom
> >   string comparison (g_strcmp0), releases the associated memory
> >   upon a successful match.
> > - holders: A GList storing the IOThreadHolder of attached devices
> >   for runtime introspection.
> >
> > A later commit will add QMP commands to let management applications
> > query the attachment status of IOThreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  5 +++
> >  iothread.c                | 94 +++++++++++++++++++++++++++++++++++++++
> >  qapi/misc.json            | 61 +++++++++++++++++++++++++
> >  3 files changed, 160 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index a1ef7696cb..b9207ad829 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -50,6 +50,11 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    /*
> > +     * The list elements are of type IOThreadHolder, which can
> > +     * represent either a QOM path or a block node name.
> > +     */
>
> You forgot monitors.  Stefan spotted this as well, and I agree with the
> fix he suggested.

Yes, my fault. will fix in the next version.

>
> > +    GList *holders;
> >
> >      /* AioContext poll parameters */
> >      int64_t poll_max_ns;
> > diff --git a/iothread.c b/iothread.c
> > index 3558535b40..3301b8d495 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -25,6 +25,92 @@
> >  #include "qemu/rcu.h"
> >  #include "qemu/main-loop.h"
> >
> > +/*
> > + * iothread_ref:
> > + * @iothread: the iothread to track
> > + * @holder: the IOThreadHolder object initialized by the caller
> > + *
> > + * Add the @holder to the iothread's tracking list.
> > + */
> > +static void iothread_ref(IOThread *iothread, const IOThreadHolder *hol=
der)
> > +{
> > +    assert(holder);
> > +    IOThreadHolder *h =3D g_new0(IOThreadHolder, 1);
> > +
> > +    h->type =3D holder->type;
> > +    switch (holder->type) {
> > +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +        h->u.qom_object.qom_path =3D g_strdup(holder->u.qom_object.qom=
_path);
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> > +        h->u.block_node.node_name =3D
> > +            g_strdup(holder->u.block_node.node_name);
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> > +        h->u.monitor_name.monitor_name =3D
> > +            g_strdup(holder->u.monitor_name.monitor_name);
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
>
> This makes @h a deep copy of @holder.  Try
>
>     IOThreadHolder *h =3D QAPI_CLONE(IOThreadHolder, holder);
>
> instead.
>
> Instead of making a copy, the function could take ownership of @holder,
> and require @holder's members to be dynamically allocated.  More
> efficient, but complicates the callers somewhat.  Not worthwhile, I
> guess.

Yes, I



>
> > +
> > +    iothread->holders =3D g_list_prepend(iothread->holders, h);
> > +}
> > +
> > +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    const IOThreadHolder *holder_a =3D a;
> > +    const IOThreadHolder *holder_b =3D b;
> > +    const char *name_a, *name_b;
> > +
> > +    if (holder_a->type !=3D holder_b->type) {
> > +        return -1;
>
> Please use
>
>            return holder_b->type - holder_a->type;
>
> Why?  By convention, an int-valued function fn() comparing A to B
> returns less than 0 when A<B, 0 when A =3D=3D B, and greater than 0 when
> A>B.  Anything else needs a prominent comment.  Best to stick to the
> convention whenever practical.
>
> Since A < B iff B > A, we want fn(A, B) =3D=3D -fn(B, A).
>
> Your function does not satisfy that!  Harmless for now, because you only
> ever pass it to g_list_find_custom(), which treats all non-zero values
> the same.  But if anyone passes it to something like qsort() in the
> future, they can look forward to some debugging "fun".
>
> > +    }
> > +
> > +    switch (holder_a->type) {
> > +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +        name_a =3D holder_a->u.qom_object.qom_path;
> > +        name_b =3D holder_b->u.qom_object.qom_path;
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> > +        name_a =3D holder_a->u.block_node.node_name;
> > +        name_b =3D holder_b->u.block_node.node_name;
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> > +        name_a =3D holder_a->u.monitor_name.monitor_name;
> > +        name_b =3D holder_b->u.monitor_name.monitor_name;
> > +        break;
> > +    default:
> > +       /*
> > +        * This should not happen. If it does, name_a/b remains
> > +        * NULL and g_strcmp0 will handle it safely.
> > +        */
> > +        name_a =3D NULL;
> > +        name_b =3D NULL;
>
> Replace this by
>
>            g_assert_not_reached();
>
> Then neither @name_a nor @name_b can be null, because a non-optional
> QAPI str is never null.  Simply use strcmp().
>
> > +    }
> > +
> > +    return g_strcmp0(name_a, name_b);
> > +}
> > +
> > +/*
> > + * This function removes the @holder from the @iothread's tracking lis=
t.
> > + * The @holder must match the one used previously in iothread_ref().
> > + * It is a programming error to call this with a @holder that is not
> > + * currently associated with the @iothread.
> > + */
> > +static void iothread_unref(IOThread *iothread, const IOThreadHolder *h=
older)
> > +{
> > +    assert(holder);
> > +    GList *link =3D g_list_find_custom(iothread->holders, holder,
> > +                                     (GCompareFunc)iothread_holder_com=
pare);
> > +
> > +    assert(link);
> > +
> > +    IOThreadHolder *h =3D (IOThreadHolder *)link->data;
> > +    qapi_free_IOThreadHolder(h);
> > +    iothread->holders =3D g_list_delete_link(iothread->holders, link);
>
> Removing @link from the list before freeing link->data would be more
> obviously correct, wouldn't it?
>
> > +}
> > +
> >  static void *iothread_run(void *opaque)
> >  {
> >      IOThread *iothread =3D opaque;
> > @@ -356,6 +442,14 @@ char *iothread_get_id(IOThread *iothread)
> >
> >  AioContext *iothread_get_aio_context(IOThread *iothread)
> >  {
> > +    /* Remove in next patch for build */
> > +    IOThreadHolder holder =3D {
> > +        .type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> > +        .u.qom_object.qom_path =3D (char *)"tmp_path",
> > +    };
> > +    iothread_ref(iothread, &holder);
> > +    iothread_unref(iothread, &holder);
>
> Is this really needed to make this patch work?
>
> > +
> >      return iothread->ctx;
> >  }
> >
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index c71a5fe657..d9f82f0922 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -67,6 +67,67 @@
> >  ##
> >  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': t=
rue }
> >
> > +
> > +##
> > +# @IOThreadHolderBlockNode:
> > +#
> > +# @node-name: A block node.
>
> Let's use
>
>    # @node-name: Name of the block node
>
> to make it more similar to node-name descriptions elsewhere.
>
> > +#
> > +# Since: 11.1
> > +#
> > +##
> > +{ 'struct': 'IOThreadHolderBlockNode',
> > +  'data': { 'node-name': 'str' } }
> > +
> > +##
> > +# @IOThreadHolderQomObject:
> > +#
> > +# @qom-path: A QOM Object.
>
> Likewise, let's use
>
>   # @qom-path: Path to the object in the QOM tree
>
> > +#
> > +# Since: 11.1
> > +#
> > +##
> > +{ 'struct': 'IOThreadHolderQomObject',
> > +  'data': { 'qom-path': 'str' } }
> > +
> > +##
> > +# @IOThreadHolderMonitor:
> > +#
> > +# @monitor-name: A HMP/QMP monitor.
>
> Let's use
>
>    # @monitor-name: Name of the HMP/QMP monitor
>
> > +#
> > +# Since: 11.1
> > +#
> > +##
> > +{ 'struct': 'IOThreadHolderMonitor',
> > +  'data': { 'monitor-name': 'str' } }
> > +
> > +##
> > +# @IOThreadHolderKind:
> > +#
> > +# @block-node: A block node.
> > +# @qom-object: A QOM Object.
> > +# @monitor-name: A HMP/QMP monitor.
>
> Rename to @monitor for consistency with the other two.
>
> Remark, not a request to change anything in your patch: kind monitor
> will become obsolete when monitors become QOM objects.  Doing that
> before we release this interface is desirable.
>
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'enum': 'IOThreadHolderKind',
> > +  'data': [ 'block-node', 'qom-object', 'monitor-name' ] }
> > +
> > +##
> > +# @IOThreadHolder:
> > +#
>
> Let's add a short description:
>
>    # The block node, QOM object, or monitor holding the I/O thread.
>
> > +# @type: the kind of I/O thread holder.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'union': 'IOThreadHolder',
> > +  'base': { 'type': 'IOThreadHolderKind' },
> > +  'discriminator': 'type',
> > +  'data': {
> > +    'block-node': 'IOThreadHolderBlockNode',
> > +    'qom-object': 'IOThreadHolderQomObject',
> > +    'monitor-name': 'IOThreadHolderMonitor' } }
> > +
> >  ##
> >  # @IOThreadInfo:
> >  #
>

