Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F3EE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVkn-0002zU-Ii; Wed, 11 Dec 2024 18:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkl-0002yC-S6
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:23 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkj-00020r-JT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862b364538so4192f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958259; x=1734563059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CyImSr/vh1Hw5UwjATJ/bss7/ONFU9Y4xODnyBojcs=;
 b=UQAyced1MDSkY9dJpr7ZzoiGcU6leSsIWzdg+uN+OfiI4vs3y8qqf2cVbV2r+xVjXA
 l46bzLnmzu+HTV/6h6elTVgNo/c5QQo+J6k8Y0v7gMPepHx1zfOwYx4+C+LVJlFjYe5/
 SnfqQTEG2Qnx/TeIiu9c7mXxHHwGvcZeG1pXVvlUufm6oHncsPMhNk6PwWcIv01YRVPV
 /Y3jkA3FFyO8edFyRICdRUh3DZzee0eJmW8CnmZqz+Gee+5RDV1vjR+J1wSibIlbboeF
 4/2Y3AdvykHsmxufl72bKuZItzYJC0JyxBFFtqpX2K21yZrgrB/WOElfyhCyuePIn9sY
 xEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958259; x=1734563059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CyImSr/vh1Hw5UwjATJ/bss7/ONFU9Y4xODnyBojcs=;
 b=g22aPwDasLvTKf2CHEx00LadcwkVJHZ92KVrPvaCbdMUMsuJtEs7i6WHgs4603u6Be
 tkgsipafYCbkrwBwansknocBlziw3CbaWtE+77iPsVC/PTwKwPv8lHAEE5SUpiXoGog0
 mCPMjN2If5IAEChsc5y4b6nr+pGiFBNhTPuDGoeGqDN2Ea0TB37ZgDhKeNpRfbqfSznv
 zoWp69diaQXaYtRYOtddxeG2jiOieRXQ6bLZS6f4gmFKlKU7eUsVx39HprZ9uy+cpjEN
 896l0UkHs07cJPw5CcHPiOVd4ID5WxSS1A7Fob6SE7yBlIdU1MTroaXk5cmmD5Ib5IWV
 hX7A==
X-Gm-Message-State: AOJu0YzgxOsPz19Ktvl37HzpVrzWZVsArlFKFVXUlEEEWzQ4ym6h9smh
 IFpe0hZaZmSOL7Ix+zpkHrBF9JhvxKrfczKLjVGbNkEcUjB1k1QhfEE+HGSkjp+tiAhQdnzb1v2
 5
X-Gm-Gg: ASbGnct4r04C3PSpqTVLhj86cUYgtARhGAKsm1eat25GaehauRYodOhD0nQI+xQs/4H
 heN6OvmrEpvVfPQ2Mi5rWU+6TtwiPIZz7dUeWc8msSavyakFL7R+6LjzJMW0F2CiotqComxakYu
 iwPd90/kC8/E8+NbzFIDZFEqDdM/3dRIt1ku5jcXcdXW/Ng0FHtKIwVn0GN0ZHcMMKGhU0NiXy4
 McQvAqQEerug0yZlGdbpXjJbmduUJ9TP9+jvBUEBl8yeRt0JOZK/3EK6Vk0axqx5FXX5T9kqa5u
 S+kXCcULHNakYuMRd+cyD3cNGOLIBXEPEA==
X-Google-Smtp-Source: AGHT+IHqHQT7Cea2Wnc1ed4/tVD7++I0hUY9dC1tLd1/pRYYVNW7km+DEaIbfVAJ6hA0okp2xjfubQ==
X-Received: by 2002:a05:6000:2cf:b0:386:32ca:7b5e with SMTP id
 ffacd0b85a97d-38788807815mr629903f8f.16.1733958259604; 
 Wed, 11 Dec 2024 15:04:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824bd8b9sm2332636f8f.47.2024.12.11.15.04.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/9] hw/arm: Include missing 'exec/tswap.h' header
Date: Thu, 12 Dec 2024 00:03:52 +0100
Message-ID: <20241211230357.97036-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Some files indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove
the former from the latter, otherwise we get:

  hw/arm/boot.c:175:19: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    175 |         code[i] = tswap32(insn);
        |                   ^
  hw/arm/npcm7xx.c:326:26: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    326 |         board_setup[i] = tswap32(board_setup[i]);
        |                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/boot.c    | 1 +
 hw/arm/npcm7xx.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 5301d8d318c..30ba98d52fb 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -26,6 +26,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/units.h"
+#include "exec/tswap.h"
 
 /* Kernel boot protocol is specified in the kernel docs
  * Documentation/arm/Booting and Documentation/arm64/booting.txt
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index af04c4b7ec4..3a5ef26f689 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -28,6 +28,7 @@
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 #include "target/arm/cpu-qom.h"
+#include "exec/tswap.h"
 
 /*
  * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
-- 
2.45.2


