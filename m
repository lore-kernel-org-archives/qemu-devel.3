Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF38C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadm-0003yv-No; Mon, 10 Feb 2025 15:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadj-0003aj-T4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:24 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadi-0003uD-6H
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:23 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso32389755e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220260; x=1739825060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gj8bVeK5NOhu7y6Rw3GfYIssZOi6C5MlJs9pxmbGNdg=;
 b=C2QuIbabgyPYd3G6V9+QYo3qKox1PYongaMS6tWx01bdSgpbXD8puKi5jvX8Rj6SBn
 Y+c5rLxgRmW3WXP4sbDGSLElb7Siy+G/7IdppXiUgAwRjrl+OFdTus16+5AA9ejtJhaE
 K4byFznoIySIySLFWvO7kXJ918RRCzPVSpyTHerAPjLMMrCN//G2PmRJJ4ZrmvWaVH3b
 bphORmCbivfyO20SxRrOmNnodRyuAmKGIkUkyxoL9i61rkhz6ByQTnp1DkQI0fY9IsDY
 08MMrereHXY7jrLZ0hsk7aTdVSK1QL92igD45sQGQ+gk3G3LhsS9P5CtHqahr9szoi6B
 ELxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220260; x=1739825060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gj8bVeK5NOhu7y6Rw3GfYIssZOi6C5MlJs9pxmbGNdg=;
 b=xRNl16M5di/2ahNWDVnZPEOBD9qLOpKRKxvxHeuUEsn1g43dp5E3pMMJL1zxjiZaEO
 Zp9TxOs8daKiyXesFsGwqA6UYoOW9joH5s9B5HcWvTcYq/4isMaJ1IKTuX3Gqfi9yqT5
 DFtaQKaCpX+3/XRkzXnB/nRPVjw+fAhRZ+rGRwj7oy35YNyIzy8V7nnCqjCNpPFR4I24
 uyc8gN6pFPRa8MvSMUp+y2OPtcgMNcBAR3wxwC8CO68OwMQIdnR70AAL817eO/j5Tz4+
 fxWzTyE57OTngh1/Meu+zpgyhIJ1dMLaXxa3R4XDZqPakYlvNSVFcO4g+TBEzc3if34c
 q5LQ==
X-Gm-Message-State: AOJu0Yzrp6UL7V5cbL0PF1Rh2JsZ78Ko4P3H9RDmKxAH8nn0RXPXas46
 7SzFHZwLUtZR8tysWCI5oM1bdBo2/5xaAmOQHuqrle3XjxJzLTQhz6dN89ctYBUDdwty9MEy457
 BPlw=
X-Gm-Gg: ASbGncsfh39YUFpy5ziEBgoWysnmm8P0tB01A7cs7Xx5rIx0YeZaN6hdPrB21l+fj0h
 JGywrHGYy7ta+8QKqCMeQse/DbB2m+6g9uz730gdAo35lvuDntqZG/kQ6fts8uss97tD9qENhum
 q55pgkN7HaIi10khatvB3mxQMDKNiIPS1L00a39jDX9kZP5JVtOVAkh7PsMWWc4aNdSlnsxi/O5
 2/EgCRcLhKXcKq/XAucrLwUp8mSh89MSO+/Xkdz2deghHIRwmFTW8hFA+DvHDx5fyL4zeWUSZPE
 pF5tzpf8D67gh8tHAPcUBTnpJECTfhsN/wXpWRV1Ys1AS3IvdDXlX3D6EvjYDqUdJA==
X-Google-Smtp-Source: AGHT+IHYdVOroScQDlt4TOiZe4GG8CJV18muBS3cycrgMwakwWd6k5Kmvr2L7eQRDxRNmFHxPtM9LA==
X-Received: by 2002:a05:600c:4f90:b0:434:a7e7:a1ca with SMTP id
 5b1f17b1804b1-439249b04f8mr117469235e9.20.1739220260096; 
 Mon, 10 Feb 2025 12:44:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94db77sm190300425e9.15.2025.02.10.12.44.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 26/32] hw/boards: Ensure machine setting auto_create_sdcard
 expose a SD Bus
Date: Mon, 10 Feb 2025 21:41:58 +0100
Message-ID: <20250210204204.54407-27-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Using the auto_create_sdcard feature without SD Bus is irrelevant.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250204200934.65279-8-philmd@linaro.org>
---
 system/vl.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index 2ce7d8c49d7..66862807be4 100644
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


