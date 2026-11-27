Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7D8606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RkGHVDm3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwT7-0006EB-Bs; Fri, 27 Nov 2026 08:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xWwT1-0006DO-Rh
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xWwT0-0005yS-86
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 08:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795787900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tu5JaLTHyzT0X2IUNQBSY5Ly/lAyh+neukHhu4ZUr+E=;
 b=RkGHVDm3Rz8n+hVInCKETeMehsVZQd2Xfz6KkgXiaZDdifqWe1mkY1MSQ6T8Dsh9kKwWor
 bdwic1Uso1zvmYpvU6wF3lXaXB7X/o4aUTpXyKAiV+9mLKW4a3Qu4pdEFWrIqg+FCS1y32
 R5leJkYn59bIKZB8F4qgaP3Vk/CqAtA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-t9ZSnzILNZafXllckx1JuA-1; Fri,
 27 Nov 2026 13:58:18 +0000
X-MC-Unique: t9ZSnzILNZafXllckx1JuA-1
X-Mimecast-MFC-AGG-ID: t9ZSnzILNZafXllckx1JuA_1795787897
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D7891955F6D; Fri, 27 Nov 2026 13:58:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.41])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A613C1801A70; Fri, 27 Nov 2026 13:58:15 +0000 (UTC)
Date: Fri, 27 Nov 2026 14:58:13 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-block@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: performance regression due to 0bd5a1b3d60c "block: Fix
 corruption from broken RMW atomicity"
Message-ID: <awmMdcIPI7C_SdE7@redhat.com>
References: <5fa22932-3a6c-4b77-af53-a2d187e7603f@linux.ibm.com>
 <awldLyF7qI9lRPft@redhat.com>
 <20261127113333.2515385-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261127113333.2515385-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 27.11.2026 um 12:33 hat Paolo Bonzini geschrieben:
> On Fri, 27 Nov 2026 11:36:31 +0100, Kevin Wolf wrote:
> > Am 26.11.2026 um 16:43 hat Christian Borntraeger geschrieben:
> >> the fix
> >> - 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
> >> results in a pretty hefty performance regression for my nvme disk via virtio-blk and
> >> multiple iothreads.
> >> 
> >> I uses AI to analyze and summarize and the result was seem legit from what I
> >> can tell, so I paste this is verbatim.
> >> I verified that 0bd5a1b3d60c is bad and 0bd5a1b3d60c^ is good.
> >
> > Do you see any difference after commit cf4f672c (the commit right after
> > 0bd5a1b3d60c)? Some checks are temporarily duplicated, but I expected
> > that after the second commit, there shouldn't be any visible difference.
> >
> > In your use case, are serialising requests actually present?
> 
> I suspect the issue is that most of the time you *don't* have serialising
> requests, but still have to pay for bdrv_find_conflicting_request().
> 
> > +    if (!qatomic_read(&self->bs->serialising_in_flight)) {
> > +        return;
> > +    }
> 
> I would put that in bdrv_find_conflicting_request instead, since it
> is more obvious there that the loop requires a serialising request, but
> yeah - if the above analysis is correct that would fix it.

Yeah, as long as nobody adds more code around the loop in
bdrv_wait_serialising_requests_locked(), that does the same thing.
Not sure which one I prefer.

By the way, while you're here, what do you think about the alternative
idea I mentioned, keeping a separate list bs->serialising_requests?
Then you wouldn't have to have a counter any more because just checking
that the list is empty isn't any slower.

> Also, with much joy there is no need to use atomics anymore!
> tracked_request_set_serialising() and bdrv_find_conflicting_request()
> are called with reqs_lock taken, and tracked_request_end() takes it
> just below decrementing req->bs->serialising_in_flight.

Yes, I mentioned that. I just wanted to keep the patch to test as simple
as possible.

Kevin


