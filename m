Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ACCC6369E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuImf-0003bc-Vt; Sun, 22 Feb 2026 18:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIme-0003bA-CZ
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:40 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImc-000142-RX
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:40 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-436317c80f7so3132159f8f.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802557; x=1772407357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OlNDJrN9SOFLJmcRVoNcVGELItOSKOjjd7ufK3aM0dc=;
 b=xBDTV7z5eALxxdmuANAHCJiBrFo4ej9Y+0g3iW8IhuYC74s3mIAu08M33HuNFW9UVT
 y05uKXF7X2AFjFOew84VacXfsJFN+IU/YoZUfLlWP3xRiJQ2NC2dyTeMTlonNkaWPF8c
 ybK07hcnNUY1VlIrR5ddH2aFcbh0OSCr/0T9tB2Y6P6s9NkDrfbCFbhmMm03RWjKuV61
 Ps1ygPDskMYB7vMBekPL569ZfchEiVXbGso3UUubmvWOdgrMKkseDuCBHVlW6UrNjEk1
 c1EPz9601Cl3nzgJtm3hPtaDXMI/+nxVsdAxXuHnSTkYMn9s8J5zANNzgLqHzXWWSCL5
 sS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802557; x=1772407357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OlNDJrN9SOFLJmcRVoNcVGELItOSKOjjd7ufK3aM0dc=;
 b=mdaZUn8nF3QZoxDE89EIsgbccSxCY1r7FRzGMOxpEhPgFmo9mrxkkmyoL76boppXIy
 qL1oVNDdF66ZuO6ZLn6/dFX+zmH+w752KPoXO22ueX7+TXWfAYEFzT8+FkxJG5/RBJhL
 c/xPtmdKMorYAxVnysTFS/5o6tvSJbGUWyvXofP9fyCxwoJwJlaZoMSw2vBcd9sKkN1I
 WCVjJyYjTo2KHh02izA8jxYbbN9nVq54teEuiMltEtqiRn0JEkdXh2Hh2iXxS4wRnfNZ
 skPLPBghYvwLTSabAKbrfkzk8cK6TpJTgZcey982He6otq/nJu8ZJM1h4Ky65TtqEC33
 94Qg==
X-Gm-Message-State: AOJu0YyFvFjvpHSwAdO48Cc7csO/WA6QsoxodosuX8rYtCPs7BlJ3Duk
 xiHKON4Labww3VtDYclHB35WC7afEJT8Qyi0tD424c+pq0EZxj5aNPntUzK3GwHcSq0hSEUXxG3
 Ro7eRPPs=
X-Gm-Gg: AZuq6aI0HQEyEHt0ElRpRHX/QQXy+QlerAWYMqDO5AerqAI/swr5RG0QcXC9JhFspn8
 dbLWPAcIwPUZBE66ICmuWTZXSucwgCznd11ZBLzkPYy/XlXIOwcVlXIjeNKHRHz+rwQ+8eRBmjj
 DmXj4qXjAOe/Dm2ks4dUYLVdq69lkZ2uhZvm0Cs6UyE3KdznZ+DpWsG554uLUxqMoucokqTyDCS
 N0GNkmH4uePY3BplvKLe+ucgiwpuHzj55Jl2oGXgauVdND+nw23i83Y+XsVe01O8ygzE5me7mm4
 IAJt2nBYKECmqv6g38pCecR3Q+eoJJRjn0v5O6ZxNmESla9kHO6gvEmeUkngk5uMpq/BrwsEo3U
 8KQtzIVfx0YGeL2kZKXrXK/n28reMEXc7+SG16zGzOynR25j7/YzZUPvRWyjTZ3x+XnJWaaRikL
 2OBDXd3nCzAyrKWpRMW2N16dnAvOB/PfHCcqUX09jWZpZy9IppuyM8lhLkgqYpqjM215gTHMvSu
 7SZZ5+59cQ=
X-Received: by 2002:a05:6000:4383:b0:436:180e:78d9 with SMTP id
 ffacd0b85a97d-4396fd9b890mr12165129f8f.1.1771802557029; 
 Sun, 22 Feb 2026 15:22:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d54760sm15072903f8f.35.2026.02.22.15.22.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:22:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 08/21] hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within
 MacFrameBuffer
Date: Mon, 23 Feb 2026 00:22:18 +0100
Message-ID: <20260222232222.7183-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
References: <20260222232222.7183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The MACFB_DISPLAY_APPLE_21_COLOR mode is not specific to the Q800
machine. Check and set it once in the MacFB DeviceRealize handler.

No need to explicitly set the MACFB_DISPLAY_VGA mode since this is
the default value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-5-philmd@linaro.org>
---
 hw/display/macfb.c | 4 ++++
 hw/m68k/q800.c     | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 8ef174dc6df..b8115c2be13 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -645,6 +645,10 @@ static bool macfb_common_realize(DeviceState *dev, MacfbState *s, Error **errp)
 {
     DisplaySurface *surface;
 
+    if (s->width == 1152 && s->height == 870) {
+        s->type = MACFB_DISPLAY_APPLE_21_COLOR;
+    }
+
     s->mode = macfb_find_mode(s->type, s->width, s->height, s->depth);
     if (!s->mode) {
         gchar *list;
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index b55c03a90bf..ba32da2fa45 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -563,11 +563,6 @@ static void q800_machine_init(MachineState *machine)
     qdev_prop_set_uint32(dev, "width", graphic_width);
     qdev_prop_set_uint32(dev, "height", graphic_height);
     qdev_prop_set_uint8(dev, "depth", graphic_depth);
-    if (graphic_width == 1152 && graphic_height == 870) {
-        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_APPLE_21_COLOR);
-    } else {
-        qdev_prop_set_uint8(dev, "display", MACFB_DISPLAY_VGA);
-    }
     qdev_realize(dev, BUS(nubus), &error_fatal);
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
-- 
2.52.0


