Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53EEFCD0B4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2k66-00085E-R0; Wed, 18 Mar 2026 02:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2k65-00084i-0V
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2k63-0005eU-0U
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 02:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773814173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B7d/4IIKOs5x4vpYZz2T+iMjWHF8DJu3oifTs2yhIaU=;
 b=ZEQNpa2Q/gquA4/35/EtnHnwz6YhY/usztH1JqCUCzvFz+7bSw7HlTXck3O41GhsxZsVHF
 lQlp1ZmiuNHVYyIfRG7BS5kS3oQmdgtTg9XPvLWbzcScFpr+8V6MSSiL4Aztiql/4wFMVB
 NIT0d/EYlS28okPT5fNL/44OjO50Roo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-1-K00ulWNz6Q35p80ou8ew-1; Wed,
 18 Mar 2026 02:09:29 -0400
X-MC-Unique: 1-K00ulWNz6Q35p80ou8ew-1
X-Mimecast-MFC-AGG-ID: 1-K00ulWNz6Q35p80ou8ew_1773814168
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79F461956048; Wed, 18 Mar 2026 06:09:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DC019560AB; Wed, 18 Mar 2026 06:09:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9F21921E6937; Wed, 18 Mar 2026 07:09:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  "Dr . David Alan Gilbert"
 <dave@treblig.org>,  Eric Blake <eblake@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V5 13/13] qapi: examine IOThread attachment status via
 query-iothreads
In-Reply-To: <20260305142459.52559-14-zhangckid@gmail.com> (Zhang Chen's
 message of "Thu, 5 Mar 2026 22:24:59 +0800")
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-14-zhangckid@gmail.com>
Date: Wed, 18 Mar 2026 07:09:25 +0100
Message-ID: <87o6klfz3e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>
> New fields added to IOThreadInfo:
> - @holders: A string containing of QOM paths for the attached devices.
>
> These fields are also exposed via the Human Monitor Interface (HMP)
> command 'info iothreads' to assist with manual debugging and
> performance tuning.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 1f5062df2a..a381074c04 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -76,6 +76,15 @@
>  #
>  # @thread-id: ID of the underlying host thread
>  #
> +# @holders: The parameter is an array of QOM paths indicating how many
> +#     active devices are currently associated with this iothread
> +#     (e.g. virtio-blk).  In hotplug scenarios, users can
> +#     pre-allocate multiple iothread objects to serve as a persistent
> +#     thread pool.  When a device is hot-unplugged, the corresponding
> +#     IOThread is released but remains available, allowing subsequent
> +#     hot-plugged devices to attach to and reuse the existing thread.
> +#     Returns empty if no devices are attached.  (since 11.0)

Let me try to polish this a bit:

   # @holders: QOM paths of the devices currently associated with this
   #     iothread.  Users can pre-allocate multiple iothread objects to
   #     serve as a persistent thread pool.  When a device is
   #     hot-unplugged, it is detached from its iothread, but the
   #     iothread remains available, allowing future hot-plugged devices
   #     to attach to it.

> +#
>  # @poll-max-ns: maximum polling time in ns, 0 means polling is
>  #     disabled (since 2.9)
>  #
> @@ -93,6 +102,7 @@
>  { 'struct': 'IOThreadInfo',
>    'data': {'id': 'str',
>             'thread-id': 'int',
> +           'holders': ['str'],
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> @@ -118,6 +128,8 @@
>  #              {
>  #                 "id":"iothread0",
>  #                 "thread-id":3134,
> +#                 "holders":["/machine/peripheral/blk1/virtio-backend",
> +#                            "/machine/peripheral/blk0/virtio-backend"],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,
> @@ -126,6 +138,7 @@
>  #              {
>  #                 "id":"iothread1",
>  #                 "thread-id":3135,
> +#                 "holders":["/machine/peripheral/blk2/virtio-backend"],
>  #                 "poll-max-ns":32768,
>  #                 "poll-grow":0,
>  #                 "poll-shrink":0,

With a bit of doc polish:
Acked-by: Markus Armbruster <armbru@redhat.com>


