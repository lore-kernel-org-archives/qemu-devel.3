Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC72C56205
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 19:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws3v0-00059K-0N; Thu, 06 Aug 2026 15:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws3ux-000596-Sn
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 15:38:15 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws3uv-0005IZ-Af
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 15:38:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so3121280a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 12:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786045092; cv=none;
 d=google.com; s=arc-20260327;
 b=bEgOi6vFEQcCEePCpsiY9eeINOb15Q5Lrz60IqRtmfimnDh2GphV5wbM1m7Nh2DXA6
 7sEozIIQ6MgLEGxy/ENKEZJcOBa7j5FlYl+v1orTsDXtD3PJ3fAt1MWzsxzGMzkzjTKg
 TXMCM0jWWkuo40aGr1rb/D0bIbVpIiXrcNohMpiSn/EhMlo6dyWQFdgd0Da2rH7G+Vmh
 Qhly8zolzgUk/qh6jk3FyWKSq5c0vvvYbQcoeu1eCKzOVbbMKycDQ5PdkUwEKaDTAkOm
 7mEFjLdIcNuwN3tppHepjeZz5yDg+6QTaZHJl4NQVHYCpkPfmtITZ3tGFoNPmlB8NRkI
 1I2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RN/JQbCzncy/8KuugTKoplZMPXs0gw1H5anRSEHEKY0=;
 fh=UaA1yCOjKZbN2T3Nzlq9jhGnddnHE8rnoiFOPAMopGg=;
 b=ROFD47urI5d9iD6usllGZ4JNLtRgAbI0v0q51JM5lZWdm41Y61eCA4v0CsmukkFAZh
 BgcGax+or2Dq772gUSnnZQ48QD0aVAWX6RsCRxa5UIT2u754JLqRFIho8LIUxh6gb+As
 bxGndb9modWUk9D8D+O5HkKJXz0stmpvfV+ZNZ3GeH8IY8zDng+hFZm6YFb6YRP/HdJ1
 ziSj27Tcp/GB8m1JsBZCuPGZBUgooEQMVcQIrI4urdB/1PtDo04WTg43Ty9S+UeUuLVP
 Q0VyPH4CO13OU32a892nAmqdgqLEJ3p04F4OH/HvmSp4Sct64hCX7pTFxKN3Jra14uvc
 6Low==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786045092; x=1786649892; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RN/JQbCzncy/8KuugTKoplZMPXs0gw1H5anRSEHEKY0=;
 b=ewA9m6nbUCyj8RqA0pcTKt0KdwNa43vfdNDJ2gkUew6OenlYYaN81C1eT795CRcN/b
 61RVzolaXWo2lzCcmkuxF9eMfWDbJDox2bvorh6EGDwoYyGaxyhvrK+gCZ50vi1SoOUi
 j/ouuFab3V6SCjz8PLJKzAbNHc0W/2FGfYQvCYBXzo5mtdGUT3cXa+DxfNWrgNwFycW3
 P6rdFsjL6W472h6tlKvkHcp51MKp7jeGDi2KPVmRn7Hh0cn52dg0gQPfhB+K+lsa5zzN
 oA+wMPLwCrb4qmkudsW+INyUy0Zl7W27e3YFP3CN8O7XsQHhqGEHkDWjMzJpF9wMszRD
 UT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786045092; x=1786649892;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RN/JQbCzncy/8KuugTKoplZMPXs0gw1H5anRSEHEKY0=;
 b=fFINqYorRErwH/u0Lpz9BV+0/MHHiNCVGlXgLw8WPCWAKOM5DWBtr7qo4/yAb2StxV
 3rCv/TTtXNSKsU1r2d2w7zp+b29/VGM3x/QaXna69ZyLT7MBCq/9+jVAEPFjibCLY9nM
 cHJU0fPJUDO0M1BM5r9f7a7ox+6REL0EFvuSSIsi/FtyzP6I6IPQJIYkHv7sJAxBwq8S
 3uKh0SHPFJKczqWsf8oDzDyC0DhuaNdPpRzCTjhxw3XilnJsWU4tZw2gqzYMv7d63reb
 9DM8q3Mc6TfhXL267YWFCxhQp6MyXpCasbRaaZivUZWTRvBgfd0dsyZiyqRRfisB26up
 Dveg==
