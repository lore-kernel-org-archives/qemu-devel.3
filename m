Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72533CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENMI-00075o-Fu; Wed, 07 Oct 2026 04:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEKL3-0006bt-16
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:37:31 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEKL0-0007oO-B2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:37:11 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so255373666b.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791351429; x=1791956229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BS+0+A7kr0tFImAK5onZ82iakCeBub9bNBk2830WfL0=;
 b=DRmw60Lvn1xr3mrsr3God8LAbVEQ1XaUFRW+G4Yn6jgVFN7ekJniiZ/cmifRMebOdJ
 z9/PAuhWyPeAofN2VWr9TaHLRjvYgWVvnDfjwqmWkDKQPpxPqV2te6z9PhPoZjKBgU0b
 KnJ1qZBoZbfU5VXtSpv2J3Ovpvy4WxaoxVW7auToA57pQywSJHga+LNt+9tIaW3dkRlZ
 pZRTOo8FcRf2jrjlBZq9pEvlE6UTMd00iLfxUypx89DIPvoflR0rXGNz1EqCVuS90pDm
 Hbt8TMmp8NHjNcooztxQ98kFBPR0SU8Hmofw9JXoNKdGWLl2aLBtz0egWZTPbV21lxAT
 vJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791351429; x=1791956229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BS+0+A7kr0tFImAK5onZ82iakCeBub9bNBk2830WfL0=;
 b=SznP/9n8UEex+PlAH+5pNa1zZl8tMab1Nc9uVWjzqZTlbwx4BH9yEGqP4Odqrn5oxq
 CSZeEc16sv75VDQuq+6AqFi0NyuW+wvjKmqhBM5cchLTvlAQ1TPaVFxiwTahHdyLBqA4
 u+MgB1meSqAgE95HShM3wQJpUITbM4E/t9Q/b5vtCewNUKF1NaBs3FaJbWPwaab99gip
 7Iq6oUSIR3sbz5VxnUj3UXtAsoCXj9s3w1w+ZBaYzJJnzOUevpBljePB/XLlUCp7zT+W
 vRo5yAL1eRYlaNQS3Y1AIY4dy8P5iZ45Uc0VWEGCciLxw0wy8FoU3ch5Hfa4ih1YsgRF
 Lm/A==
X-Gm-Message-State: AFq9FYLSEYsvtYs/Mgd4ocFmCvehF9fw9Qd8XHlLchUNvdseI+Zu2PPr
 BbF8cTstagETxJ/eZJNpZ8T9heKdNwjP53Zs9sojDLiJMBPfc823n9dT+f+hFA==
X-Gm-Gg: AYBFou1WhPtgfTQxKBSS/vCpP/s+4IrkShpQwrqzinzc1D9fDvE8WiMGvP9pogZTfVS
 1AQFFhjaSSMafKQ96BmoZhxIBi5altJpu4SPAa3B2wdQqzQ34a+ODsIuTWUpy7AsUBN3jDRKjpL
 kHIpinGUBVw1kGdjBrYaLC7QXrzA5zVlEGsAOCNSCMinWhPvxeTsOXeMzItGkP5Otgc/OZR0KMP
 z5KUHXWFQ2/J55uOfjET2urS+rmqp2W5QZCmXbq0mjIvRyXzy7AAR73i/eaBPOvy2KlRY21kfhK
 wEB+6S4BqbLGwLoixTPuJ5XF/zkFy+JSg7mPUk5iTg0kxj347tqPYXVnLkPkoYgpwW/VOb1MWOM
 M+76Q+dVvOgislj5kZjemhz9exWXcyFj8el/kNkvc7dIvQEY+OX8tMHk34KfW45huRJ4lSN0H43
 E7XC8Zt7rcGLNRrHV9jgv3dXsDy87UiKdSWdUtZ40BVC7hRfuIwiE7R2cPH8BiCC/sm2aoI5mAO
 nbG+75GQT4qGG9vwsoZpygpa+i9mQ7z4UbK85okRSTO8aQt5w==
X-Received: by 2002:a05:6000:4b11:b0:48c:511a:1f31 with SMTP id
 ffacd0b85a97d-48c6d1684f7mr1429663f8f.8.1791275724813; 
 Tue, 06 Oct 2026 01:35:24 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:24 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 04/31] hw/watchdog/wdt_imx2: Remove redundant attributes
Date: Tue,  6 Oct 2026 10:34:16 +0200
Message-ID: <20261006083445.30362-5-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since WDT and WDE are write one once bits, their values always
correspond with their respective locked attributes. Thus, the attributes
are redundant. Take advantage of this observation to simplify the code.

Note that removing the attributes changes the vmstate structure which
constitutes a migration break. This is allowed since QEMU does not
guarantee migration compatibility for i.MX devices between feature
releases.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/watchdog/wdt_imx2.h |  2 --
 hw/watchdog/wdt_imx2.c         | 20 ++++----------------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index fc01fc46e7..0bf2903959 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -84,8 +84,6 @@ struct IMX2WdtState {
     uint16_t wmcr;
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
-    bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index a15f452d48..c19f0383ad 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -59,8 +59,6 @@ static void imx2_wdt_reset(DeviceState *dev)
 
     s->wicr_locked = false;
     s->wcr_locked = false;
-    s->wcr_wde_locked = false;
-    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
@@ -156,22 +154,13 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     switch (addr) {
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
+            /* WDZST, WDBG, and WDW are write-once bits */
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
             value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
-        if (s->wcr_wde_locked) {
-            value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wcr & IMX2_WDT_WCR_WDE);
-        } else if (value & IMX2_WDT_WCR_WDE) {
-            s->wcr_wde_locked = true;
-        }
-        if (s->wcr_wdt_locked) {
-            value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wcr & IMX2_WDT_WCR_WDT);
-        } else if (value & IMX2_WDT_WCR_WDT) {
-            s->wcr_wdt_locked = true;
-        }
+        /* WDT and WDE are write one once bits */
+        value |= (s->wcr & (IMX2_WDT_WCR_WDT | IMX2_WDT_WCR_WDE));
 
         s->wcr = value;
         if (!(value & IMX2_WDT_WCR_SRS)) {
@@ -234,13 +223,12 @@ static const MemoryRegionOps imx2_wdt_ops = {
 
 static const VMStateDescription vmstate_imx2_wdt = {
     .name = "imx2.wdt",
+    .version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
         VMSTATE_PTIMER(itimer, IMX2WdtState),
         VMSTATE_BOOL(wicr_locked, IMX2WdtState),
         VMSTATE_BOOL(wcr_locked, IMX2WdtState),
-        VMSTATE_BOOL(wcr_wde_locked, IMX2WdtState),
-        VMSTATE_BOOL(wcr_wdt_locked, IMX2WdtState),
         VMSTATE_UINT16(wcr, IMX2WdtState),
         VMSTATE_UINT16(wsr, IMX2WdtState),
         VMSTATE_UINT16(wrsr, IMX2WdtState),
-- 
2.56.0


