Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF76E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMZ-00078C-JG; Sat, 11 Jan 2025 13:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMX-000767-NU; Sat, 11 Jan 2025 13:37:33 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMW-0003vh-5f; Sat, 11 Jan 2025 13:37:33 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aab925654d9so589712966b.2; 
 Sat, 11 Jan 2025 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620649; x=1737225449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOFttKKVOfYxpHBSao0DEUzlTB31JRtFpeweJdc48Qg=;
 b=ZDspemxrqVuq73Gsf8+TrZvMtJc3t788nkMnsYCmUqHPIklsGBytJlm7XkHD26jz7v
 LZpe1QaLe10gCABKPlk26PnoEcWUEM5L8t3TsBZiKzxW3xTfNDOdLB4FYEvgPgnDMLpJ
 T4Djr2qe3lmzV8o6YeuJcvALgIneY7QV5/L9ghPyA2oUqDuKz2ipwmpohc3p8yHRrOPl
 MnjK2OlYAf3Vovw90wjAz/Yjx55L/kMbTG9c8CJgM176GFbI6fYPcyrRRVR1dnS3Z9tG
 XX0eoZ7t9nfIap50lnwbw+v1VR5kzLGNGNNlF6X/quZRH2gPcO6HFGtrNoFeXFoWcVYg
 5xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620649; x=1737225449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOFttKKVOfYxpHBSao0DEUzlTB31JRtFpeweJdc48Qg=;
 b=pYDquuSAg8hxkIMHXQ21zNGiOjDxN86QHfSGggSPhAUtBRzeRmOnBZWEOxfxq6iomW
 8dAonnZa5hSaVRWFBajsgl17kQ+PwSycRqUOn+iinNhesZiXWWuOqnTMKl8YLpDBzTIe
 rl20RBWRxPCSPs2VnhUk/jdMRbRSI1/4IBeI/+H+uBo9yZtlYPRhk2NpsgK4cGfgpodq
 JsrKAYbAsxfPbeEtzNZeGhY2a+cGboq4E5UXd23IwOQ7n4zBH7hQfLQqtS43dj/Sk4NQ
 pZoehT+E9wREt4oeljc8JlMT+nl+TPREcuoFLFFurBMOSfmSNQR8qEAPQbBVs6soQ6BW
 ml7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSMjDtgV1jLM85pQDFFmQIJ+zEmPPNkVW18Q8yb0OJWIx/zRwtsSGtFfgnuYN2JzQ4SZ3xRPMzvl8moQ==@nongnu.org,
 AJvYcCXVRcJduQCJuhsHpRm5z1pPbjqxSMdboGkQ6AGUme8AT8y+KL0oYrc+wDlHLo9Q7dn6D4jgIEPeXQ==@nongnu.org
X-Gm-Message-State: AOJu0YyVlJYOAsutezAQYxcRVQMkCP2oAAErcrhuxM2j5vy7FEiaRRnc
 9Wz7ScjMZiJq86zFCJ1BCYaMqy9NXkOO4hlf1nqTQhn3L2rULz/lAj19pQ==
X-Gm-Gg: ASbGncvfIJc84NKfKgeHOhBlSU19/JJG3B7uGvqFFPDrSs1VXWD/bpv5cM5Et3XMuV1
 uCCJ9wApe6pfz9Gt20fD7rU5vu+uz3YlOibGIBI6zgWAvRe7JYq4xvr3t33q+Dk+VJje1g5eE4z
 31nXpHKPTQjzQ4INLW/Z65VOgDImQEP+ctLWL1iU4nSJ78VJuffOAPmMuon6tAiVo2feM95SN2R
 +DLnsYoHTamKbwMhm0eIvsq26iN/xTjlCWKSnogUOjCJcKmuF1KWRP4GWvmz00aHDbhr5DeNlDG
 PK8IopOHrogm9b96dgGqK2/UpNsLSsk7UgqVE9n0fMo=
X-Google-Smtp-Source: AGHT+IHBgmP5SDjLl2s4DtxI4ejxoEB3BFMJxpqCO0UsVaiSJdnWKsIc4QHgB2wcopuTorYp1i1H9A==
X-Received: by 2002:a17:907:3ea3:b0:aae:8491:bab5 with SMTP id
 a640c23a62f3a-ab2ab73b234mr1340477766b.26.1736620648696; 
 Sat, 11 Jan 2025 10:37:28 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:28 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 07/13] hw/sd/sd: Allow for inverting polarities of presence
 and write-protect GPIOs
Date: Sat, 11 Jan 2025 19:37:05 +0100
Message-ID: <20250111183711.2338-8-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index aa8d86e1af..a50e5c20c8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -181,6 +181,8 @@ struct SDState {
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
     bool enable;
+    bool readonly_active_low;
+    bool inserted_active_low;
     uint8_t dat_lines;
     bool cmd_line;
 };
@@ -876,8 +878,8 @@ static void sd_reset(DeviceState *dev)
     sd->cmd_line = true;
     sd->multi_blk_cnt = 0;
 
-    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd));
-    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd));
+    qemu_set_irq(sd->readonly_cb, sd_get_readonly(sd) ^ sd->readonly_active_low);
+    qemu_set_irq(sd->inserted_cb, sd_get_inserted(sd) ^ sd->inserted_active_low);
 }
 
 static void sd_cardchange(void *opaque, bool load, Error **errp)
@@ -896,9 +898,9 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
     }
 
     if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
-        qemu_set_irq(sd->inserted_cb, inserted);
+        qemu_set_irq(sd->inserted_cb, inserted ^ sd->inserted_active_low);
         if (inserted) {
-            qemu_set_irq(sd->readonly_cb, readonly);
+            qemu_set_irq(sd->readonly_cb, readonly ^ sd->readonly_active_low);
         }
     } else {
         sdbus = SD_BUS(qdev_get_parent_bus(dev));
@@ -2797,6 +2799,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
 
 static const Property sdmmc_common_properties[] = {
     DEFINE_PROP_DRIVE("drive", SDState, blk),
+    DEFINE_PROP_BOOL("cd-active-low", SDState, inserted_active_low, false),
+    DEFINE_PROP_BOOL("wp-active-low", SDState, readonly_active_low, false),
 };
 
 static const Property sd_properties[] = {
-- 
2.48.0


