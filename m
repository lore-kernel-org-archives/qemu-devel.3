Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39547C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Sy-0001zu-9D; Tue, 21 Jul 2026 08:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm9Si-0001wN-3r
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wm9Sd-0003l3-WF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784636432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DaIB8/dRo7mJ2fJJe8Xya1YtnR0CMfP7PNeLpiwaSF8=;
 b=Z12pL2+l3PgpPTajBcpWMthphovO0rYeSvM4+XMIMRD0+nJPRwUqxpMNpJf8Rz1UuHMnRP
 bMQGDBGarxi8nfIEkmIkGTczrEXocpNKksuaaXAXcj3r7/PdpmiHZ6m3bc7nfUHXYKMc5T
 NmGbW7tEJbTc0j3triC5A964wWNLzy8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-ChacZ2L5OGiBV-1EmrMYig-1; Tue,
 21 Jul 2026 08:20:28 -0400
X-MC-Unique: ChacZ2L5OGiBV-1EmrMYig-1
X-Mimecast-MFC-AGG-ID: ChacZ2L5OGiBV-1EmrMYig_1784636427
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A5FB1956056; Tue, 21 Jul 2026 12:20:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62AA83004190; Tue, 21 Jul 2026 12:20:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB9A621E6920; Tue, 21 Jul 2026 14:20:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RESEND PATCH V10 02/15] iothread: introduce iothread_ref/unref
 to track attached devices
In-Reply-To: <20260716172108.87700-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 17 Jul 2026 01:20:43 +0800")
References: <20260716172108.87700-1-zhangckid@gmail.com>
 <20260716172108.87700-3-zhangckid@gmail.com>
Date: Tue, 21 Jul 2026 14:20:23 +0200
Message-ID: <87ecgwpm9k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Zhang Chen <zhangckid@gmail.com> writes:

> Currently, IOThreads do not maintain a record of which devices are
> associated with them.

It's not just devices, it's QOM objects and block exports, as far as I
can tell.

>                       This makes it difficult to monitor the
> workload distribution of IOThreads, especially in complex
> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>
> This patch introduces a reference counting and tracking mechanism
> within the IOThread object:
>
> - iothread_ref(): Prepends the device's IOThreadHolder to a list.
> - iothread_unref(): Searches for the IOThreadHolder using a

Search what?

>   string comparison (strcmp), releases the associated memory
>   upon a successful match.

More implementation detail than I'd use here.

> - holders: A IOThreadHolderList storing the IOThreadHolder
>   of attached devices for runtime introspection.

Is this the list mentioned for iothread_ref()?  If yes, I'd put it
first, then refer to it, perhaps like this:

  - holders: a list describing what is "holding" the I/O thread
  - iothread_ref(): add a "holder" to this list
  - iothread_unref(): remove a "holder" from this list

And maybe

  A "holder" can be a QOM object or a block export.

> A later commit will add QMP commands to let management applications
> query the attachment status of IOThreads.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/system/iothread.h | 11 ++++++
>  iothread.c                | 70 +++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json            | 59 +++++++++++++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index a1ef7696cb..ef0b2f9648 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -38,6 +38,9 @@
>  #define IOTHREAD_POLL_WEIGHT_DEFAULT 0ULL
>  #endif
>  
> +typedef struct IOThreadHolder IOThreadHolder;
> +typedef struct IOThreadHolderList IOThreadHolderList;

These are is already defined in generated qapi/qapi-types-misc.h.  Why
not include it instead?

> +
>  struct IOThread {
>      EventLoopBase parent_obj;
>  
> @@ -50,6 +53,11 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    /*
> +     * The list elements are of type IOThreadHolder, which can
> +     * represent either a QOM path or a block export name.
> +     */

Back when holders was a GList, explaining the element type in a comment
was useful.  Now it's not.

> +    IOThreadHolderList *holders;
>  
>      /* AioContext poll parameters */
>      int64_t poll_max_ns;
> @@ -82,4 +90,7 @@ void iothread_destroy(IOThread *iothread);
>   */
>  bool qemu_in_iothread(void);
>  
> +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder);
> +void iothread_unref(IOThread *iothread, const IOThreadHolder *holder);
> +
>  #endif /* IOTHREAD_H */
> diff --git a/iothread.c b/iothread.c
> index 3558535b40..38f273c0e9 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -21,10 +21,78 @@
>  #include "system/iothread.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-misc.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-misc.h"
>  #include "qemu/error-report.h"
>  #include "qemu/rcu.h"
>  #include "qemu/main-loop.h"
>  
> +/*
> + * iothread_ref:
> + * @iothread: the iothread to track
> + * @holder: the IOThreadHolder object initialized by the caller
> + *
> + * Add the @holder to the iothread's tracking list.
> + */

This is confusing.  What's tracking what?

Here's my attempt:

   /*
    * Add a deep copy of @holder to @iothread's list of holders.
    */

If you really want to use "tracking list", you should define the term,
say with a comment next to @holder in struct IOThread.

