Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC98CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBY0h-0002SF-N9; Wed, 22 Oct 2025 08:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXzA-0001JD-DZ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXz7-0008Q7-US
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eDRd8TMDVFLc1jfdHKLOkdmmzQsBdOy51ZEFZ2mk/4=;
 b=APHCIEhrmEKX8jOZ7cxoAe9PbCnhB3WUA4rxxgTgw+kq5tv/rhbqYmheD7eDKy6lJNPB/3
 7AHfrepQlBAO0sQXJADfmmsgmOAFmdjqJt8Sy2aXyjz3eno2meF2AOCYulikCtBRixIOQ8
 lKF1Hb3YqVz4aAQxRMAQjfj4uRGEL4g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-Hg20khiLNc-GfCqQjOjh2Q-1; Wed,
 22 Oct 2025 08:30:30 -0400
X-MC-Unique: Hg20khiLNc-GfCqQjOjh2Q-1
X-Mimecast-MFC-AGG-ID: Hg20khiLNc-GfCqQjOjh2Q_1761136229
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1771B195420F; Wed, 22 Oct 2025 12:30:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 728A81800584; Wed, 22 Oct 2025 12:30:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/16] tests/functional/aarch64/ast2700fc: Add vbootrom test
Date: Wed, 22 Oct 2025 14:29:49 +0200
Message-ID: <20251022122953.877335-13-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add start_ast2700fc_test_vbootrom() which boots the ast2700fc machine
with -bios ast27x0_bootrom.bin and reuses the coprocessor loader.

Add test_aarch64_ast2700fc_sdk_vbootrom_v09_08() to test the vbootrom
with ast2700fc machine.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015062210.3128710-13-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700fc.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
index 9ab3d3269b2a..8dbc8f234f9c 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700fc.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700fc.py
@@ -138,6 +138,12 @@ def start_ast2700fc_test(self, name):
         self.do_test_aarch64_aspeed_sdk_start(
                 self.scratch_file(name, 'image-bmc'))
 
+    def start_ast2700fc_test_vbootrom(self, name):
+        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
+        self.load_ast2700fc_coprocessor(name)
+        self.do_test_aarch64_aspeed_sdk_start(
+                self.scratch_file(name, 'image-bmc'))
+
     def test_aarch64_ast2700fc_sdk_v09_08(self):
         self.set_machine('ast2700fc')
         self.require_netdev('user')
@@ -150,5 +156,14 @@ def test_aarch64_ast2700fc_sdk_v09_08(self):
         self.do_ast2700fc_ssp_test()
         self.do_ast2700fc_tsp_test()
 
+    def test_aarch64_ast2700fc_sdk_vbootrom_v09_08(self):
+        self.set_machine('ast2700fc')
+
+        self.archive_extract(self.ASSET_SDK_V908_AST2700)
+        self.start_ast2700fc_test_vbootrom('ast2700-default')
+        self.verify_openbmc_boot_and_login('ast2700-default')
+        self.do_ast2700fc_ssp_test()
+        self.do_ast2700fc_tsp_test()
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


