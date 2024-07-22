Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F37C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMp-0004Hc-95; Mon, 22 Jul 2024 00:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMf-0003ZG-OK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:35 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMd-0001uw-9H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 00:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621372; x=1753157372;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3eyeJQCSyvZboVov/rz+7Pynbeobdgv9WyZcGZymbCM=;
 b=NtfXz1EGiPKH5xuJxZW3xm9MJY3UkNnfkp00Is61eIL9h5MsiWJGfSrW
 f9S3GIgq4wtNCqJnvGSWbTTgS6bRbLQbOnHF1Nc3DlyvxULY1uxl9CaYP
 N0orrRUGIraXkOjJPED4LPGR41aC5YoeObfC9VNOHh5CGUweuyGRbH4h5
 1v93XnDQH2bMgLPvn7W0aEiGU7Ye5OaORJsjnEZOjFbnUboZcbzI1rJTf
 ta1kI+Q8yHITcepkryFR3LOOPYQb3QGraXEeoQUvZayxzI/Hj50qjJ7zS
 FHCQccQRGByYw4PTyGMNYolwWKKe8bxKbfCl8NBnUcn8cAeWlyV2xOOZ2 A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="168040033"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="168040033"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:30 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 281CBD46CC
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 68ABBCF7C2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0668120076D0F
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 905F81A000A;
 Mon, 22 Jul 2024 12:09:25 +0800 (CST)
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH 11/13] crypto/block-luks: make range overlap check more
 readable
Date: Mon, 22 Jul 2024 00:07:40 -0400
Message-ID: <20240722040742.11513-12-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10-5.537200-10.000000
X-TMASE-MatchedRID: alxK4aWrxwlrFdvBEmTnvJXi1z8zt1TRwTlc9CcHMZerwqxtE531VIPc
 XuILVCbasWlJXtA6pzily6awGSvbQP+rgDQQ6Eo3ngIgpj8eDcBpkajQR5gb3mn0m688Eo38Kra
 uXd3MZDUOfvaOrdl4gu4Zvr7PIH5ler360JD+IHd5rtcULOTTv2FjtwS2QCHaObxhn2yfSebkvG
 Bl1+gWAx5XWBJ6dWGv1duwvC6IliMfwV6sBPR0lg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.47; envelope-from=yaoxt.fnst@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
 crypto/block-luks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 5b777c15d3cd..45347adeeb71 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -33,6 +33,7 @@
 #include "qemu/uuid.h"
 
 #include "qemu/bitmap.h"
+#include "qemu/range.h"
 
 /*
  * Reference for the LUKS format implemented here is
@@ -572,7 +573,7 @@ qcrypto_block_luks_check_header(const QCryptoBlockLUKS *luks,
                                                        header_sectors,
                                                        slot2->stripes);
 
-            if (start1 + len1 > start2 && start2 + len2 > start1) {
+            if (ranges_overlap(start1, len1, start2, len2)) {
                 error_setg(errp,
                            "Keyslots %zu and %zu are overlapping in the header",
                            i, j);
-- 
2.41.0


