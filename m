Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7714CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 23:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3jS9-0001hS-HZ; Tue, 30 Sep 2025 19:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v3jS7-0001hI-6I
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 19:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v3jRx-00046S-KR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 19:08:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759273676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEBKgPrY+EPeNvVJQ5Bifgtja/q85cKx9vggjDcLps8=;
 b=UF85rUUVAC1frJ5LLQ5upgbqVFE8QvRXQc3pGir4abXPIvx/StLmrbRAXMR8U0YO26/JaD
 Thek0cBPcGj7qcLlSuwMzgZbUhgtB4dMC9mS1HmBt61RHTl6HVGfoA5rTvbQDeGUJLUIhp
 kYA5HwTqRxHiCkfvTe6EKku+NzX0DNE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-IB6ZrwEnPxepaI4hTJxvtg-1; Tue,
 30 Sep 2025 19:07:52 -0400
X-MC-Unique: IB6ZrwEnPxepaI4hTJxvtg-1
X-Mimecast-MFC-AGG-ID: IB6ZrwEnPxepaI4hTJxvtg_1759273672
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABA5D1977309; Tue, 30 Sep 2025 23:07:51 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.170])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C3581800576; Tue, 30 Sep 2025 23:07:49 +0000 (UTC)
Date: Tue, 30 Sep 2025 18:07:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: update inserted/removed nodes from
 BlockRAMRegistrar
Message-ID: <nevit4pwl3x7dzrwvc52bgbejoav56wxxmp2excrldgkvohrhw@t62qomftzb4f>
References: <20250930204555.162133-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930204555.162133-1-stefanha@redhat.com>
User-Agent: NeoMutt/20250510
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 30, 2025 at 04:45:51PM -0400, Stefan Hajnoczi wrote:
> This patch series fixes a bug in BlockRAMRegistrar: it currently doesn't react
> to block graph changes and newly inserted nodes lack RAMBlock information
> needed to map I/O buffers. This is important for vdpa-blk devices because they
> rely on the ability to map I/O buffers.
> 
> Stefan Hajnoczi (4):
>   block: add BdrvChildClass->propagate_attach/detach() callbacks
>   block: add blk_add_attach/detach_notifier() APIs
>   block: rename RAMBlockRegistrar->notifier field
>   block: update inserted/removed nodes from BlockRAMRegistrar

Makes sense to me.  For the series,

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
>  include/block/block_int-common.h            |  11 ++
>  include/system/block-backend-global-state.h |   9 ++
>  include/system/block-ram-registrar.h        |   4 +-
>  block.c                                     |  56 +++++--
>  block/block-backend.c                       |  44 ++++++
>  block/block-ram-registrar.c                 |  75 ++++++++-
>  tests/unit/test-block-backend.c             | 164 ++++++++++++++++++++
>  7 files changed, 344 insertions(+), 19 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


