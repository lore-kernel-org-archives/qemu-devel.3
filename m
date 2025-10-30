Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A50CCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 14:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vETt3-0006LG-KN; Thu, 30 Oct 2025 10:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vETsz-0006KP-KH
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vETsp-0000gS-2T
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 10:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761835445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dNdPCJnaQIO6CHm8RW7IOPVfnG4h1I8d+DN8eQ/ZVE=;
 b=cgBUKmAPvZzYCIsfRsPjL1XS16mwbGEWy1D/E8jcvswHJ5A7dk5D1vGad0uPTPYYzb0b+V
 4DF+snRbd088e4BYq1NQKmdSLvPOw0/pgz8hXLOjbnGZqnBD+kLxPKTR6MQuF5e31lpGh+
 letT3qQpXgFDL2UWcH/xaU6Cx6wrWjM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-7fxD4UdMNce5Yltv1dBpBw-1; Thu,
 30 Oct 2025 10:44:02 -0400
X-MC-Unique: 7fxD4UdMNce5Yltv1dBpBw-1
X-Mimecast-MFC-AGG-ID: 7fxD4UdMNce5Yltv1dBpBw_1761835441
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9B511805C22; Thu, 30 Oct 2025 14:44:00 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.243])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7632519560A2; Thu, 30 Oct 2025 14:43:57 +0000 (UTC)
Date: Thu, 30 Oct 2025 15:43:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 hibriansong@gmail.com, qemu-block@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com
Subject: Re: [PATCH v5 00/12] aio: add the aio_add_sqe() io_uring API
Message-ID: <aQN5q47Lw2Bv8I_X@redhat.com>
References: <20251029203411.445852-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029203411.445852-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 29.10.2025 um 21:33 hat Stefan Hajnoczi geschrieben:
> v5:
> - Explain how fdmon-io_uring.c differs from other fdmon implementations
>   in commit message [Kevin]
> - Move test-nested-aio-poll aio_get_g_source() removal into commit that touches test case [Kevin]
> - Avoid g_source_add_poll() use-after-free in fdmon_poll_update() [Kevin]
> - Avoid duplication in fdmon_epoll_gsource_dispatch(), use fdmon_epoll_wait() [Kevin]
> - Drop unnecessary revents checks in fdmon_poll_gsource_dispatch() [Kevin]
> - Mention in commit message that fdmon-io_uring.c is the new default [Kevin]
> - Add comments explaining how to clean up resources in error paths [Kevin]
> - Indicate error in return value from function with Error *errp arg [Kevin]
> - Add patch to unindent fdmon_io_uring_destroy() [Kevin]
> - Add patch to introduce FDMonOps->dispatch() callback [Kevin]
> - Drop patch with hacky BH optimization for fdmon-io_uring.c [Kevin]
> - Replace cqe_handler_bh with FDMonOps->dispatch() [Kevin]
> - Rename AioHandler->cqe_handler field to ->internal_cqe_handler [Kevin]
> - Consolidate fdmon-io_uring.c trace-events changes into this commit
> - Reduce #ifdef HAVE_IO_URING_PREP_WRITEV2 code duplication [Kevin]

Actually the whole last patch that contained the duplication seems to be
missing. Did you accidentally remove it?

Kevin


