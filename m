Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56484C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9715-00033e-1i; Tue, 22 Sep 2026 16:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9702-0000kl-VX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9701-0000Cy-Di
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQa6XhXtb1+ZMGZ4MhGugj32QXAj+5WVMmQLmGE8YHc=;
 b=DV6smoooD/7vzxe+fZiob3Q7mBbwno52+prTPcI5GT73Op6JxKykIOrTehqAbVwgGddnMq
 tOZKxuJ+BwjIHCMgz9pCucCSfty36j87FOMeaUWgd/oZkM4xCMDoA08Ur/tPXbLwkdd7eK
 yRtnYlcLw8iddz8ZRgfjc087A1Ttw+c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-vut-i7QeO0SYW_36wUy2gA-1; Tue,
 22 Sep 2026 16:21:55 -0400
X-MC-Unique: vut-i7QeO0SYW_36wUy2gA-1
X-Mimecast-MFC-AGG-ID: vut-i7QeO0SYW_36wUy2gA_1790108514
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38C7A18052FB; Tue, 22 Sep 2026 20:21:54 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 48A4F1956086; Tue, 22 Sep 2026 20:21:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:53 +0400
Subject: [PATCH 46/88] qemu-iotests/045: remove HMP monitor dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-46-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vYFoYJohKePFv62rocApwamuDP/2pLkNn5nYJ8SnQeI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxz5e8cfmwRs1YIaCLbDq70I59THWuICB08
 FQ3UtzTZSuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5TJAD/44F7NAMZpDlc8Ub1iPSYeJM/4T/3lY3Bo9LPonMHtto3irpMDabA+uJ/NpQ5I6eYHvN7W
 DjC6XmVDuUhS62tDUz/inkdI4PSp6vz7ex4qf4CRji28iDzot8SxDurBM25I8smMWavnH71T/OE
 aDmWG8DegV1OkLRX5aOIuBQGq+NUEPPRc0kYhJ+XKOx51/3DYvJJF+o+uAhj9aJkjwUx/CA+VqD
 Itllk18GrKxWI/fxICFosZP3WRFSw//WnavpIjtFk198tij1BugKrwVtxBEnbbObMYGFoMY/q1d
 ApfUEkfMug7tcamKIkf0RLuualhXmlSSsYWU7DFjmFHtU2dVpn5Qt4T7mjhU7+12gWqqoOnABBd
 V16+8KLceOlxSkCUcXJCmTFNKXblIo5Vi0cgLmhhMbS8QjyUqulvHqH1R/l10jYcK3fTGOkVVQV
 5ALMxPS1Hl/Fbq3IO+l35OEqVOrnNtEorPCZVmp0JM/5+QccBaB45EFfvyXAg2jb5XtBBBfJLaD
 oUcmx1UMF9rsScZX8K7wsa5ScARM9T6zQnTBJrsZAE8i9cU2izCDruT+a21r69F+ZbvRHegzDMC
 DFiVbP1h6ZfVLe1rVwwqrLWLx/DexT9vr4+/QN2i8Whs/sfHpo4q4/+Yd1l3Nz4Gb+JakDkea1+
 h2iyrp2LI8hmX9g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Test 045 (TestSCMFd) is adding a null HMP monitor via
add_monitor_null() to exercise fd operations with two monitors
present. With HMP disabled, -monitor null is no longer valid.

Remove the add_monitor_null() call and the now-unused method
from the Python machine module.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 python/qemu/machine/machine.py | 7 -------
 tests/qemu-iotests/045         | 6 +-----
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 393750655589..71b4696227f6 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -202,13 +202,6 @@ def __exit__(self,
                  exc_tb: Optional[TracebackType]) -> None:
         self.shutdown()
 
-    def add_monitor_null(self) -> None:
-        """
-        This can be used to add an unused monitor instance.
-        """
-        self._args.append('-monitor')
-        self._args.append('null')
-
     def add_fd(self: _T, fd: int, fdset: int,
                opaque: str, opts: str = '') -> _T:
         """
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index cd1b35edb17f..900bf85220f7 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -129,9 +129,6 @@ class TestSCMFd(iotests.QMPTestCase):
     def setUp(self):
         self.vm = iotests.VM()
         qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
-        # Add an unused monitor, to verify it works fine when two monitor
-        # instances present
-        self.vm.add_monitor_null()
         self.vm.launch()
 
     def tearDown(self):
@@ -172,5 +169,4 @@ class TestSCMFd(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


