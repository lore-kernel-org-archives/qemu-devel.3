Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44078C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 18:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpX5j-0000Nf-Rs; Tue, 04 Mar 2025 13:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpX5g-0000NI-K1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tpX5Z-00067M-F6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 13:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741113235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n4vTbKf2vdFcmVDPvSoh00VMSdksej4ULlmUMPYXUuU=;
 b=a288hyZ9Zo1xX3oHJWoCi1OsZslkVYrBlhM1gCEs7l76bwLi7MvMMuT0qbSqr2IJ+QEcPh
 597GXDhPTmR3e4claM8VfJMe4t/VmjxVrV9xbTifIHXVgOu7RYIqNblWqV64MeW34P8zER
 3+u6AOG53YBXVs297sUhbXRBBHlBWKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-I-Y84ZQaPT-bAwwQ22oSgA-1; Tue,
 04 Mar 2025 13:33:47 -0500
X-MC-Unique: I-Y84ZQaPT-bAwwQ22oSgA-1
X-Mimecast-MFC-AGG-ID: I-Y84ZQaPT-bAwwQ22oSgA_1741113226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 963091800987
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 18:33:44 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.210])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B37511800352; Tue,  4 Mar 2025 18:33:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: fix race in virtio balloon test
Date: Tue,  4 Mar 2025 18:33:40 +0000
Message-ID: <20250304183340.3749797-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There are two race conditions in the recently added virtio balloon
test

 * The /dev/vda device node is not ready
 * The virtio-balloon driver has not issued the first stats refresh

To fix the former, monitor dmesg for a line about 'vda'.

To fix the latter, retry the stats query until seeing fresh data.

Adding 'quiet' to the kernel command line reduces serial output
which otherwise slows boot, making it less likely to hit the former
race too.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_virtio_balloon.py | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
index 67b48e1b4e..308d197eb3 100755
--- a/tests/functional/test_virtio_balloon.py
+++ b/tests/functional/test_virtio_balloon.py
@@ -32,7 +32,7 @@ class VirtioBalloonx86(QemuSystemTest):
         'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
 
     DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
-                             'rd.rescue')
+                             'rd.rescue quiet')
 
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(
@@ -47,6 +47,9 @@ def mount_root(self):
         prompt = '# '
         self.wait_for_console_pattern(prompt)
 
+        # Synchronize on virtio-block driver creating the root device
+        exec_command_and_wait_for_pattern(self, "while ! (dmesg -c | grep vda:) ; do sleep 1 ; done", "vda1")
+
         exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
                                           prompt)
         exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
@@ -65,10 +68,21 @@ def assert_initial_stats(self):
             assert val == UNSET_STATS_VALUE
 
     def assert_running_stats(self, then):
-        ret = self.vm.qmp('qom-get',
-                          {'path': '/machine/peripheral/balloon',
-                           'property': 'guest-stats'})['return']
-        when = ret.get('last-update')
+        # We told the QEMU to refresh stats every 100ms, but
+        # there can be a delay between virtio-ballon driver
+        # being modprobed and seeing the first stats refresh
+        # Retry a few times for robustness under heavy load
+        retries = 10
+        when = 0
+        while when == 0 and retries:
+            ret = self.vm.qmp('qom-get',
+                              {'path': '/machine/peripheral/balloon',
+                               'property': 'guest-stats'})['return']
+            when = ret.get('last-update')
+            if when == 0:
+                retries = retries - 1
+                time.sleep(0.5)
+
         now = time.time()
 
         assert when > then and when < now
-- 
2.48.1


