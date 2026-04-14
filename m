Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D89CF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRhb-0006bN-9r; Mon, 13 Apr 2026 20:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhV-00062r-R9
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhS-0003Nr-U2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso77670625e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126735; x=1776731535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u67MdwYZYxVP5k0toQDZeYU1ghiGZ0fFyZnuWFb4BCE=;
 b=jB5T4fiGzKPxRRvun0p7r7Z1MdGiddYRzYSms9G+ma0UsLXaGL/pBgNhl8iG0QcV4K
 wH6LcRSzoSBcxIuaUOck7jQ1naCQyoktjd1itZTUkPjhUxfcLTNaWaOcRVhY9nyGTqFE
 yKYttGANwXCVsimEO3D2M873WX/D65S5/nN0sq5qMO4D2gTuKfZ4BshnGFd26M+TohRj
 Cz9j/AGT1JeudNCnDA2H/dQ/Qyz/zra0lHSnFQMOIW2bM+NK8S8vjwOBmsyy5sFVTGV8
 +Xkuf+6icD+TvtU6TyXhlX3g14Pb78omwCoGrw36VYPiDW+lCe6aEk7NYPOypKPJn49C
 Btgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126735; x=1776731535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u67MdwYZYxVP5k0toQDZeYU1ghiGZ0fFyZnuWFb4BCE=;
 b=oQooOOTRjYmM633Bi+9mwXMYn6njqKpbDMRXAxbOdphcZkfOJJZwHoadtC5MclRQi5
 /j7Em21yRXAopHNkrhU0+y6jgNWyFOtkiUinPUjrLfgi4MLbt931SZkzN4gs0UucWkar
 ve88iOcKpGRRoVgrG51ld+fi7VCYWS3NJtzi6nBPkmYcdgxn7lent4SyqrxTi/27Rljm
 gou/IhCGCsCVGG39PcUj1RO69LpcH7B1DwxSKHn4Gjz8slmagq97c1djnXfVQHqOSYAS
 h7Xiza6+14kUY2etMOJnDnwheXZkaU3GNDASWegzyeiiUCaQo+qItTCjoUXDkF3IeWnX
 zZ0w==
X-Gm-Message-State: AOJu0YxY0mc0GU7tf1VWp+wxU43jj2CIlILS4o6XC6d1TOYj76hVxzi1
 jip2O5ez+x/vDEYQS00TLv/0SMndUvdELYpZ0egzdXGOZCjxppymKIaiuORbRtRA6qkHYbTUb5R
 EZBnG4wc=
X-Gm-Gg: AeBDiesLLCdAE6nI0yWJhQa+BF7AXMIH8f5M+rMy04UIbIa2a05KvuCDxwn3VQolFiI
 tJxFqP0FoVAteIxEiH25/NT5AWQy9nUO2hAKFK5rDXIJ3eU/bfPzXJDftMkxUbzdqfuEkA7PIPg
 AnUhGxQM9K60UoB9g0qeS9MMAWkBnuZLyQC/iBx85kGBDaLVPAamEWxt/cgKgN/8aU4FPyDY9C5
 7RE5Mp+dSqyZ8wnPQvNeheu5W1SEu/AoMoCy5O0VE6ZUho2yJ1zkiuSBg3wp2tDfMgCvfT/k3vI
 T0u+5VbW6TWf9srMRtteI2VDOLcJB/kjVhdZW4zD7XNk9lg1ycVLnpZcTrUwTq2xuPNaj7ta4te
 ITGkCgHwx4Fub5lqYbMlYCcBlUf1tupmRJyPG+zUcFgWW6kYXhoxWMmxSE2hcBhFEMzbE3zca12
 WtbAPhf+7cHeyn11ATRZtS98Vlv+f/donOywAmXe+Qk9WlEecuQJIYLlaLQAbIX6RrcQIutleo
X-Received: by 2002:a05:600c:608e:b0:488:8185:e672 with SMTP id
 5b1f17b1804b1-488d688d2fbmr209037355e9.30.1776126735488; 
 Mon, 13 Apr 2026 17:32:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019d9bsm6022655e9.14.2026.04.13.17.32.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 18/27] monitor: Have MonitorDef::get_value() always return
 int64_t type
Date: Tue, 14 Apr 2026 02:29:50 +0200
Message-ID: <20260414003001.97571-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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


