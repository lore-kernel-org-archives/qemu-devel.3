Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43F1C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 13:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh6gY-0006iK-Sl; Wed, 30 Jul 2025 09:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0Wd-0002iY-VS
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:56 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0Wa-00042p-FZ
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2TAQ452hADL4KZO9AV0cQRaqxgV6RuvFxhbslKH2018=; b=MzJ6ClwcVvX2L1c2DCDqFHbPZ9
 qlOZ35wGCn7bvILpUSx8XiG9DMnbuaojH9BFn/bWuhGIuvMtbCmN1kuL3TuOZ63dlMo/Kc7KL8YAu
 3AyadBnPsoHnC+idzoYLxEDZ97DX0GDFVAP0xLCwrRux8Iu0ZpSWOOYMcXaz5CKZwyV1Q+gbKBEX0
 1XvVGz+B9rIk5WDtJsfAWax0asr2biP5MVGB3G4kW/Foy9xwYut5qMGcOYHrSTP8uIsWr3bt7mkJ6
 ePEEg0lg+G3X9H9FgWQ/2hEVAt7od8BO0hiGlAISdVzWY+nKwQPIyYgjPy5+oPTNVUnzmNvS1U83L
 FfO4Y4lw==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uh0WQ-005nOk-1C; Wed, 30 Jul 2025 08:42:42 +0200
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH 4/5] docs/about/emulation: Add documentation for hotblocks
 plugin arguments
Date: Wed, 30 Jul 2025 07:41:42 +0100
Message-ID: <35128cc5a86a0c18418f9d3150fb8771c54ef7d8.1753857212.git.asb@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753857212.git.asb@igalia.com>
References: <cover.1753857212.git.asb@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Jul 2025 09:05:40 -0400
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

Currently just 'inline'.

Signed-off-by: Alex Bradbury <asb@igalia.com>
---
 docs/about/emulation.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 456d01d5b0..9c963f4705 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -463,6 +463,16 @@ Example::
   0x000000004002b0, 1, 4, 66087
   ...
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Hot Blocks plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
 
 Hot Pages
 .........
-- 
2.50.1


