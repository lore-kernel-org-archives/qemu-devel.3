Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B00F8FA78
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 14:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFBtD-0004dv-0C; Tue, 21 Apr 2026 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFBt9-0004dl-3u
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wFBt7-0005Tp-4M
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 10:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776780937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bJMRXv0dcMT1KtICRVzHj4Y/ZZV1U8fIxXi3a79kyvY=;
 b=ZSaZH/sZ6k1RLX4j41u+ve/PYZ2uPT+MKRbUQvmh349DDBc3JtLt/dBGrD1N39BmCDniiR
 3cZ6x4AIBayAGWgO4hRmRMcUm9HjglP+i3LzKBQekI+wn3Wr0pMxmp6v+PSynRjy0r44Rk
 iSaMyI9WJvnNznaBD8sU0Kdr8MCqL0s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-iNyL1On4OOuhbE1Lzokgmw-1; Tue,
 21 Apr 2026 10:15:34 -0400
X-MC-Unique: iNyL1On4OOuhbE1Lzokgmw-1
X-Mimecast-MFC-AGG-ID: iNyL1On4OOuhbE1Lzokgmw_1776780933
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B382195608F; Tue, 21 Apr 2026 14:15:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 531073000C15; Tue, 21 Apr 2026 14:15:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E51A121E6A28; Tue, 21 Apr 2026 16:15:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V6 02/14] iothread: introduce iothread_ref/unref to
 track attached devices
In-Reply-To: <20260410150457.85190-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Fri, 10 Apr 2026 23:04:45 +0800")
References: <20260410150457.85190-1-zhangckid@gmail.com>
 <20260410150457.85190-3-zhangckid@gmail.com>
Date: Tue, 21 Apr 2026 16:15:29 +0200
Message-ID: <87bjfc4cxq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Currently, IOThreads do not maintain a record of which devices are
> associated with them. This makes it difficult to monitor the
> workload distribution of IOThreads, especially in complex
> hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.
>
> This patch introduces a reference counting and tracking mechanism
> within the IOThread object:
>
> - iothread_ref(): Prepends the device's QOM path to a list.
> - iothread_unref(): Searches for the device path using a custom
>   string comparison (g_strcmp0), releases the associated memory
>   upon a successful match.
> - holders: A GList storing the QOM paths of attached devices
>   for runtime introspection.
>
> This infrastructure allows management tools and QMP commands to
> query the attachment status of IOThreads.

Suggest something like

  A later commit will add QMP commands to let management applications
  query the attachment status of IOThreads.
  
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  1 +
>  iothread.c                | 56 +++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json            | 48 +++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index e26d13c6c7..21a76bd70d 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -33,6 +33,7 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    GList *holders;             /* an array of QOM paths for attached devices */

The comment is mostly wrong.  A GList is not an array.  The list
elements are of type IoThreadHolder, which can represent either a QOM
path or a block node name.  Suggest

       GList *holders;             /* list of IoThreadHolder */

