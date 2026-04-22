Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3976FA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdji-0005gM-2s; Wed, 22 Apr 2026 15:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjc-0005c9-05
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:44 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdja-00018g-Et
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:43 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4705309f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887980; x=1777492780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nUpSige/THBUBTzwIJKy1RlNCPwWe/4+WNp/6YTtfsk=;
 b=uWTKicnlTnC7juK4p2rp/NyMZk3m0OktssKoQsvnpHIfa225GRnQls+KP915hvrS4c
 QJe6RRuibMOsJA6AFhANJ8qSZmA3I1Vr95Yp0aB0amzWsvaf2wukqN9g5cnkUCndWIMI
 LLKWy4y2uwfXrauWUvM/N1kS23v3FrKNwZ0WpanHpLxcmbXppTxMuD7WctXcCez7KEye
 vGMta09dqvHUmxnrpYJAIRTmlCWRdZVmczwrXGT9uQo91j6AzFkaV7q8vXDpBoVybJeE
 eP9OVyfjJWzeoIVBcQXqxKPG36wn0QLZsMRcOlyaYCSOwkdCv3ndviVDBs/aqASaLqVM
 YwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887980; x=1777492780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nUpSige/THBUBTzwIJKy1RlNCPwWe/4+WNp/6YTtfsk=;
 b=duuIKEfp0/zqGkGRS8o6+jiO0rfipUxweGP2p+h3thGPMMnKg3YM8nSt4mpIV9fvvX
 FnH6tjM8JFunj0BHY3vuWw9/s8pw0XKxNb1NAIuRjOLHkrcpY5wENoyHOpVPUnciS2am
 3IqYyrrdB44OXScfQMgBmmLv6fz5H05VHB6T8np/aWdxcyK7k8wwX4lUKpqhzUEUctMa
 9H1/VP4DdOxzXh0HluvkmaoappX6syCu+cLtsN0D1W4goQjqDcPj0AJGOzfVpnyc9pRF
 OXNpYpxIeRrFwL2lfaT41T7Vi4NkHZe1cKZwOWpIZZsRNrudT8o4lOUTpjNTYhqzAztb
 REGg==
X-Gm-Message-State: AOJu0YwmY8nJ1En9NDT1fNlTfagI0OyVyiHalWHLpcwzMTf0njKhBwXk
 D2xfc4/GnKwFZH1rAl41pFpRqcmB0werIz1LASOwQ/wMB5UJuJv/2as/ucJFlvwl1De5jfCfpAC
 Anr9HSqw=
X-Gm-Gg: AeBDieswSShgLktUmnCQ8oBH63zQ9FTw4lTYFEefQD+zt07JgEcMQ0zB8Y8tjGvCEXL
 0dLTNaGSjz7GJ00dowHStDqWVyW79qijdMi/5303NDxEcEwSy2O/3ux7W0wfKAnGd9mA0PSHz0p
 P4EKqpBa18cQqvKRq9xen+v3rSb6v7WV5HtJSaQRIwFF8gV6vyzHhEwwxxhgX2BezNCb8KF9ut/
 hjdGhIZ0jwX6JIdvyB5Ge03yQeYU8R4Yo7WecOGcUqSuf0IhLnTyWropYHtVOUBgqzJ3Y65AMrm
 hov5iclKXVNkmk/nmupSIPH4g/WEVfusCf/PCb43hQ0CAPXpwcz9/jXk4M8FugjU31mY3AHRBnC
 73wFua1UtwoXyx+OoIqUnSOkLCZ4Jgzksqy79uDmFiRH77EhL+SQFK3wVaYs1+QdER22FMjuO9y
 5hopMidnZa4t8Hld6gmAQM+s3y/UcD9lO2wfr5Kndxk3pVY2xgrPhRI26DVoKqN/bxjhj4D1dAS
 k691M+Fs4c=
X-Received: by 2002:a05:6000:1785:b0:43c:fc5c:a9fe with SMTP id
 ffacd0b85a97d-43fe3dbf4e7mr36822995f8f.20.1776887980323; 
 Wed, 22 Apr 2026 12:59:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc0f31sm47628444f8f.12.2026.04.22.12.59.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/48] hw/sparc: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:14 +0200
Message-ID: <20260422195746.88865-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-34-philmd@linaro.org>
---
 hw/sparc/leon3.c     | 2 +-
 hw/sparc/sun4m.c     | 2 +-
 hw/sparc64/niagara.c | 2 +-
 hw/sparc64/sparc64.c | 2 +-
 hw/sparc64/sun4u.c   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 9147d56bd4e..d4a6e917598 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/datadir.h"
 #include "exec/cpu-common.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
 #include "hw/core/ptimer.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 46fcbdda97e..550acdff6d4 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "exec/target_page.h"
 #include "hw/core/sysbus.h"
 #include "qemu/error-report.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 209be380473..1211ecb82d4 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "block/block_int-common.h"
 #include "qemu/units.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index ce7eded143b..16f4aa052bc 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "hw/core/boards.h"
 #include "hw/sparc/sparc64.h"
 #include "qemu/timer.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 2e41785b783..d69ed9a81ac 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -27,7 +27,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/sparc/cpu.h"
 #include "exec/target_page.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
-- 
2.53.0


