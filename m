Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572CFCCD18E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8HvK-0004dw-D8; Mon, 13 Oct 2025 08:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv4-0004TN-OH
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hut-0007ul-W2
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RnZ5UGj66iRaGtOQx3od5fSCxnQ3bZZNz27AYF+HCkk=;
 b=gWTTqauZXF+YNoqrlgFZ0vNmKjLCV+IXVEQ9rRSJBo6klqKC6827nhyq5nx8ttFEKfoEr8
 Xzkvp6sCytp7C6824fkRxa3Fc8eh0KQZIAnsgLNmMFKMD8uc0EzdYz7adTilCOZPu7kfpB
 jzvjll92JrpPfuK/1hToLkbfa/rbmKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-VHSMWpxHP3yJKU6p4cKc_Q-1; Mon,
 13 Oct 2025 08:44:39 -0400
X-MC-Unique: VHSMWpxHP3yJKU6p4cKc_Q-1
X-Mimecast-MFC-AGG-ID: VHSMWpxHP3yJKU6p4cKc_Q_1760359478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FD7419560B5; Mon, 13 Oct 2025 12:44:38 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D07191800446; Mon, 13 Oct 2025 12:44:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/29] tests/functional/aarch64/test_aspeed_ast2700: Move eth2
 IP check into common function
Date: Mon, 13 Oct 2025 14:43:58 +0200
Message-ID: <20251013124421.71977-8-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
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
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The eth2 IP address check was previously only performed in
test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08. This patch moves the
check into do_ast2700_pcie_test(), ensuring it is executed consistently
across all AST2700 PCIe test runs. This avoids code duplication.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251003072107.3530642-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
index 0e9f10d991ea..ef7ed522afc3 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700.py
@@ -74,6 +74,9 @@ def do_ast2700_pcie_test(self):
             'lspci -s 0002:01:00.0',
             '0002:01:00.0 Ethernet controller: '
             'Intel Corporation 82574L Gigabit Network Connection')
+        exec_command_and_wait_for_pattern(self,
+            'ip addr show dev eth2',
+            'inet 10.0.2.15/24')
 
     def start_ast2700_test(self, name):
         num_cpu = 4
@@ -153,9 +156,6 @@ def test_aarch64_ast2700a1_evb_sdk_vbootrom_v09_08(self):
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test()
         self.do_ast2700_pcie_test()
-        exec_command_and_wait_for_pattern(self,
-            'ip addr show dev eth2',
-            'inet 10.0.2.15/24')
 
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.51.0


