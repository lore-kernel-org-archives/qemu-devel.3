Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28882CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Yj-0005Mk-4C; Wed, 29 Oct 2025 11:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Yc-0005GG-Cd
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:55 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003Xr-05
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:53 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso2196628a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753452; x=1762358252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TrDTvZiJG4yDG73wsRxB9Wak97hDmOb6p4nvdjA0DcY=;
 b=NbuT+Q92QdTOl1L2fZ9ey+HdK5kIziIxicX66L9Cno4kIjgGGtQnKCUnnqNv9isBCx
 6H7Xptc6LAX4iCb9F1xWIhlq79f4Dua0AO2AxVmLRnR010ZiT4lTznpmoKuwM8PooQJY
 85NXqcSpDkqZ3PQDIh95DBPbp7ikf6glywY1FiBUkw+V0pNOmFpIqm8jX7AIzVe8KB89
 iHfR+gnZ/rZ4ISeLlju22Ml6/F0Q7YwhrGcQm/trqipIS+sg82c7c+JAirxe7N13O5I5
 6q+dPrhlK/A4Lb+o3oobrPi7pBbP5iMcw9JPIMUV1KHkA6UJx5zXQo+CcMWh91LVBuW0
 YbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753452; x=1762358252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TrDTvZiJG4yDG73wsRxB9Wak97hDmOb6p4nvdjA0DcY=;
 b=J2UW9vTsyTyepVus/5CCor9qVCfqtKQZwjCMKjF1RIvAuiRPtA4Dk5KcAkzFCt0IJv
 +PZygEjWdo9Z+6yugw4sRVxZu/iWCVQPLA/9SiZGdykzA9PxxAWdNWQHY3jBfGfktM06
 CuaRbiV8sM1QD+F6V1WovvO98gZroWb9tpWLzHYhOwt6gCKAsih7z9HdmKbYVnOk8rKg
 d6KK82Pt3tCyCb0w/BCmXIgXvfoooNp/WXSA+b3PA3h3bG9HaAuJOzrHFUTf9PyG3KP0
 VghN1vl4rME8xcGEics2AI+IaKc4avIU7t69uJWn3vERMv4VJV3kyhamM8CHSgOMNNVo
 6dng==
X-Gm-Message-State: AOJu0YzBkg2eg9IwcG1zzLymCh0OBBybYCg6VEdjUhlT7EiGb7Y6jR9+
 vhY57esptbL8vhRrnUvVtPtiQKTV9j49+Pelv1Xs56lMp3z1Tyt0ZAMI+/5pwM8xP+c5EJC/PRl
 EvOCS2qs=
X-Gm-Gg: ASbGncsNywzUulNg8KSb4DAaszpi5WY6li5BVaHE7v3A45MAEJiReBLnY5Zndnny0lE
 2uFZn8AYnTNNvGODs+LZIaeAeKRpiyKGxUFPKBS0NHi/1WQQEk6ErjfZ9g+Ia9Er9K0zeXW41A8
 CaoTGgDGI5h2h3w/L7uOnDoks1y1H+S3l4YI6iZA6w0Q3IKjh7GlMiN7FU+P5KJePyApI83gfTS
 glvpcKcSazDprDQFWQ/Uyj1kd9bJtWyoHuN+GDc2quNglZupT9yuq3DkCPXhz77faIH1pGKvYYv
 T8CRuxyOs15pCe/J1fC5s8YfFPWGliXLS0o/nR85Ml3kU2dKKqyVhfsfHwFcoflIpH7NxQwowDC
 PjWEnnWWvQom44qVq9fyu0MmCfQEpt6zNrjI7M12MNg+vKGB08PYrDYFKb5R5fToCN6VOra+Eeq
 yL
X-Google-Smtp-Source: AGHT+IHg1BTnAUZG3sy2mU17DsFflxDrw/5NGVNoDUZS80xsCyFNi0XKXTSARZ8Ipw2OPWdnNzRNtw==
X-Received: by 2002:a05:6402:5165:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-6405e7cd523mr76185a12.3.1761753452610; 
 Wed, 29 Oct 2025 08:57:32 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64043e05a5esm2528748a12.4.2025.10.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF74860CB8;
 Wed, 29 Oct 2025 15:50:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PULL 20/35] target/openrisc: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:29 +0000
Message-ID: <20251029155045.257802-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for OpenRISC targets. We treat anything other
than resets, timer and device interrupts as exceptions.

Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027110344.2289945-21-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 486823094c8..d357aaa7da1 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -25,11 +25,13 @@
 #ifndef CONFIG_USER_ONLY
 #include "hw/loader.h"
 #endif
+#include "qemu/plugin.h"
 
 void openrisc_cpu_do_interrupt(CPUState *cs)
 {
     CPUOpenRISCState *env = cpu_env(cs);
     int exception = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     env->epcr = env->pc;
 
@@ -98,6 +100,19 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         cpu_abort(cs, "Unhandled exception 0x%x\n", exception);
     }
 
+    switch (exception) {
+    case EXCP_RESET:
+        /* Resets are already exposed to plugins through a dedicated callback */
+        break;
+    case EXCP_TICK:
+    case EXCP_INT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
+
     cs->exception_index = -1;
 }
 
-- 
2.47.3


