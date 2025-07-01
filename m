Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1703EC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCK-0000uW-U9; Tue, 01 Jul 2025 10:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcC0-0008Tz-Es
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcBu-00070Y-W6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4150853f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380951; x=1751985751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sBntsVr1Y6zHOAmwd2m7NhcLZN4vsokXucO/PBfodqM=;
 b=cs/e0zRZIRzJxgl+tUmm1pijptAhs0OXfGx0yKQIA0nDTB54etah7X81K8FqJBcQMC
 nbQ6G20cqKuBRIghWA/tWw57urpqNfToUQ9GaxqqjO1Jgn0yPH6zjBIJhErxmj96EclN
 b//UBd7fem/6mOm5Ee+d0p2u9HhIqWp+QN0g3MQK3RTrf8xf08abGJ3PiVzfNrP906lh
 8gPKTWPVYbo3zjxeMDNgMoMl3N6cKc2Ky0LW+Wgo0Nh05ht0wu2nmSAtUlUpmmG1Yin0
 ojufGplwLKfEt9/qmTCYDqFIaLSB3yjxdIIagQkgYvS6XfZuXWoJkwm07qvRYmrFvEMg
 Kp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380951; x=1751985751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sBntsVr1Y6zHOAmwd2m7NhcLZN4vsokXucO/PBfodqM=;
 b=t8pdwRKxHaQBGu6ngJ9rWpswlYfQO0GdwcdLD/cwj8maAvemtU//74G7tbBP95KURS
 6+B3I10RDFRw2hpCd9VnlL0ln51WvOuGASxU02W179jkGgOyByELgS8sMFFoaYJGN8hw
 3zI0lHI6t0zKKZaen2q/1ttTnjHIpwB/3+H18rMyPK2SF0/Kes4FSvjILplh23Uf5+35
 EaWTs3QcnBHZ2MUa/p3Z/EqNZ8/0Z3tzIPGFe4+bSLx+ZilJ+suMuJQOrD1sJQTBTKH7
 AKJoRfgNJIv9tnI00u/R2Jbm/8bufr78NU6ED0yvjR30qRBmHw+OIpSswFySQaUVsFi0
 hI2g==
X-Gm-Message-State: AOJu0YwQhFPqWpTT4xSAWreOXlvV2GAdT0lHcZ8OK3AFZbth7xNcVWal
 EBlQ/bM79wNS1NAVEC1pOkt53L6e8aZBoqpzEYjhnMrIZpsBmPelAfLAQVwsbv+lbd0ar4n7DhM
 XCF9T
X-Gm-Gg: ASbGncuBUVlD+VmdjJgLhw+bINEHPIIgp2DIa4iVZ9cD6+1PKvyiO3Ojz14ArWJN+ST
 X8i+ulOLueafIuGBd+Q8Yn2XWUc4/jWbEEdyoz6imjoWnTg7xWhpJzwpcjRSsBb5WzVrrY8QoCP
 6OR/k/yzkB0Zl+IFmJRISQobar6eRQhS8tAJp0z3QLaLnLfQbPyAlRzqisAH436uhv+wek6+wHt
 TqqnLD85CZQai6tzvHGcdELtVYDr1cItSUAYFvThYzd3wXvoN+6WnV5oV0Cv2/hAKkzFz9axQp1
 C86PlfHKtgurV+Uv96dRqJa6jWYkuNlV3nJt7WMUQYnBR5V1DWKqS+5Tpju/nwZFeH82usueD8U
 Jzhr9LKYkUnrBxrTP2GrJqeb982e4JF0o5PYH
X-Google-Smtp-Source: AGHT+IHzpyiFAUUmmUath4/BN/Mt8Ok0y3N/0/VqZY21EhrbtxCB2HESnPLMi0VfAspGXmYjQG2a3g==
X-Received: by 2002:adf:9ccb:0:b0:3a4:f787:9b58 with SMTP id
 ffacd0b85a97d-3a9187514aemr11881947f8f.58.1751380951445; 
 Tue, 01 Jul 2025 07:42:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5b2a7sm13504267f8f.69.2025.07.01.07.42.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 24/68] accel/system: Add 'info accel' on human monitor
Date: Tue,  1 Jul 2025 16:39:32 +0200
Message-ID: <20250701144017.43487-25-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

'info accel' dispatches to the AccelOpsClass::get_stats()
and get_vcpu_stats() handlers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h       |  1 +
 include/system/accel-ops.h |  2 ++
 accel/accel-system.c       | 28 ++++++++++++++++++++++++++++
 hmp-commands-info.hx       | 12 ++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 065de80a87b..80bfe3c4d0f 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -41,6 +41,7 @@ typedef struct AccelClass {
     AccelOpsClass *ops;
 
     int (*init_machine)(AccelState *as, MachineState *ms);
+    void (*get_stats)(AccelState *as, GString *buf);
 
     /* system related hooks */
     void (*setup_post)(AccelState *as);
diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index af54302409c..106ff56d880 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -50,6 +50,8 @@ struct AccelOpsClass {
 
     void (*handle_interrupt)(CPUState *cpu, int mask);
 
+    void (*get_vcpu_stats)(CPUState *cpu, GString *buf);
+
     /**
      * @get_virtual_clock: fetch virtual clock
      * @set_virtual_clock: set virtual clock
diff --git a/accel/accel-system.c b/accel/accel-system.c
index 11ba8e24d60..918900a0a8a 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/type-helpers.h"
+#include "monitor/monitor.h"
 #include "hw/boards.h"
 #include "system/accel-ops.h"
 #include "system/cpus.h"
@@ -81,6 +83,26 @@ bool cpus_are_resettable(void)
     return true;
 }
 
+static HumanReadableText *hmp_info_accel(Error **errp)
+{
+    AccelState *accel = current_accel();
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    g_autoptr(GString) buf = g_string_new("");
+
+    if (acc->get_stats) {
+        acc->get_stats(accel, buf);
+    }
+    if (acc->ops->get_vcpu_stats) {
+        CPUState *cpu;
+
+        CPU_FOREACH(cpu) {
+            acc->ops->get_vcpu_stats(cpu, buf);
+        }
+    }
+
+    return human_readable_text_from_str(buf);
+}
+
 /* initialize the arch-independent accel operation interfaces */
 void accel_init_ops_interfaces(AccelClass *ac)
 {
@@ -111,11 +133,17 @@ void accel_init_ops_interfaces(AccelClass *ac)
     cpus_register_accel(ops);
 }
 
+static void accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    monitor_register_hmp_info_hrt("accel", hmp_info_accel);
+}
+
 static const TypeInfo accel_ops_type_info = {
     .name = TYPE_ACCEL_OPS,
     .parent = TYPE_OBJECT,
     .abstract = true,
     .class_size = sizeof(AccelOpsClass),
+    .class_init = accel_ops_class_init,
 };
 
 static void accel_system_register_types(void)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 639a450ee51..0496be6abfb 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -281,6 +281,18 @@ ERST
         .cmd        = hmp_info_sync_profile,
     },
 
+    {
+        .name       = "accel",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show accelerator info",
+    },
+
+SRST
+  ``info accel``
+    Show accelerator info.
+ERST
+
 SRST
   ``info sync-profile [-m|-n]`` [*max*]
     Show synchronization profiling info, up to *max* entries (default: 10),
-- 
2.49.0


