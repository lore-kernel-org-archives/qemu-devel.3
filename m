Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2861EFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 14:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHNNn-00024Y-Rz; Mon, 27 Apr 2026 10:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHNNl-00024H-5R
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 10:56:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wHNNf-000093-Au
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 10:56:18 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b936331786dso1344428866b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 07:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777301773; cv=none;
 d=google.com; s=arc-20240605;
 b=kV1Mu6V6ggfXWqHVCcVZjPW/aAgQvzHS0NKwyaCMIAG8NA04I8mRCgFTA0C/Vo/ldW
 1AXNrHeNUv1faxFlFwEahHqPwqnyOnGf26BJaN8BvgQDJOsKn0RwHINS2qRsf0iXcWKy
 VeSU5F/7PAkfjLO/SKM+4y93ZvzIZrVSNZTtSEWitzNThatDxaskSuurd8dPMQbyUoCN
 L6RPYlMU2NxRVvLlAWKsFisT0O/an0c4Hw3GoUDFt6fiz+7n98ZcESK3DmwxKHaCuNkZ
 gLaK5yMIvnh7wytuD7AuAVwdLRv7ARf7b6G+e9xHwzy/gaK4vL/gf1LAdAtycQvBRSUz
 9rjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bc38BsKPGGjblvMFKBuaQSi93DkisBKoc+26zROYrZk=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=MgXAnAccyOye59cYPSO64HVuiZWXM4k1RQTxgIAdcBUsVHWiyKGlYGtflMh+iDLOHu
 LYZGbacx0zYwC5DhwqJirpKD4oZ/J5plwj8vsIWeWPxqTLQ28DoxNhPyVVDcgCxS6pzG
 +6gzrEaMqKSheyvbpEiv6gNleHpJWGU0NL6T7zfKh+VKka6UI+tDjX0jgDqRYsYN461U
 I6o95BB24mbgSe3xRNTUOJrTBxxPOC3VTkgzHRjvYulJXjy5yskyYzy4dMDc0utM4GgZ
 AnyeTGEzwcK4oipsdxxdk66WXjCEJ0RDL24wCGfpdOZWsC4HIrQY4IOIATGTH8VRS+Qg
 VXEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777301773; x=1777906573; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bc38BsKPGGjblvMFKBuaQSi93DkisBKoc+26zROYrZk=;
 b=VXkHQfJTpDjPhHtgAH2JJ/Iz+i0MCL8OhzGEYcXmoHOW4bUYwGi/SMk+grq/IoTThu
 ULy38pEhgORs9GTeqyoiVixbfvcAgNBbPVSnR5CJmmkWsXIDYL3zK5gssIvFsHzDemWI
 CxdAcdH0Rb8BzWK/XNE66fZhWrLT+uh0/pFuvI4Rm255WH87050EoIG/LMreG2gg2BET
 X/wBg4+TauxYEvmcB4G/74mvsXtpWlyALfkGDm2oK56/BFNp/rPG7hrow5HAZ68bTI8D
 W35XcAOT7XS/kFZwynR/ocEjduoiBRKHrLoZlA+z9DTT+uGV9mDrdmB8CNLJlM9Gw6v0
 evZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777301773; x=1777906573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bc38BsKPGGjblvMFKBuaQSi93DkisBKoc+26zROYrZk=;
 b=Npr6oGDzrztnUh7EcFj2ZK4ADN1/7gbV/ZMGgpo36radHOHRJtYV7ngwibAWyNuddF
 BksMIxhtefXg+FjyvYbLcf+QDSKn8yTC5I7QG4bd2In+j7SIpSF0Ptw6WWWuOM30QI74
 ToRkbub1GEKVTjSU+yZUpT0W2WWAzLxJtuE9fH1iTwnThHzXR6/J3GV5WS0Vl9YCuk7D
 OsXqRJD6tdM0C8ovWGU9d9MZxaL2IIAGdlBxOEiEimPvdepHeGXvhzIuTcy/02fmztIz
 aE8y/Xhz9s9Dj8TusigZ4KD0mAob/wBU7eELin6BARWshG+icq78d4C9DGgpaFTdHbT6
 gygQ==
