Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97303C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96yb-00065N-Fm; Tue, 22 Sep 2026 16:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yW-0005oR-Qz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yV-0008Dd-0A
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhQjHRO6qWZ1O1wPhHBtI+lXselfh75tPs9LCDZGga4=;
 b=GhWVvpP9gKRRF8RflOByPAAL4l0sawkuuQ0b8pKGsvLjpK96N+mJvhYRv1zOeoNx+gOhfj
 gehgyLRN7UKE/jXwICrKFFfM0X0UENQZeZbWtruXRDofsOcR7lERkFKTcH+Unn/B23XaCq
 YumnntNYToy5HbH3WUUe0JnzhhXvDk4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-6m61CBfeNCyK8PDdQD1yjw-1; Tue,
 22 Sep 2026 16:20:18 -0400
X-MC-Unique: 6m61CBfeNCyK8PDdQD1yjw-1
X-Mimecast-MFC-AGG-ID: 6m61CBfeNCyK8PDdQD1yjw_1790108417
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93FF81828AB1; Tue, 22 Sep 2026 20:20:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9184B1800446; Tue, 22 Sep 2026 20:20:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:26 +0400
Subject: [PATCH 19/88] qemu-iotests/132: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-19-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7eyieW/wITJ1M5v/DrsvYsKnJnzG3EuPfBVcjswiYjI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKv8AQBpJZ35TD9mUG/Oxlqz6rOBr22lln4P
 HOwa5NgaUWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5SZ+D/47uNSjqKGbsQcLwXG6wVr+OlNzGxkPqo0fNelc8KatQWlz65xtdYMn+n6o4dcgIqSlN0r
 qKEHtOsLvIXfx/nj9kaJPzURVvlLgxmokoaq8+eHrDrntcq8q71xzthyXOLF7A+EHn3l/qmdw6z
 FJk8OL67cBZN10cMZ3fCEPxM6fOhtb+Op2eL7+cn5YASCos5uKxPWn1zoY1nPa5T/yB5mlfScGB
 Urv3AOW1tz8vQ5VGRndCPiMyjirEjhcarXaEKJVO6JSyMKIJGa2iBRoszZdX9wAMXgs9CxSXghc
 2MW7lXAW5UbwFrP4va/NdwgZozpnk2FUFQqLQKhOU/g4/cBgmlNrFxbgNRh7KHhKr7NGWlDkrsA
 9+Ha4RHyr7XX3UvuUo6DvUsQF+mafPTd9BQDbUlT15FKDAjqvq8mTb0j9WUmRVDJ7G5gNoZ1PkZ
 bqLzNSTTw8MyYJMBUUqb7f+4UGLjP59IwyFhSNHfVB0mm+0hfVn+7U+DywkuDBTaCOhxHi04qgn
 DYPNiNDtprLeoPA7/O9fRLcUiKRk5TvpMSsdGpMbQ493JFoIj6l5u9PEI4GOhZNul1ZIvHABIKG
 L/w20XJJHoMlRhY8sNhtP+8dBofwG0RocBEB877Pb7Bma4DG9Cm453F8KOEqIUd/aNiGrLpUd8V
 g4jXAt4z+UM9t5g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
 tests/qemu-iotests/132 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index 3756573a57c0..579f6a3bdd09 100755
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -49,7 +49,7 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_mirror_discard(self):
         self.vm.cmd('drive-mirror', device='drive0', sync='full',
                     target=target_img)
-        self.vm.hmp_qemu_io('drive0', 'discard 0 64k')
+        self.vm.qmp_qemu_io('drive0', 'discard 0 64k')
         self.complete_and_wait('drive0')
         self.vm.shutdown()
         self.assertTrue(iotests.compare_images(test_img, target_img),
@@ -57,5 +57,4 @@ class TestSingleDrive(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


