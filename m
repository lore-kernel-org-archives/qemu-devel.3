Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B25DFA1FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 19:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjE-0005LA-Ql; Wed, 22 Apr 2026 15:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiA-0005BS-G1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdi7-00004x-Vc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:13 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891f625344so42747435e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887890; x=1777492690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=01/Zrekkut2XUNz7VWSiSchcmjpSKG4DzbDEzH+bDqI=;
 b=LxHRjpH00P8XEPWm/N7PrL0CmkYzUEfDOuTr7aZbnQoF18DdLo5D+gKOmAehdPSk+Y
 lMjrYnDBmqFhswmBiRrK8qZzjfqA/4/7pbF6jKUBw5ZGrDnLvtZZmCrx5DJMOvxDJiH7
 AqAQ0w/XEsCU0/IY22Nw9PCLl5P6TAUF0zVqnH+H4d/AwaFIcTGqU8b815UjDiCHaTAh
 uRvBDgvitoy6C0BtL0GS1M30KE/baAmHsjyjCvnWHm/gqkIO1Kv1R51sqaYR9nvNFIRR
 1wgsoazlQR5zovPuYzBbs1TiZDEXOz1YZ2uxcMfOmV7cQajWpuV8fJFLilhcInboHGPp
 AWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887890; x=1777492690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=01/Zrekkut2XUNz7VWSiSchcmjpSKG4DzbDEzH+bDqI=;
 b=aHVaqod5MwQUAyNEXUacwBsiFZd0OV8XFLCt5S+h5QaCzyJ0049kJhF3LR7oE9tL+m
 eVT0/0WplMK4wYrzXi7aa4HIop+M/C8d8ez8jtzvc27KHgDKwoZiqd37HN7za5yd+1+b
 j1x3CI2LJfgz0AXOaFPrBeo2y+dvUhRzVhPd3C5AxP35ZqavgPixcc8RDvS+duaNjqFx
 GHZObvaRThwAbaXQHnbwb3PLw6ukeh2cZm+bZwqtynup7PG9rl2iWsfty5ssdsXTjRNh
 zFhNGtKXeN5S8sX27ozOzXssiQFITY1z6xefV4k3FJtpo4LyupBLuNLkq4qzjVASVA7p
 qs3w==
X-Gm-Message-State: AOJu0YwDBo62vjEU357IGvo8wvpd3g+tzlQBdK5eosfoyQZ/6etWh4y7
 zMO8pdEr/9uUGjRlQQ+42laTalOnqoSeaW2MxTiYHg7KdDIsG+mgVDPfRMmepfIt3oTSo5hBYWt
 Y5kkaZ5I=
X-Gm-Gg: AeBDieuQ5em+BMcWeLDwwnb+Am/26251kbufRUWFSjr0XjOJ4OZbXyE39jJIJ/B2WuC
 dFiYq5uhhN7//mUBZtcg5a/4j4UKlAd6+ObMLpSu0lyViDy5KYkAtDAs12ujmqGvI6oW/tfAPPb
 NmML3qdQDnI5gRzLfiKZDe2Av6XGYMOf+z1++GJIdxk3oQErKks2Apzf/1WuGfVEbM1D/A3y2jN
 tNYDtdELwCEVV+ouawHN7eo2xt5j5kU0Ee3yXtcvy8KQpyFr+BimoaCSChyi0Z08sfgQGx9XO0E
 Uow2yY2ykltRwuO/KzmAzNz4z6Zk5R/HAcglwv6fL9Nj0OwbCoR30hWCCTTy2uQQhtwjLbr2n4+
 vKbGuIObIKbmtWfCs+EhoqaVK3SuWs5aJeWqiaQ9yLSEVZgo3tp5Et+9js5LuxTMEER3ayWdIr3
 YfOi04y3mPJbkTbbMOHDPAVqPsU4iyLUy7FmlC215aS7tpG4s0SZTGlHzo/n87dEFWB842IVAfc
 p90pb45nPQ=
X-Received: by 2002:a05:600c:3055:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-489032bae49mr160803755e9.6.1776887889813; 
 Wed, 22 Apr 2026 12:58:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78d1bcsm207343765e9.5.2026.04.22.12.58.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/48] hw/alpha: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:01 +0200
Message-ID: <20260422195746.88865-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20260313062055.2188-21-philmd@linaro.org>
---
 hw/alpha/dp264.c   | 2 +-
 hw/alpha/typhoon.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 2ab3c147471..f928e0cee82 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/alpha/cpu.h"
 #include "exec/target_page.h"
 #include "elf.h"
 #include "hw/core/loader.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 7722d4fd009..e32fed86f9f 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -12,7 +12,7 @@
 #include "exec/cpu-interrupt.h"
 #include "qapi/error.h"
 #include "hw/pci/pci_host.h"
-#include "cpu.h"
+#include "target/alpha/cpu.h"
 #include "hw/core/irq.h"
 #include "alpha_sys.h"
 
-- 
2.53.0


