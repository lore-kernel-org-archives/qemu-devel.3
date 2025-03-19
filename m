Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E246C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuz8R-0004X4-Kw; Wed, 19 Mar 2025 15:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuz8O-0004Ve-5v
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:31:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuz8J-0005PS-MU
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:31:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so58125e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 12:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742412677; x=1743017477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ndD5zb6eNRPpAj+IA6PiNhhpA+CeGvhn+/G8C5LC0k=;
 b=va0NnyJSJ+sUY0cdcSrAXmFNhRLYoyOubQ4QR56ndx/NpAaBZ4pMhdvopPHCD7wmaa
 efs6Et11g6aEp7pqDkKo4tkRxH9FlAHgdqoRUrICGWeZrxqyUSb95UXx2tNcdk0HO/gT
 yHl906HG7WEwJtA7O0XA9aj+uTDRQi6X9GEgERbRRi/sqHonhtEuSuFgov4VW1yaOP8X
 IEhKpyF8ifVKKe4ba6h8fe66fYcRM7ymZxb7qiVD/evWFcFNkMQAQa+DElnvPUbwvQkM
 nsDtqOG38/RIfLBVoVC3FibJ/V+5ZMFJSSv+cLRqimn+hWS5adMpq80/vSkc5dAh4zln
 Qq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742412677; x=1743017477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ndD5zb6eNRPpAj+IA6PiNhhpA+CeGvhn+/G8C5LC0k=;
 b=f9EGLlUZo/QIycpapakl28CwXdrnnNEb+aP4T1eRaOF14cno5IN1DdOhnAR8Z7gSIM
 zivI0iFwQphmrvVKlOQ+HdKN7/S47AKuyOwZsC6SrmDc3+ArBYva8HhZm7vqjTJRVMIP
 H9TDOdKAVP224OU5kJIj6epjGemqf9oGY09n/QEp4snIOuvxqhIvdj0ZMiYaMSKOJJGT
 slWpfL2CXGtk2YNj8Y8SsZyegLfcFD47pPAA+bIAV/TJJBdJH8SBR0m/0eYShHMgTKwd
 D473qq96+5RDODhN7JPf1P2g67vPkTR0Ux/8+KcA7fVC7ErTkIOrW4CtgrG5RBrwQt02
 9qwg==
X-Gm-Message-State: AOJu0YzvwUmsEi4jDTu7l3vfpQE6dZqxRtezZJijHI1vAN0fR65Ams/Z
 xKdBK5rQbfQZgAl6+YdyGXYcmaNPno3Gbi6uKa/g03zf6dOedaAIPrPP8suReeCfZEk2WMj8OvD
 6
X-Gm-Gg: ASbGncsan/1jsW2DSN7EnjeGVCE96vRH1a8tefEIk0Gh0pqP+h3K31YN/5klxsAA8ZG
 96Q5Qu0rsaImaPtRGtS67NdHLBxRyHR9KjN7Zg9uc6z7tXxpigOQEH6ou/FQqMJsEWzf8rGmM9V
 G6kMco4lQDQWLIouya0SyquQt/fLE8kiZtSBPKbyM4Ur2JzyB8y60gjlYldkUoaEkd8rRn07+fH
 YKOegN5LS6c5p/f4UEZrTLkI4i2r9R5mueKj6r+DsdHebvkxz7ddNs4y+ocNivJc98JSDefArVX
 MKO0eAPxI3fMsgFGuCtILqXHsLFcAdj6BivZlA9ZNceVtQL8qio=
X-Google-Smtp-Source: AGHT+IE+IZNF+/opYmJfXUWxZFeK40VmrUXT92c68AzxLCSjPXrFXwEuIDbbg25AbYDzTNQCPcRbtA==
X-Received: by 2002:a05:600c:a4d:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-43d495442b9mr3942705e9.12.1742412676763; 
 Wed, 19 Mar 2025 12:31:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47196sm26790495e9.16.2025.03.19.12.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 12:31:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 2/2] rust: Kconfig: Factor out whether HPET is Rust or C
Date: Wed, 19 Mar 2025 19:31:10 +0000
Message-ID: <20250319193110.1565578-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319193110.1565578-1-peter.maydell@linaro.org>
References: <20250319193110.1565578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Currently we require everywhere that wants to know if there
is an HPET device to check for "CONFIG_HPET || CONFIG_X_HPET_RUST".
Factor out whether the HPET device is Rust or C into a separate
Kconfig stanza, so that CONFIG_HPET means "there is an HPET",
and whether this has pulled in CONFIG_X_HPET_RUST or CONFIG_HPET_C
is something the rest of QEMU can ignore.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.43.0


