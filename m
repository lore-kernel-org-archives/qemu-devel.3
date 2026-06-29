Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7F0C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weIPy-0006eH-SP; Mon, 29 Jun 2026 16:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1weIPw-0006dA-M1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 16:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1weIPt-0005Zg-JH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 16:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782764237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VCTQaOSIiYtiW/SrtoEccoazy+o4U0W4UM2VMw+TWE=;
 b=XP7ETQzjQvje2D60PHgHZ7/rxWVoNvYxyWQ4F8wzByWnQk5S2LaiVUKbEPxOXRFY0goizE
 WlbmWHosufAqgkOpyT8cmC6KyRS1Vtmsqa+swHRETNkuRb97kt7vY4sdc+41zWHFBfQP1a
 6eQTYVN6t2LyczfExLwchaQrty1S8J0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-azsPvnazOgm3rMCcYIC_PQ-1; Mon,
 29 Jun 2026 16:17:13 -0400
X-MC-Unique: azsPvnazOgm3rMCcYIC_PQ-1
X-Mimecast-MFC-AGG-ID: azsPvnazOgm3rMCcYIC_PQ_1782764232
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4BE1A1964CE5; Mon, 29 Jun 2026 20:17:12 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6A181771; Mon, 29 Jun 2026 20:17:10 +0000 (UTC)
Date: Mon, 29 Jun 2026 22:17:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PULL 17/28] fuse: Manually process requests (without libfuse)
Message-ID: <akLSxINM_Udwi4SL@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-18-kwolf@redhat.com>
 <2493d422-d58a-4409-aee4-e932a4e0a73c@proxmox.com>
 <8ec42109-4123-4cc7-a55e-9aa2576a791c@redhat.com>
 <d5c3d3da-5102-4bdc-87bc-9733fb0cbf09@redhat.com>
 <9be52b33-9a28-41ca-896c-a41b5558864c@proxmox.com>
 <526e49ea-03a7-460f-9974-976abf83c6b2@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <526e49ea-03a7-460f-9974-976abf83c6b2@proxmox.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Am 29.06.2026 um 15:19 hat Fiona Ebner geschrieben:
> Am 12.05.26 um 5:23 PM schrieb Fiona Ebner:
> > Hi Hanna,
> > 
> > Am 08.05.26 um 3:11 PM schrieb Hanna Czenczek:
> >> On 08.05.26 15:06, Hanna Czenczek wrote:
> >>> On 08.05.26 13:55, Fiona Ebner wrote:
> >>>> Dear maintainers,
> >>>>
> >>>> Am 10.03.26 um 6:37 PM schrieb Kevin Wolf:
> >>>>> From: Hanna Czenczek <hreitz@redhat.com>
> >>>>>
> >>>>> Manually read requests from the /dev/fuse FD and process them, without
> >>>>> using libfuse.  This allows us to safely add parallel request
> >>>>> processing
> >>>>> in coroutines later, without having to worry about libfuse internals.
> >>>>> (Technically, we already have exactly that problem with
> >>>>> read_from_fuse_export()/read_from_fuse_fd() nesting.)
> >>>>>
> >>>>> We will continue to use libfuse for mounting the filesystem;
> >>>>> fusermount3
> >>>>> is a effectively a helper program of libfuse, so it should know best
> >>>>> how
> >>>>> to interact with it.  (Doing it manually without libfuse, while doable,
> >>>>> is a bit of a pain, and it is not clear to me how stable the "protocol"
> >>>>> actually is.)
> >>>>>
> >>>>> Take this opportunity of quite a major rewrite to update the Copyright
> >>>>> line with corrected information that has surfaced in the meantime.
> >>>>
> >>>> a colleague ran into another issue with a fuse export, this time in
> >>>> combination with virt-fw-vars and bisecting points to this patch.
> >>>> Before commit a94a1d7699 ("fuse: Manually process requests (without
> >>>> libfuse)") the reproducer [0] completes successfully, after that
> >>>> commit it hangs at [1]. The issue is still present with current
> >>>> master. I can dig into the details next week.
> >>>
> >>> On my system, virt-fw-vars opens the file with O_TRUNC (after “INFO:
> >>> writing raw edk2 varstore...”). It then tries to write to the file,
> >>> but this returns a short write because the export is not marked as
> >>> growable, and for some reason, the write is infinitely retried instead
> >>> of aborting on ret=0 (which should indicate ENOSPC for writes).
> >>>
> >>> Using growable=true makes it work.  (For me :))
> >>>
> >>> For some reason, before said commit, libfuse just did not pass that
> >>> truncate on. I’ll look into why exactly, but so far I would say the
> >>> FUSE export behavior is as I would expect it.
> >>
> >> Ah, I see. libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, which has O_TRUNC be
> >> passed on as an open option, but the old export code just ignored all
> >> open options.
> >>
> >> The new code does not set that option, so O_TRUNC is executed as an
> >> explicit truncate by the kernel, which then *is* executed.
> > 
> > thank you for digging into it!
> > 
> >> I’m not entirely sure how we should handle it. There is a case to be
> >> made that with growable=off, it may make sense to ignore O_TRUNC (which
> >> requires turning on FUSE_CAP_ATOMIC_O_TRUNC again and then continue to
> >> ignore it). But on the other hand, O_TRUNC is O_TRUNC, and growable=off
> >> does not explicitly mean “please behave as much as a block device as
> >> possible”.
> >>
> >> What do you suggest?
> > 
> > It turns out that the missing FUSE_ATOMIC_O_TRUNC flag also regresses
> > exports from block devices, making open() with O_TRUNC fail with
> > EOPNOTSUPP [0], which worked before. Intuitively to me, growable=off
> > feels like it should imply "shrinkable=off" as well.
> > 
> > My suggestions would be one of the following, with a preference for 2.:
> > 
> > 1. Always set FUSE_ATOMIC_O_TRUNC
> > 
> >   Most backwards compatible. There is the issue that O_TRUNC does not
> >   apply when it's actually a file, which is surprising.
> > 
> > 2. Set FUSE_ATOMIC_O_TRUNC if growable=off
> > 
> >   Feels natural to me. People using growable=on with block device based
> >   exports are still affected by the change in behavior.
> > 
> > 3. Set FUSE_ATOMIC_O_TRUNC if driver not file-based
> > 
> >   What should be the exact condition to consider the driver
> >   not file-based? Here, O_TRUNC for a growable=off file-based export
> >   does apply, which feels surprising to me. Continues breaking the use
> >   I reported this issue for, requiring using growable=on in such cases.
> > 
> > 4. Set FUSE_ATOMIC_O_TRUNC if growable=off or if driver not file-based
> > 
> >   Similar to 2., but reduces cases affected by the change in behavior.
> 
> Should I go for approach number 2 or do you prefer another one?

Hanna is away for the next two weeks.

I think intuitively, I would expect growable=off to imply more or less
block-device-like semantics, i.e. truncating works, but doesn't do
anything. I think this is what you suggest as option 2, so I'm fine with
that.

Using growable=on on a node that isn't resizeable feels like a user
error, I wouldn't see it as a big problem.

Kevin


