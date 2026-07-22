Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FB6C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWVq-0005eG-Jd; Wed, 22 Jul 2026 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU4-0001bB-Iu; Wed, 22 Jul 2026 08:55:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWU2-0003PN-FW; Wed, 22 Jul 2026 08:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=OtqzOpBti4ls//IyiM+eWTopy6kTKX+HVKLd93maDr0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NpPo/OOaMSzEOcAMMYFAlvMrEnvBsod9yyMV3dKb+VWSEH/Ds6nZtA8vNvl1FSz92
 e7wr5v0LWEvVHcKyKKmFE7UeC7Goz79Isq+0s2HF1geQ32/dk8ddXsU7Y04RXdccFL
 f/X9CvYDI/TVG1G5PmNB4KiBLX1igOhMlOmQ/oSP2xP8geg6j1dvKtHyLVi1S/QiJA
 sv1OVoJ7AaG1e+Ht4Mb+JU2UtdF2lC9TseSr41e/sqbrhTqeJI1mpaB+XOxFfdHgVT
 yKTK8aj+SRYH3pBDQ8avhSs5qAVP1dfI+DFMF3D0YMSn5QaL1GsZ9fdXU5m3oPcUEK
 qT0M3MnuqseEQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65D431C3B58;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE66C3F37A8;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 01A0117F85; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 123/127] hw/display/qxl: validate monitors_config
 heads[] in phys2virt
Date: Wed, 22 Jul 2026 15:48:48 +0300
Message-ID: <20260722124859.32371-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The qxl_phys2virt() call for guest_monitors_config only validates
sizeof(QXLMonitorsConfig), which covers the fixed header (count and
max_allowed) since commit 8efec0ef8bbc ("hw/display/qxl: Pass requested
buffer size to qxl_phys2virt()"), but not the flexible array member
heads[]. When count == 1, heads[0] is accessed without its memory being
validated, allowing a guest to cause an out-of-bounds read.

Include sizeof(QXLHead) in the size passed to qxl_phys2virt() so that
the first head entry is validated within the guest memory slot, preventing
guest-visible memory reading.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4027
Reported-by: Tristan @TristanInSec
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260715072722.1643289-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 9f436938c52125324e36cf9c13b877aa8aada096)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3d4b5635568..39a860c2468 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -270,7 +270,7 @@ static void qxl_spice_monitors_config_async(PCIQXLDevice *qxl, int replay)
     }
 
     cfg = qxl_phys2virt(qxl, qxl->guest_monitors_config, MEMSLOT_GROUP_GUEST,
-                        sizeof(QXLMonitorsConfig));
+                        sizeof(QXLMonitorsConfig) + sizeof(QXLHead));
     if (cfg != NULL && cfg->count == 1) {
         qxl->guest_primary.resized = 1;
         qxl->guest_head0_width  = cfg->heads[0].width;
-- 
2.47.3


