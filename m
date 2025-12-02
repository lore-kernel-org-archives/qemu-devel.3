Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E91D11704
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 16:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQSrB-0004g2-Gd; Tue, 02 Dec 2025 11:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQSrA-0004fa-55
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:04:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vQSr8-00065C-7z
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 11:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764691436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDUAZ6NgJx5pFs1rUCr5QHof4ezbIWtf1zv1rYrcdJg=;
 b=VFIjNk5jA53lr/NSjrJRI+yxeJSJDMxMJDv22evWAffySFVxNerkz6egazgr/Hy5RBfK0D
 n6HP0NiOjdd8AEL5bCXKNWth//mpgVMOLmq+FffVq1r7wwzPlWgkJSMesB4MkkGIDonhXI
 gCbpFaXD3hmE7HRKIin0KzmwAOFsPSk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-mYIPyim6Oy-gZkCKmgfNZA-1; Tue,
 02 Dec 2025 11:03:53 -0500
X-MC-Unique: mYIPyim6Oy-gZkCKmgfNZA-1
X-Mimecast-MFC-AGG-ID: mYIPyim6Oy-gZkCKmgfNZA_1764691432
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 470051955E7F; Tue,  2 Dec 2025 16:03:52 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.249])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89F2919560A7; Tue,  2 Dec 2025 16:03:50 +0000 (UTC)
Date: Tue, 2 Dec 2025 17:03:47 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] block: split qemu/aio.h out of block/aio.h
Message-ID: <aS8N4_LDyW1DrF_x@redhat.com>
References: <20251128101555.227630-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128101555.227630-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 28.11.2025 um 11:15 hat Paolo Bonzini geschrieben:
> Rust bindings are roughly broken up according to subdirectories of
> include/ (that's not exact, but it's roughly an aim).  However,
> block/aio.h contains both block layer-specific concepts (BlockAIOCB,
> BlockCompletionFunc) and AioContext-related declarations that are
> used be qemu/main-loop.h.
> 
> Break out the latter into their own header file, and use that to
> break the inclusion of block/ from qemu/main-loop.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Based on top of
> 	https://lore.kernel.org/qemu-devel/20251127131516.80807-3-pbonzini@redhat.com/
> 
>  include/block/aio.h      | 838 +-------------------------------------
>  include/qemu/aio.h       | 852 +++++++++++++++++++++++++++++++++++++++
>  include/qemu/main-loop.h |   4 +-
>  3 files changed, 857 insertions(+), 837 deletions(-)
>  create mode 100644 include/qemu/aio.h

Is it really worth keeping a separate tiny include file for BlockAIOCB?
Maybe let's have a patch to move it and its three functions to
block-common.h, and then just move this file unchanged into the place
where it should always have been.

Kevin


