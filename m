Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474BAC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublkl-00036A-Bi; Tue, 15 Jul 2025 15:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublbe-0003EU-SB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:36 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublba-0002kT-Ve
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:46:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so4471501f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608779; x=1753213579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cw+NX1Z/I/vv+7/l6bBturm2d7SORqaw9ensm0XSezs=;
 b=m0kUrvRCk+r6u1d7mu+zS2IaVylrF+K8PFLLNFAbj26OO1x28+pZwnq/GEv4A7BIdy
 tgyEzHmTdfMrHCj95GQx+/i9A2KwVIL0OllX3U/rSkw1cGP2I1gjJloODmODySZ3vvxE
 ZKfew27rgIeShi5H4xWYirOgMP1QjzeBvOnSdOEpTm3wXj2rUf2UkHDZz7GUonXy6Yqn
 Lukl93Y6fMtunLtFdnzHAF4cMgLN+9FkPd7JUTuaDsu6JtAwVrxoLf5t9yYdn67cVTbq
 WFEr6Lv6A/H05MBNJByZ6KymO6fiOBir9XR+ba3VqfE/k61FD9Anvl7oulK5e8h10hBI
 hPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608779; x=1753213579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cw+NX1Z/I/vv+7/l6bBturm2d7SORqaw9ensm0XSezs=;
 b=q4BacjzGuYrkTDgDqGNEyKcwrm8oT8vp/vfpNMpEb/eACToug+xEl875tR6mf8+HWM
 Fqpk8BKhFh6rnNtPptg1qlvWGEX+Rsmy3IKvku7sadXlhgczOfhw/LR6Vsa/SjROTGdZ
 DMGJ+rWVdWO2Osvd2oivOSRLt2Nd7Q6z7grDJqmNQV0wCx++uhbWp9yzuzrduihDvbfI
 JIQTKB/oCno1azyp/xSGQ1/Cxg+G3R5iKN0xH7AjSQtA7GuqM0raMQj8eDtiffuZMfs3
 N/N4RsTrVtmFI9NWLtGKIYIixNRylYHommuM+mOlewDqLxv79wzibDeC8xZ8G9HEEvm0
 kKKQ==
X-Gm-Message-State: AOJu0YxozMefvX9Spb5d7tPF7L+wPmfgS+DD8pOPIPjvCN2TRir5hudS
 PzC7xEdJoYikZEjFYoTkGeM4LW4aq3asb6bhm7YTR2Pi6EMFlNNLySZemYmE1juA1gAuBpafs5S
 aFIVZ
X-Gm-Gg: ASbGncuvizSJx5kLKUS3w9H4qfvBy1NVikVcl09h+IkkmPN9VYATWvtvEsgi5aOt3jD
 mtKcnwh7JtgaevlJFY7rUSYxPwDIk1+k7LPXwUjgN67zHzV5SDVpNczRQIy4pwR6F/MOreqSw7b
 xWQ01d54Ugp0OXUoPq0lv+xqLfwFnhnvxiu0Rx/itpWgMiwcOR1h+lpL4mq1tW7vt1xAaANd8dA
 8picKQ+iU2j7g20IoNbQdAjBfk8pYLSPZ4c81KQiD3D/ZEof7z/NnRIII6Dy9lQsgrty0PMAGFj
 5G9x0QvPYYzKC5zSsktuWWpE0I4BEgzQOslBQXMZL1iXw+Qdi1LvFS1kHu/J67Ee5tUiMzMCrKr
 ZI2hixSB4ZVP+6MRsACIYnLX7p29gHi3YOOr4+3oOc/WV8ZOtLRYGN09dFqzwoVt2Myf/SxIw9B
 PTKg==
X-Google-Smtp-Source: AGHT+IGL1XsWJVBdOttFgS3/lIZFENeG4hW/CfZeJ9Cvt3cOXuMW28tizllZNBLNh0ot7WqjiiZEyw==
X-Received: by 2002:a05:6000:4911:b0:3b5:db54:c68e with SMTP id
 ffacd0b85a97d-3b60dd4aa3dmr365961f8f.9.1752608778921; 
 Tue, 15 Jul 2025 12:46:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26ff9sm15888292f8f.93.2025.07.15.12.46.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:46:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] accel/system: Add 'info accel' on human monitor
Date: Tue, 15 Jul 2025 21:45:11 +0200
Message-ID: <20250715194516.91722-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
Message-Id: <20250715140048.84942-5-philmd@linaro.org>
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


