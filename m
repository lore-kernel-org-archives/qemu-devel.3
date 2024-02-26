Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954B5C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reWwE-000781-Hx; Mon, 26 Feb 2024 04:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWwA-00077G-Em
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:06:14 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reWw8-0003Vh-9K
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:06:13 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3f5808b0dfso379056266b.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 01:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708938370; x=1709543170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fx8gADBe2ucDCcShPCUpi1E8G9A7PtB4VTqy5UmiqEI=;
 b=I4/e4LbAG79Xcfu2u6/gz/iU8cJhz1Nk9XHaj0RA/fpAlKgD/jDtruMU9vpRf6YE7s
 i7oPlZ5My8eNyE/t92rNy9N9hW8ySF7V9xHzEwMAJymiGNNjT5ocQOoa2rsc6XeNK0W7
 y1kOKgyuKVCSaujepcuTDyUTISq22Av4AvyFbB0LfHWjXZ6f5UaRHARObP97Hmaw50X5
 +oKNLiHNDg5N502dqvHRFBlD5zGr83/G7SoUBkXaFtV+UW5BMAtyufGRS9IBVQeXo329
 sl1kv9ClD+oTlabUYQ9icfu5yJ+WGanTesCBpIHW6kg5RNrBpVrZug8dTOMfVVDlKzYS
 uKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708938370; x=1709543170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fx8gADBe2ucDCcShPCUpi1E8G9A7PtB4VTqy5UmiqEI=;
 b=K1tlz/0FYad9ytUIAp20fYm9WUUVBgtDTDk5gtLg6Q0zW7Cwwjh0/HZVo8IvSqXSVp
 lpPxyQVp4GHnOviRWSEKGpYFSSnIGtXxjp+oQ7p5jt1xyybIDXzO09m/gQSEgtbFQSaS
 BwkcEZRdC7NXI0leImcIgo3q6o1qk34pDAMAiRmMUG9Hn704PejnEg02RVPWyl9CSUqr
 hJZvhgR6JYkXpEKhWgfv7ddaQkjUssZFhUTZs1MgW3jGIZzbkjmhPCAzc5mqjgtbEy1l
 y3waQ98HA1X18wBJnEaSo2wQiTDTEvqhajUv4g0xML4ktNA5EHq0S5Nn3Cm0G/hBhe1Z
 d7Cg==
X-Gm-Message-State: AOJu0YwUcVUAJCakTuAdOWXIbjlYGgRHtsGCvldnXR6XVg4zt3nqFLfh
 SX9oj4np+cdwdgKNpKeKr2WbqlICxG7ttjBbrXv7t5GtJ3VC0BZ7Wmr/whqdpgMCTFzlDRfSCx/
 8
X-Google-Smtp-Source: AGHT+IHMqAFO7+xpmXQNFVbCJI7o8aZMcL3AjqcHr5QsBkJCmO/l+tGITIN70TboFSoLxBE7HaCtTg==
X-Received: by 2002:a17:906:a00b:b0:a43:3879:35e0 with SMTP id
 p11-20020a170906a00b00b00a43387935e0mr1808930ejy.11.1708938370099; 
 Mon, 26 Feb 2024 01:06:10 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 tl18-20020a170907c31200b00a437d3e975esm159660ejc.210.2024.02.26.01.06.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 01:06:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/acpi/ich9: Include missing headers
Date: Mon, 26 Feb 2024 10:05:59 +0100
Message-ID: <20240226090600.31952-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226090600.31952-1-philmd@linaro.org>
References: <20240226090600.31952-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

The ICH9LPCPMRegs structure has MemoryRegion and
Notifier fields, so requires the "qemu/notify.h"
and "exec/memory.h" headers.

However nothing from "hw/acpi/acpi_dev_interface.h"
is required, so reduce its inclusion to hw/acpi/ich9.c
source file where it is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/ich9.h | 3 ++-
 hw/acpi/ich9.c         | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 2faf7f0cae..215de3c91f 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -21,12 +21,13 @@
 #ifndef HW_ACPI_ICH9_H
 #define HW_ACPI_ICH9_H
 
+#include "qemu/notify.h"
+#include "exec/memory.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/memory_hotplug.h"
-#include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/ich9_tco.h"
 
 #define ACPI_PCIHP_ADDR_ICH9 0x0cc0
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 573d032e8e..6205de6046 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -34,8 +34,8 @@
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/ich9_tco.h"
-
 #include "hw/southbridge/ich9.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
-- 
2.41.0


