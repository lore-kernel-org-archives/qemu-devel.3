Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FE1E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6HX-0007Ty-77; Sun, 12 Jan 2025 17:18:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6H8-0007SX-7Q
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6H5-0006O5-Pg
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:17:41 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso28855785e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720257; x=1737325057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/QB0eCOWglzRhv0POd1a0450MrEr7ITHH+s9iR/zMg=;
 b=WzcRFFukQ/Yek1m5hnh0Gzid8WquR2GLR97HU4biR3b934lhc0v74JJYjqeB9LA9Hg
 sKwQRkpbS3+oSPR09KU0nnCS81qGoIZmp1g2/yVJ2JYWLDpd5uZMNQHCzegevIqkglhZ
 KC4WbHIABgKaXWYRHw4GFNQYgjYX5bEyPBxU2GjbMAHYJp4PEm/Rg7qp+Fc09bUAAUzV
 u2yt2qgm+CN0ddUc3pW7CHKcP187ZWo4NpWm3uFSL5+FubbwT7ptkbGCe4cLWPSHtjX0
 G3Q4uj5zKP80S6VaGAOgb7lZD6Z8Sg/u4hHys7diHoADXwj2PyWHEeHhdAFNW4ErynoF
 RBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720257; x=1737325057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/QB0eCOWglzRhv0POd1a0450MrEr7ITHH+s9iR/zMg=;
 b=buEZHg+XHbJhmnSIn2eymRZsaiL+ICe7X0ghLx67yxi6kh4T+TpdS44FM1IG7IBzUd
 /Se/Q1dkst8vEqIu7XMbQdIxnVTbApYQf9YQjZNo+DlJND3cdWgQz1K6DPHVcg8hRCgV
 vRvlMhoTKr7FM9SN1gZcHHPJaW/NCV8dleFMdXRvETtkmJCeScc5nZqjmPsp1uVQzcZR
 sqreX/Fo0c99RePnog2a0Cf89MbUWjbTcqCs2zrnFXZo2mX1H5g5EyDVFyUaxCLv+bKg
 +UDFX8P4wajrdToNQevFNcExsyJm0JsdRlu48GyY8o1P/N+fmtti3G9E0rWqpdUERyOT
 QFKw==
X-Gm-Message-State: AOJu0YwfaaGFnLN3M22NyYUXn2piRrkOSMGdgmN7RagPLbB5zgYWNsqQ
 aKA/auvQbP7k8szZliXW0qWMubCDc2Ix1M3551h+2DeQz1dUzKB36s3WpuxkL1ywCqh6qcD325c
 wHp8=
X-Gm-Gg: ASbGncv6GawSDM66PYnKZyrV3yrbk6EstN3WRRWENnA/+z6Xtc1i3i2YDPmeHM+DBP4
 yc+vH3ONdAzheuW0lAyqYu6HJ/4a7nRevAh7Ur2vpKM5LjPoncDoHqjg8N9EnzHYCP7+UIzDC07
 tumRaDB2zf7ZN6PMZy87+thGWe0NpEvrPnLZlcv/8NrzcqdfdeUb+yjf+Xj/JS20KtzaSmRhqGY
 2xXP7XK9LJpEH1Q8t8J4TgcGqtQJNXehqIEg2SWWrEGOb9ee1cM76sNrSnF0rXuxkFTfpfpG94g
 dKQp6WiYyGEjTm7D22VKxbug+q5pGoE=
X-Google-Smtp-Source: AGHT+IHVpV9jbQcShCU9uTEQ9imEE4oGKokPvRrRxcwuQzR+G2HMzaJMQ++Z2O5gqcO35UftZXx1QA==
X-Received: by 2002:a05:6000:1f89:b0:38a:9ffb:ff02 with SMTP id
 ffacd0b85a97d-38a9ffc0264mr5293576f8f.12.1736720257354; 
 Sun, 12 Jan 2025 14:17:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c6dbsm10787823f8f.55.2025.01.12.14.17.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:17:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 02/49] target: Replace DEVICE(object_new) -> qdev_new()
Date: Sun, 12 Jan 2025 23:16:38 +0100
Message-ID: <20250112221726.30206-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240216110313.17039-8-philmd@linaro.org>
---
 target/mips/cpu.c   | 2 +-
 target/xtensa/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e3af02a4e6d..47cd7cfdcef 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -644,7 +644,7 @@ MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
 {
     DeviceState *cpu;
 
-    cpu = DEVICE(object_new(cpu_type));
+    cpu = qdev_new(cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     object_property_set_bool(OBJECT(cpu), "big-endian", is_big_endian,
                              &error_abort);
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 0910a3d2904..4eb699d1f45 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -208,7 +208,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
 {
     DeviceState *cpu;
 
-    cpu = DEVICE(object_new(cpu_type));
+    cpu = qdev_new(cpu_type);
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     qdev_realize(cpu, NULL, &error_abort);
 
-- 
2.47.1


