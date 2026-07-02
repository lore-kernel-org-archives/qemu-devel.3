Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B96DC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKXg-000359-Sa; Thu, 02 Jul 2026 12:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKXe-00034M-ST; Thu, 02 Jul 2026 12:45:34 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wfKXc-0003UH-VL; Thu, 02 Jul 2026 12:45:34 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9F8212003C6;
 Thu,  2 Jul 2026 18:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783010731;
 bh=4MrAaUdT5FZE2wruIVBvwInZwOlQQccL6jwwutryqm0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aesZ4XiKf1lpz0ze95jkO7xVCQOnFAQzbmbGCK0cUugMVnHRzOVPAlF842b482IO6
 EzsuJkdDpP+HY6IOKuzteWqy/yuW6oUJ1AUlUynRGUpUO0aHDYK4in/GH6s8Yh1aoV
 5OAWgerye5Ksk2DeVUAky4e2gfx9xwaQMth77zPareJllVuXOa5G6xrecU83qUI/4A
 GpK5vljG47HAsUS1rsykiBrcGZEFbQ+al0fWHwCjS/7g+CjfTk4ZETG7ycs7I4KQWp
 eRv0us+c9mctCG7qM40B/peGHWpdXIWf0mjTIPqXGH4oQzuU0uvJ7ynWRZa7Wc5pjF
 8+lNmQdh/ReGA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 02 Jul 2026 18:44:30 +0200
Subject: [PATCH 3/4] tests/functional: aspeed: optionally check the device
 tree model on boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sanmiguel-bmc-v1-3-b176b840aee3@free.fr>
References: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
In-Reply-To: <20260702-sanmiguel-bmc-v1-0-b176b840aee3@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 qemu-arm@nongnu.org, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010682; l=1675;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=4MrAaUdT5FZE2wruIVBvwInZwOlQQccL6jwwutryqm0=;
 b=3EfoCAatETGhtZ/Paog3YuBDCi7smSwrZL8f7xUwheV2XB06NkJhI8gOMb64T2DAzVTJ2ZPf3
 HxP3+hGTVAMDpogcuuh32NW2kksYKb/DAbtbasYnCXNZX9WX3s6wOQb
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add an optional 'dt_model' argument to do_test_arm_aspeed_openbmc(). When
provided, the helper also waits for the kernel's "Machine model: ..." line,
letting a test confirm the booted image actually matches the expected board
device tree rather than only the SoC revision.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/aspeed.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 88b6590934..57e224999f 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -9,7 +9,7 @@ class AspeedTest(LinuxKernelTest):
 
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
                                    cpu_id='0x0', soc='AST2500 rev A1',
-                                   image_hostname=None):
+                                   image_hostname=None, dt_model=None):
         # Allow for the image hostname to not end in "-bmc"
         if image_hostname is not None:
             hostname = image_hostname
@@ -26,6 +26,8 @@ def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
         self.wait_for_console_pattern('## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
         self.wait_for_console_pattern(f'Booting Linux on physical CPU {cpu_id}')
+        if dt_model:
+            self.wait_for_console_pattern(f'Machine model: {dt_model}')
         self.wait_for_console_pattern(f'ASPEED {soc}')
         self.wait_for_console_pattern('/init as init process')
         self.wait_for_boot_complete(hostname)

-- 
2.50.1


