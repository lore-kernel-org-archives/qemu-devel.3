Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FB9C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96z9-0007Cq-LK; Tue, 22 Sep 2026 16:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96ye-0006Bt-QA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96yd-0008MM-AK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NubHi+pakNXPfkzbcYdUVILijVzX9mm7dOPZZmw6AIc=;
 b=JfWQNT1XKH5/+466f6OctKhEi5jOkGt/Iuje6Rabnj1kWhXT0sdpNyz90Bs728viqeqcJw
 IGYr5Ee2KqZ2OqDTnixxrXDj2yb8sBHdWUtU9QYkc8Fk9S/nfEMN9gPYaRqWo4BXBD9tXX
 fzC6Be+RUz/4quSfVGG5deP/Yb5Fj2g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-CvPMqxxKNLGlCnScHLNlKA-1; Tue,
 22 Sep 2026 16:20:29 -0400
X-MC-Unique: CvPMqxxKNLGlCnScHLNlKA-1
X-Mimecast-MFC-AGG-ID: CvPMqxxKNLGlCnScHLNlKA_1790108428
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D78D4185FD06; Tue, 22 Sep 2026 20:20:27 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E76D71956095; Tue, 22 Sep 2026 20:20:26 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:29 +0400
Subject: [PATCH 22/88] qemu-iotests/264: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-22-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iPKD5bVUcdc3VcVaoNHWqoMNvay9dIJd6LmpfXzUzEA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKv4u0jmPQzHGWmCboKbs2mWxS6gov1aPNrQ
 3rBW9ABoRSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLirwAKCRDa6OEJdZac
 5XRPD/9sKeHb8OVWq8d9kMP3agXN+Y2+4lLJkT4XAUapn1+Zror+VG73HnzNtVAGAKirM6vLVui
 eGUurPc0s9UEK0mmQMT5Jcw6jY1eBmlungNRCCUSLd+ct1xCDXSy8X6RGdOncXTbvh6Nte6dxqE
 hPoEZbFOBk2IIca+VgPpyCFMFyeX3YMOeSQrHovrtwuih0Jjj0DlpM6p4U6+QamWv0p9mX3dkAu
 ii1QUvDP/692cR+6Yx66LRvClYaNRq9hJcckGLEyDeUuNBgsYaTPV+goyAZA9qvJuItAlXE/kU+
 0dX7GTGdy5gljBlRbfLMPx3/wQy8GPjapDZ88rt6cx+Govcy5hmULZE3DAEk/NrkeUHegf/FnI0
 C57LnoAjroSDf4zD1fi0qjAnSr6ufE2sFgE4ctq4Z7Z9bK6hYMhdu2ccn8K8POensjYQ9b9+AO2
 nD5Aq6tPXgw6jYnr46C00eF6NZ2MnDJvR5r9Ys0TGB4sUS7hEGwXIEAF5wnjb4mEPoFLBQc88w9
 esIia561Wiwlc5IP/zsk8PyhGaiLhq97RDoHgbLEoLl3Z4RxScb0msjGZ8HlP8Xn6IOQBhlnPjW
 v5yXSl+ongmwzqg9lp2aOn8h7qarxihdW8VpGZuzbY0K1l3sPFDWQtUgBgm1wnuoU3oqrXCHy81
 fBDbM7XiadWje3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 tests/qemu-iotests/264 | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index b621f11ab427..4b1fb67e1b4b 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -38,7 +38,7 @@ class TestNbdReconnect(iotests.QMPTestCase):
         qemu_img_create('-f', iotests.imgfmt, disk_b, str(disk_size))
         self.vm = iotests.VM().add_drive(disk_a)
         self.vm.launch()
-        self.vm.hmp_qemu_io('drive0', 'write 0 {}'.format(disk_size))
+        self.vm.qmp_qemu_io('drive0', 'write 0 {}'.format(disk_size))
 
     def tearDown(self):
         self.vm.shutdown()
@@ -114,5 +114,4 @@ class TestNbdReconnect(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'],
-                 require_hmp=True)
+    iotests.main(supported_fmts=['qcow2'])

-- 
2.56.0.rc0.29.g47ce80527c56


