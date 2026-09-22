Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CFFC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zn-0000Si-7q; Tue, 22 Sep 2026 16:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96z8-00078M-Jy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96z6-0008UT-SJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWZxI8fbK11M+JjltBFpGEro0hKdHPYEyvSmjo3wgT8=;
 b=PjOFCB5YV6CORoacVemaeDoT1zls0MbWkmcwQJc7e3m9DPrerjnsEvJPXGZilRCFbWz7Bj
 xJjYgmaZ83OAu6b8IDKmtP2/5S/u/RLeMn4mj660och+sIwJTTl2gmUoe0K05hYIl1Ch/v
 NiayV1TbEMiVFnlLSmyC782kRblKkHE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-_vfzsKamOiCi8hsFUA9-Dw-1; Tue,
 22 Sep 2026 16:20:57 -0400
X-MC-Unique: _vfzsKamOiCi8hsFUA9-Dw-1
X-Mimecast-MFC-AGG-ID: _vfzsKamOiCi8hsFUA9-Dw_1790108456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 862271955D88; Tue, 22 Sep 2026 20:20:56 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91E7F1956086; Tue, 22 Sep 2026 20:20:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:37 +0400
Subject: [PATCH 30/88] qemu-iotests/148: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-30-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZYnyOlR6uu0xg5X8wWnKLYIbWiT1JT89Ji6/Ktix86Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwgZP3XBCUHSfaplGkbswY70HlqdTv1EhCq
 421GGzBsDWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5QZYD/40ZSZKGoBKrJRN7gzv97kuRTYEwTvArCMATZiGTOIi3F44qRqsiK08kA1IPj0p6PUfvSr
 o+5jLpoDXbyh2R6hjQKkmeZfsNnRvbqFTXXA1eXowy1XbAVAhNYNZ0tq6XrVt+pQ7OyuizcizbK
 aRcj+Z+PNHub7g5QASTt372PP13YlDOsHUjVuejsfTPYu+5ygeKmG20llb4wC4XlhaexAES/6kf
 1w0W7dUIFI5u1ZLH3i/gmxm7cqo9bHu5yT6yJwUIo2xWsxVy6yP6A92vnGqgvgTfjm05nFgRHzv
 lU8cbjUZhW2iGgINWfj6Jue4/0P/YnV3tQ4jZnLCm8dgA69Ky1GE+2HY5On+D1jZuQtAI13k61v
 gMkNyIkc/BrrmvMuup1rXC9k9HX/5A8sEoyTIzfW+TuQlyyFqzr6nlKwZkpI+kf+Ug1hoZ+AVdG
 auw4hkLwdMapHaENk0YFeSUT9Phzcdvb6G2lNHH9QPE36BzQL2uvqAiUouyb0CGnDphz+xO0eMU
 ywvzYZQgyyymzwhVujHM0422P/r73kjmlA4+8J/FxXibkarFPxzockLYFFUPuHvWcdz+WISPzWw
 obog0dkZUstfwuaHvW6YB/kDOpUE4vGVKVIQyoSXUkCAxAatEMiogmKmp+eia0FbMVZF8mgGQhn
 fry1JtX3WL8QvJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/148 | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index 4b092dccb7cc..0279386e3299 100755
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -82,7 +82,7 @@ sector = "%d"
 
     def testQuorum(self):
         # Generate an error and get an event
-        self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
+        self.vm.qmp_qemu_io("drive0", "aio_read %d %d" %
                             (offset * sector_size, sector_size))
         self.vm.qtest("clock_step 10")
         self.do_check_event('img0', offset)
@@ -90,7 +90,7 @@ sector = "%d"
         # I/O errors in the same child: only one event is emitted
         delay = 10
         for i in range(3):
-            self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
+            self.vm.qmp_qemu_io("drive0", "aio_read %d %d" %
                                 (offset * sector_size, sector_size))
             self.vm.qtest("clock_step %d" % delay)
             self.do_check_event(None)
@@ -102,7 +102,7 @@ sector = "%d"
         # I/O errors in the same child: all events are emitted
         delay = 2 * event_rate
         for i in range(3):
-            self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
+            self.vm.qmp_qemu_io("drive0", "aio_read %d %d" %
                                 (offset * sector_size, sector_size))
             self.vm.qtest("clock_step %d" % delay)
             self.do_check_event('img0', offset)
@@ -110,7 +110,7 @@ sector = "%d"
         # I/O errors in different children: all events are emitted
         delay = 10
         for i in range(len(imgs)):
-            self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
+            self.vm.qmp_qemu_io("drive0", "aio_read %d %d" %
                                 ((offset + i) * sector_size, sector_size))
             self.vm.qtest("clock_step %d" % delay)
             # In fifo mode only errors in the first child are detected
@@ -122,7 +122,7 @@ sector = "%d"
         # I/O errors in different children: all events are emitted
         delay = 2 * event_rate
         for i in range(len(imgs)):
-            self.vm.hmp_qemu_io("drive0", "aio_read %d %d" %
+            self.vm.qmp_qemu_io("drive0", "aio_read %d %d" %
                                 ((offset + i) * sector_size, sector_size))
             self.vm.qtest("clock_step %d" % delay)
             # In fifo mode only errors in the first child are detected
@@ -140,5 +140,4 @@ class TestFifoQuorumEvents(TestQuorumEvents):
 if __name__ == '__main__':
     iotests.verify_quorum()
     iotests.main(supported_fmts=["raw"],
-                 supported_protocols=["file"],
-                 require_hmp=True)
+                 supported_protocols=["file"])

-- 
2.56.0.rc0.29.g47ce80527c56


