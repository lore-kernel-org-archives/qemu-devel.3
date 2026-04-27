Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DF3FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2n-0007IR-0e; Mon, 27 Apr 2026 04:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2m-0007Bw-0M
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2j-0002TP-7d
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso98654235e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277411; x=1777882211; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HQd4kWlVL3tTuUUEKzzbm5wkvsPG410wtgsY2aydV/I=;
 b=HpnP6B4lSgWNfY/dMvsTmCiZxr8ZESgCwH2xTd8rTEechp0y32jyC0xelF9PYep//S
 WJvwDmzTVccb7hVC6/YmeMjhjaxBvjLuDax0ZKe4Vc9juZnhVzoC5JfM79LFc2fhsQ1L
 yjipzvkzFXYotCyhqpEB4fZqUNBgo3zwYKR4Md6Xr8JKnbNaNW+ZYs9Nd1M2/RMFX38C
 NDdrN9uBGbwOM6/EHj0frEDae/5sx4SIT/YcuOZkKCY+traeOuHFavAmEgPtYfrSxaew
 Q+hRpjNTLpCIUxntMosf+UUdO5t/0DN2xPxHF6hB8BMsyn50lwzQ1aK7JK8nbhkUJNgT
 GLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277411; x=1777882211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HQd4kWlVL3tTuUUEKzzbm5wkvsPG410wtgsY2aydV/I=;
 b=WTcFNRxryazDiFVAJBp1LpmQn83WBBPYGwg4PEYWDwXd+iPJ0tnfBzZm4jcaQDIGdp
 S/+uNqZl3qKNiqcPDiXagg3EZmes6iUIJBjTWnmsbrBN0RgUY0bBtU1Oo9UYqOYEbiDV
 ztb1Rc/3or1nVs9ivzW6Y9Q5mSyRnykXv6USMTQDLIgIcRkxf4wuJP1uLISoKxQFOHrV
 8L3+xYZ48Y83s17rLaDScffIoKR3HyH7Qj/TlCiOoUmAzYoUTf/xPAVIxBjsATvTrRa+
 WvOnf5YVIqRWJF81HQI+PpUupwUNPDCfEgH9E7Kc33nyAd63XmuMzPpF74yWrjwXer2s
 BBgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RhqgvANpkydVmgNYjyIywCwC59CVKlVN8NRIQquambyNdh+C6J/dDVj4RpSuQNC/+SJtPueEUBUX6@nongnu.org
X-Gm-Message-State: AOJu0YzrYtm3MjvyPF2+anqqrHungOPrrl3A0WHFPou7CJXXR4yeWaev
 sy8uhWyF/xQ3BP4hM7paqcZKkxLNNEVoaMDNYOSfJPlkjBNcfwldd1ivyyTNEh0qVaTc0u6cPq/
 1hhxgeCo=
X-Gm-Gg: AeBDievj/jl4zpg3c+ynn1LmsnXkWT3qJj4OiUHPCtvX9DxboTzk7SxaAZhPOTGjEpA
 ZbNR/C4PR8guhJhFTZ2MOeko7u8glPbtDNlP+koGsTvht6yMY3ZXQKf7MRW8Sm73bxYi0QKcaTz
 E08/giCuhsIBTriRpDUynz/p8qqleXXH1ygYLUQ/PoEJBb7roWWAA/P0KvgJ7NYqctKHzZP7rc0
 TtT46JcN6UIv2W4Ac4yu+qtmz9DWD3br/n4XKiXKohcs0fnzuZ9Omd/lMrMDYcuuDvhaKkIRWss
 OoMj+OoZciBJE6YvbCLhWDFQEdxOmdQoQZRRObQZTpUY3slfp6e4ygnIqci4nUnjWDHbyfX1egP
 apybUea1QDcXLiva2eC/csyNtUFQHdUXmL3tpsJON1rOJMZsISrM+8UsDsJUzp6A/jJjoErnovg
 2C6lBCUJ/8b6Cjghi7VVTFP1Bt6LqiEO7dn1IHOX3uyEfD25L957gjFJDzbsJBylAqUAmxrrWiK
 G7sUzTtjaI=
X-Received: by 2002:a05:600c:5246:b0:488:a639:b787 with SMTP id
 5b1f17b1804b1-488fb74fc0dmr600756645e9.11.1777277411297; 
 Mon, 27 Apr 2026 01:10:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm856930445e9.3.2026.04.27.01.10.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 22/32] monitor: Have MonitorDef::get_value() always return
 int64_t type
Date: Mon, 27 Apr 2026 10:07:28 +0200
Message-ID: <20260427080738.77138-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Simplify MonitorDef::get_value() handler by having it always
return a int64_t type.

Let the single caller (x86 targets) sign-extend the returned
value, directly handling 64-bit CPUs in 32-bit or 16-bit mode.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/monitor/hmp-target.h |  6 +-----
 target/i386/monitor.c        | 11 ++++++++---
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index 008c1a6570c..ae34ca65ded 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -27,15 +27,11 @@
 
 typedef struct MonitorDef MonitorDef;
 
-#ifdef COMPILING_PER_TARGET
-#include "exec/target_long.h"
 struct MonitorDef {
     const char *name;
     int offset;
-    target_long (*get_value)(Monitor *mon, const struct MonitorDef *md,
-                             int val);
+    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
 };
-#endif
 
 const MonitorDef *target_monitor_defs(void);
 
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 977f65fe16c..98df5c7fd12 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -593,11 +593,16 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     }
 }
 
-static target_long monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
-                                  int val)
+static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+                              int offset)
 {
     CPUArchState *env = mon_get_cpu_env(mon);
-    return env->eip + env->segs[R_CS].base;
+    int64_t ret = env->eip + env->segs[R_CS].base;
+
+    if (!(env->hflags & HF_CS64_MASK)) {
+        ret = (int32_t)ret;
+    }
+    return ret;
 }
 
 const MonitorDef monitor_defs[] = {
-- 
2.53.0


