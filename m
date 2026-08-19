Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DB3C5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwiA4-00060x-7h; Wed, 19 Aug 2026 11:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9y-0005wD-6k; Wed, 19 Aug 2026 11:24:59 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1wwi9v-0005nK-QJ; Wed, 19 Aug 2026 11:24:57 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB0C443876;
 Wed, 19 Aug 2026 15:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C051F000E9;
 Wed, 19 Aug 2026 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787153093;
 bh=HM693KI6NDehBscoX7RDjmC7+M+rGxWmkVW9+Tj4ayI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=cNGM3piFuR0umJjlp42AzVGZ6TXeVpsEc/GMoSpF/zTfLd42F2znZ1epKuhYSZEQS
 kWYADTMsbVY8BJJCSpzVouEdX6hTVuNhmgeFmWcUJ4K6CVL0AgbQxl22VDTW4sRRYH
 GhLZxOF5Fei27fWeciiy6hjqJRFrW/MFLcdEJlKbuGpzXP2W7Vn3evhf7rly+ksWv8
 eDjeooAQzv01UY/uRFwQJXHD+QeLPVducMRpq/XdJvZZMRxZtP+4Xgn5x6wdHYxjPl
 uakYufIMAKZdUoX4XBy1kGf+A6MHls3hdhrjS8fTapHXQBIM9LWFVFMGs5cUZGSYCg
 VqlMBGpHnklag==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Wed, 19 Aug 2026 17:24:07 +0200
Subject: [PATCH v2 5/7] hw/nvme: clamp mdts and zasl shifts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-align-nvme-mdts-with-linux-v2-5-351ac2dfed64@samsung.com>
References: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
In-Reply-To: <20260819-align-nvme-mdts-with-linux-v2-0-351ac2dfed64@samsung.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Daniel Gomez <da.gomez@kernel.org>, 
 Daniel Gomez <da.gomez@samsung.com>, GOST <gost.dev@samsung.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787153075; l=1822;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=V8UXJ/HAjuXyOpqBOxXDYTuhV7TkWdT24ek2q3pDRAk=;
 b=UawG5kWO63oWGJZfmSwlzDyyQ/T7VDMJamBmKHT5QR2u+40y/qS4wLSSlYdlUaNjvUcTYhjEd
 FXIoIZ4NJvaBy9rNxBpduu+aKYSUz4VxuOVdAZvGkpEx03PcjTX6dyl
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=172.234.252.31; envelope-from=da.gomez@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Once dma_blk_cb() chunks at IOV_MAX, a later patch drops the current
mdts 2 MiB cap, allowing mdts (and zasl, which may be as large as mdts)
to essentially be 32 or more. Ensure shifting doesn't go out of range
by adding a static inline helper that clamps to UINT64_MAX when mdts or
zasl shift operations exceed uint64_t width.

Fixes error with ubsan enabled and large mdts:
../hw/nvme/ctrl.c:1685:36: runtime error: shift exponent 32 is too large
for 32-bit type 'unsigned int'

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4893cf7e741..a24a674a4c5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1713,11 +1713,18 @@ static void nvme_clear_events(NvmeCtrl *n, uint8_t event_type)
     }
 }
 
+static inline uint64_t nvme_max_data_transfer_size(NvmeCtrl *n, uint8_t exp)
+{
+    unsigned shift = n->page_bits + exp;
+
+    return shift >= 64 ? UINT64_MAX : 1ULL << shift;
+}
+
 static inline uint16_t nvme_check_mdts(NvmeCtrl *n, size_t len)
 {
     uint8_t mdts = n->params.mdts;
 
-    if (mdts && len > n->page_size << mdts) {
+    if (mdts && len > nvme_max_data_transfer_size(n, mdts)) {
         trace_pci_nvme_err_mdts(len);
         return NVME_INVALID_FIELD | NVME_DNR;
     }
@@ -3809,7 +3816,7 @@ static uint16_t nvme_do_write(NvmeCtrl *n, NvmeRequest *req, bool append,
             }
 
             if (n->params.zasl &&
-                data_size > (uint64_t)n->page_size << n->params.zasl) {
+                data_size > nvme_max_data_transfer_size(n, n->params.zasl)) {
                 trace_pci_nvme_err_zasl(data_size);
                 return NVME_INVALID_FIELD | NVME_DNR;
             }

-- 
2.55.0


