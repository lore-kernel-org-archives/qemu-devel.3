Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB18CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 11:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOwPM-0003bD-Tq; Mon, 18 May 2026 07:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwP9-0003aD-P0
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wOwOv-00029u-6o
 for qemu-devel@nongnu.org; Mon, 18 May 2026 07:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779104686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yxS2hOlVCCE43jVC3QbMt/kEHOmWfGNie6mBrK10kc=;
 b=IiowVqwpJ1Oaxcn3tT+XfQGuBJb7B2qH2K5CaJTpUuhtJEO+fcKQWFQ9sGr0z4IdbQOuGh
 sWY6WJdzeN9Jn76OD78J+kj7UQTgPz9bhksuYVq/sB28DljMkhwbcCFGQrAQ2jjfoPdQY2
 wo+XY8lbFTMCgvOrGveRXNACudupxR8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-HBm4YvwdO8m1VEH9DEKhIg-1; Mon,
 18 May 2026 07:44:42 -0400
X-MC-Unique: HBm4YvwdO8m1VEH9DEKhIg-1
X-Mimecast-MFC-AGG-ID: HBm4YvwdO8m1VEH9DEKhIg_1779104681
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B7211956089; Mon, 18 May 2026 11:44:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A24230002DF; Mon, 18 May 2026 11:44:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26C0721E6A01; Mon, 18 May 2026 13:44:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  "Michael S . Tsirkin" <mst@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V7 02/14] iothread: introduce iothread_ref/unref to
 track attached devices
In-Reply-To: <20260511140416.28271-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 11 May 2026 22:04:04 +0800")
References: <20260511140416.28271-1-zhangckid@gmail.com>
 <20260511140416.28271-3-zhangckid@gmail.com>
