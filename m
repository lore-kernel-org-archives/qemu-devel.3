Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0FCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 12:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEoKH-0004WM-QQ; Fri, 31 Oct 2025 08:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEoKG-0004W9-3g
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vEoK9-0005Ao-Oh
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 08:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761914018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=416ejIxb3ChzopdZc+FqS5bCe3INXY4qAUZKLbwMXbU=;
 b=EQr1TQMVZJW6J9OpizxVKOQdZAsDKx4ODTpOY/0avJbn9mJFm1GTqMmpTZhI+x7H8kQqJB
 iK2K7xxkDn/7VOhRtoKbkMwpdjVRbJIi3JEFdEPfUJNEFHg14bOO/LLtbI8lsLEnm6OvuZ
 LMwD7nyNOr2YQFH1HZwMwZLpeWB2tZw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-UlkNKOK7Md2Dog1xhSNU7Q-1; Fri,
 31 Oct 2025 08:33:34 -0400
X-MC-Unique: UlkNKOK7Md2Dog1xhSNU7Q-1
X-Mimecast-MFC-AGG-ID: UlkNKOK7Md2Dog1xhSNU7Q_1761914014
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E50C718001D1; Fri, 31 Oct 2025 12:33:33 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7305730001A6; Fri, 31 Oct 2025 12:33:31 +0000 (UTC)
Date: Fri, 31 Oct 2025 13:33:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: Re: [PATCH v3 21/21] fuse: Increase MAX_WRITE_SIZE with a second
 buffer
Message-ID: <aQSsmAOnj2tAeNxx@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
 <20250701114437.207419-22-hreitz@redhat.com>
 <aPpFogd44fuISVKd@redhat.com>
 <c9339232-476d-4074-9150-ea7c154658b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9339232-476d-4074-9150-ea7c154658b7@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 31.10.2025 um 13:13 hat Hanna Czenczek geschrieben:
> On 23.10.25 17:11, Kevin Wolf wrote:
> > Am 01.07.2025 um 13:44 hat Hanna Czenczek geschrieben:
> > > We probably want to support larger write sizes than just 4k; 64k seems
> > > nice.  However, we cannot read partial requests from the FUSE FD, we
> > > always have to read requests in full; so our read buffer must be large
> > > enough to accommodate potential 64k writes if we want to support that.
> > > 
> > > Always allocating FuseRequest objects with 64k buffers in them seems
> > > wasteful, though.  But we can get around the issue by splitting the
> > > buffer into two and using readv(): One part will hold all normal (up to
> > > 4k) write requests and all other requests, and a second part (the
> > > "spill-over buffer") will be used only for larger write requests.  Each
> > > FuseQueue has its own spill-over buffer, and only if we find it used
> > > when reading a request will we move its ownership into the FuseRequest
> > > object and allocate a new spill-over buffer for the queue.
> > > 
> > > This way, we get to support "large" write sizes without having to
> > > allocate big buffers when they aren't used.
> > > 
> > > Also, this even reduces the size of the FuseRequest objects because the
> > > read buffer has to have at least FUSE_MIN_READ_BUFFER (8192) bytes; but
> > > the requests we support are not quite so large (except for >4k writes),
> > > so until now, we basically had to have useless padding in there.
> > > 
> > > With the spill-over buffer added, the FUSE_MIN_READ_BUFFER requirement
> > > is easily met and we can decrease the size of the buffer portion that is
> > > right inside of FuseRequest.
> > > 
> > > As for benchmarks, the benefit of this patch can be shown easily by
> > > writing a 4G image (with qemu-img convert) to a FUSE export:
> > > - Before this patch: Takes 25.6 s (14.4 s with -t none)
> > > - After this patch: Takes 4.5 s (5.5 s with -t none)
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > The commit message seems outdated, there is no such thing as a
> > FuseRequest object.
> > 
> > I agree with the idea of allocating a separate buffer for the data to be
> > written. I'm not so sure that the approach taken here with combining an
> > in-place and a spillover buffer does actually do much for us in exchange
> > for the additional complexity.
> > 
> > The allocation + memcpy for in_place buf in fuse_co_write() bothers me a
> > bit. I'd rather have a buffer for the data to write that can be directly
> > used. And let's be real, we already allocate a 1 MB stack per request. I
> > don't think 64k more or less make a big difference, but it would allow
> > us to save the memcpy() for 4k requests and additionally an allocation
> > for larger requests.
> > 
> > The tradeoff when you use an iov for the buffer in FuseQueue that is
> > only big enough for the header and fuse_write_in and then directly the
> > per-request buffer that is owned by the coroutine is that for requests
> > that are larger than fuse_write_in, you'll have to copy the rest back
> > from the data buffer first. This seems to be only fuse_setattr_in, which
> > shouldn't be a hot path at all, and only a few bytes.
> 
> So I understand that first, you disagree with “Always allocating FuseRequest
> objects with 64k buffers in them seems wasteful, though.” I.e. to just use a
> 64k buffer per request.  OK, fair.

I think in practice most write requests will exceed the 4k anyway, so
we'd already use the spillover buffer. Maybe the most common exception
is fio, if we want to optimise for that one. :-)

> Second, you suggest to improve performance by having an aligned 64k data
> buffer separate from the request metadata buffer to save on memcpy().  I did
> consider this, but discarded it because of I was afraid of the complexity. 
> Actually probably too afraid.
> 
> I’ll take a look, it actually can’t be too hard.  (Just have two buffers;
> make the metadata buffer long enough to capture all request headers, but
> only pass the sizeof(fuse_write_in)-long head into readv(), then check the
> request opcode.  If metadata spilled over to the data buffer, copy it back
> into the “shadowed” metadata buffer tail.)

Yes, that's what I had in mind. Not sure if it's premature
optimisation...

Kevin