>  
>      /* AioContext poll parameters */
>      int64_t poll_max_ns;
> diff --git a/iothread.c b/iothread.c
> index caf68e0764..c43266b191 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -36,6 +36,55 @@
>  #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
>  #endif
>  
> +/*
> + * Add holder device path to the list.

Please explain semantics of parameter @holder here, it's not obvious
that @holder is a QOM path if it starts with '/', else a block node
name.

Restriction: only absolute QOM paths work.  Relative ones get
misinterpreted as block node names.

> + */
> +static void iothread_ref(IOThread *iothread, const char *holder)
> +{
> +    IoThreadHolder *h = g_new0(IoThreadHolder, 1);
> +
> +    if (holder && holder[0] == '/') {
> +        h->type = IO_THREAD_HOLDER_KIND_QOM_OBJECT;
> +        h->u.qom_object.data = g_strdup(holder);
> +    } else {
> +        h->type = IO_THREAD_HOLDER_KIND_BLOCK_NODE;
> +        h->u.block_node.data = g_strdup(holder ? holder : "unknown");

No.  Nothing stops a user from naming a block node "unknown".

How can !holder happen?  If it's not supposed to happen, assert() it
doesn't!

> +    }
> +
> +    iothread->holders = g_list_prepend(iothread->holders, h);
> +}
> +
> +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> +{
> +    const IoThreadHolder *holder_node = a;
> +    const char *target_name = b;
> +    const char *current_name = NULL;

Superfluous initializer.

> +
> +    if (holder_node->type == IO_THREAD_HOLDER_KIND_QOM_OBJECT) {
> +        current_name = holder_node->u.qom_object.data;
> +    } else if (holder_node->type == IO_THREAD_HOLDER_KIND_BLOCK_NODE) {
> +        current_name = holder_node->u.block_node.data;
> +    }
> +
> +    return g_strcmp0(current_name, target_name);

Why g_strcmp0()?  How can any of the arguments be null?

> +}
> +
> +/*
> + * Delete holder device path from the list.

Please explain semantics of @holder as for iothread_ref(), and state
that a it must be one of @io_thread's holders.

> + */
> +static void iothread_unref(IOThread *iothread, const char *holder)
> +{
> +    GList *link = g_list_find_custom(iothread->holders, holder,
> +                                     (GCompareFunc)iothread_holder_compare);
> +
> +    /* We don't support unref without a link */

I doubt this comment is useful.

> +    assert(link);
> +
> +    IoThreadHolder *h = (IoThreadHolder *)link->data;
> +    qapi_free_IoThreadHolder(h);
> +    iothread->holders = g_list_delete_link(iothread->holders, link);
> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread = opaque;
> @@ -115,6 +164,9 @@ static void iothread_instance_finalize(Object *obj)
>  
>      iothread_stop(iothread);
>  
> +    /* We don't support finalize without holders */

Why?

> +    assert(iothread->holders == NULL);
> +
>      /*
>       * Before glib2 2.33.10, there is a glib2 bug that GSource context
>       * pointer may not be cleared even if the context has already been
> @@ -336,6 +388,10 @@ char *iothread_get_id(IOThread *iothread)
>  
>  AioContext *iothread_get_aio_context(IOThread *iothread)
>  {
> +    /* Remove in next patch for build */
> +    iothread_ref(iothread, "tmp");
> +    iothread_unref(iothread, "tmp");
> +
>      return iothread->ctx;
>  }
>  
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 1f5062df2a..d65d8012b2 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -67,6 +67,54 @@
>  ##
>  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
>  
> +
> +##
> +# @IoThreadHolderBlockNode:
> +#
> +# @data: Block node name.

These are commonly named @node-name.

> +#
> +# Since: 11.0
> +#
> +##
> +{ 'struct': 'IoThreadHolderBlockNode',
> +  'data': { 'data': 'str' } }
> +
> +##
> +# @IoThreadHolderQomObject:
> +#
> +# @data: QOM path.

These are commonly named @qom-path.

Should we use "Absolute QOM path" here?  Relative ones don't actually
work.

> +#
> +# Since: 11.0
> +#
> +##
> +{ 'struct': 'IoThreadHolderQomObject',
> +  'data': { 'data': 'str' } }
> +
> +##
> +# @IoThreadHolderKind:
> +#
> +# @block-node: Block node name.

The block node name is not the holder, the block node is.

> +# @qom-object: Standard QOM path.

What do you mean by "standard"?

> +#
> +# Since: 11.0
> +##
> +{ 'enum': 'IoThreadHolderKind',
> +  'data': [ 'block-node', 'qom-object' ] }
> +
> +##
> +# @IoThreadHolder:
> +#
> +# @type: Current IoThread holder type support QOM path and Block node.

Awkward English :)

   # @type: the kind of I/O thread holder

isn't exactly great, either.  But I'm out of time for today.

> +#
> +# Since: 11.0
> +##
> +{ 'union': 'IoThreadHolder',
> +  'base': { 'type': 'IoThreadHolderKind' },
> +  'discriminator': 'type',
> +  'data': {
> +    'block-node': 'IoThreadHolderBlockNode',
> +    'qom-object': 'IoThreadHolderQomObject' } }
> +
>  ##
>  # @IOThreadInfo:
>  #


