Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE44CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 11:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy7Nn-0001Sv-Uc; Mon, 15 Sep 2025 07:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeff@altlinux.org>) id 1uy7Na-0001Qp-8H
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:28:21 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zeff@altlinux.org>) id 1uy7NR-0000YA-RH
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 07:28:17 -0400
Received: from happy.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
 (Authenticated sender: sergeevdv)
 by air.basealt.ru (Postfix) with ESMTPSA id 8B42C23382;
 Mon, 15 Sep 2025 14:27:59 +0300 (MSK)
From: Denis Sergeev <zeff@altlinux.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org, zeff@altlinux.org
Subject: [PATCH] contrib/plugins/hwprofile: use BIT_ULL() for CPU mask,
 avoid UB shift
Date: Mon, 15 Sep 2025 14:27:03 +0300
Message-ID: <20250915112722.50169-1-zeff@altlinux.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=zeff@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

(1 << cpu_index) promotes 1 to int and can trigger undefined behavior on
32-bit ints when cpu_index >= 31. Static analyzers also flag this as a
potential overflow.

cpu_read/cpu_write are 64-bit bitmasks, so use BIT_ULL(cpu_index) from
qemu/bitops.h to construct the mask explicitly as 1ULL<<cpu_index.
This preserves the existing 64-bit semantics and removes the UB.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Denis Sergeev <zeff@altlinux.org>
---
 contrib/plugins/hwprofile.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/hwprofile.c b/contrib/plugins/hwprofile.c
index a9838ccc87..7a470bbfd9 100644
--- a/contrib/plugins/hwprofile.c
+++ b/contrib/plugins/hwprofile.c
@@ -17,6 +17,7 @@
 #include <glib.h>
 
 #include <qemu-plugin.h>
+#include "qemu/bitops.h"
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
@@ -187,10 +188,10 @@ static void inc_count(IOCounts *count, bool is_write, unsigned int cpu_index)
 {
     if (is_write) {
         count->writes++;
-        count->cpu_write |= (1 << cpu_index);
+        count->cpu_write |= BIT_ULL(cpu_index);
     } else {
         count->reads++;
-        count->cpu_read |= (1 << cpu_index);
+        count->cpu_read |= BIT_ULL(cpu_index);
     }
 }
 
-- 
2.50.1


