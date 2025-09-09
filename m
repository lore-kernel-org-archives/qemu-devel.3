Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E018CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvymB-0000y7-9R; Tue, 09 Sep 2025 09:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvylp-0000oC-TQ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvyll-0005H9-1m
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757425942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7ND8DVcojIY8zZOwOhSVViHrcmjFHDYL+b9zvQ0MLA=;
 b=auiZ6yVq0fubI7XVAdqIzNr95mNNf7+GVruTLhicn1TJTU7HFkaLX/yKkY2FMmFJyqwthi
 xw6n9FmakDE3yPpkncQO4SUU8dxmT1jGftM5PvHwa6moslm9IwZjgm8pNmCXm6Sqd/k+CC
 /QKSDxuQzfiHmx//g72cb+9m12WScYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-qES64YwhNlmddWyvAYzZwA-1; Tue,
 09 Sep 2025 09:52:20 -0400
X-MC-Unique: qES64YwhNlmddWyvAYzZwA-1
X-Mimecast-MFC-AGG-ID: qES64YwhNlmddWyvAYzZwA_1757425940
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A21F7180029A; Tue,  9 Sep 2025 13:52:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.46])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0BD1318003FC; Tue,  9 Sep 2025 13:52:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/23] tests/functional/arm: Update test ASPEED SDK v09.07 for
 AST2700 vbootrom
Date: Tue,  9 Sep 2025 15:51:37 +0200
Message-ID: <20250909135147.612345-14-thuth@redhat.com>
In-Reply-To: <20250909135147.612345-1-thuth@redhat.com>
References: <20250909135147.612345-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20250904100556.1729604-5-kane_chen@aspeedtech.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index d02dc7991c1..8a08bc46888 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -54,6 +54,10 @@ def verify_openbmc_boot_and_login(self, name):
             'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
             'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
 
+    ASSET_SDK_V907_AST2700A1_VBOOROM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2700-default-obmc.tar.gz',
+            '6e9e0c4b13e0f26040eca3f4a7f17cf09fc0f5c37c820500ff79370cc3c44add')
+
     def do_ast2700_i2c_test(self):
         exec_command_and_wait_for_pattern(self,
             'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
@@ -127,10 +131,10 @@ def test_aarch64_ast2700a1_evb_sdk_v09_06(self):
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
 
-    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_06(self):
+    def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_07(self):
         self.set_machine('ast2700a1-evb')
 
-        self.archive_extract(self.ASSET_SDK_V906_AST2700A1)
+        self.archive_extract(self.ASSET_SDK_V907_AST2700A1_VBOOROM)
         self.start_ast2700_test_vbootrom('ast2700-default')
         self.verify_vbootrom_firmware_flow()
         self.verify_openbmc_boot_and_login('ast2700-default')
-- 
2.51.0


