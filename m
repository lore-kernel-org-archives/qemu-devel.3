Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200BCA5FF0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJd-0006Ox-SP; Sun, 04 Oct 2026 08:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJa-0006NK-Bl
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJY-00075T-6s
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so6537305e9.2
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116855; x=1791721655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L4B5bnHQFyEPgJBdx5DSPHdDW8vW0JVFidXChRaS+LI=;
 b=gjP5wPliWdUpmq1etc7S6fpSgpqwyneu8Af5KFdzTzA1wHOwO4UDdJOvoUZqfuTIXO
 ZzLtkrJ81eEHGVJSOrL0Cvy6V8j86SCaZN5hBCWTDUWZsX1TJ0ldtVhj8wU+kFA0QS4B
 HV8ecILBO+PJ/mOdNyRm6qJEdruYRuH4caq308vlgYBOwcWqhs0ndxS6BhlsHsvG400v
 ZuxnTbBfqLuFipn0sTJnr4nreasEXF1/wfx3haxmS5ydW5K5o/B5UcqGfcNwAD61L6es
 kcooGisEr6o4VPnsKXAHOqUrEHpuiEo3ZI861Jofhgg0j8u6E4099gFZDIcgy94xpg5u
 ja8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116855; x=1791721655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L4B5bnHQFyEPgJBdx5DSPHdDW8vW0JVFidXChRaS+LI=;
 b=We97KvnKbJeUWXuRxXUMV8g3Pk1UT84OJEwyM9eTu8m+63LHLFWwVCnSQdwK3XwOEZ
 Yfb/ptMT4pm0BbdrYDpUBePcMHCLqeQDHUxgOSdaNk/nR4SF330xf4hlrov6YfhdRxz7
 c41nh95tp9Rxyr2txYQX3IbWbdlKwfJcxhtaRsc16mFS4SnZ5F9WmOvH94rV+B/5c3wm
 2n7ltlhHtjTHeDqi97SU3zbpwhoMb26zA+nAezjwptv360LQgiEOlEhmhj1PTACK2ihd
 if0Aipc1HBNyEkpPyLjSHf47JOUCTqfwb9eDOR8Q2fmWXYAf4Ne/TKh6ugYtJikPaEj1
 82RA==
X-Gm-Message-State: AFuF++kIwpVKgdOffPPdLAWzgWsnSbfQDUcyw/4aNvgSlzij8bALducd
 dIZV9O4lH2GC1dHOHXuMHysefRIQ4R4bJnRgNzjxz8Sy3fUyWnfxeG/DhdX/fQ==
X-Gm-Gg: AYBFou3qawvgE/+qhNO+pOLeNtQ1nfYfZ3vyv+rtj1Lz8ZJyqybL8gcrBgRy/OHAQRH
 pdFovtHig0FkyYQoxQlYRcNOVV0hKiQrD9aqMjMUj8Ewyr6ndxid/77rdcTonZLUm3ULoJmTrK2
 YFuNKfX4ua1QE5DimfLMB3Cx9AXWOGhnD2u3yw9mSuGxfFwBuxlz8e25GSxHtqloNwsgRyIW3Am
 LPgLo7CPNOl93lymAYlJTk4NsWKtcAal4YObe1bn7h7kY3skQGmS3eyuESySWH3p9YyHq9aZcGD
 SlainHUkpESK3GMVdDHDdVJdyBhaXLy8dhdI1Po0N/aPHxZBF99vdhDOIvcB2PN8+LKuR9vPBOR
 otnYxx31mzA1iOeeFumFXuah+uJlmQLYNOkvUuIGqH62JKrwcpfVxzMSlG27Dksn+MhCoxXEXgr
 e9IHGB+XqBc/tS3zwiVMyuG3orrRcKqOwMSUg5U2eWeNXghsKfCNv3ivUjg3rALJDxgcRrA8ovI
 fGjRZgUlbLS/LRPDyUemTxFjJCIVIk1FkhrnrUw10Esen9g
X-Received: by 2002:a05:600c:3556:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1680f7447mr80228945e9.20.1791116854774; 
 Sun, 04 Oct 2026 05:27:34 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 02/30] hw/watchdog/wdt_imx2: Clear WDT lock on reset
Date: Sun,  4 Oct 2026 14:26:18 +0200
Message-ID: <20261004122647.3913-3-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The WDT bit gets reset and becomes writeable after power on reset which
imx2_wdt_reset() represents. While the WDT bit in the WCR register
already gets reset, its locked attribute wasn't. Fix this inconsistency
by adding the missing unlock of its locked attribute.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
cc: qemu-stable
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/watchdog/wdt_imx2.h | 2 +-
 hw/watchdog/wdt_imx2.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index ad36b8820d..fc01fc46e7 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -85,7 +85,7 @@ struct IMX2WdtState {
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
     bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
+    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 3283990bbf..dc7751bd5a 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -60,6 +60,7 @@ static void imx2_wdt_reset(DeviceState *dev)
     s->wicr_locked = false;
     s->wcr_locked = false;
     s->wcr_wde_locked = false;
+    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
-- 
2.56.0


