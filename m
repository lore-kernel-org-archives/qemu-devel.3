Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6593DE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB4C-0006i0-U5; Fri, 13 Dec 2024 14:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3Y-0005fB-Al
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:33 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3V-00072i-K6
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:32 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71e1e051e50so556917a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117028; x=1734721828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxHsxoCqVHXq4MPkg5fUEdQj30fdSGU3LBmK9dFYU78=;
 b=xWUFBqJ94WeVAGQydxd0PzWE7SxFfJ/QmHjXxK5Q2Oh5E1pgo0W7fI0KDzWFbyhK1U
 VpAfLOLzLl5ZiICXP7mZULWtHh2WIO5Eg/qsuDhyMlFh1cnL/npcuD52WtQw1j0h8/bf
 GOfFPP1Hkmp8DkZas9lEjpVdDHs3s2/cDxuy1TJJzEc+JcaRTsIEkzYPV/+a8wto4mwK
 fF0qqZvqe4VwsX5VbXx5Y+cxA9mORQ+C+askOVJlek+R8STK49K3bXRsj7O4WNqVpV30
 BXDsZf96c3l/35gdKjirRh4T7m1uknivdwGw88zjtpB0Rwc2MrfKDPsRUk0gJSY8The/
 8ZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117028; x=1734721828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxHsxoCqVHXq4MPkg5fUEdQj30fdSGU3LBmK9dFYU78=;
 b=W7W0eFerJjefLKflBOng3NMxjazo8wgil89KrAwFEHzouaGoNTSeWEuv2r9D1fkOGz
 O0n9fNlY+ivbMh5r+X3xhlPDOk2lDgtStNIwvMzEfbsT1s9kMlqqpReKYnUxijA9yNuY
 OQjcoCVI9OzS1jJKTxO3Erg4UEoyFyz/NeA+hJuyhEO2wn4bWfAxALbj4ENUpctFa7x4
 x8rm1ckxqBk9FI4cnipJJhtyePLO2BIIhaPiY6Rwmf00Xf+u/5FTcvi1jwfA4tmIbrDE
 YVIAQIK0NuLq1qZ4wWh+MSgMWTPwktHkwzwbWvoexmJnD4FLCMbLA8FhQcRewU7tVSz1
 hfAw==
X-Gm-Message-State: AOJu0YzWomf0n0+Y+CJSCIxdtssE++BbOfnC2MCCDNSgclDevBSPzJH4
 JD5QEY7XoDqY92FjW7JOKYj2HUimzaCV7FrAva9R4JrWZZT2eJkSfDKXzN+WaTz3tORUbWf4bZa
 dBeKGXHx+
X-Gm-Gg: ASbGncskVwtwEoyxMTIxzgKUffLw9uiWec4Gfcc/lGeNbLTjrS5SWc5OHznJOAYrA4i
 d60b/hLMCsNBozZe3i68yrzytyjnXnzUH7G+TDdXuBNs0yJ5ASYu7Y8CsdRiNxswFJKF35/DCeP
 iVSI38/vLJ0nHwZC4qVCY325rHQ+h7FUgqQ05lJ6zLlVnO3FAKiDcugIzgLGk8C1/7coBfSWSJh
 Dp7s9H3q7foBX86Qxt3jqeBPDcv6Jbx48M2/NhYpyzuWbWahdeUg7dRi1kM8jGr
X-Google-Smtp-Source: AGHT+IEDvOS6pK5/yz9GOEXP1s5SJim9kaM84wcuqdxAR212IakyOU2NwMmdFgx2oYUgniQZuCS9/w==
X-Received: by 2002:a05:6830:dc8:b0:718:186a:497d with SMTP id
 46e09a7af769-71e3b8164f2mr2133808a34.5.1734117028407; 
 Fri, 13 Dec 2024 11:10:28 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 qemu-arm@nongnu.org (open list:Stellaris)
Subject: [PATCH 31/71] hw/input: Constify all Property
Date: Fri, 13 Dec 2024 13:07:05 -0600
Message-ID: <20241213190750.2513964-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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


