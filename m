Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E000C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFsl-0001Gk-Ou; Tue, 23 Apr 2024 09:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rz9Vx-0003Mq-Go
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 02:20:27 -0400
Received: from mail1.sfc.wide.ad.jp ([2001:200:0:8803:203:178:142:133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rz9Vp-0000pv-GE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 02:20:21 -0400
Received: from k8s-worker-01.tail4d807.ts.net (unknown
 [IPv6:2400:4051:3e03:2d00:1e98:ecff:fe05:4840])
 (Authenticated sender: mii)
 by mail1.sfc.wide.ad.jp (Postfix) with ESMTPSA id 593A373C;
 Tue, 23 Apr 2024 15:19:53 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sfc.wide.ad.jp;
 s=mail1; t=1713853193;
 bh=iLgfuzBLOT/ymiieytEdCw3BXsG+02NpZNhpnVVpgeQ=;
 h=From:To:Cc:Subject:Date:From;
 b=VL2553Ab8jR0VTL1icDMIdFCETfP/NNAfIy19KvMnnOIOIoj9PXstJ+V8w9itOTgt
 nkvDESoXRZpMoruoj7wt/USOR3vzeq/ci7LhjVsvVYwuSYk6njYwBts/rFIg6TIeNq
 tOigm5AYze9Mlx3EtN+bJoN+5nLFqUXVwSFVHeAeOvCiHTTBs2Bl3NEOXJgMQUWzC0
 tjW4s+ZzuvKkmxJVZ1KqAtnwyYV4AoTMhb3EgXfx22LztKAabfRJ8Brx4KzQuu+HVs
 Sl5VZOAwwTPq/fp6YWyLkbvrq4vNU2gXxV/YGcBIepWD7ZsX/a/1udOkwySbMliWqT
 m4YqiBLnL++dA==
From: Masato Imai <mii@sfc.wide.ad.jp>
To: qemu-devel@nongnu.org
Cc: Masato Imai <mii@sfc.wide.ad.jp>, Hyman Huang <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration/dirtyrate: Fix segmentation fault
Date: Tue, 23 Apr 2024 06:19:25 +0000
Message-Id: <20240423061925.254941-1-mii@sfc.wide.ad.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:200:0:8803:203:178:142:133;
 envelope-from=mii@sfc.wide.ad.jp; helo=mail1.sfc.wide.ad.jp
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Apr 2024 09:08:17 -0400
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

When the KVM acceleration parameter is not set, executing calc_dirty_rate
with the -r option results in a segmentation fault due to accessing a
null kvm_state pointer in the kvm_dirty_rate_enabled function.
This commit adds a check for kvm_enabled to prevent segmentation faults.

Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
---
 migration/dirtyrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746f..4c1579c6e9 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -800,6 +800,8 @@ void qmp_calc_dirty_rate(int64_t calc_time,
      * on the contrary, dirty bitmap mode is not.
      */
     if (((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
+        !kvm_enabled()) ||
+        ((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
         !kvm_dirty_ring_enabled()) ||
         ((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&
          kvm_dirty_ring_enabled())) {
-- 
2.34.1


