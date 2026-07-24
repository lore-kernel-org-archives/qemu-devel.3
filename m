Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479CDC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFZF-0006Kn-81; Fri, 24 Jul 2026 09:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnFZA-0006JC-5d
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wnFZ7-0003ED-Jm
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784898228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzEUyqZwlz4laCr3v5OX3AXqG4UafoZ0WdaTog+GTnA=;
 b=Rczpa8K7yZXAKnm/7ZDQG+j5Fadn7bcc1RTmwa87fHrllIOtV5EAr90X9uojAfoPKu0tVb
 mJuiPN0p8Aa1qvTksJI473x+EhveHdSSq83dVt4oEZwSxlSPpu/M2Fsp/G/+X/XnUrbSGO
 E40phRa6UNegn2vviiUu+VFkNs+OjRs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-SYshLs-yOXuPd7pdH5Yaug-1; Fri,
 24 Jul 2026 09:02:39 -0400
X-MC-Unique: SYshLs-yOXuPd7pdH5Yaug-1
X-Mimecast-MFC-AGG-ID: SYshLs-yOXuPd7pdH5Yaug_1784898158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 687CD1800844; Fri, 24 Jul 2026 13:02:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91484190CDF8; Fri, 24 Jul 2026 13:02:34 +0000 (UTC)
Date: Fri, 24 Jul 2026 15:02:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v2 0/3] block/accounting: fix unlocked latency histogram
 reconfiguration races
Message-ID: <amNiaGIifcK8FNDe@redhat.com>
References: <20260724111311.4086859-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724111311.4086859-1-den@openvz.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 24.07.2026 um 13:13 hat Denis V. Lunev geschrieben:
> block_latency_histogram_set() and block_latency_histograms_clear()
> replace BlockLatencyHistogram's nbins/boundaries/bins without taking
> stats->lock, while block_account_one_io() reads those same fields
> under that lock from whatever iothread completes the I/O. A histogram
> reconfiguration (block-latency-histogram-set QMP command, monitor
> thread) racing an in-flight completion can therefore observe those
> fields torn, hitting assert(pos != NULL) in
> block_latency_histogram_account(), or corrupting the heap outright.
> This showed up as a qemu-kvm SIGABRT on a customer's virtio-blk guest.
> 
> Regression test is added for illustrative purpose but I am unsure that
> it is viable long term. Feel free to drop.
> 
> v1 -> v2
> * patch 1, 2: WITH_QEMU_LOCK_GUARD -> plain lock()/unlock(), pure
>   additions, nothing reindented or moved
> * patch 3: writer thread now also calls
>   block_latency_histograms_clear(), the other function patch 1 fixes
> * patch 2: take stats->lock for bdrv_query_blk_stats()'s whole call
>   instead of per-section, since the interval loop's
>   timed_average_min/max/avg() calls race timed_average_account() the
>   same way the already-locked fields did; block_acct_queue_depth()
>   now requires the caller to hold the lock instead of taking it
>   itself, since bdrv_query_blk_stats() is its only caller

Thanks, applied to the block branch.

Kevin


