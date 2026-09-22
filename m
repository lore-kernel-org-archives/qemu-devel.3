Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0818BC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970T-000248-Bj; Tue, 22 Sep 2026 16:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zn-0000V2-9D
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zl-0000Aq-LQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mamSw4xslryVG87aKbgwluYltQ8ZgmHZJA6qPnUeK5k=;
 b=IfH10vrYroiGLa29ul+nJ54n2dlyqR5xRuJm+03USxxLErJRWR2frjGuXW1h/7e5Oqzu3v
 XrmOv6PNMR6jmZ9Qbb+PmPLeiFbq1TTX8CO/iIKh4tVfm/WWI/u5s0Z7V7Zj36F283fZEz
 liyOQf0iws7iIy2D+XteZELsWoz7Qhk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610--6i9s0gHMgihQWH9-_tMIg-1; Tue,
 22 Sep 2026 16:21:37 -0400
X-MC-Unique: -6i9s0gHMgihQWH9-_tMIg-1
X-Mimecast-MFC-AGG-ID: -6i9s0gHMgihQWH9-_tMIg_1790108496
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B95DA19352F1; Tue, 22 Sep 2026 20:21:36 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99BDD180056E; Tue, 22 Sep 2026 20:21:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:48 +0400
Subject: [PATCH 41/88] qemu-iotests/migrate-bitmaps-test: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-41-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nAgdlKU5ANKjTdVkSB54qAiNNbbto0h3s+g1JsdYYNw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKxVno/0vxwm2JR3MrF2s5DmefBK/lpZhhV5
 1ubkcSvsHSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisQAKCRDa6OEJdZac
 5eSND/91psQdzLRp6fpsVivIPVtijTHXiFcb/oBTJW99kT8itGX/K9ZJ85HY1JklDXQWpAZX90c
 JuvyoUfZ4pyKWcjEx1rxNIhYXxfYbHyR+yvzBg5bG0G+L2nndDj2UzHjPiLt7VVf+3e4qQ4rsad
 XJn4AlnA2GpIev1XNNx1ewYFCyPv8+U7TlKPAuRaMrxv3IAvvIw2nIib7NQUWMGHBTpth9thot3
 7bsg4PdO1A9znf6WYJ6Lh4iZhDJJdWg3SCt0rD6ThsIZlHqJk2sVj2UxpAKnByXMwl2fH85i0Jw
 nfoNAtirnmCZSNsC6Upsrajk9oPEf60P2ei+Yz6wNDBUrJqWx8jz065MZkhNFfNfSGezqN4NhQY
 Qi2q/R+vp18RfC44d8KuWR6cawco250JfgnnZwZWVsbwplhlPa4u2O2sXOiSI5mT+8Lzb/VkHR+
 JHyhEHpa/bu6UjpDBrqOGrtoOG1qzbHYWKilc7JCeh/fudNJTh2XD20WPKsZUhpAyh3IIIpiYrr
 bsXIgJq/Csjwi6KVngMM+ZCO5FbbGXsIa1IoOcf6jV1CnPrJYkPxJ2Bqh8JU6wpvhFtY63bck4A
 2LKZBcV/BMcf2joXV17Z5D7ZeBJrDTorfdH41HB94LtffuxknT5JX7f5TcX1+z8CWzETmETATsR
 EAtQ4dJHrDwxBPg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
 tests/qemu-iotests/tests/migrate-bitmaps-test | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index 25439c9eb773..f386e960afa8 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -95,7 +95,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
         self.add_bitmap(self.vm_a, granularity, persistent)
         for r in regions:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
+            self.vm_a.qmp_qemu_io('drive0', 'write %d %d' % r)
         sha256 = get_bitmap_hash(self.vm_a)
 
         self.vm_a.cmd('migrate', uri=mig_cmd)
@@ -159,7 +159,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
         self.add_bitmap(self.vm_a, granularity, persistent)
         for r in regions:
-            self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
+            self.vm_a.qmp_qemu_io('drive0', 'write %d %d' % r)
         sha256 = get_bitmap_hash(self.vm_a)
 
         if pre_shutdown:
@@ -215,7 +215,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.vm_b.add_drive(disk_b, 'read-only=on')
 
         self.add_bitmap(self.vm_a, granularity, True)
-        self.vm_a.hmp_qemu_io('drive0', 'write 0 4096')
+        self.vm_a.qmp_qemu_io('drive0', 'write 0 4096')
 
         self.vm_a.cmd('migrate-set-capabilities', capabilities=mig_caps)
         self.vm_a.cmd('migrate', uri=mig_cmd)
@@ -330,7 +330,6 @@ def main() -> None:
         supported_fmts=['qcow2'],
         supported_protocols=['file'],
         unsupported_imgopts=['compat'],
-        require_hmp=True,
     )
 
 

-- 
2.56.0.rc0.29.g47ce80527c56


