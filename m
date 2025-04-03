Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7D0C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJV-0000cD-Rv; Thu, 03 Apr 2025 19:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJU-0000c4-5E
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJR-0000Pu-P4
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso1009832f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724171; x=1744328971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dr1ajPlH6JN6hTaMKguRfw4hYb+PXW8/xQ7f19VH6vQ=;
 b=ybjZSfaAwHgTReE0hqs/O/Ug9MVE3WHMJMIJMPFJseiDp5pJKViLE8aimOmNsbzxNg
 TQoAggxuRnMoI423HxH+Xhbia8cuxN1HpinnYIQpWN1ZOy5kvIWsuw/12Ppy9pCURyMV
 UVHXsdiTrH3qA8Yafv/ctVaaG9v2P9irBnbbKS9jS5UF/w5/Vzpnm/yGTztUVgk0yvPj
 XOsK18zUNyJL8fisoC9dd2dOxpe9prbgJdd9EXVoaADzUs2CZ8fLduP6NbTyi4g3synP
 gQjIJM4vwsUHpgvyJEytNJcT4rBdWPOrMsDlwU/IxmuIijUtOPZZyOa5Ce0zL67ovTKD
 a8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724171; x=1744328971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dr1ajPlH6JN6hTaMKguRfw4hYb+PXW8/xQ7f19VH6vQ=;
 b=UfBd8OPS96xWH7OxAV+QwixN0fDyFQM2tXylpoPFBN9IOTig2mGPa8Qq/CLQvjEQp9
 VilNks5tYYwjNyDJpv7pGeMR5raKnE/JNOUahXlsuP81cNKy4Q5nA93HQ8kKuin/9lMC
 Gn++B1BsLyBWU79ViQp7e5FNwBfGhgXVZedXVAosLiwIkdjnbXi5dSQzvSXQsxVPy6ZT
 4r0tdwGUHslir95v5Z4gM93BHhAEHN0DcZHXoxEMojj1UBu+2Gm5wMjetIRob8+l3ijT
 qiao1EZfZRp1WOmKEMsOZ57o6xed5w/WTo8P6dOZfWygHC2TUevqe4nh1HsOrrJ8cb01
 rKfQ==
X-Gm-Message-State: AOJu0YzQQAZ9KVZt/+7Ul3uPqz62MZbugmrgeZVlDhGYEBneXhKv99Pj
 bUAB28HpOl/H+B8SfqCRJa0omOpnmEbmXaclzLFQEbq0I1u+zCd3T6I5i3qzhx4V0IW1X7dP8g6
 x
X-Gm-Gg: ASbGncuPeUlmJQryAkzozHB1x0zus0o8OUBuKbk6eFgIXARIv5DhrhYCGkRXLFyqM/e
 BECVrHPcjlWant/AtPuq/8x9+6hD9vdIVnjeG2C6aybQLKcDG+sA0BszAoERbEiBIlZa8Q/hs9/
 CEMgddLKHcfmiMcH0a0KMdU92xHtIeYR1XF/dlFxLUUoqIHriqtcRwQEhDvYH1ZJHgB2glsh1K6
 nsk2g7AmYGda7AxLHwMoYMPiojrEVkBOOYhwDUU1MYOOVvPvShRl1gq8OGQtxuD4XJqML98dJF8
 wISNENdPXt9Hf3zDJjC2fxXDhkqOsafdj7RTkr49YN4BxPtBabcXbZJg5WV4p4rDMGaIPLsIkiH
 NT1seXMthMZ3GlLGiYT5d7cpjBr7ZyQ==
X-Google-Smtp-Source: AGHT+IEJdc/oUH88yGHT8LqEBHVAe0pCN/7RQh88SANiYQxIYFQ3+DnMRvR49xggiIkExgwvV8DS1Q==
X-Received: by 2002:a5d:6da6:0:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-39c2e651726mr5597399f8f.23.1743724171656; 
 Thu, 03 Apr 2025 16:49:31 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226bbfsm3015600f8f.90.2025.04.03.16.49.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 02/19] qemu: Convert target_name() to TargetInfo
 API
Date: Fri,  4 Apr 2025 01:48:57 +0200
Message-ID: <20250403234914.9154-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h           | 2 --
 include/qemu/target_info-impl.h | 3 +++
 include/qemu/target_info.h      | 2 ++
 cpu-target.c                    | 5 -----
 hw/core/machine-qmp-cmds.c      | 1 +
 plugins/loader.c                | 2 +-
 system/vl.c                     | 2 +-
 target_info-stub.c              | 1 +
 target_info.c                   | 5 +++++
 9 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5b645df59f5..9d9448341d1 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1115,8 +1115,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-const char *target_name(void);
-
 #ifdef COMPILING_PER_TARGET
 
 extern const VMStateDescription vmstate_cpu_common;
diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index b340e192fce..00bb746572b 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -16,6 +16,9 @@ struct BinaryTargetInfo {
     /* runtime equivalent of TARGET_INFO_STUB_NEEDED definition */
     bool is_stub;
 
+    /* runtime equivalent of TARGET_NAME definition */
+    const char *const name;
+
 };
 
 #endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index fab3f3153ea..5b8f17a15a3 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -15,4 +15,6 @@ const BinaryTargetInfo *target_info(void);
 
 bool target_info_is_stub(void);
 
+const char *target_name(void);
+
 #endif
diff --git a/cpu-target.c b/cpu-target.c
index c99d208a7c4..3f82d3ea444 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -165,8 +165,3 @@ bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
 }
-
-const char *target_name(void)
-{
-    return TARGET_NAME;
-}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..6701e210f54 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,6 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/target_info.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/plugins/loader.c b/plugins/loader.c
index 7523d554f03..36a4e88d4db 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -29,7 +29,7 @@
 #include "qemu/xxhash.h"
 #include "qemu/plugin.h"
 #include "qemu/memalign.h"
-#include "hw/core/cpu.h"
+#include "qemu/target_info.h"
 #include "exec/tb-flush.h"
 
 #include "plugin.h"
diff --git a/system/vl.c b/system/vl.c
index c17945c4939..d8a0fe713c9 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -40,6 +40,7 @@
 #include "qemu/help_option.h"
 #include "qemu/hw-version.h"
 #include "qemu/uuid.h"
+#include "qemu/target_info.h"
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "system/runstate-action.h"
@@ -79,7 +80,6 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
-#include "hw/core/cpu.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
diff --git a/target_info-stub.c b/target_info-stub.c
index d683a05977d..db61a335908 100644
--- a/target_info-stub.c
+++ b/target_info-stub.c
@@ -13,6 +13,7 @@
 
 static const BinaryTargetInfo target_info_stub = {
     .is_stub = true,
+    .name = TARGET_NAME,
 };
 
 const BinaryTargetInfo *target_info(void)
diff --git a/target_info.c b/target_info.c
index cb17d29b86d..6b44ea9fc0e 100644
--- a/target_info.c
+++ b/target_info.c
@@ -14,3 +14,8 @@ bool target_info_is_stub(void)
 {
     return target_info()->is_stub;
 }
+
+const char *target_name(void)
+{
+    return target_info()->name;
+}
-- 
2.47.1


