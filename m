Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BF6EB48EE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 09:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqSh5-0002Yr-2b; Thu, 12 Feb 2026 04:09:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqSh3-0002Y8-B0; Thu, 12 Feb 2026 04:09:01 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vqSgu-000444-Pe; Thu, 12 Feb 2026 04:09:01 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4DEF3C01FF;
 Thu, 12 Feb 2026 12:08:48 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:450::1:4])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id j8QYBp0Al4Y0-nA2VSxdd; Thu, 12 Feb 2026 12:08:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770887327;
 bh=CYE2pEM95PycaKXMxxcqrt2w1cUELnQTQy2wRr10s0o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=rmjLZpuptespGK6slCoAoJEP5AQ8BYq/M7XdBogv+MijJQXqFRBVA+bpA4IUhTtDT
 9i7WT/rSZu7mvC5blVXFvSAbpm1oSqROJE3ZULKGEeoaBvlTJ8XkXFmTABhkVNhcDx
 tEoE6smr/oLancjgAC57JxQFwDqFlvT+wREMQDdM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, vsementsov@yandex-team.ru,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 2/2] iotests: test active mirror with unaligned,
 small write zeroes op
Date: Thu, 12 Feb 2026 12:08:01 +0300
Message-ID: <20260212090801.999731-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212090801.999731-1-vsementsov@yandex-team.ru>
References: <20260212090801.999731-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

This tests the scenario fixed by "block/mirror: check range
when setting zero bitmap for sync write" [0].

[0] https://lore.kernel.org/qemu-devel/20260112152544.261923-1-f.ebner@proxmox.com/

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260120113859.251743-1-f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/151     | 20 ++++++++++++++++++++
 tests/qemu-iotests/151.out |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 06ee3585db..9b9c815db5 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -191,6 +191,26 @@ class TestActiveMirror(iotests.QMPTestCase):
 
         self.potential_writes_in_flight = False
 
+    def testUnalignedSmallerThanGranularityWriteZeroes(self):
+        # Fill the source image
+        self.vm.hmp_qemu_io('source', 'write -P 1 0 %i' % self.image_len);
+
+        # Start the block job
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking')
+
+        # Wait for the READY event
+        self.wait_ready(drive='mirror')
+
+        for offset in range(6 * self.image_len // 8, 7 * self.image_len // 8, 1024 * 1024):
+            self.vm.hmp_qemu_io('source', 'aio_write -z %i 512' % (offset + 512))
+
+        self.complete_and_wait(drive='mirror', wait_ready=False)
 
 class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
     image_len = 128 * 1024 * 1024  # MB
diff --git a/tests/qemu-iotests/151.out b/tests/qemu-iotests/151.out
index 3f8a935a08..2f7d3902f2 100644
--- a/tests/qemu-iotests/151.out
+++ b/tests/qemu-iotests/151.out
@@ -1,5 +1,5 @@
-......
+.......
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 7 tests
 
 OK
-- 
2.52.0


