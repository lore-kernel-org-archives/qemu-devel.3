Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC47CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcs7-00034G-OP; Wed, 06 May 2026 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqs-0000Ou-5D
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqq-0001AU-HY
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ba840146so57404565e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076225; x=1778681025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p3+mBWTr+gywNcALvVWo2llrDpelHbSPx6IEjp8iCFg=;
 b=wDkqfhV2rsivvF7ZA/olDyXhD9enYA2D+z+zrQWbBPAROjSn4vvJqg4YgrPGIzCG7O
 ZsxJNQI7IVq5u0Ol1XC7//uYR1sAQK6wbHGjIXlmPrlv6OsUKr3hcAmcNBIxZtUNqQDM
 Qnj0JvBeYXRttRdwLv2GMrinajZ6flsZXsRvkZxHpNZZFh9yRkyhhViCdCP1S64GXq2b
 g2lOKdeJSnGGQM3QfNvXcrZYreNlAvXqOG+hE7+fUtGTjKtvxg7pCH7q5VV6zSvtVp+l
 Ek0sr+4WZbCIyWgFw5v8JN+meY05+ejsAVtUJVo1d03+D72FRFuwdv12/0Glx7tDqwVu
 vYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076225; x=1778681025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p3+mBWTr+gywNcALvVWo2llrDpelHbSPx6IEjp8iCFg=;
 b=LPvAxMrdmF/Ry+/R0UNftQiSvSINZns/IkcBaOd6uY6sLre54ZdGNh61gXW5965W2w
 13AbI9iggyxOmrGvnfVhAoI4t6Oxbbn3BWoqEdZcoTNHKul5UBuKNzzLI5Q3OUn04Ntf
 lWv/5ag4eOPKmNLlQu5a6VvAXLcZwEOmkCZgrXRIGg0fLZFhtN4S7E1uTNO22zeVSWf7
 C8R3RrRtkLMSzTjjOcemDpg8ms0IcJ0jVDsh/Qc9idSaIqcpNqZh44ZLTpVWCapO8iX3
 K9Ybn7gXNCtjtkdNnvz3Qs2R+iE7mft+fODUDy4YGVXePy6tM8NBoBZ+NY/mEG+bLNd2
 o6SA==
X-Gm-Message-State: AOJu0YyIg0f8C021UaOywam4d4Azz6fttt0X/KEb74DT7mw8oN02mwNH
 yb7+EkkieCijPWfXp7Qjs4mHSRNR4yak4jt20dA+EttEWMJCoEkwIgQxPcZBa0S9nq1X5O1ZlL3
 g5k4UQQ4=
X-Gm-Gg: AeBDievJlhtUTWGCr59qN/+btTcYlD/v/zbkV4pC2TOzBD76gtNGM3eI0peZQV+wCW9
 Zvn5JAmNhGwXxRqXj86+WF8FTJahCoX0b33iK51HmyOH3dXFGh4OwGHWvWl0M/1Mnyw40f7rcOO
 fx56Jet0twUstL1XCzwnwZwCdaO3XYcHOaf6zQGYJKCKBfxKH+OCAJk6K6NXvsBUi/WvcTIkPzD
 k138cKNbDCT+dCE1jil4FZP/1hv3PBvqGnk9g+bYCndH+CoN1UN+gBSJduoLk8p8lV5piyp41JB
 3kZWvlugIPwS0oKS24n64hAL6z3BJPQ0kzAnbWwKzdIsIAAhwOlsOipmQjByBL412blbSwcapdl
 HvvhH243n+PyqdQj6d9nZF1zRczjWzZSreDapVJaUE5baItjqZHmfm1xGipYiOvZTNQ4H/DBET7
 0AA99Trr6NeanPSFntYmEUWvt0wD9HQT1lJYZa8Dyu8DyBgwA0TJawhfCjCCt655mPJqVosNXd6
 xLr3lyntxI=
X-Received: by 2002:a05:600c:4881:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48e51e0a697mr40023665e9.1.1778076224524; 
 Wed, 06 May 2026 07:03:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm49547775e9.4.2026.05.06.07.03.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 064/110] target/m68k: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Wed,  6 May 2026 15:54:36 +0200
Message-ID: <20260506135524.20617-65-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

Restrict m68k_monitor_defs[] to cpu.c, register it as
SysemuCPUOps::monitor_defs hook, allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-29-philmd@linaro.org>
---
 target/m68k/cpu.c     | 18 ++++++++++++++++++
 target/m68k/monitor.c | 21 ---------------------
 2 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d849a4a90fc..f704a6af613 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -25,6 +25,7 @@
 
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
+#include "monitor/hmp.h"
 #endif
 
 #include "cpu.h"
@@ -602,11 +603,28 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
+static const MonitorDef m68k_monitor_defs[] = {
+    { "ssp", offsetof(CPUM68KState, sp[0]) },
+    { "usp", offsetof(CPUM68KState, sp[1]) },
+    { "isp", offsetof(CPUM68KState, sp[2]) },
+    { "sfc", offsetof(CPUM68KState, sfc) },
+    { "dfc", offsetof(CPUM68KState, dfc) },
+    { "urp", offsetof(CPUM68KState, mmu.urp) },
+    { "srp", offsetof(CPUM68KState, mmu.srp) },
+    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
+    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
+    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
+    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
+    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
+    { NULL },
+};
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
+    .monitor_defs = m68k_monitor_defs,
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index be7411edca6..3e0df40a6b8 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -21,24 +21,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 
     dump_mmu(env1);
 }
-
-static const MonitorDef monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


