Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF20C0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5DP-00013A-HT; Wed, 29 Jan 2025 05:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td5DO-00012s-9g
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td5DM-0004UE-I6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:22:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738146150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=22pKqwM0+tGWJze/QFEPd2FYGrLRsW8ZA1ZeyZuHaok=;
 b=dP0b6l7cQAS8EidAJulpCM4XcOJGdvTXnCOPLStSg273qBAdsRWDz1mwpToUQyjIIm+noj
 VH9gAhLwFsGcZWmFFy8iurVJkkBp/IijC4eIBEM/eBhRlugB4C2ntYdmnO/RgwX3yzciCx
 aeWnP78MBI7wcEYcBRejgjZDJJrzVh0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-BAUoS3tpOAOl0SClUvwydg-1; Wed,
 29 Jan 2025 05:22:28 -0500
X-MC-Unique: BAUoS3tpOAOl0SClUvwydg-1
X-Mimecast-MFC-AGG-ID: BAUoS3tpOAOl0SClUvwydg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94E5518009C5; Wed, 29 Jan 2025 10:22:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3E5D919560AA; Wed, 29 Jan 2025 10:22:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] tests/functional: Extend PPC 40p test with Linux boot
Date: Wed, 29 Jan 2025 11:22:23 +0100
Message-ID: <20250129102223.1313703-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fetch the cdrom image for the IBM 6015 PReP PowerPC machine hosted on
the Juneau Linux Users Group site, boot and check Linux version.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_ppc_40p.py | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index 7a74e0cca70b..5ce79aec5e6b 100755
--- a/tests/functional/test_ppc_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -9,7 +9,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern, skipUntrustedTest
-
+from qemu_test import exec_command_and_wait_for_pattern
 
 class IbmPrep40pMachine(QemuSystemTest):
 
@@ -72,5 +72,23 @@ def test_openbios_and_netbsd(self):
         self.vm.launch()
         wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
 
+    ASSET_40P_SANDALFOOT = Asset(
+        'http://www.juneau-lug.org/zImage.initrd.sandalfoot',
+        '749ab02f576c6dc8f33b9fb022ecb44bf6a35a0472f2ea6a5e9956bc15933901')
+
+    def test_openbios_and_linux(self):
+        self.set_machine('40p')
+        self.require_accelerator("tcg")
+        drive_path = self.ASSET_40P_SANDALFOOT.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-cdrom', drive_path,
+                         '-boot', 'd')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Please press Enter to activate this console.')
+        exec_command_and_wait_for_pattern(self, '\012', '#')
+        exec_command_and_wait_for_pattern(self, 'uname -a', 'Linux ppc 2.4.18')
+        exec_command_and_wait_for_pattern(self, 'poweroff', 'Terminated')
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.48.1


