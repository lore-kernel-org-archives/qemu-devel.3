Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2AEC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZ5-0000KK-NX; Tue, 25 Aug 2026 15:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZ3-0008SD-6y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYy-0004JR-HP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sm50nC9j9AKkXq46KV+FOJM33zpmzdHl2b/Q1NzN08=;
 b=an5/NJ4PIYlK/VVeyGYA8wB0bJXzyITgEHaNktAprsB5x4YtPcWcmY1YOBIdy5h64sYX6s
 6BHROZadsXP/cDvSJt3YAGiE2936vb9aqQTuw1pGSQ9h6BaEddAmEbqxEwtIs2YL0Yqvcy
 wVESK0SmfufPsTSRo/QaaMQP8Q85iWg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-4EJ-RhX-PsewWzyUBvvcQQ-1; Tue,
 25 Aug 2026 15:11:49 -0400
X-MC-Unique: 4EJ-RhX-PsewWzyUBvvcQQ-1
X-Mimecast-MFC-AGG-ID: 4EJ-RhX-PsewWzyUBvvcQQ_1787685107
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 987111954B3E; Tue, 25 Aug 2026 19:11:47 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 490A9434; Tue, 25 Aug 2026 19:11:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:35 +0400
Subject: [PATCH v4 28/49] tests: skip HMP-dependent tests when HMP is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-28-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Hyman Huang <infra.ai.cloud@bitdeer.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=41066;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pFWGNiIId3GKva578rPE7YzSY5rMwiLn5o+Ug7lD8qo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHjD1wa8Ops90DsxRD2hafVNTLd2DsKRHIv
 k6CR5vGoD6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5dPuD/9lgMTwxdD/I/GjKYVBINVgNaZumCXs8ywVCl5Hads85r7HKRUe3uIILSOrbAYt4QUrzFZ
 8UVw15Ejt7jWVnblKTC2GlCzUbgxNDq3S99XO74o/9MlnPhR3kne3Z7njYbmDPDwMgz/lEL14nU
 jrvGK0nBqBWQ/OqKYEE2L1ewWfY5UE5nqnzaD+7fquz3DR4PJhwYKVlAyLsVxbgfcxfrPO6Q9b6
 KkVQ3IuVJiBgXI1zndyYRci8OAGxT0NdHC4ZxjPCOdqsSCdcOXn3ploeu0DMQBtG8Q30FT4IWGD
 zsiE2HAwBLldTGEiEg956Rn5ic1ZEkHgjB/FmyurC+YPq9hwjV6voRaj/kO6m591tx37f87ghZu
 gQk2+aeK5Kh3fc7cCcoNlgWCwlHkQcupqFzDkP0Cp6zH6Lv41oMQM9RAsFq6QkE0lboPItz6B5N
 aUQK3xhFnmdg/NjBfj7zsIQTA3lMgE5uwUNFNqI0bT/cYHFnM6Mk0m5wsxuJdjXVeUTdhD3Y2yH
 oiziuuuj0SEfQzUvFrFE5Ugm3i3M7oxjzX4Jl2fE6clh7UvgqNZflhbauckcq02hqwy4SD32H2E
 hEK60/fxC9ozK3YFSJ7sxixRqTm7MXxHLB2krGlJLD5BZtsOE852d6HJXNht2oaNgZ3q+ffg7Hj
 m6B0GyPa4JbeWPQ==
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

Add runtime detection of HMP availability so tests gracefully skip
instead of failing when QEMU is built without HMP support.

For qtests (drive_del-test), use compile-time #ifndef CONFIG_HMP guards.

For bash iotests, add _require_hmp() to common.rc that probes QEMU.

For Python iotests, add _verify_hmp() and a require_hmp parameter
threaded through execute_setup_common()/main()/script_initialize()/
script_main().

