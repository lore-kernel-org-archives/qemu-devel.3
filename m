Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFA5CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 12:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwSO-0006T9-Ba; Fri, 29 May 2026 08:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSL-0006Sr-3O; Fri, 29 May 2026 08:36:53 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wSwSJ-00031C-Eq; Fri, 29 May 2026 08:36:52 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9188C42B8A;
 Fri, 29 May 2026 12:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6E71F00893;
 Fri, 29 May 2026 12:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780058209;
 bh=dTgtZJYkbw9Dxl5/Ovcn0CYfHPf3JZL7gwLv4z0RU+I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eWxTY4eejRltuNtns1XrkbHCqhlZQdOPKoVutTZHDLY/guey3hAFjkAoYBURhyn0M
 I1UykN0kKffoBdjoCZI6BCstD4mL7+uE+h+OfhMByBPUrxXoBn11tow++g9pCqDqJ+
 8p9v66x6EUJzzDxEWVXx+kdLmyfGfCHXWyrd83eQAetvIOI3KA5doAmL+mNHmHOKlG
 ktqRnVnKxxHBobVWWiaj3mY10YzLLLSe4VS/8mtRUXVp6czqHF3Dx4iNdeZBwbSlag
 vN8TFZS7g6xkIujPLT0uIkIdv3RWjr64FdvLxAuXCPuLbVaJsnLewWzCALwDNa039j
 JwVNVFd91f7Ow==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Fri, 29 May 2026 14:36:15 +0200
Subject: [PATCH 3/3] hw/nvme: allow mdts up to 8192 KiB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-align-nvme-mdts-with-linux-v1-3-221d4d21ab43@samsung.com>
References: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
In-Reply-To: <20260529-align-nvme-mdts-with-linux-v1-0-221d4d21ab43@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780058199; l=2311;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=960pdnVnwcQY0HoV2wasXfG55Ann+JslDud+rCzOWuc=;
 b=4w9DnUh6eDzRhYXlZX+729kaBVRl5WCtZ/0BOQx2PxWr0g0ooQMaZbl/KgH/IGB3ox3J0oBIx
 RUUX4TCgKGbDlEwmBY5b0dPVCe6H9yR2hUPxFg8gMFqcxd6efCHs+jT
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.234.252.31; envelope-from=da.gomez@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Gomez <da.gomez@samsung.com>

Commit 53493c1f83 ("hw/nvme: cap MDTS value for internal limitation")
capped MDTS so the worst-case PRP count would fit in IOV_MAX, leaving
transfers limited to 2 MiB.

Now that dma_blk_cb() can batch IOs up to IOV_MAX instead of limiting
to IOV_MAX, raise the limit via a new NVME_MDTS_MAX = 11 (i.e. 8 MiB) to
match Linux's NVME_MAX_BYTES.

Per spec, MDTS=0 means "that there is no maximum data transfer
size". With the dma_blk_cb() changes, we can potentionally honor
that literally, however Linux host driver will clamp requests at
NVME_MAX_BYTES regardless of the advertised MDTS. Coerce mdts=0 to
NVME_MDTS_MAX so the value the guest sees matches the current Linux
ceiling and document it.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 00995d9808f..123f969cc03 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -104,6 +104,9 @@
  *   as a power of two (2^n) and is in units of the minimum memory page size
  *   (CAP.MPSMIN). The default value is 7 (i.e. 512 KiB).
  *
+ *   NOTE: A value of 0 means "that there is no maximum data transfer size" per
+ *   spec, but here it is coerced to 11 (i.e. 8 MiB).
+ *
  * - `vsl`
  *   Indicates the maximum data size limit for the Verify command. Like `mdts`,
  *   this value is specified as a power of two (2^n) and is in units of the
@@ -226,6 +229,7 @@
 #define NVME_VF_RES_GRANULARITY 1
 #define NVME_VF_OFFSET 0x1
 #define NVME_VF_STRIDE 1
+#define NVME_MDTS_MAX 11
 
 #define NVME_GUEST_ERR(trace, fmt, ...) \
     do { \
@@ -8624,10 +8628,13 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
 
-    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
-        error_setg(errp, "mdts exceeds IOV_MAX");
+    if (n->params.mdts > NVME_MDTS_MAX) {
+        error_setg(errp, "mdts must be in [0, %u]", NVME_MDTS_MAX);
         return false;
     }
+    if (n->params.mdts == 0) {
+        n->params.mdts = NVME_MDTS_MAX;
+    }
 
     if (n->params.zasl > n->params.mdts) {
         error_setg(errp, "zoned.zasl (Zone Append Size Limit) must be less "

-- 
2.53.0


