Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1AA106B53F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 14:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Oqa-000510-7e; Wed, 25 Mar 2026 10:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5OqY-00050G-H7
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w5OqU-0000wH-Ab
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 10:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774447464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1R7mTulkhK8/TSM0U1Ck7YjzmrYxyDqutiTOYN/p0Xc=;
 b=ftUJSUkKNgmn6qOOoTAe1GnCfw88AuQovoqCTab6S5f6GFa18E42uoIFeRpwQlS4gJt+cj
 2W3AQhg3KS+eC98dlKib7uvK871r7i15pMqQ/jJc72IOc8T+XLQKhRa+ZDuerdm3wN7f0t
 +OnpK/8sPXi4TsAbUSE13/eTnme0EJ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-jcHYMI8UN4G356iCIg7Z7Q-1; Wed,
 25 Mar 2026 10:04:17 -0400
X-MC-Unique: jcHYMI8UN4G356iCIg7Z7Q-1
X-Mimecast-MFC-AGG-ID: jcHYMI8UN4G356iCIg7Z7Q_1774447455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B767180049D; Wed, 25 Mar 2026 14:04:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0D8419560B1; Wed, 25 Mar 2026 14:04:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99D9B21E6937; Wed, 25 Mar 2026 15:04:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  mjrosato@linux.ibm.com,
 farman@linux.ibm.com,  pbonzini@redhat.com,  stefanha@redhat.com,
 fam@euphon.net,  armbru@redhat.com,  eblake@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 sw@weilnetz.de
Subject: Re: [PATCH RFC v2 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
In-Reply-To: <20260323135451.579655-4-jhkim@linux.ibm.com> (Jaehoon Kim's
 message of "Mon, 23 Mar 2026 08:54:51 -0500")
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-4-jhkim@linux.ibm.com>
Date: Wed, 25 Mar 2026 15:04:10 +0100
Message-ID: <87o6kckntx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jaehoon Kim <jhkim@linux.ibm.com> writes:

> Introduce a configurable poll-weight parameter for adaptive polling
> in IOThread. This parameter replaces the hardcoded POLL_WEIGHT_SHIFT
> constant, allowing runtime control over how much the most recent
> event interval affects the next polling duration calculation.
>
> The poll-weight parameter uses a shift value where larger values
> decrease the weight of the current interval, enabling more gradual
> adjustments. When set to 0, a default value of 3 is used (meaning
> the current interval contributes approximately 1/8 to the weighted
> average).
>
> This patch also removes the hardcoded default values for poll-grow
> and poll-shrink parameters from the grow_polling_time() and
> shrink_polling_time() functions, as these defaults are now properly
> initialized in iothread.c during IOThread creation.
>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 28c641fe2f..39d17010bc 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -85,6 +85,12 @@

Note: this is IOThreadInfo, used only as return value of
query-iothreads.

>  # @poll-shrink: how many ns will be removed from polling time, 0 means
>  #     that it's not configured (since 2.9)
>  #
> +# @poll-weight: the weight factor for adaptive polling.
> +#     Determines how much the current event interval contributes to
> +#     the next polling time calculation.  Valid values are 1 or
> +#     greater.  0 selects the system default value which is current 3

Does query-iothreads actually return 0?  I'd expect it to return the
value that is actually used.

> +#     (since 10.2)

11.1 most likely.

> +#
>  # @aio-max-batch: maximum number of requests in a batch for the AIO
>  #     engine, 0 means that the engine will use its default (since 6.1)
>  #
> @@ -96,6 +102,7 @@
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> +           'poll-weight': 'int',
>             'aio-max-batch': 'int' } }
>  
>  ##
> diff --git a/qapi/qom.json b/qapi/qom.json
> index c653248f85..feb80b6cfe 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -606,6 +606,11 @@
>  #     algorithm detects it is spending too long polling without
>  #     encountering events.  0 selects a default behaviour (default: 0)
>  #
> +# @poll-weight: the weight factor for adaptive polling.
> +#     Determines how much the current event interval contributes to
> +#     the next polling time calculation.  Valid values are 1 or
> +#     greater.  If set to 0, the default value of 3 is used.

The commit message hints what the valid values mean, the doc comment
doesn't even that.  Do users need to know?

Code [*] below uses it like time >> poll_weight, where @time is int64_t.
poll_weight > 63 is undefined behavior, which is a no-no.  Please reject
such values.  poll_weight == 64 results in zero.  Is that useful?

Missing: (default: 0) (since 11.1)

