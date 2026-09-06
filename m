Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E718C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPL-0005B0-GK; Sun, 06 Sep 2026 13:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPK-00050N-0c
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GPI-0000M4-B2
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2Q434UiBnVyO/40qdBy5Hf/HT2OFG9HiPqWDxG9kBc=;
 b=cio7/WeomCvZ2Lrwb2xbuSOvPvOWXwyxoKVNw33tPzhdMcFs2uX/SNQq7NHOSTax8e7XfV
 WryK69ywJYnCSetQYVLDxLhTJYeZZt6BpNw2Ps3RZeOakmePKIhO1iVid6u1Jd4FxdCrmL
 cH94FlLqLXoS+7aJLl7VJ/ioIrEheqs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-fzPDUctcM_uVILqSUMiDsA-1; Sun,
 06 Sep 2026 13:11:50 -0400
X-MC-Unique: fzPDUctcM_uVILqSUMiDsA-1
X-Mimecast-MFC-AGG-ID: fzPDUctcM_uVILqSUMiDsA_1788714709
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D6C41955BD0; Sun,  6 Sep 2026 17:11:49 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 984F21955F06; Sun,  6 Sep 2026 17:11:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 40/40] tests/functional: aspeed: optionally check the device
 tree model on boot
Date: Sun,  6 Sep 2026 19:10:21 +0200
Message-ID: <20260906171021.26568-41-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Add an optional 'dt_model' argument to do_test_arm_aspeed_openbmc().
When
provided, the helper also waits for the kernel's "Machine model: ..."
line,
letting a test confirm the booted image actually matches the expected
board
device tree rather than only the SoC revision.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-16-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aspeed.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 076da1036cfd..08af6b4839cf 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -8,7 +8,8 @@
 class AspeedTest(LinuxKernelTest):
 
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
-                                   cpu_id='0x0', soc='AST2500 rev A1'):
+                                   cpu_id='0x0', soc='AST2500 rev A1',
+                                   dt_model=None):
         self.set_machine(machine)
         self.vm.set_console()
         self.vm.add_args('-drive', f'file={image},if=mtd,format=raw',
@@ -19,6 +20,8 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
         self.wait_for_console_pattern('## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
         self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
+        if dt_model:
+            self.wait_for_console_pattern(f'Machine model: {dt_model}')
         self.wait_for_console_pattern(f'ASPEED {soc}')
         self.wait_for_console_pattern('/init as init process')
         self.wait_for_boot_complete()
-- 
2.55.0


