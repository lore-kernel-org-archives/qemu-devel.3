Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA8C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:11:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Yvv-000247-Ab; Wed, 23 Apr 2025 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Yv9-0000v7-G0
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:09:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7Yv7-0000no-9f
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:09:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso58305545e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745410179; x=1746014979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FZgMkeN579lrvloaKRasUpMTcORD0XAWHQyNz1vd4U8=;
 b=VWq1UPzfkVbNIgJNmUDW1hjrXevLVlahFVjoir0qzKulBseEUT7nPLANnDiR8h1Su3
 UUi7/ALRT3fGNXLgV+EKENBuRZ2wxbpTiVI6X9exJqW0dEl8sCpdednsdpfwB9j329JF
 UJmLmoDXesR6jplOlAo4Se0oZZnoBBK6v066Mk7t1oD9cMFr1JEd9Lyse78SDrNu+zrp
 AmcL6U+eAabAmLjChSRsQTtKminWh+ohVeXOsd+c8l7+ijakpkaj+pslvRFnWkL0TwGi
 mZTxz8JUZTBv4SKMglbQj6cdzv2ltn/tTnfbB0iCC6y+PoGGgV3Nj1eKQ/v7dpmdnhVz
 ZVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745410179; x=1746014979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FZgMkeN579lrvloaKRasUpMTcORD0XAWHQyNz1vd4U8=;
 b=uhW9wqBcjW8WSJlYUNYudPj6O1aGQITal6B6j7HarmekDAqt+aM1GUDNUc1kgxoU+J
 ZZDgY0C5PTiSNVOaT0eZi/Q3DarMYMPMwuFTdYqHNowxeGXM3PzsA7+/IZXkOokJ2YMt
 zcn6Nftl3IUFk9/aA+bOd6MPUuPWkUe8lRjDpGHYtx0GuTD1WSxTCTXxclSKEWlS5NXg
 xvVhLmtFD3pqr3abGh/Xs+BTebEh5YoO0lzOkmhf+rRj7ESSn9j+oUFFgZSueaenFKXy
 Cg1RenCTbxo4LfyRsBhVRLoeAg5cEC+Nl/Ty7vo7Hga/NoftOZ/vLPZWCvo9l0zEY+YC
 fA8Q==
X-Gm-Message-State: AOJu0YwN37GEo5nUDreWozu1/ESdcISz5Kils91sfKOmM5pNULDPMvmv
 d0tUO7zF0Tr4/GgFYBv15+9SgojHOetuXuM5n72jNBeSrpqmIztJSRSKWuZNXvbtvorhDvGHA2t
 U
X-Gm-Gg: ASbGncvdVG+JQzaDTLI2qV9or8MFfHqPigbNmcNTycEhhcKlORY/boKYKsvgcSMcrcg
 cZHX0FIJYZfJEUf6xjrtwA1NoxH3H4olRawPp0im68BjEDBGYge78YSPrdh3isYwQdeOSS+z9dm
 KDUrbyGqVerbK0hn6pUpq4ZGlva3N5f8MALQ5nQAGXibltZbZOXzPCjmfJUYyPycU2cWYVESLS6
 20sPFPSm5R0Hx/XPefnQ91WBs7QHNFbnUSkGHA6MQ6MP/6ZHFqJxbZ3B1PpD8OxM9DX3Af/baLe
 CcKWy3I7yNzk3b03K0QgiCLazM24ok5rlFTBSHgWExufEh6JowpHGB7Et/iTZ6/qNufOc8H7lVf
 WN4gBa8nOT/uuLlA=
X-Google-Smtp-Source: AGHT+IFqst3Hohv3VYjwsvdZTBQwQI0BcP6qbNDCB7OnRaxNqJosHjd9RI8nopf1tlEK4kN3NrvdTQ==
X-Received: by 2002:a05:600c:3583:b0:43c:ed61:2c26 with SMTP id
 5b1f17b1804b1-4406abb2407mr163305915e9.17.1745410179144; 
 Wed, 23 Apr 2025 05:09:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2d558sm24277415e9.17.2025.04.23.05.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Apr 2025 05:09:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
Date: Wed, 23 Apr 2025 14:09:37 +0200
Message-ID: <20250423120937.21490-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
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

uint8_t is good enough to hold a property "between 0 and 0xff".

Define pullups/pulldowns properties using DEFINE_PROP_UINT8()
macro, remove unnecessary range checks in pl061_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/pl061.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 60ce4a7f628..25b7ae3eccc 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -79,8 +79,8 @@ struct PL061State {
     qemu_irq out[N_GPIOS];
     const unsigned char *id;
     /* Properties, for non-Luminary PL061 */
-    uint32_t pullups;
-    uint32_t pulldowns;
+    uint8_t pullups;
+    uint8_t pulldowns;
 };
 
 static const VMStateDescription vmstate_pl061 = {
@@ -548,14 +548,6 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 {
     PL061State *s = PL061(dev);
 
-    if (s->pullups > 0xff) {
-        error_setg(errp, "pullups property must be between 0 and 0xff");
-        return;
-    }
-    if (s->pulldowns > 0xff) {
-        error_setg(errp, "pulldowns property must be between 0 and 0xff");
-        return;
-    }
     if (s->pullups & s->pulldowns) {
         error_setg(errp, "no bit may be set both in pullups and pulldowns");
         return;
@@ -563,8 +555,8 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 }
 
 static const Property pl061_props[] = {
-    DEFINE_PROP_UINT32("pullups", PL061State, pullups, 0xff),
-    DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
+    DEFINE_PROP_UINT8("pullups", PL061State, pullups, 0xff),
+    DEFINE_PROP_UINT8("pulldowns", PL061State, pulldowns, 0x0),
 };
 
 static void pl061_class_init(ObjectClass *klass, void *data)
-- 
2.47.1


