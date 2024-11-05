Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F72D1268B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbZ-0004gX-Py; Tue, 05 Nov 2024 06:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbU-0004aT-6D
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:08 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbJ-00078j-CF
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:06 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so4013025f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805594; x=1731410394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pRL4mDTjVw9mfjbMMniJd6QkIPpIN0o0sYfT9bqu/h8=;
 b=jbrBQsMz/bC0OTpKA684iLmiDZ/n3zmiJ+zivdVCA2TRoAZv6/dOQ/UIhaZAAhKOOp
 9OnGaJT/EPQKM+utUtmhsTmJFSZHH+BE5OVmPigdw8QJyfglgUjg1u/4Gh5o060tDYAU
 sujBt7NYPqpa7mzeZ4Cd8edW62e2azkZWamMlaNcXCjFIfsbXrmHciPkFazPEOHSTMMb
 XM0tgOO8vOicDazORs6JRkcMopQkTo6NoY+1/7jZ5K7534BW71uOzqX1PMoAT8clcULt
 dOozyHsE3Gw/tyucvGgOvddwqbCz7oqeQZqcScXssD8hAph7Qsv98r/UQDhf5tdghbuz
 WZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805594; x=1731410394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRL4mDTjVw9mfjbMMniJd6QkIPpIN0o0sYfT9bqu/h8=;
 b=mirSX+ct+YsBxrtf4zl8uQ3Ji05/yjdIvPWVvlPHzRFk3JL7Xx6iYUWJINwJBGH0x7
 g1mcA2EJvju3UIo/EF82vpQitV1EumRhU+ciAIfFw+CIdOftDYdeKxw9dcr2hAGn11e8
 nqAMEi6j5EWsa+HzYJ5p3bfOTm2lw22Y0POHESoEuVv8+V8AIZJAC99b2MjhfNhgGZ2q
 2+V4wOIPdfLMYCnfCnedeletTDnfoZaj3JJ4okLoYOogPs95IKWCT3BD4qbb5GY1XUXY
 Z4cRVY+FZnbVIZBwzBy8pf9mBxHgI0NZX51zHao8oCqogo9sWZvSUF8EX5MxhQ70N2MN
 bJWQ==
X-Gm-Message-State: AOJu0YyAH4wpNuj1FPrPerXgy8plf2OrUe7pWT+HxQdhp9vRDEiM6+0N
 kWbt5PY3WFZHtd80utVHujrfFCIr6wvwTgdkGRtOVlePiP77COYbDR/0YhQDEIf0L3ECxZoPgBn
 L
X-Google-Smtp-Source: AGHT+IFb3FOnBV06+RbQjkiLVZv8rfrPX1f7EbPVHyQbnki3LFjpC+3mPkHtdGcZ+eu5ud7EZe3XYg==
X-Received: by 2002:a5d:6da2:0:b0:374:b6e4:16a7 with SMTP id
 ffacd0b85a97d-381c7974c6cmr13763013f8f.8.1730805594301; 
 Tue, 05 Nov 2024 03:19:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/31] hw/sensor/tmp105: Convert printf() to trace event,
 add tracing for read/write access
Date: Tue,  5 Nov 2024 11:19:33 +0000
Message-Id: <20241105111935.2747034-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

printf() unconditionally prints to the console which disturbs `-serial stdio`.
Fix that by converting into a trace event. While at it, add some tracing for
read and write access.

Fixes: 7e7c5e4c1ba5 "Nokia N800 machine support (ARM)."
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241103143330.123596-5-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 meson.build            | 1 +
 hw/sensor/trace.h      | 1 +
 hw/sensor/tmp105.c     | 7 ++++++-
 hw/sensor/trace-events | 6 ++++++
 4 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 hw/sensor/trace.h
 create mode 100644 hw/sensor/trace-events

diff --git a/meson.build b/meson.build
index c386593c527..4262e1e84a9 100644
--- a/meson.build
+++ b/meson.build
@@ -3484,6 +3484,7 @@ if have_system
     'hw/s390x',
     'hw/scsi',
     'hw/sd',
+    'hw/sensor',
     'hw/sh4',
     'hw/sparc',
     'hw/sparc64',
diff --git a/hw/sensor/trace.h b/hw/sensor/trace.h
new file mode 100644
index 00000000000..e4721560b03
--- /dev/null
+++ b/hw/sensor/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-hw_sensor.h"
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 9d7b911f596..ef2824f3e1b 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -27,6 +27,7 @@
 #include "qapi/visitor.h"
 #include "qemu/module.h"
 #include "hw/registerfields.h"
+#include "trace.h"
 
 FIELD(CONFIG, SHUTDOWN_MODE,        0, 1)
 FIELD(CONFIG, THERMOSTAT_MODE,      1, 1)
@@ -150,17 +151,21 @@ static void tmp105_read(TMP105State *s)
         s->buf[s->len++] = ((uint16_t) s->limit[1]) >> 0;
         break;
     }
+
+    trace_tmp105_read(s->i2c.address, s->pointer);
 }
 
 static void tmp105_write(TMP105State *s)
 {
+    trace_tmp105_write(s->i2c.address, s->pointer);
+
     switch (s->pointer & 3) {
     case TMP105_REG_TEMPERATURE:
         break;
 
     case TMP105_REG_CONFIG:
         if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
-            printf("%s: TMP105 shutdown\n", __func__);
+            trace_tmp105_write_shutdown(s->i2c.address);
         }
         s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
diff --git a/hw/sensor/trace-events b/hw/sensor/trace-events
new file mode 100644
index 00000000000..a3fe54fa6dc
--- /dev/null
+++ b/hw/sensor/trace-events
@@ -0,0 +1,6 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# tmp105.c
+tmp105_read(uint8_t dev, uint8_t addr) "device: 0x%02x, addr: 0x%02x"
+tmp105_write(uint8_t dev, uint8_t addr) "device: 0x%02x, addr 0x%02x"
+tmp105_write_shutdown(uint8_t dev) "device: 0x%02x"
-- 
2.34.1