X-Gm-Message-State: AOJu0YxzinqKgMQCdxPJs0n7lEZkFKDcgFYwQfAfJLoiteKauVUy4iD1
 0upvaRg4b1Pb54gdb3915mkN38g3RPIpXg3H5w1XA0qlzWl2g1eMQO4JJzGjQQ3SbXKa+tsjtij
 7pwf6IuD5g7zDK5abMNOmUxoAIuY6tMk=
X-Gm-Gg: AR+sD10hRiI/RKXxk7NUFEktV1ebls8mjVuLLNI6L3nn5+f5o+jC15JBi6dvkxE7Rtj
 Aa6dxUef+7+TiRnrwnFzsXlz0EtCDbuya0TUEbAciHpelExuL812s39IZH0OQsLUK2NROPQIEvr
 v9k1+OKs08ucjapsKZWfr8fXWx/vFamvBSqnPk3jpsT0OioHpc/3JtRlmy1nfiPTtX2bOSHKIl7
 qkrgAAKwzMqatJ09Ql47zmuvNtbauK1lo7n5FXV7eQT6mksrcCeBwmVsrbEM+khVIPl7h6nVfMy
 2GbjpbeN+OVtELfwbSgya0IkzGIZzCZdQczN7a1nEnkcW4HvTAMMe4M=
X-Received: by 2002:a05:6402:51d1:b0:6a0:d40e:9c0b with SMTP id
 4fb4d7f45d1cf-6a14f1448femr8513369a12.16.1786045087005; Thu, 06 Aug 2026
 12:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-3-zhangckid@gmail.com>
 <87ecgwpm9k.fsf@pond.sub.org>
In-Reply-To: <87ecgwpm9k.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 7 Aug 2026 03:37:30 +0800
X-Gm-Features: AUfX_mzBUhzOvA5MjeoufKMzpb2Fd9NcIEqTagtBqZbWwHPJVF-OwJM_KlB-H_A
Message-ID: <CAK3tnvJWhQUBy5rLL9q9KdaA_Cf=Jo6ndkX89Gh6w7f0-j=Gxg@mail.gmail.com>
Subject: Re: [RESEND PATCH V10 02/15] iothread: introduce iothread_ref/unref
 to track attached devices
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
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

