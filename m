Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808A6C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5eQ-0007YD-2Q; Tue, 11 Mar 2025 15:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eJ-0007OM-BM
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eG-0007XX-W2
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so7196065e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722739; x=1742327539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPwG81CDQDlI7rnw58FUGfF/8AkVAzJZybrmEGNU+RE=;
 b=wpp/gH/OB2EzlFGecczjpGJg925Assl/J4UrOu9kvt45ND8w1Xm4Np5mhaiEEvnzEe
 nnTiRO4ELmu+3imvwPit492xXWiGvi2Jtvitk9xHQhEqLw5P4C/K5NzKhkGtr7TSJqJc
 Muog+REnAVSntNrQ3iXYf++ce1ZGFepyIPo6fGcHdILJmaALZX8cLl23yps8X6WG4ITE
 gaMcJ6KCHrGHglIGKO3X7bF8plK0n9a7BJ7cdNC0Non0GZhW2bxEX8R6tPIjRm6M7XqK
 Om8MVxdkk71c7O73m0aV73tamN4nu+oGw1KITp6MirmNUWXxQAwHiryqeGcMEWSrHLKl
 7mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722739; x=1742327539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uPwG81CDQDlI7rnw58FUGfF/8AkVAzJZybrmEGNU+RE=;
 b=nsHj4Zad9B8aE3cG/6ghIA+aCxqSsC42ruRKDPpSwcZlmKA7Hf2Xq3Iv26BwLPwVPk
 820gYPZTFtCzSmMGbJSuvAGeSSUtdZ/Prms4SenG4cxTtYigFcwQR7t0h9Jji6lXG7xL
 cJp+SNfOybyv83OfLPVi4uHlrd3xsCfhlh/gXNL9wuuLlm0Pj1Qp5BbgN2NMD1hYSFPz
 Z+n90r+25kCZSVb5Q2wHG2Rs72TNCTs0kCk6SoxsAUSpEOPtS8HEThpX10jE2755m/cr
 QBJD0PyNdxDsLIPokTxiDvUMiRXcypNHPu3kwdiR9RKk4UGBZKKGnowLVumZ7/XOG4h7
 JhtA==
X-Gm-Message-State: AOJu0Yz2OGE+SFuLai0oAhOLeHQidjQ5GjZxxVc0K49fZ+NH9AesjM5+
 ouQcG6ohU9ydS3UGDsGBSh4yqfB1gAbcj5+vmFSaAnmjszQ6XAwNmBiP/L4WydsduT7rUZ0JWOT
 GEn0=
X-Gm-Gg: ASbGncsVRqsSHrtwGQaMIm5EtJ1I+royfX9R966aTC2wHQkvuEyjxFunRjATcUFKzvq
 uVlKNP9y2oDywcj+UxRUrHrvKz/7WpElh25opKVVDvpe3gfBeQgtNW+e7QIDGxKhnY9Q5L1VsrI
 DFVVUUlNnTTgmzSKOaqEeCQuwO0wtRnQ+LoPZSg2ihaqQXABLNCCZo+ZAJppxOt52gb/138Fffi
 Wau768qrltGSNhLyPSUToYcYw6JLRTQMHul1ZzzLGv2fnSaUAMahyrBWndhMHyRxrczuXZ2DVUT
 S8EaE4VEpkpR4NBXpe4rbRATo8j4i9BzK6WP6NNBP1X2DdV5ZbkwtIi1xjuDq76J11lnja3E/1m
 X+ubcaGoI5G95uAteXoA=
X-Google-Smtp-Source: AGHT+IH4ttBvMP2B6Ovxh4s1geCjYjf4FIIGXb7l0Daqd3JmFfHyF5nMneZC6tFyoNeClWmWUQjwlg==
X-Received: by 2002:a05:6000:2cb:b0:391:ba6:c069 with SMTP id
 ffacd0b85a97d-39132db8c73mr16630802f8f.44.1741722738814; 
 Tue, 11 Mar 2025 12:52:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d073555e5sm20578135e9.4.2025.03.11.12.52.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 11/14] hw/i386/fw_cfg: Check ACPI availability with
 acpi_builtin()
Date: Tue, 11 Mar 2025 20:51:20 +0100
Message-ID: <20250311195123.94212-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Define acpi_tables / acpi_tables_len stubs, then replace the
compile-time CONFIG_ACPI check in fw_cfg.c by a runtime one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20250307223949.54040-4-philmd@linaro.org>
---
 hw/acpi/acpi-stub.c | 3 +++
 hw/i386/fw_cfg.c    | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/acpi-stub.c b/hw/acpi/acpi-stub.c
index 790bf509e5d..fd0b62fad9e 100644
--- a/hw/acpi/acpi-stub.c
+++ b/hw/acpi/acpi-stub.c
@@ -21,6 +21,9 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/acpi.h"
 
+char unsigned *acpi_tables;
+size_t acpi_tables_len;
+
 void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     g_assert_not_reached();
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index d08aefa0291..a7f1b60b98c 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -145,10 +145,10 @@ FWCfgState *fw_cfg_arch_create(MachineState *ms,
      */
     fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, apic_id_limit);
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ms->ram_size);
-#ifdef CONFIG_ACPI
-    fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
-                     acpi_tables, acpi_tables_len);
-#endif
+    if (acpi_builtin()) {
+        fw_cfg_add_bytes(fw_cfg, FW_CFG_ACPI_TABLES,
+                         acpi_tables, acpi_tables_len);
+    }
     fw_cfg_add_i32(fw_cfg, FW_CFG_IRQ0_OVERRIDE, 1);
 
     fw_cfg_add_bytes(fw_cfg, FW_CFG_HPET, &hpet_fw_cfg, sizeof(hpet_fw_cfg));
-- 
2.47.1


