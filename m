Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849E3FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcs9-0003IF-Kw; Wed, 06 May 2026 10:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqz-0000Qd-L0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:04:03 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqy-0001B3-0S
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso49612425e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076232; x=1778681032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v9IZia9T54nsdk1tWUK1kZA/j93ztaFsjJIvNzWV3m8=;
 b=siaXdHJOjM+alEQvRltXpx4FOr81K4dTtWB9YdDhQjuyTAWcF0dH6YRpzRSbSoTa+N
 WCtAa4i9qk0CLwbfZ05w4G1vAEkOLP5gKry11WqephDWbUfsLbCaXinL2VLhDa0iUBuo
 lAx2ls3NgmLoUpUM9TXR8f75pdo7NRn6kbM/riuOxH+0D8xppwzemyi4+DSY0Zlaf13f
 OlTNKb4uNPMAshHZ3CLwoRBFpXqp0EMbLPXfKyhMT0FZbLDMmOIG2q9kBJPw/76k8HF4
 ZH6SR0Xpe7sQRmpLDZZjXIMPWTYDSR8JfnNpFI6MvmlS9KyV+7gfTlKuzzRiz/DqsW4a
 Pq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076232; x=1778681032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v9IZia9T54nsdk1tWUK1kZA/j93ztaFsjJIvNzWV3m8=;
 b=k2qSTojZKpB3o9Ey+0NYMJ3pucg7s6u90VY+NrZ+qdCpYDh7wjmvV93Jrz20yRTx4d
 Pw5i83FP8SFXhmeifu7MIbmD0ktz6w7aJ+J3Lt3jVOkg8pguG6fA52yu8wZ0pXf2yipz
 sYXl3aRQnWa3GtAnVH1LhkwTIEl6f7wRsgokf0fb+6FX30dTvK1tTZXvFGw5wqMFlr8m
 UZJGMHCkbGiqFLEBiuSa0z4Ri5Sz9KgF5ydFjDPijOWalxVBsPD8FQ/rvIYLIO/z6nSV
 lCdihHlQXuiiALwGgf3mksNt/cvsTqlhQHs1CiLz28JRo+qVYu8jkNYZm92cWyj2UPHi
 lWog==
X-Gm-Message-State: AOJu0Yz4Had42F2ILhWWVWRI18FnBjpUOurAbYv+pz/N08NAbvoEQdjg
 vKqnZF02XDJmzh5kQ0Nwr7zLnVIGVhbtD4PxzdhAaUHocaRNBegqgvvaT4PwepzHNEVapuwZckn
 2LMnhF4s=
X-Gm-Gg: AeBDiet2D6XC0UenRWZfF46SglCeQX8AxHwmu/6S1C3vVcwkqzT9NFCx9Fdt7WfH8aE
 0FP3YeC/e32z0FklZQhKO6hUMJ/iN+f+292ztNoSQrqHRoQD5PUG8gQl74XjBBn30b/QWgHcF4I
 q071kM8Ue7YbVD95rSMFFDuUHiEYhvNCBCFjTdD/ldZW8GjXTPWNiV0MXnfZ4pHeK/6WLZd1zWK
 CBM6ZP26uOozgG2rzhU2FrR5jySdc/JPFiadMaBTGWmmjUqiGEyg4F3DrpGcNpz5HMmYTenRW8L
 QIqqWEMeO7WzOzsiF0FNVBcK9OoBgXWeTnk98CnjOggwnf9imjFJG9oRs1sjRfgheFQefX2XIq5
 i2sukpw8Cj/890XjOlA8RLkPp74WNF73PqS/5V0VSOKWTHCXwiMCU9hxKbMYXDYctpZDfyyaouJ
 qqE+tudH/r0wVvExZ4x7FzPh8+SmrcWUthca+64EkIattWpFRbnGCYswAZ/8FxSve+5a8X/3qX2
 R99Ymp/IZ0=
X-Received: by 2002:a05:600c:c11c:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-48e51f5398emr43086785e9.7.1778076232270; 
 Wed, 06 May 2026 07:03:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5382a327sm90961905e9.0.2026.05.06.07.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 065/110] target/sparc: Replace target_monitor_defs ->
 SysemuCPUOps::monitor_defs
Date: Wed,  6 May 2026 15:54:37 +0200
Message-ID: <20260506135524.20617-66-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20260427080738.77138-30-philmd@linaro.org>
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