> +void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
> +{
> +    assert(holder);
> +
> +    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
> +}
> +
> +static int iothread_holder_compare(const IOThreadHolder *holder_a,
> +                                   const IOThreadHolder *holder_b)
> +{
> +    const char *name_a, *name_b;
> +
> +    if (holder_a->type != holder_b->type) {
> +        return holder_b->type - holder_a->type;
> +    }
> +
> +    switch (holder_a->type) {
> +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +        name_a = holder_a->u.qom_object.qom_path;
> +        name_b = holder_b->u.qom_object.qom_path;
> +        break;
> +    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
> +        name_a = holder_a->u.block_export.export_name;
> +        name_b = holder_b->u.block_export.export_name;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    return strcmp(name_a, name_b);
> +}
> +
> +/*
> + * This function removes the @holder from the @iothread's tracking list.

Imperative mood, please:

    * Remove @holder from @iothread's list of holders.

> + * The @holder must match the one used previously in iothread_ref().

I believe the next sentence makes this one redundant.

> + * It is a programming error to call this with a @holder that is not
> + * currently associated with the @iothread.
> + */
> +void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
> +{
> +    IOThreadHolderList **prev = &iothread->holders;
> +    IOThreadHolderList *curr;
> +
> +    assert(holder);
> +
> +    while (*prev) {
> +        curr = *prev;
> +        if (iothread_holder_compare(curr->value, holder) == 0) {
> +            *prev = curr->next;
> +            curr->next = NULL;
> +            qapi_free_IOThreadHolderList(curr);
> +            return;
> +        }
> +        prev = &curr->next;
> +    }
> +
> +    g_assert_not_reached();
> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread = opaque;
> @@ -129,6 +197,7 @@ static void iothread_instance_finalize(Object *obj)
>          iothread->main_loop = NULL;
>      }
>      qemu_sem_destroy(&iothread->init_done_sem);
> +    qapi_free_IOThreadHolderList(iothread->holders);
>  }
>  
>  static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
> @@ -373,6 +442,7 @@ static int query_one_iothread(Object *object, void *opaque)
>      info = g_new0(IOThreadInfo, 1);
>      info->id = iothread_get_id(iothread);
>      info->thread_id = iothread->thread_id;
> +    info->holders = QAPI_CLONE(IOThreadHolderList, iothread->holders);
>      info->poll_max_ns = iothread->poll_max_ns;
>      info->poll_grow = iothread->poll_grow;
>      info->poll_shrink = iothread->poll_shrink;
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c71a5fe657..096e418b7a 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -67,6 +67,56 @@
>  ##
>  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
>  
> +
> +##
> +# @IOThreadHolderBlockExport:
> +#
> +# @export-name: Name of the block export.

What's a block export name?

Is it BlockExportOptions member @id?

Is it BlockExportOptions member @node-name?

Something else?

> +#
> +# Since: 11.1

By now 11.2.

> +#
> +##
> +{ 'struct': 'IOThreadHolderBlockExport',
> +  'data': { 'export-name': 'str' } }
> +
> +##
> +# @IOThreadHolderQomObject:
> +#
> +# @qom-path: Path to the object in the QOM tree.
> +#
> +# Since: 11.1
> +#
> +##
> +{ 'struct': 'IOThreadHolderQomObject',
> +  'data': { 'qom-path': 'str' } }
> +
> +##
> +# @IOThreadHolderKind:
> +#
> +# @block-export: A block export.
> +# @qom-object: A QOM Object.
> +#
> +# Since: 11.1
> +##
> +{ 'enum': 'IOThreadHolderKind',
> +  'data': [ 'block-export', 'qom-object' ] }
> +
> +##
> +# @IOThreadHolder:
> +#
> +# The block export or QOM object holding the I/O thread.
> +#
> +# @type: the kind of I/O thread holder.

We should use "iothread" for consistency (even though I/O thread is
nicer).

> +#
> +# Since: 11.1
> +##
> +{ 'union': 'IOThreadHolder',
> +  'base': { 'type': 'IOThreadHolderKind' },
> +  'discriminator': 'type',
> +  'data': {
> +    'block-export': 'IOThreadHolderBlockExport',
> +    'qom-object': 'IOThreadHolderQomObject' } }
> +
>  ##
>  # @IOThreadInfo:
>  #
> @@ -76,6 +126,11 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @holders: the QOM objects or block nodes currently
> +#     associated with this iothread.  When an associated component is
> +#     detached or destroyed, it is removed from this list.
> +#     (Since 11.1)

Wrap lines more nicely, please:

   # @holders: the QOM objects or block nodes currently associated with
   #     this iothread.  When an associated component is detached or
   #     destroyed, it is removed from this list.  (Since 11.1)


> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -98,6 +153,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'holders': ['IOThreadHolder'],
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -124,6 +180,8 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "holders":[{"qom-path": "/machine/peripheral/blk1/virtio-backend", "type": "qom-object"},
> +#                            {"qom-path": "/machine/peripheral/blk2/virtio-backend", "type": "qom-object"}],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -132,6 +190,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "holders":[{"export-name": "fmt_qcow2", "type": "block-export"}],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,


