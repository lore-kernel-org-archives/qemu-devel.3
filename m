Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E75C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdj-0005sB-Tz; Wed, 02 Sep 2026 04:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdg-0005oi-DK; Wed, 02 Sep 2026 04:48:12 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdc-0007Av-9c; Wed, 02 Sep 2026 04:48:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 42A4D80CB2;
 Wed, 02 Sep 2026 11:48:05 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-gAF91yBQ; Wed, 02 Sep 2026 11:48:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338884;
 bh=W2dWXaBudcA0BTbqpLGWO9Va0yvNHFfq/w1lvxGW0gY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vL5DZ/3Mef36ZyV8MNUjZC+5FBpWgl2D6IXHziAQl5NtM/0KD0Noqa5nTo7VTP+k3
 3bgKmdAGoYh1aT+H4qk8P9pxJpZrLlrftJzQPUo+BwMC+HBCkVhNdetz68H3L9RgbJ
 dqrZi2DXBsKoJPVHIMui++whqZzK6RooAmmI5Zxg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 7/8] iotests/nbd-commands: cover NBD_CMD_BLOCK_STATUS with a
 payload
Date: Wed,  2 Sep 2026 11:47:53 +0300
Message-ID: <20260902084754.140103-8-vsementsov@yandex-team.ru>
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

With extended headers a client may name the meta contexts it wants in
a request payload. Our own client never sends one, so the server side
of it, nbd_co_block_status_payload_read(), is not exercised anywhere.

Export two meta contexts and ask libnbd for each of them in turn,
which is only answerable through that path.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260827161002.310688-5-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 14 ++++++++++++--
 tests/qemu-iotests/tests/nbd-commands.out |  4 ++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index 3dfe9131900..09e811724b1 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -90,7 +90,7 @@ class TestNbdCommands(iotests.QMPTestCase):
             self.h.shutdown()
             self.h = None
 
-    def block_status(self, count=size):
+    def block_status(self, count=size, wanted=None):
         """Map each meta context in the reply to its list of extents."""
         reply = {}
 
@@ -98,7 +98,10 @@ class TestNbdCommands(iotests.QMPTestCase):
             reply.setdefault(meta, []).extend(zip(entries[0::2],
                                                   entries[1::2]))
 
-        self.h.block_status(count, 0, cb)
+        if wanted is None:
+            self.h.block_status(count, 0, cb)
+        else:
+            self.h.block_status_filter(count, 0, wanted, cb)
         return reply
 
     def top_extents(self):
@@ -148,6 +151,13 @@ class TestNbdCommands(iotests.QMPTestCase):
     def test_commands_extended_headers(self):
         self.check_commands(structured=True, extended=True)
 
+    def test_block_status_payload_filter(self):
+        self.assertEqual(sorted(self.block_status()),
+                         ['base:allocation', 'qemu:allocation-depth'])
+
+        for wanted in (['base:allocation'], ['qemu:allocation-depth']):
+            self.assertEqual(sorted(self.block_status(wanted=wanted)), wanted)
+
     def test_cache_past_end_of_export(self):
         self.assertRaises(nbd.Error, self.h.cache, size + 1, 0)
 
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 3f8a935a082..2f7d3902f23 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-......
+.......
 ----------------------------------------------------------------------
-Ran 6 tests
+Ran 7 tests
 
 OK
-- 
2.43.0


