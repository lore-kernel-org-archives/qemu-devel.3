Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55150CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76T2-0001ga-QV; Fri, 10 Oct 2025 02:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76St-0001an-1a
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v76So-0001GO-1i
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:18:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso12061225e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760077128; x=1760681928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GvzJo9cmhQhu87w0cYmMX+C4spooPwgjzIRmxcjewMA=;
 b=j9rLa1U3Fwd4693POENfPUYD+mP4UiMgxfOyqYOTz4Gi3ZyP6UTcaJlDgSu4s4phsG
 0opjnzMRPFRvXrp526HdFijWE6K4EY9HoYft16ot0AlRHzckLJEKOATHGx00oXxXpkVX
 a1ltxVuqzsbspldA2Ua2pVdeWSrtiku08wRHIa0ibsnnDHbX0XbCIWiTVN7ICv9iPMSb
 Vr9fd1oiSHKZMdDLi4JuD5YbRx3pRpwGOCdG3y5ZGXcvUrzQZPAxiVB/HS0BK6560glb
 dAIyrLXTRgbGAYPMTvupHKOoeqNINj8ONDzGle5dbVmcjhj058ldCBdOTwxnBMJ+TghX
 i/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760077128; x=1760681928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GvzJo9cmhQhu87w0cYmMX+C4spooPwgjzIRmxcjewMA=;
 b=iA4jSmuTJYXrskCydfi2Bqq8TBEUguMzsP6nMU5gVGidKCe4QekjW41Lt8YSMUDmm5
 pxFwfZFc+xMi+gWgCwXU7RjcEG8ze/t9LaCA67TWWJf3+Hcf6cW+b86MzSO4pY1QouAE
 xWpzfYjRvMh+O+uuCG4sUR6QF5Du3v8Behe90usGs3tYsaEqWuXLTVBzlz0brX2DRjm9
 +5Mlljpo2WW+Rdg0l5W/W8j7qAwIof1hgK8gzcZ3I8z3rSrCcrlJA14xXgHinYWE3aMW
 hSVzRy69uaRw2W5rjqIigNR/A/+OwF9+uSm/QX3ImtS7aHcg6Mw+KUElQmUK9UvVxMHF
 mRmA==
X-Gm-Message-State: AOJu0YyHyP3HYw2mqqwyPwIqwAmncRIbW8yf1pd7w8g0MKNwd54JL7QV
 UxMIODk/xeLQ0jQtXDvWvvvrV7/V6bTLKm1+U0deQguSBuoc5mzXCrIaI3nwO7GHYBTXc/ZHYDp
 kq8hU1rGkdg==
X-Gm-Gg: ASbGncsk5Ytojnmk9dOM6NXVdWFSrY1QapHXDJM/1bh6NqYAV4qXDbWUNclNPZO/Z0I
 5Sies/0dpnVzNpVSeD8ug8MqZPhKRnArHL2NiuC+rkhXOyR3IasgAfmpP3Vgf47/mPWGaKNyLiZ
 XYFbcFM7hMdgjU+PAFIJ3cFlWALgtaUIB5O44mye+s+CDgd1HUJv9ffB3zZKMvOSboBhDX0hjWF
 JRe6t7HTlxmcXRn3ph4sZs3Z33Z7Tr2rY4xPu2u88+jEFdBJw7/yZRUFrm6jK/8fgX13Pwb7RID
 T7mBjQwkSDb2erkms2QpxuLoOqmwySK1H4hryoBS54hhQZQyXo3j8yid5uTtyD+EhLAjbvG0pcY
 /TCKH2VKWJcEvLzYdS8uxFHGzwLL5nyBeYSLtHrMMaUyQ7zp+GpYiD/Z1n/BXd7EEj+jyGN11xw
 IfXWGIJjfM4PZbuFJcovJ7vJoi
X-Google-Smtp-Source: AGHT+IExUsMpo+9SBmRBW4aH4fNGsHB3CWSX95VtDvC1gzH2SKf42QG6uMY2foyNeHBmfzdBl38ZmQ==
X-Received: by 2002:a05:600c:a104:b0:46e:4329:a4d1 with SMTP id
 5b1f17b1804b1-46fa9a945abmr48387225e9.4.1760077127574; 
 Thu, 09 Oct 2025 23:18:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb48a60b8sm30004575e9.19.2025.10.09.23.18.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 23:18:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
