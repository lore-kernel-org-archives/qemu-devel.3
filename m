Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A1FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgzE-0004QR-Gb; Tue, 15 Jul 2025 10:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgKH-00051X-De
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:08:09 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgKF-0006ax-36
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:08:09 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-32b3b250621so48132941fa.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588484; x=1753193284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlnnQVYR7UDi9FQuqtljHTy9JqrOVxDZXhuwIJFwMtU=;
 b=ml6ULte8F7aZwGayKUB+gb20Y+q7eifa0igpUCrooCrmnhgrehecjD5cBfZ8lnzg+F
 YBhMNcqwwPYevfflsJI6DEGCBlDACyQH61q3PxLE3aZQqKNQm3f5MEcDUkKdunPwuS3R
 EUy3mWmSLd02+K8iZFJEUpaiLvFAs+0TZVVgy2gwOAvqSuytkWtU+TF5E0ey0ucY+Uru
 v1FpEfY4qQxSlhcxTj0nplo7JdDN3/iG2U6G85wSBaWqObAq1pHEPLoThVGlN/Jv/ITP
 xxbvqOwNX26lJKm5JwpnXNEkbIY6yd6sOQ+G5SviG1e75U6NIWsY4EG8fZO3ewi/pQfH
 vYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588484; x=1753193284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlnnQVYR7UDi9FQuqtljHTy9JqrOVxDZXhuwIJFwMtU=;
 b=Bwt9ebw0kMLXS9Sque4C3z3TwDUVZRZNf8gqETOAcetFm4w49gCxkpnvJAhF+dm6UB
 mAGSLEAxMrR9XM2H9bL2ff72rvp8aDy4EltWkFl2iCUf/hsjvSsWgj7ThbLOrmkKFgo7
 e5LM7uzn906ryB3o8lI2eCMKZtiAftEOu/D+n6kO/DPGs8ZO3NUz/HSylhA88ePiOgCv
 2PnG4vuSyKgpD9a57tcJruBK/93IrYRToa3K40JxYv39kbaJj3zKGFgp4NcGDRQKLMlZ
 ofV8VwUkeR4WOdZWnb7bkZDnliawSxM3WX8oL7FAawfQf6hczQB9pm1pL6lMKtXCG10G
 8EgQ==
X-Gm-Message-State: AOJu0YzCjSpxbBBR0iezyCZ/CU2vZ7Kl4FbvI11f+ribfcxbwcba5Voo
 7KUf2U5y/MutyxXZ/f5SyPJjFsQfsuPcYdcMwHXw8Odu6u9USJoKBXWHOYZynFGpwyHxTyAICx9
 gXWSx
X-Gm-Gg: ASbGncvohMwyJMM4I5WcRiAXvSg5Fuw3tIl54dXG54uksbQWHhYS0A3areoknoYADYz
 tgYz6H5azMsEvviCo2+42AzWBRz1wDGpzkC2Unxt0+rgADujedho0w5wVLhxd/DzH4mBQwlw49g
 npUwwN8pGdGpo9zktvI/SLE/v7VQiy34fUePnX6wdZ3dtcaTz1+4b8wCjvQbb0ZQw2HCcvD9AXm
 UOSsBT1V7nN0ARAWeu4a0EZ6p1RJxxznPR/B5S49HUqQnL3El1UUA3GT4dhvQXaSJzqFEHui9uM
 d/fDgb6PjihQ46E6E239tGHctEM8hSKTlZuMtHYFlPB4K+FzFa7WiPc80DDjcE25hgMgU2QS1rB
 fQyH5yGGVJN/527SyrRlt8ot+ShwHaKU1fWS+Z7CBvSUWtgB9nfSu8DNb/MrBKPVCZHHPlht/hl
 jflg==
X-Google-Smtp-Source: AGHT+IET6AfPGQspy2YEf5sBC8PEdvdIjXjuOuvGFQU5KEacnAemZCPR5Fs5Vaej4m347Jl0Uoo2Mg==
X-Received: by 2002:a05:600c:5187:b0:456:1c44:441f with SMTP id
 5b1f17b1804b1-4562771c272mr29894655e9.31.1752588074914; 
 Tue, 15 Jul 2025 07:01:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd537785sm165175635e9.23.2025.07.15.07.01.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:01:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH-for-10.1 v6 4/8] accel/system: Add 'info accel' on human
 monitor
Date: Tue, 15 Jul 2025 16:00:44 +0200
Message-ID: <20250715140048.84942-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715140048.84942-1-philmd@linaro.org>
References: <20250715140048.84942-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/accel-system.c |  8 ++++++++
 hmp-commands-info.hx | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 76cf4e7ef7a..1e97c64fdca 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/qapi-commands-accelerator.h"
+#include "monitor/monitor.h"
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
 #include "accel/accel-ops.h"
@@ -103,11 +105,17 @@ void accel_init_ops_interfaces(AccelClass *ac)
     cpus_register_accel(ops);
 }
 
+static void accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    monitor_register_hmp_info_hrt("accel", qmp_x_accel_stats);
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
index d7979222752..6142f60e7b1 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -267,6 +267,18 @@ ERST
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


