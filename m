Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393F7FA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkU-0006hK-KT; Wed, 22 Apr 2026 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjs-0005mS-2f
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:06 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdjo-0001Cm-GJ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:59:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d70b3e159so2973881f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887994; x=1777492794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8suQGu1nF4ZqMjD6ewAoA5Snv+bFLYbMG478vQnIU0E=;
 b=OE78cfnHVPqdFSzKI6QjL5mQsUwYEYmfMPnJmxtVisblVvnGWqfKz3gryf2FfePCmR
 tmsaqmRv5fnSdwIfX1J29aw6Cj5mp/U85wthmgFlPj1HfX5SPwUELVnfHmT6n+jPpeFA
 8VFT8hcuRGKyBh7Jd98J78+OqYFRlQkXJoM/ly9esYnuJZOm6loEmihXhtG1eTefpVaS
 a1OTuad/PUi5oenBhYqDpTefY0kxZA/DxZU6X2Cik+ZRylYaRU1rsBVrbOwx06f2lrtv
 ezRgLMDKXtbUxlXuh5EQznjIxaIeNbJo2osN0YuByOabHEWYrPTBO/bTWpUrg2szA9RT
 toOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887994; x=1777492794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8suQGu1nF4ZqMjD6ewAoA5Snv+bFLYbMG478vQnIU0E=;
 b=SCSQoeapl+BPaWrDEHWU3ZB+KxdYGa2v8nd0pIUo1RyEiHvypekWflPfcvqN6AJHSG
 bRcXMsemXfo9qkeDmZJEhuvN3TNRUdMI0iz4p94SH9FfF8FonkLdnyq1YN5+FHbMLIfo
 x61BAM/YVT5HkOwy83IJvd8MXOgY1PD80z6jyKVGITxDFqoBu1CbzB64FDZkVyZWiwbt
 eCSylIBXFe6Wz3L8vGLMkPMlhAgsXBztJAxo7eeFf24SBVva0c1MpqtwvzUg2cIxDd3t
 JBAG2k6z+23CS7DG9DSjHqVqFGXcEOuPeznaVT9gU4T/64IJrZfKHZA3V8T9dNkpUxa0
 wiLg==
X-Gm-Message-State: AOJu0YxTVd4gfG4OSnt40VUzR77nagKt7FSy9X7l6fu2x2wyWwnsxbZQ
 nsd2rCcveOGoEf1jNO92i8QyhrZNIC8ALcy7MfWG3G8O/jUI0f/uxaWwJNZehV/4UREut188wG3
 gyegLOb4=
X-Gm-Gg: AeBDieuq6Of+VzLgbIqFEa3vqTzPQtRqzKGE1/ntMtcmtzNN2ZTUA8kB9LbqteLck/R
 ghXjm19TTMcsavcbDaO8Sz/xfr9WWZR31EIuebdbSyoLKCX6gJDVhNa5AdaVOsQ2XDVGtpvm/g5
 H/ZRV5AS52zMHGkwT54XCTo4VaoMRiV2PeE2gUFKj3gNQkbODAq7HHtxyRKsoxpyeafhPuklEXW
 198VDek7vLRk++q85uEfrRdYNVdObWNvKp5uJt4qjMZZXuNc3Mlm78ReYBtBbcuM8vIBY9qE/3Q
 Kskxl0eFpgvyMxOV8/Z/ohZU+c0ogylJMo2bOAztQeii9pRICz3PByl5NAfvBpnFeXZPucR87W4
 iZMIMsZNbROjV8t7dWvQi9b6BeFYj0JJVOrSjns93wnzG4G1dJUV4QiOtX6X739ltBTBrSHXYJJ
 vY9GR/1SRyMPZuSh7wj25zGUcI+KfQH3Nvz8Yo5olbY74AeaEmC3Qn/s9vmWb/tQzeWM3ypQ4Lh
 ZEvAkRJyqU=
X-Received: by 2002:a05:6000:2211:b0:43f:e94f:3da0 with SMTP id
 ffacd0b85a97d-43fe94f3deemr31637807f8f.4.1776887994317; 
 Wed, 22 Apr 2026 12:59:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a7b4sm44612625f8f.22.2026.04.22.12.59.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:59:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/48] hw/xtensa: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:16 +0200
Message-ID: <20260422195746.88865-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
Message-Id: <20260313062055.2188-36-philmd@linaro.org>
---
 hw/xtensa/xtensa_memory.h | 2 +-
 hw/xtensa/pic_cpu.c       | 2 +-
 hw/xtensa/xtfpga.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index af7e8025e3c..c86ad06685a 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -28,7 +28,7 @@
 #ifndef XTENSA_MEMORY_H
 #define XTENSA_MEMORY_H
 
-#include "cpu.h"
+#include "target/xtensa/cpu.h"
 
 void xtensa_create_memory_regions(const XtensaMemory *memory,
                                   const char *name,
diff --git a/hw/xtensa/pic_cpu.c b/hw/xtensa/pic_cpu.c
index c00167859a2..370a353f1e3 100644
--- a/hw/xtensa/pic_cpu.c
+++ b/hw/xtensa/pic_cpu.c
@@ -26,7 +26,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
+#include "target/xtensa/cpu.h"
 #include "exec/cpu-interrupt.h"
 #include "hw/core/irq.h"
 #include "qemu/log.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index ed24720f94a..5e509216df8 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
+#include "target/xtensa/cpu.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-- 
2.53.0


