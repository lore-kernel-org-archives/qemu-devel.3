Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E977AC83036
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEGt-00060b-NF; Mon, 30 Jun 2025 09:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGp-0005zn-Uk
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:04 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGl-0003z0-DR
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:02 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4535fbe0299so12071485e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751288997; x=1751893797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVu21VQj8moUvN4y9H9klvBu0KFfflfQTQgSaLVpIq4=;
 b=XP84tkaWxxXXFJyyHWqDVtNxSeSj52PWzi+wgG+lFmPLsJNbvH/x2gbfwBUONaV1nw
 igoScRKvzUUcCkCTjGORK/V9GNQPeZFM56WFqhoEPnqvxdTDYaFFOc/JRfa9PCbECWKg
 PafAwdyG+IejA4e0hyYl5YkB03NcZrBXlGb32VQ40gow6di6LraAqSAqmSBZVNJTehbe
 KhSWKOrd01JFHE7v4aA/4eugPh9W8iD3t2HgAq1ekU86NeQx4gAVG2yFOECXIh2tKfkN
 02RVKxkfkelrYsEo5I0E4mh/xlJzDzX2PBi4mv8vIszHknSi8fjreTNeo5bbaQ90KkdU
 kURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751288997; x=1751893797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gVu21VQj8moUvN4y9H9klvBu0KFfflfQTQgSaLVpIq4=;
 b=UApAYjkIWLn0G9Yjj+PFGG6OYuefChqZdqLKXZqcO9k7hjhu1ihwMGL+DLcoNyeCHy
 ZWRh5QTURX1HtZP45NbgfHqP6LtYPQenxvduJ8Fj+u8WuYHI20Wv0d9W9VWPn1NIvEoA
 gNyqgNcUyqfqWUolHvWscdI7ksc2C+HQT1+mgt1nafV16RA6zNh3LIFt5n8xwUVDiOuT
 Du65/OBmOGM0vj2IwlJw3TSc1fCT5aF/t8lhGBE1h2IjNumLCxZqEjrZ7BKWpUx2RGCj
 t2QcakI5hOSYbuSlPpC91+nvso56uaBx3umt8xtVaKCQbtyI6xrnJymScdatJVT/dNJq
 pknQ==
X-Gm-Message-State: AOJu0YyD8AQ1ERWO3DCW8pZJ3Sp/eL0H35fEaKrgAqZE+1iwSJbmlYYQ
 LIYJtupySjq/2DThrcbz5fUoe5D3eqIosChl3T24dfvcdyjXqTdSW91nbXdlxdLlAU8yybcTskx
 TjKw4
X-Gm-Gg: ASbGncvfZxi94Sf8obcxfOY9QJ4gCxbNU1poIgiPlPschjwpMEgzECwVUjfcKK0xWCM
 sAAVb6fEcotwIJlFwNatLbJKfWc/jm0WIsHhDWR0NEbA0emo2kb27GZQ+Ws+JSIewj3F60UJzn1
 2ol5tFE+0yD5KYW3yNJFAQaZNoW5prPo40bhY/PtGdMXcmz0r88D9+8EaVryAFousV7ZOvxSGyK
 l9UMDshwidswVz+uYR+y+qIonjw/oGICCB//fDv0ljWq1okU3oRS19VHR6SZlZNksGG5C3DVAAF
 EfY3XdlHLyP+T5+ZCrlIpu4QPZqsyQN1jmIoyIWwvayfELlOEm00qHcYSVpNOWKG9WSzaSNF/wp
 eiyZ+mehA84zvMUz6Hxd7u6Hc2vgAyTJoV3u6
X-Google-Smtp-Source: AGHT+IHQZWVRv7COfUKTcPVWGcRltskCqmNyt9doYt3xOLyzJlaw8sjSpsZQE/IQWqL04mhJpyU42Q==
X-Received: by 2002:a05:600c:1e12:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-4538ee39aabmr120625305e9.11.1751288996757; 
 Mon, 30 Jun 2025 06:09:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c4acsm162585205e9.1.2025.06.30.06.09.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:09:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] target/arm: Better describe PMU depends on TCG or HVF
Date: Mon, 30 Jun 2025 15:09:34 +0200
Message-ID: <20250630130937.3487-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130937.3487-1-philmd@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Simplify PMU logic by rewriting '!KVM' as 'TCG || HVF'
(ignoring QTest, because vCPUs are not available there).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c     |  2 +-
 target/arm/machine.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b6a8ba83a46..0311ff315fe 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2352,7 +2352,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_PMU)) {
         pmu_init(cpu);
 
-        if (!kvm_enabled()) {
+        if (tcg_enabled() || hvf_enabled()) {
             arm_register_pre_el_change_hook(cpu, &pmu_pre_el_change, 0);
             arm_register_el_change_hook(cpu, &pmu_post_el_change, 0);
         }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index e442d485241..baa7ad25ca9 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "qemu/error-report.h"
-#include "system/kvm.h"
+#include "system/hvf.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
 #include "internals.h"
@@ -853,7 +853,7 @@ static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(&cpu->env);
     }
 
@@ -888,7 +888,7 @@ static int cpu_post_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(&cpu->env);
     }
 
@@ -921,7 +921,7 @@ static int cpu_pre_load(void *opaque)
      */
     env->irq_line_state = UINT32_MAX;
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_start(env);
     }
 
@@ -1013,7 +1013,7 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
-    if (!kvm_enabled()) {
+    if (tcg_enabled() || hvf_enabled()) {
         pmu_op_finish(env);
     }
 
-- 
2.49.0


