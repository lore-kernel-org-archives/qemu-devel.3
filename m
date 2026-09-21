Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937AFC982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrW-0006Bz-Qf; Mon, 21 Sep 2026 17:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrH-000654-4u
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:32 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrF-0008Vt-2H
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:30 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so26169165e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027248; x=1790632048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J9CEIaPD2r/78EllzBYWRo7JKzGqzJJ/rogwaGuXtMQ=;
 b=Hq/02M40JOrmfeMScwA38zQGcnVnbvOkCK5skIQGNhkQMlen1kuKDNqIr9SB9M1RWm
 sHsJmrVXxfegUfjhlrmKeMX2ki5KEpPSds8kyjx3IrDLAg7bDKR15/hfC085FhIsHM4G
 qS7+ACko2ubuAGwPhUnOFXg/cRErdL8HMXqYGcaDgBicqpbYyU/bThg80HSFGCcwHskH
 ipwMXJZyFT1eoRXjs5oZPRBq/bGlz+fqTNxJHpdhsUbbteSN8d3jLPUCtr2vznwo5OIC
 2Z/YAHLD2sxuRBeeMd8l04iB3CtTQiCNlNsq5b/bfz7+sB8IEqZa4qE1yWG7Z1UbDYqD
 FVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027248; x=1790632048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J9CEIaPD2r/78EllzBYWRo7JKzGqzJJ/rogwaGuXtMQ=;
 b=1vZOK2FQecOYpRGyqRcyg+BZ89QAXXvr72oXdwTZZMDGK/PnvjNrgylmAs9tKC7/7F
 hKVL79ToKYNV+93hemDSUIbT1ktZkQv+7sjSBEvWJqUdUrWT6ksRglQR8/i0Wholn0eJ
 aBcePPVdNl2yQs1WWcArFjp3pJQPv3NHjF2KDwIil/NJMNNmyP0U/MOFIyaSXkQe6sPJ
 oYIQH71XPr2lDNtRXhla6jFSxzhDqpL6yBF9lGUaDTXIS451CZdyYEjc+b7WclQdQssf
 yM3w8BlHCvIKOd1/Fd9eMEyb+nf1PRubDgU+ZqHKB9JNCcgt8FHfjMF83cxL0WzHeR9e
 WN8A==
X-Gm-Message-State: AFuF++kBrZnps+FDAPVl/Gfm5+GBSFlHN4i1xUmHYvhaFTV2xWdX76DR
 TVoM4NVoTvl6QsQ52z/wuBZKj3NkHJyipax0dz+pMlhDMFi/ZN+HDz00Jj+Mpw==
X-Gm-Gg: AYBFou0go6ueA1hCgJ4medaFmBHIAGkucgmk1YkDjbvO0TmQuH3ShY1ez+0uy2ZLSah
 N160RSPQVpfxv1d0qp+MTnvsQN7qqDiErMAs/aAZg1j8R9LJ01rcR3MpMELfS2YSXW3XEvsfXM9
 DZPHqlD1ayFhBRSZsibCt/a/gaQGIbUqD4hNSe3VRhEBQC+RzcvRbZvhwi18VAGSScn7Tf5emr8
 GvErAKv1zWznKqdLDC0s5eHL07EG3ee0KOetgastpGMtgBrNivl+/VWa0DpHyroXcAK7LczTQxC
 rSmvtBINd0zqrrVDBNaANYcMyXTUXDkfNwYchU5AdLkO5NVfgV62ghHVNAuZTQpucZ3Lk6uT57g
 9iAGwTBt0P0IxmwBwDeS/A2e7Eob/voRdIQbMEJfMlCHIO1HKe4TdKDw9zxUXNUsOuLXBHo+xZg
 QETUXuKnwXKK4ms1vjTtd0wtIWqB5u9gAaVqOz6lW3/NKQ6j0xTxzNi6IrhETtMbZNApCfDwjut
 GMkWjc4CEJ2tw7LyINEYvnqqyNxVr3stTbPF+hypF7EGvzvK05FoCgHEbKeh5HSmFG6YbRg0DvK
 fIk=
X-Received: by 2002:a05:600c:34d0:b0:49c:eb16:9fd with SMTP id
 5b1f17b1804b1-49fc5671650mr169292315e9.3.1790027247683; 
 Mon, 21 Sep 2026 14:47:27 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:27 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 01/42] hw/watchdog/wdt_imx2: Fix handling of write-once WCR
 bits
Date: Mon, 21 Sep 2026 23:46:29 +0200
Message-ID: <20260921214710.29422-2-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
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

Guests such as u-boot may experience inadvertant reboots when configuring
the WCR register. Apparently there is a typo in the WCR locked bits
handling: The locked values for s->wcr must come from itself rather than
from s->wicr. While at it remove the redundant locked attributes for the
bits which stick to one once written with one.

Note that removing the locked attributes required a migration break. Defer
that to a subsequent patch to help backporting.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog
support")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index c83d4107c1..aaf4695db2 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -59,9 +59,8 @@ static void imx2_wdt_reset(DeviceState *dev)
 
     s->wicr_locked = false;
     s->wcr_locked = false;
-    s->wcr_wde_locked = false;
 
-    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
+    s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS | (s->wcr & IMX2_WDT_WCR_WDT);
     s->wsr = 0;
     s->wrsr &= ~(IMX2_WDT_WRSR_TOUT | IMX2_WDT_WRSR_SFTW);
     s->wicr = IMX2_WDT_WICR_WICT_DEF;
@@ -156,23 +155,11 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
-            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
-        if (s->wcr_wde_locked) {
-            value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
-        } else if (value & IMX2_WDT_WCR_WDE) {
-            s->wcr_wde_locked = true;
-        }
-        if (s->wcr_wdt_locked) {
-            value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
-        } else if (value & IMX2_WDT_WCR_WDT) {
-            s->wcr_wdt_locked = true;
-        }
 
-        s->wcr = value;
+        s->wcr = value | (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_WDE));
         if (!(value & IMX2_WDT_WCR_SRS)) {
             s->wrsr = IMX2_WDT_WRSR_SFTW;
         }
-- 
2.55.0


