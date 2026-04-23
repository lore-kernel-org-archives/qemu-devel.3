Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAECFFDEE27
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFxTX-0001jX-Fm; Thu, 23 Apr 2026 13:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxT1-0001IU-2T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFxSw-0005iU-0O
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 13:03:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-483487335c2so68061555e9.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776963828; x=1777568628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zd/YFz6QaH8XwfH3yB/TOjWNiK07VelK7idPnaaUGxk=;
 b=AKPUZKx6dwoeDfixfaux0xF0b0qLAnEXxaSw6RALUHeyx0oY7ZGwBZIVdMZzT1FPSW
 TjlPE+PTjt1zYuVEsTJii4WROdxJH0JhEQ9sf+M+9bmS4MkUuzTn+7uZASwK8nLA/3YA
 hqRIUxk53rV4dNTjgmaiV9fjfYJRpQrsjj+W1AKGtjFp8neJ5RzsUPyAhRwNOilMvKs0
 2cXKM9wRKRmCKAwX58SS/qUrGhJfKXkUnQjT7/l/KT4Y+r5N6RzqfDv53jesuAXptFfM
 uIdS7GAOhWLEFHc6gr9/29U8K2gKnGHGucTEILvU5NH/tw341EePlCp71WRKLAZxOKcU
 GVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776963828; x=1777568628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zd/YFz6QaH8XwfH3yB/TOjWNiK07VelK7idPnaaUGxk=;
 b=EsjmxmcfUyYWpW8DUEcS0hZIXTbLLJEv+YR1ZTDblZWGFIHTSHsDhzFoMOV9m39cmi
 g3fXuItk6Qy0Njg5oTNNiVl1/htzfYqqr6geFfLXkSZwlDdIQdNJrQdXHFqujekNx9br
 lrrN9hzBmneWE9cc8xHdeaiE/ufqMsVMsxdGNN4PZb81Ebcu9DnvcFNJmynQYQysCOdn
 8wMi12D6uFF9cqYOjQIXTpg/C6j9cZj0F9PqP6X1rd8TBSu/yuGGE55PQlWNUvsRwT3u
 3i2dBpTQNSHnwZDCo1klwalh2ysIHxnxUF5C3K+nP/uR95BENhlpCHeregu+8uLOZgBv
 G38A==
X-Gm-Message-State: AOJu0YzRLg6OgwI42T056Wf1WSaL9cwwiHQKDzNIgFpipvfleFkya3X9
 4KPumIn8LQ8WOlqrFgbJf13KAyHi2UmFQv2+hwWaxSYULiqEfCTzbFfXZmMEVhhIcgSoRAT83NU
 1luBm84o=
X-Gm-Gg: AeBDiesplx5Gjd+NHTRn7DG9WDELYJZlRX5VIb/NbPUvQIQ0QcNByYFvmPtLEcY4U/E
 /xNAb/v1X2MLUC2WK8TGJwpTiK5S6kCX4tsGLFr1mXOyNB4Wo6ZN9BFXvq+jMvTGXf+nRoN+jsk
 M+C2ZjqMMGleWpn0EHIJTqmyxbBgYLNfLtjARfrHIraNwNJPhZWFMUT9dtEiI0D1rHp1c93LGdE
 01UQL1AHf5+FmZ+xIy273liT6eL+Sg2Ui85AwTXOAOE8z5/ExcL9DDgdZq4CqFVyGMOg5IsMZh9
 roQ2n30XlEvCUjv4v47c5uVebte8CzAHLsScQXSqHrXswO4id8IBsq7NK+lhBhZsNj0/ZeKu6Gz
 Mz7ji+faaGalJpEfrBjVZshpNek2USQdvWgxTXm3YnwYDV70sbs5HhI5A7wb8rdMIeuXNQY7nOn
 QeJT+6DQfWNL6lNUBydPmI/00/UlZSH4IUgx+ok7LStFVkxx+9gL8i1CpOHpjfxI51TSk78HA8g
 t2N/w9zbKhGUQirXVMoFw==
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-488fb796fa0mr383690255e9.25.1776963827997; 
 Thu, 23 Apr 2026 10:03:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8193sm485631935e9.1.2026.04.23.10.03.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 10:03:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/16] target/arm: Use generic hwaccel_enabled() to check
 'host' cpu type
Date: Thu, 23 Apr 2026 19:02:22 +0200
Message-ID: <20260423170229.64655-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
References: <20260423170229.64655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

We should be able to use the 'host' CPU with any hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/arm-qmp-cmds.c | 5 +++--
 target/arm/cpu.c          | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 83ec95c290f..ee17261c9fe 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "system/hw_accel.h"
 #include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
@@ -96,8 +97,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    if (!kvm_enabled() && !strcmp(model->name, "host")) {
-        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
+    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
+        error_setg(errp, "The CPU type 'host' requires hardware accelerator");
         return NULL;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ccc47c8a9ad..4f98121be0b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1629,8 +1629,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled() && !whpx_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM, HVF or WHPX");
+        if (!hwaccel_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with "
+                             "hardware accelator such KVM/HVF/WHPX");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
-- 
2.53.0


