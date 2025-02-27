Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C781C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbIw-0007gL-NJ; Thu, 27 Feb 2025 05:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnbIr-0007bk-RR
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnbIq-0003C3-4n
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740652778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jzuaNwODF1DK/Qm246vnVnxoJib6aVgbvc3Wt9wkKRM=;
 b=Ufir6tRNZ/Mcd2Q2+fp5jV9ZNswk0z2nx6+Hs9jK66biLOqsw8P6nQbFnqNnw+Hp5liUcu
 M3pC/kzQWG/ObdXrg6Xy/97FIWslyHdUuk1sQA1B4ihwxTXkl4VDaQrEBPkfTMd/XFZXVE
 1HtfWFCawOLIxqgptZPqDpqdEkYKsjU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-2wZxDIwmOGKuooz9N0h78Q-1; Thu,
 27 Feb 2025 05:39:32 -0500
X-MC-Unique: 2wZxDIwmOGKuooz9N0h78Q-1
X-Mimecast-MFC-AGG-ID: 2wZxDIwmOGKuooz9N0h78Q_1740652772
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D640F1800874; Thu, 27 Feb 2025 10:39:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.184])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2CB3300018D; Thu, 27 Feb 2025 10:39:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/6] tests/functional/test_mips_malta: Add a network test via
 the pcnet NIC
Date: Thu, 27 Feb 2025 11:39:11 +0100
Message-ID: <20250227103915.19795-3-thuth@redhat.com>
In-Reply-To: <20250227103915.19795-1-thuth@redhat.com>
References: <20250227103915.19795-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The kernel has a driver for the pcnet NIC included, and the initrd has
a "tftp" command, so we can test a simple network transfer here, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_mips_malta.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index eaf372255ba..9697c7d63f8 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -45,12 +45,15 @@ def test_mips_malta(self):
         'dcfe3a7fe3200da3a00d176b95caaa086495eb158f2bff64afc67d7e1eb2cddc')
 
     def test_mips_malta_cpio(self):
+        self.require_netdev('user')
+        self.set_machine('malta')
+        self.require_device('pcnet')
+
         kernel_path = self.archive_extract(
             self.ASSET_KERNEL_4_5_0,
             member='boot/vmlinux-4.5.0-2-4kc-malta')
         initrd_path = self.uncompress(self.ASSET_INITRD)
 
-        self.set_machine('malta')
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
                                + 'console=ttyS0 console=tty '
@@ -58,6 +61,8 @@ def test_mips_malta_cpio(self):
         self.vm.add_args('-kernel', kernel_path,
                          '-initrd', initrd_path,
                          '-append', kernel_command_line,
+                         '-netdev', 'user,id=n1,tftp=' + self.scratch_file('boot'),
+                         '-device', 'pcnet,netdev=n1',
                          '-no-reboot')
         self.vm.launch()
         self.wait_for_console_pattern('Boot successful.')
@@ -66,6 +71,19 @@ def test_mips_malta_cpio(self):
                                                 'BogoMIPS')
         exec_command_and_wait_for_pattern(self, 'uname -a',
                                                 'Debian')
+
+        exec_command_and_wait_for_pattern(self, 'ip link set eth0 up',
+                                          'eth0: link up')
+        exec_command_and_wait_for_pattern(self,
+                                          'ip addr add 10.0.2.15 dev eth0',
+                                          '#')
+        exec_command_and_wait_for_pattern(self, 'route add default eth0', '#')
+        exec_command_and_wait_for_pattern(self,
+                         'tftp -g -r vmlinux-4.5.0-2-4kc-malta 10.0.2.2', '#')
+        exec_command_and_wait_for_pattern(self,
+                                          'md5sum vmlinux-4.5.0-2-4kc-malta',
+                                          'a98218a7efbdefb2dfdf9ecd08c98318')
+
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
         # Wait for VM to shut down gracefully
-- 
2.48.1


