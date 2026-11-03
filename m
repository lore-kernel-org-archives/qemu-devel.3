Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F72606A326
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Y4r4qYjF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOE9T-0000xZ-MK; Tue, 03 Nov 2026 08:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOE97-0000eL-P4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xOE95-0001Lc-M1
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793710905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/cIa/ylu4oQ8CWmmAJG1Gde5YAAwCcvyIJDXBFWzdgE=;
 b=Y4r4qYjFoxsDQ80j0ivQAgBRzQYnccoOmx0dhW+l1DPBzFSC6YEiyMRoz4pCJ6VQEWjOY+
 35GVGSpP9hBUu23yzGtUJeGvsbhOhhj5aUICQMRaYLjPKx4vvZyRDF/4GuXR/JqikVCcpv
 qKBP8T1Fl7fn0h8bun7x2F7e431sH0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-8XM0J7hfPeiJ6IzMcaMpzA-1; Tue,
 03 Nov 2026 08:01:43 -0500
X-MC-Unique: 8XM0J7hfPeiJ6IzMcaMpzA-1
X-Mimecast-MFC-AGG-ID: 8XM0J7hfPeiJ6IzMcaMpzA_1793710902
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B0B91955DE7; Tue,  3 Nov 2026 13:01:42 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4996630001B9; Tue,  3 Nov 2026 13:01:39 +0000 (UTC)
Date: Tue, 3 Nov 2026 14:01:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 05/13] block/preallocate: hold back writes into a
 preallocation in flight
Message-ID: <aunbMKIJAaKpoB5Y@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-6-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930165000.303236-6-den@openvz.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 30.09.2026 um 18:49 hat Denis V. Lunev geschrieben:
> From: Denis V. Lunev <den@openvz.org>
> 
> The previous patch holds the mutex across all of handle_write(),
> including the preallocating write zeroes. That is correct and far too
> coarse: the fallocate takes as long as it takes, and every writer that
> extends the file waits for it.
> 
> Reserve the range instead of holding the lock over it. file_end moves
> to the end of the preallocated range before the request is issued, so
> a writer arriving while it is in flight works from a length that
> already covers the range being zeroed.
> 
> That leaves it going straight into the range, and BDRV_REQ_SERIALISING
> cannot stop it. Serialisation orders a request against the ones in
> bs->tracked_requests, and the zeroing request is not there yet: the
> filter runs above bdrv_co_pwritev_part(), which is what tracks it.
> Whatever the filter lets through in that window is unordered by
> construction, so the filter has to hold it back itself.

If I understand correctly, the problem isn't that the zeroing request
isn't there yet, but will be later, but that it operates on bs->file
while you want to serialise requests against it on bs.

I wonder if the easier solution for this wouldn't be what you removed
from file-posix in the first patch: Get the current request and widen it
so that it covers the area that gets preallocated and then mark it
serialising.

> safe_end trails file_end, standing at the lowest start of a
> preallocation in flight and reaching file_end once none is left. A
> write above it waits on a queue and re-reads the state when the
> preallocations drain. A write zeroes merged into a preallocation
> starts it below file_end, so safe_end has to move down as well as up.
> 
> Below safe_end nothing can be zeroed any more, so those writes do not
> queue, and below zero_start there is nothing to record either, so
> those take no mutex at all. The stores are qatomic_set() because that
> path reads them without it.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: qemu-stable@nongnu.org
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  block/preallocate.c | 95 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 76 insertions(+), 19 deletions(-)
> 
> diff --git a/block/preallocate.c b/block/preallocate.c
> index 442cdb0176..128f1da014 100644
> --- a/block/preallocate.c
> +++ b/block/preallocate.c
> @@ -32,6 +32,7 @@
>  #include "qemu/units.h"
>  #include "block/block-io.h"
>  #include "block/block_int.h"
> +#include "qemu/atomic.h"

Please also add comments to those struct fields that are supposed to be
accessed with atomics.

I see that data_end, safe_end and zero_start are accessed inconsistently
with and without atomics, sometimes even within the same function.

Kevin


