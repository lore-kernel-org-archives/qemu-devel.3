Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68A110987A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPa-0000TF-On; Fri, 20 Mar 2026 12:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPF-0000FF-VC
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cPD-00008s-Pv
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:09:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso19268745e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022938; x=1774627738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MlMfDpt1UrnWvCHRhzu62WEH4lx9fXnycrYi+XszbCY=;
 b=lu/w54jb97CXZaYjEfQCZ1Qti4cfIETEn2ej6NP3H3rsHkAlZXbTHSFrjYMzXX9UjB
 I7pPb5avVLcJX/nTq5QGKwEq5qU2R/KlrQppJDoPbk3T74Eq4DGii1GyYGMwIVwAhkf3
 nXFbCX7NEfrwOdDde6aCkX2OcCMCDFSmpYsQq0w5UERnTGEeFIpfEFiX72ZNn5uNnouo
 t8BuNrHINgiig6RY4ejx23Ji4ugJC3QL8dyuFiUfR2PZCjqQG+eqCIi5QAR6YZ+BExHb
 jGO//TP/mAvMEkHjuuwnmZc6la2ZU/fSkV54LfKbRhIWpg1c2QAAb0BJvHd7fM67Wlr4
 r8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022938; x=1774627738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MlMfDpt1UrnWvCHRhzu62WEH4lx9fXnycrYi+XszbCY=;
 b=kE7Kht8PxdRy84MGmb3iNqjqoOAFx/pWxrf1sARrE/H80uNXSKuvzcFPtll2NYqIGB
 P/gw5OZ6vgQHAyRKC/67e+zWIZkKOhztUOW0fXE1QNzkjQKK/V3iVhyWkQR0O4d2Na/n
 zHZUXxaOGZyHf94wV5dQZ6JbOOcwR1CRtMtDK6dxhtpJ1+iBGju1NFZjXI/4iDmQUPxd
 hQWk8xpcxfnzk42FC1m/xf95359evaRIdhGdIeWfF8YAy7kbIf8WsUbiPRJjOaDuWjQN
 Vb73/g0VqRTnlddFKx+ZPWtUj2Mr1DZd8I6CV4WCkzyf8ZO7ykGowlafj/FP4AncjMeQ
 9eqg==
X-Gm-Message-State: AOJu0YxzeMU7cFpNjzGZQmKylgdgew52ufx16DVEsPpELOmTzt1VuQxl
 O3onudLZghrxHidvIeZCaICqemXtbEUVvK9KizQXMf4nESjW2A+A7HUeULrbirNUKih5H2AYanC
 2Ba7Abfk=
X-Gm-Gg: ATEYQzzoAOjowMa0ktJIQdfUd4D73exMCylfeQWrfB9jM7fuWif80+2vVxX5r55rapT
 vNFdedbIn8rOzcsdzgwl6GyIw/LOkHFD/UNA9lmmMLtsOhNhxkPqtQgLBQhcfxGpNYcKfGrbXv+
 8JzPoHFqejUxpMSNiZP289kj9o8IVJClCgimE9wl/H556bEa1PlTFXptFjffJvPKMViYNRi+8aE
 BKo8b065+g+62sc7VAdHDLT5eEZZfSR7EteveOZ0uZn1OoglT0c3WW48ezxoik6UBq7cJ7a84vx
 DGaz5BE1VrlSpOo/CarM6XWipmKQMhm6JK+8KC84RW+u2SOO/uq5r+iK6kGucF7lWGQF/ZgjgLp
 oXVcm+1HYTy0yp7MWXHPxH+E1OkafEffXnBNZydz3umU7IFNCKCtHctHh1105nDvL7QNZILi+XV
 wg04mY40YSgY6S3ZzVokWsE28wWlHgfHebi4xC156agRAbmHzNUCt6obyxdWvtQnFhbkTHvvGz
X-Received: by 2002:a05:600c:3483:b0:487:12c:e7ea with SMTP id
 5b1f17b1804b1-487012ce938mr37256925e9.5.1774022937693; 
 Fri, 20 Mar 2026 09:08:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe7e2665sm82629185e9.6.2026.03.20.09.08.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 06/10] target/sparc: Replace legacy
 target_monitor_defs -> legacy_monitor_defs
Date: Fri, 20 Mar 2026 17:08:06 +0100
Message-ID: <20260320160811.28611-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Expose sparc64_monitor_defs within target/sparc/ and register
it as CPUClass::legacy_monitor_defs hook (taking care to not
register it on 32-bit SPARC target).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h     | 2 ++
 target/sparc/cpu.c     | 3 +++
 target/sparc/monitor.c | 9 +++------
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ac0eb9f0faa..83f6859019d 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -7,6 +7,8 @@
 #include "exec/target_long.h"
 #include "qemu/cpu-float.h"
 
+extern const MonitorDef *sparc64_monitor_defs;
+
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #define TARGET_FCCREGS 1
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1493336e7a2..65468ceeb78 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1096,6 +1096,9 @@ static void sparc_cpu_class_init(ObjectClass *oc, const void *data)
     cc->gdb_core_xml_file = "sparc64-cpu.xml";
 #else
     cc->gdb_core_xml_file = "sparc32-cpu.xml";
+#endif
+#if defined(TARGET_SPARC64)
+    cc->legacy_monitor_defs = sparc64_monitor_defs;
 #endif
     cc->tcg_ops = &sparc_tcg_ops;
 }
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 99abddbf1e0..377c2b18cab 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -38,8 +38,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     dump_mmu(env1);
 }
 
-const MonitorDef monitor_defs[] = {
 #ifdef TARGET_SPARC64
+static const MonitorDef monitor_defs[] = {
     { "asi", offsetof(CPUSPARCState, asi) },
     { "pstate", offsetof(CPUSPARCState, pstate) },
     { "cansave", offsetof(CPUSPARCState, cansave) },
@@ -47,11 +47,8 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-#endif
     { NULL },
 };
 
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
+const MonitorDef *sparc64_monitor_defs = monitor_defs;
+#endif
-- 
2.53.0


