Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BB3C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 02:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxxmT-0004UG-Nj; Sat, 22 Aug 2026 22:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxxmQ-0004Tr-Vh
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 22:17:50 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxxmL-0005Dh-CM
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 22:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787451451; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=HTdT7EnXt/u749ArgIm3LgiRLepw2OmQavC1CxNB/78=;
 b=f3QPqj5dFHeLzuHgdl4/cf5iGMfnZOiQXKdb6sIqg6P1sI3lfAtZyprtZfp5UCXDsoM6ac
 DXnVJTLpqcpPEMfj2qQ1XAWPCinkVzJjA/7RCRR43kNL3oD3KkKhx7c7Z5kvFw1opTt55Z
 279DNVYZms+6z/7BVB+pGp4vRvEVLUp78K1IbTtJPuvGaj/qEez4Me/Ej2s7Y1MmCsZ/jC
 Ha5rbv/7Uol7ADRXIZX2YhpWuDpL/mU2tptWRSMBa663DOxZ6Z7eXSIxWjtTr3kjOXx7s9
 ysG29T5DPlvt1yiG3iuPjktvUkGG1iIr8ONVHg24rnryRnJMGUUTuYTDYbaxyg==
Subject: [PATCH v3 0/3] migration/rdma: Misc RDMA migration fixes
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26a8a5839+19f3cf+nongnu.org+yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Message-Id: <20260823021657.2824542-1-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: <qemu-devel@nongnu.org>
Date: Sun, 23 Aug 2026 10:16:54 +0800
Received-SPF: pass client-ip=209.127.230.111;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-111.ptr.blmpb.com
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

This series fixes three RDMA migration issues.

v2->v3:
  - patch3: Change the type of return value to bool. And add an assert
            check to unexpected WR type. (Peter)

v1->v2:
  - patch1/2: Collect Reviewed-by
  - patch2: Add reproducation step and error logs in commit message
  - patch3: Wrap the post-send op and retry logic into a helper, and
            retry only once after draining a completion when the queue
            is full. (I believe ENOMEM is only recoverable in the
            queue-full case, so we retry once; it should succeed after
            a completion is drained. Any further ENOMEM is treated as
            non-recoverable.)

Yanfei Xu (3):
  migration/rdma: Fix write-side shutdown
  migration/rdma: Post initial receive before accepting
  migration/rdma: Retry control sends on full queue

 migration/rdma.c       | 89 +++++++++++++++++++++++++-----------------
 migration/trace-events |  2 +-
 2 files changed, 55 insertions(+), 36 deletions(-)

-- 
2.20.1

