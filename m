Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B5D185E8
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 12:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdosG-0005ZN-5F; Thu, 08 Jan 2026 07:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdosE-0005Z7-A8
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:12:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdosA-0005Bi-Si
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 07:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767874333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VBiQ372Yp611HcJjI0MS7+eo0ZjF5++swn5BALlKPoE=;
 b=YiPAUf1VBk9swDmI+C7o7BsnURGbudYSy94Q/hUTHEW17meYxZVgEmGDjbWOUkmzqwAV1I
 kkhXD6yKuF5F64vdr0Q5xA7mdoyl423oLS8qX+xbKFmAFz+FpvjVAEFGYMR4bMdP3KXxxU
 HGNO9QTjxvVBnxO1y1zbXaInDUOFzVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-1QxGD1YLPdeIv99LpY9GZw-1; Thu,
 08 Jan 2026 07:12:09 -0500
X-MC-Unique: 1QxGD1YLPdeIv99LpY9GZw-1
X-Mimecast-MFC-AGG-ID: 1QxGD1YLPdeIv99LpY9GZw_1767874329
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBDB919560B7; Thu,  8 Jan 2026 12:12:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 616DD30002D1; Thu,  8 Jan 2026 12:12:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E63E721E6937; Thu, 08 Jan 2026 13:12:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 3/3] qapi: Add thread_status flag for iothreads
In-Reply-To: <20251229103859.98777-3-zhangckid@gmail.com> (Zhang Chen's
 message of "Mon, 29 Dec 2025 18:38:59 +0800")
References: <20251229103859.98777-1-zhangckid@gmail.com>
 <20251229103859.98777-3-zhangckid@gmail.com>
Date: Thu, 08 Jan 2026 13:12:05 +0100
Message-ID: <877bts8fsa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

> The thread_status depends on struct IOThreadInfo's
> 'attached': 'bool'. Show in the qmp/hmp CMD with
> 'attached' or 'detached'.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  iothread.c         | 1 +
>  monitor/hmp-cmds.c | 2 ++
>  qapi/misc.json     | 6 ++++++
>  3 files changed, 9 insertions(+)
>
> diff --git a/iothread.c b/iothread.c
> index 38e38fb44d..fb4898e491 100644
> --- a/iothread.c
> +++ b/iothread.c
> @@ -358,6 +358,7 @@ static int query_one_iothread(Object *object, void *opaque)
>      info = g_new0(IOThreadInfo, 1);
>      info->id = iothread_get_id(iothread);
>      info->thread_id = iothread->thread_id;
> +    info->attached = iothread->attached;
>      info->poll_max_ns = iothread->poll_max_ns;
>      info->poll_grow = iothread->poll_grow;
>      info->poll_shrink = iothread->poll_shrink;
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 33a88ce205..84b01737cf 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -197,6 +197,8 @@ void hmp_info_iothreads(Monitor *mon, const QDict *qdict)
>          value = info->value;
>          monitor_printf(mon, "%s:\n", value->id);
>          monitor_printf(mon, "  thread_id=%" PRId64 "\n", value->thread_id);
> +        monitor_printf(mon, "  thread_status=%s" "\n",
> +                       value->attached ? "attached" : "detached");
>          monitor_printf(mon, "  poll-max-ns=%" PRId64 "\n", value->poll_max_ns);
>          monitor_printf(mon, "  poll-grow=%" PRId64 "\n", value->poll_grow);
>          monitor_printf(mon, "  poll-shrink=%" PRId64 "\n", value->poll_shrink);
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 6153ed3d04..2eea920bd2 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -76,6 +76,9 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @attached: flag to show current iothread attached status

What does "attached status" actually mean?

> +#            (since 10.3.0)

(since 12.0)

> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -93,6 +96,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'attached': 'bool',
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -118,6 +122,7 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 'thread_status':"attached",

I believe this is actually

                     "attached": true

and ...

>  #                 'poll-max-ns':0,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -126,6 +131,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 'thread_status':"detached",

                     "attached": false

Recommend to create example output by running a test instead of making
it up, because making it up likely screws it up :)

>  #                 'poll-max-ns':0,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,