An earlier version of this series did an almost-complete conversion of
the tests to QMP. However, this made the series even longer. I decided
to post-pone it for now.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/028                             |  1 +
 tests/qemu-iotests/045                             |  3 ++-
 tests/qemu-iotests/051                             |  1 +
 tests/qemu-iotests/056                             |  3 ++-
 tests/qemu-iotests/060                             |  1 +
 tests/qemu-iotests/068                             |  1 +
 tests/qemu-iotests/071                             |  1 +
 tests/qemu-iotests/081                             |  1 +
 tests/qemu-iotests/091                             |  1 +
 tests/qemu-iotests/093                             |  3 ++-
 tests/qemu-iotests/102                             |  1 +
 tests/qemu-iotests/117                             |  1 +
 tests/qemu-iotests/119                             |  1 +
 tests/qemu-iotests/120                             |  1 +
 tests/qemu-iotests/124                             |  3 ++-
 tests/qemu-iotests/130                             |  1 +
 tests/qemu-iotests/132                             |  3 ++-
 tests/qemu-iotests/136                             |  3 ++-
 tests/qemu-iotests/142                             |  1 +
 tests/qemu-iotests/145                             |  1 +
 tests/qemu-iotests/146                             |  1 +
 tests/qemu-iotests/148                             |  3 ++-
 tests/qemu-iotests/151                             |  3 ++-
 tests/qemu-iotests/152                             |  3 ++-
 tests/qemu-iotests/153                             |  1 +
 tests/qemu-iotests/156                             |  1 +
 tests/qemu-iotests/157                             |  1 +
 tests/qemu-iotests/161                             |  1 +
 tests/qemu-iotests/165                             |  3 ++-
 tests/qemu-iotests/172                             |  1 +
 tests/qemu-iotests/181                             |  1 +
 tests/qemu-iotests/185                             |  1 +
 tests/qemu-iotests/186                             |  1 +
 tests/qemu-iotests/192                             |  1 +
 tests/qemu-iotests/201                             |  1 +
 tests/qemu-iotests/216                             |  3 ++-
 tests/qemu-iotests/225                             |  1 +
 tests/qemu-iotests/232                             |  1 +
 tests/qemu-iotests/236                             |  3 ++-
 tests/qemu-iotests/245                             |  3 ++-
 tests/qemu-iotests/246                             |  3 ++-
 tests/qemu-iotests/249                             |  1 +
 tests/qemu-iotests/254                             |  3 ++-
 tests/qemu-iotests/255                             |  3 ++-
 tests/qemu-iotests/257                             |  3 ++-
 tests/qemu-iotests/260                             |  3 ++-
 tests/qemu-iotests/264                             |  3 ++-
 tests/qemu-iotests/267                             |  1 +
 tests/qemu-iotests/274                             |  3 ++-
 tests/qemu-iotests/280                             |  1 +
 tests/qemu-iotests/281                             |  3 ++-
 tests/qemu-iotests/283                             |  1 +
 tests/qemu-iotests/286                             |  1 +
 tests/qemu-iotests/298                             |  3 ++-
 tests/qemu-iotests/300                             |  3 ++-
 tests/qemu-iotests/304                             |  3 ++-
 tests/qemu-iotests/310                             |  3 ++-
 tests/qemu-iotests/common.rc                       |  8 +++++++
 tests/qemu-iotests/iotests.py                      | 14 +++++++++++-
 tests/qemu-iotests/tests/backup-discard-source     |  3 ++-
 tests/qemu-iotests/tests/copy-before-write         |  3 ++-
 tests/qemu-iotests/tests/image-fleecing            |  3 ++-
 tests/qemu-iotests/tests/iothreads-create          |  3 ++-
 tests/qemu-iotests/tests/luks-detached-header      |  3 ++-
 .../tests/migrate-bitmaps-postcopy-test            |  3 ++-
 tests/qemu-iotests/tests/migrate-bitmaps-test      |  3 ++-
 tests/qemu-iotests/tests/mirror-change-copy-mode   |  3 ++-
 tests/qemu-iotests/tests/mirror-ready-cancel-error |  3 ++-
 tests/qemu-iotests/tests/qcow2-internal-snapshots  |  1 +
 tests/qemu-iotests/tests/qsd-migrate               |  3 ++-
 tests/qemu-iotests/tests/reopen-file               |  3 ++-
 tests/qemu-iotests/tests/write-zeroes-unmap        |  1 +
 tests/qtest/drive_del-test.c                       | 25 ++++++++++++++++++++++
 73 files changed, 152 insertions(+), 37 deletions(-)

diff --git a/tests/qemu-iotests/028 b/tests/qemu-iotests/028
index 2b232c461405..28f01439c525 100755
--- a/tests/qemu-iotests/028
+++ b/tests/qemu-iotests/028
@@ -49,6 +49,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file fuse
 _supported_os Linux
