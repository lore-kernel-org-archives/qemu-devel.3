Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9B3C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 15:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgd9-0005fU-D8; Mon, 10 Jun 2024 11:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgd7-0005eL-Ij
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:08:17 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgd5-0006Yw-SA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 11:08:17 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ebeefb9b56so506341fa.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718032093; x=1718636893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXk0bDQ1yYJpJgY5lHESnxmo/mUAUI8vWA756v/ff84=;
 b=IP+419bCWvT4ByeHNw8/QBFSAJa4YP58FXPo0cm9KILSNBFSWKzDgHIQNnKDYroR84
 Z/J0zl0A0LQfbkzl00eELfN7E/JF3ZwHtclLGTSJAt5TwpkTk4xY9bqhjB5GAyfyJ+c1
 sfJsqplzHXyABFWZ1B5OmHra+RC/kqB1RaspNJnUh7q5DPzZZkrOybcnwvSOKfr/qI+S
 KdCgOT9yNGj8YcGEzrtywQ47CQKIisFRAAnAnZtumv43d55OaVbc3NaXunAn49R7m23n
 UtW5q3JVTUFd0wGJt4m4OKt5fR1g6O2d1PABPHOEjyREfnXb3Pcf3u8v/CNKzsTJI+OK
 4ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718032093; x=1718636893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXk0bDQ1yYJpJgY5lHESnxmo/mUAUI8vWA756v/ff84=;
 b=mzR6omabrGBaOoG1ihxAq1Da0dwA6vVNYqHuecAU96Fzwot7oKivFMMXcE1rxWTTt/
 7D6x84PO5pH6QapXJR/1ITo5w6DtlJGbR2+zPUXZZXLWQpwnKMTeumb0WaIzuEyM9HlN
 DtnVV8oBQsSDRPEZr3F72z1OxfepfxBENoNkBb4JFJnpuQvfoPzIfYoF0lAIC1EgMh+b
 gMpjumYV6MZ8EkwDT4CrmJJLpqLk0FhWlAjA1b9uF45Nh5FS2oUlWPQ3pEpTlDYiZXCZ
 ASOVEWLlPwxyiQpgnX0pGOv29W94vkjdjM/YGqw/iXMEekRxy++3ETNWXBjEvgmrPPVp
 69Pw==
X-Gm-Message-State: AOJu0YwOlqDbE2mYz5YpFvRWovqXFAUT/7jjtdznXA5GjDlls5s/Rpbh
 BVMgeTKo1QaSB1JM149EC0ve0sGkZlRxRlqpucdWHnHuGbQ+Wr12unCB2uF5WF8LOQ0f6cyOq+Y
 L
X-Google-Smtp-Source: AGHT+IE2dYsYRaJMuNiOMu/WfBm+5ctwyi5FGzRoWFgkg9afl/d4+UxNQa9lLHdwSp8Ts/b+K+5Vmw==
X-Received: by 2002:a05:651c:b06:b0:2eb:f029:7142 with SMTP id
 38308e7fff4ca-2ebf029716emr2631901fa.15.1718032093424; 
 Mon, 10 Jun 2024 08:08:13 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42196386d13sm47450965e9.12.2024.06.10.08.08.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 08:08:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/misc/mos6522: Do not open-code
 hmp_info_human_readable_text()
Date: Mon, 10 Jun 2024 17:07:58 +0200
Message-ID: <20240610150758.2827-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610150758.2827-1-philmd@linaro.org>
References: <20240610150758.2827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Register the command 'info via' using HMPCommand::cmd_info_hrt(),
so it is processed using the generic hmp_info_human_readable_text().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/misc/mos6522.h    |  2 --
 include/monitor/hmp-target.h |  1 -
 hw/misc/mos6522.c            | 13 -------------
 hmp-commands-info.hx         |  2 +-
 4 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/include/hw/misc/mos6522.h b/include/hw/misc/mos6522.h
index fba45668ab..a54fe063ac 100644
--- a/include/hw/misc/mos6522.h
+++ b/include/hw/misc/mos6522.h
@@ -172,6 +172,4 @@ extern const VMStateDescription vmstate_mos6522;
 uint64_t mos6522_read(void *opaque, hwaddr addr, unsigned size);
 void mos6522_write(void *opaque, hwaddr addr, uint64_t val, unsigned size);
 
-void hmp_info_via(Monitor *mon, const QDict *qdict);
-
 #endif /* MOS6522_H */
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbf..9b46fec84a 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -53,7 +53,6 @@ void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_sgx(Monitor *mon, const QDict *qdict);
-void hmp_info_via(Monitor *mon, const QDict *qdict);
 void hmp_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
 void hmp_info_registers(Monitor *mon, const QDict *qdict);
diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index b1bb7f54f0..afa343dd27 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -29,8 +29,6 @@
 #include "hw/misc/mos6522.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "monitor/monitor.h"
-#include "monitor/hmp.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/type-helpers.h"
 #include "qemu/timer.h"
@@ -587,17 +585,6 @@ HumanReadableText *qmp_x_query_mos6522_devices(Error **errp)
     return human_readable_text_from_str(buf);
 }
 
-void hmp_info_via(Monitor *mon, const QDict *qdict)
-{
-    Error *err = NULL;
-    g_autoptr(HumanReadableText) info = qmp_x_query_mos6522_devices(&err);
-
-    if (hmp_handle_error(mon, err)) {
-        return;
-    }
-    monitor_puts(mon, info->human_readable_text);
-}
-
 static const MemoryRegionOps mos6522_ops = {
     .read = mos6522_read,
     .write = mos6522_write,
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cfd4ad5651..a24c217d89 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -873,7 +873,7 @@ ERST
         .args_type    = "",
         .params       = "",
         .help         = "show guest mos6522 VIA devices",
-        .cmd          = hmp_info_via,
+        .cmd_info_hrt = qmp_x_query_mos6522_devices,
     },
 #endif
 
-- 
2.41.0


