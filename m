Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B922FC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpT-0005Ca-KK; Sun, 09 Mar 2025 13:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpN-0005C9-Nc
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:41 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpL-0004pz-Nd
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:41 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-391342fc148so1343664f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542758; x=1742147558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XCeL7qLhCXyawqpFh374doAuSUcQFtoZ56lrH3Aj2ao=;
 b=NTP4Hy/1nypXSu3QMI7r74VNdq3lAzUOIBisCb4teEDBLpcYXtH3GxVngNewcdzeFV
 oXaWjCXhBwI3YJd3oNXXnmrOVdmWjsDnhmGCxVUUaol4dRLh0SHCZP8JPnDgd4CM0MkL
 bVYGIFw3tBtaoyGW+ZrHZCn92/dzYcotJ3NEyD1iuzQ+SKfbPiCd5Fryb4XjI0gEQszd
 jDP6hcV/t/5hzMpkbQZSy7qa717dVbbKdZA42Fktd3N7YLCD6BHJwRUjuxEy1m09Wbiw
 vz9eFyJY/7sWvHmmjMjBZr4qZMWPPHq+2qgtLGknZOeSrUA6fNxr/YH5dXKztK9eGTjH
 v2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542758; x=1742147558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCeL7qLhCXyawqpFh374doAuSUcQFtoZ56lrH3Aj2ao=;
 b=i/lFQhHChF1P3pECIZR/ep+zlFO7q4sva9xnCBdwEv7cR39sHApHnPKYPyVtdkhEmF
 /lL0OTainycnXrZi3I5Xd3XFLn/NwRDu2Mquw6j2e8r63J5E5GXsOUVi0x+bY+TZUSB6
 GkDjeee0Qzn0+kz536n+gEA6OVj7xOWcdvCeQvSqviMPdMbnl5lwX8Xup+FWZVicF76K
 JzNlBYUmWBqzm8h8V4Y583hjHmYYbgWzkf1KN06btlL2zBvsCvj55Nk0YML+NvgjlA3M
 9vHv2KfWbBh/eAvk9DwN6fU/ry0RZdZlxHwsNMzrIQmG/R/I63ecHvL9RhXXy5vhyNq6
 aA+g==
X-Gm-Message-State: AOJu0YzZcDWxgFdjSepd0nnnsMkf1O3U2vdToiUIJ+5NIt+kstnjj1VN
 5pcE22KCtCQcALPW+X+4AuUwj2b0eqW1UIPXQhFztI8QZJHEvmzjiii9I9e/Y6NVBVhdU0srmTF
 UvQ8=
X-Gm-Gg: ASbGncsXvEMzK3s+M19N2/El352kf2yfsjtDXG/MP7SLbGKySS5aOLLedFYbGUyx9sf
 7jUn5Mm7zSWD612AgnKDsLykXJqnfqP0d7JK0/tRgMyDnQKfVr/d4nRPFWf+XGmzhFxzQSIp1t0
 YZ7x5oVaCgn0/xTbG4RZUyj9thDykKXsEeuleHGuLL2Y0/pid3M3NkABLl3G/ottVa1qZL3xw8D
 3zkIOhyKrUPqVlXGGZwTc2Xca6TXXbg9gbflnssQLcbgly2qoNRKj8CdZxtSA5D+298znFqi7O2
 CTwRwAApKF6+iphwl6x2hn2pHuQQ5otKdcXKuE94qObD/wSbnA/6pcBJ1iRncQOxQZd/XBXioSe
 S2YDsFSgVfwgubt3TId0=
X-Google-Smtp-Source: AGHT+IGS6SH0UrFipcFsIlm1EyzudTT+VD7XHBwkuoasmMLi2DQfY7DqLJMDaQ7n8so3Mh9NUJVOMg==
X-Received: by 2002:adf:a3cf:0:b0:391:4231:40a with SMTP id
 ffacd0b85a97d-391423105ccmr1503457f8f.33.1741542757730; 
 Sun, 09 Mar 2025 10:52:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce720f93bsm60298215e9.25.2025.03.09.10.52.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/38] cpus: Build cpu_exec_[un]realizefn() methods once
Date: Sun,  9 Mar 2025 18:51:35 +0100
Message-ID: <20250309175207.43828-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Now that cpu_exec_realizefn() and cpu_exec_unrealizefn()
methods don't use any target specific definition anymore,
we can move them to cpu-common.c to be able to build them
once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-21-philmd@linaro.org>
---
 cpu-target.c         | 29 -----------------------------
 hw/core/cpu-common.c | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index bc9c537c575..cae77374b38 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -25,38 +25,9 @@
 #include "system/cpus.h"
 #include "exec/tswap.h"
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
index d5cd227fe6d..5671d8d4f54 100644
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


