Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B0CE95374
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaCw-0004Bf-DI; Wed, 04 Feb 2026 05:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaCF-0002mA-Ga
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaCC-0004F2-Q5
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNo2vv9aQLCkD776mwCo37Nfsvyu+C7/DmNPeMHG+Mc=;
 b=YkGNtAtmRgXv/j3OriqljOpGvoo4Acrlq2jHgCxPJOuIS4kHsb7DMUEvDFw3GbQXH3cvHe
 QwIRmV19L4bjQ4wXPIH2f2LPY9e8JaHt0e3mqqLLYcu3LPk4IGia30SlN/j2x0WfLeAxOt
 DihZLX/FSLIL8Cy1lJBeRhDk8gv9L/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-d-N_1qqGPGGaBkwZkiilzQ-1; Wed,
 04 Feb 2026 05:33:14 -0500
X-MC-Unique: d-N_1qqGPGGaBkwZkiilzQ-1
X-Mimecast-MFC-AGG-ID: d-N_1qqGPGGaBkwZkiilzQ_1770201193
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A42C318003F6; Wed,  4 Feb 2026 10:33:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32FB218003F6; Wed,  4 Feb 2026 10:33:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 44/45] tests/functional/aarch64: Parameterize PCIe2
 initialization in AST2700
Date: Wed,  4 Feb 2026 11:31:35 +0100
Message-ID: <20260204103136.1795455-45-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane Chen <kane_chen@aspeedtech.com>

The current AST2700 functional test forces PCIe2 enablement by manually
manipulating U-Boot env and FDT via the console. This sequence
interferes with test cases that rely on the default boot flow of the
image.

Introduce a 'enable_pcie' parameter (defaulting to True) to both
'verify_openbmc_boot_start' and 'verify_openbmc_boot_and_login' methods.
This allow test cases to toggle the PCIe2 initialization sequence based
on their specific requirements without breaking standard boot tests.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260204082113.3955407-22-kane_chen@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index d7eeab9c23fd..cb1aafeb99fa 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -65,13 +65,14 @@ def enable_ast2700_pcie2(self):
             'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
         exec_command(self, 'bootm go')
 
-    def verify_openbmc_boot_start(self):
+    def verify_openbmc_boot_start(self, enable_pcie=True):
         wait_for_console_pattern(self, 'U-Boot 2023.10')
-        self.enable_ast2700_pcie2()
+        if enable_pcie:
+            self.enable_ast2700_pcie2()
         wait_for_console_pattern(self, 'Linux version ')
 
-    def verify_openbmc_boot_and_login(self, name):
-        self.verify_openbmc_boot_start()
+    def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
+        self.verify_openbmc_boot_start(enable_pcie)
 
         wait_for_console_pattern(self, f'{name} login:')
         exec_command_and_wait_for_pattern(self, 'root', 'Password:')
-- 
2.52.0


