Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278DCC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96zj-0000Dc-AQ; Tue, 22 Sep 2026 16:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96z0-0006Vo-Aj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yy-0008Su-4i
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3xA0xoRq/MNApbxkwdGRgWCI3LD7zjCYZy/JqN8jy0=;
 b=bsL0o2M11Ec1XSCEuMZM57d50M5mvlU8eg12/lmoHrvHVwwIfjepWTw2tT1tg9mrE9cwEN
 /svY/fhFIkzWqBDrHFrpepb2k/U6G9RMvP3iyPEiit+KhhYLGU6hZ2pDBzDaQunSUEXlUq
 raEqwT4BlKKbBarMa7+q6vwsNkNeAAE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-0ynaajIRNhC8tPTxD0gsiA-1; Tue,
 22 Sep 2026 16:20:47 -0400
X-MC-Unique: 0ynaajIRNhC8tPTxD0gsiA-1
X-Mimecast-MFC-AGG-ID: 0ynaajIRNhC8tPTxD0gsiA_1790108446
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E3A4180A971; Tue, 22 Sep 2026 20:20:46 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94251180034C; Tue, 22 Sep 2026 20:20:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:34 +0400
Subject: [PATCH 27/88] qemu-iotests/093: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-27-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pCUKjqFpdxBVRp0DH1LmzQbC+ZZ/IH+lQmvSpCGndKI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwmvRoHFjNB45gzqOHNCxKyyp15nSQ6jFci
 3Ll+RtVumaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5TrtD/9Sg0XpE/peJYq1QCSvexBIyKzxlssrWsMH2SiT7SzsNTyqYyepFvwiY4FQIbOUksXnAFi
 WmiQnPgYMf3Z5+v5BbVjNvowlKhZ89qdCqOSTORTBtBubzxgKOGNZAN9Mie7mi0TxcBzbZ+Wr/W
 BrFf790gzcNQknL/1a+onh0pxdaW7L2Q29TPIzRjuz5rPT36K61ZA1ybNBCmBcTiVYbwCIlMt8u
 bdJPWFl1/Z3WORZ5GfG2CBx90Ke567eMjp6tE7IqcDpZm2/d/LFzrmyUFG5DYC+aGbPY58ydo5O
 xNaMaz9Jzp2s4l5/JgovikdcabsiwgZHskKRvQ8Wlepu6hZDfGWQeaWor7+rYRz5FNWPLG1/7UW
 Pic/MYwR9u82jEQcZnumopAOf2i7JV33GuhaXXA+pvjwu5sCvHhrXrOTItfOsD7+to5SAaE563Q
 51bcwg0oe+W0kfcZ8YpCPxWpDUkJgZjha+iqXvuDxbGvNaDrj9l+EUfDW1Cw1W2bSbTQ72OUi/a
 PS/vmIX6MnLN5MXcCTyYV/6QkVhmDnVnhaCyLtaT9DurJuWn4Fc31RgYtNGlSVUt0umDW1fS8OJ
 A8yqbD/OSlizpTZVAeqF9/mXpqOhFftlqAoc9LqcUr0LpTLI7Qv3Lq0pBBvSXWaUgy9xsOeGam2
 O1xra79XoWhJX9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/qemu-iotests/093 | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 26ae6e2b2d56..5a22f672d8c2 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -90,13 +90,13 @@ class ThrottleTestCase(iotests.QMPTestCase):
         for i in range(rd_nr):
             for drive in range(0, ndrives):
                 idx = first_drive + drive
-                self.vm.hmp_qemu_io("drive%d" % idx, "aio_read %d %d" %
+                self.vm.qmp_qemu_io("drive%d" % idx, "aio_read %d %d" %
                                     (i * rq_size, rq_size))
 
         for i in range(wr_nr):
             for drive in range(0, ndrives):
                 idx = first_drive + drive
-                self.vm.hmp_qemu_io("drive%d" % idx, "aio_write %d %d" %
+                self.vm.qmp_qemu_io("drive%d" % idx, "aio_write %d %d" %
                                     (i * rq_size, rq_size))
 
         # We'll store the I/O stats for each drive in these arrays
@@ -227,21 +227,21 @@ class ThrottleTestCase(iotests.QMPTestCase):
         self.configure_throttle(2, params)
 
         # Read 4KB from drive0. This is performed immediately.
-        self.vm.hmp_qemu_io("drive0", "aio_read 0 4096")
+        self.vm.qmp_qemu_io("drive0", "aio_read 0 4096")
 
         # Read 2KB. The I/O limit has been exceeded so this
         # request is throttled and a timer is set to wake it up.
-        self.vm.hmp_qemu_io("drive0", "aio_read 0 2048")
+        self.vm.qmp_qemu_io("drive0", "aio_read 0 2048")
 
         # Read 2KB again. We're still over the I/O limit so this is
         # request is also throttled, but no new timer is set since
         # there's already one.
-        self.vm.hmp_qemu_io("drive0", "aio_read 0 2048")
+        self.vm.qmp_qemu_io("drive0", "aio_read 0 2048")
 
         # Read from drive1. This request is also throttled, and no
         # timer is set in drive1 because there's already one in
         # drive0.
-        self.vm.hmp_qemu_io("drive1", "aio_read 0 4096")
+        self.vm.qmp_qemu_io("drive1", "aio_read 0 4096")
 
         # At this point only the first 4KB have been read from drive0.
         # The other requests are throttled.
@@ -419,5 +419,4 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
 if __name__ == '__main__':
     if 'null-co' not in iotests.supported_formats():
         iotests.notrun('null-co driver support missing')
-    iotests.main(supported_fmts=["raw"],
-                 require_hmp=True)
+    iotests.main(supported_fmts=["raw"])

-- 
2.56.0.rc0.29.g47ce80527c56


