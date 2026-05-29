Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D542CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 07:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSrGu-0000W5-MB; Fri, 29 May 2026 03:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSrGl-0000VX-Qw
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:04:35 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1wSrGj-0008B9-2e
 for qemu-devel@nongnu.org; Fri, 29 May 2026 03:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1780038250; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=2nCwX2iqKB9bsAFbLUnoxcGES800omXU8YiCiCVJoBQ=;
 b=nQd4ym59/znPsoCOR+89ufYH7S5eNL/v/p+SNi3DhIRMCzmbaGS5REoNuGJ97MxmTvMGlEOnzOGcjU3rkotShURNDQGjPLGnOhc9QpTCYBpNa2ndVRbPHAsq+lIra6+LsMKFVabcNq3SiH+zn5JHtyVV7mmgEVSxmQh2+7LRXCk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R291e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X3odXVr_1780038249; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X3odXVr_1780038249 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 29 May 2026 15:04:10 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 0/2] migration/rdma: fix blocking readv and zero-page
 accounting
Date: Fri, 29 May 2026 15:04:06 +0800
Message-ID: <20260529070408.92651-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

This small series fixes two independent issues in the RDMA migration
code path that were noticed while reviewing the QIOChannelRDMA behavior
and migration statistics during RDMA live migration.

Patch 1 makes QIOChannelRDMA's readv honor the blocking flag set via
io_set_blocking().  Previously, in blocking mode it returned immediately
when the receive buffer could not satisfy the request, diverging from
other QIOChannel implementations.  The fix loops on
qemu_rdma_exchange_recv() while the channel is in blocking mode, and
removes the now-stale XXX comments about unimplemented blocking
support.

Patch 2 fixes transfer accounting for the RDMA zero page compression
path.  When a zero page is detected, an RDMA_CONTROL_COMPRESS message
is sent instead of an RDMA Write, but mig_stats.rdma_bytes and
ram_transferred_add() were never updated, so migration progress and
bandwidth were undercounted.  The patch accounts the wire cost
(RDMAControlHeader + RDMACompress payload), matching how the non-RDMA
path accounts for zero page markers.

Both patches are small and self-contained; no behavior change is
expected outside the RDMA migration path.

Bin Guo (2):
  migration/rdma: honor blocking mode in QIOChannelRDMA readv
  migration/rdma: account transferred bytes for zero page compression

 migration/rdma.c | 62 ++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 33 deletions(-)

-- 
2.50.1 (Apple Git-155)


