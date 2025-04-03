Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEF3C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UVw-0002zw-ML; Thu, 03 Apr 2025 20:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVj-0001xs-HB
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UVh-0003Hz-K0
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43948021a45so13762955e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724932; x=1744329732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRB41Zr3gSL28OqDvkaeyUBkBJ9gMDVta/60hwAlbGw=;
 b=mNOBWyml14AhBocQyeEN4CJVmVYJM1qjTOeIhH6OO5Lnpo+C1OHaY0PXYDKVNrkZ2Q
 I1l2ECDILyVOF8jkLDvcs46D/E94gLgLYyjM26En+LXxyiJqkjpPd2wk38/A/UeMbwrT
 HtAkZldugyuawFINb3i2jkopGatzWdiea3pnJ1T2UBn/t8Me68/u39bnNKhZn1mfCiit
 V7z2QPg/sOK+nQFh59o5ppX78e7KK3+OYxA8GiBk3dpVWI46ANB4i2ZGxWACeZZih1B0
 tYCzD7p09VlYfgUwBo8l9TLwQuhxyGo1evh+k/o825rp0lGmydTMuCTJ8chW3ObvFdUb
 EE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724932; x=1744329732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRB41Zr3gSL28OqDvkaeyUBkBJ9gMDVta/60hwAlbGw=;
 b=XxG+qg72fz5rM8/cjLlP/X28zeuBXyrz439Tvw0vtmwPQOC0R5oqBv9cNou0LRJucf
 zDTFDsGMk+h36BF+0RkoAJMzkFNcWJm0SOPH5sWkI3jp8Ct7YRSg/65u4Cim4ebPUPuo
 pu+ycMu3zaJKmgLkolldCbHkylmGDvm10ECfJrA5ZM/PIhJVw2VHuDOVtiCShAGiD7Py
 pgBmKo2pknyPc/aP6Clue7qkQhBfmLRxUGYNVDxFVIVse/nF0R0zCV1n8woCoj0v+fV4
 xvZmOTkBzGRLR+YgOF2aj1lm0uChrhB7KXuphEE7pBRMqBM6xdaxFHv7C6Z4cZ6V2h1h
 YgPA==
X-Gm-Message-State: AOJu0Yw5pNCHjGd9DJE975lQO1+s4lu5DDOvajH+pXnpx7CIemOMY1Kv
 zuObx5XwaY4sJXfQ5dE2v9eY9EoJU4+KjWpOyAYcVnMrLiZc2uQRpzswFmBjQBeZQexsBQkDQ4c
 9
X-Gm-Gg: ASbGncsyJcldHlvo+ALKe3l7lquu+KRZz6itaP6e7VHwUwcvhfxZijyKqa9s3Y0ha4M
 ZVco+YWgHbYb5oZ1dyxbJ2RNVgSGg2eHgsX3njCqJfO6Mq+LmcgBnPFKZkEVTpvxzqixPAzitRw
 dEHAPbSYDwc6FNFCRRD81Z8UuWH/EktGsNWHNoMQqXpmMJYtQQBGy8157qDYJeUeqfjy/SFPxYu
 5y1kwDdHCnImbpVDsP6EeFr9NjaLRjBiW8UJP4PqcmBbuVoWy5uTH1H/P8eLLvbeyFI80uDM6B2
 J/J3HRi5bgHWWnw/CmhYykEloguwdr6Z1XgGokiAjsChoVep+3C2sevOdiFacgwRxnjMELpxLs+
 7yNW9o5dqvFbXiAhUhJk=
X-Google-Smtp-Source: AGHT+IF1PQrFyYjAYKz/+5gC3p8MEo0g8rzI0ya5CHlrnRPM4HKURU3ccDERH3GoOsXiCgWmA9s5LQ==
X-Received: by 2002:a05:600c:1e13:b0:43c:fbbf:7bf1 with SMTP id
 5b1f17b1804b1-43ed0da49e6mr7124545e9.30.1743724931659; 
 Thu, 03 Apr 2025 17:02:11 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795630sm35331985e9.29.2025.04.03.17.02.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 35/39] hw/arm/virt: Replace TARGET_AARCH64 ->
 target_long_bits()
Date: Fri,  4 Apr 2025 01:58:17 +0200
Message-ID: <20250403235821.9909-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Replace the target-specific TARGET_AARCH64 definition
by a call to the generic target_long_bits() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e241e71e1c3..a020f1bd581 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3133,25 +3133,25 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TCG
     machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a7"));
     machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a15"));
-#ifdef TARGET_AARCH64
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a35"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a55"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a72"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a76"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a710"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("a64fx"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n1"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-v1"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n2"));
-#endif /* TARGET_AARCH64 */
+    if (target_long_bits() == 64) {
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a35"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a55"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a72"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a76"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a710"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("a64fx"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n1"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-v1"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("neoverse-n2"));
+    }
 #endif /* CONFIG_TCG */
-#ifdef TARGET_AARCH64
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a53"));
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a57"));
+    if (target_long_bits() == 64) {
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a53"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("cortex-a57"));
 #if defined(CONFIG_KVM) || defined(CONFIG_HVF)
-    machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
+        machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("host"));
 #endif /* CONFIG_KVM || CONFIG_HVF */
-#endif /* TARGET_AARCH64 */
+    }
     machine_class_add_valid_cpu_type(mc, ARM_CPU_TYPE_NAME("max"));
 
     mc->init = machvirt_init;
-- 
2.47.1


