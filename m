Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505B0D68BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 09:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWAC0-00032w-Bf; Thu, 18 Dec 2025 04:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vWABl-00032S-Tk
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:20:50 -0500
Received: from sg-1-103.ptr.blmpb.com ([118.26.132.103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vWABg-0005n3-2k
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 04:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1766049623; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Yx4BIP5+6EKVCoEm0zoPq0/I9xrQPQjktACnV7eqgVg=;
 b=eBYBbZOQKsKKBjG9x77FlI00kwejs3ZHQBEOn0dP3tS09nltQpLehEpL/bc7jdDRVhlNzM
 ovZ+9nILTI50zEPnB2b1PbwS9pI+K6rvC7k3J/kNFwHa8gPyyy0yJUq4m8XHk98i6wtiCd
 wXoJtYByNqB5Om0yBD2lLOAWIA+pXXFvnk6AGFsR1McBV84nfYlmjhBbwN8ehi6zs2hrYH
 OO1llsBQ/YN5UzckrJPuu/vqdvxqXurw+5JxRt9T1B5KTEMSEAyeF9YNJDDVt9RcpbEFyT
 NLyQlzIeRlwEqm2T7EeyY8XAaxO6zjxyHSOkcZflGWd2K0OJfTyeTvXe4XUKww==
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
To: "Peter Xu" <peterx@redhat.com>
Date: Thu, 18 Dec 2025 17:20:19 +0800
Message-Id: <82ca276d-831d-4e19-96e2-d88a7f94a430@bytedance.com>
X-Lms-Return-Path: <lba+26943c755+8042fb+nongnu.org+xuchuangxclwt@bytedance.com>
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
 <877bum36ed.fsf@suse.de> <aUGIPj1JNpd8HZ-V@x1.local>
 <29bc82b4-99c3-4275-b4a8-cfc400f0e44d@bytedance.com>
 <aUKuWISfpQeld_AF@x1.local>
 <65dc5a3d-fe3f-48d9-b7e8-c04346308fa8@bytedance.com>
 <aULFP1kbeT2yceiV@x1.local>
Cc: <qemu-devel@nongnu.org>, "Fabiano Rosas" <farosas@suse.de>, 
 <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <david@kernel.org>, <philmd@linaro.org>
In-Reply-To: <aULFP1kbeT2yceiV@x1.local>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Received-SPF: pass client-ip=118.26.132.103;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-103.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/12/2025 22:59, Peter Xu wrote:
> Right, it will, because any time used for sync has the vCPUs running, so
> that will contributes to the total dirtied pages, hence partly increase D,
> as you pointed out.
>
> But my point is, if you _really_ have R=B all right, you should e.g. on a
> 10Gbps NIC seeing R~=10Gbps.  If R is not wire speed, it means the R is not
> really correctly measured..

In my experience, the bandwidth of live migration usually doesn't reach
the nic's bandwidth limit (my test environment's nic bandwidth limit is 200Gbps).
This could be due to various reasons: for example, the live migration main thread's
ability to search for dirty pages may have reached a bottleneck;
the nic's interrupt binding range might limit the softirq's processing capacity;
there might be too few multifd threads; or there might be overhead in synchronizing
between the live migration main thread and the multifd thread.

>
> I think it's likely impossible to measure the correct R so that it'll equal
> to B, however IMHO we can still think about something that makes the R
> getting much closer to B, then when normally y is a constant (default
> 300ms, for example) it'll start to converge where it used to not be able to.

Yes, there are always various factors that can cause measurement errors.
We can only try to make the calculated value as close as possible to the actual value.

> E.g. QEMU can currently report R as low as 10Mbps even if on 10Gbps, IMHO
> it'll be much better and start solving a lot of such problems if it can
> start to report at least a few Gbps based on all kinds of methods
> (e.g. excluding sync, as you experimented), then even if it's not reporting
> 10Gbps it'll help.
>
After I applied these optimizations, typically the bandwidth statistics
from QEMU and the real-time nic bandwidth monitored by atop are close.

Those extremely low bandwidth(but consistent with atop monitoring) is usually
caused by zero pages or dirty pages with extremely high compression rates.
In these cases, QEMU uses very little nic bandwidth to transmit a large number
of dirty pages, but the bandwidth is only calculated based on the actual
amount of data transmitted.

If we want to use the actual number of dirty pages transmitted to calculate
bandwidth, we face another risk: if the dirty pages transmitted before the
downtime have a high compression ratio, and the dirty pages to be transmitted
after the downtime have a low compression ratio, then the downtime will far
exceed expectations.

This may have strayed a bit, but just providing some potentially useful information
from my perspective.

Thanks!

