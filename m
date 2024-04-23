Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62253C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzFsm-0001IL-CN; Tue, 23 Apr 2024 09:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rzCDl-00035h-Rc
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:13:49 -0400
Received: from mail1.sfc.wide.ad.jp ([203.178.142.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mii@sfc.wide.ad.jp>)
 id 1rzCDj-0005zv-6R
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 05:13:49 -0400
Received: from k8s-worker-01.tail4d807.ts.net (unknown
 [IPv6:2400:4051:3e03:2d00:1e98:ecff:fe05:4840])
 (Authenticated sender: mii)
 by mail1.sfc.wide.ad.jp (Postfix) with ESMTPSA id 0C56F73C;
 Tue, 23 Apr 2024 18:13:43 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sfc.wide.ad.jp;
 s=mail1; t=1713863623;
 bh=d5MXOmg56bRqxOY0Neg0l85+8q0471wDoEYPcVDKOY8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sDgFjWFh/0P9e0EpZlbYWGWrXhHIGM+q8vVWiHsvwDaQEEI3rRxdTADN/JPQ2YnGg
 WsT5PhGBePbDRUApzruKO6FVv5Utvohtzriju/vx23GzprA/nRzOBc/pdDDTmbZvaO
 ivkCqLDyptIohslrF3j+kgGzk8Dk9ehJd0KQ3wW1UCP0ieCMmE/MYWF1tJA/K/tyJ+
 I0QDX4IzOdFmrSCa39RWtM+/Wzqflt3HgN90SQYQsgCr1dGubSoiav6TWV9A6hWZ8R
 hEC2GkERNwayBEysaUkThKiW7WtHKNqhqgykD44Kd7UW1FWm0CjA6ifOiCMy3UL0Pf
 J1/4MSixVr7nA==
From: Masato Imai <mii@sfc.wide.ad.jp>
To: qemu-devel@nongnu.org
Cc: Masato Imai <mii@sfc.wide.ad.jp>, Hyman Huang <yong.huang@smartx.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
Date: Tue, 23 Apr 2024 09:13:08 +0000
Message-Id: <20240423091306.754432-2-mii@sfc.wide.ad.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
References: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.178.142.133; envelope-from=mii@sfc.wide.ad.jp;
 helo=mail1.sfc.wide.ad.jp
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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
with the -r or -b option results in a segmentation fault due to accessing
a null kvm_state pointer in the kvm_dirty_ring_enabled function.
This commit adds a check for kvm_enabled to prevent segmentation faults.

Signed-off-by: Masato Imai <mii@sfc.wide.ad.jp>
---
 migration/dirtyrate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 1d2e85746f..2a7df52519 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -799,6 +799,13 @@ void qmp_calc_dirty_rate(int64_t calc_time,
      * dirty ring mode only works when kvm dirty ring is enabled.
      * on the contrary, dirty bitmap mode is not.
      */
+    if (!kvm_enabled() &&
+        (mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING ||
+         mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP)) {
+        error_setg(errp, "mode %s requires kvm to be enabled.",
+                         DirtyRateMeasureMode_str(mode));
+        return;
+    }
     if (((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_RING) &&
         !kvm_dirty_ring_enabled()) ||
         ((mode == DIRTY_RATE_MEASURE_MODE_DIRTY_BITMAP) &&
-- 
2.34.1


