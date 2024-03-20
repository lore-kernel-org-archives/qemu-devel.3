Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE8EC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmz04-0003Da-2G; Wed, 20 Mar 2024 12:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmz03-0003D3-5w
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:41:11 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmyzy-0008QK-Pc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:41:10 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-512bde3d197so72985e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710952864; x=1711557664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uBipDkgk2OtHXrYLE6niKLfwVNhjxBZzSEhQS339zKI=;
 b=ohFmiGS2BY2CP1/yiDcGfK/3+rp8rXqWXvA9w4csDmzV5SZGLi+MUYXypMbGjX7Mdi
 MawWrg/CBtwNe71+lbNvnxKpa/cslw91/G/lHCCW+20cMBxW15FJAUTlK/xS6gW3S6Ie
 FM+OlQQYkYl6uKdJae04TMNrstnqc3QhD4eD3aZqksplweVoXmuBasB5zP7Gp/xjkaCu
 Vd+iMYDsi1NYyOHmk9Srl9pPTA0ReHz47xnKYP13w9pCr6wFSFRsvkEfAamjd8LwNTnK
 UydnGDx7SX/KazDiR8gScP59i5eNxrSWeDbil9nWfWpazNiTQLD3muIUFL846Tm7C/BE
 lPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710952864; x=1711557664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uBipDkgk2OtHXrYLE6niKLfwVNhjxBZzSEhQS339zKI=;
 b=IUqLYEtmZ9VZ4EqjiUUPjoFWt29sAryzydhdp8zJLhz4lLM2shcMkTS+fnWn32CIOk
 8QdWxD03UVrZFQ/E3G4S5aA1ZYjqcrdNDaceQsyEL982Ll/kYXlIuxZJ8fpwn20QTihu
 I9RZJYUd/DV7IRlWEZ2KxZ8PKBGYyvGQZ+VFPC8mWG5cDVOWnKKRrQXLiGDntONGAOX3
 IOD1ZXNI9iqXKys/HV+EdV0M/LyoHAveFczma6rjjf9BE186hFY3y5ncAptTzxd/0MkA
 eAp7k81Y5ngoyPE13qch9gVMFLEmTrsLbJTGwdyq/BZxMEEoC8yfOD83yjJ0cjtAFTu2
 MONA==
X-Gm-Message-State: AOJu0YzNna01tjhWalA3Cb8HdG5scq3vtO3APBGhwwiT8qTrQylvFv3f
 7HfZmXTZ+yq2Gz1j7Jb5rByGfvmE7n38+z9zCcstlXC05x8IZEdYUyuFRSo9F180VXGfDDH2RsM
 0
X-Google-Smtp-Source: AGHT+IHtrf4rG044ck65QzHkds4K+JnxF6D35WRfN/7fWRlib9Sk+BwJCK0bTKXtEX22KIpSpz+E1A==
X-Received: by 2002:a19:770e:0:b0:513:e47d:614d with SMTP id
 s14-20020a19770e000000b00513e47d614dmr4932908lfc.37.1710952864623; 
 Wed, 20 Mar 2024 09:41:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.156.105])
 by smtp.gmail.com with ESMTPSA id
 fs7-20020a05600c3f8700b00414038162e1sm2668663wmb.23.2024.03.20.09.41.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 Mar 2024 09:41:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 1/2] target/monitor: Introduce 'info mmu' command
Date: Wed, 20 Mar 2024 17:40:54 +0100
Message-ID: <20240320164055.60319-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240320164055.60319-1-philmd@linaro.org>
References: <20240320164055.60319-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce the 'info mmu' command. For now it only
forward to the 'info tlb' and 'info mem' commands,
which will be deprecated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/monitor/hmp-target.h |  1 +
 monitor/hmp-cmds-target.c    | 37 ++++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx         | 14 ++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index d78e979f05..2af84b1915 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -44,6 +44,7 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
 CPUArchState *mon_get_cpu_env(Monitor *mon);
 CPUState *mon_get_cpu(Monitor *mon);
 
+void hmp_info_mmu(Monitor *mon, const QDict *qdict);
 void hmp_info_mem(Monitor *mon, const QDict *qdict);
 void hmp_info_tlb(Monitor *mon, const QDict *qdict);
 void hmp_mce(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 9338ae8440..71bce4870a 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -31,6 +31,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "sysemu/hw_accel.h"
+#include "sysemu/tcg.h"
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
 int monitor_set_cpu(Monitor *mon, int cpu_index)
@@ -379,3 +380,39 @@ void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
     memory_region_unref(mr);
 }
 #endif
+
+__attribute__((weak))
+void hmp_info_mem(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon,
+                 "No per-CPU mapping information available on this target\n");
+}
+
+__attribute__((weak))
+void hmp_info_tlb(Monitor *mon, const QDict *qdict)
+{
+    monitor_puts(mon,
+                 "No per-CPU TLB information available on this target\n");
+}
+
+void hmp_info_mmu(Monitor *mon, const QDict *qdict)
+{
+    bool tlb = qdict_get_try_bool(qdict, "tlb", false);
+    bool mem = qdict_get_try_bool(qdict, "mem", false);
+
+    if (!tcg_enabled()) {
+        monitor_puts(mon, "This command is specific to TCG accelerator\n");
+        return;
+    }
+
+    if (!tlb && !mem) {
+        tlb = mem = true;
+    }
+
+    if (mem) {
+        hmp_info_mem(mon, qdict);
+    }
+    if (tlb) {
+        hmp_info_tlb(mon, qdict);
+    }
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad1b1306e3..e31f2467fb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -208,6 +208,20 @@ SRST
     Show PCI information.
 ERST
 
+    {
+        .name       = "mmu",
+        .args_type  = "tlb:-t,mem:-m",
+        .params     = "[-t][-m]",
+        .help       = "show virtual to physical memory "
+                      "(-t: TLB; -m: active mapping)",
+        .cmd        = hmp_info_mmu,
+    },
+
+SRST
+  ``info mmu``
+    Show virtual to physical memory mappings.
+ERST
+
 #if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) || \
     defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
-- 
2.41.0


