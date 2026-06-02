Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DBECD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUT0s-0000qS-Vf; Tue, 02 Jun 2026 13:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUT0d-0000on-KL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUT0Z-0005if-Ki
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780421670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cZy1Kro50qm2gmEWw1tL+CSfTMjP2o5is92673TVmw=;
 b=anB+BWFFy8OkhzDe8MAe5lcs3XAbUN+ElW0KH21AsgS8fK3T6Qv3AzsYI9NE0rkwMSkwpv
 ijLkzh+4oc8EXWgYtxWNe1PJr71JQWnrWKFGwOVpCTH36EfhukgEwAwj2Wtc4Znnm1CWcF
 W1yWI/V75g+G+2C0AFvB8/Wv9dtLYs8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-UkvpSNw_MEq4Ze7dhrjKPw-1; Tue,
 02 Jun 2026 13:34:28 -0400
X-MC-Unique: UkvpSNw_MEq4Ze7dhrjKPw-1
X-Mimecast-MFC-AGG-ID: UkvpSNw_MEq4Ze7dhrjKPw_1780421667
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72F0919560A5; Tue,  2 Jun 2026 17:34:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A01A11687; Tue,  2 Jun 2026 17:34:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A5EC21E6A01; Tue, 02 Jun 2026 19:34:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V8 14/15] qapi: examine IOThread attachment status via
 query-iothreads
In-Reply-To: <20260529213321.96271-15-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 30 May 2026 05:33:20 +0800")
References: <20260529213321.96271-1-zhangckid@gmail.com>
 <20260529213321.96271-15-zhangckid@gmail.com>
Date: Tue, 02 Jun 2026 19:34:24 +0200
Message-ID: <87jysgrgm7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Zhang Chen <zhangckid@gmail.com> writes:

> Extend the 'IOThreadInfo' structure to include attachment metrics.
> This allows users to monitor the associated devices by identify them
> by their QOM paths.

Should we mention block nodes and monitors, too?

