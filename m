Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484DDFD8FCF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vveGm-0000Cz-2d; Thu, 26 Feb 2026 11:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vveGk-0000Cp-PH
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vveGj-0000fN-2D
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772123475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zyIbuf1nZjAcl8F85OutUZAgeiQ0fVf1JUq5N1mh7Vo=;
 b=YZ7zockN7rI6c45/DpdoQ4++tKc6s/F9Iv4WTor+UlLrjCQtIymEeibIbL3mzkuq3WhYS0
 IgtvtRtD61xVa9X/lzr01z5kKgI5QnhOE3udEOZlis/Zj0yXOBOy/VItfXorp5HtjNIJZ2
 /5rWXF2xKkL8ZrcyYexHf2Il570hSkg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-OBepDoouNfGdU1F3H7zPeA-1; Thu,
 26 Feb 2026 11:31:12 -0500
X-MC-Unique: OBepDoouNfGdU1F3H7zPeA-1
X-Mimecast-MFC-AGG-ID: OBepDoouNfGdU1F3H7zPeA_1772123470
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB4619560B8; Thu, 26 Feb 2026 16:31:10 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.49])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B4961800465; Thu, 26 Feb 2026 16:31:08 +0000 (UTC)
Date: Thu, 26 Feb 2026 17:31:05 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com
Subject: Re: [PATCH] hw/block/block: add 'throttle-group' property
Message-ID: <aaB1SXNFxiHlS08u@redhat.com>
References: <20260116143946.1031006-1-f.ebner@proxmox.com>
 <aZ23DELMG6CycbQ8@redhat.com>
 <7f1754b9-61a7-4413-9a97-1f47958da3e4@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f1754b9-61a7-4413-9a97-1f47958da3e4@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_PASS=-0.001,
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

Am 26.02.2026 um 16:20 hat Fiona Ebner geschrieben:
> Am 24.02.26 um 3:34 PM schrieb Kevin Wolf:
> > Am 16.01.2026 um 15:39 hat Fiona Ebner geschrieben:
> >> With '-drive', it is possible to specify the throttle configuration
> >> directly on the commandline. Add the possibility to do the same when
> >> using the modern way with '-blockdev' and a front-end device. Using a
> >> throttle filter block node is not always an option: in particular, the
> >> mirror block job operates on a root block node and it might be desired
> >> to throttle only the guest IO, but not to the block job.
> > 
> > Hm, is there still a reason why we require a root node for the source?
> 
> I'm not sure if the restriction could be lifted. But AFAICS, that
> doesn't help in my case with a throttle node as the root node:
> 
> Say I'm mirroring the node below throttle and the job is ready to be
> completed. Further, assume that requests pile up for the root node,
> while the node below is mostly idle, which can easily happen with low
> throttle limits:
> 
> At some moment, there might be no IO in-flight for the node below
> throttle and thus the mirror can complete, while all the in-flight
> requests for the throttle node are currently being intercepted by the
> throttle group and waiting for the timer to wake them. Because, the call
> to bdrv_inc_in_flight() for the node below throttle only happens after
> the intercepted requests are woken. Mirror and the node below do not
> know about the parent's in flight requests. Is this interpretation correct?

Well, mirror doesn't just complete by itself, but let's assume it
already was ready and you told it to complete. Then yes, if there is no
more activity and both sides are in sync, the mirror job can complete.

However, is this any different from a mirror job completing when the
guest has already put a request in the virtio-blk virtqueue, but the
device model hasn't processed it yet? From the guest's perspective, the
request is in flight in both cases, and from the mirror job's
perspective it hasn't started yet in both cases.

I think the only difference is that with throttling you might hit this
case more often, but it's not a case that is fundamentally impossible
without throttling.

> There are scenarios where we finish the job via block-job-cancel after
> freezing the guest filesystem to ensure consistency, so having
> intercepted requests as described above would mess it up.

Why? You got a copy that was in sync at the time that the mirror job
completed. The job doesn't promise the exact point of time that the copy
matches, it's just some arbitrary time after you request completion when
both sides are in sync. This implies that requests after this arbitrary
point in time will not be included in the copy.

Though I'm also wondering, if you successfully froze the file system (as
opposed to still trying to freeze it), why are we getting write
requests? Shouldn't freezing involve waiting for completion of all
in-flight requests?

Kevin


