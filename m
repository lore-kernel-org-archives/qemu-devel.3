Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A80CC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPFY-0001Mr-6b; Tue, 04 Feb 2025 15:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPFS-0001Fv-Sf
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:10:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPFP-0006hO-Po
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:10:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso42161925e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738699811; x=1739304611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhmA/maE+T+RrjSr6dpY30qil8BVZDc6N3XpaacESEk=;
 b=XUNnyHcLRkC15Z8nlDkP68umo1S+C9vJQMmUkyBaYFcBkRg01UHLmdT1siQWh2hSQl
 5HcVkjzrKGS/RnagCl6qaEa5XY1coXb3zgm5UuAe8DKIPiJZ2QEkKZ8iIZnpqDkto9mB
 6K+OYNTUCGorTtNoLgHcvTBu2fkP+BVIyKxFtklP7SgwADd9cGyySGesFwDofdzZ/KUd
 QjNnOA++6wqjyEUqV77jonv5AR17ZBLB4b2vhDZ+Co2fgWcFFOeuZYlZmgFNbGMI7wlr
 yxOK4+GZpM4CFQDqNToLifqisM7nbE26IO4O8HwIIUss+6f5k/YYGLcyoc6szHNPMcyG
 yQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738699811; x=1739304611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhmA/maE+T+RrjSr6dpY30qil8BVZDc6N3XpaacESEk=;
 b=GZFqmNvEfSg6oYFxlLOpa7u5Z3VKVbs2sl1y7y7oAPtbw4iVHMGHrFhveV6egmkdBh
 ex6HoI+hqXr+wqPiIita/P3Kcux35zWcnqXFJEZnQinjA669mE2B8zHwW9Zp/ELMsMx2
 MVFpXylH4fUYw5pFOyBkqoGCFS2iTA5PddWlae7Lm8LLq9mNShsTYnV4DPH+e7pnFv+x
 Pqc/ssTG+fB5lRtg4cEfhiENujuRM663g6tNGWmw5aucGtVmIF38ewQU9KOGHyeLcmJs
 UU8ZG3/P/Mo22Sy6IBbGsbQVWD4ahElFr8qPAZM6DANH7zo/JFo2+fq7q5uO6IOTKQUc
 /q9g==
X-Gm-Message-State: AOJu0YwVF76clBrYU535IedmWeD3zOWa6XlBK+uwMA0+BPcLRRqMVGMy
 AmXypuqnMsC3C3HUaiJk6XRJi8xQRF3MCRQPAAgqMiuulO5VeeiisZw4jf6uQFjfN3FRB5WpTD9
 2mGU=
X-Gm-Gg: ASbGnctmvjUuj4F3rJ1tBM87wgx9eCT8/1GkAyt5yJknNM16U68/AaYVCM1s7jeVy+u
 4Oj+IHlgi58v++OCRIK7Cypdf6uakdri6BO/9+AlwCrQc084GSxaN+9S1+uonHc9jpB4iVmp1B6
 0KN7iexCCU5d8z814KotmmsLVoRrL9HJYnJwYFhAzMF7hYIO7IX/ejLPTuZmxcG+TwOVBei2Qoc
 xLgwfWsYAiPQrmEy/5fbemMNgn/qgbp8b8XtjOWGPRoH9LuJ32A1enn3L2PuaOrEYmLJFSIJGca
 9q9fzI08fdfhbWcblFY3qObRr39zCfFb8Mag9YPoYe2tetNVU4WJzJyeUiYQpazlDA==
X-Google-Smtp-Source: AGHT+IECUpMeniqijK4mePxq840Vp3xOlLEVSJrdQh/GL2m7Mhjps3IHcc1c/ih6zKtBGGSc+riCFQ==
X-Received: by 2002:a05:600c:5112:b0:436:fb02:e68 with SMTP id
 5b1f17b1804b1-4390d42f7c5mr67025e9.2.1738699811044; 
 Tue, 04 Feb 2025 12:10:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38da59470b2sm3255118f8f.40.2025.02.04.12.10.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 12:10:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 7/7] hw/boards: Ensure machine setting auto_create_sdcard
 expose a SD Bus
Date: Tue,  4 Feb 2025 21:09:34 +0100
Message-ID: <20250204200934.65279-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204200934.65279-1-philmd@linaro.org>
References: <20250204200934.65279-1-philmd@linaro.org>
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

Using the auto_create_sdcard feature without SD Bus is irrelevant.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 5ff461ea4ca..a904687b57c 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -53,6 +53,7 @@
 #include "hw/usb.h"
 #include "hw/isa/isa.h"
 #include "hw/scsi/scsi.h"
+#include "hw/sd/sd.h"
 #include "hw/display/vga.h"
 #include "hw/firmware/smbios.h"
 #include "hw/acpi/acpi.h"
@@ -2661,12 +2662,27 @@ static void qemu_init_displays(void)
 
 static void qemu_init_board(void)
 {
+    MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
+
     /* process plugin before CPUs are created, but once -smp has been parsed */
     qemu_plugin_load_list(&plugin_list, &error_fatal);
 
     /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
     machine_run_board_init(current_machine, mem_path, &error_fatal);
 
+    if (machine_class->auto_create_sdcard) {
+        bool ambigous;
+
+        /* Ensure there is a SD bus available to create SD card on */
+        Object *obj = object_resolve_path_type("", TYPE_SD_BUS, &ambigous);
+        if (!obj && !ambigous) {
+            fprintf(stderr, "Can not create sd-card on '%s' machine"
+                            " because it lacks a sd-bus\n",
+                            machine_class->name);
+            abort();
+        }
+    }
+
     drive_check_orphaned();
 
     realtime_init();
-- 
2.47.1


