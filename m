Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65BECCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 16:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Fre-0004up-S2; Fri, 10 Oct 2025 12:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v7FrY-0004sm-LJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v7FrP-0003vJ-3F
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 12:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760113246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JtYrKviae3CT741vqDU4G8h6Y4yDQ2OdrpfN54thof8=;
 b=a3BlgykN9b4G2IJUXwwvJ0v5d16SxxKxPJ5eIF3r+0cYPShp6owDi1gYZVaj+nET7JMH5H
 f0mSXmSJ5GtcdO/SGzt6rI12KiIRUkjH4YoJFZLYlYYmXS3V4D/MlqIN+xwj5mrv1DeKOd
 A9qkXoEJxxm5hdNerm2RFzfWOMTtDJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-ISbvAdVdPdu71CzRLC6d9g-1; Fri,
 10 Oct 2025 12:20:42 -0400
X-MC-Unique: ISbvAdVdPdu71CzRLC6d9g-1
X-Mimecast-MFC-AGG-ID: ISbvAdVdPdu71CzRLC6d9g_1760113241
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40C031800578; Fri, 10 Oct 2025 16:20:40 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.92])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F220180035E; Fri, 10 Oct 2025 16:20:36 +0000 (UTC)
Date: Fri, 10 Oct 2025 18:20:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 09/12] aio-posix: add aio_add_sqe() API for
 user-defined io_uring requests
Message-ID: <aOkyUdEJFhFMlIfD@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-10-stefanha@redhat.com>
 <aOkk0NL7IMq3gFVl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOkk0NL7IMq3gFVl@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 10.10.2025 um 17:23 hat Kevin Wolf geschrieben:
> Am 10.09.2025 um 19:57 hat Stefan Hajnoczi geschrieben:
> > Introduce the aio_add_sqe() API for submitting io_uring requests in the
> > current AioContext. This allows other components in QEMU, like the block
> > layer, to take advantage of io_uring features without creating their own
> > io_uring context.
> > 
> > This API supports nested event loops just like file descriptor
> > monitoring and BHs do. This comes at a complexity cost: a BH is required
> > to dispatch CQE callbacks and they are placed on a list so that a nested
> > event loop can invoke its parent's pending CQE callbacks. If you're
> > wondering why CqeHandler exists instead of just a callback function
> > pointer, this is why.
> 
> This is a mechanism that we know from other places in the code like the
> Linux AIO or indeed the old io_uring block driver code, because a BH is
> the only thing that makes sure that the main loop will call into the
> code again later.
> 
> Do we really need it here, though? This _is_ literally the main loop
> implementation, we don't have to make the main loop call us.
> .need_wait() checks io_uring_cq_ready(), so as long as there are
> unprocessed completions, we know that .wait() will be called in nested
> event loops. We just can't take more than one completion out of the
> queue to process them later for this to work, but have to process them
> one by one as we get them from the ring. But that's what we already do.
> 
> Am I missing something?

I think what I missed is that we probably don't want to call arbitrary
callbacks from .wait(), but only in the dispatching phase. At the same
time, we need to fill the ready_list during .wait() and can't do that
later, so we do have to go through all CQEs here. The only way I can see
to get rid of the extra list - which I would really like to see - would
be processing the CQEs twice (once during .wait() for the internal ones
and once during the dispatch phase for the add_sqe() ones). That's a bit
annoying.

Either way, even if we keep the list, scheduling and cancelling BHs from
the fdmon still doesn't feel quite right to me. I wonder if we shouldn't
introduce a .dispatch() callback in FDMonOps that could run the
cqe_handler_ready_list for fdmon-io_uring. That would also make the
interface more consistent with the set of callbacks we have for GSource,
and maybe eventually simplify deduplicating them.

Then you also don't need the ugly optimisation in the next patch that
fixes the slowness of scheduling BHs in .wait() by moving io_uring code
to the AioContext core.

Kevin


