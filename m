Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38493CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 09:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ullVf-00084f-DZ; Tue, 12 Aug 2025 05:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullVd-00082g-UK; Tue, 12 Aug 2025 05:41:33 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1ullVa-0000lv-UW; Tue, 12 Aug 2025 05:41:33 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 12 Aug
 2025 17:40:16 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 12 Aug 2025 17:40:16 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <troy_lee@aspeedtech.com>, Kane-Chen-AS <kane_chen@aspeedtech.com>
Subject: [PATCH v5 10/10] docs/system/arm/aspeed: Document OTP memory options
Date: Tue, 12 Aug 2025 17:40:07 +0800
Message-ID: <20250812094011.2617526-11-kane_chen@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=kane_chen@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Kane Chen <kane_chen@aspeedtech.com>
From:  Kane Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kane-Chen-AS <kane_chen@aspeedtech.com>

Add documentation for the OTP memory module used by AST2600 and AST1030
SoCs, and describe options for using a pre-generated image or an
internal buffer. Include example commands for configuration and image
generation.

Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
---
 docs/system/arm/aspeed.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index bf18c56347..6317c0e910 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -243,6 +243,37 @@ under Linux), use :
 
   -M ast2500-evb,bmc-console=uart3
 
+OTP Option
+^^^^^^^^^^
+
+Both the AST2600 and AST1030 chips use the same One Time Programmable
+(OTP) memory module, which is utilized for configuration, key storage,
+and storing user-programmable data. This OTP memory module is managed
+by the Secure Boot Controller (SBC). The following options can be
+specified or omitted based on your needs.
+
+  * When the options are specified, the pre-generated configuration
+    file will be used as the OTP memory storage.
+
+  * When the options are omitted, an internal memory buffer will be
+    used to store the OTP memory data.
+
+.. code-block:: bash
+
+  -blockdev driver=file,filename=otpmem.img,node-name=otp \
+  -global aspeed-otp.drive=otp \
+
+The following bash command can be used to generate a default
+configuration file for OTP memory:
+
+.. code-block:: bash
+
+  if [ ! -f otpmem.img ]; then
+    for i in $(seq 1 2048); do
+      printf '\x00\x00\x00\x00\xff\xff\xff\xff'
+    done > otpmem.img
+  fi
+
 Aspeed 2700 family boards (``ast2700-evb``)
 ==================================================================
 
-- 
2.43.0


