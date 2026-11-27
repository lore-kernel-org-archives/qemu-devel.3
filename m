Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA0606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=ZQ5FYHsC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWpAN-0005wh-Qw; Fri, 27 Nov 2026 01:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8j-00089o-8U; Fri, 27 Nov 2026 01:08:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8g-0000WL-K8; Fri, 27 Nov 2026 01:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=+Dph76DD3+P+QAclsgVJOChlhLxoopmwIUv9pU/EGqs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZQ5FYHsCw4rtkdjncnNmb652PWqz77wlH/BbgfnJwLEenVqDh794xg8zBUYT5s07U
 s3ODKAHcCR5xmHbRXwV826zW6sQex6emwg7TgdWmmGhzilRPWZyOnOgdXUSzbFHbCo
 LHZ0RwTBaHTdYqY405/OYxwDNYGi2Yv/oW0YO3jHn4I3J+eNW2Jw68RL01d/cXbFUc
 H3IJfMA13heOR31hbIw85wHwGXoT+HASKBoyOx+nq520z4LOwrE2eVnoEjxrSCpmEX
 w9AOvloM3CSYWWhGhkYR0E0f78Yu+PdmWYAeN4Dm8bYDMwi8SiiS3GySP71KgeXK+j
 Tq5J75MR51jYw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 49FE01EA370;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 47AEE46999B;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2021CCF32E; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 126/152] hw/nvme: fix open zone zrwa allocation
Date: Fri, 27 Nov 2026 08:54:24 +0300
Message-ID: <20261127055709.39630-63-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_zrm_open_flags incorrectly allocates a ZRWA resource regardless of
the zone state. A ZRWA resource shall only be allocated if

    a) there are available ZRWA resources; and
    b) the zone is empty.

Fix the state machine and error out early.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 86d136c48476738ab6831940ee24c1482f8a403d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 10564813273..f7973bbc701 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2037,10 +2037,19 @@ enum {
 static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, int flags)
 {
+    NvmeZoneState state = nvme_get_zone_state(zone);
+
+    bool zrwaa =
+        (flags & NVME_ZRM_ZRWA) && !(zone->d.za & NVME_ZA_ZRWA_VALID);
+
     int act = 0;
     uint16_t status;
 
-    switch (nvme_get_zone_state(zone)) {
+    if (zrwaa && state != NVME_ZONE_STATE_EMPTY) {
+        return NVME_INVALID_ZONE_OP | NVME_DNR;
+    }
+
+    switch (state) {
     case NVME_ZONE_STATE_EMPTY:
         act = 1;
 
@@ -2050,8 +2059,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         if (n->params.auto_transition_zones) {
             nvme_zrm_auto_transition_zone(ns);
         }
-        status = nvme_zns_check_resources(ns, act, 1,
-                                          (flags & NVME_ZRM_ZRWA) ? 1 : 0);
+        status = nvme_zns_check_resources(ns, act, 1, zrwaa);
         if (status) {
             return status;
         }
@@ -2079,7 +2087,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         /* fallthrough */
 
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        if (flags & NVME_ZRM_ZRWA) {
+        if (zrwaa) {
             ns->zns.numzrwa--;
 
             zone->d.za |= NVME_ZA_ZRWA_VALID;
-- 
2.47.3


