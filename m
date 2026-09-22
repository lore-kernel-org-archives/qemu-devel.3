Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CA3C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970P-0001dm-Az; Tue, 22 Sep 2026 16:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zc-0008Vl-75
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96za-00007v-Au
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LdyaC8s5gFy9tJwN9G7tD+ROBpHwjrC1/cCo+mIKUWg=;
 b=eVOnZhmSjNH8THkIHiVlq9WNYpb/xoIQfRk2IB1yZRXtSUARzh7f7Gm8Ucwk196F50tYde
 kRKGIhhotbtfgCwdAJz3WjMgmla58LuyEU7pSy4px2HHHr/FHLtCwZpK7qn3AcHdCoBJe0
 c4ro3d5QU0MD73PCVhcpAzz2uqZwtzs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-9o43IuLJO3y79R8X3pbTiw-1; Tue,
 22 Sep 2026 16:21:26 -0400
X-MC-Unique: 9o43IuLJO3y79R8X3pbTiw-1
X-Mimecast-MFC-AGG-ID: 9o43IuLJO3y79R8X3pbTiw_1790108485
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 361321855882; Tue, 22 Sep 2026 20:21:25 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34110300106D; Tue, 22 Sep 2026 20:21:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:45 +0400
Subject: [PATCH 38/88] qemu-iotests/backup-discard-source: migrate away
 from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-38-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2294;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XO32CZqVvuhFJJUFHhtvp2qCCH+LyQpThQt01K+i+rI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKw0WKuTXFPu4etsxk+IZ4Zad8QbNHVnz6ao
 snq+YJM/niJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5bXOD/4o6vWhaluegacNe88ax0WVbD3Ii76ND0hd7MtSd0l0FCTJ6z5wkih07B+Q0SM1Jx2kTsw
 iV+5DaNiIoqK8UncvUG7Dq0Kt5MUum8+HZX5WSiDTtHThqlUKCe8+s4bhk+Y+Hg3CijeXuu6Rpn
 xKdkYh+0Y2Lqt/4OcWEqoI6fjcbgyXukFpHHx+H+zfA4wBnuzC5jcvIItjnWa3L1kMJGUcRhq9s
 ZDIQY/2Uf7xWzoKG7RUp4trRQOtPeXZffg+/3PD0g3x+/Q4GwlTlqUUx4PL9ECMcZy0KAhWLxnb
 n7bJSVLXG4SlbLQIPNoy5rPvR5UnuB7UU9NliO7G1ijqOgimo58tqBdPrVfQBfuP/B3vMfrLz/N
 EtAQP5OmOGjRKkCjBiTG6ZK2As8RPlkCavjN82Msd3Nd/pYioZd1ChDoTUfmSc7pBiJIkXz2E5c
 WClPNAipA4tyY8auNCgMkQANaXPvmnJHS1gPObcFMRr/OJPCe5VL2tNzYkVPzn1CfZ+p6ALqddz
 TwEkPiFDUWJ/bcfge2fZTg/sF/fS9ACq2i8gjb/Nc10Gm/V+GHmCczJtRXURmJ6zs/VKqhllfPO
 6fELTCADoE/dkCNiOmK6O3h9/levr9oBNcohcURFnwR9P/8IUX7z6HmxUfErDm/yu7azNLUyUYK
 WjOWpcU3wiVfH4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/qemu-iotests/tests/backup-discard-source | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
index 80ea32c46e3f..3ccd616d197e 100755
--- a/tests/qemu-iotests/tests/backup-discard-source
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -87,11 +87,13 @@ class TestBackup(iotests.QMPTestCase):
 
     def tearDown(self):
         # That should fail, because region is discarded
-        result = self.vm.hmp_qemu_io('access', 'read 0 1M')
+        result = self.vm.qmp('x-qemu-io', device='access',
+                             command='read 0 1M')
 
         self.vm.shutdown()
 
-        self.assertIn('read failed: Permission denied', result['return'])
+        self.assertIn('read failed: Permission denied',
+                      result['error']['desc'])
 
         # Final check that temp image is empty
         mapping = qemu_img_map(temp_img)
@@ -127,8 +129,7 @@ class TestBackup(iotests.QMPTestCase):
            removed from temp
         """
         # Trigger copy-before-write operation
-        result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
-        self.assert_qmp(result, 'return', '')
+        self.vm.qmp_qemu_io('cbw', 'write 0 1M')
 
         # Check that data is written to temporary image
         self.assertEqual(self.get_bitmap_count(), size)
@@ -150,8 +151,7 @@ class TestBackup(iotests.QMPTestCase):
         self.vm.cmd('block-dirty-bitmap-clear', self.bitmap)
 
         # Try trigger copy-before-write operation
-        result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
-        self.assert_qmp(result, 'return', '')
+        self.vm.qmp_qemu_io('cbw', 'write 0 1M')
 
         # Check that data is not written to temporary image, as region
         # is discarded from copy-before-write process
@@ -160,5 +160,4 @@ class TestBackup(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


