Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2824C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 14:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7F32-0007u4-14; Tue, 22 Apr 2025 10:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2p-0007Yg-NV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7F2j-0005FL-5q
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 10:56:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso3267781f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745333769; x=1745938569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ys1CVx2S8BFm0hdd9mmIlkJ/zaau9sSCXoT1k+qUtnQ=;
 b=zeS/n/2E+iiV2KrPxTsaCzT2GAqZq55n9cx21awkWZ21WyM0OMazuPK7jHZ4twMfuO
 p0k74cihP1iCuD5r5bbcCSl54Qaeo2mPttTC/2QnpOpOnrxRdJeksV70spq/S/Hg0XeA
 ep7iRRTDE/BaUH8UGfFVdOGVe54Hfukbz9ODcaD5DZyIqp6xSYWjQ3yyMK1F05WwBbYi
 3ESIOlJJmWSS5edGC+o0MmMqsiN3XtFGEQl27Zb0fTOmtuY5iPmGF3XIMrbOgb9mCYcc
 p3PAl9+OOTq3mZgqAUl5npyBYZlF5TCDIEXKjc/CscoZu/S5qw+omiyUR4NIGpz0qgxP
 IWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745333769; x=1745938569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ys1CVx2S8BFm0hdd9mmIlkJ/zaau9sSCXoT1k+qUtnQ=;
 b=IQQOTaKqE0+D2mKDv+mWixoIVxxG9g4yHXC23D409hMiOoyOzmoncVtKwCOOlUG2Jh
 yv5nmSGqh899GLRKkkKFvx60EaLuE43H87uCMmbfEsr/01RgvLDM5pDXtHs59o0xBHFc
 0LLbNCR1Xs4O9zW183rdJMbFKQHCqtBtMnWSsBGRjOBhFo0Z1kYgsh78cyBLvZfMJGnM
 JA2mVCTc2I7J++MBB5DvBWYLEgRVEBTxUrUX99XBNjYKd8dWZ58+cmxlNAhp2a6hYP2a
 VA0vkEVNBH9E2ERT93LdhVU0eJmQgEgMoBmDeEaT2VFapH3joRfw7UsclVEOTEFuENgE
 +sPw==
X-Gm-Message-State: AOJu0YwyF/CB5bwNbhYDK8PDsHzuWehVq9QH2PlJb8gNZuoZow9lKl49
 zvmu5sGIyOkX0Ftf8bbwlcbx9ynHRMKkSDthWvG/q9MdVazFdNWa3BHiAMuq68dSLHeKWcgMdUe
 /
X-Gm-Gg: ASbGncuIEtxRPDNAraR2CPYFRz9tiDimGKmQFSEDMgGFYolKo34DqdqirFGTKRjakC5
 fitlxHwhiI8Xmp4yIUfqMxivdTpHdPuR47tCtQHiOCVYg/oQUTPzP0ZMnNwydm+ncg+yXy9Wk4c
 BgovEjhzEp5xivj9q52XEoY7WDxFWtTg34l+6zMSFrK1TcG/D5OTG8KFJjOZidsqY9ttUmqkl3m
 8XlwCZcSCiyILAFE2R7+iHRHLLD9JBY2h//wz/AZQ0+A83iPKf+dehZqjq15RPiWvwnGvCspo8P
 mFFv8vov+VIjC2TJBNhbx3RixSyR4OZrcuJL5aVs8o+TG2iUZDoytgWpNPRF3IQkdixzXcymddj
 z44rDxw+rUEWrFLE=
X-Google-Smtp-Source: AGHT+IGUcqFcrsiFdS/t15/nFnyBti+ww9bgfY5ZBnQ0+2BIpkSEcQudoR2bkA/FOG1bHHSKbETzWA==
X-Received: by 2002:a05:6000:2905:b0:390:f460:77b0 with SMTP id
 ffacd0b85a97d-39efba5bfe5mr12107732f8f.26.1745333769262; 
 Tue, 22 Apr 2025 07:56:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4332c1sm15299896f8f.27.2025.04.22.07.56.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 07:56:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v4 14/19] qemu/target_info: Add %target_arch field to
 TargetInfo
Date: Tue, 22 Apr 2025 16:54:56 +0200
Message-ID: <20250422145502.70770-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250422145502.70770-1-philmd@linaro.org>
References: <20250422145502.70770-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info-impl.h   | 4 ++++
 configs/targets/aarch64-softmmu.c | 1 +
 configs/targets/arm-softmmu.c     | 1 +
 target-info-stub.c                | 1 +
 4 files changed, 7 insertions(+)

diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index 4ef54c5136a..e5cd169b49a 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -10,12 +10,16 @@
 #define QEMU_TARGET_INFO_IMPL_H
 
 #include "qemu/target-info.h"
+#include "qapi/qapi-types-machine.h"
 
 typedef struct TargetInfo {
 
     /* runtime equivalent of TARGET_NAME definition */
     const char *const target_name;
 
+    /* related to TARGET_ARCH definition */
+    SysEmuTarget target_arch;
+
     /* QOM typename machines for this binary must implement */
     const char *const machine_typename;
 
diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 375e6fa0b7b..ff89401ea34 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -13,6 +13,7 @@
 
 static const TargetInfo target_info_aarch64_system = {
     .target_name = "aarch64",
+    .target_arch = SYS_EMU_TARGET_AARCH64,
     .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
 };
 
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index d4acdae64f3..22ec9e4faa3 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -13,6 +13,7 @@
 
 static const TargetInfo target_info_arm_system = {
     .target_name = "arm",
+    .target_arch = SYS_EMU_TARGET_ARM,
     .machine_typename = TYPE_TARGET_ARM_MACHINE,
 };
 
diff --git a/target-info-stub.c b/target-info-stub.c
index 218e5898e7f..e573f5c1975 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -12,6 +12,7 @@
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .target_arch = -1,
     .machine_typename = TYPE_MACHINE,
 };
 
-- 
2.47.1


