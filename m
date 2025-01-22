Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AE9C02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUs5-0005KF-JJ; Wed, 22 Jan 2025 02:09:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUs3-0005JT-Bp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1taUrz-0008QX-QJ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737529787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hAhVlXQET5eW9qZ7pK9kd+FVFwJRgIZEg09bqeq/ImE=;
 b=UYIx8EhAE89UL4z7slycAtA91DbjpDJwhTt+TNAuQXw5RdSVFuJ9miCiYZ5QmOJMhe87iu
 Fhh/C8AM/R/5aTEQX5iFOyiKququwAPH06KazM4xuvsqy7GoVAWU7lsdh/JIpt6jZtb4j3
 jWWHsfdZhtXcgXNeHbFYUMbxLMTCj3w=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316--zDHzrPWPN6ptbN5m9tjFQ-1; Wed,
 22 Jan 2025 02:09:40 -0500
X-MC-Unique: -zDHzrPWPN6ptbN5m9tjFQ-1
X-Mimecast-MFC-AGG-ID: -zDHzrPWPN6ptbN5m9tjFQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3722C19560A1; Wed, 22 Jan 2025 07:09:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AFB63003FD1; Wed, 22 Jan 2025 07:09:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 7/9] test/functional: Update the Aspeed aarch64 test
Date: Wed, 22 Jan 2025 08:09:07 +0100
Message-ID: <20250122070909.1138598-8-clg@redhat.com>
In-Reply-To: <20250122070909.1138598-1-clg@redhat.com>
References: <20250122070909.1138598-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Bumped SDK version to v09.03. v09.04 is available but not yet
supported in QEMU.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_aarch64_aspeed.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
index 141d86385936..6a9ae2a34956 100755
--- a/tests/functional/test_aarch64_aspeed.py
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -27,14 +27,14 @@ def do_test_aarch64_aspeed_sdk_start(self, image):
         wait_for_console_pattern(self, '## Loading kernel from FIT Image')
         wait_for_console_pattern(self, 'Starting kernel ...')
 
-    ASSET_SDK_V902_AST2700 = Asset(
-            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.02/ast2700-default-obmc.tar.gz',
-            'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7')
+    ASSET_SDK_V903_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.03/ast2700-default-obmc.tar.gz',
+            '91225f50d255e2905ba8d8e0c80b71b9d157c3609770c7a740cd786370d85a77')
 
     def test_aarch64_ast2700_evb_sdk_v09_02(self):
         self.set_machine('ast2700-evb')
 
-        self.archive_extract(self.ASSET_SDK_V902_AST2700)
+        self.archive_extract(self.ASSET_SDK_V903_AST2700)
 
         num_cpu = 4
         uboot_size = os.path.getsize(self.scratch_file('ast2700-default',
-- 
2.48.1


