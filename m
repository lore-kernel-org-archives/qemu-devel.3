Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B50FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3f-00019T-2f; Mon, 27 Apr 2026 04:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3X-0000uJ-1S
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3U-0002p3-Gf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso140724925e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277459; x=1777882259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YR1bIQJaEN4irJmFXMTH708rYFQjSQ11tGcPtx2WYz4=;
 b=bvnnCjyHdAL2b6drpW1Ch8n0UAYyR7BDi9uRmMJxfuSzpzqJ7mUePtEFehDl3Rw+0Z
 FPEfL1Ni46Q1m3854+mz7aiepOJMg2ugDXNpcWO0irlAXJV6s5kW5/0isV7wtC2xJl9s
 o7AcCn7OEJvXiUMa7GbaIsv7sOM3OMecnbqCaPcxV3yfxgAhOZBWwS8mFgNQjMV8HNho
 xoPsrc1H7zCKMtcOlAaz8RsNgIhytfx++aOLYAcJsQeBpvC7aigO02t54AUAPW6TO6UP
 Js9QHSiobCuvTLP18ocwJ3oqIkN+fYG/zZjk9fu0uZHAucHm7/bwB2ZOcM4iXdKDHkhn
 4WVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277459; x=1777882259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YR1bIQJaEN4irJmFXMTH708rYFQjSQ11tGcPtx2WYz4=;
 b=VmrAllFEtaDfmPFKCgJ9pd94Ysd2nfxNsY99x5yiJWY6mHOyrrrbGnuBF6U21z8xTy
 fXFpAigY638ayTeR0xznw4uhk1rxBfJHygt+vwTs0SMgJtEEvu0cSs1W3Ajq1e/tKmdv
 grNMfkdVY9raF9g5ccxqu/cWvYW3Mf4kTSUX4xFN+y1lJ7a7750+/asrmY+rVgTQxrbx
 VsrCHBr88N6beg0LCMy+gGa/ryhOYk6DycZF7swH3wBHaA21RHpSNKCIumx2a/tnO+7e
 Cs88HVj9Iag6oGSuuK+tAdfi0/MEBudLOhfJ9NaVIJW8Vg/BXXELt+hIFoK6xdNm1AW6
 Tmjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QjRij0PCOIwCXfpt+bPNoZnRgqFlOnN96aEk+xiLumKYfsw2rGNOA/4QksFkIUttpdixgAKDjp/ov@nongnu.org
X-Gm-Message-State: AOJu0Yw8EiRRZVxhDpFA43Q02qkFywklxRvm5tfiRh5wFe0xqS0WiK+A
 5NJfrDp4lB8D0L7bfQikAt7hxZwk87SGPlONBiKiN64J7XSXXg7//NtphHxJVYNx14Sp1fW9uZX
 M9tPtLBg=
X-Gm-Gg: AeBDiesgCPn9pw8zsWVLhtbsZNsIYzG6EWNlSzYGvL4BA3NT0INe5Aj8Q4oUgRLl+Yp
 zRtFcA2GwMKaDvi/TT6FzVkyiwd+RRaaFphNvG/dzV9ZKwB9MX8Av2dDD93ei6vgk04nAmi7qY6
 oFoaW86tzyzLV6aPibpIa0ud9g8scX3Tusk75h0dbWRbuPsq7BsC4KcDFD5Gih3S+X0KqSmOBRr
 ior2MTGCassVLYRsg0pvXFKbzmF4v/FPPGekZi7MM8CDduMvkSq34FeSnS1Ev9TUdLJPgfcvr4y
 tfbI7Sx61cB9PJBtnUyqPKiphkPe3z5UYDSufeWWX6qiX8Sv/vVZTBHACMXPK4DJR4pEPZQYao0
 lTHInWgiSWr018PhDU5gy493tpv2dxE4Q8PwsYA2GE81Vo7NQNSgElfv7hOBVO9rfSQ4tQBLSZh
 Ln3qWPa4L0/zKFRUG3ZG0hq/w5HFUKeX2uoVgfuvw9bRWvUU2dccsN9V+8dYfDThkz2Pf8Rey+Y
 y04dvgEKfg=
X-Received: by 2002:a05:600c:4fd1:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-488fb78ede0mr591820695e9.29.1777277458736; 
 Mon, 27 Apr 2026 01:10:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm877418125e9.8.2026.04.27.01.10.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 29/32] target/sparc: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Mon, 27 Apr 2026 10:07:35 +0200
Message-ID: <20260427080738.77138-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Restrict sparc64_monitor_defs[] to cpu.c, register it
as SysemuCPUOps::monitor_defs hook (taking care to not
register it on 32-bit SPARC target), allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c     | 19 +++++++++++++++++++
 target/sparc/monitor.c | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 77046104284..c6989229da6 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -993,12 +993,31 @@ static const Property sparc_cpu_properties[] = {
 };
 
 #ifndef CONFIG_USER_ONLY
+
+#ifdef TARGET_SPARC64
+#include "monitor/hmp.h"
+
+static const MonitorDef sparc64_monitor_defs[] = {
+    { "asi", offsetof(CPUSPARCState, asi) },
+    { "pstate", offsetof(CPUSPARCState, pstate) },
+    { "cansave", offsetof(CPUSPARCState, cansave) },
+    { "canrestore", offsetof(CPUSPARCState, canrestore) },
+    { "otherwin", offsetof(CPUSPARCState, otherwin) },
+    { "wstate", offsetof(CPUSPARCState, wstate) },
+    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
+    { NULL },
+};
+#endif
+
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
     .get_phys_page_debug = sparc_cpu_get_phys_page_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
+#if defined(TARGET_SPARC64)
+    .monitor_defs = sparc64_monitor_defs,
+#endif
 };
 #endif
 
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 99abddbf1e0..36f3d8d58e9 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -37,21 +37,3 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
     dump_mmu(env1);
 }
-
-const MonitorDef monitor_defs[] = {
-#ifdef TARGET_SPARC64
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-#endif
-    { NULL },
-};
-
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-- 
2.53.0


