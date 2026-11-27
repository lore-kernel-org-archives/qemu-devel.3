Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4F606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PKwnjUN+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtJx-0007bV-5x; Fri, 27 Nov 2026 05:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xWtJt-0007a7-7F
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xWtJr-0008Bc-J4
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 05:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795775802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G4lwLEvlNO7gf/Y6ygqG0fe0w1wAnmQCbR2b5ogINkw=;
 b=PKwnjUN+jIU09GY76pAsE+954SxJIY0UnkoD+9b0RqgTILKLKoO3rX3YRbsqkfQcxgC2T6
 GYAfgl6MrCf9k4gY6EyzKMCYXO2eOdnnMi9DG+M2nhUs0Zx7+mMfxPpdCDA8a4qvPrs1ul
 qA/DmmamCSeXhHtQqMTOO6k4uWxvAYc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-Pdj75ElXOLGteWPZiyVMjw-1; Fri,
 27 Nov 2026 10:36:37 +0000
X-MC-Unique: Pdj75ElXOLGteWPZiyVMjw-1
X-Mimecast-MFC-AGG-ID: Pdj75ElXOLGteWPZiyVMjw_1795775796
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8CAD195606A; Fri, 27 Nov 2026 10:36:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEA6830000D3; Fri, 27 Nov 2026 10:36:33 +0000 (UTC)
Date: Fri, 27 Nov 2026 11:36:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-block@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>
Subject: Re: performance regression due to 0bd5a1b3d60c "block: Fix
 corruption from broken RMW atomicity"
Message-ID: <awldLyF7qI9lRPft@redhat.com>
References: <5fa22932-3a6c-4b77-af53-a2d187e7603f@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa22932-3a6c-4b77-af53-a2d187e7603f@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 26.11.2026 um 16:43 hat Christian Borntraeger geschrieben:
> the fix
> - 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
> results in a pretty hefty performance regression for my nvme disk via virtio-blk and
> multiple iothreads.
> 
> I uses AI to analyze and summarize and the result was seem legit from what I
> can tell, so I paste this is verbatim.
> I verified that 0bd5a1b3d60c is bad and 0bd5a1b3d60c^ is good.

Do you see any difference after commit cf4f672c (the commit right after
0bd5a1b3d60c)? Some checks are temporarily duplicated, but I expected
that after the second commit, there shouldn't be any visible difference.

In your use case, are serialising requests actually present?

> ## Description of problem
> Since commit 0bd5a1b3d60c ("block: Fix corruption from broken RMW atomicity")
> and the follow-up cf4f672c11d6 ("block: Remove now redundant
> bdrv_wait_serialising_requests() calls"), tracked_request_begin()
> unconditionally calls bdrv_wait_serialising_requests_locked(). The
> `bs->serialising_in_flight` fast path that bdrv_wait_serialising_requests()
> used to provide is gone.

Yes, that's a good point, and we could simply add this condition to
bdrv_wait_serialising_requests_locked() if the walk is expensive.

In fact, I suppose we could optimise even the case that does have
serialising requests by keeping a separate list of serialising requests
so that we don't have to iterate over all the non-serialising requests,
too. Though maybe it's not expected to have both serialising and a lot
of non-serialising requests at the same time on the same disk.

Anyway, can you try out if the below patch helps? (Only compile tested.)
serialising_in_flight doesn't actually have to be atomic any more, but
it's the simplest change we can make for 11.2.

Kevin


diff --git a/block/io.c b/block/io.c
index e4568d4d244..5e2734e540a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -703,6 +703,10 @@ bdrv_wait_serialising_requests_locked(BdrvTrackedRequest *self)
 {
     BdrvTrackedRequest *req;

+    if (!qatomic_read(&self->bs->serialising_in_flight)) {
+        return;
+    }
+
     while ((req = bdrv_find_conflicting_request(self))) {
         /*
          * If this request is the active owner of the data blocks it accesses,


