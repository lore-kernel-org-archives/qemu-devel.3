Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920A9C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMT-0002q6-Rx; Mon, 22 Jul 2024 00:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMO-0002bW-Ne
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:17 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMM-0001tO-KY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621355; x=1753157355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YCrC8JJcGzGageWxlfj5NoWgHUEu+F7i677Gb/aAwpI=;
 b=i6E7JRWflIYA7f7Ngu3j0kgsWDpiukkrutYHXXC2sqg/htyHt8xzTU+1
 D81WW/0naEl4CV4QTRNdWmXF5JLA80yF8Hqb54cAKRc9a84aVBP2iDyi+
 MvRXVLSM/E/fikEQf6ZwU9X6EsX93igh4YzCasqUOPB7FDr8WLwdJ7Waq
 9Iq61Caq/9R1KEZW+BIibgKMioVG7a3l19qqpKCT/d4DxcuZs4kMpSn+A
 W89DS+J3pjzrD4rcGxCvyjmNtz53JHZfp2xuYDuRWlLvzVWBL1vmM0jRP
 csWe7JXzyvIPSowEaeC52QgOorMGEWQ3pzi0/QVm4/PFXxlj9MQdUQ3zv g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="169998077"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="169998077"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:14 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 06D69C68E2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 45F9ED5085
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:10 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C5D2820076D0D
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:09 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 529F81A000A;
 Mon, 22 Jul 2024 12:09:09 +0800 (CST)
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 03/13] core/loader: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:32 -0400
Message-ID: <20240722040742.11513-4-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10-3.619200-10.000000
X-TMASE-MatchedRID: aX2W24vmfqtrFdvBEmTnvE7nLUqYrlslFIuBIWrdOeOcbyawsiRjd6PF
 jJEFr+olAmPpbGBYlhvkwjHXXC/4I8ZW5ai5WKlygW5PvEaGA6Yn0KAVDcV68t64DZDbEIQS8dq
 RFpgLKwiJztRg9U5K6c4klx51aoIoe4ziUfDZ/rr1KF0d0T7BDIk8hr35r8xREWW0bEJOTAVAdU
 D6vW8Z1mZAMQMIyK6zB8/x9JIi8hKhgLRzA45JPQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=68.232.139.139;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa6.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 hw/core/loader.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index 31593a117171..dac0df561b16 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -63,6 +63,7 @@
 #include "qemu/cutils.h"
 #include "sysemu/runstate.h"
 #include "tcg/debuginfo.h"
+#include "qemu/range.h"
 
 #include <zlib.h>
 
@@ -1278,7 +1279,8 @@ static bool roms_overlap(Rom *last_rom, Rom *this_rom)
         return false;
     }
     return last_rom->as == this_rom->as &&
-        last_rom->addr + last_rom->romsize > this_rom->addr;
+        ranges_overlap(last_rom->addr, last_rom->romsize,
+                       this_rom->addr, this_rom->romsize);
 }
 
 static const char *rom_as_name(Rom *rom)
-- 
2.41.0


