Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D05C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdi-0005qo-Ef; Wed, 02 Sep 2026 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdg-0005oH-2m; Wed, 02 Sep 2026 04:48:12 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdc-0007As-78; Wed, 02 Sep 2026 04:48:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id A90C180CAD;
 Wed, 02 Sep 2026 11:48:04 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-ygl8N5rE; Wed, 02 Sep 2026 11:48:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338884;
 bh=vZa2zXqkRViDrN4KckmOg4GrtxY8Zuwqx3ByJlvFGdw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=b23lq1RBgkTUzlGt5HBUsmR3HvJWC0nhjVMxzaQbHQ5R5MIyJTlq2X8uNKrurhTZa
 WCa3U9nlLS1kL/4CLyKz5kIQrAEDSjM4JfH6mfRwUfvi6pOOo8/FEdE0xrmFYPcN8Y
 pDc7rqcJsnH3Q7wlJY6LVApHW6aCunr+PK/vbaco=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 6/8] iotests/nbd-commands: exercise the simple and structured
 reply modes
Date: Wed,  2 Sep 2026 11:47:52 +0300
Message-ID: <20260902084754.140103-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

From: "Denis V. Lunev" <den@openvz.org>

Every NBD request the iotests send arrives in NBD_MODE_EXTENDED, so
the server paths kept for older clients are never taken. Instrumenting
nbd_co_receive_request() over the whole auto group and every test that
touches NBD gives mode 4 for all of them, which leaves
nbd_co_send_simple_reply() and the compact header handling dead under
test. A regression there would only show against a third party client.

libnbd can negotiate down, so run the same command set three times,
once per mode, and assert the mode that was actually reached. Block
status is limited to the two modes that can negotiate a meta context.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260827161002.310688-4-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 29 +++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |  4 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index cbfc47782ff..3dfe9131900 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -119,6 +119,35 @@ class TestNbdCommands(iotests.QMPTestCase):
         self.assertEqual(self.top_extents(), [(0, size, 0)])
         qemu_io('-c', f'read -P {pattern} 0 {size}', top)
 
+    def check_commands(self, structured, extended):
+        self.connect(structured, extended)
+
+        self.assertEqual(self.h.pread(4096, 4096), bytes([pattern]) * 4096)
+
+        self.h.cache(size, 0)
+
+        self.h.pwrite(b'x' * 4096, 4096)
+        self.h.flush()
+        self.assertEqual(self.h.pread(4096, 4096), b'x' * 4096)
+
+        self.h.zero(4096, 8192)
+        self.assertEqual(self.h.pread(4096, 8192), bytes(4096))
+
+        self.h.trim(4096, 16384)
+
+        if structured:
+            self.assertEqual(self.block_status()['qemu:allocation-depth'],
+                             [(size, DEPTH_LOCAL)])
+
+    def test_commands_simple_replies(self):
+        self.check_commands(structured=False, extended=False)
+
+    def test_commands_structured_replies(self):
+        self.check_commands(structured=True, extended=False)
+
+    def test_commands_extended_headers(self):
+        self.check_commands(structured=True, extended=True)
+
     def test_cache_past_end_of_export(self):
         self.assertRaises(nbd.Error, self.h.cache, size + 1, 0)
 
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 8d7e9967009..3f8a935a082 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-...
+......
 ----------------------------------------------------------------------
-Ran 3 tests
+Ran 6 tests
 
 OK
-- 
2.43.0


