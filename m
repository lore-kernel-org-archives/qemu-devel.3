Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCF9D31A1C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 07:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfvcA-0003dI-FY; Wed, 14 Jan 2026 02:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfvc5-00031t-Lp
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 02:48:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vfvc3-00012G-VV
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 02:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768376899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xtl/uKgt1EPrxZOujKbynp1zUm/1wFpofQjo43iq4FQ=;
 b=byZ+J/8XKX8GaozRNbidK9R9Uz8BH2oZmbArL5IW72V7gS4xUeY/+3Dk5ryz9SALyDd8DM
 kJAm2CoOmgEAUd1NOgcgBa+H8OohK0zE9zE6LOBIbMThwtmrO7Ylkil3ryJf/sG1nnVsXI
 U0+urYKj5mTZt9N54Qd+VRyjiim2At0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-jNxD8IpSNaa5UP9_7IOn-A-1; Wed,
 14 Jan 2026 02:48:16 -0500
X-MC-Unique: jNxD8IpSNaa5UP9_7IOn-A-1
X-Mimecast-MFC-AGG-ID: jNxD8IpSNaa5UP9_7IOn-A_1768376895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 639961956080; Wed, 14 Jan 2026 07:48:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44C601801760; Wed, 14 Jan 2026 07:48:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9357B21E6742; Wed, 14 Jan 2026 08:48:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  pbonzini@redhat.com,
 stefanha@redhat.com,  fam@euphon.net,  eblake@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 sw@weilnetz.de
Subject: Re: [PATCH RFC v1 3/3] qapi/iothread: introduce poll-weight
 parameter for aio-poll
In-Reply-To: <20260113174824.464720-4-jhkim@linux.ibm.com> (Jaehoon Kim's
 message of "Tue, 13 Jan 2026 11:48:24 -0600")
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
 <20260113174824.464720-4-jhkim@linux.ibm.com>
Date: Wed, 14 Jan 2026 08:48:10 +0100
Message-ID: <87qzrs4oud.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> Introduce a new poll-weight parameter for aio-poll. This parameter
> controls how much the most recent event interval affects the next
> polling duration. When set to 0, a default value of 2 is used, meaning
> the current interval contributes roughly 25% to the calculation. Larger
> values decrease the weight of the current interval, enabling more
> gradual adjustments to polling duration.
>
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>

[...]

> diff --git a/qapi/misc.json b/qapi/misc.json
> index 28c641fe2f..b21cc48a03 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -85,6 +85,11 @@
>  # @poll-shrink: how many ns will be removed from polling time, 0 means
>  #     that it's not configured (since 2.9)
>  #
> +# @poll-weight: the weight factor for adaptive polling.
> +#     Determines how much the current event interval contributes to
> +#     the next polling time calculation.  0 means that the default
> +#     value is used.  (since 10.1)

When the default value is used, the actual value being used remains
hidden.  Why?

> +#
>  # @aio-max-batch: maximum number of requests in a batch for the AIO
>  #     engine, 0 means that the engine will use its default (since 6.1)
>  #
> @@ -96,6 +101,7 @@
>             'poll-max-ns': 'int',
>             'poll-grow': 'int',
>             'poll-shrink': 'int',
> +           'poll-weight': 'int',
>             'aio-max-batch': 'int' } }
>  
>  ##
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 6f5c9de0f0..d90823478d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -606,6 +606,11 @@
>  #     algorithm detects it is spending too long polling without
>  #     encountering events.  0 selects a default behaviour (default: 0)
>  #
> +# @poll-weight: the weight factor for adaptive polling.
> +#     Determines how much the current event interval contributes to
> +#     the next polling time calculation.  0 selects a default
> +#     behaviour (default: 0) since 10.1.

This leaves the actual default behavior unspecified.  Is this a good
idea?

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

[...]


