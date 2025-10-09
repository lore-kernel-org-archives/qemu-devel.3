Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED503CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 15:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6srX-0004XX-LA; Thu, 09 Oct 2025 11:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6srV-0004XN-6a
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6srL-0005AL-3X
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 11:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760024831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AAOBAoxNy2wJkKda1WFhVWlLpmdgBlXYcQJQZa1sqlE=;
 b=EFL13YCX0bYL4sr+jwTCFC70NHBVnqvCCQUEXMe2nF8+uWTySgZQWP3ge8UYKQowtdCQAy
 jNFPrGjI0xe6cF+9KOI2gonKBhQe/4VOeMNmBlissEJW+ctk5W2WI/06aJ9tsZA0oZXSCP
 pJBKy5arRr9cHc0R1z5dR67pdpG+BNk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-8Mrigj3CPRGHcAhWddsuMA-1; Thu,
 09 Oct 2025 11:47:05 -0400
X-MC-Unique: 8Mrigj3CPRGHcAhWddsuMA-1
X-Mimecast-MFC-AGG-ID: 8Mrigj3CPRGHcAhWddsuMA_1760024823
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10351800451; Thu,  9 Oct 2025 15:47:03 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E834B30001B7; Thu,  9 Oct 2025 15:46:59 +0000 (UTC)
Date: Thu, 9 Oct 2025 17:46:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 05/12] aio: remove aio_context_use_g_source()
Message-ID: <aOfY8TgysdujAL-l@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-6-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910175703.374499-6-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> There is no need for aio_context_use_g_source() now that epoll(7) and
> io_uring(7) file descriptor monitoring works with the glib event loop.
> AioContext doesn't need to be notified that GSource is being used.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

We should probably mention in the commit message that this causes the
default fdmon on Linux to change from poll to io_uring. It's a small
code change, but it makes QEMU use a completely different code path by
default.

With this added: Reviewed-by: Kevin Wolf <kwolf@redhat.com>

> diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
> index 45484e745b..d13ecccd8c 100644
> --- a/tests/unit/test-nested-aio-poll.c
> +++ b/tests/unit/test-nested-aio-poll.c
> @@ -83,12 +83,6 @@ static void test(void)
>      /* Enable polling */
>      aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
>  
> -    /*
> -     * The GSource is unused but this has the side-effect of changing the fdmon
> -     * that AioContext uses.
> -     */
> -    aio_get_g_source(td.ctx);
> -
>      /* Make the event notifier active (set) right away */
>      event_notifier_init(&td.poll_notifier, 1);
>      aio_set_event_notifier(td.ctx, &td.poll_notifier,

I wonder if it wouldn't make sense to squash this hunk into patch 3
('tests/unit: skip test-nested-aio-poll with io_uring').

Kevin


