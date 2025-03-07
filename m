Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05047C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWH5-0002Ny-Df; Fri, 07 Mar 2025 06:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWH4-0002Ni-1g
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWH2-0000Lb-FL
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cd6O1VZDeIT786/XOF02v5jigOV2z1r9juG1O4n0MAM=;
 b=YYw31uqsWAEemIzRC/JuY509eLYUeLTDNYem6tMtfnuQqlE5ROz9aK2IeVlrvjJaNwZjAO
 S7jX4JvA+P2Io3jV2XDnfJCSxdvhZNtXuVHJfnknh7+WtCQUoA2U49sGz2Z4iMzX1FLK7J
 jvn++tyebc90cYCeTFrNkJAkBJQuCUI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-_pdVH5ESOMSRMxsgZakQLw-1; Fri,
 07 Mar 2025 06:53:47 -0500
X-MC-Unique: _pdVH5ESOMSRMxsgZakQLw-1
X-Mimecast-MFC-AGG-ID: _pdVH5ESOMSRMxsgZakQLw_1741348426
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD9EA19560A1
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 11:53:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66C561944F2E; Fri,  7 Mar 2025 11:53:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 10/15] tests/functional: fix race in virtio balloon test
Date: Fri,  7 Mar 2025 12:53:09 +0100
Message-ID: <20250307115314.1096373-11-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

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
Message-ID: <20250304183340.3749797-1-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[thuth: Break long line to avoid checkpatch error]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_virtio_balloon.py | 26 ++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
index 67b48e1b4e8..082bf08c4e8 100755
--- a/tests/functional/test_virtio_balloon.py
+++ b/tests/functional/test_virtio_balloon.py
@@ -32,7 +32,7 @@ class VirtioBalloonx86(QemuSystemTest):
         'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
 
     DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
-                             'rd.rescue')
+                             'rd.rescue quiet')
 
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(
@@ -47,6 +47,11 @@ def mount_root(self):
         prompt = '# '
         self.wait_for_console_pattern(prompt)
 
+        # Synchronize on virtio-block driver creating the root device
+        exec_command_and_wait_for_pattern(self,
+                        "while ! (dmesg -c | grep vda:) ; do sleep 1 ; done",
+                        "vda1")
+
         exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
                                           prompt)
         exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
@@ -65,10 +70,21 @@ def assert_initial_stats(self):
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


