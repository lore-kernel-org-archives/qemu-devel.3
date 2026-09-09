Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37717C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4NDj-0007jH-Qz; Wed, 09 Sep 2026 14:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NC4-0006Ap-89; Wed, 09 Sep 2026 14:38:55 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1x4NBx-00074r-Tz; Wed, 09 Sep 2026 14:38:44 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5318B600CB;
 Wed,  9 Sep 2026 18:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB0E1F000FF;
 Wed,  9 Sep 2026 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788979120;
 bh=Xob8NsqOBoZjbWo1s35N0zCmHyuwjpWh2O9NS/qcXvw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IdvgT66PBvfb9XHYtzwZej45S+HvUabnbFCwZn8eVVv1RSUT7Ne6hgoAxX7NOrX9t
 nE5hJAde+rD9TaaBhflNL0pxI8g4Cl1Ci64ph9gNkozMrigqu1rRGJKgwDGT9VPAvE
 SocEcSKuS6aS0An/uoJj9PcFkEZGL3oLR1j10m3j55pZWdNafNQQIZLj2OEFUd1FqW
 606oZQRKlQSZ0Du6+147w4iUG7rK1/xsVInURIlc/SqbXIVp0zAC8/5aUeBd6T1llG
 ctyw3xIwOKZLykbRP/gVOXxFk9ERU1OpqDEPzDfm+BCP9c0PUlI3HAHLWCrDvYrEd7
 4IOFCTaBIXF1A==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 09 Sep 2026 20:36:56 +0200
Subject: [PATCH v3 7/7] hw/nvme: cap mdts for CMB/PMR-only
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-align-nvme-mdts-with-linux-v3-7-1cee970cc8c8@samsung.com>
References: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
In-Reply-To: <20260909-align-nvme-mdts-with-linux-v3-0-1cee970cc8c8@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788979097; l=1786;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=HkTv7Vn4/V7k/VYyPKeIRujrQm0Dbp94qHpsEZy05w0=;
 b=dZEU4leYyoL2VJ+G92oQbeIoEZuk53S+C07P0DXnguEAvxbZcPArna8hRsTnMruiSoSGDHG0y
 a3BwF5x0EPbBcKt3pIURI9QJEyWoI/mV34WS07Brg8yOWy6fcR5ieJg
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
to IOV_MAX, remove it, except for CMB/PMR-only where the limit still
applies.

In addition, fix UB when mdts >= 31 by calculating the worst-case iovec
count with a width-bounded shift helper. Fixes error with ubsan:
    ../hw/nvme/ctrl.c:8638:33: runtime error: shift exponent 32 is too
    large for 32-bit type 'int'

Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 7861d8f2521..f219bf524dd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8720,6 +8720,11 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
+static inline uint64_t nvme_mdts_max_iovs(uint8_t mdts)
+{
+    return mdts >= 64 ? UINT64_MAX : (1ULL << mdts) + 1;
+}
+
 static bool nvme_check_params(NvmeCtrl *n, Error **errp)
 {
     NvmeParams *params = &n->params;
@@ -8802,8 +8807,9 @@ static bool nvme_check_params(NvmeCtrl *n, Error **errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
 
-    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
-        error_setg(errp, "mdts exceeds IOV_MAX");
+    if ((params->cmb_size_mb || n->pmr.dev) &&
+        (!params->mdts || nvme_mdts_max_iovs(params->mdts) > IOV_MAX)) {
+        error_setg(errp, "mdts=%u is incompatible with CMB/PMR", params->mdts);
         return false;
     }
 

-- 
2.55.0


