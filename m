Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 915DFCD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyAt-0007LZ-7O; Fri, 29 May 2026 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAr-0007It-Hb
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSyAp-0003QA-M2
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:26:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490686877a1so40937385e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780064814; x=1780669614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JIu8PCygzL9wHkP8hkt7uxJi7hvxrUL4lU7Ro6etspM=;
 b=P9X7BxTigXRmmyO29DHvdv6+AVDN8Sd93paUAsNqp8ud5/u36SIdG9rz3N4BUEd+ok
 AyPP3d2vgtaXvj5EW6YVYfvXZTDwh25/Uhe+SvGOwXh7GdzGPr5pluGFhnBXuOXY6ssO
 ny8FoQHZuFtADMpc3jV58y9eR/9LU1sBclHjUBMts4Czoha6rAC3ohfZy4H5I3nTPKEQ
 7m1sVrq/tPDEHx0vmtcjcf+UIHdc7GVtApV5SDx+SwI8Aym43NEwBUSU4MDXZKy9vXGe
 1MFLPGNgzkQIt2IsfOpPn4NhcS9Ji1CG/0K3P04HA+AqOtOy+JxlNXx2GdKwMZQTR/7i
 rgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780064814; x=1780669614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JIu8PCygzL9wHkP8hkt7uxJi7hvxrUL4lU7Ro6etspM=;
 b=JxufRzUSK2ktBfIxJtSYVggG8Nt5HKJn7Mm2xBWAVh47N2Yqa5QZaPJ66XwAvOCPpL
 YW3DQ1t5rCo6eSGgXi2GM5j+jOot9YEQiAp66PQB7n3jnecwBtSxYuAgRWGc+fuWAwm0
 7ex2GXBs/HIK+lCawbwdApV4WCUeIzf+eJye1SvdVoTUvwYP6uYIGXWqJ2O5hzNmbLs2
 MGaPNcsxTWGZVBies2nj7c8Td3vmB2NFNtym0rhaKa76XeYwWe/b3f+F1UigcjfwNFUX
 SXXpC+hfSwq5/lXK483NOrd3G+St9hPyrun+mlmZeMIzr6emLinMzI56ESo7gol8ILHc
 Dd6Q==
X-Gm-Message-State: AOJu0Yxat0LlEOAFAIv9NrFa27WcRkBbTSZxxdbmIQ9WYvVtafrQue+F
 5NWsm3CbzozF73TJlAtntwBRjfUpenV3t12T32CikaSU8cO0Fzt/U23MqUu3CHdh41/vmEOUPf1
 WK4PIsyUflQ==
X-Gm-Gg: Acq92OG7hTl5ao3VvmTDAoFK6RXdzqMRj3nQ3IiMx4GzB2LKugAXeMbjrgGUPKsM6tr
 6dENFOk93c8MDICMgDABM1UAjI/j34mmgSCR5ML8JKeQRkPGdn49COj6ZbnN/T3j0vIlHOG4NZ+
 gTcNaDdbVMlnh7B5cPuN6qlvH/MQT2TX5h4pKE3mzEJKZU/izzj6Gj6RjivZHioZZARzWe3CkO2
 F8xxjffeKCtLahhOae7+yCSeBwLXsZzpGzyFXDKbD3hvOLvxYgKJz7KlKc7MYsTb8jYDT0Cbgev
 rEkWdVrBo6ItKX4PD5b6oSQEruuCARKf6nzj8n34R86gsUWBrsehRWJV9Sb1aKiAIfkdlOf0l75
 iYlAuO35f8KVU4CQdi4XmDi3//PIdK6hnJlA2WucbXpW/I0kia4em4VWPAf3bo4ct5AEeqJ33fS
 N8q0pSGDQ8aVuYOxGeoL5sfTiWCL3Bv0i8VxWPBXqLHO88Yx5Oz1/ix0DihtroIwxxj17Vm7wEQ
 Pem
X-Received: by 2002:a05:600c:a30f:b0:490:4b89:5372 with SMTP id
 5b1f17b1804b1-4909c62603cmr36489245e9.11.1780064814109; 
 Fri, 29 May 2026 07:26:54 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d6a0e42sm43781075e9.8.2026.05.29.07.26.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 07:26:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 17/17] accel: Remove AccelCPUClass and
 'accel/accel-cpu-target.h'
Date: Fri, 29 May 2026 16:24:33 +0200
Message-ID: <20260529142434.87880-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529142434.87880-1-philmd@linaro.org>
References: <20260529142434.87880-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

AccelCPUClass is now an empty class. We removed all uses of
the TYPE_ACCEL_CPU definition. Remove as dead code, along with
register_accel_target_type().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-target.h | 31 -------------------------------
 include/accel/accel-cpu.h        | 19 -------------------
 accel/accel-common.c             | 16 ----------------
 3 files changed, 66 deletions(-)
 delete mode 100644 include/accel/accel-cpu-target.h
 delete mode 100644 include/accel/accel-cpu.h

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
deleted file mode 100644
index 6feb344e29b..00000000000
--- a/include/accel/accel-cpu-target.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- * Accelerator interface, specializes CPUClass
- * This header is used only by target-specific code.
- *
- * Copyright 2021 SUSE LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef ACCEL_CPU_TARGET_H
-#define ACCEL_CPU_TARGET_H
-
-/*
- * This header is used to define new accelerator-specific target-specific
- * accelerator cpu subclasses.
- * It uses CPU_RESOLVING_TYPE, so this is clearly target-specific.
- *
- * Do not try to use for any other purpose than the implementation of new
- * subclasses in target/, or the accel implementation itself in accel/
- */
-
-#include "qom/object.h"
-#include "accel/accel-cpu.h"
-#include "cpu.h"
-
-#define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
-#define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
-DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
-
-#endif /* ACCEL_CPU_H */
diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
deleted file mode 100644
index d7ea45ada2e..00000000000
--- a/include/accel/accel-cpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Accelerator interface, specializes CPUClass
- *
- * Copyright 2021 SUSE LLC
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef ACCEL_CPU_H
-#define ACCEL_CPU_H
-
-#include "qom/object.h"
-#include "hw/core/cpu.h"
-
-typedef struct AccelCPUClass {
-    ObjectClass parent_class;
-} AccelCPUClass;
-
-#endif /* ACCEL_CPU_H */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index d8ee6d62667..4fe15349012 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -11,7 +11,6 @@
 #include "qemu/accel.h"
 #include "qemu/target-info.h"
 #include "accel/accel-ops.h"
-#include "accel/accel-cpu.h"
 #include "accel/accel-cpu-ops.h"
 #include "accel-internal.h"
 
@@ -98,18 +97,3 @@ static const TypeInfo accel_types[] = {
 };
 
 DEFINE_TYPES(accel_types)
-
-static void register_accel_target_type(void)
-{
-    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
-    const TypeInfo accel_cpu_type = {
-        .name = name,
-        .parent = TYPE_OBJECT,
-        .abstract = true,
-        .class_size = sizeof(AccelCPUClass),
-    };
-
-    type_register_static(&accel_cpu_type);
-}
-
-type_init(register_accel_target_type);
-- 
2.53.0


