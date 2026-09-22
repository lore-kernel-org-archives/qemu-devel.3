Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88662C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970M-0001PC-VJ; Tue, 22 Sep 2026 16:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zZ-0008Sr-Ke
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zX-00007J-0J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABpGnhIDfNKzqYdINzfYJMCU6HBL2aMayBYhgJ4Ixu8=;
 b=gTIH58ksgiSb2BQfzigcotNUTidfAOQRFVbOcnguA9R3QHNzwNL07dMgYww6nNYKS8VsMV
 i3pV+jB2AkpH4fQPVcGNLz0e0Dfj+ZGDa6+E/jHsTFGIEqTyBbodwZDXWrVRCf5oAqFEe6
 hruU6snoJfzka+Zkwq6/7raUFIOj84o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-eUnoQOn4OUaNDgwvR-czqg-1; Tue,
 22 Sep 2026 16:21:22 -0400
X-MC-Unique: eUnoQOn4OUaNDgwvR-czqg-1
X-Mimecast-MFC-AGG-ID: eUnoQOn4OUaNDgwvR-czqg_1790108481
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C156A1955DDF; Tue, 22 Sep 2026 20:21:21 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB359418; Tue, 22 Sep 2026 20:21:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:44 +0400
Subject: [PATCH 37/88] qemu-iotests/280: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-37-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=nUnRmZ69+LiHtt2jIqUYo9fP0QqIV0Jh7e1i5aDHxfU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKwtKyuesQfD4TMOTvwqQgf3ZLMCjEah5Vf9
 Gpxj17y30uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisAAKCRDa6OEJdZac
 5eZvD/9xaMYthRqJg0/FaORMeXZWV5+HqzVi33GZwohlpzwTuUT4Z1Mo0Y7oehDkds+EgfpGqiO
 EM59h9y0+37IGivGEryom9twFVETtTvg2cMcSTyGS2JMdISEkKM55Le3iuqz57WCk3u4H80kBXX
 F+bnAv77CMFJWjLmsDKiJa/Pou2h5WD+VjVVCapnAlsqigZt6KVsGOyhOgC2d5C7UVKVZCXe/sN
 dc1TsUuVkY1MHofDEIFGniTbP1zI9dbwHTbPyAK6uznis2ZSTZ8Rb3LRRT+j5ZCnC92pK1skx9v
 cvWn4awxNBS3IEBZt6dehL2zk8aJZIBRGuxCIWBuwV2I4EvyyzRptl+Gyhpqynv/NM/i9rPrjWJ
 J7dgrj4WmxzSDCHnkC0cevRBBftvAHxaLJh0nswGuiSKRT+AebLsSft1UnTtkLSWikdkNyyia1z
 auAof/zD9glRrbSeZDaUTckQLZB5jrcdFbUF3VHkokxQ8DzJZ5ch2BFk8h7smdTu86mFjz1cq3y
 tK80HeNn43kP8Ns7LeqDOjT9ciAsXYY8at92M1P/TuVnGtWfwi4XZX2CLBsPWxPSHIp8tkFrDEt
 evJ8E0WtbTI22PPd+BUCYjEJBQrVMdGqnXNTXuQy4w35CinIBeKbiIxNwcJCflNJypzadMcvD9F
 Vu61/f54AHH+Z3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

For consistency with the rest of the test, we use use_log=True, although
it is not stricly necessary.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/280     | 3 +--
 tests/qemu-iotests/280.out | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/280 b/tests/qemu-iotests/280
index 8f4750de074b..ccd94905e045 100755
--- a/tests/qemu-iotests/280
+++ b/tests/qemu-iotests/280
@@ -27,7 +27,6 @@ iotests.script_initialize(
     supported_fmts=['qcow2'],
     supported_protocols=['file'],
     supported_platforms=['linux'],
-    require_hmp=True,
 )
 
 with iotests.FilePath('base') as base_path , \
@@ -77,7 +76,7 @@ with iotests.FilePath('base') as base_path , \
 
     iotests.log('\n=== Resume the VM and simulate a write request ===')
     vm.qmp_log('cont')
-    iotests.log(vm.hmp_qemu_io('-d vda/virtio-backend', 'write 4k 4k'))
+    vm.qmp_qemu_io('vda/virtio-backend', 'write 4k 4k', use_log=True, qdev=True)
 
     iotests.log('\n=== Commit it to the backing file ===')
     result = vm.qmp_log('block-commit', job_id='job0', auto_dismiss=False,
diff --git a/tests/qemu-iotests/280.out b/tests/qemu-iotests/280.out
index 37411144cafe..21eff12585c1 100644
--- a/tests/qemu-iotests/280.out
+++ b/tests/qemu-iotests/280.out
@@ -36,7 +36,8 @@ completed
 === Resume the VM and simulate a write request ===
 {"execute": "cont", "arguments": {}}
 {"return": {}}
-{"return": ""}
+{"execute": "x-qemu-io", "arguments": {"command": "write 4k 4k", "qdev": "vda/virtio-backend"}}
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 4096\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 === Commit it to the backing file ===
 {"execute": "block-commit", "arguments": {"auto-dismiss": false, "device": "top-fmt", "job-id": "job0", "top-node": "top-fmt"}}

-- 
2.56.0.rc0.29.g47ce80527c56


