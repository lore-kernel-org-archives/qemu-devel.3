Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ED4C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPQp-0001AD-9I; Fri, 21 Aug 2026 09:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPQl-00019U-Go
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:12 -0400
Received: from va-1-111.ptr.blmpb.com ([209.127.230.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1wxPQi-0000gd-PZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787319415; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/cDqVTRpFX48Slo90cTsppM42k33S9eJUTS1YM8cbK0=;
 b=Vxqm5L5WWtg6pEwTVX+wtSTFJdbSC62KdqwpvMkU5ryVtCDhmQJuBhU5zAQgzLedIEAa3n
 TQL5l1RuQ/ITYMrrwfjlg15fazyQLoMfuAQzAIwh4wpOGGWyCwhfbRhLNCFvN1VPIIrT2I
 QFXKJwJrgiTfDMm4QYkPAye70UJs/sjGvhkPPc+b7XpIe9hNRtedCgf3jUPwCADmQAdy9x
 VrQl7kf42tUy2iR2aqQ2c/xOSbsnKBd0ooeAW63CO2QCBmLman3i3/ikc+yT4wo6UggAvv
 HT2yHCpCxjctLH6qGFxsUzBHDCmsFo5mml9AltOg8/1qDsl/hvEszezvjxjJVA==
To: <qemu-devel@nongnu.org>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a885475+13a27a+nongnu.org+yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Subject: [PATCH v2 0/3] migration/rdma: Misc RDMA migration fixes
Date: Fri, 21 Aug 2026 21:35:56 +0800
Message-Id: <20260821133559.3815727-1-yanfei.xu@bytedance.com>
Mime-Version: 1.0
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
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

 migration/rdma.c       | 92 ++++++++++++++++++++++++++----------------
 migration/trace-events |  2 +-
 2 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.20.1

