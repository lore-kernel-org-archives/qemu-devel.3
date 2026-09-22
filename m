Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE799C98309
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970Q-0001lc-Cu; Tue, 22 Sep 2026 16:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zj-0000Gi-8m
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zh-00008v-Oa
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4qblk7JBMw4nsyFWPNZsBsjuJnK7G0DNZ04KPgRIT1g=;
 b=EX1RA+9KbkaqLvu82q/ZiJkOY4/rDk8Lz/vRB8wZj6dSySB/ixd6au65Mukon6E8/MBatC
 NMIo9rhVFxcULFtZrDJC24pjvAMEovsdXO2UGyvB8qtwsgJu/ASoMoDoBEW5MetadUvNan
 D/l7u6Auw+lExOkJ/zJhKQSR+AKu/6Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-ZvKGnNMiOqavCZ60id-Ssw-1; Tue,
 22 Sep 2026 16:21:33 -0400
X-MC-Unique: ZvKGnNMiOqavCZ60id-Ssw-1
X-Mimecast-MFC-AGG-ID: ZvKGnNMiOqavCZ60id-Ssw_1790108492
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83FAC1956069; Tue, 22 Sep 2026 20:21:32 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A9913000223; Tue, 22 Sep 2026 20:21:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:47 +0400
Subject: [PATCH 40/88] qemu-iotests/mirror-change-copy-mode: migrate away
 from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-40-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2696;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MI58I8YC289QjxqhVLUxIVtkbJ0Lcb8tu722GBguSwI=;
 b=owEBbAKT/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxlK6M05fkcT4Vo+ejnwVS4OTpgXPzBMb1x
 CiHRbYIIKGJAjIEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5TcAD/dKGEJTjwG2l3GiGCv1GKsyjnBPJkZC0ia18KRU27zL02MfZWsmqOctaVgCFFhEa2e6fj6
 PxJ9XH9b+9XhTuVIqsYh+CEyXo/OBdGjZANc79w/REoymBMOgQr7ryrgKhs+a4fFz/ft5Kp1tmr
 yx08rFPuPTxZnfkcL1eWwYGGN6Qk+PcAPHLFh22nlYhayQU9T7Q6kNjVbKSUJtq7fHqskFHDOAq
 EES6l57u1//gBMVK28q9b+miBrHvqz1hEd+ZXTXokB/aDjGyUXIUAs9iMd2QMEKok8fsJG4I5X6
 oaZhRUiD5uUOF1xcs729M8u+UDVQLnE+/dg/ibZXsmjTCEbC10pKpdiHgzmgX1O9dqhuv+6oqB4
 bqa+FZ9BM15lz3WsmxqbrsDdpQxZGyCWhPyyGwncFJ441GbmG6XLoucOV6GmTANLIMcR8z5ln2+
 jGF13PetoHtp72xQkcAy4DwiApXshEYdl5trqhKod6uIhSXV+whkYnVRSnxE6daAuJZk7PoQNLq
 mGuumuaBeB8CGCV7zr4MS8GVhI1GL7VNbgyB6KmLiK0vzelgiJ+2KmCYSGSc/J/ZTx+ETVeyIIH
 tmltaWJLN5F29bFZhNBhL1MOm60J+BBG1oYNchZsZlEyJ+rhv0o9vqTE0x3lfmdCI2lbG7MNqtc
 qp1S9IOr6UOV0
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/mirror-change-copy-mode | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/tests/mirror-change-copy-mode b/tests/qemu-iotests/tests/mirror-change-copy-mode
index c9c345f1397c..79a6a7396450 100755
--- a/tests/qemu-iotests/tests/mirror-change-copy-mode
+++ b/tests/qemu-iotests/tests/mirror-change-copy-mode
@@ -119,8 +119,8 @@ class TestMirrorChangeCopyMode(iotests.QMPTestCase):
                     copy_mode='background')
 
     def test_background_to_active(self):
-        self.vm.hmp_qemu_io('source', f'write 0 {image_size}')
-        self.vm.hmp_qemu_io('target', f'write 0 {image_size}')
+        self.vm.qmp_qemu_io('source', f'write 0 {image_size}')
+        self.vm.qmp_qemu_io('target', f'write 0 {image_size}')
 
         self.start_mirror()
 
@@ -137,7 +137,7 @@ class TestMirrorChangeCopyMode(iotests.QMPTestCase):
         req_size = image_size // reqs
         for i in range(0, reqs):
             req = f'aio_write -P 7 {req_size * i} {req_size}'
-            self.vm.hmp_qemu_io('source', req)
+            self.vm.qmp_qemu_io('source', req)
 
         # Wait for the first few requests.
         time.sleep(1)
@@ -174,15 +174,15 @@ class TestMirrorChangeCopyMode(iotests.QMPTestCase):
         req_size = image_size // 2 // reqs
         for i in range(0, reqs):
             req = f'aio_write -P 19 {req_size * i} {req_size}'
-            self.vm.hmp_qemu_io('source', req)
+            self.vm.qmp_qemu_io('source', req)
 
         # Now issue a synchronous write in the second half of the image and
         # immediately verify that it was written to the target too. This would
         # fail without switching the copy mode. Note that this only produces a
         # log line and the actual checking happens during tearDown().
         req_args = f'-P 37 {3 * (image_size // 4)} {req_size}'
-        self.vm.hmp_qemu_io('source', f'write {req_args}')
-        self.vm.hmp_qemu_io('target', f'read {req_args}')
+        self.vm.qmp_qemu_io('source', f'write {req_args}')
+        self.vm.qmp_qemu_io('target', f'read {req_args}')
 
         self.vm.cmd('block-job-cancel', device='mirror')
         while len(self.vm.cmd('query-block-jobs')) > 0:
@@ -190,5 +190,4 @@ class TestMirrorChangeCopyMode(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'raw'],
-                 supported_protocols=['file'],
-                 require_hmp=True)
+                 supported_protocols=['file'])

-- 
2.56.0.rc0.29.g47ce80527c56


