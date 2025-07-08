Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE26AC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 22:10:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZGUm-00007w-Kd; Tue, 08 Jul 2025 18:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGCH-0003t7-UZ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:49:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZGCE-0002w8-BJ
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 17:49:53 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso2641772f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752011388; x=1752616188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91kh8gM7bE1DvG8K9EhiXTHWKL7JzNJQDQuB0S1EOTc=;
 b=qPi4QAjrl0OKEVH83y3dj+AMZuXeITMFOLtQaBex20C+U36HUU7OuUFbiOx5rKmMNx
 ZRwrWWCxgwWHACcgtjU50ctV9psdJ0xRsP9/F9TBMyBzaJu+qviyvMeJJvCaIgeIydza
 WhGeeu65HeXTMNxSw9CjV8AldRgNURoUMLp5KGULu1Eyg61Iq02ZNymSROHZ18UttdXi
 s1PtdZ4+bHSCXrrXAAGBgcsiKrSH1iyVCsC6F3n8Pua2Jszti8bEdyOst0Bc+6rpPyR1
 21cA1c7C7PX7ClJlhjuZ6bYKSDJcG6+mDTbZcBfSlcrvdF+pnoxIKJv/Vc1n/xu0DUuY
 XLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752011388; x=1752616188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91kh8gM7bE1DvG8K9EhiXTHWKL7JzNJQDQuB0S1EOTc=;
 b=LYXYrC1RgRXbdguVov7zawsMTxBcHrDb6rGhpZlU6I9gg3EoHq7aGGvbYIIhaOdY9j
 1/K3Vwe2mw3HMnWOyT2e42cTIhZPAOnEODnj1M2LTI1xQogHjqtMRwyrvj/6mK545Q4k
 zRwelN6uK8Vh7GRYAwM9hYkENkvSzqhtbkeBxeIq5p63Xkaw2bxOsZJwQ93MNavNyrND
 t0n4fTpd0N+12rlv2l+3mynhhR6pg/dDWTOTPcfiAAs+JZ8eJzv5cDVxyT2lj+NWzgFK
 Liuguc5e3zj8UTo9+rV0H6r/oc22oHzkywOJzNzqFPALgMaqIPePaGhHVQrKXvabywKP
 Pz1g==
X-Gm-Message-State: AOJu0YwjpKDZfQ1K5M0+LQR5aCGzZ0ENcQ2QB6IRkJalPgi0GS/8VegS
 RmJfQR5ub+DSMw+9R3YKcP/SgvSxFA8sEpKYbNs56hoYV+zUzzF7RLV0SUvTSAasnBW5+CQoZHk
 npqvG
X-Gm-Gg: ASbGncvgYCred4PkxUsUA3Evw4sdIAp2n2LoOvmGPlXdUmVY4pmHPpW+a5fVG1GFdoI
 arOzzpILvf15Bb7PHUZOfn4BOoJN+CMtUg5NfIVOI/3JPzELFuV0G1oqJ5qIF6hfusL5h7ePgfZ
 Z0YRCQGXKJcJ1coWhig4sVdT4FSUEI/EfSmGMGCVBHPq4PqLGdtENo7wZ7KFmhnYcVD/HAj1HkF
 bqom7GN/AsKme8atgvTd6f8LJIxHOz+2LO4Jt7i+hJe+AnXvFZMa6ZYCX8Gjhz0hkOKXdKIFXjZ
 0mm37wkpdQ/woTUb9PWtLUl9zIiJcXNiF1S/0BlmaEMzT074cYNKNPCdIPHmz4nMhOM99A2/xs1
 4LyuTTGaOV7Myzcn2SsSY9GPrCh28D8JdBuNl
X-Google-Smtp-Source: AGHT+IGz/nDlysTObTTFveGgG8xteLGP44HOWLHgSh2RSo9II+etzca5BMNc9nan0XmMMHCx5DdNig==
X-Received: by 2002:adf:b64a:0:b0:3b3:9ca4:ac8e with SMTP id
 ffacd0b85a97d-3b5e320cdeemr684024f8f.44.1752011388403; 
 Tue, 08 Jul 2025 14:49:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285d3bbsm14150487f8f.96.2025.07.08.14.49.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 14:49:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-10.1 v8 1/8] target/qmp: Use target_cpu_type()
Date: Tue,  8 Jul 2025 23:49:10 +0200
Message-ID: <20250708214918.70076-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708214918.70076-1-philmd@linaro.org>
References: <20250708214918.70076-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/arm-qmp-cmds.c             | 3 ++-
 target/loongarch/loongarch-qmp-cmds.c | 3 ++-
 target/mips/system/mips-qmp-cmds.c    | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index cefd2352638..d292c974c44 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -21,6 +21,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
 #include "qapi/error.h"
@@ -241,7 +242,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_ARM_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, arm_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index f5f1cd0009d..1d8cd32f5fc 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -32,7 +33,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_LOONGARCH_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, loongarch_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
diff --git a/target/mips/system/mips-qmp-cmds.c b/target/mips/system/mips-qmp-cmds.c
index d98d6623f2f..b6a2874f2dd 100644
--- a/target/mips/system/mips-qmp-cmds.c
+++ b/target/mips/system/mips-qmp-cmds.c
@@ -7,6 +7,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "cpu.h"
@@ -40,7 +41,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
     CpuDefinitionInfoList *cpu_list = NULL;
     GSList *list;
 
-    list = object_class_get_list(TYPE_MIPS_CPU, false);
+    list = object_class_get_list(target_cpu_type(), false);
     g_slist_foreach(list, mips_cpu_add_definition, &cpu_list);
     g_slist_free(list);
 
-- 
2.49.0


