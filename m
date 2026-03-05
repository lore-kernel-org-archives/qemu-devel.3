Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2ACF47CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 18:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCyc-0001wh-KI; Thu, 05 Mar 2026 12:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxy-0000Bi-PP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCxs-0003jT-Gj
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:58:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gxd0DBmGCNLItwmqxf9WoE3L+VXhutEHVrqXOm+qzcw=;
 b=ftiTOFa9LQG8DFE4FmQLw/FKhxFPneBaDT18ubG/Buge2ozvV8hqilVNGjtNVJ2VZWSS+x
 M7oinV5BGwF5BdXyk30elNWfmeeEa6/CrCW00Ixr4bCzjEc0CcegpwZegxq41dpGwGZj+D
 PTNCoqNEJ+d7N8rzOue5bTj9fYnrCLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-g2zGIlmKPouXPZGh2QhKnQ-1; Thu,
 05 Mar 2026 12:58:18 -0500
X-MC-Unique: g2zGIlmKPouXPZGh2QhKnQ-1
X-Mimecast-MFC-AGG-ID: g2zGIlmKPouXPZGh2QhKnQ_1772733496
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 986A41956094; Thu,  5 Mar 2026 17:58:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D591C3003E9E; Thu,  5 Mar 2026 17:58:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Subject: [PULL 22/38] tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c
 functional test
Date: Thu,  5 Mar 2026 18:56:55 +0100
Message-ID: <20260305175711.1119025-23-clg@redhat.com>
In-Reply-To: <20260305175711.1119025-1-clg@redhat.com>
References: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260225021158.1586584-22-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index 971fa3390d21..46b9f7058c08 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -31,6 +31,15 @@ def do_ast2600_pcie_test(self):
             'ip addr show dev eth4',
             'inet 10.0.2.15/24')
 
+    def do_ast2600_i3c_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab'
+            ' -w 0x12,0x34,0x56,0x78,0x90,0xab,0xcd,0xef',
+            'Success on message 0')
+        exec_command_and_wait_for_pattern(self,
+            'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | xargs',
+            '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')
+
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
         self.require_netdev('user')
@@ -43,6 +52,8 @@ def test_arm_ast2600_evb_sdk(self):
             'ds1338,bus=aspeed.i2c.bus.5,address=0x32')
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.0')
         self.vm.add_args('-netdev', 'user,id=net1')
+        self.vm.add_args('-device',
+            'mock-i3c-target,bus=dw.i3c.5,pid=0xab9078563412')
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default", "image-bmc"))
 
@@ -69,6 +80,7 @@ def test_arm_ast2600_evb_sdk(self):
         exec_command_and_wait_for_pattern(self,
              '/sbin/hwclock -f /dev/rtc1', year)
         self.do_ast2600_pcie_test()
+        self.do_ast2600_i3c_test()
 
 
 if __name__ == '__main__':
-- 
2.53.0


