Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9346C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJ1o-0003H0-Hm; Thu, 20 Jun 2024 10:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sKJ1h-0003Fq-08; Thu, 20 Jun 2024 10:44:37 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sKJ1d-00018h-47; Thu, 20 Jun 2024 10:44:36 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:3196:0:640:fabe:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id A9A3760C80;
 Thu, 20 Jun 2024 17:44:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b486::1:24])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4iL0bh2RiW20-lwDtvWKm; Thu, 20 Jun 2024 17:44:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1718894668;
 bh=qVG+R5ghMvbwxPsLBIHAf5nWwrGXV+lpfL08/Nhe8DQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=YECVMTXtSeV5zZHOyaBSQ4dOOdUB4JJJhvFyYprUH/dB6/r5w5oHqObI1IMcA2zW/
 EC5PHiI++i9Qk54/UCE9yaPP+6K+fl4MZW57HA9o7QalQrx+z1LbwhAdAOil+VapK+
 N2iXPjIiBvaaGy/NwyPaDey2wVyUX3FD++rCj7jE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 1/2] iotests/backup-discard-source: convert size variable to
 be int
Date: Thu, 20 Jun 2024 17:44:01 +0300
Message-Id: <20240620144402.65896-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620144402.65896-1-vsementsov@yandex-team.ru>
References: <20240620144402.65896-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Make variable reusable in code for checks. Don't care to change "512 *
1024" invocations as they will be dropped in the next commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/backup-discard-source | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
index 2391b12acd..05fbe5d26b 100755
--- a/tests/qemu-iotests/tests/backup-discard-source
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -28,7 +28,7 @@ from iotests import qemu_img_create, qemu_img_map, qemu_io
 temp_img = os.path.join(iotests.test_dir, 'temp')
 source_img = os.path.join(iotests.test_dir, 'source')
 target_img = os.path.join(iotests.test_dir, 'target')
-size = '1M'
+size = 1024 * 1024
 
 
 def get_actual_size(vm, node_name):
@@ -39,9 +39,9 @@ def get_actual_size(vm, node_name):
 
 class TestBackup(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img_create('-f', iotests.imgfmt, source_img, size)
-        qemu_img_create('-f', iotests.imgfmt, temp_img, size)
-        qemu_img_create('-f', iotests.imgfmt, target_img, size)
+        qemu_img_create('-f', iotests.imgfmt, source_img, str(size))
+        qemu_img_create('-f', iotests.imgfmt, temp_img, str(size))
+        qemu_img_create('-f', iotests.imgfmt, target_img, str(size))
         qemu_io('-c', 'write 0 1M', source_img)
 
         self.vm = iotests.VM()
@@ -98,7 +98,7 @@ class TestBackup(iotests.QMPTestCase):
         mapping = qemu_img_map(temp_img)
         self.assertEqual(len(mapping), 1)
         self.assertEqual(mapping[0]['start'], 0)
-        self.assertEqual(mapping[0]['length'], 1024 * 1024)
+        self.assertEqual(mapping[0]['length'], size)
         self.assertEqual(mapping[0]['data'], False)
 
         os.remove(temp_img)
@@ -125,7 +125,7 @@ class TestBackup(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', '')
 
         # Check that data is written to temporary image
-        self.assertGreater(get_actual_size(self.vm, 'temp'), 1024 * 1024)
+        self.assertGreater(get_actual_size(self.vm, 'temp'), size)
 
         self.do_backup()
 
-- 
2.34.1


