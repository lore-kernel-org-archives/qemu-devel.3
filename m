Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4DDC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 17:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u806F-00021O-Qt; Thu, 24 Apr 2025 13:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u806D-000212-EW
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u806A-0006Mr-FA
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 13:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745514653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8I905gfmerzKfeKgDSgOdWFxZ6UdgQHVlvcCk859z/g=;
 b=OOaAqYqrJch+ZcDK8Nv27SWLqn+eQbn8IX7benY294QuL5J7xJBsRQJPaVo+d2MnwyR9DJ
 q/MYKrcTLTFIFkYoGtv6dSjK596ZlRc60O9YNA70Ljs9P5f7VQNM1PS6LmZooGbkbTj3TV
 p06kXNLn4llpVZLm7yrxBSx0RNr0nz8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-u5oTL53mMgakezb-w2o40w-1; Thu,
 24 Apr 2025 13:10:48 -0400
X-MC-Unique: u5oTL53mMgakezb-w2o40w-1
X-Mimecast-MFC-AGG-ID: u5oTL53mMgakezb-w2o40w_1745514647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDA141800ECB; Thu, 24 Apr 2025 17:10:45 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DAB230001AB; Thu, 24 Apr 2025 17:10:42 +0000 (UTC)
Date: Thu, 24 Apr 2025 12:10:39 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 07/11] mirror: Skip pre-zeroing destination if it is
 already zero
Message-ID: <7wbypgzhbogcqgsz726o5njcrwd5tb6vqppmu2cwhqlay6cxsy@el4osy3wp4w6>
References: <20250417184133.105746-13-eblake@redhat.com>
 <20250417184133.105746-20-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417184133.105746-20-eblake@redhat.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 17, 2025 at 01:39:12PM -0500, Eric Blake wrote:
> When doing a sync=full mirroring, QMP drive-mirror requests full
> zeroing if it did not just create the destination, and blockdev-mirror
> requests full zeroing unconditionally.  This is because during a full
> sync, we must ensure that the portions of the disk that are not
> otherwise touched by the source still read as zero upon completion.
> 
> However, in mirror_dirty_init(), we were blindly assuming that if the
> destination allows punching holes, we should pre-zero the entire
> image; and if it does not allow punching holes, then treat the entire
> source as dirty rather than mirroring just the allocated portions of
> the source.  Without the ability to punch holes, this results in the
> destination file being fully allocated; and even when punching holes
> is supported, it causes duplicate I/O to the portions of the
> destination corresponding to chunks of the source that are allocated
> but read as zero.
> 
> Smarter is to avoid the pre-zeroing pass over the destination if it
> can be proved the destination already reads as zero.  Note that a
> later patch will then further improve things to skip writing to the
> destination for parts of the image where the source is zero; but even
> with just this patch, it is possible to see a difference for any BDS
> that can quickly report that it already reads as zero.

Hmm.  When the destination reads as all zeroes, but is not (yet)
sparse, and the user has opened the destination image with
"discard":"unmap" and "detect-zeroes":"unmap", then pre-patch this
would sparsify the destination, but post-patch it leaves the
destination allocated.

When "detect-zeroes" is at its default of 'off', or even at 'on'
(which says optimize zero writes, but don't worry about punching
holes), that's not a problem.  But when "detect-zeroes" is at 'unamp',
this is a regression in behavior.  I'll see if I can quickly adjust
that in v3.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


