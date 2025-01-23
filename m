Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645BC0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6uN-0002s7-QG; Thu, 23 Jan 2025 18:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6tx-0000t8-Bt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:46:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6to-0004YU-QD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:46:20 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso878632f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675971; x=1738280771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSu/7xOdAlhOhpGqndt0dd/xIMB7MzmL+xgNpZ/1JvM=;
 b=D8TpQ3ldiIUxakZQwnr1yZJRyuTjRVD02UOr3G/KjTXqztQUCGeIpYAmQSwD5Zw2UN
 o7pk04ABeEvcTiAyHIfndE8Y5tntlBsV1IQx5oCG2vO1md7cB0mEalMtgcrqi9jfI8Vn
 ruFXrczHqIA2sr8LBq0EOTldUsK4kmlSRdsjQ4rRP9GztGd8624S0BKkY5QSzE2iozey
 z4oIgIO1JVNLT8s5S2faUTK8tEDVwEESlQmI0yPRUYw9wJOCgapV+jvk1tGoIeuENfRA
 sO3LX5Jn6IgATCAg7lqEhgiMsp8Cr8TwZS6b1xgQ34PfGOYyElS2zpGJVD3BUjYFgBnL
 hKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675971; x=1738280771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSu/7xOdAlhOhpGqndt0dd/xIMB7MzmL+xgNpZ/1JvM=;
 b=smnAaw7Lwo3pZTL4ojQP6ZNsRzzSH5QjUQYOuTOZiop3z1d8rYf287V5pUOgRUDNzo
 a2gYvP5kOZyUaptEJRhm3r4LOZu7hMQ/qq8DEoYtEkYf0rdsTFyv9obmnoTbfqxPPre0
 lLC8Uagnr8CLr7hsf+8LMm69okszojzgRUDnmnwQEOAU98kgFuVMkTtNAKcxVMIAFrH0
 BAWphtPC1dNj0hUexcAyUhh3P7tDIevUzgjtcvQIN+f4HJxbIa9SAlKbcBVEhMwVEKMM
 8fDqZNm33w11ah8RSG4Rf7A/Dt6fo+ZRRHA2gAniX/zOkA5ZEE9D6hCkClOkubdPcIWJ
 rv8A==
X-Gm-Message-State: AOJu0Yykv6VkaT8KNftjHvdnz31bkFOKPltDQPZJUiFmnshg/sBJryqj
 ygkY8jam6odC/nqgNRBSS8xRCbne+QZZHZl6391JUmcF8btppPb+xP68iRp8Mkxyt0mnMAhkgWL
 HSvc=
X-Gm-Gg: ASbGnct0/nM3KVeM//BFkWfWWDe/Y9FW0Ev80GtTtAyk7NAI70aRaz+41B0PciOP0SM
 WHOJOBtiBUjbn0Tius4+W3QK4qif+Omm5vb4nEsNirsrm9+kurGB1ryuWazfzkgkuW8/IoWwicV
 3jPWUc9A+LQ+jT30hkgiD6ALXJ7fzRoHpa5zKiF7PeB7lhqpambrXjLu0cCQUCpPZKobWEjjAJa
 V8vZUn1uIJTHoSK+NLfEoKK26NMi9IqmFnoxwa4rP8slGEzHn9101EWgZ3jox4vVWqV5MFl95WW
 plbGdxh3v14egNavbRyRQpa8FoHJievCBg7F8jgEiYXRuEWeAnuNNE8=
X-Google-Smtp-Source: AGHT+IFycJysfhMaCpSR16Rzr8MUGZyLqdkkV1WoJ+3KdF//Z7stLVwsFpncYG19E6JH49Nuy1YUSA==
X-Received: by 2002:a05:6000:e4a:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38bf566f3bemr20406552f8f.24.1737675970851; 
 Thu, 23 Jan 2025 15:46:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4d34e3sm6953255e9.39.2025.01.23.15.46.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:46:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 20/20] cpus: Build cpu_exec_[un]realizefn() methods once
Date: Fri, 24 Jan 2025 00:44:14 +0100
Message-ID: <20250123234415.59850-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Now that cpu_exec_realizefn() and cpu_exec_unrealizefn()
methods don't use any target specific definition anymore,
we can move them to cpu-common.c to be able to build them
once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Eventually they'll be absorbed within cpu_common_[un]realizefn().
---
 cpu-target.c         | 30 ------------------------------
 hw/core/cpu-common.c | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index bfcd48f9ae2..8f4477be417 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -19,43 +19,13 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
 #include "exec/replay-core.h"
-#include "exec/cpu-common.h"
 #include "exec/log.h"
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
-#include "qemu/accel.h"
-#include "hw/core/cpu.h"
-
-bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
-{
-    if (!accel_cpu_common_realize(cpu, errp)) {
-        return false;
-    }
-
-    /* Wait until cpu initialization complete before exposing cpu. */
-    cpu_list_add(cpu);
-
-    cpu_vmstate_register(cpu);
-
-    return true;
-}
-
-void cpu_exec_unrealizefn(CPUState *cpu)
-{
-    cpu_vmstate_unregister(cpu);
-
-    cpu_list_remove(cpu);
-    /*
-     * Now that the vCPU has been removed from the RCU list, we can call
-     * accel_cpu_common_unrealize, which may free fields using call_rcu.
-     */
-    accel_cpu_common_unrealize(cpu);
-}
 
 char *cpu_model_from_type(const char *typename)
 {
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 71425cb7422..c5382a350fc 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -193,6 +193,20 @@ static void cpu_common_parse_features(const char *typename, char *features,
     }
 }
 
+bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
+{
+    if (!accel_cpu_common_realize(cpu, errp)) {
+        return false;
+    }
+
+    /* Wait until cpu initialization complete before exposing cpu. */
+    cpu_list_add(cpu);
+
+    cpu_vmstate_register(cpu);
+
+    return true;
+}
+
 static void cpu_common_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cpu = CPU(dev);
@@ -234,6 +248,18 @@ static void cpu_common_unrealizefn(DeviceState *dev)
     cpu_exec_unrealizefn(cpu);
 }
 
+void cpu_exec_unrealizefn(CPUState *cpu)
+{
+    cpu_vmstate_unregister(cpu);
+
+    cpu_list_remove(cpu);
+    /*
+     * Now that the vCPU has been removed from the RCU list, we can call
+     * accel_cpu_common_unrealize, which may free fields using call_rcu.
+     */
+    accel_cpu_common_unrealize(cpu);
+}
+
 static void cpu_common_initfn(Object *obj)
 {
     CPUState *cpu = CPU(obj);
-- 
2.47.1


