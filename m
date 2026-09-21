Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A69C982FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrT-00068w-HV; Mon, 21 Sep 2026 17:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrI-000658-4O
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:33 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrG-0008W8-CS
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:31 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so19942135e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027249; x=1790632049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lVnjRdLc88bwkEOj1pcHpoR2nWaQoq8yYXYeFGKmXCc=;
 b=U0YDYoNdnGbyXq8yDzouDXsqQ7JvjGpmvD2t9QHcq/H1UoAuf2DSQXZ1Qgi58AV09V
 i+qf/Az5PrQzHwqV8qJMtIXkWhSHJoxM1vJ1Uk4PVkpEJgaHQBJPAh9AHzqE1jwQijaO
 uzIxZfkg0YV+BnhuHOLHEMQLgHYZJ+8VLsvuNtwAHl7WEOAq0rcfHqbJi97nSl7g1cEZ
 4MhlJAU9ZGEwSKLHGgf/MWjCXPkcMGgxazqVQuT1VcXX5IfcqQ5IvyH99Dth/AaGTEgZ
 0B4UHTP+ldPrMuSYFvkY8/HNP5nHlzGb8F5/rYosQZ4lOk1sggW/kpiSGJjOHmllKsjY
 jELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027249; x=1790632049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lVnjRdLc88bwkEOj1pcHpoR2nWaQoq8yYXYeFGKmXCc=;
 b=DDi30iaK5lnyVZ5SM6eNo6fPnQmRgPCa6hiqpHTJBwe/f9gD0KTbdzxKqh7mTi4Djl
 A1nsxyQqvlnGTqtQPf3z7LT3szxT7BxvzA0phht4h6R97a/0MK6ufBILeSSwxXotNuCW
 rE9Uu1/VwsfxJoEfFpR6zJQl1jOCDx8XmRQCdNgEBNE046vj/oB0da+mF1nTP4oegNPc
 tLQ18cOR0uX/dZlLBF+Talhpy/dJ+761KVQC2EWf2NXv/+jOkPBDJAHmx3D5fps8wcXV
 Zfuj83/w2u9tWLaIIHGQmpVTcMq0BaDDUda7QOeL5zPPS67e6VWW5zO8wUYDwBUS02kE
 cdHg==
X-Gm-Message-State: AFuF++nDOVcfjYAMXCZwCVSBi8qIlzbvsjRCgGHMvy2kCLEjW6hczyqw
 pLCPjq1NV2jp5xQem0UWvUtZj/U0Y1/t0JkoiBisV4YRhJrKwBQ3bUlWwDgPUw==
X-Gm-Gg: AYBFou3+0B9NtKpyM03n33LRANmYzQve98VL7rPN8jHAbVRoDP+FdKU7V1UwfjcuMN/
 V64qsTDFHdtN7IoscKQfdngcomgKhxW9OuMp59G7IjuzE1ZllMtPiOiA501A0mBCmFT2e1+x8X5
 cLrnM51kUEqVOCqdL3p7QwtVZJAHIApJHPPRfHBgqK1sCjg2bW9fMNisDloVIsfdJZizl3nu7Rr
 KsEAgKP/mqW876opZeM9iXaQMLIF+RyYKWft7kzhXxhVyN9Wj2cZxotIVgePc2Scoj9EwTVnwWm
 a9hUEXZYDnEjiY3Au6PYXQz6eMH/QlgENhEN2g0pPqevouXUY/tuNgTzjDeOkMPFn5BZYm0Hjmj
 dRdG/GUT0InW5snUcWLTaXzqVMhsL2dFvkzRRmo0ybVXMV+chgryGC3TMWGgoztHSbP1gpbrLEe
 Hh6sStn1oiD9ODi+XSF/i467h0scNfkDvtKsIUg2R6DUpKwdwFasC4Obe11Cz9IQrimTKnLSTq8
 CHn3sAhr5KuQ3gcRHnqJD9gNhMK0R8zyVTakF7K6IsQPmbc4SDsP7SAy5dC2r9acYe7kwI+YGlE
 0cW4Kq4WlHPM2Q==
X-Received: by 2002:a05:600c:3588:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49fcc3772bamr188370445e9.15.1790027248851; 
 Mon, 21 Sep 2026 14:47:28 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:28 -0700 (PDT)
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
Subject: [PATCH 02/42] hw/watchdog/wdt_imx2: Remove unused attributes
Date: Mon, 21 Sep 2026 23:46:30 +0200
Message-ID: <20260921214710.29422-3-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The previous change rendered the locked attributes unused but they were kept
for migration compatibiliy when backporting. Remove the unneeded attributes
and break migration compatibility since QEMU does not guarantee
compatibility for i.MX devices between feature releases.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/watchdog/wdt_imx2.h | 2 --
 hw/watchdog/wdt_imx2.c         | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index ad36b8820d..0bf2903959 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -84,8 +84,6 @@ struct IMX2WdtState {
     uint16_t wmcr;
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
-    bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index aaf4695db2..c8ea704aa3 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -220,13 +220,12 @@ static const MemoryRegionOps imx2_wdt_ops = {
 
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
2.55.0


