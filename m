Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5565CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2D6-0001GT-GF; Fri, 26 Jun 2026 04:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wd2Cp-0001Fl-0H
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:46:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wd2Ck-0006PB-TM
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 04:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782463588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=azhboJMdiBp2NuE0R0GcYDgB1nF6JMf6U0/9hJ3njOw=;
 b=RJ/PTdFZV6Ft1vA3yLD/a/lKSXxVLv4khhytsosAqOYxtDepMPxYZDyYtLiScF3aeEYLmk
 WTC/Stj7bvkR8kPy5h/O30Z5bF7gLJ7UrWDizypo+u5b60UCXzKjMgNwDFfXAqko7fWoC8
 tpRk0xQTFUlIrPDkAtuTOhTY9j4wQac=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-mWVFccJINK2-B_8JdGXVSQ-1; Fri,
 26 Jun 2026 04:46:24 -0400
X-MC-Unique: mWVFccJINK2-B_8JdGXVSQ-1
X-Mimecast-MFC-AGG-ID: mWVFccJINK2-B_8JdGXVSQ_1782463583
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E00E71956056; Fri, 26 Jun 2026 08:46:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 129D3195608A; Fri, 26 Jun 2026 08:46:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8164921E6920; Fri, 26 Jun 2026 10:46:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 02/17] iothread: introduce iothread_ref/unref to
 track attached devices
In-Reply-To: <20260624070851.13342-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Wed, 24 Jun 2026 15:08:36 +0800")
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-3-zhangckid@gmail.com>
Date: Fri, 26 Jun 2026 10:46:19 +0200
Message-ID: <87o6gx1yg4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Looks like you missed my review of v8.  I'm replaying my review
comments.

Zhang Chen <zhangckid@gmail.com> writes:

> Currently, IOThreads do not maintain a record of which devices are
> associated with them. This makes it difficult to monitor the
> workload distribution of IOThreads, especially in complex
> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>
> This patch introduces a reference counting and tracking mechanism
> within the IOThread object:
>
> - iothread_ref(): Prepends the device's IOThreadHolder to a list.
> - iothread_unref(): Searches for the IOThreadHolder using a custom
>   string comparison (g_strcmp0), releases the associated memory
>   upon a successful match.
> - holders: A GList storing the IOThreadHolder of attached devices
>   for runtime introspection.
>
> A later commit will add QMP commands to let management applications
> query the attachment status of IOThreads.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  5 +++
>  iothread.c                | 94 +++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json            | 61 +++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index a1ef7696cb..b9207ad829 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -50,6 +50,11 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    /*
> +     * The list elements are of type IOThreadHolder, which can
> +     * represent either a QOM path or a block node name.
> +     */

You forgot monitors.  Stefan spotted this as well, and I agree with the
fix he suggested.