> +#
>  # The @aio-max-batch option is available since 6.1.
>  #
>  # Since: 2.0
> @@ -614,7 +619,8 @@
>    'base': 'EventLoopBaseProperties',
>    'data': { '*poll-max-ns': 'int',
>              '*poll-grow': 'int',
> -            '*poll-shrink': 'int' } }
> +            '*poll-shrink': 'int',
> +            '*poll-weight': 'int' } }
>  
>  ##
>  # @MainLoopProperties:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 69e5a874c1..8ddf6c8d36 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -6413,7 +6413,7 @@ SRST
>  
>              CN=laptop.example.com,O=Example Home,L=London,ST=London,C=GB
>  
> -    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,aio-max-batch=aio-max-batch``
> +    ``-object iothread,id=id,poll-max-ns=poll-max-ns,poll-grow=poll-grow,poll-shrink=poll-shrink,poll-weight=poll-weight,aio-max-batch=aio-max-batch``
>          Creates a dedicated event loop thread that devices can be
>          assigned to. This is known as an IOThread. By default device
>          emulation happens in vCPU threads or the main event loop thread.
> @@ -6449,6 +6449,11 @@ SRST
>          the polling time when the algorithm detects it is spending too
>          long polling without encountering events.
>  
> +        The ``poll-weight`` parameter is the weight factor used in the
> +        adaptive polling algorithm. It determines how much the most
> +        recent event interval affects the calculation of the next
> +        polling duration.
> +
>          The ``aio-max-batch`` parameter is the maximum number of requests
>          in a batch for the AIO engine, 0 means that the engine will use
>          its default.
> diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
> index 9ab1ad08a7..4c38f36fd4 100644
> --- a/tests/unit/test-nested-aio-poll.c
> +++ b/tests/unit/test-nested-aio-poll.c
> @@ -81,7 +81,7 @@ static void test(void)
>      qemu_set_current_aio_context(td.ctx);
>  
>      /* Enable polling */
> -    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
> +    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, 3, &error_abort);
>  
>      /* Make the event notifier active (set) right away */
>      event_notifier_init(&td.poll_notifier, 1);
> diff --git a/util/aio-posix.c b/util/aio-posix.c
> index 2b3522f2f9..13b7f94911 100644
> --- a/util/aio-posix.c
> +++ b/util/aio-posix.c
> @@ -29,7 +29,6 @@
>  
>  /* Stop userspace polling on a handler if it isn't active for some time */
>  #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
> -#define POLL_WEIGHT_SHIFT   (3)
>  
>  static void adjust_block_ns(AioContext *ctx, int64_t block_ns);
>  static void grow_polling_time(AioContext *ctx, int64_t block_ns);
> @@ -593,10 +592,6 @@ static void shrink_polling_time(AioContext *ctx, int64_t block_ns)
>      int64_t old = ctx->poll_ns;
>      int64_t shrink = ctx->poll_shrink;
>  
> -    if (shrink == 0) {
> -        shrink = 2;
> -    }
> -
>      if (block_ns < (ctx->poll_ns / shrink)) {
>          ctx->poll_ns /= shrink;
>      }
> @@ -610,10 +605,6 @@ static void grow_polling_time(AioContext *ctx, int64_t block_ns)
>      int64_t old = ctx->poll_ns;
>      int64_t grow = ctx->poll_grow;
>  
> -    if (grow == 0) {
> -        grow = 2;
> -    }
> -
>      if (block_ns > ctx->poll_ns * grow) {
>          ctx->poll_ns = block_ns;
>      } else {
> @@ -640,8 +631,8 @@ static void adjust_block_ns(AioContext *ctx, int64_t block_ns)
>               * poll.ns to smooth out polling time adjustments.
>               */
>              node->poll.ns = node->poll.ns
> -                ? (node->poll.ns - (node->poll.ns >> POLL_WEIGHT_SHIFT))
> -                + (block_ns >> POLL_WEIGHT_SHIFT) : block_ns;
> +                ? (node->poll.ns - (node->poll.ns >> ctx->poll_weight))
> +                + (block_ns >> ctx->poll_weight) : block_ns;

[*] This is the use of @poll-weight referred to above.

>  
>              if (node->poll.ns > ctx->poll_max_ns) {
>                  node->poll.ns = 0;
> @@ -831,7 +822,8 @@ void aio_context_destroy(AioContext *ctx)
>  }
>  
>  void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
> -                                 int64_t grow, int64_t shrink, Error **errp)
> +                                 int64_t grow, int64_t shrink,
> +                                 int64_t weight, Error **errp)
>  {
>      AioHandler *node;
>  
> @@ -848,6 +840,7 @@ void aio_context_set_poll_params(AioContext *ctx, int64_t max_ns,
>      ctx->poll_max_ns = max_ns;
>      ctx->poll_grow = grow;
>      ctx->poll_shrink = shrink;
> +    ctx->poll_weight = weight;
>      ctx->poll_ns = 0;
>  
>      aio_notify(ctx);

[...]


