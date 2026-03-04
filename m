Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B545EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxlsW-00041b-Ob; Wed, 04 Mar 2026 08:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vxlsR-0003xU-KK
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:02:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vxlsP-0003qV-8x
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=an3YMNWHo19AB2i+7+094N8EdX3JoA6SqaPIK8+Xww8=;
 b=gOWC4t+SiFwNibx0xI+GvLUKkq6Mxe4Tfc9rinL+uhdjxD2EkFxUTi3xcds+enKfbPhOGa
 VohqLZ/44RyYVF8JAveKGNMhgGR9BWHkPcLqkbZ7Lkhd1Yf/FoUppDiVYmjtXlXy82PpJo
 tSUVDKQaS8MLEJhnrYjvfJW75r0Wwyg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-L5nsqWSXMdSToMBmpJhPTQ-1; Wed,
 04 Mar 2026 08:02:51 -0500
X-MC-Unique: L5nsqWSXMdSToMBmpJhPTQ-1
X-Mimecast-MFC-AGG-ID: L5nsqWSXMdSToMBmpJhPTQ_1772629370
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EF5C195608F; Wed,  4 Mar 2026 13:02:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.201])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF6730001A2; Wed,  4 Mar 2026 13:02:48 +0000 (UTC)
Date: Wed, 4 Mar 2026 14:02:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, hreitz@redhat.com,
 jsnow@redhat.com
Subject: Re: [PATCH] hw/block/block: add 'throttle-group' property
Message-ID: <aagtde8OV1Y3fXFw@redhat.com>
References: <20260116143946.1031006-1-f.ebner@proxmox.com>
 <aZ23DELMG6CycbQ8@redhat.com>
 <7f1754b9-61a7-4413-9a97-1f47958da3e4@proxmox.com>
 <aaB1SXNFxiHlS08u@redhat.com>
 <bf9ccb3f-29e3-4c14-8e66-0e16d81da865@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf9ccb3f-29e3-4c14-8e66-0e16d81da865@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

Am 02.03.2026 um 13:54 hat Fiona Ebner geschrieben:
> Am 26.02.26 um 5:31 PM schrieb Kevin Wolf:
> > Am 26.02.2026 um 16:20 hat Fiona Ebner geschrieben:
> >> Am 24.02.26 um 3:34 PM schrieb Kevin Wolf:
> >>> Am 16.01.2026 um 15:39 hat Fiona Ebner geschrieben:
> >>>> With '-drive', it is possible to specify the throttle configuration
> >>>> directly on the commandline. Add the possibility to do the same when
> >>>> using the modern way with '-blockdev' and a front-end device. Using a
> >>>> throttle filter block node is not always an option: in particular, the
> >>>> mirror block job operates on a root block node and it might be desired
> >>>> to throttle only the guest IO, but not to the block job.
> >>>
> >>> Hm, is there still a reason why we require a root node for the source?
> 
> Do you happen to know what the original reason for the restriction was?
> From git history I cannot really see anything special, just:

No, I don't remember. Maybe some mailing list archaeology could help,
but I'm not planning to do that right now.

> > commit 07eec652722f3d12b07c5b28d0671ddfc22fe6a5
> > Author: Kevin Wolf <kwolf@redhat.com>
> > Date:   Thu Jun 23 14:20:24 2016 +0200
> > 
> >     block: Accept node-name for blockdev-mirror
> >     
> >     In order to remove the necessity to use BlockBackend names in the
> >     external API, we want to allow node-names everywhere. This converts
> >     blockdev-mirror to accept a node-name without lifting the restriction
> >     that we're operating at a root node.
> 
> For operations like backup and stream, the same restriction was lifted:
> 930fe17f99 ("blockdev: enable non-root nodes for backup source")
> 554b614765 ("block: Add QMP support for streaming to an intermediate layer")
> 
> We have the following code snippet in blockdev_mirror_common():
> 
> >     if (!replaces) {
> >         /* We want to mirror from @bs, but keep implicit filters on top */
> >         unfiltered_bs = bdrv_skip_implicit_filters(bs);
> >         if (unfiltered_bs != bs) {
> >             replaces = unfiltered_bs->node_name;
> >         }
> >     }
> 
> Doing this as well for non-root nodes would still match the documentation:
> 
> > # @replaces: with sync=full graph node name to be replaced by the new
> > #     image when a whole image copy is done.  This can be used to
> > #     repair broken Quorum files.  By default, @device is replaced,
> > #     although implicitly created filters on it are kept.

Yes, I think this would be the expected behaviour.

> But I guess we could also do something like
> 
> > diff --git a/blockdev.c b/blockdev.c
> > index 6e6932ddea..0ff058bed0 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -2931,7 +2931,14 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
> >          /* We want to mirror from @bs, but keep implicit filters on top */
> >          unfiltered_bs = bdrv_skip_implicit_filters(bs);
> >          if (unfiltered_bs != bs) {
> > -            replaces = unfiltered_bs->node_name;
> > +            if (bdrv_is_root_node(bs)) {
> > +                replaces = unfiltered_bs->node_name;
> > +            } else {
> > +                error_setg(errp, "Detected non-root block node which is an"
> > +                                 " implicit filter, please specify @replaces"
> > +                                 " parameter explicitly");
> > +                return;
> > +            }
> >          }
> >      }
> >  
> 
> to avoid any surprises for people who explicitly specify a non-root
> implicit filter as the source? Or what do you think?

What would the surprise be? That the filters are kept instead of being
replaced? But wouldn't it be inconsistent then that the same setup works
if it's a root node?

I suppose what would have been consistent is if BlockBackend names kept
implicit filters, but node names didn't. It's too late for that, though.

> Reading through the code, I don't see any other issues with using a
> non-root node as the source and an initial test case for a node below a
> throttle node seems to work fine too :)

That sounds promising.

Given that the 11.0 freeze is on Tuesday, do we still want to move
forward with a v2 of this patch, or do you think we should rather focus
on making throttle nodes usable in all of the cases we care about, even
if that means delaying it to 11.1?

Kevin


