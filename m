Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA6CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 17:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6tzd-00017X-AD; Thu, 09 Oct 2025 12:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6tzV-00013K-Bg
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1v6tzO-0007CA-1S
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760029171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0+M6fQEFegl1N1qs1zg4olIhOS5WJCvtOEJ5M9PXKdA=;
 b=agZ5VOH2B4xwwtt3NeqyBqCz3D2F1Cp2+NA0Yx+Z9pGasOe9v7CYQMumc5eWKqMPxJqbV/
 oz5H2+xedm6WCtFvzApGPrOMw8KwpqN56MA/SmlJstwqGAeG4p+x7Z9zmuN1eHtLWkTEqn
 hXRdkTUxO6FrqjFsppMuMRNc+aLaY6I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-cD6UtK3oNuaHgX0-xqA1xQ-1; Thu,
 09 Oct 2025 12:59:28 -0400
X-MC-Unique: cD6UtK3oNuaHgX0-xqA1xQ-1
X-Mimecast-MFC-AGG-ID: cD6UtK3oNuaHgX0-xqA1xQ_1760029167
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F0AB19560B2; Thu,  9 Oct 2025 16:59:26 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.99])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3B441800578; Thu,  9 Oct 2025 16:59:22 +0000 (UTC)
Date: Thu, 9 Oct 2025 18:59:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, eblake@redhat.com,
 qemu-block@nongnu.org, hibriansong@gmail.com,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 05/12] aio: remove aio_context_use_g_source()
Message-ID: <aOfp6I_v6N3dc-YB@redhat.com>
References: <20250910175703.374499-1-stefanha@redhat.com>
 <20250910175703.374499-6-stefanha@redhat.com>
 <aOfY8TgysdujAL-l@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOfY8TgysdujAL-l@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Am 09.10.2025 um 17:46 hat Kevin Wolf geschrieben:
> Am 10.09.2025 um 19:56 hat Stefan Hajnoczi geschrieben:
> > There is no need for aio_context_use_g_source() now that epoll(7) and
> > io_uring(7) file descriptor monitoring works with the glib event loop.
> > AioContext doesn't need to be notified that GSource is being used.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> We should probably mention in the commit message that this causes the
> default fdmon on Linux to change from poll to io_uring. It's a small
> code change, but it makes QEMU use a completely different code path by
> default.

Just to make sure, I ran 'make check' after this patch and it's failing
for me:

 10/401 qemu:qtest+qtest-x86_64 / qtest-x86_64/ahci-test                    TIMEOUT        150.02s   killed by signal 15 SIGTERM
133/401 qemu:unit / test-aio                                                TIMEOUT         30.01s   killed by signal 15 SIGTERM
137/401 qemu:unit / test-bdrv-drain                                         TIMEOUT         30.01s   killed by signal 15 SIGTERM
142/401 qemu:unit / test-block-iothread                                     TIMEOUT         30.01s   killed by signal 15 SIGTERM
192/401 qemu:doc+rust / rust-bql-rs-doctests                                FAIL             0.84s   exit status 101
311/401 qemu:block / io-qcow2-267                                           ERROR            3.20s   exit status 1
321/401 qemu:block / io-qcow2-copy-before-write                             TIMEOUT        180.01s   killed by signal 15 SIGTERM

Some of them look unrelated, but I have confirmed that the three unit
tests still pass before this patch (and still hang after the complete
series).

Kevin


