Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1269D3B7E1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 13:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSa4g-00070z-Vs; Mon, 08 Dec 2025 07:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vSa4c-00070q-OW
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:10:39 -0500
Received: from sg-1-100.ptr.blmpb.com ([118.26.132.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xuchuangxclwt@bytedance.com>)
 id 1vSa4Y-0003Hh-Nc
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 07:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1765195816; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gZyI/XsjZiM5ib2NK+w8S+bx76otR7d/4oq7pAk6Pw8=;
 b=nyOvLkUvr66PZwTAE6XHcX5fOuwyzczOyKItaJ2qPUHgzpDJtdWN8TbKK5ElhgRXBt8Ed1
 FlY0D5qibWPO2KUN+jLYXBadLDe4u+GV5UciawcnfAHmoadgiFeznnfsQqblJIm8LSkqd7
 YQTCqPQrBZkpONdQwHURrs6FYd0Wy3FBweYtdjvvK/c5nrILgK1AGTTx19xgc1otlVNTCC
 b0JUZNGqv7HhWwRob6jSayNeqoH1wQb8sEESWeQmdqD6n0CZ2CEF0LUqy05I1B3swkgi69
 z1Kh4pST7frg1htbg07+lJPJM2hBCDIeHCVMj8DcPZTa2THGA4bHket0SmQ5Ig==
From: "Chuang Xu" <xuchuangxclwt@bytedance.com>
X-Original-From: Chuang Xu <xuchuangxclwt@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20251208120952.37563-1-xuchuangxclwt@bytedance.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: <mst@redhat.com>, <sgarzare@redhat.com>, <richard.henderson@linaro.org>, 
 <pbonzini@redhat.com>, <peterx@redhat.com>, <david@kernel.org>, 
 <philmd@linaro.org>, <farosas@suse.de>
Subject: [RFC v1 0/2] migration: reduce bitmap sync time and make dirty pages
 converge much more easily
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
To: <qemu-devel@nongnu.org>
Date: Mon,  8 Dec 2025 20:09:50 +0800
X-Lms-Return-Path: <lba+26936c026+f53b9c+nongnu.org+xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=118.26.132.100;
 envelope-from=xuchuangxclwt@bytedance.com; helo=sg-1-100.ptr.blmpb.com
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
the sync time is as high as 250ms, while after applying this patch, the sync time is only 10ms.

*First case, assume our maximum bandwidth can reach 15GBps and the dirty page rate is 7.5GBps.

If x = 250 ms, when there is a critical convergence state,
we use formula(2) get t = D * x / (B - D) = 250 ms,
because x + t = 500ms > 100ms,
so we get y > B * x / (B - D) = 500ms.

If x = 10 ms,
when there is a critical convergence state,
we use formula(2) get t = D * x / (B - D) = 10 ms,
because x + t = 20ms < 100ms,
so we get y > 100 * D * x / ((B - D) * (100 - x)) = 11.1ms.

We can see that after optimization, under the same bandwidth and dirty rate scenario,
the downtime limit required for dirty page convergence is significantly reduced.

*Second case, assume our maximum bandwidth can reach 15GBps and the downtime limit is set to 300ms.
If x = 250 ms,  x + t > 250ms > 100ms,
so we use formula(12) get D < B * (y - x) / y = 15 * (300 - 250) / 300 = 2.5GBps

If x = 10 ms,
when x + t > 100ms,
we use formula(12) get D < B * (y - x) / y = 15 * (300 - 10) / 300 = 14.5GBps,
when x + t < 100ms,
we use formula(19) get D < 14.46GBps

We can see that after optimization, under the same bandwidth and downtime limit scenario,
the convergent dirty page rate is significantly improved.

Through the above formula derivation, we have proven that reducing bitmap sync time
can significantly improve dirty page convergence capability.

This series only optimize bitmap sync time for some scenarios.
There may still be many scenarios where bitmap sync time negatively impacts dirty page
convergence capability, and we can also try to optimize using this approach.

