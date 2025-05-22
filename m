Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84968C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 12:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5AQ-0006oc-LN; Thu, 22 May 2025 08:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI59r-0006id-S6
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI59o-0001JC-Lz
 for qemu-devel@nongnu.org; Thu, 22 May 2025 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747917377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5EAsjv9wrL99HIoZp0w2tcHiQs210DoZUmuPnVbrbw=;
 b=hj8LixGmAGnZWd2Iq9A2DDiCTWa3kG00YcIsibbzxLfgfkART8xTV2WgxRSfEszXm3WFtg
 CX8b9EygU+3cMoQXCn+fXmGGzXcyvI8stBzZvRK9pdRDq8e5CGH2k7P70oANseu2ygNzbw
 ePJUliDEmFHbetDP8LDrsVwHNiH4UfM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-JFf5yhkbNyKrJlwoDfq1Kg-1; Thu,
 22 May 2025 08:36:14 -0400
X-MC-Unique: JFf5yhkbNyKrJlwoDfq1Kg-1
X-Mimecast-MFC-AGG-ID: JFf5yhkbNyKrJlwoDfq1Kg_1747917372
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B6A11955DB5; Thu, 22 May 2025 12:36:10 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.76])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A6B0180045B; Thu, 22 May 2025 12:36:04 +0000 (UTC)
Date: Thu, 22 May 2025 14:36:01 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com,
 stefanha@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 vsementsov@yandex-team.ru, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com, berto@igalia.com, fam@euphon.net, ari@tuxera.com
Subject: Re: [PATCH v2 09/24] block: move drain outside of
 bdrv_try_change_aio_context()
Message-ID: <aC8aMZDZqE1X2XZ2@redhat.com>
References: <20250520103012.424311-1-f.ebner@proxmox.com>
 <20250520103012.424311-10-f.ebner@proxmox.com>
 <aC4BCk_BWM-lMuVs@redhat.com>
 <67436842-4c8a-4536-ad6f-36952160770e@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67436842-4c8a-4536-ad6f-36952160770e@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 22.05.2025 um 11:56 hat Fiona Ebner geschrieben:
> Am 21.05.25 um 18:36 schrieb Kevin Wolf:
> > Am 20.05.2025 um 12:29 hat Fiona Ebner geschrieben:
> >> This is part of resolving the deadlock mentioned in commit "block:
> >> move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".
> >>
> >> Convert the function to a _locked() version that has to be called with
> >> the graph lock held and add a convenience wrapper that has to be
> >> called with the graph unlocked, which drains and takes the lock
> >> itself. Since bdrv_try_change_aio_context() is global state code, the
> >> wrapper is too.
> >>
> >> Callers are adapted to use the appropriate variant. In the
> >> test_set_aio_context() unit test, prior drains can be removed, because
> >> draining already happens inside the new wrapper.
> > 
> > I'm not sure what's the difference between qmp_x_blockdev_set_iothread()
> > which is converted to _locked() and e.g. qmp_blockdev_mirror().
> 
> For deciding on the variant, I only looked at whether the caller holds
> the graph lock or not.

Oh, I see. I was thinking much too complicated once again.

Maybe just add "the appropriate variant, depending on whether the caller
already holds the lock"?

> > The reason I could see in qmp_x_blockdev_set_iothread() is that (as we
> > discussed in the RFC version of this series) draining can change the
> > graph and that could in theory invalidate bs. But the same is true for
> > other functions in blockdev.c.
> 
> Right, my patches are not enough to address that kind of problem.
> 
> > If it's just that qmp_x_blockdev_set_iothread() was easy to fix and the
> > others are more complex, that's fine with me, but maybe worth mentioning
> > in the commit message.
> 
> Yes, I can mention something in the commit message, maybe:
> 
> Functions like qmp_blockdev_mirror() query the nodes to act on before
> draining and locking. In theory, draining could invalidate those nodes.
> This kind of issue is not addressed by these commits.

Doesn't hurt, but it's also not really needed.

Kevin


