Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276F3CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 05:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa5jK-0000A2-N5; Thu, 18 Jun 2026 01:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@U-QD9X07DR-1901.local>)
 id 1wa5jD-00009h-2m
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:55:51 -0400
Received: from [2401:b180:1000:3::1:7a1] (helo=U-QD9X07DR-1901.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guobin@U-QD9X07DR-1901.local>) id 1wa5j6-0000Qb-Rn
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 01:55:50 -0400
Received: by U-QD9X07DR-1901.local (Postfix, from userid 502)
 id 8014A5E400F9; Thu, 18 Jun 2026 13:55:22 +0800 (CST)
To: peterx@redhat.com
Cc: berrange@redhat.com, farosas@suse.de, guobin@linux.alibaba.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] migration/rdma: honor blocking mode in
 QIOChannelRDMA readv
Date: Thu, 18 Jun 2026 13:55:22 +0800
Message-ID: <20260618055522.13792-1-laiqi.gb@alibaba-inc.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <ajKvputk1JI0tPAY@x1.local>
References: <20260529070408.92651-1-guobin@linux.alibaba.com>
 <20260529070408.92651-2-guobin@linux.alibaba.com> <ajGfYYFrhlEaklig@x1.local>
 <ajKvputk1JI0tPAY@x1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2401:b180:1000:3::1:7a1
 (deferred)
Received-SPF: none client-ip=2401:b180:1000:3::1:7a1;
 envelope-from=guobin@U-QD9X07DR-1901.local; helo=U-QD9X07DR-1901.local
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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
Reply-to:  "laiqi.gb" <laiqi.gb@alibaba-inc.com>
From:  "laiqi.gb" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Guo <guobin@linux.alibaba.com>

On Wed, 18 Jun 2026, Peter Xu wrote:
> If io_readv() reads partial, IIUC returning how much it reads is the
> correct behavior. You can refer to qio_channel_socket_readv().

You're right.  I misread the QIOChannel contract.  readv() should
return whatever is available, not loop until the full request is
satisfied.  The socket implementation confirms that.

> RDMA doesn't respect blocking is because it _always_ blocks. That is,
> qemu_rdma_exchange_recv() always will block even if blocking=false.

Yes, that's the real issue.  My v2 patch only changed the blocking
path and left qemu_rdma_exchange_recv() blocking unconditionally in
non-blocking mode, which is wrong and can break coroutine use cases.

I'll drop [PATCH 1/2].  The blocking/non-blocking handling in RDMA
needs a more fundamental rework than this series attempted.

> Also, I'd like Zhijian to take another look, and cc Dan too.

Understood.

For [PATCH 2/2] "migration/rdma: account transferred bytes for zero
page compression", it is an independent fix for RDMA migration
accounting and unrelated to the blocking-mode discussion.  I'd like
to keep that one separate and submit it on its own if there are no
further comments.

Thanks,
Bin Guo

