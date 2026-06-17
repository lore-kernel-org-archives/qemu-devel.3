Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FAACD98F1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoz2-0004Iy-AG; Wed, 17 Jun 2026 08:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@U-QD9X07DR-1901.local>)
 id 1wZkgf-0007WK-Rs
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:27:54 -0400
Received: from [140.205.11.250] (helo=U-QD9X07DR-1901.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guobin@U-QD9X07DR-1901.local>) id 1wZkgV-00009T-85
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 03:27:48 -0400
Received: by U-QD9X07DR-1901.local (Postfix, from userid 502)
 id AF40A5DFDE63; Wed, 17 Jun 2026 15:27:12 +0800 (CST)
To: peterx@redhat.com
Cc: farosas@suse.de, guobin@linux.alibaba.com, lizhijian@fujitsu.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] migration/rdma: honor blocking mode in QIOChannelRDMA
 readv
Date: Wed, 17 Jun 2026 15:27:11 +0800
Message-ID: <20260617072712.83154-1-laiqi.gb@alibaba-inc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260529070408.92651-2-guobin@linux.alibaba.com>
References: <20260529070408.92651-1-guobin@linux.alibaba.com>
 <20260529070408.92651-2-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 140.205.11.250 (deferred)
Received-SPF: none client-ip=140.205.11.250;
 envelope-from=guobin@U-QD9X07DR-1901.local; helo=U-QD9X07DR-1901.local
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jun 2026 08:02:38 -0400
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
Reply-to:  "laiqi.gb" <laiqi.gb@alibaba-inc.com>
From:  "laiqi.gb" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Guo <guobin@linux.alibaba.com>

On Tue, 16 Jun 2026, Peter Xu wrote:
> this patch made it the other way round: the channel didn't respect
> blocking mode because it always blocks, not always non-block.

You're right, the commit message was misleading.

The function already blocks inside qemu_rdma_exchange_recv() when
waiting for the next RDMA SEND message.  What it didn't do was keep
blocking when the bytes from a *single* receive were not enough to
satisfy the full request -- it would return partial data instead of
waiting for more.

In blocking mode a QIOChannel readv should keep trying until the
request is satisfied (or an error occurs), matching the behaviour of
other QIOChannel implementations.  That's what the loop is for.

> Also, this is only the read path; there's also write.

The write path already loops over the full iov in
qio_channel_rdma_writev(), so it handles the blocking case
correctly.  Only read needed fixing.

I send a v2 with a corrected commit message.  Thanks for the
review.

Bin Guo

