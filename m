Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0F1D5B16E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9Dt-00011Q-4s; Mon, 15 Dec 2025 09:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vV9Dn-0000yL-Gg
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:06:43 -0500
Received: from sg-1-103.ptr.blmpb.com ([118.26.132.103])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vV9Di-0000WR-9V
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765807581; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mdrZwmEps9khHPfnDavMxy8BuDg6qYxaetpSfRyhV/4=;
 b=IBXqNkm6Ur6s+00ul2+Wkvl2Nuq3eanP6yzgNprhPz2ZySNacIKXB8xkjJZM6vlxxmN+3Q
 vUxJyyz5D1eat0L+Soo3SUaQSd2Qm+2YeWuI+35C57HLdNDX1F3AMDJIpuqSOAnCBuBa5B
 RPCvUVm92HG5mMJziSmf/qVuedAoR6KCO/kJPnBfUq3YLmzKNhKSY0bQ8pDPAHidJDMw6L
 +U0biIMjf3pT9w7rPYR+t1dpumy6QqR5SDlwepoE76oPukuD/t0W7GXj7E+dnjua69gayr
 9rsTx4fF7SqkJ/cqV4MxZDrA42HenZtqstaXppKFjTMXRY0MVuc0aZjLGV0GKg==
X-Lms-Return-Path: <lba+2694015db+5e97ef+nongnu.org+xuchuangxclwt@bytedance.com>
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
Subject: [PATCH v2 0/1] migration: reduce bitmap sync time and make dirty
 pages converge much more easily
Date: Mon, 15 Dec 2025 22:06:10 +0800
Cc: <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@kernel.org>, 
 <philmd@linaro.org>, <farosas@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
Message-Id: <20251215140611.16180-1-xuchuangxclwt@bytedance.com>
To: <qemu-devel@nongnu.org>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.103;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-103.ptr.blmpb.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In this version:

- drop duplicate vhost_log_sync optimization
- refactor physical_memory_test_and_clear_dirty
- provide more detailed bitmap sync time for each part in this cover


In our long-term experience in Bytedance, we've found that under the same load,
live migration of larger VMs with more devices is often more difficult to
converge (requiring a larger downtime limit).

We've observed that the live migration bandwidth of large, multi-device VMs is
severely distorted, a phenomenon likely similar to the problem described in this link
(https://wiki.qemu.org/ToDo/LiveMigration#Optimize_migration_bandwidth_calculation).

Through some testing and calculations, we conclude that bitmap sync time affects
the calculation of live migration bandwidth.

Now, let me use formulaic reasoning to illustrate the relationship between the downtime
limit required to achieve the stop conditions and the bitmap sync time.

Assume the actual live migration bandwidth is B, the dirty page rate is D,
the bitmap sync time is x (ms), the transfer time per iteration is t (ms), and the
downtime limit is y (ms).

To simplify the calculation, we assume all of dirty pages are not zero page and only
consider the case B > D.

When x + t > 100ms, the bandwidth calculated by qemu is R = B * t / (x + t).
When x + t < 100ms, the bandwidth calculated by qemu is R = B * (100 - x) / 100.

If there is a critical convergence state, then we have:
  (1) B * t = D * (x + t)
  (2) t = D * x / (B - D)
For the stop condition to be successfully determined, then we have two cases:
  When:
  (3) x + t > 100
  (4) x + D * x / (B - D) > 100
  (5) x > 100 - 100 * D / B
  Then:
  (6) R * y > D * (x + t)
  (7) B * t * y / (x + t) > D * (x + t)
  (8) (B * (D * x / (B - D)) * y) / (x + D * x / (B - D)) > D * (x + D * x / (B - D))
  (9) D * y > D * (x + D * x / (B - D))
  (10) y > x + D * x / (B - D)
  (11) (B - D) * y > B * x
  (12) y > B * x / (B - D)

  When:
  (13) x + t < 100
  (14) x + D * x / (B - D) < 100
  (15) x < 100 - 100 * D / B
  Then:
  (16) R * y > D * (x + t)
  (17) B * (100 - x) * y / 100 > D * (x + t)
  (18) B * (100 - x) * y / 100 > D * (x + D * x / (B - D))
  (19) y > 100 * D * x / ((B - D) * (100 - x))

After deriving the formula, we can use some data for comparison.

For a 64C256G vm with 8 vhost-user-net(32 queue per nic) and 16 vhost-user-blk(4 queue per blk),
the sync time is as high as *73ms* (tested with 10GBps dirty rate, the sync time increases as the dirty page rate increases),
Here are each part of the sync time:

- sync from kvm to ram_list: 2.5ms
- vhost_log_sync:3ms
- sync aligned memory from ram_list to RAMBlock: 5ms
- sync misaligned memory from ram_list to RAMBlock: 61ms

After applying this patch, syncing misaligned memory from ram_list to RAMBlock takes only about 1ms,
and the total sync time is only *12ms*.

*First case, assume our maximum bandwidth can reach 15GBps and the dirty page rate is 10GBps.

If x = 73 ms, when there is a critical convergence state,
we use formula(2) get t = D * x / (B - D) = 146 ms,
because x + t = 219ms > 100ms,
so we get y > B * x / (B - D) = 219ms.

If x = 12 ms, when there is a critical convergence state,
we use formula(2) get t = D * x / (B - D) = 24 ms,
because x + t = 36ms < 100ms,
so we get y > 100 * D * x / ((B - D) * (100 - x)) = 27.2ms.

We can see that after optimization, under the same bandwidth and dirty rate scenario,
the downtime limit required for dirty page convergence is significantly reduced.

*Second case, assume our maximum bandwidth can reach 15GBps and the downtime limit is set to 150ms.
If x = 73 ms,
when x + t > 100ms,
we use formula(12) get D < B * (y - x) / y = 15 * (150 - 73) / 150 = 7.7GBps,
when x + t < 100ms,
we use formula(19) get D < 5.35GBps

If x = 12 ms,
when x + t > 100ms,
we use formula(12) get D < B * (y - x) / y = 15 * (150 - 12) / 150 = 13.8GBps,
when x + t < 100ms,
we use formula(19) get D < 13.75GBps

We can see that after optimization, under the same bandwidth and downtime limit scenario,
the convergent dirty page rate is significantly improved.

Through the above formula derivation, we have proven that reducing bitmap sync time
can significantly improve dirty page convergence capability. 

This patch only optimizes bitmap sync time for part of scenarios.
There may still be many scenarios where bitmap sync time negatively impacts dirty page
convergence capability, and we can also try to optimize using this approach.

