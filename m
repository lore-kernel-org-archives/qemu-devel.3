Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865C2C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jx-0002xw-G1; Wed, 12 Aug 2026 09:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8if-0008QD-W6; Wed, 12 Aug 2026 09:10:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ie-0005pe-BC; Wed, 12 Aug 2026 09:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=f93CzPsPEonZ4DHwNIIApvLavRQB8Sws2YGHdrp5lgs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VQehN6SgBaWeeaY3Z5NxHVOP5FGo79Te932xEefOgap9oaaNgL+kvYTtY9v250C2S
 ufFKVVGzL4WU7NjTDbfBgedbysYqXpJsAjSA8NahiZJPQ3dpHJ50/TToLrjmYD7HOQ
 sO5Z5OIBGnxr7kEJ8/gtB6qtnWnsy7LGuB+mk/Aj1Y7GAylXabi7LOfWukOkttVrMY
 SXSYlnYSXqEs1F2Y08N9GoO9/Mdli8NU84ZH/jNCZOJqxfqw3sa3dZvUEuzYm/nsO4
 yxeAi+vEB2uOjieFYaWQCsRlgFTtdmO5sqrLPg/NteAwMIVoCowQHrcdnX7LEFQIXv
 3yV+J6efk2EUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65C7C1CA4C8;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9BAE6409BAB;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8DC672F926; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 073/102] hw/nvme: fix unintentional integer overflow
 in shift
Date: Wed, 12 Aug 2026 16:01:48 +0300
Message-ID: <20260812130233.621965-73-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Fix potentially overflowing shift operation.

Cc: qemu-stable@nongnu.org
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Resolves: Coverity CID 1663674
Fixes: ec917cd49918 ("hw/nvme: fix FDP set FDP events")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit c39e05af439a3a2bd58a847fc30d7eb590fcf61e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 258ad5f38ec..46f44f28922 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -194,6 +194,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -6538,7 +6539,8 @@ static uint16_t nvme_set_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
         if (!shift && event_type) {
             continue;
         }
-        event_mask |= (1 << nvme_fdp_evf_shifts[events[i]]);
+        event_mask =
+            deposit64(event_mask, nvme_fdp_evf_shifts[events[i]], 1, 1);
     }
 
     if (enable) {
-- 
2.47.3