On Tue, Jul 21, 2026 at 8:20=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > Currently, IOThreads do not maintain a record of which devices are
> > associated with them.
>
> It's not just devices, it's QOM objects and block exports, as far as I
> can tell.
>
> >                       This makes it difficult to monitor the
> > workload distribution of IOThreads, especially in complex
> > hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
> >
> > This patch introduces a reference counting and tracking mechanism
> > within the IOThread object:
> >
> > - iothread_ref(): Prepends the device's IOThreadHolder to a list.
> > - iothread_unref(): Searches for the IOThreadHolder using a
>
> Search what?
>
> >   string comparison (strcmp), releases the associated memory
> >   upon a successful match.
>
> More implementation detail than I'd use here.
>
> > - holders: A IOThreadHolderList storing the IOThreadHolder
> >   of attached devices for runtime introspection.
>
> Is this the list mentioned for iothread_ref()?  If yes, I'd put it
> first, then refer to it, perhaps like this:
>
>   - holders: a list describing what is "holding" the I/O thread
>   - iothread_ref(): add a "holder" to this list
>   - iothread_unref(): remove a "holder" from this list
>
> And maybe
>
>   A "holder" can be a QOM object or a block export.
>
> > A later commit will add QMP commands to let management applications
> > query the attachment status of IOThreads.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/system/iothread.h | 11 ++++++
> >  iothread.c                | 70 +++++++++++++++++++++++++++++++++++++++
> >  qapi/misc.json            | 59 +++++++++++++++++++++++++++++++++
> >  3 files changed, 140 insertions(+)
> >
> > diff --git a/include/system/iothread.h b/include/system/iothread.h
> > index a1ef7696cb..ef0b2f9648 100644
> > --- a/include/system/iothread.h
> > +++ b/include/system/iothread.h
> > @@ -38,6 +38,9 @@
> >  #define IOTHREAD_POLL_WEIGHT_DEFAULT 0ULL
> >  #endif
> >
> > +typedef struct IOThreadHolder IOThreadHolder;
> > +typedef struct IOThreadHolderList IOThreadHolderList;
>
> These are is already defined in generated qapi/qapi-types-misc.h.  Why
> not include it instead?
>
> > +
> >  struct IOThread {
> >      EventLoopBase parent_obj;
> >
> > @@ -50,6 +53,11 @@ struct IOThread {
> >      bool stopping;              /* has iothread_stop() been called? */
> >      bool running;               /* should iothread_run() continue? */
> >      int thread_id;
> > +    /*
> > +     * The list elements are of type IOThreadHolder, which can
> > +     * represent either a QOM path or a block export name.
> > +     */
>
> Back when holders was a GList, explaining the element type in a comment
> was useful.  Now it's not.
>
> > +    IOThreadHolderList *holders;
> >
> >      /* AioContext poll parameters */
> >      int64_t poll_max_ns;
> > @@ -82,4 +90,7 @@ void iothread_destroy(IOThread *iothread);
> >   */
> >  bool qemu_in_iothread(void);
> >
> > +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder);
> > +void iothread_unref(IOThread *iothread, const IOThreadHolder *holder);
> > +
> >  #endif /* IOTHREAD_H */
> > diff --git a/iothread.c b/iothread.c
> > index 3558535b40..38f273c0e9 100644
> > --- a/iothread.c
> > +++ b/iothread.c
> > @@ -21,10 +21,78 @@
> >  #include "system/iothread.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-commands-misc.h"
> > +#include "qapi/clone-visitor.h"
> > +#include "qapi/qapi-visit-misc.h"
> >  #include "qemu/error-report.h"
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
>
> This is confusing.  What's tracking what?
>
> Here's my attempt:
>
>    /*
>     * Add a deep copy of @holder to @iothread's list of holders.
>     */
>
> If you really want to use "tracking list", you should define the term,
> say with a comment next to @holder in struct IOThread.
>
> > +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
> > +{
> > +    assert(holder);
> > +
> > +    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, ho=
lder));
> > +}
> > +
> > +static int iothread_holder_compare(const IOThreadHolder *holder_a,
> > +                                   const IOThreadHolder *holder_b)
> > +{
> > +    const char *name_a, *name_b;
> > +
> > +    if (holder_a->type !=3D holder_b->type) {
> > +        return holder_b->type - holder_a->type;
> > +    }
> > +
> > +    switch (holder_a->type) {
> > +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> > +        name_a =3D holder_a->u.qom_object.qom_path;
> > +        name_b =3D holder_b->u.qom_object.qom_path;
> > +        break;
> > +    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> > +        name_a =3D holder_a->u.block_export.export_name;
> > +        name_b =3D holder_b->u.block_export.export_name;
> > +        break;
> > +    default:
> > +        g_assert_not_reached();
> > +    }
> > +
> > +    return strcmp(name_a, name_b);
> > +}
> > +
> > +/*
> > + * This function removes the @holder from the @iothread's tracking lis=
t.
>
> Imperative mood, please:
>
>     * Remove @holder from @iothread's list of holders.
>
> > + * The @holder must match the one used previously in iothread_ref().
>
> I believe the next sentence makes this one redundant.
>
> > + * It is a programming error to call this with a @holder that is not
> > + * currently associated with the @iothread.
> > + */
> > +void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
> > +{
> > +    IOThreadHolderList **prev =3D &iothread->holders;
> > +    IOThreadHolderList *curr;
> > +
> > +    assert(holder);
> > +
> > +    while (*prev) {
> > +        curr =3D *prev;
> > +        if (iothread_holder_compare(curr->value, holder) =3D=3D 0) {
> > +            *prev =3D curr->next;
> > +            curr->next =3D NULL;
> > +            qapi_free_IOThreadHolderList(curr);
> > +            return;
> > +        }
> > +        prev =3D &curr->next;
> > +    }
> > +
> > +    g_assert_not_reached();
> > +}
> > +
> >  static void *iothread_run(void *opaque)
> >  {
> >      IOThread *iothread =3D opaque;
> > @@ -129,6 +197,7 @@ static void iothread_instance_finalize(Object *obj)
> >          iothread->main_loop =3D NULL;
> >      }
> >      qemu_sem_destroy(&iothread->init_done_sem);
> > +    qapi_free_IOThreadHolderList(iothread->holders);
> >  }
> >
> >  static void iothread_init_gcontext(IOThread *iothread, const char *thr=
ead_name)
> > @@ -373,6 +442,7 @@ static int query_one_iothread(Object *object, void =
*opaque)
> >      info =3D g_new0(IOThreadInfo, 1);
> >      info->id =3D iothread_get_id(iothread);
> >      info->thread_id =3D iothread->thread_id;
> > +    info->holders =3D QAPI_CLONE(IOThreadHolderList, iothread->holders=
);
> >      info->poll_max_ns =3D iothread->poll_max_ns;
> >      info->poll_grow =3D iothread->poll_grow;
> >      info->poll_shrink =3D iothread->poll_shrink;
> > diff --git a/qapi/misc.json b/qapi/misc.json
> > index c71a5fe657..096e418b7a 100644
> > --- a/qapi/misc.json
> > +++ b/qapi/misc.json
> > @@ -67,6 +67,56 @@
> >  ##
> >  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': t=
rue }
> >
> > +
> > +##
> > +# @IOThreadHolderBlockExport:
> > +#
> > +# @export-name: Name of the block export.
>
> What's a block export name?
>
> Is it BlockExportOptions member @id?
>
> Is it BlockExportOptions member @node-name?
>
> Something else?
>
> > +#
> > +# Since: 11.1
>
> By now 11.2.
>
> > +#
> > +##
> > +{ 'struct': 'IOThreadHolderBlockExport',
> > +  'data': { 'export-name': 'str' } }
> > +
> > +##
> > +# @IOThreadHolderQomObject:
> > +#
> > +# @qom-path: Path to the object in the QOM tree.
> > +#
> > +# Since: 11.1
> > +#
> > +##
> > +{ 'struct': 'IOThreadHolderQomObject',
> > +  'data': { 'qom-path': 'str' } }
> > +
> > +##
> > +# @IOThreadHolderKind:
> > +#
> > +# @block-export: A block export.
> > +# @qom-object: A QOM Object.
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'enum': 'IOThreadHolderKind',
> > +  'data': [ 'block-export', 'qom-object' ] }
> > +
> > +##
> > +# @IOThreadHolder:
> > +#
> > +# The block export or QOM object holding the I/O thread.
> > +#
> > +# @type: the kind of I/O thread holder.
>
> We should use "iothread" for consistency (even though I/O thread is
> nicer).
>
> > +#
> > +# Since: 11.1
> > +##
> > +{ 'union': 'IOThreadHolder',
> > +  'base': { 'type': 'IOThreadHolderKind' },
> > +  'discriminator': 'type',
> > +  'data': {
> > +    'block-export': 'IOThreadHolderBlockExport',
> > +    'qom-object': 'IOThreadHolderQomObject' } }
> > +
> >  ##
> >  # @IOThreadInfo:
> >  #
> > @@ -76,6 +126,11 @@
> >  #
> >  # @thread-id: ID of the underlying host thread
> >  #
> > +# @holders: the QOM objects or block nodes currently
> > +#     associated with this iothread.  When an associated component is
> > +#     detached or destroyed, it is removed from this list.
> > +#     (Since 11.1)
>
> Wrap lines more nicely, please:
>
>    # @holders: the QOM objects or block nodes currently associated with
>    #     this iothread.  When an associated component is detached or
>    #     destroyed, it is removed from this list.  (Since 11.1)
>
>

