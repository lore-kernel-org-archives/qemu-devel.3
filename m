Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE9BC77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHgr-0000BH-GX; Thu, 03 Jul 2025 07:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHe5-0005QJ-1Z
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHe3-0002hN-Bg
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:58:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so57626835e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540301; x=1752145101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65bSiZBK1YYcXSsQqihiwVaoKns5se5K6zq/pnQZJmA=;
 b=lYkY9DIZtZPXtVvI18a1XYUzhzWXrKI7tFj3M0cL5hlz7Uv3I0CTmSZLFNIEw9dYNd
 GtHzVKEIlVlKtKqq/GVum80nKfXWIeyplqaP2whR+rCSytjcx46bso7lyAO7qTIINx1U
 TXLFl/CiCAinHjsx7cqv+XlWkkx0ssDiA/G2fDIwn8GwLIG+x5U3xzpAo6RFmTMVpXBQ
 jiqfd0kQt74jCrymUyS5lJ6ZB3kxqs0utQWYXntNdfGlUi74gAd8F3yLupjXCJ/JBRzj
 DeIBwHLjnlOaYD5uodbxOo6ey77ljyo/1KdbJ0qJ+A0CLF148lj5rt2Tu/mAJEi8Xd0y
 dvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540301; x=1752145101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65bSiZBK1YYcXSsQqihiwVaoKns5se5K6zq/pnQZJmA=;
 b=FHyxey+DjfRxuBPP7Xc1XRQqQnyl3pnRlIuokbanSK0+3TtlpP+nLAgUkr+ZDKQQ5d
 WMBlrbMRXU8IspzoiHM72JJi2LrNQdCRfxTSzvfrxblxJ7dw8w2WmfOOR69iVGd1ZPPZ
 2L7EQr/cQ5JqFdGlFTQdTfxv24efm6Qd10uGXXtpLm6OyCWBjBRI8DASDQ5aH2BXE0hk
 KpKQSbOr0q91rPxCJvem6y4XpXqn+3WS5Hc1m5tiz//8dh0K4z/Mo/bBdxZGkCFBxIly
 OsuwjjJPDfGWoPnvqaWDUMrxWC+q5kf7rF8BalzhgCTRQYj+JnWh7Kc1+mTtqrcG1Ock
 pjzA==
X-Gm-Message-State: AOJu0YznHx23YENoo70liJNW9YKzSwZ1OL8xvgcV22DXZ+waeX1ChEEE
 EOzc5uFvZ92xUQ8eZYE1SJl5iH0pz0Kd5J5AMVZKmELURBHJ2150zhAVc5CRFqDeZ3gWSi8yufZ
 5YyaeiSg=
X-Gm-Gg: ASbGncuZUNHR6F7gAE9H0eG4ziDK+7D/BR6mdRWi2UYm1BvGkTihBud0xA1VauHilI2
 dVpXdm1BTEnp3FRX4vL0KAkTcQQaC1hePobNJiERkSGkTJ6xP8mELGjX2+OFNBMcpbZJTbwFCmb
 mjvgkOh6uFuDy8bcRgoDpviuJfE/rg7P2eLV/n2/x4tDwcdrDfo5VjOwmyrc680c7e4T3+yWZ2A
 uXhYCVs9d3dtat5brf0t/rSDpz05wOOvnV0jV9Pi1NYHgUjVJWWYSs9TWMRHMJx0RPKZXcNc9cA
 RxIcaW8VaDhhOjW8AxFTxi5/R0CWhcxxv2O9E4YzSh4fYiYpOaCl6ht272MdRGY2TZZUz4MuYgT
 IdwZYRIGEAq8=
X-Google-Smtp-Source: AGHT+IFnrXJdmwqfXVm57EvsTKQuyO3XMuVNe0870dybuwL8Cjih60IeaZAQMlXUOjIMVyzf3QlrkA==
X-Received: by 2002:a05:600c:8b73:b0:453:8bc7:5e53 with SMTP id
 5b1f17b1804b1-454a9be89demr37655095e9.0.1751540301208; 
 Thu, 03 Jul 2025 03:58:21 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bcececsm23556015e9.23.2025.07.03.03.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:58:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v5 30/69] accel/system: Add 'info accel' on human monitor
Date: Thu,  3 Jul 2025 12:54:56 +0200
Message-ID: <20250703105540.67664-31-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
index 246ea55425f..6cdfe485c29 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -25,6 +25,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/accel.h"
+#include "qapi/qapi-commands-accelerator.h"
+#include "monitor/monitor.h"
 #include "hw/boards.h"
 #include "hw/core/cpu.h"
 #include "system/accel-ops.h"
@@ -112,11 +114,17 @@ void accel_init_ops_interfaces(AccelClass *ac)
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


