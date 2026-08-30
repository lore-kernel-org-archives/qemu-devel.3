Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C092C61DD6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 01:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ULb-0000Mx-AJ; Sat, 29 Aug 2026 21:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x0ULV-0000Mc-2Y
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 21:28:29 -0400
Received: from va-1-115.ptr.blmpb.com ([209.127.230.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x0ULS-00020Y-O8
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 21:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788053286; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5DW4vYMvjeHCxwNWni1hlz0n93O5xi7oYbgwxBgvu30=;
 b=PdC+VpUJ2Qk9eZLalL01+BDFw8YP4zEtIWcxMqYzBdOVu3EuwT5IAd4SCcffzXnoFeSTwg
 WnbQ6HzIMfcOTrIHr1wtgAInJF7PFF/I8yNVf3Cm6l3qhTbDM+xTUkY3NCsYezkAq3DHKE
 rQz4+6Xlp2v3B/wXbvEnh0FP9RxTBbCoJYWM1HmYw8JzlKReBFau7NkaKXbBe+WqFLqSLP
 a7yowEarP2WVATg/1uafiI4IAJa9L5AizrqyhnZbV8Txx+5UJPRXTLD8y+lDz8jiMA1L7F
 B2DZ/Zt7gkdfikKlBZYy7/IrnvOz2ds6Bxb8Z515Grk9XeH6TKAL/49sfrEH7Q==
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2 0/4] migration/rdma: Allow multiple writes per chunk
Date: Sun, 30 Aug 2026 09:27:46 +0800
Message-Id: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a938724+0716dc+nongnu.org+yanfei.xu@bytedance.com>
To: <qemu-devel@nongnu.org>
X-Mailer: git-send-email 2.20.1
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.115;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-115.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series improves RDMA migration throughput during iterative precopy
and the iterable stop-copy phase by allowing multiple writes to be in
flight for the same registration chunk.

RDMA tracks RAM in registration chunks.  During the final iterable
transfer, workloads can leave many scattered 4 KiB dirty pages, with
multiple pages falling into the same chunk.  The current code waits for
an earlier write to a chunk to complete before posting the next one.
These serial completion waits can leave send queue capacity unused and
limit RDMA bandwidth, increasing downtime.

A ram_save_iterate() call can stop due to rate limiting before the RAM
scanner completes a full round.  Therefore, it is not the correct
boundary for ordering page versions.

Add a return-valued notifier at the point where the RAM scanner wraps to
the first RAMBlock.  Convert multifd's existing per-round
synchronization to use this notifier, and register an RDMA notifier that
flushes buffered writes and drains outstanding completions at the same
boundary.

This provides the explicit completion barrier before a newer version of
a page can be sent.  The per-chunk wait is therefore unnecessary and is
removed, together with the now-unused transit bitmap.

The test configuration is:

  RDMA chunk size:       32 MiB
  Guest:                 32 vCPUs, 128 GiB RAM
  Test runs:             10
  Maximum HCA bandwidth: 100 Gbps
  Workload:              idle


Average result(pin-all=true)    Before       After
  pin-all is true
  Downtime                      396.7 ms     345.7 ms        ~12.9% improve
  Final iterable bandwidth      9952.0 MiB/s 11639.10 MiB/s  ~17.0% improve


Average results(pin-all=false)  Before       After
  pin-all is false
  Downtime                      248.7 ms     191.1 ms        ~23.2% improve
  Final iterable bandwidth      5605.1 MiB/s 9826.0 MiB/s    ~75.3% improve

"Final iterable bandwidth" is the bandwidth measured during
qemu_savevm_state_complete_precopy_iterable().  Non-iterable data is
not transferred using RDMA Write.

Changes in v2 (Suggested by Peter):

  - Add a generic RAM round synchronization notifier.
  - Drain RDMA writes at the RAM scan-round boundary.
  - Remove the per-chunk wait and the unused transit bitmap.

Yanfei Xu (4):
  migration/ram: Add RAM round synchronization notifiers
  migration/rdma: Drain writes at RAM round boundaries
  migration/rdma: Allow multiple in-flight writes per chunk
  migration/rdma: Remove unused transit bitmap

 migration/multifd-nocomp.c | 24 ++++++++++
 migration/ram.c            | 45 +++++++++++++++---
 migration/ram.h            | 12 +++++
 migration/rdma.c           | 97 ++++++++++++++++++++------------------
 migration/trace-events     |  5 +-
 5 files changed, 128 insertions(+), 55 deletions(-)

-- 
2.20.1

