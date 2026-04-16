Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0703F8D756
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDO72-0003Jh-99; Thu, 16 Apr 2026 10:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDO71-0003JR-08
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDO6y-0006vC-MF
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776351271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6Gdi1KEPOIIOtwHvqkye5nRfrimJtrKL17O+HZexMs=;
 b=V/IvQCLahdAyug8cdf1JVfadQhIAAnMecEEJYopz8oHWaRTl9ldFb79aqU7CBR/e3X4x+z
 Blk3T0ErtpBZo2ivRq0ZXu/cYyeIgZlmp0m3Wg9tl+O2njAAD3Fwk58RTUBaTcVd1rg/Av
 Y3UBYZiw/zLpmeSKVMZo46kQ17S7rcY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-awDnxJDrOWWgdAb0YEQl2w-1; Thu,
 16 Apr 2026 10:54:26 -0400
X-MC-Unique: awDnxJDrOWWgdAb0YEQl2w-1
X-Mimecast-MFC-AGG-ID: awDnxJDrOWWgdAb0YEQl2w_1776351264
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5C6D1956080; Thu, 16 Apr 2026 14:54:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65A1D30001A4; Thu, 16 Apr 2026 14:54:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9AE021E6A28; Thu, 16 Apr 2026 16:54:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  pbonzini@redhat.com,
 stefanha@redhat.com,  fam@euphon.net,  eblake@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 sw@weilnetz.de,  mjrosato@linux.ibm.com,  farman@linux.ibm.com
Subject: Re: [PATCH v3 3/3] qapi/iothread: introduce poll-weight parameter
 for aio-poll
In-Reply-To: <20260405200735.3075407-4-jhkim@linux.ibm.com> (Jaehoon Kim's
 message of "Sun, 5 Apr 2026 15:07:34 -0500")
References: <20260405200735.3075407-1-jhkim@linux.ibm.com>
 <20260405200735.3075407-4-jhkim@linux.ibm.com>
Date: Thu, 16 Apr 2026 16:54:19 +0200
Message-ID: <87eckfq7l0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 28c641fe2f..554b0c5717 100644
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
> +#     greater.  0 selects the system default value which is currently
> +#     3 (since 11.1)

As far as I can tell, query-iothreads never returns "poll-weight": 0.
So, scratch the last sentence.

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
> index c653248f85..dd45ac1087 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -606,6 +606,13 @@
>  #     algorithm detects it is spending too long polling without
>  #     encountering events.  0 selects a default behaviour (default: 0)
>  #
> +# @poll-weight: the weight factor for adaptive polling.  Determines
> +#     how much the most recent event interval affects the next
> +#     polling duration calculation.  If set to 0, the system default
> +#     value of 3 is used.  Typical values: 1 (high weight on recent
> +#     interval), 2-4 (moderate weight on recent interval).
> +#     (default: 0) (since 11.1)
> +#
>  # The @aio-max-batch option is available since 6.1.
>  #
>  # Since: 2.0
> @@ -614,7 +621,8 @@
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

This is now less detailed than the version in qom.json.  Care to add the
details here, too?

> +
>          The ``aio-max-batch`` parameter is the maximum number of requests
>          in a batch for the AIO engine, 0 means that the engine will use
>          its default.

[...]


