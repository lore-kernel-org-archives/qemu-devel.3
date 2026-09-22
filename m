Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692F1C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970Q-0001li-C8; Tue, 22 Sep 2026 16:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9701-0000kT-Im
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zx-0000CO-Mc
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dlfm1Ii5r1HQH8gstT18nSCgINLXBXF6zaLLHJdleD0=;
 b=BZaOv1lILvi1+NujObJ9ov1DXUJMQYHtFMhLpOkdgOk9+KMa3w0Ys3n6z6IrZyfh0LrRiJ
 h6mBxjRGw0KiykqBxn55glQkte58e+UoqOUf0EUzbnNJyfbVoImHxgpVWtiAs0XsKTZpAQ
 glovOKFjbBcGxYWG2YBO7dHyXhmtTxY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-09t5XYLmPqKc5eD_NrduOg-1; Tue,
 22 Sep 2026 16:21:48 -0400
X-MC-Unique: 09t5XYLmPqKc5eD_NrduOg-1
X-Mimecast-MFC-AGG-ID: 09t5XYLmPqKc5eD_NrduOg_1790108507
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38BDF195609D; Tue, 22 Sep 2026 20:21:47 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 37CE1300106D; Tue, 22 Sep 2026 20:21:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:51 +0400
Subject: [PATCH 44/88] qemu-iotests/165: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-44-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AQS7vsAJ7TUlM8UXHoSCARVjIDS9/6IH7oxVsB2PKKY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxSjCMLODihdsZ+qU1zBq5QMIJLMZb1zDxG
 sZ49bVROxaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5WQuD/9btQdwN0FFpAAqgOWyDGSIzvMC+rgQhduPZJrn5S2wiDShFChAkiiLqFvjNLhjndqXYkw
 ZXtBr+70SHMamGlhvIe9p86ixbQZhpMsEqF1Y9RFIOKBJ17IzyFYJ46hBcR466LHBGmL7JNpnhJ
 pNWvBscr0r+S3NI4Vc2MW7bIWuYYfmyIV4OVD+EjB4JyjRS1qOLwLaR7puRNjKLm5tmIxqQ7o8i
 E17/WjEKG+pLdGj7EDwduaYXzvrMu/BW8u9U5Ltc6Ph7n1NQKjXOLkKazr6p+98lP2fKF4dR0zH
 /rVVSDDuCtyg/sXWSa9k+Zq7CJBPeemJZdfy/pDC0we1DtdTD50vEQXjNO+A4g/4l3LFpUQcZip
 Sjc1PH0knVzPe3xqivUWjG1xZTIyUBO+a0uyJ/RX5pck4maRX2g5pzmC80oys5uysppBCx9V4Gk
 btHZUOan/RP62TO0aVtTTVl33cW1WXuw+MUAtZ8nUQoU38cSRs1XA3Oj5GvTh3W/t/VGyTZhCjo
 ZBYYAydYbB8Xy69/LDmkHSLzPSlDlUjedq1van4hvpQVSlXLKyKFjNiGWTxv5IIfz0/U5DDdIdC
 5S6fj2oqLrhKN95BM2Ydnmk2S/0VhY4/Gy5MAh2pCYO3yGusNkucCOAgPniP24dOZbiuN5HSsgs
 l7ZyYqmmAzXkkGQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

For the read-only write test, call qmp() directly and assert
the expected GenericError, since qmp_qemu_io() assumes success.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/165 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index 13b784fcc64d..e1e557424cec 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -66,7 +66,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 
     def writeRegions(self, regions):
         for r in regions:
-            self.vm.hmp_qemu_io('drive0',
+            self.vm.qmp_qemu_io('drive0',
                                 'write %d %d' % r)
 
     def qmpAddBitmap(self):
@@ -138,7 +138,10 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         assert sha256_1 == self.getSha256()
 
         # Check that we are in RO mode and can't modify bitmap.
-        self.writeRegions(regions2)
+        for r in regions2:
+            result = self.vm.qmp('x-qemu-io', device='drive0',
+                                 command='write %d %d' % r)
+            self.assert_qmp(result, 'error/class', 'GenericError')
         assert sha256_1 == self.getSha256()
 
         # Reopen to RW
@@ -162,5 +165,4 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'parallels'],
                  supported_protocols=['file'],
-                 unsupported_imgopts=['compat'],
-                 require_hmp=True)
+                 unsupported_imgopts=['compat'])

-- 
2.56.0.rc0.29.g47ce80527c56


