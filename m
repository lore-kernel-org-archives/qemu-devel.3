Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7906EFF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3Z-0000t9-5o; Mon, 27 Apr 2026 04:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3P-0000kR-Rw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3N-0002n6-IU
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:10:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488ad135063so90594395e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277452; x=1777882252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWkinHow/eylS7JBe+fWXt/Nq4YrC48hyztEBorpfGw=;
 b=cs0qNY3z/xRPmuigO1xe6Epwlpll1VlMdM+Gla/DCkf+6dkNI051XFGKGKTEfC1Yqw
 BF3fosOGAa+nFRFWuZt5EpimPWnXnoxyROAx4vwZea5vKFALBXI+91RdiY4G6MHujsA8
 GUDVwAnrtau2GJCZyinYT09PUI6koICc6ATkCrQQwpNwcuh5eYl4vW9xWNzjwEIzQXDv
 /D/vhrAmK3zEW9cSZ7SOtAalQ3toQJ6zDG15FVeajU7K9nt6dgXFtVm6gyob+JXmd/mE
 pYbGqTORNiIzMhufv8S9/r3hZMDZnWM4+HjEyrrOwNV6hkpsg1J0uDpO+e4NjG05EPyZ
 cCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277452; x=1777882252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pWkinHow/eylS7JBe+fWXt/Nq4YrC48hyztEBorpfGw=;
 b=mT4/OnTWntSm49jvJLqGtY9dnNZI+4Dx7GrduxLdYWE82Zz6aydiYhMdbZTy1hzkgk
 Imrkt7xWBwmVVQv2/JRhTNl+0OYNvEBy/bqrQ302GpI87QgqBP+FWUCSaaBg1+TZztcg
 ULROiW/nOjMINP3yZzz1L3pgKa3EvzueRinfUueQWK/VcGX5pyKUfW6pTa6slplMjQwb
 EvBwArrcLNXQYrrExUaLKaD7gR3+gsN3N+XhtJGsv1i6dqlcRrwZeK945DFIsYVpB000
 9p9OOFsXPrC3yF16oaZSkThrrR+BnGE9FBE/7O9A1JM5xbSkRoRw3bz0RXs4mVpaLFlq
 sI9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dwTTjF7ZBII9ogt0b5/IzqxzAsTZ9Vqzu8MQ3UXxDbw7vvO8cTvE6jbh7LasVO08t12m54bFCW9fy@nongnu.org
X-Gm-Message-State: AOJu0Yyjw7gNTCTdbdn1TAYVHygwcFNjhaDusbvgdBFZvvnOjwogJCN5
 JYCJqmaLhkslwsASVR1WoPg8/O5swUROOgBL4NDND7dZYeQn7YrEIvS2WAmg6rdoaUc=
X-Gm-Gg: AeBDievcJabqJQ5xP4oEO8H1mkVYQtvmoiLiq9DV5db7+nbFO+69u7Zfn4V4v3ZqfQ6
 i29DfcOwNzx7ofi4C/eD15TeG1QjNN3PtPnDlYh/sP+BW6uZSb3pCwTIhj04wCuN2FOSsm9+BCz
 r5ORZ/dhakmJULjSogXwa0cmt6iTr8VA7N+NHtEBz5jZiE4LKy/ul0ZVmCWKFgFeekS+dhvioJP
 hcxZO/hFq7RkC9O99xxtAvc9yqKqcAELMCYFdX3eNYPVYh1XInrWeb0rZaODdfdGKEv9GcwfeiJ
 R9M2gU562ngM9pVP3AVtCs9xGGN2Y+yViLONVVdExZDQes74HJdLRLSONF3hdudG3LzPxIGxb4k
 TYc7WePqQnFRKssmvIaOrbNVyl6Bk8jSPI0lXACmoE//SeoqTJuCEoflNcPjPmoieoSDVo9XW+i
 as4Srk5ORnU+0NycEUsLquviy97meGYe7RzxUjH/nuAmSVyMhhxTJtL/msBJqKzySdbFPFNK+eV
 SIc67IsVak=
X-Received: by 2002:a05:600c:c0c8:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-488fb78b8c5mr430143325e9.25.1777277451990; 
 Mon, 27 Apr 2026 01:10:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5c4b9e8dsm113167865e9.7.2026.04.27.01.10.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:10:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 28/32] target/m68k: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Mon, 27 Apr 2026 10:07:34 +0200
Message-ID: <20260427080738.77138-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


