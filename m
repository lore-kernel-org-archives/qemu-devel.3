Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D20606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cTNOIbf5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWggO-0002Ng-Gh; Thu, 26 Nov 2026 16:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xWggM-0002Ju-9B
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xWggK-0005vW-G6
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 16:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795727222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3mW8Ry6atjIMFXOM2qn0FP6n1CB8ocDzNrsn0aK1dVc=;
 b=cTNOIbf5Py7giWD6R70Qu1+JeGF55ZOuxRkb+jmxWdmZ6sdZG/28E+NjuHgsqF3GT0xLxi
 xuo9/anIYxECIq6Yvhrax0QDDvZQy0IBcIUmWri91JNP+b634WvLHzYJk3dHFktLGwzs6F
 KkeQAXum3vAKX6TD+mu/iuVUaDtWEgc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-wRwt_AEHNECwDuhKTrjcmA-1; Thu,
 26 Nov 2026 21:06:58 +0000
X-MC-Unique: wRwt_AEHNECwDuhKTrjcmA-1
X-Mimecast-MFC-AGG-ID: wRwt_AEHNECwDuhKTrjcmA_1795727217
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D51A5195608B; Thu, 26 Nov 2026 21:06:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63C2A410; Thu, 26 Nov 2026 21:06:56 +0000 (UTC)
Date: Thu, 26 Nov 2026 16:06:55 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH for-12.0 v3] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <20261126210655.GA251101@shajnocz.csb>
References: <20261126201445.3326530-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126201445.3326530-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 03:14:45PM -0500, Peter Xu wrote:
> Hongyan reported a possible use-after-free of RDMA migration code:
> 
> https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> 
> The issue seems real, while this patch is a proposal to fix it in a simpler
> way, meanwhile it should be a problem to the yield_until_fd_readable()
> helper in general, so it should make more sense to be fixed there too.
> 
> The problem is about the use of the stack allocated FDYieldUntilData where
> we must make sure after yield_until_fd_readable() returns it's not used
> anywhere.  If the coroutine yielded can be entered from outside of this
> helper (fd_coroutine_enter()), then the aio handler might be installed even
> after yield_until_fd_readable() returns, and that makes the stack variable
> accessible by aio codd, even if stack gone.
> 
> Fix it by moving the aio handler removal outside the handler.
> 
> Fixes: 923709896b1b ("migration: poll the cm event for destination qemu")
> Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - Drop FDYieldUntilData altogether [Kevin]
> - Drop the comment, doesn't feel as helpful now [myself]
> v3:
> - Add doc for the helper [Stefan]
> - Add Fixes [Stefan]
> ---
>  include/qemu/coroutine.h |  5 ++++-
>  util/qemu-coroutine-io.c | 20 +++++---------------
>  2 files changed, 9 insertions(+), 16 deletions(-)

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

The latest qemu.git tag is v11.2.0-rc2 and this bug is not a regression
in the current release (commit 923709896b1b is from 2018), so I'm
queuing this on the block-next branch for QEMU v12.0.0. If there is a
reason to still put this into v11.2.0-rc3, please let me know.

CCing -stable too

Stefan


