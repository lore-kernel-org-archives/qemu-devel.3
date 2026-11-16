Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C20606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=MJGa9QDj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3I0-0007PB-La; Mon, 16 Nov 2026 15:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Hp-0007FF-Qb; Mon, 16 Nov 2026 15:26:47 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ho-0007Fi-82; Mon, 16 Nov 2026 15:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860763; bh=W5Nf+YjLNjybUF/5cgnhH6WXH4RsNccGNwbGh186bXg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MJGa9QDjAv4Vs29TXT4xlrxOIehUr0MEfuPoOUZBwHkrEoSzS4jYn7HF0/wgxlhrF
 toL7Iq5r9r5ShbxShBtcjZO7lAl23qyBtr/qppIiAWu6IEdI8ecIskdfjbGJHDiJSm
 x0SBVh3Qg28DGVRbZ0iwz0GTWwOHuBi742FWBC8/CoYHIIMk2Q2RcmHtsoNkT7uYOw
 RouPKy+7h7HtSAnSCSSAYfYMBZT4nB+bq2e5gMmFOubesdpvYAW1lb4i34XGDoxeMI
 Uw0k0fhjkDqNdedWBeVqA0yFZDL2aczMcuKt94QtkAfBZh2F1ArEEc5xib1TnJyad2
 a4UtKwfo2iakg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C5CB91E719F;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2C5345FBCB;
 Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 85D95B8E5A; Mon, 16 Nov 2026 23:26:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Bin Meng <bin.meng@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 10/63] hw/watchdog/wdt_imx2: Preserve own locked bits
 in WCR
Date: Mon, 16 Nov 2026 23:24:49 +0300
Message-ID: <20261116202554.535325-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bernhard Beschow <shentey@gmail.com>

Apparently there is a typo in the WCR locked bits handling: The locked
values for s->wcr must come from itself rather than from s->wicr, so fix
that. Without it, guests such as u-boot may experience inadvertent
reboots when configuring the WCR register.

Cc: qemu-stable@nongnu.org
Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit c278e6dc1abc4f33c0b9737d47b3b7ae8676e654)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index c83d4107c19..3283990bbf8 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
-            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.47.3