Thanks. I will update here and the commit message to describe holders
and remove the implementation details.

The current block-export holder value is actually the block node name.
I will change it to BlockExportOptions.id and expose it as "export-id",
so the holder identifies the block export rather than its backing node.

And rethink for the patch 14, I will drop it and keep the original name
"iothread_ref_and_get_aio_context" to avoid misunderstanding.

Thanks

Chen

> > +#
> >  # @poll-max-ns: maximum polling time in ns, 0 means polling is
> >  #     disabled (since 2.9)
> >  #
> > @@ -98,6 +153,7 @@
> >  { 'struct': 'IOThreadInfo',
> >    'data': {'id': 'str',
> >             'thread-id': 'int',
> > +           'holders': ['IOThreadHolder'],
> >             'poll-max-ns': 'int',
> >             'poll-grow': 'int',
> >             'poll-shrink': 'int',
> > @@ -124,6 +180,8 @@
> >  #              {
> >  #                 "id":"iothread0",
> >  #                 "thread-id":3134,
> > +#                 "holders":[{"qom-path": "/machine/peripheral/blk1/vi=
rtio-backend", "type": "qom-object"},
> > +#                            {"qom-path": "/machine/peripheral/blk2/vi=
rtio-backend", "type": "qom-object"}],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
> > @@ -132,6 +190,7 @@
> >  #              {
> >  #                 "id":"iothread1",
> >  #                 "thread-id":3135,
> > +#                 "holders":[{"export-name": "fmt_qcow2", "type": "blo=
ck-export"}],
> >  #                 "poll-max-ns":32768,
> >  #                 "poll-grow":0,
> >  #                 "poll-shrink":0,
>

