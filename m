Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E20FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdjY-0005ZX-M7; Wed, 22 Apr 2026 15:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdj6-0005Jm-0A
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdj2-0000QC-TV
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:10 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43fea39e066so4755923f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887946; x=1777492746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QeNmwRW1c5GvvK12yDu3Rfr0cCFHKWNwjEOndIyqAOY=;
 b=sTw+lTLlsiHdSZigJdt5Sk1mME2xZ0RLMuY4dY+eg8eqa3kC/I3Y5DFILSSdhskWhK
 OO4lQq6uAXhRpTwrWjks967gafgVsOVjSa5pbL1tp/nNfWbN5+HHXUtrT2Qn5H+ekMfV
 5MTaVY6zYfTucsvtibeBBva76ezEQ71W/E7C5xCbo9UaxEOEagfs2pMdfVy4gH1GM0U5
 PsF5CTBIIaH1x4n6GRRHJU5FZMbGDkTyM3YxRomveNzlKsmKZQ6RK8uWYwJ0mANjxcRU
 zki1tg/1RceBRFx7yDqSn6YWWNzqyxk6Fwmu6VxzuvsDJLeEZYi5iF2S4FsmWJPSIeWI
 KBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887946; x=1777492746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QeNmwRW1c5GvvK12yDu3Rfr0cCFHKWNwjEOndIyqAOY=;
 b=EhNEaxkpA425AivycuWUBCRQ0JtaDXt8wSFyTE9ghn7USnEbOUkgXsEx9URnGzqYlG
 Ttwd0nFNWzcoFp30AdJVZCyL6K5k5cRnUKMM/LxWmBKM3NHitQ8ZpU+K7D8/++PPEiQJ
 nWrSs5N7L9TzGOPwWoP78KCP9fNQzWlBVy+CcXdNfFtaIOQx0AQcD/dBYRnYuL1QumXD
 Z6jy1puYWHeykEZ3tHSN7Gho8lIBcTDentZ1zCkn0+Pw9X/MXomB8B4Gip7ap2smV6r7
 wgbXr3GF6LDRk+Y7EVEFtpkoXrJMDB32NrFyscWwLnj5zWyOqsRJHhXCpVaURLQ42FBv
 jN0Q==
X-Gm-Message-State: AOJu0Yw0gywpXs5uk/jJI4N/c3Lm0E+P5gK4BzSJQzGkg35Kl3FPeCb+
 QFNRmr7jJkLTqAEgHH3o92F9FJQQOIyxSi8sBVPebMwfbTf35a58XSDqRCsXvpHsL0HQC01XwwV
 Qhkp69/0=
X-Gm-Gg: AeBDiev0uZWRD04JbXYGMpET3mgvQ0/4TSvA0+04T6xYO3R/9sfYihn3TKsPk+Hhp+N
 AiS7QAEF8/HIPxXV7yCOzPH4HgBNPWo+cAvwfsC8Vtab0Hb5lqjfzDKxaz9dWSV6+FJBnY4AMmV
 5I0xJOyOQVA9fNE+Jn7WAejaA1V58c4C4mtK7ozVaxTh48doPIHWEmR+VXhWhgWFB1TnvHr9NwY
 lUg1J2r3FrMDzhbHwojDBRvyepQMyf/qMlZ+tyFEiODLpP8LLdXf2+dkGBTbs91QHYTWe3O9j+D
 9SBaskEothDdqZG7Cy+JnQ2oR74NmZrHqBv5h/zWpTUtvoX7Gowz8imu6YGP/KetTnRRUkiWEDf
 GxamBCcZZWGZj1inM2gmQtAn/PtI57yh5Q/8tZvL2a+0IxwRs5P1Bkre9YjnGU32ehmDi/1DxLh
 +5th2yNHsmbsf6Dkw/l+rQY0BAx/EQfep1sByVUWbBvtbGnrUrDeQxr+8b7+lWcc5CfX7gFjGJX
 h0iLyJRQqHnOz87Nbs32w==
X-Received: by 2002:a05:6000:1a86:b0:441:1df5:480c with SMTP id
 ffacd0b85a97d-4411df54848mr14504740f8f.42.1776887945710; 
 Wed, 22 Apr 2026 12:59:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm44609012f8f.22.2026.04.22.12.59.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/48] hw/or1k: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:09 +0200
Message-ID: <20260422195746.88865-12-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
Message-Id: <20260313062055.2188-29-philmd@linaro.org>
---
 hw/or1k/boot.c     | 2 +-
 hw/or1k/cputimer.c | 2 +-
 hw/or1k/or1k-sim.c | 2 +-
 hw/or1k/virt.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/or1k/boot.c b/hw/or1k/boot.c
index c18f4a6a9fc..714634b5f3f 100644
--- a/hw/or1k/boot.c
+++ b/hw/or1k/boot.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 #include "elf.h"
diff --git a/hw/or1k/cputimer.c b/hw/or1k/cputimer.c
index 51da226fcde..b35411aa1e1 100644
--- a/hw/or1k/cputimer.c
+++ b/hw/or1k/cputimer.c
@@ -19,7 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "system/reset.h"
diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
index f1b1f63274b..b55105cd148 100644
--- a/hw/or1k/or1k-sim.c
+++ b/hw/or1k/or1k-sim.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "hw/core/irq.h"
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 39f54058ab3..2ff5c084a2b 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -10,7 +10,7 @@
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/or1k/cpu.h"
 #include "system/address-spaces.h"
 #include "hw/core/irq.h"
 #include "hw/core/boards.h"
-- 
2.53.0


