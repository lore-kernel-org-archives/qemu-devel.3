Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3020C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiv1o-0006nf-MF; Mon, 04 Aug 2025 09:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uiuJa-0002G5-9z
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uiuJX-0003Dr-Ks
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 08:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754310553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i1F6cEO+DfL8jUvpY209iGdXHLMkehDCGpTSemolG+Y=;
 b=Ea4b3V/UyH/YylRJ0yhrncehAOQTO1UD26Ef74wosN2w39OXQHBjo+TnXS+Y+F4ComV5++
 JPgno7xt4JeF+b9kVix/u1DfsEgdYtFMiM5yWJPDLVcnxWU9+WwDiCBw1MDieOX+b1K2u3
 2WKl2Rw9D2wLOHiGuZqybd4kfWLtuC8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-MAowxxKQMrG4HJ8998eSdA-1; Mon,
 04 Aug 2025 08:29:08 -0400
X-MC-Unique: MAowxxKQMrG4HJ8998eSdA-1
X-Mimecast-MFC-AGG-ID: MAowxxKQMrG4HJ8998eSdA_1754310547
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63FFF19560B4; Mon,  4 Aug 2025 12:29:07 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.203])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B6351800B65; Mon,  4 Aug 2025 12:29:04 +0000 (UTC)
Date: Mon, 4 Aug 2025 14:29:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Brian Song <hibriansong@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [QEMU/FUSE] Discussion on Proper Termination and Async
 Cancellation in fuse-over-io_uring
Message-ID: <aJCnjubEbU529XiY@redhat.com>
References: <3867ced7-efb7-4a0f-ac0f-465631950bdb@gmail.com>
 <dc326a4b-f6fa-435a-b614-208e03f61556@gmail.com>
 <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577bf373-92cb-4160-a49e-e29d3615a308@ddn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Bernd,

Am 04.08.2025 um 13:33 hat Bernd Schubert geschrieben:
> Hi Brian,
> 
> sorry for my late reply, just back from vacation and fighting through
> my mails.
> 
> On 8/4/25 01:33, Brian Song wrote:
> > 
> > 
> > On 2025-08-01 12:09 p.m., Brian Song wrote:
> >> Hi Bernd,
> >>
> >> We are currently working on implementing termination support for fuse- 
> >> over-io_uring in QEMU, and right now we are focusing on how to clean up 
> >> in-flight SQEs properly. Our main question is about how well the kernel 
> >> supports robust cancellation for these fuse-over-io_uring SQEs. Does it 
> >> actually implement cancellation beyond destroying the io_uring queue?
> >>
> >> In QEMU FUSE export, we need a way to quickly and cleanly detach from 
> >> the event loop and cancel any pending SQEs when an export is no longer 
> >> in use. Ideally, we want to avoid the more drastic measure of having to 
> >> close the entire /dev/fuse fd just to gracefully terminate outstanding 
> >> operations.
> >> [...]

> I have to admit that I'm confused why you can't use umount, isn't that
> the most graceful way to shutdown a connection?
> 
> If you need another custom way for some reasons, we probably need
> to add it.

Brian focussed on shutdown in his message because that is the scenario
he's seeing right now, but you're right that shutdown probably isn't
that bad and once we unmount the exported image, we can properly shut
down things on the QEMU side, too.

The more challenging part is that sometimes QEMU needs to quiesce an
export so that no new requests can be processed for a short time. Maybe
we're switching processing to a different iothread or something like
this. In this scenario, we don't actually want to unmount the image, but
just cancel any outstanding COMMIT_AND_FETCH request, and soon after
submit a new one to continue processing requests.

If it's impossible to cancel the request in the kernel and queue new
request for a little bit (I suppose it would look a bit like userspace
being completely busy processing hypothetical NOP requests), we would
have to introduce some indirections in userspace to handle the case that
CQEs may be posted at times when we don't want to process them, or even
in the ring of the wrong thread (each iothread in QEMU has it's own
io_uring instance).

Come to think of it, the next thing the user may want to do might even
be deleting the old thread, which would have to fail while it's still
busy. So I think we do need a way to get rid of requests that it started
and can't just wait until they are used up.

Kevin