X-Gm-Message-State: AOJu0YzGwJptlj+QQmv5X1COCFZfA9Nph/rfwFbw6czrhZqxD5VE9Ihn
 kegWBUXnvuK8THMN/4E1C54E7BAZjGAERHtO5aOGAm8kwk4PO2uSIhSqf8hVpUx3NB7pFyErqVi
 pz3lk7GrYv6QlMylb+AhW3obqDKcjuBs=
X-Gm-Gg: AeBDiesBtsZhm4D0SQ7lh5ykpK+hVndyUFPovSd5t9D3gQddIIAVk3vVOtALbPi76eF
 lK1gbXRFyhvVTSkjeB5mu2zCOM5IC7FeDAXMtNIVDGJkun1n5T8oc2gdAxOqn43lW+8pDR823pW
 FHLlF8S2IFO6BglsNYjyAnxlgsMmoYo+hHsS3/Thd+wIy/cnh4HstJUvrLUICEHW8H166a3DCRp
 FxV6sL7WSJVW605/2qx83qVX0HxNL4VIHWq1GWZVl/XHTvCpN71ZlzbksZJIVnt7qbSsw84f70k
 TxWeZxKKJRnmsEgAbF0=
X-Received: by 2002:a17:907:da7:b0:ba6:4e0f:e3a8 with SMTP id
 a640c23a62f3a-ba64e0fe96fmr1670995166b.12.1777301772698; Mon, 27 Apr 2026
 07:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-3-zhangckid@gmail.com>
 <87bjfc4cxq.fsf@pond.sub.org>
In-Reply-To: <87bjfc4cxq.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 27 Apr 2026 22:55:34 +0800
X-Gm-Features: AVHnY4JBRidCCWE6cN3ODS6ZSpsOj-nbsOdqYjENeY6bpjjiZFu7ferWZzCIDPg
Message-ID: <CAK3tnvKn_hHDjZx2VWCRUzKK1O2xi35VUdxYQ0++rLO-rvMTCw@mail.gmail.com>
Subject: Re: [PATCH V6 02/14] iothread: introduce iothread_ref/unref to track
 attached devices
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x62e.google.com
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

On Tue, Apr 21, 2026 at 10:15=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
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
> > - iothread_ref(): Prepends the device's QOM path to a list.
> > - iothread_unref(): Searches for the device path using a custom
> >   string comparison (g_strcmp0), releases the associated memory
> >   upon a successful match.
> > - holders: A GList storing the QOM paths of attached devices
> >   for runtime introspection.
> >
> > This infrastructure allows management tools and QMP commands to
> > query the attachment status of IOThreads.
>
> Suggest something like
>
>   A later commit will add QMP commands to let management applications
>   query the attachment status of IOThreads.

Sorry for the late reply, I originally intended to wait for stefan's
feedback so I could reply to everything at once.

For the comments, it looks better, will replace it in the next version.

>
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  include/system/iothread.h |  1 +
> >  iothread.c                | 56 +++++++++++++++++++++++++++++++++++++++
> >  qapi/misc.json            | 48 +++++++++++++++++++++++++++++++++
> >  3 files changed, 105 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index e26d13c6c7..21a76bd70d 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -33,6 +33,7 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    GList *holders;             /* an array of QOM paths for attached =
devices */
>
> The comment is mostly wrong.  A GList is not an array.  The list
> elements are of type IoThreadHolder, which can represent either a QOM
> path or a block node name.  Suggest

Good catch, forgot to update it after we defined the type IoThreadHolder.

>
>        GList *holders;             /* list of IoThreadHolder */
>
> >
> >      /* AioContext poll parameters */
> >      int64_t poll_max_ns;
> > diff --git a/iothread.c b/iothread.c
> > index caf68e0764..c43266b191 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -36,6 +36,55 @@
> >  #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
> >  #endif
> >
> > +/*
> > + * Add holder device path to the list.
>
> Please explain semantics of parameter @holder here, it's not obvious
> that @holder is a QOM path if it starts with '/', else a block node
> name.
>
> Restriction: only absolute QOM paths work.  Relative ones get
> misinterpreted as block node names.

OK.

>
> > + */
> > +static void iothread_ref(IOThread *iothread, const char *holder)
> > +{
> > +    IoThreadHolder *h =3D g_new0(IoThreadHolder, 1);
> > +
> > +    if (holder && holder[0] =3D=3D '/') {
> > +        h->type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT;
> > +        h->u.qom_object.data =3D g_strdup(holder);
> > +    } else {
> > +        h->type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE;
> > +        h->u.block_node.data =3D g_strdup(holder ? holder : "unknown")=
;
>
> No.  Nothing stops a user from naming a block node "unknown".
>
> How can !holder happen?  If it's not supposed to happen, assert() it
> doesn't!

OK.

>
> > +    }
> > +
> > +    iothread->holders =3D g_list_prepend(iothread->holders, h);
> > +}
> > +
> > +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    const IoThreadHolder *holder_node =3D a;
> > +    const char *target_name =3D b;
> > +    const char *current_name =3D NULL;
>
> Superfluous initializer.