Date: Fri, 10 Oct 2025 08:18:32 +0200
Message-ID: <20251010061836.45739-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010061836.45739-1-philmd@linaro.org>
References: <20251010061836.45739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

B160L and C3700 share a lot of common code. Factor it out
as an abstract HPPA_COMMON_MACHINE QOM parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/hppa/machine.c | 61 +++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2ab5fcb471a..c8da159a114 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -36,6 +36,13 @@
 #include "net/net.h"
 #include "qemu/log.h"
 
+#define TYPE_HPPA_COMMON_MACHINE  MACHINE_TYPE_NAME("hppa-common")
+OBJECT_DECLARE_SIMPLE_TYPE(HppaMachineState, HPPA_COMMON_MACHINE)
+
+struct HppaMachineState {
+    MachineState parent_obj;
+};
+
 #define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
@@ -683,6 +690,22 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static void hppa_machine_common_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    NMIClass *nc = NMI_CLASS(oc);
+
+    mc->reset = hppa_machine_reset;
+    mc->block_default_type = IF_SCSI;
+    mc->default_cpus = 1;
+    mc->max_cpus = HPPA_MAX_CPUS;
+    mc->default_boot_order = "cd";
+    mc->default_ram_id = "ram";
+    mc->default_nic = "tulip";
+
+    nc->nmi_monitor_handler = hppa_nmi;
+}
+
 static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -690,23 +713,13 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, const void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
-    NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP B160L workstation";
     mc->default_cpu_type = TYPE_HPPA_CPU;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_B160L_init;
-    mc->reset = hppa_machine_reset;
-    mc->block_default_type = IF_SCSI;
-    mc->max_cpus = HPPA_MAX_CPUS;
-    mc->default_cpus = 1;
     mc->is_default = true;
     mc->default_ram_size = 512 * MiB;
-    mc->default_boot_order = "cd";
-    mc->default_ram_id = "ram";
-    mc->default_nic = "tulip";
-
-    nc->nmi_monitor_handler = hppa_nmi;
 }
 
 static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
@@ -716,42 +729,34 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
         NULL
     };
     MachineClass *mc = MACHINE_CLASS(oc);
-    NMIClass *nc = NMI_CLASS(oc);
 
     mc->desc = "HP C3700 workstation";
     mc->default_cpu_type = TYPE_HPPA64_CPU;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = machine_HP_C3700_init;
-    mc->reset = hppa_machine_reset;
-    mc->block_default_type = IF_SCSI;
     mc->max_cpus = HPPA_MAX_CPUS;
-    mc->default_cpus = 1;
-    mc->is_default = false;
     mc->default_ram_size = 1024 * MiB;
-    mc->default_boot_order = "cd";
-    mc->default_ram_id = "ram";
-    mc->default_nic = "tulip";
-
-    nc->nmi_monitor_handler = hppa_nmi;
 }
 
 static const TypeInfo hppa_machine_types[] = {
     {
-        .name = MACHINE_TYPE_NAME("B160L"),
-        .parent = TYPE_MACHINE,
-        .class_init = HP_B160L_machine_init_class_init,
+        .name           = TYPE_HPPA_COMMON_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(HppaMachineState),
+        .class_init     = hppa_machine_common_class_init,
+        .abstract       = true,
         .interfaces = (const InterfaceInfo[]) {
             { TYPE_NMI },
             { }
         },
+    }, {
+        .name = MACHINE_TYPE_NAME("B160L"),
+        .parent = TYPE_HPPA_COMMON_MACHINE,
+        .class_init = HP_B160L_machine_init_class_init,
     }, {
         .name = MACHINE_TYPE_NAME("C3700"),
-        .parent = TYPE_MACHINE,
+        .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_C3700_machine_init_class_init,
-        .interfaces = (const InterfaceInfo[]) {
-            { TYPE_NMI },
-            { }
-        },
     },
 };
 
-- 
2.51.0


