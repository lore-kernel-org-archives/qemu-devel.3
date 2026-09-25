Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB445C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA6Wm-00043Y-8G; Fri, 25 Sep 2026 10:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xA6Wh-00043A-6h
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 10:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xA6Wd-0000xO-E9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 10:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790345011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vBiH1+gebYAPPzVGOM7V5zGiOdRE1zg1LwtOqWtbQ1g=;
 b=NMLZb/9Ij0cUfExa7P1HqVf6sNHuY7hafk+nAQJGHGTBC43/yRdBzetOfcQbaOU4QlKDM7
 cf6Bwqld55iXHZdLOiHGYzvFrTWYtdifLBiyfnHSEElJ2a2XT9dItqfh0UjZArZNvtpWbw
 +95WCPUhDai505a0xY65neBov0jYsGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-hF_AXmipO8u_ehrNJ0a-gA-1; Fri,
 25 Sep 2026 10:03:27 -0400
X-MC-Unique: hF_AXmipO8u_ehrNJ0a-gA-1
X-Mimecast-MFC-AGG-ID: hF_AXmipO8u_ehrNJ0a-gA_1790345006
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273891840C67; Fri, 25 Sep 2026 14:03:26 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.175])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 342A530002D6; Fri, 25 Sep 2026 14:03:23 +0000 (UTC)
Date: Fri, 25 Sep 2026 16:03:21 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 0/9] scripts/qemugdb: some fixes for 'qemu bt' / 'qemu
 coroutine' commands
Message-ID: <arZ_Kfg_AOgfILee@redhat.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 04.08.2026 um 17:17 hat Andrey Drobyshev geschrieben:
> A bunch of fixes for functional bugs, cosmetic improvements and fixes
> for annoying failures and corner cases which I encounter when using this
> script in gdb sessions.  Most of them are basically fixups for my previous
> commit 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining
> detailed trace in coredump").  Still I did split them up cause it'd be a
> mess putting them all together.
> 
> Andrey Drobyshev (9):
>   scripts/qemugdb: coroutine: Fix selected frame leak on error path
>   scripts/qemugdb: coroutine: Get rid of fallback pattern when dumping
>     backtrace
>   scripts/qemugdb: coroutine: Only attempt to restore regs in coredump
>   scripts/qemugdb: coroutine: Don't unwind past the outermost frame
>   scripts/qemugdb: coroutine: Fix patching pt_regs in the coredump
>   scripts/qemugdb: coroutine: Fix '--detailed' description
>   scripts/qemugdb: coroutine: Handle target absence gracefully
>   scripts/qemugdb: coroutine: Speed up coroutine lookup in a coredump
>   scripts/qemugdb: coroutine: Don't touch the coredump for a plain
>     backtrace
> 
>  scripts/qemugdb/coroutine.py | 135 ++++++++++++++++++++++-------------
>  1 file changed, 86 insertions(+), 49 deletions(-)

Thanks, applied to the block branch.

Kevin


