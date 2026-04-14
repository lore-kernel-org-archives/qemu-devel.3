Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4627F531DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRha-0006L4-5p; Mon, 13 Apr 2026 20:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhL-0005od-V9
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRhJ-0003NO-UF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:32:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so3591125f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126728; x=1776731528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKNy0httwE1FyS382gLwVKQ/bynBm+cBhYz+ssqf0KI=;
 b=q6KPoyIoNK4ZOVABhSFlOpBMnraMKPBBGg+mAdtgyeFqnpKq6U+rG/3MeP8KNoAoTe
 wlS1nvIukoJpLr/sZEYdzK63ybvV34tNnLKhBUSU41lf+fjrt1tQ7jcgE4heworaASmd
 SV05x+JU8iK3tMgNuIvcqU4A0XF/ceAeKHKN7YWsOAbOqqd/NFJ/oHAqohk7z+48HbXP
 RFP1OWQKOOdI3DC2cSIYJeJd51AN/d5sUvDyUMnLWUtFEQ6YnwZTIWZOmKebTtABaZMF
 VItlokQnZWTMypE1mE9/+O3Zh/GBYR/oz+Lyswt88RsKY7AL+3pLarJ6sIL6a1G1D34K
 CRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126728; x=1776731528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xKNy0httwE1FyS382gLwVKQ/bynBm+cBhYz+ssqf0KI=;
 b=bnCfKJ46lsreHbN+HZKJfEp+Yd9INExy6RVoXumBcWggTdxsjL+x4H/OC09hA+/Bhl
 MjvwrYycwoJsClZSwIKJLeXftWBmBSUq0m8FvAg9BjaEdrlSYrX0m+ZlAW7CRYNmCHMm
 05yKhue2hnzspBCy/kp8AIRG4lXpoOtV2I2upW1bLoMm6vKUya2bOo/b2rRLYxtJ/0N3
 DGFSNO9UwOQvXjhrrafiaN/VZX4ryXj3EE2yoEyZ14bWKkKgIUNr3uftqx92ytuhVYhG
 8+GR1aCeTX4nmJaaESmeR6TvuVjO/PUXAxYrhnSQNSggGh6RKt6GZrtPjxsGnpUQmO0e
 xuoQ==
X-Gm-Message-State: AOJu0YxA99v+mFJW1/Kn/yGFlcC0lov4HGAnCXafP79OG0Cf9nEsoIDW
 DScZIlTWFw/Lihnze6Cz4WuG6a8lBoJB+Ijdt+020ITioIW6NQC/O0zxfiGIEOVnZ7ojbNq9RC/
 VaTTJ6NE=
X-Gm-Gg: AeBDieuX0zCke90DgfMDBHjjmBBUptYZeexYDZ6KvkMi0ikEB6i36wi2q4j5Dhzu2Bs
 Hhwq+Fe0SLMGtcUvtxUbRfi10PfHGDTtRyDWsnSGRs6FQUTBYAobTJmMaXaxQGSUH5GOye7QQhp
 jQf+/umJsKvyJPMikBQsXa+WlpfF7mNkY3/vD7hjZvs//fgMirtjEy9RDimf/WjrKz1A9JrE4OR
 A0/z8SQfNjIMSsrPQ/6Avmz1GIV5JsrBKH337/u+G18uMczdugVxl7WKiNB4ZivEwYc7Y4d5uc0
 k/0FqhkB2g1hMhAi3z3gIt7IdFu9xhboKX3uAM8umsRwQbAHU1EdAd45lolMsIpNRHFlBJJCy99
 8XuXZHH6pb1P/xaJxamHxU88kfcJByH/enZawnInWsROGb43PYWNR9TezZHTQSuUY0L8J4NXHup
 p1zpoQ3s0XLF4XA1JPHe9hZTNBnPdbbLTgsxLdCjYw36wdbTC3N59JQwPEdk3onaWVzbJae/bv
X-Received: by 2002:a05:6000:22c1:b0:43d:7ea1:fb53 with SMTP id
 ffacd0b85a97d-43d7ea1fbd4mr2618357f8f.33.1776126727664; 
 Mon, 13 Apr 2026 17:32:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7b219576sm9618493f8f.19.2026.04.13.17.32.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:32:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 17/27] monitor: Remove target_get_monitor_def()
Date: Tue, 14 Apr 2026 02:29:49 +0200
Message-ID: <20260414003001.97571-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

target_get_monitor_def() is now only a dead stub. Remove as pointless.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/monitor/hmp-target.h   |  1 -
 monitor/hmp-target.c           | 14 +++-----------
 stubs/target-get-monitor-def.c | 29 -----------------------------
 stubs/meson.build              |  1 -
 4 files changed, 3 insertions(+), 42 deletions(-)
 delete mode 100644 stubs/target-get-monitor-def.c

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index ce0bb1983cc..008c1a6570c 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -38,7 +38,6 @@ struct MonitorDef {
 #endif
 
 const MonitorDef *target_monitor_defs(void);
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index 46ccbd14aec..c2ddcd67e51 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -66,8 +66,6 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
     void *ptr;
-    uint64_t tmp = 0;
-    int ret;
 
     if (cs == NULL || md == NULL) {
         return -1;
@@ -86,16 +84,10 @@ int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
         }
     }
 
-    if (cs->cc->sysemu_ops->monitor_get_register) {
-        ret = cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
-    } else {
-        ret = target_get_monitor_def(cs, name, &tmp);
-        if (!ret) {
-            *pval = (target_long) tmp;
-        }
+    if (!cs->cc->sysemu_ops->monitor_get_register) {
+        return -1;
     }
-
-    return ret;
+    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
 }
 
 static int
diff --git a/stubs/target-get-monitor-def.c b/stubs/target-get-monitor-def.c
deleted file mode 100644
index 394e0f9a7d2..00000000000
--- a/stubs/target-get-monitor-def.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *  Stub for target_get_monitor_def.
- *
- *  Copyright IBM Corp., 2015
- *
- *  Author: Alexey Kardashevskiy <aik@ozlabs.ru>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License,
- *  or (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
-{
-    return -1;
-}
diff --git a/stubs/meson.build b/stubs/meson.build
index 398822f47fa..2bf376e15e3 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -74,7 +74,6 @@ if have_system
     stub_ss.add(files('igvm.c'))
   endif
   stub_ss.add(files('kvm.c'))
-  stub_ss.add(files('target-get-monitor-def.c'))
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
-- 
2.53.0


