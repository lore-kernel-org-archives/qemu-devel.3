Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD232C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFA8-0001yW-QT; Tue, 08 Jul 2025 16:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDeb-0005HR-SF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:07:03 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDeW-0004Xl-6c
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:06:54 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ae0bc7aa21bso1016525666b.2
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001610; x=1752606410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHSfU1hw2z+9jkIM4IPD8mN1I4YQgc2MZothfwYUUn4=;
 b=t4KnuV3Vr88rAy4zwRWx6jrB1MTPLwCV7FaKR09iVvdrYhEntXlZFpI/sa3JB6ujtP
 jGxLSgA8N9tV/tT7m/TupY6dNz6ooMAMdg+KAsr+9h60c6e9SwOEiZ2L0cZkABPU4AB5
 bbb6sGbw5QJTD1Jm0VZDswoinHVxVj+Qtcek0nlYb/N2aeXKRy4M+b/Jn2hmc9MD87Sn
 aacE/7rmTQyeUqPg6o60J+7I5qMn4zlMfsrS60djtw3DMrbteFrZR0McQWxgHsZ9Uyxn
 9ayboBkm7XYwNYYj+9UD69Ppd3TP5TaX1gKIHGAbx1uUQTHpzXAxMWGk9lYKdN9huJQz
 bd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001610; x=1752606410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHSfU1hw2z+9jkIM4IPD8mN1I4YQgc2MZothfwYUUn4=;
 b=RGsMMLz91sEGHZPKtcaOdCfSA2rjDkwPbDYpGPmYOyMbRK6v0yRFvih+suFNbMs5QY
 MFlvILHPPgyz3EdhGoHayb06nZk/+QZeWvsLdqWbskedZt71uEnyO3WoPHSnlMi/Prbw
 /LoCv3RiB6COoxV79Z92cY+ihOmirqCtFXxbdFoGo/yS35rNhncYcDkYK0a21RYAJ2Kk
 5rUip2LwuFhf5yWGSe+9Ed0gcCdx8IW0Y3s7AaxE2J1xU9ixjezxE8X7lTBg3pV94R8P
 6EMHbMGfQa4qpJmZQUkcjdFiJPhbSyghe2nGmAYKW2/TD4LvaA0aC9jNsdUkqvfBxOW4
 Cz/Q==
X-Gm-Message-State: AOJu0YxsImbK2Ps9eWl3VMmbDahWWgnxWgHowaEIHN4sUMRb1BtteVZe
 G7PR2cHzXzp7iH08J+MSYvT5Im20PYbmLbKHK7aJNRTiHpdJb5evc0MrsgLCnFTIORh7G/C/9EH
 7iJAs
X-Gm-Gg: ASbGncuuonY8hRE17ZnRryGXvR7/GiWwhU6YB2p+NL1Ra4WWAX80WX7G5lKaeTJMXbT
 mihufh9A/I6UQMZNnLtcqnnB9Pm0NfFxGkAk1tiaxX4IUO3XWl+KInuOlXiCkTFgI9nDWzFpmj7
 yX7uPcBVYQyGvhpTEjzNvonTcx7xFDj2Ahy2+6AaLXyvwEAQvbMbuSlPLNeg9T0L7Ec47zp9mua
 7Mt7jAoXUqmTQJ1WyIDvPJGl5lHCufIUJBBlu28tTw+1wiNulJKpNb4XhTa5/cW/ueAQvkzNlyT
 JNBvuEcO0RUE4QwwguxkNqKHOWWvXyrbS8BkQGVMXxY1zk8MKdZ4Vtwhe4ud18u3ivlTmYByX4t
 12ya+h6VYQWv5FcD2Bphyl23E2DBkyy6BfS1H
X-Google-Smtp-Source: AGHT+IFsmodWCOsSIAzcPTk6dkh6F8N2/9PUPUtepWvho3NU70iaiwVVCG+G9Q36XUWaJ/6q1u8LHw==
X-Received: by 2002:a5d:6f1a:0:b0:3a6:d255:7eda with SMTP id
 ffacd0b85a97d-3b497038ed2mr14264397f8f.28.1751995228021; 
 Tue, 08 Jul 2025 10:20:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b97353sm13744377f8f.51.2025.07.08.10.20.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 10:20:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH-for-10.1 v7 1/8] target/qmp: Use target_cpu_type()
Date: Tue,  8 Jul 2025 19:19:41 +0200
Message-ID: <20250708171949.62500-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708171949.62500-1-philmd@linaro.org>
References: <20250708171949.62500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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


