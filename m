Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F034ECD980
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1oo-0006vJ-TW; Thu, 05 Feb 2026 11:02:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vo1ok-0006hR-TL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:02:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vo1oi-0000aH-Vy
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:02:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770307366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bBBpKEmCF3wE5yHBDfw/MtoHhDq4l8H86CdxZFId09w=;
 b=DZF55N4K0C8oXwzU0muir4eK9mQ9QlEiB7xlCn/5ymL7wCg4KRDoUBQ03bdgH54hjcluMC
 aDul3nS9P7McdLgTyqamXxpXQ3k9kjaa2GMJQxdcEZ44jCTqPv59gDzyz0nq9bs9aq9aCi
 x/c0+mGP8Yz8qjJCO4GAtEKxap9CS5U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-ylBui5EuOpmUwjKpY1CZ-A-1; Thu,
 05 Feb 2026 11:02:41 -0500
X-MC-Unique: ylBui5EuOpmUwjKpY1CZ-A-1
X-Mimecast-MFC-AGG-ID: ylBui5EuOpmUwjKpY1CZ-A_1770307360
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E681955F3D; Thu,  5 Feb 2026 16:02:40 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.198])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2120300DDA8; Thu,  5 Feb 2026 16:02:37 +0000 (UTC)
Date: Thu, 5 Feb 2026 17:02:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, hreitz@redhat.com, fam@euphon.net
Subject: Re: [RFC v2 0/6] block/io: avoid failure caused by misaligned
 BLKZEROOUT ioctl
Message-ID: <aYS_G-QHlbucVpUd@redhat.com>
References: <20260109120837.2772961-1-f.ebner@proxmox.com>
 <20260202221634.GB429972@fedora>
 <36a69637-d7b9-42cb-b16f-473091efb3ee@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36a69637-d7b9-42cb-b16f-473091efb3ee@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Am 05.02.2026 um 13:13 hat Fiona Ebner geschrieben:
> Hi Stefan,
> 
> Am 02.02.26 um 11:15 PM schrieb Stefan Hajnoczi:
> > On Fri, Jan 09, 2026 at 01:08:27PM +0100, Fiona Ebner wrote:
> >> Previous discussion here:
> >> https://lore.kernel.org/qemu-devel/20260105143416.737482-1-f.ebner@proxmox.com/
> >>
> >> Commit 5634622bcb ("file-posix: allow BLKZEROOUT with -t writeback")
> >> enables the BLKZEROOUT ioctl when using 'writeback' cache, regressing
> >> certain 'qemu-img convert' invocations, because of a pre-existing
> >> issue. Namely, the BLKZEROOUT ioctl might fail with errno EINVAL when
> >> the request is shorter than the block size of the block device.
> >>
> >> Stefan suggested prioritizing bl.pwrite_zeroes_alignment in
> >> bdrv_co_do_zero_pwritev(). This RFC explores that approach and the
> >> issues with qcow2 I encountered, where
> >> bl.pwrite_zeroes_alignment = s->subcluster_size;
> >> I would be happy to discuss potential solutions and whether we should
> >> use this approach after all.
> > 
> > Hi Fiona,
> > I wanted to continue this discussion. My thoughts are that making
> > bdrv_co_do_zero_pwritev() use bl.pwrite_zeroes_alignment is the right
> > long-term solution to keep all the padding logic in one place.
> > 
> > On the other hand, your series shows it involves fixing a bunch of test
> > failures and that's not fun. The original bug that is being solved here
> > is my doing, so feel free to hand this over to me if you decide you
> > don't want to work on it.
> 
> in your other mail, you mentioned you'll ask Kevin for his opinion. So
> in part, I was waiting for that. But I also was side-tracked by other
> things, and it will be 1-2 more weeks until I can really focus on this
> again. If that is too long, please go ahead and pick it up.

I didn't review this thoroughly yet, but I agree that considering the
alignment from the start is the better solution and also more consistent
with what we're already doing for normal reads and writes.

We just need to make sure that we use the right alignments in the right
places, which can be a bit confusing with the fallbacks to buffered zero
writes here and there.

I assume that there is enough time left to do this before the 11.0
release and there is no need to take something like v1 as an
intermediate solution?

Kevin


