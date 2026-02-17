Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03239E63F2B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 07:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsFrb-0000SS-PC; Tue, 17 Feb 2026 02:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsFrX-0000SG-UZ
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 02:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vsFrW-0003KX-9k
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 02:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771314672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Phars+mJG5yKR/1oErrVSZdj1G7B6wUb3lqEpzYli/A=;
 b=VILAWZSzzc/ELE1FkZ9kMKuxIb1pkuccihQZPzE5ry/Eg1mndT/uYAW1ujgQE5XXJNVw8E
 pB+JlymQuGcW7iG+joaczs6O7IaPRq8r7mnhmhmMVPWfjGhYXv10kv82aUMltXoChx2sLC
 7OnGCG6g6B4kw46+RDF2XJwX0yKXguU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-2CD2rHs9M3qzZrSsHMpxaA-1; Tue,
 17 Feb 2026 02:51:08 -0500
X-MC-Unique: 2CD2rHs9M3qzZrSsHMpxaA-1
X-Mimecast-MFC-AGG-ID: 2CD2rHs9M3qzZrSsHMpxaA_1771314667
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EC7E1956052; Tue, 17 Feb 2026 07:51:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B26BF1800348; Tue, 17 Feb 2026 07:51:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A00021E692D; Tue, 17 Feb 2026 08:51:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
In-Reply-To: <20260213171622.55629-4-zhangckid@gmail.com> (Zhang Chen's
 message of "Sat, 14 Feb 2026 01:16:22 +0800")
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-4-zhangckid@gmail.com>
Date: Tue, 17 Feb 2026 08:51:04 +0100
Message-ID: <87wm0bq047.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Extend the 'IOThreadInfo' structure to include attachment metrics.
> This allows users to monitor how many devices are associated with
> a specific IOThread and identify them by their QOM paths.
>
> New fields added to IOThreadInfo:
> - @attached-cnt: An integer representing the number of devices
>   currently using this IOThread's AioContext.
> - @attached-dev: A string containing a delimited list ("|") of
>   QOM paths for the attached devices.
>
> These fields are also exposed via the Human Monitor Interface (HMP)
> command 'info iothreads' to assist with manual debugging and
> performance tuning.
>
> Example QMP output:
> {
>     "id": "iothread0",
>     "thread-id": 3134,
>     "attached-cnt": 2,
>     "attached-dev": "/machine/peripheral/blk1/virtio-backend | /machine/peripheral/blk0/virtio-backend",
>     ...
> }
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 1f5062df2a..ca53638684 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -76,6 +76,19 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @attached-cnt: The parameter is a counter indicating how many
> +#     active devices are currently associated with this iothread
> +#     (e.g. virtio-blk).  In hotplug scenarios, users can
> +#     pre-allocate multiple iothread objects to serve as a persistent
> +#     thread pool.  When a device is hot-unplugged, the corresponding
> +#     IOThread is released but remains available, allowing subsequent
> +#     hot-plugged devices to attach to and reuse the existing thread.
> +#     (since 11.0)
> +#
> +# @attached-dev: A list of QOM paths for the devices currently
> +#     associated with this IOThread, delimited by " | ".
> +#     Returns "none" if no devices are attached. (since 11.0)

QAPI schema design maxim: do not encode structured data as strings.
@attached-devs should be an array of QOM paths instead.

Unless I misunderstand your docs, @attached-cnt is the number of QOM
paths in @attached-dev, i.e. @attached-dev is redundant.  If this is the
case, drop it.  If it isn't, educate me :)

We generally avoid abbreviations in the QAPI schema: @attached-count,
@attached-devices.

> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -93,6 +106,8 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'attached-cnt': 'int',
> +           'attached-dev': 'str',
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -118,6 +133,8 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "attached-cnt":2,
> +#                 "attached-dev":/machine/peripheral/blk1/virtio-backend | /machine/peripheral/blk0/virtio-backend,

Once again, the example is syntactically incorrect (the value lacks
double quotes), and once again I recommend to create example I/O by
actually running a test.  Getting tired of this, to be frank.

>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -126,6 +143,8 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "attached-cnt":1,
> +#                 "attached-dev":/machine/peripheral/blk3/virtio-backend,

Likewise.

>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,