Date: Mon, 18 May 2026 13:44:38 +0200
Message-ID: <877bp1uel5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> A later commit will add QMP commands to let management applications
> query the attachment status of IOThreads.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  include/system/iothread.h |  5 +++
>  iothread.c                | 67 +++++++++++++++++++++++++++++++++++++++
>  qapi/misc.json            | 48 ++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+)
>
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index a1ef7696cb..2871b06edc 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -50,6 +50,11 @@ struct IOThread {
>      bool stopping;              /* has iothread_stop() been called? */
>      bool running;               /* should iothread_run() continue? */
>      int thread_id;
> +    /*
> +     * The list elements are of type IoThreadHolder, which can
> +     * represent either a QOM path or a block node name.
> +     */
> +    GList *holders;
>=20=20
>      /* AioContext poll parameters */
>      int64_t poll_max_ns;
> diff --git a/iothread.c b/iothread.c
> index 3558535b40..b805e4f97d 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -25,6 +25,66 @@
>  #include "qemu/rcu.h"
>  #include "qemu/main-loop.h"
>=20=20
> +/*
> + * Add the @holder path to the iothread's tracking list.
> + * The @holder is a QOM path if it starts with '/', else a block node na=
me.
> + */

This interface overloads two string keys: QOM paths and block node
names.  For that to work, a key value must be unambiguously either QOM
path or block node name.  To get that, you restrict QOM path to
absolute.  Not exactly pretty, but it works.

What if you ever need to add another kind of holder?

Any new kind of holder would need a string key that cannot start with
'/', and cannot clash with block node names.  You'd either have to redo
this interface, or outlaw the clashes.

PATCH 06 in fact adds a new kind of holder: monitors.  To keep this
interface working, it uses made-up QOM paths as keys.  This is cheating.

Daniel Berrang=C3=A9 posted a series that turns monitors into QOM objects.
If it gets merged, your series can be fixed not to cheat.

More in review of PATCH 06.

> +static void iothread_ref(IOThread *iothread, const char *holder)
> +{
> +    IoThreadHolder *h =3D g_new0(IoThreadHolder, 1);
> +
> +    assert(holder);
> +
> +    if (holder[0] =3D=3D '/') {
> +        h->type =3D IO_THREAD_HOLDER_KIND_QOM_OBJECT;
> +        h->u.qom_object.data =3D g_strdup(holder);
> +    } else {
> +        h->type =3D IO_THREAD_HOLDER_KIND_BLOCK_NODE;
> +        h->u.block_node.data =3D g_strdup(holder);
> +    }
> +
> +    iothread->holders =3D g_list_prepend(iothread->holders, h);
> +}
> +
> +static int iothread_holder_compare(gconstpointer a, gconstpointer b)
> +{
> +    const IoThreadHolder *holder_node =3D a;
> +    const char *target_name =3D b;
> +    const char *current_name;
> +
> +    if (holder_node->type =3D=3D IO_THREAD_HOLDER_KIND_QOM_OBJECT) {
> +        current_name =3D holder_node->u.qom_object.data;
> +    } else if (holder_node->type =3D=3D IO_THREAD_HOLDER_KIND_BLOCK_NODE=
) {
> +        current_name =3D holder_node->u.block_node.data;
> +    } else {
> +        /*
> +         * This should not happen. If it does, current_name remains
> +         * NULL and g_strcmp0 will handle it safely.
> +         */
> +        current_name =3D NULL;
> +    }
> +
> +    return g_strcmp0(current_name, target_name);
> +}
> +
> +/*
> + * This function removes the @holder from the @iothread's tracking list.
> + * The @holder string must match the one used previously in iothread_ref=
).
> + * It is a programming error to call this with a @holder that is not
> + * currently associated with the @iothread.
> + */
> +static void iothread_unref(IOThread *iothread, const char *holder)
> +{
> +    GList *link =3D g_list_find_custom(iothread->holders, holder,
> +                                     (GCompareFunc)iothread_holder_compa=
re);
> +
> +    assert(link);
> +
> +    IoThreadHolder *h =3D (IoThreadHolder *)link->data;
> +    qapi_free_IoThreadHolder(h);
> +    iothread->holders =3D g_list_delete_link(iothread->holders, link);
> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread =3D opaque;
> @@ -108,6 +168,9 @@ static void iothread_instance_finalize(Object *obj)
>=20=20
>      iothread_stop(iothread);
>=20=20
> +    /* We don't support finalize without holders */
> +    assert(iothread->holders =3D=3D NULL);

The comment seems to say "no holders is not supposed to happen".

The assertion says "holders is not supposed to happen".

Which one is wrong?

> +
>      /*
>       * Before glib2 2.33.10, there is a glib2 bug that GSource context
>       * pointer may not be cleared even if the context has already been
> @@ -356,6 +419,10 @@ char *iothread_get_id(IOThread *iothread)
>=20=20
>  AioContext *iothread_get_aio_context(IOThread *iothread)
>  {
> +    /* Remove in next patch for build */
> +    iothread_ref(iothread, "tmp");
> +    iothread_unref(iothread, "tmp");
> +
>      return iothread->ctx;
>  }
>=20=20
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c71a5fe657..5fb7dcfcad 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -67,6 +67,54 @@
>  ##
>  { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': tru=
e }
>=20=20
> +
> +##
> +# @IoThreadHolderBlockNode:
> +#
> +# @data: Block node name.

Could we name this @node-name?

> +#
> +# Since: 11.1
> +#
> +##
> +{ 'struct': 'IoThreadHolderBlockNode',
> +  'data': { 'data': 'str' } }
> +
> +##
> +# @IoThreadHolderQomObject:
> +#
> +# @data: Absolute @qom-path.

Could we name this @qom-path?

> +#
> +# Since: 11.1
> +#
> +##
> +{ 'struct': 'IoThreadHolderQomObject',
> +  'data': { 'data': 'str' } }
> +
> +##
> +# @IoThreadHolderKind:
> +#
> +# @block-node: Block node name.
> +# @qom-object: Absolute @qom-path.

Let's use

   # @block-node: A block node
   #
   # @qom-object: A QOM Object

> +#
> +# Since: 11.1
> +##
> +{ 'enum': 'IoThreadHolderKind',
> +  'data': [ 'block-node', 'qom-object' ] }
> +
> +##
> +# @IoThreadHolder:
> +#
> +# @type: the kind of I/O thread holder.
> +#
> +# Since: 11.1
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


