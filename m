Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CE8C5B549
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM1RX-0002Uj-Al; Mon, 02 Jun 2025 05:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM1RV-0002UI-BP
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM1RP-0007fe-6f
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 05:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748856404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WixGrqsp0huneAgOvLnHTAwfiFnaDxK9PTTSGV5BYKY=;
 b=AtcE3sTqJjY2UdaphKKlt2VF+3ZxA8DdyGI+6F1Cq8xbpvrl8+3zMK4ygnMinzTMYbyY6H
 +SqIAZbALovO8xU00mv1K6OJjhDsKo+78bN5EtSzHSvy8OcWju+UobZmrzMiGhi6G0XxYi
 WXLmuSEU22PMqo8VB0CznoGgtIQw/9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-CbWC0fgiNRWVwF7a6ddreQ-1; Mon,
 02 Jun 2025 05:26:41 -0400
X-MC-Unique: CbWC0fgiNRWVwF7a6ddreQ-1
X-Mimecast-MFC-AGG-ID: CbWC0fgiNRWVwF7a6ddreQ_1748856400
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D90C1956088; Mon,  2 Jun 2025 09:26:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4BFB19560AB; Mon,  2 Jun 2025 09:26:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCB0E21E6766; Mon, 02 Jun 2025 11:26:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alexey Perevalov <a.perevalov@samsung.com>,  Fabiano Rosas
 <farosas@suse.de>,  Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 08/13] migration/postcopy: Report fault latencies in
 blocktime
In-Reply-To: <20250527231248.1279174-9-peterx@redhat.com> (Peter Xu's message
 of "Tue, 27 May 2025 19:12:43 -0400")
References: <20250527231248.1279174-1-peterx@redhat.com>
 <20250527231248.1279174-9-peterx@redhat.com>
Date: Mon, 02 Jun 2025 11:26:36 +0200
Message-ID: <8734cilcj7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> Blocktime so far only cares about the time one vcpu (or the whole system)
> got blocked.  It would be also be helpful if it can also report the latency
> of page requests, which could be very sensitive during postcopy.
>
> Blocktime itself is sometimes not very important, especially when one
> thinks about KVM async PF support, which means vCPUs are literally almost
> not blocked at all because the guest OS is smart enough to switch to
> another task when a remote fault is needed.
>
> However, latency is still sensitive and important because even if the guest
> vCPU is running on threads that do not need a remote fault, the workload
> that accesses some missing page is still affected.
>
> Add two entries to the report, showing how long it takes to resolve a
> remote fault.  Mention in the QAPI doc that this is not the real average
> fault latency, but only the ones that was requested for a remote fault.
>
> Unwrap get_vcpu_blocktime_list() so we don't need to walk the list twice,
> meanwhile add the entry checks in qtests for all postcopy tests.
>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi/migration.json                   | 13 +++++
>  migration/migration-hmp-cmds.c        | 70 ++++++++++++++++++---------
>  migration/postcopy-ram.c              | 48 ++++++++++++------
>  tests/qtest/migration/migration-qmp.c |  3 ++
>  4 files changed, 97 insertions(+), 37 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8b9c53595c..8b13cea169 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -236,6 +236,17 @@
>  #     This is only present when the postcopy-blocktime migration
>  #     capability is enabled.  (Since 3.0)
>  #
> +# @postcopy-latency: average remote page fault latency (in us).  Note that
> +#     this doesn't include all faults, but only the ones that require a
> +#     remote page request.  So it should be always bigger than the real
> +#     average page fault latency. This is only present when the
> +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
> +#
> +# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
> +#     us).  It has the same definition of @postcopy-latency, but instead
> +#     this is the per-vCPU statistics. This is only present when the

Two spaces between sentences for consistency, please.

> +#     postcopy-blocktime migration capability is enabled.  (Since 10.1)

I figure the the @i-th array element is for vCPU with index @i.  Correct?

This is also only present when @postcopy-blocktime is enabled.  Correct?

Could a QMP client compute @postcopy-latency from
@postcopy-vcpu-latency?

> +#
>  # @socket-address: Only used for tcp, to know what the real port is
>  #     (Since 4.0)
>  #
> @@ -275,6 +286,8 @@
>             '*blocked-reasons': ['str'],
>             '*postcopy-blocktime': 'uint32',
>             '*postcopy-vcpu-blocktime': ['uint32'],
> +           '*postcopy-latency': 'uint64',
> +           '*postcopy-vcpu-latency': ['uint64'],
>             '*socket-address': ['SocketAddress'],
>             '*dirty-limit-throttle-time-per-round': 'uint64',
>             '*dirty-limit-ring-full-time': 'uint64'} }

[...]


