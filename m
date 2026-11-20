Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7966606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AWVsvn97
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUS1J-0001Ct-CL; Fri, 20 Nov 2026 12:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xUS1H-0001Bw-A8
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xUS1F-0005Mz-JT
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795194203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3rVjaMq8ZcDTZ154DOJCXmh/ibsjUmqq3lEP5x9WWyg=;
 b=AWVsvn979PsYVKCk73kYnHYTHim4zvblSGrbsXuedDWqAb9TD6jlJRKES8v+SWG2KJXfS3
 g81CBj1sXTpg4iJQ8JD/UVQYz+GyyXrd1TdxaZXA/gIWO6XCAE30AvukSgcUBDw76vGzYN
 Op185rl2kpD8yZg5fWjaudqiUC+zOF0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-GzhlUTaPOCO3XZGpeSC0-w-1; Fri,
 20 Nov 2026 17:03:18 +0000
X-MC-Unique: GzhlUTaPOCO3XZGpeSC0-w-1
X-Mimecast-MFC-AGG-ID: GzhlUTaPOCO3XZGpeSC0-w_1795194194
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE2B71800488; Fri, 20 Nov 2026 17:03:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EE76342; Fri, 20 Nov 2026 17:03:11 +0000 (UTC)
Date: Fri, 20 Nov 2026 18:03:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <awB9TbgTzxvPBeVk@redhat.com>
References: <20261119145311.1144878-1-peterx@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119145311.1144878-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.2026 um 15:53 hat Peter Xu geschrieben:
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
> Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Hongyan Xu <getshell@seu.edu.cn>
> Signed-off-by: Peter Xu <peterx@redhat.com>

The fix looks right to me, however now FDYieldUntilData has two unused
fields. I suppose you could get rid of it entirely now and pass the
coroutine pointer as opaque.

Kevin


