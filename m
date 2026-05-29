Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D39ECD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxRI-0006yD-7b; Fri, 29 May 2026 09:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSxRD-0006xQ-Iz
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wSxRC-0004Uy-4Z
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780061984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wMt5rWqlm0F7EalJNfPMtguRYkVS3rsc7cHmyLCfcmE=;
 b=IXvMjnCL58ryFsuLRSgm9gMWSw/bg52bbHCpSmtHvzFv7HwuDkxeq1j9wOQjYSzhK7vW4j
 KGJUqlzRKCb2Iqrtj/TS+1W/FoKqzNECYGMriCGGduHmDAaeAvmDkJM7IMlnTQg0olNcuo
 6mETXjt4oinbZFeshMob1qFliBpCLqA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-aiqkoLPFP96JcNCe46KqQA-1; Fri,
 29 May 2026 09:39:40 -0400
X-MC-Unique: aiqkoLPFP96JcNCe46KqQA-1
X-Mimecast-MFC-AGG-ID: aiqkoLPFP96JcNCe46KqQA_1780061979
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 078E2180034E; Fri, 29 May 2026 13:39:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.95])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8234A180056E; Fri, 29 May 2026 13:39:37 +0000 (UTC)
Date: Fri, 29 May 2026 15:39:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Subject: Re: [PATCH] util/qemu-coroutine: skip global pool lock when pool is
 empty
Message-ID: <ahmXFt7AtoyClZui@redhat.com>
References: <20260529015423.49688-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529015423.49688-1-guobin@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Am 29.05.2026 um 03:54 hat Bin Guo geschrieben:
> coroutine_pool_refill_local() acquires global_pool_lock on every
> call even when the global pool is empty (global_pool_size == 0).
> Under high I/O concurrency many threads simultaneously attempt to
> refill from an empty global pool, causing unnecessary mutex
> contention.
> 
> Add a fast-path check: read global_pool_size with qatomic_read()
> before acquiring the mutex.  If zero, the global pool is empty and
> we return immediately.  This is a racy read but correctness is
> preserved: the only consequence of a stale read is a missed refill
> opportunity, which will be retried on the next coroutine allocation.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

If you have any benchmark results, putting them in the commit message
would be a good idea. (If you don't have them, you should probably get
them for a patch that is motivated by performance.)

Kevin


