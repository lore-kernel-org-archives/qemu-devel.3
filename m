Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7BBC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvhED-0001Xd-QW; Fri, 21 Mar 2025 14:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhEA-0001KN-3a
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tvhE8-00070u-30
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742582175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVg1tbjHDlf8QclYlE4W/Yr+fT0nQXJyVq0t9o0sx40=;
 b=JpLh63YUQark/EQG+b+GfP6cOhYxNtJngeWdgHL0zrupG/v/ARfyhqISkH/dk2Njy4JRY4
 CCle8Jj29H9y0Zo1su+FRcH9wW6e5sEq4lIba6DpGeOY71L+VxNdOcS2Pd3Vu+593K15qO
 MNAqgKGmZ7Btz9vXPCjeQRRiNA0+gfM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-RJ-JoDZPMLKniy4de0iqKQ-1; Fri, 21 Mar 2025 14:36:13 -0400
X-MC-Unique: RJ-JoDZPMLKniy4de0iqKQ-1
X-Mimecast-MFC-AGG-ID: RJ-JoDZPMLKniy4de0iqKQ_1742582172
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39131851046so1011397f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582171; x=1743186971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DVg1tbjHDlf8QclYlE4W/Yr+fT0nQXJyVq0t9o0sx40=;
 b=PnqNAUsWdcG/S7hlcYybY3haEMQjRZ0DGtgtduK+O6zVIfSjC0TvqlVPaRRkF97C3H
 T5wrkvfg0ClcsSjbX7aPTtUdKtdW4i0JYtR9RLUtoOtDzj5aLoN0Vi5I3CNIPiUsgOwB
 LvG99ZjydNKmlromGnnhEVhS5qfwCmPyleGoTJTGSg9HlpTLR8KklbdqkeTfrujoEqkA
 duz1rgiw8J1OmU+Fju+13jeRe3Ug8XcWu5Lqr5GG4ZE+5ZjwNyKGjqwomNh7YtKLZLqX
 60o4YprvgKokmyOXhfk6p6+RbOaO4jg4YtXBFhPeyvvgDhnWglLaCuV4tGpeDV+oQouv
 ntCQ==
X-Gm-Message-State: AOJu0YwmGswNx5bjeTCDxG0P9o8ECMR22fDJARFyejdyUdyyPOgig2V9
 NNauD8Kv7OrC9uFWSRDb54UIyg+ap+oVTB8d3RmB5nfuDe1PZCptXvBxnxo5bWcqyURjpPiOtJ0
 j9df0mxF0T9OGGE6AOq8FWJ+7DS2JfQGyNwQs/20wG+/m6Onl8bFKhbmAdI9CNpivKa2A5loODk
 Webc8t2KsrbYol4Jn7H+BgdQh/xbsMFG3q+d0r
X-Gm-Gg: ASbGncslBDpj25K6l62Fyn3h/BpxfSGQNiZddtTcbwX0tX4rXP29ylB6gDJX1xARo2Y
 ctBXtcdLpT5jkMGTFQaGwpef7q/RS+Rod8bg6m7laMnimFYSNzlUubB5XVmCzZFlbQwxPwzS87U
 hTJTvfzGj6sOCvL+NPCfy9s0OdTxP62isMdCJR+JHe4ZkQlrsixDVJ9WHmq+QfL+UrbwFDZ6VzB
 jU+wIQ240TUhOr9J8tA29EY7uWWPl2nfRMrhm3H69wDem63L/BP4NlleWD0YS+eCzp7TwVW699R
 JkzN447Z5Bk5WcFiVdoB
X-Received: by 2002:a05:6000:184d:b0:391:2391:2f79 with SMTP id
 ffacd0b85a97d-3997f932e9dmr4775099f8f.43.1742582170821; 
 Fri, 21 Mar 2025 11:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9hxRT2dy4L0zi6a1tvv2mvPdssWKs/VwK45g1jEhho9ibQ5uHZ1UgfkcIwSB2ePjhSi3/vw==
X-Received: by 2002:a05:6000:184d:b0:391:2391:2f79 with SMTP id
 ffacd0b85a97d-3997f932e9dmr4775074f8f.43.1742582170253; 
 Fri, 21 Mar 2025 11:36:10 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a345fsm3021188f8f.24.2025.03.21.11.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 11:36:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/24] rust: Kconfig: Factor out whether HPET is Rust or C
