Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A26C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMb-000371-V1; Mon, 22 Jul 2024 00:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkML-0002X6-Jw; Mon, 22 Jul 2024 00:09:14 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMK-0001tO-0R; Mon, 22 Jul 2024 00:09:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621352; x=1753157352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ThRdQS8GfgTXHrFzjsZjoCSjLl0BRfNH9DOAJNL1M4g=;
 b=ipnpYfD+Cvq0ZnWGxy8uNNWFuf/DsBcSxHbuveNK2X7APWiDNhbFOXzg
 uyr3VobUmANzwC/smE7wXhrGe/BwsgFlqhnuiHvrZ/fxBbh3ICLYGpqN6
 sxyqaN0pUCExhVPpG/QkL9lrLyztYUS5lJg04cZycByFz6TnOEdE7ZPiA
 +GLsKZPveg1Bt7VfTlH9JIdcVrR/pB5ERNXUjd7fq0VYqbnG9tph3IzUl
 c7PGBk+ckCHodZDyTf6jTl9KMY3ZGtXl3B6eC+wKhNg7A3mS/kuLSlcCG
 DBhMZmZ46Ek1AOyV7PS3qO5b0hMmVjIwe4xFvChP2K7RkpYxrrQpXbEBi w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="169998063"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="169998063"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:09 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 81FC6C13CD;
 Mon, 22 Jul 2024 13:09:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 49B1ED7494;
 Mon, 22 Jul 2024 13:09:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id D9A966BEE3;
 Mon, 22 Jul 2024 13:09:02 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 5AFDF1A000A;
 Mon, 22 Jul 2024 12:09:02 +0800 (CST)
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	qemu-arm@nongnu.org
Subject: [PATCH 02/13] arm/boot: make range overlap check more readable
Date: Mon, 22 Jul 2024 00:07:31 -0400
Message-ID: <20240722040742.11513-3-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.004
X-TMASE-Result: 10-2.602800-10.000000
X-TMASE-MatchedRID: 79qQreYAxVdrFdvBEmTnvKekGZXOwUBuwTlc9CcHMZerwqxtE531VNnf
 JrUSEbFDcfrBpTCbnFHQ1eGkfrkoDhNSYeRE3U64ueYB1mSXzr/QxDD776KHL3O+fW3rC5pr4nP
 T8jZv1NHi8zVgXoAltuJ5hXsnxp7jC24oEZ6SpSmcfuxsiY4QFEefxKz+lqKeRBH8Txz8pnTjZH
 4udmlbmJ1nGLbWF2Mf/I2DASliqu9RQEieGkuV+JuQqgIFLrgWXoVg+nWV3m2MQipNdyIFc5sNE
 GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
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
 hw/arm/boot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d480a7da02cf..a004a90e87be 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "qemu/range.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
@@ -238,8 +239,8 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
     assert((mvbar_addr & 0x1f) == 0 && (mvbar_addr >> 4) < 0x100);
 
     /* check that these blobs don't overlap */
-    assert((mvbar_addr + sizeof(mvbar_blob) <= info->board_setup_addr)
-          || (info->board_setup_addr + sizeof(board_setup_blob) <= mvbar_addr));
+    assert(!ranges_overlap(mvbar_addr, sizeof(mvbar_blob),
+           info->board_setup_addr, sizeof(board_setup_blob)));
 
     for (n = 0; n < ARRAY_SIZE(mvbar_blob); n++) {
         mvbar_blob[n] = tswap32(mvbar_blob[n]);
-- 
2.41.0