> +    GList *holders;
>  
>      /* AioContext poll parameters */
>      int64_t poll_max_ns;
> diff --git a/iothread.c b/iothread.c
> index 3558535b40..3301b8d495 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -25,6 +25,92 @@
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
> +static void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
> +{
> +    assert(holder);
> +    IOThreadHolder *h = g_new0(IOThreadHolder, 1);
> +
> +    h->type = holder->type;
> +    switch (holder->type) {
> +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +        h->u.qom_object.qom_path = g_strdup(holder->u.qom_object.qom_path);
> +        break;
> +    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> +        h->u.block_node.node_name =
> +            g_strdup(holder->u.block_node.node_name);
> +        break;
> +    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> +        h->u.monitor_name.monitor_name =
> +            g_strdup(holder->u.monitor_name.monitor_name);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }

This makes @h a deep copy of @holder.  Try

    IOThreadHolder *h = QAPI_CLONE(IOThreadHolder, holder);

instead.

Instead of making a copy, the function could take ownership of @holder,
and require @holder's members to be dynamically allocated.  More
efficient, but complicates the callers somewhat.  Not worthwhile, I
guess.

> +
> +    iothread->holders = g_list_prepend(iothread->holders, h);
> +}
> +
> +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> +{
> +    const IOThreadHolder *holder_a = a;
> +    const IOThreadHolder *holder_b = b;
> +    const char *name_a, *name_b;
> +
> +    if (holder_a->type != holder_b->type) {
> +        return -1;

Please use

           return holder_b->type - holder_a->type;

Why?  By convention, an int-valued function fn() comparing A to B
returns less than 0 when A<B, 0 when A == B, and greater than 0 when
A>B.  Anything else needs a prominent comment.  Best to stick to the
convention whenever practical.

Since A < B iff B > A, we want fn(A, B) == -fn(B, A).

Your function does not satisfy that!  Harmless for now, because you only
ever pass it to g_list_find_custom(), which treats all non-zero values
the same.  But if anyone passes it to something like qsort() in the
future, they can look forward to some debugging "fun".

> +    }
> +
> +    switch (holder_a->type) {
> +    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +        name_a = holder_a->u.qom_object.qom_path;
> +        name_b = holder_b->u.qom_object.qom_path;
> +        break;
> +    case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> +        name_a = holder_a->u.block_node.node_name;
> +        name_b = holder_b->u.block_node.node_name;
> +        break;
> +    case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> +        name_a = holder_a->u.monitor_name.monitor_name;
> +        name_b = holder_b->u.monitor_name.monitor_name;
> +        break;
> +    default:
> +       /*
> +        * This should not happen. If it does, name_a/b remains
> +        * NULL and g_strcmp0 will handle it safely.
> +        */
> +        name_a = NULL;
> +        name_b = NULL;

Replace this by

           g_assert_not_reached();

Then neither @name_a nor @name_b can be null, because a non-optional
QAPI str is never null.  Simply use strcmp().

> +    }
> +
> +    return g_strcmp0(name_a, name_b);
> +}
> +
> +/*
> + * This function removes the @holder from the @iothread's tracking list.
> + * The @holder must match the one used previously in iothread_ref().
> + * It is a programming error to call this with a @holder that is not
> + * currently associated with the @iothread.
> + */
> +static void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
> +{
> +    assert(holder);
> +    GList *link = g_list_find_custom(iothread->holders, holder,
> +                                     (GCompareFunc)iothread_holder_compare);
> +
> +    assert(link);
> +
> +    IOThreadHolder *h = (IOThreadHolder *)link->data;
> +    qapi_free_IOThreadHolder(h);
> +    iothread->holders = g_list_delete_link(iothread->holders, link);

Removing @link from the list before freeing link->data would be more
obviously correct, wouldn't it?

> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread = opaque;
> @@ -356,6 +442,14 @@ char *iothread_get_id(IOThread *iothread)
>  
>  AioContext *iothread_get_aio_context(IOThread *iothread)
>  {
> +    /* Remove in next patch for build */
> +    IOThreadHolder holder = {
> +        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +        .u.qom_object.qom_path = (char *)"tmp_path",
> +    };
> +    iothread_ref(iothread, &holder);
> +    iothread_unref(iothread, &holder);

Is this really needed to make this patch work?

> +
>      return iothread->ctx;
>  }
>  
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c71a5fe657..d9f82f0922 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -67,6 +67,67 @@
>  ##
>  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
>  
> +
> +##
> +# @IOThreadHolderBlockNode:
> +#
> +# @node-name: A block node.

Let's use

   # @node-name: Name of the block node

to make it more similar to node-name descriptions elsewhere.

> +#
> +# Since: 11.1
> +#
> +##
> +{ 'struct': 'IOThreadHolderBlockNode',
> +  'data': { 'node-name': 'str' } }
> +
> +##
> +# @IOThreadHolderQomObject:
> +#
> +# @qom-path: A QOM Object.

Likewise, let's use

  # @qom-path: Path to the object in the QOM tree

> +#
> +# Since: 11.1
> +#
> +##
> +{ 'struct': 'IOThreadHolderQomObject',
> +  'data': { 'qom-path': 'str' } }
> +
> +##
> +# @IOThreadHolderMonitor:
> +#
> +# @monitor-name: A HMP/QMP monitor.

Let's use

   # @monitor-name: Name of the HMP/QMP monitor

> +#
> +# Since: 11.1
> +#
> +##
> +{ 'struct': 'IOThreadHolderMonitor',
> +  'data': { 'monitor-name': 'str' } }
> +
> +##
> +# @IOThreadHolderKind:
> +#
> +# @block-node: A block node.
> +# @qom-object: A QOM Object.
> +# @monitor-name: A HMP/QMP monitor.

Rename to @monitor for consistency with the other two.

Remark, not a request to change anything in your patch: kind monitor
will become obsolete when monitors become QOM objects.  Doing that
before we release this interface is desirable.

> +#
> +# Since: 11.1
> +##
> +{ 'enum': 'IOThreadHolderKind',
> +  'data': [ 'block-node', 'qom-object', 'monitor-name' ] }
> +
> +##
> +# @IOThreadHolder:
> +#

Let's add a short description:

   # The block node, QOM object, or monitor holding the I/O thread.

> +# @type: the kind of I/O thread holder.
> +#
> +# Since: 11.1
> +##
> +{ 'union': 'IOThreadHolder',
> +  'base': { 'type': 'IOThreadHolderKind' },
> +  'discriminator': 'type',
> +  'data': {
> +    'block-node': 'IOThreadHolderBlockNode',
> +    'qom-object': 'IOThreadHolderQomObject',
> +    'monitor-name': 'IOThreadHolderMonitor' } }
> +
>  ##
>  # @IOThreadInfo:
>  #


