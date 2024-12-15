Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FF2E77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwo-0001gb-2W; Sun, 15 Dec 2024 14:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwd-0001Sy-QH
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwc-0001DD-1g
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:23 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-288fa5ce8f0so933181fac.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289580; x=1734894380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXOLh9yZNgpRyWamRBq8wsPa5UlUqVmERW2UrYN4jVU=;
 b=i2ydotqxMmlpT0Szl5lqLG89dX5gu8MzPKUN1lVfwrIA8DMw7G7rD4jSxhbId4p5EQ
 bLCSDAmV58hfQRw9unMTkJRx33m4omfp/RiZYCkkMsNuNJqlF32OB0QsAVvJKsONoxJj
 HG33yfuphRztM7+PHVA/av8NCwIoFpo0rwzcEPKFM2Tnpm1tcXThUERtt3QQnuQVxh4s
 Bdj4zxBuKIkU3s1PdWvxZdZghFN4lPcV/iu5q9/srjcXBX7OUigb/eYs8v3IcVyrV0Q+
 +tUPD+oGw8wuxnSCEkmzqyIJv9Yrd9ZqOQAIZ6jPuH1K1AznZnwQ8EdN5kDns7vCpjme
 rxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289580; x=1734894380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXOLh9yZNgpRyWamRBq8wsPa5UlUqVmERW2UrYN4jVU=;
 b=e7oqQux8rR732iuLrm83CK6CCxBN3kzZKWOKwDnd8CWoMUE/NZgldkIUZrrqWpKWxR
 mZZX9WB2gphUleh/X6eT4qOSKXBjV42gJwv6mp2TGJeul5TUpOcigWMWCQi5p+O/iuJh
 de9m+0NsaZCTjWVYKSxtwLe8thGSiYMkbOdKo1yA8s04enSpWn7Q+Li00xve70v/POGN
 36xvXpoazfw7M/bToFEqeM2YzA0kTY/LReONd+yHhW/6LCKlTsuhcT1AAdg5Tn+ImclM
 1UIFBKzLpYFW9fL9PIgCEnyus26blPnDvt4bRUdbvBsLnBmpaQoV+yqIfU8wTvHtCge1
 ZNiA==
X-Gm-Message-State: AOJu0YxOioWHsxMNRmzy7F9z0s9yYDDZuVPg0uL98mz3nU5C20LO+rOA
 QY+NtyNSni6UW4S1s+UBf2I3txZT5M4oToPC/Bh9nNePQs6f5zpwF0jqzcXh9rbmMvnQbX6He82
 osub1MWw/
X-Gm-Gg: ASbGncvzz89NbI3a3yI8CmuVheJr1tN9m5NqnRUzgLGJGMo6vHc3Xyy97saeKs5FaA1
 MNhZHor68vVxMPWr5grB9uHMyAYZ4qVAga3pPDE2wEyDa8LLz+I3EUIp/oeNByDzJZDbUsi4KOm
 ChT4au/b9gN3S7Kutn3nedOIfhANUa+Pimtf3WO+CzTylfLZgGVu18K/oDv4KMA+EgFs+KjciMu
 04/SrJfxSAs0NlqD0E6w0omXTCbx8CqHrCcT+ZnM8Q2O/d1iM3mtXot0wFoBTHY3fBk49VRoO4l
 Zn0oLyHsCrX3R8bjKPVFDP2noUd7IBOE7p2F2o7nNqc=
X-Google-Smtp-Source: AGHT+IF/DX66qzlGFmPlROxakzib22ndkzEGAgTCL09zZe6EnwyZYS2PYhy8lvAXe+uDGqYzQopt3w==
X-Received: by 2002:a05:6870:912b:b0:29e:1b72:7586 with SMTP id
 586e51a60fabf-2a3ac62d5d6mr5871603fac.18.1734289580401; 
 Sun, 15 Dec 2024 11:06:20 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/67] hw/input: Constify all Property
Date: Sun, 15 Dec 2024 13:04:56 -0600
Message-ID: <20241215190533.3222854-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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
 hw/input/pckbd.c             | 4 ++--
 hw/input/stellaris_gamepad.c | 2 +-
 hw/input/virtio-input-hid.c  | 6 +++---
 hw/input/virtio-input-host.c | 2 +-
 hw/input/virtio-input.c      | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 04c1b3cbf9..24a133fd25 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -735,7 +735,7 @@ static void i8042_mmio_init(Object *obj)
                             "ps2-mouse-input-irq", 1);
 }
 
-static Property i8042_mmio_properties[] = {
+static const Property i8042_mmio_properties[] = {
     DEFINE_PROP_UINT64("mask", MMIOKBDState, kbd.mask, UINT64_MAX),
     DEFINE_PROP_UINT32("size", MMIOKBDState, size, -1),
     DEFINE_PROP_END_OF_LIST(),
@@ -933,7 +933,7 @@ static void i8042_build_aml(AcpiDevAmlIf *adev, Aml *scope)
     aml_append(scope, mou);
 }
 
-static Property i8042_properties[] = {
+static const Property i8042_properties[] = {
     DEFINE_PROP_BOOL("extended-state", ISAKBDState, kbd.extended_state, true),
     DEFINE_PROP_BOOL("kbd-throttle", ISAKBDState, kbd_throttle, false),
     DEFINE_PROP_UINT8("kbd-irq", ISAKBDState, kbd_irq, 1),
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 17ee42b9fc..b1cc693189 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -77,7 +77,7 @@ static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
     memset(s->pressed, 0, s->num_buttons * sizeof(uint8_t));
 }
 
-static Property stellaris_gamepad_properties[] = {
+static const Property stellaris_gamepad_properties[] = {
     DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
                       keycodes, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 45e4d4c75d..7396385508 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -237,7 +237,7 @@ static void virtio_input_hid_handle_status(VirtIOInput *vinput,
     }
 }
 
-static Property virtio_input_hid_properties[] = {
+static const Property virtio_input_hid_properties[] = {
     DEFINE_PROP_STRING("display", VirtIOInputHID, display),
     DEFINE_PROP_UINT32("head", VirtIOInputHID, head, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -380,7 +380,7 @@ static struct virtio_input_config virtio_mouse_config_v2[] = {
     { /* end of list */ },
 };
 
-static Property virtio_mouse_properties[] = {
+static const Property virtio_mouse_properties[] = {
     DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -505,7 +505,7 @@ static struct virtio_input_config virtio_tablet_config_v2[] = {
     { /* end of list */ },
 };
 
-static Property virtio_tablet_properties[] = {
+static const Property virtio_tablet_properties[] = {
     DEFINE_PROP_BOOL("wheel-axis", VirtIOInputHID, wheel_axis, true),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index fea7139382..2be2c633ab 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -221,7 +221,7 @@ static const VMStateDescription vmstate_virtio_input_host = {
     .unmigratable = 1,
 };
 
-static Property virtio_input_host_properties[] = {
+static const Property virtio_input_host_properties[] = {
     DEFINE_PROP_STRING("evdev", VirtIOInputHost, evdev),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 3bcdae41b2..edcd94dedb 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -300,7 +300,7 @@ static const VMStateDescription vmstate_virtio_input = {
     .post_load = virtio_input_post_load,
 };
 
-static Property virtio_input_properties[] = {
+static const Property virtio_input_properties[] = {
     DEFINE_PROP_STRING("serial", VirtIOInput, serial),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


