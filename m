Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FB606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=FOT+p3Tl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWozv-0008CZ-7F; Fri, 27 Nov 2026 00:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozr-0007tx-Lb; Fri, 27 Nov 2026 00:59:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWozp-0002uU-CQ; Fri, 27 Nov 2026 00:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758878; bh=LxwHlDsfFiU0ANedGvN5oBIfbjazLqV9sd8ZDPpcFqk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FOT+p3Tll6ZwycGaG22p1XgygOHk/iXP1G1ettQCmGEWQLMOT7DtrkNuWupT0M8QP
 m5vShYU7xaODv2E1kKpX3fCw7svU+p98NSa3L80JLs1ksyN2i7bxkMOJyWrL/udzXw
 wjRGX6RJ8K3mOPu3vlCeerDAdo4Q8Nx8FNVln3kqT3K56bskbyEIyTZQrOznNtOAtA
 jrtEGca+zZMfdhsvxhj9bKeegQnQT5qNc7Jx6SvrnmoAMhE+mgMflBvBOqeiGrcjCz
 FAkrj+w3L+vm+bDhvLxrATe8m5tk/TeOYUKjejDwBkxZwcKDm6xBiySzU31Hy1v87g
 u8PyIdruY+KxA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 044401EA2FC;
 Fri, 27 Nov 2026 08:54:38 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 021CE469937;
 Fri, 27 Nov 2026 08:54:38 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C499ACF27A; Fri, 27 Nov 2026 08:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 114/140] hw/nvme: fix open zone zrwa allocation
Date: Fri, 27 Nov 2026 08:53:40 +0300
Message-ID: <20261127055421.39015-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
index c01900a8cad..e77d18809cc 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2017,10 +2017,19 @@ enum {
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
 
@@ -2030,8 +2039,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         if (n->params.auto_transition_zones) {
             nvme_zrm_auto_transition_zone(ns);
         }
-        status = nvme_zns_check_resources(ns, act, 1,
-                                          (flags & NVME_ZRM_ZRWA) ? 1 : 0);
+        status = nvme_zns_check_resources(ns, act, 1, zrwaa);
         if (status) {
             return status;
         }
@@ -2059,7 +2067,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         /* fallthrough */
 
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        if (flags & NVME_ZRM_ZRWA) {
+        if (zrwaa) {
             ns->zns.numzrwa--;
 
             zone->d.za |= NVME_ZA_ZRWA_VALID;
-- 
2.47.3


