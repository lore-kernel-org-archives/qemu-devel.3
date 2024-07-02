Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E318C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOVev-00084q-BW; Tue, 02 Jul 2024 01:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVeu-0007tX-2U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOVer-0007Cy-9T
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:02:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-424ad289949so27207545e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 22:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719896543; x=1720501343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q56NCjL65Y7HhHMowi4nLhIP6TzxOP1AaiItOEx8tAA=;
 b=DmY+hfHISK5enlD/Hq3qvgCRMNUpqBAhORcrOLgTsR/tbqzzsUenvhjHtjNmqVN9f6
 tHvkPvay1jxrQ3jCh2DJqYPld9M7xt8/LChSo/nHz93/fgeg2YFcbMVFZUTcJbtBBWgO
 8A1OasuyysMfyie2V/aKm+kyDKM/UBIj94WvuTh/q2ksC2Gk8GlFCqEKTOBZn3TETkPz
 z9V0dlnyrjkC+umZHmux26KrbC6eVi7p+Zq6vsJioBloR8353zyMgZfGr/PnTXRFL8V5
 ASbCg+jf/E9BETF9LPSjV0NVuSfFsYbjRSi/+9UzAU81rsnm4iZoasGYY0B/FmRyzEpm
 /VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719896543; x=1720501343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q56NCjL65Y7HhHMowi4nLhIP6TzxOP1AaiItOEx8tAA=;
 b=t0QGR80+vCm8kyJqNBagM8tLyUhL/cWqvco8zKLG4uDsdaE8GPSRjCMlLiW+obhSQ0
 lSjdippFL2FhV1/tH4tlHysa9ZJ9wr8pzcFMr2sUKJx7Ra3i3BALqvmRWjwXEr5CaNO8
 JShTGtFdecKLx0Fsoh4Evnvqg28AU1dTtIiv0niGZIp93WwYgokYQIbup/OxGU2fpsUg
 tvS+s0yZOD2OxS27+tQWWf8aJBO5lFjiRIybasg4Se1Coogq/pqHw+aLjLg5eeH761Et
 yErXTDxLX2DZdaxH/HwqUSaWdckaIrcDS06w+0FV5D9Eok+8qys3NUYCwcacn6MVIdjd
 6xIQ==
X-Gm-Message-State: AOJu0YxVIPdzcJjbZ74NwirjOSzSUtQEO+/4vqElzuHvkLGcEQnyvmKN
 lVyNcZBE3Et3FW2NPaplfU7RZahKM5J/6U+sSG4iS6U8HS84qYLvUsArg62FCYk/ZhYPu/37AnD
 T
X-Google-Smtp-Source: AGHT+IE/eMIMQiqBMEWBzZ12/XAqekucNnIKf5AC5kxObxt6gQglv2dNfhZoVfXDk86GwxE2PH8ynA==
X-Received: by 2002:a05:600c:1d1a:b0:425:73c9:e60e with SMTP id
 5b1f17b1804b1-4257a020eafmr47566275e9.25.1719896543168; 
 Mon, 01 Jul 2024 22:02:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256f55c4b5sm166624665e9.43.2024.07.01.22.02.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 01 Jul 2024 22:02:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/22] hw: set deprecation info for all versioned machine types
Date: Tue,  2 Jul 2024 07:01:01 +0200
Message-ID: <20240702050112.35907-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
References: <20240702050112.35907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This calls the MACHINE_VER_DEPRECATION() macro in the definition of
all machine type classes which support versioning. This ensures
that they will automatically get deprecation info set when they
reach the appropriate point in their lifecycle.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240620165742.1711389-11-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h       | 1 +
 hw/arm/virt.c              | 1 +
 hw/m68k/virt.c             | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 027c6f29f7..83d2e66498 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -330,6 +330,7 @@ extern const size_t pc_compat_2_3_len;
         MachineClass *mc = MACHINE_CLASS(oc); \
         MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
         mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
     } \
     static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
     { \
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 08990b9abe..02e13b4a3d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -110,6 +110,7 @@ static void arm_virt_compat_set(MachineClass *mc)
         arm_virt_compat_set(mc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index cd6ee692f7..37bb36b385 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -343,6 +343,7 @@ type_init(virt_machine_register_types)
         MachineClass *mc = MACHINE_CLASS(oc); \
         MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \
         mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__); \
         if (latest) { \
             mc->alias = "virt"; \
         } \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2785b6b303..55268489d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4811,6 +4811,7 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     {                                                                \
         MachineClass *mc = MACHINE_CLASS(oc);                        \
         MACHINE_VER_SYM(class_options, spapr, __VA_ARGS__)(mc);      \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__);                        \
         if (latest) {                                                \
             spapr_machine_latest_class_options(mc);                  \
         }                                                            \
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 380e9e2e5b..c25dc3e13f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -826,6 +826,7 @@ static const TypeInfo ccw_machine_info = {
         MachineClass *mc = MACHINE_CLASS(oc);                                 \
         MACHINE_VER_SYM(class_options, ccw, __VA_ARGS__)(mc);                 \
         mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
+        MACHINE_VER_DEPRECATION(__VA_ARGS__);                                 \
         if (latest) {                                                         \
             mc->alias = "s390-ccw-virtio";                                    \
             mc->is_default = true;                                            \
-- 
2.41.0


