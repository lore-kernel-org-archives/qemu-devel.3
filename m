Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E073DC61DB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaCh-0005xA-V2; Fri, 06 Jun 2025 12:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCZ-0005YT-My
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCX-0003RC-Ll
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a522224582so1435798f8f.3
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228351; x=1749833151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaqgBc+8IPd+F+DKqw2/dlO2PgT1d6b4+qh/jcNGS0o=;
 b=ztDm1INrsjBP4xUKGJhwETQGgiILgQ5uD+cVjqufE1UqGW7May8UivU2CgGFMxT6CK
 iW/qCOafAJlNu7QBB9jWISRgCrAyDJOn2Vej5CZxPp1XhpUsf1xLTJNkhQWnbgdsKBFH
 YfpvQjfm1cmA5PIwnAfAmKyp9dOceOLUmwhXYoGsCuseHhqwTxkUjAtGdKuHkEvVTPiF
 brjNskbZ2DLOL/hig57eUTG6SBUAwT32HjDpK17XIdaFUbAp2sMBeM2tRszsXrnqEYVI
 zU/ZGeNWqOtPbe2za+To/z6lx7ZAk0e432BnnOKFK6nDKC1WZZPDxR5TAwEk8aSaPJ9w
 nYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228351; x=1749833151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaqgBc+8IPd+F+DKqw2/dlO2PgT1d6b4+qh/jcNGS0o=;
 b=JrCiuB2eWP6GqCechsbaAcYZkuHkvpCep3ZY1cZXlzZOPMgL0zrecPbmta5U2H0oko
 ftFdPHf1UZRFAloWmTJsQu0I5ORXZZjHaoneqrJ6i1ft2lz1xkSxXfJaDxWAiHclSTZX
 xtb+DpIch0MZ44MbQhqcdU2kls4TU8Uauds+kyxR5lOAaT/D+kAQUOGjtVNU4Elb2rNW
 kJ2wlX2IY9HID/3gRYbJIK3kT/CabmMyWoEhkJXFPnCCRv0frxXypbAOSjmbsn14uP68
 IXokIBaC5MkR2xIBXPc8joMOoJU2vlTPFq+OOHGCZueod2Ffz0HrDgA7bKPZcumifETw
 mV1A==
X-Gm-Message-State: AOJu0YyIFiVltjumqosUO2pNVQjt5hGMX37Z0A3JDeYtIPFd3m+GWxLM
 vszPXuy4HlVbGm4qQlA6wmJ/zRMfvmR56EkOt0wLpGSgmLKex9tU0NdbZ/dqCZ2zto3O5eOX3QJ
 RGDHAxcXydg==
X-Gm-Gg: ASbGncv4dCT/yMIpa+eufhWWcDDGDOeL+2odoD56sY6GIdC0a9DDUSDMF7juRIQtUwq
 Ni1sw64WM9/IJ+R3PZ9h+Q/jCcMPYFZWCf39NgxlQ9H72LnO5gCuowJvxvmBNFx25TLpQvCUUvR
 IiLNlhrcyjGR2tLlUXx+wBulwbXa3FnmCPRx7hxW5k8L8A+l+2l4HJPVFpQ5vaRckm+rI7jrHqt
 9tMBhDX3kF8gLXxnfR8xMgww4Jq3Ie1EJd42z8xonim3bczffbRWa0HcwzojUl4ElDaR50ruRHm
 Gdb9UycrmTzKrEfHju6U/APiier6yEGL+Rf98HENw5aPBSW+hYsORzwK1ObjItvGOCtq/L1H5Uu
 chW0JxhPJryh6X2ip7o8TR/+BQzGWMx1xkj6efg==
X-Google-Smtp-Source: AGHT+IHy3I3xniHdl9pP2pmVXsFrTxR4qRcns7OlZAb6H/2bqDPkN/Nsdjdsfxf0oTgi5COmBZKwgA==
X-Received: by 2002:a05:6000:2c11:b0:3a4:e393:11e2 with SMTP id
 ffacd0b85a97d-3a5318a9b08mr3551108f8f.34.1749228351303; 
 Fri, 06 Jun 2025 09:45:51 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244fd02sm2330320f8f.75.2025.06.06.09.45.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 12/19] accel: Factor accel_create_vcpu_thread() out
Date: Fri,  6 Jun 2025 18:44:11 +0200
Message-ID: <20250606164418.98655-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Factor accel_create_vcpu_thread() out of system/cpus.c
to be able to access accel/ internal definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h |  2 ++
 accel/accel-common.c | 20 ++++++++++++++++++++
 system/cpus.c        |  4 +---
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 3c9aaf9523c..a351eebe567 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -93,6 +93,8 @@ void accel_cpu_instance_init(CPUState *cpu);
 
 bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp);
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu);
+
 /**
  * accel_cpu_common_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 4f3b42e7112..6bd4ef47c2c 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
+#include "system/accel-ops.h"
 #include "accel/accel-cpu.h"
 #include "accel-internal.h"
 
@@ -88,6 +89,25 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
+void accel_create_vcpu_thread(AccelState *accel, CPUState *cpu)
+{
+    AccelClass *ac;
+
+    if (!accel) {
+        accel = current_accel();
+    }
+    ac = ACCEL_GET_CLASS(accel);
+
+    /* accelerators all implement the AccelOpsClass */
+    g_assert(ac->ops);
+
+    if (ac->ops->create_vcpu_thread != NULL) {
+        ac->ops->create_vcpu_thread(cpu);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 bool accel_cpu_realize(AccelState *accel, CPUState *cpu, Error **errp)
 {
     AccelClass *acc;
diff --git a/system/cpus.c b/system/cpus.c
index 4835e5ced48..b6dff01c7ea 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -709,9 +709,7 @@ void qemu_init_vcpu(CPUState *cpu)
         cpu_address_space_init(cpu, 0, "cpu-memory", cpu->memory);
     }
 
-    /* accelerators all implement the AccelOpsClass */
-    g_assert(cpus_accel != NULL && cpus_accel->create_vcpu_thread != NULL);
-    cpus_accel->create_vcpu_thread(cpu);
+    accel_create_vcpu_thread(NULL, cpu);
 
     while (!cpu->created) {
         qemu_cond_wait(&qemu_cpu_cond, &bql);
-- 
2.49.0


