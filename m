Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3F7C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKgZ-0007Qd-9V; Thu, 21 Mar 2024 11:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgH-00070o-Qf
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKgE-0001ko-9V
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:50:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-414776775d3so2813905e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036207; x=1711641007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaYDCoOXgjCF3J0hi/NBXkeoqt0AB2bCPsQIdEK8J3A=;
 b=beIQHEzsMkZHTnO66WKDRpglA39EuEcATRPxx/Fj3DZJu4HCENmfm51036hrCVrwE8
 AsAlRaA8tzvgRTYQfnoIer1h0cieAy4hhSTKS0DRoovqnJfuSPYjvtekA4GtDS9zs26n
 diolqu7sCCrxGs08ZAFhIb+U1tniflycdUlG2pSsNQUOUe2OssgFBC+Y1gtsdy6QwRla
 gkuR2XZZmDXvTN98qNJIj/t+LOWrmJBERq6L4sqS2uQlRRjXUGrluzsRWya/vRmU4xdn
 3cQElUiPEdBCj94BdGVPCG0TtLcxrOH+XyCEG806Ng4/NOvSByKXUCI74yfJwMqNAIcr
 HaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036207; x=1711641007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaYDCoOXgjCF3J0hi/NBXkeoqt0AB2bCPsQIdEK8J3A=;
 b=XPueGN7nIHd+ReadXcacNWzyHF4T8KUqmOSvgRQaZogb5gWi1J08woWS4MT4Yl2zeb
 4uU4gCAHl1sJSibG9Ptc5GHKXcbkxhC+JJNve6Mb1o/XT4nYxDSeAhJRh70Z2X+EbfJn
 Y+lS96rb9aCMFpR6Ob2f5xhF3OT2evvuCDzlYlsWfjfrEGJlSBBjt8c0tziB8/u2tPy/
 7cm02IsiOKiOmWZm9QanTjLqOANZOKSEOds/sqiixJ9UTKx+5xz0PdVj2cXiYCWFMU2r
 d+45c4iGv45tEOmyQTSgyU154LLpna/xrrKJYBI/TKkY1Xao8geNFA8a1OFH3q4A/dzk
 4F7A==
X-Gm-Message-State: AOJu0YxR8CpVeCrBdXr9YBNTnhVDxxnYJx3YH9zynwbWLfAV5gI/I3Kp
 iB+wjO4KB3oKmZUuYrfuHO9/Ge9Gr7nhLhtQJPE8qX9bfNq3jPbmGsfh/AoDmLinUBvidfULXRl
 mlas=
X-Google-Smtp-Source: AGHT+IECdpN4aGFS4wOtGuEHJ/tngZrGDJvB0eP2LElCYBc2wi28sHD7ORsHzU6O1p3ZiIqxr5lUfA==
X-Received: by 2002:a05:600c:1c20:b0:414:645c:33cd with SMTP id
 j32-20020a05600c1c2000b00414645c33cdmr1714797wms.32.1711036207350; 
 Thu, 21 Mar 2024 08:50:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c501200b004146bdce3fesm5885327wmr.4.2024.03.21.08.50.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:50:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 11/21] target/nios2: Move monitor commands to monitor.c
Date: Thu, 21 Mar 2024 16:48:27 +0100
Message-ID: <20240321154838.95771-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Move 'info tlb' monitor commands to monitor.c,
rename dump_mmu() as nios2_info_mmu().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/nios2/cpu.h     |  2 +-
 target/nios2/mmu.c     | 27 ---------------------------
 target/nios2/monitor.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 4164a3432e..27e835cf40 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -250,7 +250,7 @@ static inline void nios2_update_crs(CPUNios2State *env)
 
 void nios2_tcg_init(void);
 void nios2_cpu_do_interrupt(CPUState *cs);
-void dump_mmu(CPUNios2State *env);
+void nios2_info_mmu(Monitor *mon, CPUNios2State *env);
 void nios2_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 G_NORETURN void nios2_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
                                               MMUAccessType access_type, int mmu_idx,
diff --git a/target/nios2/mmu.c b/target/nios2/mmu.c
index 272bd9fc6a..278eba1b0a 100644
--- a/target/nios2/mmu.c
+++ b/target/nios2/mmu.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "mmu.h"
@@ -187,29 +186,3 @@ void nios2_mmu_init(CPUNios2State *env)
     mmu->tlb_entry_mask = (cpu->tlb_num_entries / cpu->tlb_num_ways) - 1;
     mmu->tlb = g_new0(Nios2TLBEntry, cpu->tlb_num_entries);
 }
-
-void dump_mmu(CPUNios2State *env)
-{
-    Nios2CPU *cpu = env_archcpu(env);
-    int i;
-
-    qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
-                cpu->tlb_num_ways, cpu->tlb_num_entries,
-                cpu->pid_num_bits);
-
-    for (i = 0; i < cpu->tlb_num_entries; i++) {
-        Nios2TLBEntry *entry = &env->mmu.tlb[i];
-        qemu_printf("TLB[%d] = %08X %08X %c VPN %05X "
-                    "PID %02X %c PFN %05X %c%c%c%c\n",
-                    i, entry->tag, entry->data,
-                    (entry->tag & (1 << 10)) ? 'V' : '-',
-                    entry->tag >> 12,
-                    entry->tag & ((1 << cpu->pid_num_bits) - 1),
-                    (entry->tag & (1 << 11)) ? 'G' : '-',
-                    FIELD_EX32(entry->data, CR_TLBACC, PFN),
-                    (entry->data & CR_TLBACC_C) ? 'C' : '-',
-                    (entry->data & CR_TLBACC_R) ? 'R' : '-',
-                    (entry->data & CR_TLBACC_W) ? 'W' : '-',
-                    (entry->data & CR_TLBACC_X) ? 'X' : '-');
-    }
-}
diff --git a/target/nios2/monitor.c b/target/nios2/monitor.c
index 0152dec3fa..c6043769e4 100644
--- a/target/nios2/monitor.c
+++ b/target/nios2/monitor.c
@@ -22,14 +22,40 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
+void nios2_info_mmu(Monitor *mon, CPUNios2State *env)
+{
+    Nios2CPU *cpu = env_archcpu(env);
+
+    qemu_printf("MMU: ways %d, entries %d, pid bits %d\n",
+                cpu->tlb_num_ways, cpu->tlb_num_entries,
+                cpu->pid_num_bits);
+
+    for (int i = 0; i < cpu->tlb_num_entries; i++) {
+        Nios2TLBEntry *entry = &env->mmu.tlb[i];
+        qemu_printf("TLB[%d] = %08X %08X %c VPN %05X "
+                    "PID %02X %c PFN %05X %c%c%c%c\n",
+                    i, entry->tag, entry->data,
+                    (entry->tag & (1 << 10)) ? 'V' : '-',
+                    entry->tag >> 12,
+                    entry->tag & ((1 << cpu->pid_num_bits) - 1),
+                    (entry->tag & (1 << 11)) ? 'G' : '-',
+                    FIELD_EX32(entry->data, CR_TLBACC, PFN),
+                    (entry->data & CR_TLBACC_C) ? 'C' : '-',
+                    (entry->data & CR_TLBACC_R) ? 'R' : '-',
+                    (entry->data & CR_TLBACC_W) ? 'W' : '-',
+                    (entry->data & CR_TLBACC_X) ? 'X' : '-');
+    }
+}
+
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
 
-    dump_mmu(env1);
+    nios2_info_mmu(mon, env1);
 }
-- 
2.41.0


