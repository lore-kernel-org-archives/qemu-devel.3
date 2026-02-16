Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30440E83838
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cr-00023D-Gc; Mon, 16 Feb 2026 16:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CE-0000bh-42
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:01 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CB-00041p-Bc
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:57 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so30818145e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277513; x=1771882313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iTYDTjW8oF01EE5U+uJHraTm442v4OtMz2SMPZaJV0=;
 b=NuDFnYm+eVmGOrK4dlTMIP/d3LjUJh8VxOhnhokSVX07Yb/QacVmkEzW3dl0g5KxBn
 irtFKnMbtXUzkXErA17RQsjRDLsVGZVvjt/WSbHTwAh42OKGgFMRoiEiiN1kecXlvXGY
 BEmbHmffCzB62t9BFOLp/Y4mEpe+0fBIf8Dm65VU1zS1YVFmzaqjI+LF1iv8jG05tWuI
 /lCQxsgawTfo7ilGOFI8fvsq8rktMUnH5latOEsX8Zynckvv7BT1Mukeghu+pdEpmexq
 C2GYHuoSCRBLGkh6XRQOLkyKJ4Gz6PT+GhmZqU8ClEMmBvcWZiGC2RowwTVyJY05XZUj
 jbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277513; x=1771882313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4iTYDTjW8oF01EE5U+uJHraTm442v4OtMz2SMPZaJV0=;
 b=clNSKiJ2vr1YlzpDwtNcip91P4u9mj21ebm7vidWEawpPbim/tdTKNxLT35gdBUN7B
 uw60tImHkJLD2KjTf0nbmwZwxXdD0EIwxAUMh2Gt8aio/uPR2cI3xNFg9KIbEwTbPkI/
 +eELN8AcuyA7wFnGRe7wE3Qjkt43muYxGEkTugBHhv6sZ45ilbNAwqYvMw7ibr0tpBFW
 kjGn9JblmDI5D6EoDNbIfM3Jib6lxNlVTwEjo7yLqLuS+0I2Tfd9AINKSIQXtw+9cDYH
 QxLWTFPu0EvFWdcbR8HwshZP+rds9s0iAGh3sXmTuqfMSZsw7LJpdN6JZzcLLWFWMc9d
 1PPg==
X-Gm-Message-State: AOJu0YxVYjprGmV2ftswLzfrs2zl6Z+ZNItlRZEx1JTbjcTuyjTGOZVZ
 rL682xnbGFTSvsxR45DwiffcmWI+/xci5ECaqxgS8hrr3vTzKwWZ7ldlRWm+KUbBQniQXe8l1Ru
 k56ZdMXI=
X-Gm-Gg: AZuq6aIr45CTqfqWc+OZrsg7XwwONSWAYTxwUFMLirEDeXKR6mHEhDjKQ4Fwbq7aIQ+
 xCfi/rvpq+43crpoxYuLVB/4TG1X8DwtD54xyMxMS/DWwkDcDcojB2Hb6ea6825cdLy8v/yQZCR
 tRCqgovH/khQDjY/eBYHAodnrNQjQyW4KVtH6zN8Q93IBy3GPC0oElTPqe0OZt5o3ZsE8dHr60R
 pbwovfJUVEzUFfo5xWXp41dpwlO4/ITZYuXFPg0gr5KU/syVz4I/VxkcBzqUAeDuu6OJAqdRqtY
 Lsmu8SmHF0dCwQM1nQGOyr/puplt31HvxXLocnEMWIB9Gm/0/OORJClT4iL4f9NWoGAAHkab+xL
 8ZXR2TmfVBcLxdF0C2VBuvTa4VohlWCX9XPm/v0WlBth+obhgivHsd3KAK0IBBQX60EA7HH/S7c
 NgYXVqrK2GRi92CcNEyGzznaVFvU3/VFu6IcH+wDOdBBRokwi7QTq9HQZIRZfnqoCJPtpNWI2o
X-Received: by 2002:a05:600c:620d:b0:480:3bba:1cac with SMTP id
 5b1f17b1804b1-48371043046mr182491715e9.6.1771277513333; 
 Mon, 16 Feb 2026 13:31:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a3f835sm91270965e9.25.2026.02.16.13.31.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:31:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within
 MacFrameBuffer
Date: Mon, 16 Feb 2026 22:31:17 +0100
Message-ID: <20260216213121.47122-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The MACFB_DISPLAY_APPLE_21_COLOR mode is not specific to the Q800
machine. Check and set it once in the MacFB DeviceRealize handler.

No need to explicitly set the MACFB_DISPLAY_VGA mode since this is
the default value.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


