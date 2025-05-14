Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03631C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 08:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7UN-0007L2-Lz; Wed, 14 May 2025 04:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UL-0007GH-BP; Wed, 14 May 2025 04:29:17 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uF7UJ-0006JJ-Gq; Wed, 14 May 2025 04:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747211356; x=1778747356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hPcHhjioLQi9o5CfHROpDsHKTCLxyOFvAINFhZm1c1U=;
 b=eMsEUjqg1tIjmP1VeDJqjNBTxTS6EvLOwwoXvAKITMZxtWQKTZrVLESu
 Q3zqMFnEZKwmcOAacbyjoFiGtzfTZfxCdwSqSBE0lalgHk92rSlq74Mj3
 6fvsdGbiq4+yIixHATKn8ml9rbrgKKQez/2wDEFupVgl5OaN/eSnWE0AP
 gpSknPIn6TzJwTsEEf1MjlaCTTD7vKKdcHrT48DCn/xNLiv8q8XzVgUbc
 hINYaSHionKzOQX0eeP3XSuDnFY4HF/ENJ7Je5JHxB9OxUPSZlYlOWvJ0
 bXW35lodZwfTyJr+odiB9e1Qi2XeoJ9uknGCAJXi+Z+Jm5Y6TDL7/fdhd w==;
X-CSE-ConnectionGUID: +NtvBDPZTICnwXgc9oVbkQ==
X-CSE-MsgGUID: 8b2T3Xo/QSuO+D+UH90HjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="66505619"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="66505619"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2025 01:29:14 -0700
X-CSE-ConnectionGUID: /ESUO+fYQ/2NT8TKhEjvxg==
X-CSE-MsgGUID: Wo9EQtm8QFqpNNMdIaFjEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; d="scan'208";a="169065857"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 14 May 2025 01:29:11 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 9/9] ui/console-vc: Consolidate OBJECT_DEFINE_SIMPLE_TYPE
Date: Wed, 14 May 2025 16:49:57 +0800
Message-Id: <20250514084957.2221975-10-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514084957.2221975-1-zhao1.liu@intel.com>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The QOM types of QemuTextConsole and QemuFixedTextConsole are declared
by OBJECT_DECLARE_SIMPLE_TYPE, which means they don't need the class!

Therefore, use OBJECT_DEFINE_SIMPLE_TYPE to implement the type, then
there's no need for class definition.

Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 ui/console-vc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 830842064d69..1b2c6951c275 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -70,17 +70,19 @@ typedef struct QemuTextConsole {
     Fifo8 out_fifo;
 } QemuTextConsole;
 
-typedef QemuConsoleClass QemuTextConsoleClass;
-
-OBJECT_DEFINE_TYPE(QemuTextConsole, qemu_text_console, QEMU_TEXT_CONSOLE, QEMU_CONSOLE)
+OBJECT_DEFINE_SIMPLE_TYPE(QemuTextConsole,
+                          qemu_text_console,
+                          QEMU_TEXT_CONSOLE,
+                          QEMU_CONSOLE)
 
 typedef struct QemuFixedTextConsole {
     QemuTextConsole parent;
 } QemuFixedTextConsole;
 
-typedef QemuTextConsoleClass QemuFixedTextConsoleClass;
-
-OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEXT_CONSOLE, QEMU_TEXT_CONSOLE)
+OBJECT_DEFINE_SIMPLE_TYPE(QemuFixedTextConsole,
+                          qemu_fixed_text_console,
+                          QEMU_FIXED_TEXT_CONSOLE,
+                          QEMU_TEXT_CONSOLE)
 
 struct VCChardev {
     Chardev parent;
-- 
2.34.1