OK, will remove it.


>
> > +
> > +    if (holder_node->type =3D=3D IO_THREAD_HOLDER_KIND_QOM_OBJECT) {
> > +        current_name =3D holder_node->u.qom_object.data;
> > +    } else if (holder_node->type =3D=3D IO_THREAD_HOLDER_KIND_BLOCK_NO=
DE) {
> > +        current_name =3D holder_node->u.block_node.data;
> > +    }
> > +
> > +    return g_strcmp0(current_name, target_name);
>
> Why g_strcmp0()?  How can any of the arguments be null?

Using g_strcmp0 provides a defensive check against cases
where a holder name might be uninitialized or the holder type
is unrecognized, avoiding a potential NULL pointer dereference.

>
> > +}
> > +
> > +/*
> > + * Delete holder device path from the list.
>
> Please explain semantics of @holder as for iothread_ref(), and state
> that a it must be one of @io_thread's holders.

OK.

>
> > + */
> > +static void iothread_unref(IOThread *iothread, const char *holder)
> > +{
> > +    GList *link =3D g_list_find_custom(iothread->holders, holder,
> > +                                     (GCompareFunc)iothread_holder_com=
pare);
> > +
> > +    /* We don't support unref without a link */
>
> I doubt this comment is useful.

Will remove it.

>
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
> > @@ -115,6 +164,9 @@ static void iothread_instance_finalize(Object *obj)
> >
> >      iothread_stop(iothread);
> >
> > +    /* We don't support finalize without holders */
>
> Why?

If I understand correctly, Stefan's design is to manage the iothread
lifecycle using paired ref/unref.
The iothread ref will give a holder for the iothread. So, any using
iothread must have a holder here.

Another scenario is that an iothread was added but was not assigned to
any device.
In this case, yes, no need assert the holders here.

I will remove it next version.

>
> > +    assert(iothread->holders =3D=3D NULL);
> > +
> >      /*
> >       * Before glib2 2.33.10, there is a glib2 bug that GSource context
> >       * pointer may not be cleared even if the context has already been
> > @@ -336,6 +388,10 @@ char *iothread_get_id(IOThread *iothread)
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
> > index 1f5062df2a..d65d8012b2 100644
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
>
> These are commonly named @node-name.

OK.

>
> > +#
> > +# Since: 11.0
> > +#
> > +##
> > +{ 'struct': 'IoThreadHolderBlockNode',
> > +  'data': { 'data': 'str' } }
> > +
> > +##
> > +# @IoThreadHolderQomObject:
> > +#
> > +# @data: QOM path.
>
> These are commonly named @qom-path.
>
> Should we use "Absolute QOM path" here?  Relative ones don't actually
> work.

Yes, good idea.

>
> > +#
> > +# Since: 11.0
> > +#
> > +##
> > +{ 'struct': 'IoThreadHolderQomObject',
> > +  'data': { 'data': 'str' } }
> > +
> > +##
> > +# @IoThreadHolderKind:
> > +#
> > +# @block-node: Block node name.
>
> The block node name is not the holder, the block node is.
>
> > +# @qom-object: Standard QOM path.
>
> What do you mean by "standard"?

I will change it to "Absolute QOM path".

>
> > +#
> > +# Since: 11.0
> > +##
> > +{ 'enum': 'IoThreadHolderKind',
> > +  'data': [ 'block-node', 'qom-object' ] }
> > +
> > +##
> > +# @IoThreadHolder:
> > +#
> > +# @type: Current IoThread holder type support QOM path and Block node.
>
> Awkward English :)
>
>    # @type: the kind of I/O thread holder
>
> isn't exactly great, either.  But I'm out of time for today.

OK.

Thanks

chen

>
> > +#
> > +# Since: 11.0
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
>