+_require_hmp
 
 # Choose a size that is not necessarily a cluster size multiple for image
 # formats that use clusters.  This will ensure that the base image doesn't end
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index a341f21cd70f..cd1b35edb17f 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -172,4 +172,5 @@ class TestSCMFd(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index 4c079b11e320..a722c0c1bc8f 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -45,6 +45,7 @@ _supported_proto file
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file \
     compression_type
 _require_drivers nbd
+_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" = "pc" ]; then
     _require_devices lsi53c895a
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index 808ea6b48abe..7cc97486951c 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -332,4 +332,5 @@ class BackupTest(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 5cd21a6f686f..8d06f84df16b 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -56,6 +56,7 @@ _unsupported_imgopts 'compat=0.10' data_file \
 
 # The repair process will create a large file - so check for availability first
 _require_large_file 64G
+_require_hmp
 
 rt_offset=65536  # 0x10000 (XXX: just an assumption)
 rb_offset=131072 # 0x20000 (XXX: just an assumption)
diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 7ecd2474093e..11b660a8b7c4 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
@@ -43,6 +43,7 @@ _supported_proto generic
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]' data_file
+_require_hmp
 
 IMG_SIZE=128K
 
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 331f8cfddcf9..83c4ce6314c5 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -43,6 +43,7 @@ _require_drivers blkdebug blkverify
 # blkdebug can only inject errors on bs->file, not on the data_file,
 # so this test does not work with external data files
 _unsupported_imgopts data_file
+_require_hmp
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index 1ac66f197e46..d9e729f674c6 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -44,6 +44,7 @@ _supported_proto file
 _supported_os Linux
 _require_drivers quorum
 _require_devices virtio-scsi
+_require_hmp
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
index e396748a9179..626203d6fc93 100755
--- a/tests/qemu-iotests/091
+++ b/tests/qemu-iotests/091
@@ -48,6 +48,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _supported_os Linux
 _supported_cache_modes writethrough none writeback
+_require_hmp
 _default_cache_mode none writeback
 
 size=1G
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 4f9e224e8a8c..26ae6e2b2d56 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -419,4 +419,5 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
 if __name__ == '__main__':
     if 'null-co' not in iotests.supported_formats():
         iotests.notrun('null-co driver support missing')
-    iotests.main(supported_fmts=["raw"])
+    iotests.main(supported_fmts=["raw"],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/102 b/tests/qemu-iotests/102
index 141bfe1e9023..5db8180d3bb7 100755
--- a/tests/qemu-iotests/102
+++ b/tests/qemu-iotests/102
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file fuse
+_require_hmp
 
 IMG_SIZE=64K
 
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6081473584fe..5cc9433f4a67 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto file fuse
+_require_hmp
 
 _make_test_img 64k
 
diff --git a/tests/qemu-iotests/119 b/tests/qemu-iotests/119
index 6cac8793bac6..ce1b62521f59 100755
--- a/tests/qemu-iotests/119
+++ b/tests/qemu-iotests/119
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto nbd
 _supported_os Linux
+_require_hmp
 
 _make_test_img 64M
 # This should not crash
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index ac7bd8c4e3cd..e4ed87e1a705 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -42,6 +42,7 @@ _supported_fmt generic
 _supported_proto file fuse
 _unsupported_fmt luks
 _require_drivers raw
+_require_hmp
 
 _make_test_img 64M
 
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index b2f4328e3456..ab9ea4d8b59d 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -750,4 +750,5 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index 7af85d20a892..3d10aba2594e 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -46,6 +46,7 @@ _supported_proto file
 _supported_os Linux
 # We are going to use lazy-refcounts
 _unsupported_imgopts 'compat=0.10'
+_require_hmp
 
 qemu_comm_method="monitor"
 
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index 12a64b3d95a3..3756573a57c0 100755
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -57,4 +57,5 @@ class TestSingleDrive(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/136 b/tests/qemu-iotests/136
index 58df876bafca..72fd638aa04d 100755
--- a/tests/qemu-iotests/136
+++ b/tests/qemu-iotests/136
@@ -410,4 +410,5 @@ class BlockDeviceStatsTestCoroutine(BlockDeviceStatsTestCase):
 if __name__ == '__main__':
     if 'null-co' not in iotests.supported_formats():
         iotests.notrun('null-co driver support missing')
-    iotests.main(supported_fmts=["raw"])
+    iotests.main(supported_fmts=["raw"],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/142 b/tests/qemu-iotests/142
index 86d65a2d1a1e..8538a727ac08 100755
--- a/tests/qemu-iotests/142
+++ b/tests/qemu-iotests/142
@@ -43,6 +43,7 @@ _supported_proto file
 # We test all cache modes anyway, but O_DIRECT needs to be supported
 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_hmp
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/145 b/tests/qemu-iotests/145
index a2ce92516dc5..f61a50f63951 100755
--- a/tests/qemu-iotests/145
+++ b/tests/qemu-iotests/145
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto generic
+_require_hmp
 
 _make_test_img 1M
 
diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index 661a9d2625cc..f63291d0ffba 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt vpc
 _supported_proto file
 _supported_os Linux
+_require_hmp
 
 
 qemu_comm_method="monitor"
diff --git a/tests/qemu-iotests/148 b/tests/qemu-iotests/148
index 7ccbde4633c2..4b092dccb7cc 100755
--- a/tests/qemu-iotests/148
+++ b/tests/qemu-iotests/148
@@ -140,4 +140,5 @@ class TestFifoQuorumEvents(TestQuorumEvents):
 if __name__ == '__main__':
     iotests.verify_quorum()
     iotests.main(supported_fmts=["raw"],
-                 supported_protocols=["file"])
+                 supported_protocols=["file"],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 647194094a4c..204221a5738e 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -434,4 +434,5 @@ class TestHighThrottledWithNbdExport(TestThrottledWithNbdExportBase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'raw'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index 197bea9e7785..d9170359213a 100755
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -61,4 +61,5 @@ class TestUnaligned(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['raw', 'qcow2'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index 1e02f6a6e344..def01d6f3ea4 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -59,6 +59,7 @@ _check_ofd || _notrun "OFD lock not available"
 
 _supported_fmt qcow2
 _supported_proto file
+_require_hmp
 
 _run_cmd()
 {
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 97c2d86ce573..a0e4d1ffd42a 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -53,6 +53,7 @@ _supported_fmt qcow2 qed
 _supported_proto file
 # Copying files around with cp does not work with external data files
 _unsupported_imgopts data_file
+_require_hmp
 
 # Create source disk
 TEST_IMG="$TEST_IMG.backing" _make_test_img 1M
diff --git a/tests/qemu-iotests/157 b/tests/qemu-iotests/157
index aa2ebbfb4b43..531dbd3122b1 100755
--- a/tests/qemu-iotests/157
+++ b/tests/qemu-iotests/157
@@ -41,6 +41,7 @@ _supported_fmt generic
 _supported_proto file
 
 _require_devices virtio-blk
+_require_hmp
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f25effab9360..8ca139262975 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -45,6 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file fuse
 _supported_os Linux
+_require_hmp
 
 IMG_SIZE=1M
 
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index b3b1709d71fa..8fc79daae16d 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -154,4 +154,5 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'],
-                 unsupported_imgopts=['compat'])
+                 unsupported_imgopts=['compat'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
index 4da0e0f2e297..a78e42ff0adf 100755
--- a/tests/qemu-iotests/172
+++ b/tests/qemu-iotests/172
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index b904e8ce0124..458cb737f1cb 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -47,6 +47,7 @@ _supported_fmt generic
 _unsupported_fmt qcow vdi vhdx vmdk vpc vvfat parallels
 _supported_proto generic
 _supported_os Linux
+_require_hmp
 
 _flaky_test https://gitlab.com/qemu-project/qemu/-/work_items/3515
 
diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index a62ae8d3293e..bb577a9cc999 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -50,6 +50,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2
 _supported_proto file
 _supported_os Linux
+_require_hmp
 _flaky_test https://gitlab.com/qemu-project/qemu/-/issues/3270
 
 size=$((64 * 1048576))
diff --git a/tests/qemu-iotests/186 b/tests/qemu-iotests/186
index eaf13c7a3340..9a4215d28e92 100755
--- a/tests/qemu-iotests/186
+++ b/tests/qemu-iotests/186
@@ -41,6 +41,7 @@ _supported_fmt qcow2
 _supported_proto file fuse
 _require_drivers null-co
 _require_devices virtio-scsi-pci
+_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index e66e1a4f06af..6869bd171537 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt generic
 _supported_proto file
+_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" != "pc" ]; then
     _notrun "Requires a PC machine"
diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index 1b8eb51d8f38..a5c750c38a83 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -47,6 +47,7 @@ _supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
+_require_hmp
 
 size=64M
 _make_test_img $size
diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 311e02af3a7b..4eabada9b35d 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -25,7 +25,8 @@ from iotests import log, qemu_img, qemu_io
 
 # Need backing file support
 iotests.script_initialize(supported_fmts=['qcow2', 'qcow', 'qed', 'vmdk'],
-                          supported_platforms=['linux'])
+                          supported_platforms=['linux'],
+                          require_hmp=True)
 
 log('')
 log('=== Copy-on-read across nodes ===')
diff --git a/tests/qemu-iotests/225 b/tests/qemu-iotests/225
index b5949fcb58e0..8128d583d609 100755
--- a/tests/qemu-iotests/225
+++ b/tests/qemu-iotests/225
@@ -46,6 +46,7 @@ _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
                      "subformat=twoGbMaxExtentSparse"
+_require_hmp
 
 TEST_IMG="$TEST_IMG.base" _make_test_img 1M
 TEST_IMG="$TEST_IMG.not_base" _make_test_img 1M
diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
index b30faaa21806..1ee0aae481d4 100755
--- a/tests/qemu-iotests/232
+++ b/tests/qemu-iotests/232
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
+_require_hmp
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 20419bbb9e54..3cf0de4043f6 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -23,7 +23,8 @@
 import iotests
 from iotests import log
 
-iotests.script_initialize(supported_fmts=['generic'])
+iotests.script_initialize(supported_fmts=['generic'],
+                          require_hmp=True)
 size = 64 * 1024 * 1024
 granularity = 64 * 1024
 
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 03550b99715c..2f354d1d9205 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1160,4 +1160,5 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 if __name__ == '__main__':
     iotests.activate_logging()
     iotests.main(supported_fmts=["qcow2"],
-                 supported_protocols=["file"])
+                 supported_protocols=["file"],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index b009a7839775..cee5131c3ce4 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -24,7 +24,8 @@ import iotests
 from iotests import log
 
 iotests.script_initialize(supported_fmts=['qcow2'],
-                          unsupported_imgopts=['compat'])
+                          unsupported_imgopts=['compat'],
+                          require_hmp=True)
 size = 64 * 1024 * 1024 * 1024
 gran_small = 32 * 1024
 gran_large = 128 * 1024
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 28bffd4d5712..1254bf942913 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -45,6 +45,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file fuse
 _supported_os Linux
+_require_hmp
 
 IMG_SIZE=1M
 
diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index 7ea098818cf0..d3d18a1bbf1f 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -23,7 +23,8 @@ import iotests
 from iotests import qemu_img_create, file_path, log
 
 iotests.script_initialize(supported_fmts=['qcow2'],
-                          unsupported_imgopts=['compat'])
+                          unsupported_imgopts=['compat'],
+                          require_hmp=True)
 
 disk, top = file_path('disk', 'top')
 size = 1024 * 1024
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 88b29d64b44e..8f88522f1e91 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -24,7 +24,8 @@
 import iotests
 from iotests import imgfmt
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          require_hmp=True)
 
 iotests.log('Finishing a commit job with background reads')
 iotests.log('============================================')
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index cd0468aaa162..5e4dba02e769 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -533,4 +533,5 @@ def main():
 
 if __name__ == '__main__':
     iotests.script_main(main, supported_fmts=['qcow2'],
-                        supported_protocols=['file'])
+                        supported_protocols=['file'],
+                        require_hmp=True)
diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
index c2133f998010..65165446607c 100755
--- a/tests/qemu-iotests/260
+++ b/tests/qemu-iotests/260
@@ -24,7 +24,8 @@ from iotests import qemu_img_create, file_path, log, filter_qmp_event
 
 iotests.script_initialize(
     supported_fmts=['qcow2'],
-    unsupported_imgopts=['compat']
+    unsupported_imgopts=['compat'],
+    require_hmp=True,
 )
 
 base, top = file_path('base', 'top')
diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index c6ba2754e279..b621f11ab427 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -114,4 +114,5 @@ class TestNbdReconnect(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'])
+    iotests.main(supported_fmts=['qcow2'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index 2e2afdad9c57..e14aeb1f18d0 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -48,6 +48,7 @@ _require_drivers copy-on-read
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
 
 _require_devices virtio-blk
+_require_hmp
 
 do_run_qemu()
 {
diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
index 2495e051a227..d91c11c70d2e 100755
--- a/tests/qemu-iotests/274
+++ b/tests/qemu-iotests/274
@@ -24,7 +24,8 @@ import iotests
 
 iotests.script_initialize(supported_fmts=['qcow2'],
                           supported_platforms=['linux'],
-                          unsupported_imgopts=['refcount_bits', 'compat'])
+                          unsupported_imgopts=['refcount_bits', 'compat'],
+                          require_hmp=True)
 
 size_short = 1 * 1024 * 1024
 size_long = 2 * 1024 * 1024
diff --git a/tests/qemu-iotests/280 b/tests/qemu-iotests/280
index 5f50500fdb82..8f4750de074b 100755
--- a/tests/qemu-iotests/280
+++ b/tests/qemu-iotests/280
@@ -27,6 +27,7 @@ iotests.script_initialize(
     supported_fmts=['qcow2'],
     supported_protocols=['file'],
     supported_platforms=['linux'],
+    require_hmp=True,
 )
 
 with iotests.FilePath('base') as base_path , \
diff --git a/tests/qemu-iotests/281 b/tests/qemu-iotests/281
index f6746a12e881..5f3050f50d0b 100755
--- a/tests/qemu-iotests/281
+++ b/tests/qemu-iotests/281
@@ -336,4 +336,5 @@ class TestYieldingAndTimers(iotests.QMPTestCase):
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'],
-                 unsupported_imgopts=['compat'])
+                 unsupported_imgopts=['compat'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
index 5defe48e97d5..6d341d3e9745 100755
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -24,6 +24,7 @@ import iotests
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
     supported_fmts=['qcow2'],
+    require_hmp=True,
 )
 
 size = 1024 * 1024
diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
index cc6aacf02283..3b030ec58aa0 100755
--- a/tests/qemu-iotests/286
+++ b/tests/qemu-iotests/286
@@ -40,6 +40,7 @@ _supported_proto file fuse
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
+_require_hmp
 
 _make_test_img 64M
 
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index 09c9290711a8..f2b94077f43a 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -177,4 +177,5 @@ class TestTruncate(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'], required_fmts=['preallocate'])
+    iotests.main(supported_fmts=['qcow2'], required_fmts=['preallocate'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index e46616d7b19a..df2ba326327d 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -683,4 +683,5 @@ class TestAliasTransformMigration(TestDirtyBitmapMigration):
         self.verify_dest_error(None)
 
 if __name__ == '__main__':
-    iotests.main(supported_protocols=['file'])
+    iotests.main(supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index 198f2820871e..d465a519a932 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -24,7 +24,8 @@ import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
 iotests.script_initialize(supported_fmts=['qcow2'],
-                          supported_protocols=['file'])
+                          supported_protocols=['file'],
+                          require_hmp=True)
 
 test_img = file_path('test.qcow2')
 target_img = file_path('target.qcow2')
diff --git a/tests/qemu-iotests/310 b/tests/qemu-iotests/310
index 650d2cb6fb3e..7f290898fea0 100755
--- a/tests/qemu-iotests/310
+++ b/tests/qemu-iotests/310
@@ -25,7 +25,8 @@ from iotests import log, qemu_img, qemu_io
 
 # Need backing file support
 iotests.script_initialize(supported_fmts=['qcow2'],
-                          supported_platforms=['linux'])
+                          supported_platforms=['linux'],
+                          require_hmp=True)
 
 log('')
 log('=== Copy-on-read across nodes ===')
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index bcb1ec50a93d..262fe63da820 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -995,6 +995,14 @@ _notrun_on_fuse_error()
     esac
 }
 
+_require_hmp()
+{
+    if echo quit | $QEMU -M none -display none -monitor stdio 2>&1 |
+            grep -q "HMP monitor is not available"; then
+        _notrun "HMP monitor not available"
+    fi
+}
+
 # Check that we have a file system that allows huge (but very sparse) files
 #
 _require_large_file()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f36bcf316429..7d5a77a85e58 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1456,6 +1456,15 @@ def _verify_formats(required_formats: Sequence[str] = ()) -> None:
         notrun(f'formats {usf_list} are not whitelisted')
 
 
+def _verify_hmp() -> None:
+    args = [qemu_prog] + qemu_opts + ['-M', 'none', '-monitor', 'stdio']
+    with subprocess.Popen(args, stdin=subprocess.PIPE,
+                          stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                          universal_newlines=True) as subp:
+        out, _ = subp.communicate('quit\n')
+    if 'HMP monitor is not available' in out:
+        notrun('HMP monitor not available')
+
 def _verify_virtio_blk() -> None:
     out = qemu_pipe('-M', 'none', '-device', 'help')
     if 'virtio-blk' not in out:
@@ -1694,7 +1703,8 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
                          supported_protocols: Sequence[str] = (),
                          unsupported_protocols: Sequence[str] = (),
                          required_fmts: Sequence[str] = (),
-                         unsupported_imgopts: Sequence[str] = ()) -> bool:
+                         unsupported_imgopts: Sequence[str] = (),
+                         require_hmp: bool = False) -> bool:
     """
     Perform necessary setup for either script-style or unittest-style tests.
 
@@ -1715,6 +1725,8 @@ def execute_setup_common(supported_fmts: Sequence[str] = (),
     _verify_formats(required_fmts)
     _verify_virtio_blk()
     _verify_imgopts(unsupported_imgopts)
+    if require_hmp:
+        _verify_hmp()
 
     return debug
 
diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
index 6c624bc8b0b0..80ea32c46e3f 100755
--- a/tests/qemu-iotests/tests/backup-discard-source
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -160,4 +160,5 @@ class TestBackup(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index 3e43e7127f20..5531ad8a4c0d 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -321,4 +321,5 @@ wrote 524288/524288 bytes at offset 524288
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'],
-                 required_fmts=['copy-before-write'])
+                 required_fmts=['copy-before-write'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index 5e3b2c7e46a9..b42aa6967f68 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -31,7 +31,8 @@ iotests.script_initialize(
     supported_fmts=['qcow2'],
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
-    unsupported_imgopts=['compat']
+    unsupported_imgopts=['compat'],
+    require_hmp=True,
 )
 
 patterns = [('0x5d', '0',         '64k'),
diff --git a/tests/qemu-iotests/tests/iothreads-create b/tests/qemu-iotests/tests/iothreads-create
index 0c862d73f20e..09fe57a09ac0 100755
--- a/tests/qemu-iotests/tests/iothreads-create
+++ b/tests/qemu-iotests/tests/iothreads-create
@@ -22,7 +22,8 @@ import asyncio
 import iotests
 
 iotests.script_initialize(supported_fmts=['qcow2', 'qcow', 'qed', 'vdi',
-                                          'vmdk', 'parallels'])
+                                          'vmdk', 'parallels'],
+                          require_hmp=True)
 iotests.verify_virtio_scsi_pci_or_ccw()
 
 with iotests.FilePath('disk.img') as img_path, \
diff --git a/tests/qemu-iotests/tests/luks-detached-header b/tests/qemu-iotests/tests/luks-detached-header
index 3455fd8de1ef..58eb3c2cc484 100755
--- a/tests/qemu-iotests/tests/luks-detached-header
+++ b/tests/qemu-iotests/tests/luks-detached-header
@@ -313,4 +313,5 @@ class TestDetachedLUKSHeader(QMPTestCase):
 
 if __name__ == "__main__":
     # Test image creation and I/O
-    iotests.main(supported_fmts=["luks"], supported_protocols=["file"])
+    iotests.main(supported_fmts=["luks"], supported_protocols=["file"],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index 33ff2b861f78..b2b37ada4b27 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -279,4 +279,5 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
-                 unsupported_imgopts=['compat'])
+                 unsupported_imgopts=['compat'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index cb9154ca8d7f..25439c9eb773 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -329,7 +329,8 @@ def main() -> None:
     iotests.main(
         supported_fmts=['qcow2'],
         supported_protocols=['file'],
-        unsupported_imgopts=['compat']
+        unsupported_imgopts=['compat'],
+        require_hmp=True,
     )
 
 
diff --git a/tests/qemu-iotests/tests/mirror-change-copy-mode b/tests/qemu-iotests/tests/mirror-change-copy-mode
index 51788b85c7ac..c9c345f1397c 100755
--- a/tests/qemu-iotests/tests/mirror-change-copy-mode
+++ b/tests/qemu-iotests/tests/mirror-change-copy-mode
@@ -190,4 +190,5 @@ class TestMirrorChangeCopyMode(iotests.QMPTestCase):
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'raw'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/mirror-ready-cancel-error b/tests/qemu-iotests/tests/mirror-ready-cancel-error
index ed2e46447e3e..ffa045af2191 100755
--- a/tests/qemu-iotests/tests/mirror-ready-cancel-error
+++ b/tests/qemu-iotests/tests/mirror-ready-cancel-error
@@ -139,4 +139,5 @@ if __name__ == '__main__':
     # LUKS would require special key-secret handling in add_blockdevs()
     iotests.main(supported_fmts=['generic'],
                  unsupported_fmts=['luks'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots b/tests/qemu-iotests/tests/qcow2-internal-snapshots
index 9f83aa890391..d301f0941b5c 100755
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots
@@ -43,6 +43,7 @@ _supported_proto file
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]' data_file
+_require_hmp
 
 IMG_SIZE=64M
 
diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
index a4c6592420c4..d76278b576c2 100755
--- a/tests/qemu-iotests/tests/qsd-migrate
+++ b/tests/qemu-iotests/tests/qsd-migrate
@@ -24,7 +24,8 @@ from iotests import filter_qemu_io, filter_qtest
 
 iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
                           supported_protocols=['file'],
-                          supported_platforms=['linux'])
+                          supported_platforms=['linux'],
+                          require_hmp=True)
 
 with iotests.FilePath('disk.img') as path, \
      iotests.FilePath('nbd-src.sock', base_dir=iotests.sock_dir) as nbd_src, \
diff --git a/tests/qemu-iotests/tests/reopen-file b/tests/qemu-iotests/tests/reopen-file
index 5a50794ffc41..f8812320ea8f 100755
--- a/tests/qemu-iotests/tests/reopen-file
+++ b/tests/qemu-iotests/tests/reopen-file
@@ -85,4 +85,5 @@ if __name__ == '__main__':
     # Must support creating images and reopen
     iotests.main(supported_fmts=['qcow', 'qcow2', 'qed', 'raw', 'vdi', 'vhdx',
                                  'vmdk', 'vpc'],
-                 supported_protocols=['file'])
+                 supported_protocols=['file'],
+                 require_hmp=True)
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap b/tests/qemu-iotests/tests/write-zeroes-unmap
index f90fb8e8d270..506ced647bc1 100755
--- a/tests/qemu-iotests/tests/write-zeroes-unmap
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap
@@ -33,6 +33,7 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
 _require_disk_usage
+_require_hmp
 
 create_test_image() {
     _make_test_img -f $IMGFMT 1m
diff --git a/tests/qtest/drive_del-test.c b/tests/qtest/drive_del-test.c
index 4c32da594a4a..cc52c2d87936 100644
--- a/tests/qtest/drive_del-test.c
+++ b/tests/qtest/drive_del-test.c
@@ -167,6 +167,11 @@ static void test_drive_without_dev(void)
 {
     QTestState *qts;
 
+#ifndef CONFIG_HMP
+    g_test_skip("HMP not enabled");
+    return;
+#endif
+
     /* Start with an empty drive */
     qts = qtest_init("-drive if=none,id=drive0 -M none");
 
@@ -187,6 +192,11 @@ static void test_after_failed_device_add(void)
     QDict *response;
     QTestState *qts;
 
+#ifndef CONFIG_HMP
+    g_test_skip("HMP not enabled");
+    return;
+#endif
+
     if (!has_device_builtin("virtio-blk")) {
         g_test_skip("Device virtio-blk is not available");
         return;
@@ -223,6 +233,11 @@ static void test_drive_del_device_del(void)
 {
     QTestState *qts;
 
+#ifndef CONFIG_HMP
+    g_test_skip("HMP not enabled");
+    return;
+#endif
+
     if (!has_device_builtin("virtio-scsi")) {
         g_test_skip("Device virtio-scsi is not available");
         return;
@@ -405,6 +420,11 @@ static void test_drive_add_device_add_and_del(void)
     const char *arch = qtest_get_arch();
     const char *machine_addition = "";
 
+#ifndef CONFIG_HMP
+    g_test_skip("HMP not enabled");
+    return;
+#endif
+
     if (!has_device_builtin("virtio-blk")) {
         g_test_skip("Device virtio-blk is not available");
         return;
@@ -436,6 +456,11 @@ static void test_drive_add_device_add_and_del_q35(void)
 {
     QTestState *qts;
 
+#ifndef CONFIG_HMP
+    g_test_skip("HMP not enabled");
+    return;
+#endif
+
     if (!has_device_builtin("virtio-blk")) {
         g_test_skip("Device virtio-blk is not available");
         return;

-- 
2.55.0.543.g5ebe2ebe4ea8


