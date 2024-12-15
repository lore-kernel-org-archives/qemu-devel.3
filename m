Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1C1E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtzs-00027N-Hm; Sun, 15 Dec 2024 14:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzn-0001ww-6m
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:40 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzk-0001Tw-Be
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:37 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-29e65257182so1629132fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289775; x=1734894575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bRFQMU6GPusRQSSs8tq0WijM+F0esCyWu9EDpKqyNs=;
 b=yBEdIK8kfB5r5grI02lgavYzFJDlBL6K2LW2kLLspuKSKZtsZrERGRAYOHG8ri0NZA
 7pK+XCVmQ6G23SmJBGZP3uAvc9h3y0OgOA1GqnQM3nND52UzUkBMwgqrpvyE/YxtxTvK
 VawgozlVE+tw9HmFNYIOFnQKf/TJOXWHytKrYshQ2FN5lD6fXg4INPVOSkGmD2T4lwXf
 84KHYGsgNK0lRgCqfJ+xRzVxfdff0vsfrLjB4HW3WkGNqfAid29g9fS4IMushl7bqKJ4
 LcH8UoXgOX6oNe0E2Xkq+Iw7z8N42ApkuCee3i9XqB52aiHIP5kYKIusf7hWGOydv+Mx
 Q21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289775; x=1734894575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bRFQMU6GPusRQSSs8tq0WijM+F0esCyWu9EDpKqyNs=;
 b=V2l/WcXfRvCwKqQ0vgFhnxQnwMbrVyJXWHAMD6d1WGjwaKQp0Wl95o89W7im/YH6hT
 8df7x1x+gLOTKgrb3hDaVDL4Tga9Fto1/5WAYLhJaSDRmZsFA6qXZ3o2SgcqLPPj8LUy
 GE2tcz7/sDLuaty9g+R7S+Xx/SZt1QE8oZaXq/t4DHNP5uHwzyw/Na1kXrA/7sA6Qeot
 i13zDSrqM0MB9s3LGXlUvM1mypSjthryOGhnAj1ceUPeWSelXkaQOTJXWUiKUIRi9tnR
 PuIqnUpg+uuhya4rSTll5U5eMUUsLjf48mToj/jhfyxoV785FgA+IYKTKD0JKOuV1nDX
 XTKA==
X-Gm-Message-State: AOJu0Yyvc4enJL+1ivUvCBl0EYWpHFiQIHrjBmhDyYxxSkjDifxoelsm
 D+tRtFaVdqA+ScxkuELWqpkburUkDHMxEv3QhUK2kGWCBXA85tTXneMeyomnA0aWp+o8fAz6sTn
 PvxphqBeh
X-Gm-Gg: ASbGnctVX+d2VSdbXwG5oZbiUcrrgUJ3AXXXozJfW+fULopPyT9zVFWcnM4xZIeFYSU
 Bb6ystuRqbMA1OnP4OTWukCrHU7WkxT1G4kru63tFF1/QMXtPK0ubJKbQzdYah3VWfTLnQdaiNu
 PD5/CGRBZMVLewpXC6/RaJveoPg7PuHKmfjIXTunlrXJOAWrQTBkphzm6fPaKobCxJahxjOZMMf
 AIEs5Kl8drnWp0g9jWGPL8eLZcGJk7kVa5U+sKqsl1mfjeXJrY7/sNUxXYSdC2YQFLE1xnyRaDv
 kpvYA/cC3HrtuXUjw0bfRvjEHN0zSwEoMB7M//gEyiY=
X-Google-Smtp-Source: AGHT+IElTgnlJLPv57K1O+QDVi1sclk/whma4AX7i2Egh1rclYs4ChzVc9mRDBKhPcuKl56FYB/PyA==
X-Received: by 2002:a05:6870:8dc4:b0:29e:6b6a:d6f3 with SMTP id
 586e51a60fabf-2a3ac8c358amr4826615fac.39.1734289774786; 
 Sun, 15 Dec 2024 11:09:34 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/67] hw/nubus: Constify all Property
Date: Sun, 15 Dec 2024 13:05:07 -0600
Message-ID: <20241215190533.3222854-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/nubus/nubus-bridge.c | 2 +-
 hw/nubus/nubus-device.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nubus/nubus-bridge.c b/hw/nubus/nubus-bridge.c
index a42c86080f..83893e5a46 100644
--- a/hw/nubus/nubus-bridge.c
+++ b/hw/nubus/nubus-bridge.c
@@ -23,7 +23,7 @@ static void nubus_bridge_init(Object *obj)
     qdev_init_gpio_out(DEVICE(s), bus->irqs, NUBUS_IRQS);
 }
 
-static Property nubus_bridge_properties[] = {
+static const Property nubus_bridge_properties[] = {
     DEFINE_PROP_UINT16("slot-available-mask", NubusBridge,
                        bus.slot_available_mask, 0xffff),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 26fbcf29a2..7cafc13427 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -107,7 +107,7 @@ static void nubus_device_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static Property nubus_device_properties[] = {
+static const Property nubus_device_properties[] = {
     DEFINE_PROP_INT32("slot", NubusDevice, slot, -1),
     DEFINE_PROP_STRING("romfile", NubusDevice, romfile),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


