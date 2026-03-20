Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CCC109879E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3cPS-0000LC-Je; Fri, 20 Mar 2026 12:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cP2-00009C-5E
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:48 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w3cOv-0008V6-1H
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 12:08:42 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso17636325e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774022916; x=1774627716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjF8TKw+cr/1Oy3sc/nSY2zSxmQ8jlpXSNrnRMQupDY=;
 b=hhGLtYiSEJDZ4InXb6EBBlwu6XKJ1QvtSyf2vmFaBULZWLw2L3nCR2HA/8YSSj7DLw
 yyorR1zd8XJg+bfy/v8gbKhjf3+uclaI9+BQybnWxPhDYHeYw3+M/h47AKfXKgmH7G1c
 hidmJguCD/tLSQwHwoB88pIgK8r3Twf9tDMc6ufVrJbnz3g2mbC0ginzimUAK4ohBYbC
 GaIWa4Y+EG/yVvBQEiUCg3qaKeaoQd+FKon5cNYL9Gby/aEUkr7rvN0HrZ6VldJCNX89
 DlL90RPbi8cFXLz2CInHzcB2AencuHjIRezloaSsqtzCpnOt5yd+Hp42yZpNoffTPZcR
 +LFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774022916; x=1774627716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cjF8TKw+cr/1Oy3sc/nSY2zSxmQ8jlpXSNrnRMQupDY=;
 b=ViHUL2PVKcedBRIexeFCe4Xbj4BoabV0U6QF9u4diLwKvzpzOvZQ0DdtduAAQqz3Za
 4btvRBqSYggoKLlbHXH/BmhlvqXqZQ5drHHZMFRqvRGPUOOq0TMOaZhcKNfI8FBZ4P56
 MDjMWw0M5ZcgIjfoHqIuftgM/9Lsa9SZJnqxAzw7Nek4lhL0vueaZblaVFWLsFfYU4cM
 gC4GVPkbnUBvC3G2QQbLAnN/hT9uuZcGrPqS/0u7iozIzdjDVlBITrCavb95iRztPxFo
 t+N1ha+xzJQ2Kgl0GSNpZiCngR/m5syyoZvDUPb0aDmoevM3M/CF6uTlMN+KdHdqYGUw
 g/yw==
X-Gm-Message-State: AOJu0YzhXQsokPACZYChnmYe7iiuebJtRGKZh1iobFGfN4/Jguy+Gk46
 zdR0+1qF56a0Ts3++BWF2FDyDJBuLiLYoYCo0mu8Gp3rvnIx0qy2E2Ec8eYQU4TjCpf5UOmbvFL
 X6lenaDI=
X-Gm-Gg: ATEYQzxcc/BpwpWWcW+38isUdERbyao1M+JmaRsdc+dCzjikZXNx10i8tD8i5N0Oy35
 kVsR3OubhHj6ZC4Pi/aM1mBlXLIYoxLU9M7k1wuqbSbSIRgDTFODVTIxAZTEuUeYXxKZx+h8j5b
 LyD/xHAaMBe7eGoVQtTkXnnG8BJz8vqkcDvYBwP3Opg+g7XgVFmtY36ljbIDQQY2/oZ/o9duJ68
 Pr2lH9zELGJ77Jiq1vHIWYQ4vPKIcHGNvRkI6W5kWA6EznF05LGFCYxeFpyiqnk8HwEo/UyKO9T
 cgqMfNgQFwdiIJSUaFZQQefLmFskIAmVvbN2+e62NmQzi6xeTY/ERX1+6z2G7vzCXLRMUmAdmwH
 NGu6vrrtLkmBNjSELy9RXVyEIbhsyELRIKH91NHs6isOlPOfMceRgJbqC8bUkAcZwVzuWCgVwdD
 xOUnGS/3lMLAJF+Smvwukomc6E5Hs/XNLqV/w8iqD/Uu3FHXN00LOdNPVuP5nyX0PDIaFaZKEo
X-Received: by 2002:a05:600c:a085:b0:485:3ec6:e634 with SMTP id
 5b1f17b1804b1-486fedcc6e7mr56899415e9.15.1774022916268; 
 Fri, 20 Mar 2026 09:08:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fc4d90f4sm125937545e9.1.2026.03.20.09.08.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Mar 2026 09:08:35 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH-for-11.1 03/10] cpus: Introduce CPUClass::legacy_monitor_defs
 hook
Date: Fri, 20 Mar 2026 17:08:03 +0100
Message-ID: <20260320160811.28611-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320160811.28611-1-philmd@linaro.org>
References: <20260320160811.28611-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Allow targets to register their legacy target_monitor_defs()
in CPUClass; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 3 +++
 monitor/hmp.c         | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04e1f970caf..072f58bead5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -148,6 +148,8 @@ struct SysemuCPUOps;
  * @max_as: Maximum valid index used to refer to the address spaces supported by
  *          the architecture, i.e., to refer to CPUAddressSpaces in
  *          CPUState::cpu_ases.
+ * @legacy_monitor_defs: Array of MonitorDef entries. This field is legacy,
+ *                       use @gdb_core_xml_file to dump registers instead.
  *
  * Represents a CPU family or model.
  */
@@ -174,6 +176,7 @@ struct CPUClass {
     const char *gdb_core_xml_file;
     const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
+    const MonitorDef *legacy_monitor_defs;
 
     void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index c63da13e310..a2b6269d0ff 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include <dirent.h>
+#include "hw/core/cpu.h"
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
@@ -1603,8 +1604,8 @@ void monitor_register_hmp_info_hrt(const char *name,
  */
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
-    const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
+    const MonitorDef *md = cs->cc->legacy_monitor_defs ?: target_monitor_defs();
     void *ptr;
     uint64_t tmp = 0;
     int ret;
-- 
2.53.0


