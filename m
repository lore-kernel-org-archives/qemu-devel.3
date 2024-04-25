Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79228C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwtn-0000ij-No; Thu, 25 Apr 2024 07:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsa-0008Ot-B6
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwsW-0008TK-CN
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41b5dc5e0d6so1749735e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714042977; x=1714647777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdAyeGYkrzEliXsZ63G9PrJ5ByexuubM31tow2m95nM=;
 b=fHYlOULTE2a3fsprAAta1qZ2ezY1pfD4k4EXW6g1tW/+LwQ65TJGGdnhuLJYqvfAgX
 aICle9981skz+Jnn8Cw0Lxp52xaZICqC9g1Ad27mEuONz0ICz8IHmzsGH2on+6oPUfRE
 PQebi7rXgU5reXb4kferau3jlWdS4d96dyZk99psuTVjObzaR+/J2xZhBBmymJOqF1DY
 tHOfzp56SEYb58KS/qB0IdJ8fFVmgrIiDZF1wfAFo9KlAW1xi07fKeLUcuCu6LGzuK5w
 f1SAgVSJ6i3sbeQyv9nhuI1EZrpDY4/uKi3VROvH286YMNrOqz48LSRJR0TBl4NcUG36
 1b7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714042977; x=1714647777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdAyeGYkrzEliXsZ63G9PrJ5ByexuubM31tow2m95nM=;
 b=fw1p4ZwF/HdbIZJqG68UeNqj7C9+18owzdizJ4v6Q4xMoqfpaJInAKbg3U/ODiZz1W
 FIdbTBn2H0J4O+GjJ91NCZ6UNZ3LeQCBdlcrCUwzb+POiapf06h8dSf/pO+MC0NyjWNF
 H0vAExSPhaD7dk2JN/ExjfVpTdaxEY8mh8/u31J4i3pFn1QXz8QmwQrFuY/Jt8DGZzgf
 sJXPo6b3EFCWEHgk1KahZcuH1fpgAUhqAPpzuQnDTudkctNJnkx/I2vx3WZ67K72hkTV
 pWYQtJYEsBon0MrvMF87OVwmrFp9KvpIujJvRJh3hRlM5Vh/FyfIR7HCLYZt95kZ02uP
 veKA==
X-Gm-Message-State: AOJu0YyW81UVVMYo5A2dIulbAmj1C7/NYyw+qzo0T8W/zVc0ZTPGVrUH
 iP5HIuTOVVixec1WZAf4l/bpYtDN2ilBUqqHucwDvSjHAj3BCfmfHMBS+u9IaA1+qIpD5ghkDJc
 p
X-Google-Smtp-Source: AGHT+IFeW3acT9aERuuRclTexJYBdyBpYe3GuhkGTdOm4UP1aF2NxUWvVkQ1Y32yGXUUjpZL9cegSg==
X-Received: by 2002:a05:600c:3143:b0:41a:afe1:6d77 with SMTP id
 h3-20020a05600c314300b0041aafe16d77mr3643130wmo.11.1714042977351; 
 Thu, 25 Apr 2024 04:02:57 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm30648723wmq.14.2024.04.25.04.02.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:02:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/22] hw: Fix problem with the A*MPCORE switches in the
 Kconfig files
Date: Thu, 25 Apr 2024 13:01:43 +0200
Message-ID: <20240425110157.20328-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

A9MPCORE, ARM11MPCORE and A15MPCORE are defined twice, once in
hw/cpu/Kconfig and once in hw/arm/Kconfig. This is only possible
by accident, since hw/cpu/Kconfig is never included from hw/Kconfig.
Fix it by declaring the switches only in hw/cpu/Kconfig (since the
related files reside in the hw/cpu/ folder) and by making sure that
the file hw/cpu/Kconfig is now properly included from hw/Kconfig.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240415065655.130099-2-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/Kconfig     |  1 +
 hw/arm/Kconfig | 15 ---------------
 hw/cpu/Kconfig | 12 +++++++++---
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/hw/Kconfig b/hw/Kconfig
index b1cc40d6be..f7866e76f7 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -47,6 +47,7 @@ source watchdog/Kconfig
 
 # arch Kconfig
 source arm/Kconfig
+source cpu/Kconfig
 source alpha/Kconfig
 source avr/Kconfig
 source cris/Kconfig
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 893a7bff66..d97015c45c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -678,21 +678,6 @@ config ZAURUS
     select NAND
     select ECC
 
-config A9MPCORE
-    bool
-    select A9_GTIMER
-    select A9SCU       # snoop control unit
-    select ARM_GIC
-    select ARM_MPTIMER
-
-config A15MPCORE
-    bool
-    select ARM_GIC
-
-config ARM11MPCORE
-    bool
-    select ARM11SCU
-
 config ARMSSE
     bool
     select ARM_V7M
diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
index 1767d028ac..f776e884cd 100644
--- a/hw/cpu/Kconfig
+++ b/hw/cpu/Kconfig
@@ -1,8 +1,14 @@
-config ARM11MPCORE
-    bool
-
 config A9MPCORE
     bool
+    select A9_GTIMER
+    select A9SCU       # snoop control unit
+    select ARM_GIC
+    select ARM_MPTIMER
 
 config A15MPCORE
     bool
+    select ARM_GIC
+
+config ARM11MPCORE
+    bool
+    select ARM11SCU
-- 
2.41.0


