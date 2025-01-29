Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B1C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5d3-00083B-Rt; Wed, 29 Jan 2025 05:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td5d1-00082a-R8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:49:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td5d0-0008BL-1w
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738147738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K6pVBDbM6DGqWjbPaCKDnPT+TbY/fu326k403+s+Fv8=;
 b=Tvno954o1YCpsIf4YXMRFXx80pvzetxshJxwTVCWmCw5/kuV1m8jZWBAi0fNsrXXQ5XjLO
 0r0Pk+B+8bbtrJiI3f2WZdoXEQTruL5d515v31TFUTOHWue2n2WQnuiiFKz381VtCAmie8
 4oQiDEWwxhrAjYPJNa5OhN9S8DyOjNQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-DAIqXADNP7SZkYRaRIac0A-1; Wed,
 29 Jan 2025 05:48:56 -0500
X-MC-Unique: DAIqXADNP7SZkYRaRIac0A-1
X-Mimecast-MFC-AGG-ID: DAIqXADNP7SZkYRaRIac0A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7EE6D195608F; Wed, 29 Jan 2025 10:48:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 376DC1956094; Wed, 29 Jan 2025 10:48:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] tests/functional: Extend PPC 40p test with Linux boot
Date: Wed, 29 Jan 2025 11:48:44 +0100
Message-ID: <20250129104844.1322100-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v2:

 - Kept the 2 empty lines lines between the imports and the class
   statements

 tests/functional/test_ppc_40p.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index 7a74e0cca70b..614972a7eb38 100755
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