>
> New fields added to IOThreadInfo:
>  @holders: IOThreadHolder of the devices currently associated with
>      this iothread.  Users can pre-allocate multiple iothread objects
>      to serve as a persistent thread pool.  When a device is hot-unplugge=
d,
>      it is detached from its iothread, but the iothread remains available,
>      allowing future hot-plugged devices to attach to it.  (Since 11.1)
>
> These fields are also exposed via the Human Monitor Interface (HMP)
> command 'info iothreads' to assist with manual debugging and
> performance tuning.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  iothread.c         | 22 ++++++++++++++++++++++
>  monitor/hmp-cmds.c | 26 ++++++++++++++++++++++++++
>  qapi/misc.json     | 11 +++++++++++
>  3 files changed, 59 insertions(+)
>
> diff --git a/iothread.c b/iothread.c
> index a85e960e45..5949785b32 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -24,6 +24,8 @@
>  #include "qemu/error-report.h"
>  #include "qemu/rcu.h"
>  #include "qemu/main-loop.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qapi-visit-misc.h"
>=20=20
>  /*
>   * iothread_ref:
> @@ -119,6 +121,25 @@ static void iothread_unref(IOThread *iothread, const=
 IOThreadHolder *holder)
>      object_unref(OBJECT(iothread));
>  }
>=20=20
> +static IOThreadHolderList *iothread_get_holders_list(IOThread *iothread)
> +{
> +    IOThreadHolderList *head =3D NULL;
> +    IOThreadHolderList **prev =3D &head;
> +    GList *l;
> +
> +    for (l =3D iothread->holders; l; l =3D l->next) {
> +        IOThreadHolder *src =3D l->data;
> +        IOThreadHolderList *entry =3D g_new0(IOThreadHolderList, 1);
> +
> +        entry->value =3D QAPI_CLONE(IOThreadHolder, src);
> +
> +        *prev =3D entry;
> +        prev =3D &entry->next;
> +    }

If iothread->holders was a IOThreadHolderList instead of a GList, this
loop could be QAPI_CLONE(IOThreadHolderList, iothread->holders) instead.

> +
> +    return head;
> +}
> +
>  static void *iothread_run(void *opaque)
>  {
>      IOThread *iothread =3D opaque;
> @@ -488,6 +509,7 @@ static int query_one_iothread(Object *object, void *o=
paque)
>      info =3D g_new0(IOThreadInfo, 1);
>      info->id =3D iothread_get_id(iothread);
>      info->thread_id =3D iothread->thread_id;
> +    info->holders =3D iothread_get_holders_list(iothread);
>      info->poll_max_ns =3D iothread->poll_max_ns;
>      info->poll_grow =3D iothread->poll_grow;
>      info->poll_shrink =3D iothread->poll_shrink;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 443b8c785d..1b5883147b 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -237,11 +237,37 @@ void hmp_info_iothreads(Monitor *mon, const QDict *=
qdict)
>      IOThreadInfoList *info_list =3D qmp_query_iothreads(NULL);
>      IOThreadInfoList *info;
>      IOThreadInfo *value;
> +    IOThreadHolderList *h;
>=20=20
>      for (info =3D info_list; info; info =3D info->next) {
>          value =3D info->value;
>          monitor_printf(mon, "%s:\n", value->id);
>          monitor_printf(mon, "  thread_id=3D%" PRId64 "\n", value->thread=
_id);
> +        monitor_printf(mon, "  holders=3D");
> +        if (value->holders) {
> +            for (h =3D value->holders; h; h =3D h->next) {
> +                IOThreadHolder *holder =3D h->value;
> +
> +                switch (holder->type) {
> +                case IO_THREAD_HOLDER_KIND_BLOCK_NODE:
> +                    monitor_printf(mon, "[block-node: %s]",
> +                                   holder->u.block_node.node_name);
> +                    break;
> +                case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
> +                    monitor_printf(mon, "[qom-path: %s]",
> +                                   holder->u.qom_object.qom_path);
> +                    break;
> +                case IO_THREAD_HOLDER_KIND_MONITOR_NAME:
> +                    monitor_printf(mon, "[monitor-name: %s]",
> +                                   holder->u.monitor_name.monitor_name);
> +                    break;
> +                default:
> +                    monitor_printf(mon, "[unknown]");
> +                    break;
> +                }
> +            }
> +            monitor_printf(mon, "\n");
> +        }
>          monitor_printf(mon, "  poll-max-ns=3D%" PRId64 "\n", value->poll=
_max_ns);
>          monitor_printf(mon, "  poll-grow=3D%" PRId64 "\n", value->poll_g=
row);
>          monitor_printf(mon, "  poll-shrink=3D%" PRId64 "\n", value->poll=
_shrink);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index d9f82f0922..4c16be3fd4 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -137,6 +137,13 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @holders: IOThreadHolder of the devices currently associated with

This is rendered like

    =E2=80=A2 holders ([IOThreadHolder]) =E2=80=93 IOThreadHolder of the de=
vices currently associated with

Better use something like

   # @holders: the devices currently associated with ...

I'm not sure about "devices", though.  It's QOM objects, block nodes,
and monitors.  Perhaps the QOM objects are all be devices (subtypes of
TYPE_DEVICE), but I'd have to dig through your patches to be sure.  Does
it matter?

> +#     this iothread.  Users can pre-allocate multiple iothread objects
> +#     to serve as a persistent thread pool.  When a device is
> +#     hot-unplugged, it is detached from its iothread, but the
> +#     iothread remains available, allowing future hot-plugged devices
> +#     to attach to it.  (Since 11.1)

This may need to be rewritten with block nodes and monitors in mind.

> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -159,6 +166,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'holders': ['IOThreadHolder'],
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -185,6 +193,8 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "holders":[{"qom-path": "/machine/peripheral/blk1/virt=
io-backend", "type": "qom-object"},
> +#                            {"qom-path": "/machine/peripheral/blk0/virt=
io-backend", "type": "qom-object"}],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -193,6 +203,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "holders":[{"qom-path": "/machine/peripheral/blk2/virt=
io-backend", "type": "qom-object"}],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,

Would it be useful if one of these examples was a block node?


