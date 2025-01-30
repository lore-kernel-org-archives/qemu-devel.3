Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEDBC0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 13:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUQ2-0000NW-0L; Thu, 30 Jan 2025 08:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP7-0007WP-EJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUP3-0000B3-CZ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1333MXfcJNjkCPS2IqEDL8zLZHoge3PzuNzOpIy/EgA=;
 b=LBeEyzItyY8eIrpZFKCmdruvTgX7KoNqXWicKmZkoBjv10ulw4yu0AGLt4jVUrg3x0tuqC
 bglHn1CkmQhBCETsVe2ReC6r+MVYmoiXodX1816Y0NI+aLqI4N8quI8VqId2Xoj0+HuE6M
 NNXhL9ttPNVPSQb8EJ7ZG6LUFbeowLQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-2l3SF2j2Nw6hEtA2lITKNw-1; Thu,
 30 Jan 2025 08:16:14 -0500
X-MC-Unique: 2l3SF2j2Nw6hEtA2lITKNw-1
X-Mimecast-MFC-AGG-ID: 2l3SF2j2Nw6hEtA2lITKNw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AB531955DD4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:16:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C593A30001BE; Thu, 30 Jan 2025 13:16:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/20] tests/functional: Extend PPC 40p test with Linux boot
Date: Thu, 30 Jan 2025 14:15:28 +0100
Message-ID: <20250130131535.91297-15-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

From: Cédric Le Goater <clg@redhat.com>

Fetch the cdrom image for the IBM 6015 PReP PowerPC machine hosted on
the Juneau Linux Users Group site, boot and check Linux version.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250129104844.1322100-1-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc_40p.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index 7a74e0cca7..614972a7eb 100755
--- a/tests/functional/test_ppc_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -9,6 +9,7 @@
 
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern, skipUntrustedTest
+from qemu_test import exec_command_and_wait_for_pattern
 
 
 class IbmPrep40pMachine(QemuSystemTest):
@@ -72,5 +73,22 @@ def test_openbios_and_netbsd(self):
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
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.48.1


