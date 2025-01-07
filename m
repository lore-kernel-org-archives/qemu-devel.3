Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3301E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV88p-0005W7-Cm; Tue, 07 Jan 2025 06:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV88m-0005Vr-43
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:52:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tV88k-000587-JI
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736250771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LvCEGT6+UCd7L1UgCGlJdhwfSQFQGaHZ8TvaU16c2rk=;
 b=CwCB0F1Wa2UXxBJ+GSBDg1pSienBr1JFBTsaumeHtm5T5SwmZhW79GoS5AuJuynJdYMA9i
 V5GznHH5PbrZB46WzxBCDIOoc0pNnYTM9GAnRwPauIHoR8Wo7sn7f3JArdWj2k2ixFYX/H
 BB7yZikLVwNDeo4jGquGhqXr071UxxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-pu46uJIIP1qbHXuFeSAoxw-1; Tue,
 07 Jan 2025 06:52:50 -0500
X-MC-Unique: pu46uJIIP1qbHXuFeSAoxw-1
X-Mimecast-MFC-AGG-ID: pu46uJIIP1qbHXuFeSAoxw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48A451955F44; Tue,  7 Jan 2025 11:52:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.58])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 382A61956053; Tue,  7 Jan 2025 11:52:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Subject: [PATCH] tests/functional/test_x86_64_hotplug_cpu: Fix race condition
 during unplug
Date: Tue,  7 Jan 2025 12:52:45 +0100
Message-ID: <20250107115245.52755-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When unplugging the CPU, the test tries to check for a successful
unplug by changing to the /sys/devices/system/cpu/cpu1 directory
to see whether that fails. However, the "cd" could be faster than
the unplug operation in the kernel, so there is a race condition
and the test sometimes fails here.
Fix it by trying to change the directory in a loop until the the
CPU has really been unplugged.

Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_x86_64_hotplug_cpu.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/test_x86_64_hotplug_cpu.py
index b1d5156c72..7b9200ac2e 100755
--- a/tests/functional/test_x86_64_hotplug_cpu.py
+++ b/tests/functional/test_x86_64_hotplug_cpu.py
@@ -59,11 +59,13 @@ def test_hotplug(self):
                                           'cd /sys/devices/system/cpu/cpu1',
                                           'cpu1#')
 
+        exec_command_and_wait_for_pattern(self, 'cd ..', prompt)
         self.vm.cmd('device_del', id='c1')
 
         exec_command_and_wait_for_pattern(self,
-                                          'cd /sys/devices/system/cpu/cpu1',
-                                          'No such file or directory')
+                                    'while cd /sys/devices/system/cpu/cpu1 ;'
+                                    ' do sleep 0.2 ; done',
+                                    'No such file or directory')
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.1


