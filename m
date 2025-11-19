Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18673CF259E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdXA-0003Ib-4k; Wed, 19 Nov 2025 03:27:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdX2-0003CK-OS
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLdX0-0000ts-TI
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763540833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILJj5HtA0d+6QI4dslPgn4+dCqIwzHYnHyjqRqvseb0=;
 b=b9sh7f+4YwqdMuMpyFGEEDyONwZip8FE1Bf4gzHWIOBgPtsagWJjUJG2d1fv2A1cNei1ce
 x0SLp6qW77INbPx37zYSe8M7c2nS/QSRHkvjNIN2k2ChCkJdng1CjcEJXY2DRypsarGUfR
 NL+Q4weuNcYD5zUsDE4conWBPqgGeeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-rY3a-B8nPle33QhQJp6qBQ-1; Wed,
 19 Nov 2025 03:27:08 -0500
X-MC-Unique: rY3a-B8nPle33QhQJp6qBQ-1
X-Mimecast-MFC-AGG-ID: rY3a-B8nPle33QhQJp6qBQ_1763540825
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28CDC19560B3; Wed, 19 Nov 2025 08:27:05 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BDD7180049F; Wed, 19 Nov 2025 08:26:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH for-11.0 03/15]
 tests/functional/arm/test_aspeed_ast2600_buildroot: Fix pylint warnings
Date: Wed, 19 Nov 2025 09:26:24 +0100
Message-ID: <20251119082636.43286-4-thuth@redhat.com>
In-Reply-To: <20251119082636.43286-1-thuth@redhat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Pylint recommends to use a "with" context for tempfile.TemporaryDirectory()
to make sure that the directory is deleted once it is not needed anymore,
and it recommends to use the "check" parameter for subprocess.run().
For style reasons, the imports at the beginning of the file should be
grouped by module.

Message-Id: <20251113100601.476900-1-thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../arm/test_aspeed_ast2600_buildroot.py      | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_ast2600_buildroot.py b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
index 51f2676c906..575a5f64143 100755
--- a/tests/functional/arm/test_aspeed_ast2600_buildroot.py
+++ b/tests/functional/arm/test_aspeed_ast2600_buildroot.py
@@ -9,8 +9,8 @@
 import tempfile
 import subprocess
 
-from qemu_test import Asset
 from aspeed import AspeedTest
+from qemu_test import Asset
 from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
 
 
@@ -66,21 +66,18 @@ def test_arm_ast2600_evb_buildroot(self):
          'images/ast2600-evb/buildroot-2023.02-tpm/flash.img'),
         'a46009ae8a5403a0826d607215e731a8c68d27c14c41e55331706b8f9c7bd997')
 
-    @skipIfMissingCommands('swtpm')
-    def test_arm_ast2600_evb_buildroot_tpm(self):
-        self.set_machine('ast2600-evb')
-
+    def _test_arm_ast2600_evb_buildroot_tpm(self, tpmstate_dir):
         image_path = self.ASSET_BR2_202302_AST2600_TPM_FLASH.fetch()
 
-        tpmstate_dir = tempfile.TemporaryDirectory(prefix="qemu_")
-        socket = os.path.join(tpmstate_dir.name, 'swtpm-socket')
+        socket = os.path.join(tpmstate_dir, 'swtpm-socket')
 
         # We must put the TPM state dir in /tmp/, not the build dir,
         # because some distros use AppArmor to lock down swtpm and
         # restrict the set of locations it can access files in.
         subprocess.run(['swtpm', 'socket', '-d', '--tpm2',
-                        '--tpmstate', f'dir={tpmstate_dir.name}',
-                        '--ctrl', f'type=unixio,path={socket}'])
+                        '--tpmstate', f'dir={tpmstate_dir}',
+                        '--ctrl', f'type=unixio,path={socket}'],
+                       check=True)
 
         self.vm.add_args('-chardev', f'socket,id=chrtpm,path={socket}')
         self.vm.add_args('-tpmdev', 'emulator,id=tpm0,chardev=chrtpm')
@@ -97,6 +94,12 @@ def test_arm_ast2600_evb_buildroot_tpm(self):
 
         self.do_test_arm_aspeed_buildroot_poweroff()
 
+    @skipIfMissingCommands('swtpm')
+    def test_arm_ast2600_evb_buildroot_tpm(self):
+        self.set_machine('ast2600-evb')
+        with tempfile.TemporaryDirectory(prefix="qemu_") as tpmstate_dir:
+            self._test_arm_ast2600_evb_buildroot_tpm(tpmstate_dir)
+
 
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.51.1


