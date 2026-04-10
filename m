Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB4F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHxm-0008Rn-RZ; Fri, 10 Apr 2026 15:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxl-0008I3-0f
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHxc-00041D-VT
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:56:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488b0046078so24119855e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850971; x=1776455771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C78IbPBsz6cVs2Ym43RKAMokAYox7chDUSzKqZO66SU=;
 b=n8DmGKHlWSIX4ZQwbtlQ0+D23gzPAAiOsDkskPo8XxYh7NN2Tvrc5mjpylEeRTIdWf
 bHvJExa324wGjoLNN4cZJjZE+c7/NZqILob5JYIk7bJPmPYvZX+W3+riuu0PWKEhZuHB
 1m9J8UMaGy91gZD1OCQTPKH006rUYUbB0zxQPSGdoX+Ntni236xs11cpgtZZdvYgDHi4
 DX/+y8GVknfROZXOb55OUmjKHqPo8dRns9RiMWx2KsRrzQzQhVCO8ant60gMpiPRqiej
 9kYKSmSgJly5FLDf8UGV4nLhhRkbJaR5MYo58CjDOBIISqq382JHMxcbv8UmZ/dK6rzF
 xyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850971; x=1776455771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C78IbPBsz6cVs2Ym43RKAMokAYox7chDUSzKqZO66SU=;
 b=m/s0JB7m0TQ46D0Y1uhsix0KraN7ztF6AUGbyhWPvItdVbxlKoFuWg5yVDEunsFmW9
 KaihLYKxsEeZKiOoJGHe2FulI3wWb746r53RBXAaM61OIuTyowUovjtAPy+AYCCrOrTg
 F+VCICwOEota4Dom8av6s4NCa9AZlCnluvQITyeBhihuGSU+e350Aezs8WYfUgROz9UF
 2tyPaHhWeyOs+0Ty02zX3TLOvWpHi8wRj3OIP93e2MkgIcEqj+qyi7fhYUwKREjOSmYo
 9fu2uYTYJgmCNt+/l7rkobMQ43MLe+S1BgEqpH8aDoDACH5qmO1RvgwPOVtDAMP9uVcI
 fLUA==
X-Gm-Message-State: AOJu0YylXRrlFLIjUi2y0DbraBtp3rO13TDRGZL0pMNCjDN3prQ5rMJH
 OAANyun17CCMF2R26MAslLebMwDZNMOlBaX5pSMFtZT5Ir3QNnAy9AdwnlXkHYlCXJPTYNZ2ahO
 0aBlD2CA=
X-Gm-Gg: AeBDiesZAJnwrrSaytlm1KUymYjojuGF57i7ig8wGt8iKYC8zfKgAYrQbp/73zVq/by
 F00wq4pG2VpIYpqCoS3XI/bfCbseR+zlbQsKhMxXCr0ma8BXf8nJvusEXv6KoBefiyMJDyrgLnQ
 wPIIJMueOega0u0WJ9hH18QfUZY2e6lo1lxg0qhA845CE1cjR4x0D0y5a5Ss6uiqd6mGNVRejBH
 AqGm81Izvh2lDqTM/cV0RfItawxsI69Acz+/qFxGpAVVNuPfJck6KhM0NtqgDng9KFVqyC2O+/s
 mc51gkX7FCC0maWsmGHnQggrCz6mehAC/R/Xi7fESPA61mOoFFiYfyfkgJmG2OxT9MhV/XI5UFt
 DWADWH+2qO9WL5Foa1806HHWBW6jH5hdLTA/OznbsfozkvI0sY+n5YxPi5bh/lZ279EKFzSDOm3
 39Ub/xXbGdJ3IpvZTsUJyEn69OIA4GC1NGpd28CnGbi7XiNqpBdyg9Bw5BQniUffzrv6WfAGZR
X-Received: by 2002:a05:600c:45c9:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-488d689cf9emr52390385e9.29.1775850970618; 
 Fri, 10 Apr 2026 12:56:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f2b6sm106301525e9.2.2026.04.10.12.56.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:56:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v2 23/27] monitor: Do not check TARGET_I386 to build 'info
 sgx' command
Date: Fri, 10 Apr 2026 21:53:17 +0200
Message-ID: <20260410195323.17937-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

This command is filtered at build-time for i386/x86_64 binaries.
By using the recently introduced HMPCommand::arch_bitmask flag
we can filter it at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on the CONFIG_SGX definition, define it
in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS            |  1 +
 hw/i386/sgx-hmp-stub.c | 16 ++++++++++++++++
 hw/i386/sgx-stub.c     |  5 -----
 hmp-commands-info.hx   |  3 +--
 hw/i386/meson.build    |  1 +
 5 files changed, 19 insertions(+), 7 deletions(-)
 create mode 100644 hw/i386/sgx-hmp-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 458951bc051..31e973fdeb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -514,6 +514,7 @@ L: kvm@vger.kernel.org
 S: Supported
 F: docs/system/i386/amd-memory-encryption.rst
 F: docs/system/i386/sgx.rst
+F: hw/i386/sgx*
 F: stubs/qmp-i386-sev.c
 F: stubs/qmp-i386-sgx.c
 F: target/i386/kvm/
diff --git a/hw/i386/sgx-hmp-stub.c b/hw/i386/sgx-hmp-stub.c
new file mode 100644
index 00000000000..cf1d9a6344b
--- /dev/null
+++ b/hw/i386/sgx-hmp-stub.c
@@ -0,0 +1,16 @@
+/*
+ * Human Monitor 'info sgx' stub (CONFIG_SGX)
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+void hmp_info_sgx(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "SGX is not available in this QEMU\n");
+}
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 6e82773a86d..59d58926311 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -22,11 +22,6 @@ SgxInfo *qmp_query_sgx_capabilities(Error **errp)
     return NULL;
 }
 
-void hmp_info_sgx(Monitor *mon, const QDict *qdict)
-{
-    monitor_printf(mon, "SGX is not available in this QEMU\n");
-}
-
 void pc_machine_init_sgx_epc(PCMachineState *pcms)
 {
     memset(&pcms->sgx_epc, 0, sizeof(SGXEPCState));
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b575e4ac993..da9fdc0ab7b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -866,15 +866,14 @@ SRST
     Display the vcpu dirty page limit information.
 ERST
 
-#if defined(TARGET_I386)
     {
         .name       = "sgx",
         .args_type  = "",
         .params     = "",
         .help       = "show intel SGX information",
         .cmd        = hmp_info_sgx,
+        .arch_bitmask = QEMU_ARCH_I386,
     },
-#endif
 
 SRST
   ``info sgx``
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 63ae57baa51..b611fbb5a7f 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,6 +24,7 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
 i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
 i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
                                 if_false: files('sgx-stub.c'))
+stub_ss.add(files('sgx-hmp-stub.c'))
 
 i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
-- 
2.53.0