Date: Fri, 21 Mar 2025 19:35:34 +0100
Message-ID: <20250321183556.155097-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321183556.155097-1-pbonzini@redhat.com>
References: <20250321183556.155097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently we require everywhere that wants to know if there
is an HPET device to check for "CONFIG_HPET || CONFIG_X_HPET_RUST".
Factor out whether the HPET device is Rust or C into a separate
Kconfig stanza, so that CONFIG_HPET means "there is an HPET",
and whether this has pulled in CONFIG_X_HPET_RUST or CONFIG_HPET_C
is something the rest of QEMU can ignore.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20250319193110.1565578-3-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/i386-softmmu/default.mak | 1 -
 hw/i386/fw_cfg.c                         | 2 +-
 hw/i386/pc.c                             | 2 +-
 hw/timer/Kconfig                         | 8 +++++++-
 hw/timer/meson.build                     | 2 +-
 rust/hw/timer/Kconfig                    | 1 -
 tests/qtest/meson.build                  | 3 +--
 7 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/configs/devices/i386-softmmu/default.mak b/configs/devices/i386-softmmu/default.mak
index 9ef343cace0..4faf2f0315e 100644
--- a/configs/devices/i386-softmmu/default.mak
+++ b/configs/devices/i386-softmmu/default.mak
@@ -6,7 +6,6 @@
 #CONFIG_APPLESMC=n
 #CONFIG_FDC=n
 #CONFIG_HPET=n
-#CONFIG_X_HPET_RUST=n
 #CONFIG_HYPERV=n
 #CONFIG_ISA_DEBUG=n
 #CONFIG_ISA_IPMI_BT=n
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index a7f1b60b98c..5c0bcd5f8a9 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -26,7 +26,7 @@
 #include CONFIG_DEVICES
 #include "target/i386/cpu.h"
 
-#if !defined(CONFIG_HPET) && !defined(CONFIG_X_HPET_RUST)
+#if !defined(CONFIG_HPET)
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
 #endif
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 63a96cd23f8..01d0581f62a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1704,7 +1704,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->sata_enabled = true;
     pcms->i8042_enabled = true;
     pcms->max_fw_size = 8 * MiB;
-#if defined(CONFIG_HPET) || defined(CONFIG_X_HPET_RUST)
+#if defined(CONFIG_HPET)
     pcms->hpet_enabled = true;
 #endif
     pcms->fd_bootchk = true;
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 9ac00845340..b3d823ce2c3 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -11,7 +11,13 @@ config A9_GTIMER
 
 config HPET
     bool
-    default y if PC && !HAVE_RUST
+    default y if PC
+    # The HPET has both a Rust and a C implementation
+    select HPET_C if !HAVE_RUST
+    select X_HPET_RUST if HAVE_RUST
+
+config HPET_C
+    bool
 
 config I8254
     bool
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index f5f9eed2d0a..178321c029c 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -13,7 +13,7 @@ system_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic-timer.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_mct.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
-system_ss.add(when: 'CONFIG_HPET', if_true: files('hpet.c'))
+system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpt.c'))
diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
index 42e421317a5..afd98033503 100644
--- a/rust/hw/timer/Kconfig
+++ b/rust/hw/timer/Kconfig
@@ -1,3 +1,2 @@
 config X_HPET_RUST
     bool
-    default y if PC && HAVE_RUST
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5a8c1f102c2..3136d15e0f8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -103,8 +103,7 @@ qtests_i386 = \
    config_all_devices.has_key('CONFIG_VIRTIO_PCI') and                                      \
    slirp.found() ? ['virtio-net-failover'] : []) +                                          \
   (unpack_edk2_blobs and                                                                    \
-   (config_all_devices.has_key('CONFIG_HPET') or                                            \
-    config_all_devices.has_key('CONFIG_X_HPET_RUST')) and                                   \
+   config_all_devices.has_key('CONFIG_HPET') and                                            \
    config_all_devices.has_key('CONFIG_PARALLEL') ? ['bios-tables-test'] : []) +             \
   qtests_pci +                                                                              \
   qtests_cxl +                                                                              \
-- 
2.49.0


