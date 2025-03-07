Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF33C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWGx-0002MK-E3; Fri, 07 Mar 2025 06:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGv-0002M8-Gr
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tqWGt-0000Kb-Sx
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 06:53:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741348423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6avlNywYqNBs21pMU25Gyd2Sd9eIGLD/4nwfd+flrBM=;
 b=iS7qMS170EzHi+1HFWx7KJWkVGIEJP9jS5RuauhZt3DfM3YrnkizwRNA9X8i1T9z7K85LX
 y762uPcg0rVZ8+GxRYBh/9dHWFyvNmPDjRlowx97pSEJD5705n+Y4sGLRDXUFs4+2bHdRy
 aS17+oV9NBCYc1EZYJZELCaYsGM3IPI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-xFsjYEHhN7ipkKFRKnkMdg-1; Fri,
 07 Mar 2025 06:53:41 -0500
X-MC-Unique: xFsjYEHhN7ipkKFRKnkMdg-1
X-Mimecast-MFC-AGG-ID: xFsjYEHhN7ipkKFRKnkMdg_1741348421
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB1BD19560B8
 for <qemu-devel@nongnu.org>; Fri,  7 Mar 2025 11:53:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.60])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94A741944E45; Fri,  7 Mar 2025 11:53:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 08/15] tests/functional/test_mips_malta: Add a network test via
 the pcnet NIC
Date: Fri,  7 Mar 2025 12:53:07 +0100
Message-ID: <20250307115314.1096373-9-thuth@redhat.com>
In-Reply-To: <20250307115314.1096373-1-thuth@redhat.com>
References: <20250307115314.1096373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The kernel has a driver for the pcnet NIC included, and the initrd has
a "tftp" command, so we can test a simple network transfer here, too.

Message-ID: <20250227103915.19795-3-thuth@redhat.com>
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


