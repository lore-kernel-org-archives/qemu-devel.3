Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E02F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHw8-0000yM-AK; Fri, 10 Apr 2026 15:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHw3-0000up-9f
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHw1-0001Wj-3t
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:54:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d17bb1c65so1645347f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850871; x=1776455671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQcummkxUOYYVBuFGYQ78NMsb9ycB7/JcbKGuZBFsZk=;
 b=kDnSkJhUbdGGH0YeXAdmyMRvkxlfwU5iDk+NAEZfHBiZ7TqiIVa5ptkvVMe9gunV7h
 ggQQ1G/McIXUZDiK7cMsysga0OeY3LTiofa654dRZpkL0/ruzDfQiGRH/guoeXOdZDo4
 SHwycANaiWd8vHyMhVQc2FeJgLwmjC/RgMWwL5o8qUcOjBt3oJWcn1qJ7X8/YWPueBeS
 HoPgBbg8BXYFApTOaqi11KrrdcKIck3OvxpT7jmkBoPX1mgJ2Z2UcU3PQ5kTxVmYXNKN
 NUrGFMBfUPzLbn3uCc1R1aeUPmXPNuNJYpMy5/PBUBZWwkcT/IhmY+BdP4+xmcmaqHtp
 oexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850871; x=1776455671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQcummkxUOYYVBuFGYQ78NMsb9ycB7/JcbKGuZBFsZk=;
 b=D3P+DREtlttL9JXwFW7ZtvFhbkY7g3JpnH4bkvrW0x0csHKqetiHjetfbBgrq8oakE
 tGv6FzK/sCrFX1NLpwjbyXZ7lsY2NfqyOxrf6R5D7lmS3mnpejvBmH4OdHHq+o6PoLqw
 3X9XThGvby3Jq/HF/zsXvtPWwHppSUhJqUiRvtd2upItkbAt+f9BMmpTfEo6c9lmBeq9
 U7tLzMlwxsWGZMS+GjTIVevxpsEDy4TSWc6VYmc0YtS+93yHYqVLgNMhnk27RVS3ci0p
 MDChqKwzvp1kFb/0dwc9vYM5QG/4qnZZZNzlp0t1pT4BlYuGG74f5ArD10TDiUY5EzCb
 oMQQ==
X-Gm-Message-State: AOJu0YyZjplReKYbqM4oeA/WOEavAKji5WMgXVP3dJNRwOTltFq0W06H
 O4aguf3SzWjXb5/0Ja4wgSVqJzNv1KRDQhOJV/82WAg+nwfZyEPQUl2mCRZXimptRj4Krxn1Owh
 kVHehMgM=
X-Gm-Gg: AeBDiesMbQFI/HE2boGCNMQ8FwWvWTB95px4C0mWBm9fkIE08FON2waEgnMHUxvBZXL
 dld8n0pbWkpb6mpVwddW8/iOB5esZ12rMyt/NqIlsYbmcbs5iX/XE5e632RfhfRAnUvhLwACKmi
 56TDJqrfCQ4AoI54kqiu+WI7mSBxsE2rRM1zPdjL2ysxdWTWJW64tzVyAN2mrEJKkyeO9Li5fj7
 fCh9UX/A5CpmIXhhjrG01qm1f55bAne1MZEFUs/hKMclVs6KCqM8/Sm4Sr2iVpMDz796cI6B6eF
 4OgBdN25iGZkjbJwCWUN+eIdyGoHBW2NVKsgSeDzLtH1VrwitcDARqi8W7YKQymS3v0KjDY2bQW
 fMhRsui1B7+xbKHJ5o7aK4nxzqA27UCxSDq+H012P3B4B0i6cNlK7/5Zzea0gLKOqulkzaZzK5M
 CLEH2AdXuUVdfCXokSfPKID5nZASI14HU0E0aZjzyJjlKoaSGGyH8vHHKkcckIPooLo1Y7RpJA
X-Received: by 2002:a05:6000:1a8f:b0:43b:a21e:9c19 with SMTP id
 ffacd0b85a97d-43d642c080amr6854206f8f.38.1775850871272; 
 Fri, 10 Apr 2026 12:54:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5d85fsm8603605f8f.36.2026.04.10.12.54.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:54:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 09/27] target/sparc: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Fri, 10 Apr 2026 21:53:03 +0200
Message-ID: <20260410195323.17937-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Restrict sparc64_monitor_defs[] to cpu.c, register it
as SysemuCPUOps::monitor_defs hook (taking care to not
register it on 32-bit SPARC target), allowing to remove
the target_monitor_defs() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.c     | 19 +++++++++++++++++++
 target/sparc/monitor.c | 18 ------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1493336e7a2..9c5175aca34 100644
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


