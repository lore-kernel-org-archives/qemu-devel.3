Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B7ECCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:29:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNTT-0007B5-JQ; Fri, 24 Oct 2025 15:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNTK-000787-LV
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:29:12 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNTH-0000sa-Pd
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:29:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-475dae5d473so2015415e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334146; x=1761938946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZmR/vKigIXSmSa6cg9qftLuQu/Ejb6TYNf4zV+r4wwo=;
 b=gAQZQAuS2XN4/6O/QglTa6pHYVPE7mGLlTTK1WAVFlYtO6A1WWaLHEJYxZ+PQFOOw3
 tYl8kwE6Dzv6PZndKo9DE/Cpp4lVdqs8/ZB8DpG5njcYPdTYrx5f+pjCxaJB9lu11j0y
 n/rIaEnuTOQpc+LWvhp2cSlvwY1GdgvZ4uJ4np9BC83fZc7+Dp+iVh3J05apLm2CFQSx
 AwonEikaEx+w7858fQi3MZVcnNlMWyXAkRY8VBdv4/j/A5+izYap+2HgW4FwWvjkyXhh
 Je6tNALkjxrrFnWY2oake48EfikVqGR1afoHzI7OAGt2uq8kL2yTzzyMdM5WgQyOG5A3
 y4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334146; x=1761938946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZmR/vKigIXSmSa6cg9qftLuQu/Ejb6TYNf4zV+r4wwo=;
 b=PAOK6q3sN9+VH1AHjyZjcJMrdaS4cHv11AfxAdUD6+HULDPuQlf9lDnWcH92QGhDkc
 MHBlZDCMJJclAji1uwtGsJnjw6PHkbAGy+H5fiP6BwK9FmJVgb+fkqo7D2DhMyzt4dpi
 QLCNmsovwn/FJSdd+sAKNeC9GP+4QduKuQQksmmjvgS9aK+VG54YoPG/cmj041KCCK3q
 TzfTKIpfozZJEcpn8qtnZvvjjtDmzA3/jqDsKOkDXJF7VeM7OF1Ym8xQo2fNxFugUGK9
 YOeCHBvbILXSUiVgIxVyse41mslaI05Lw4p5gdzaZguBIaNW6rBeDoP/lX26X727y3xk
 c8CQ==
X-Gm-Message-State: AOJu0YwtoJBTxKyLL5Jo3FXJrdfqYx4HTepuKRBZNtryzpcIf5menJmc
 1b3Vk3oTr+NfjcwOYzna57USBUHPIOwhMYvsztRKWKRUxiY7O/y4Kef7K6XDgRoeWFcbR6My43R
 PpzudOk4=
X-Gm-Gg: ASbGncuuQH7EW5sYniYQLU0OV7qpxmeS32uEdKtlz4xthma43gUU0VvRN6W2RnhIYYQ
 q66AhDt5vf5CUDQ4IlwKmqWh5z6SkanLKSf8FHa5k8OXkc6Zpixf4LUhduDb8DakDrbpN+bvprI
 JXzkjCZd0p5bLA52V9mCzB4VBWGRv8JTt0cXxGO9NTQ29Ve5lHxvby0aMLcBWS7QVFJAB0gcknH
 5vcnU6v9jpX04nIU66sHqdIIXg4n09VLcMwnb/5WM++iruVvV6rB4aFIyXhzRd6OWgXlmbyC43A
 eZ+ZhkV999V85thTKNfrpPreg8ZJKRXV2iiYzl3FHF1AsxylGCKrvAvaJMud/WTqCMYtCByYKZ+
 SYG7CGMLLV/1cUaooxpzLmTVVDs9ytdlBNrNkS4bwPWhEADicVVaqHkg3jwU1hlA2GrCOBwE25n
 vQlUJKXoIHvp7ffOmNR81z/0i9OogrWkPVYgPQZDvwLRFeUHz6Ig==
X-Google-Smtp-Source: AGHT+IG0RiK01kZIh16MR1iqaoEqzr4gEB8V2N/4RTW4W09n9yQ2EU7tZFGNsh9H1+jSXGktk6surA==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id
 5b1f17b1804b1-4711786c79emr250191335e9.6.1761334145875; 
 Fri, 24 Oct 2025 12:29:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898cce3bsm10580944f8f.38.2025.10.24.12.29.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:29:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 16/27] hw/scsi/esp: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:03 +0200
Message-ID: <20251024190416.8803-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/scsi/esp.c:31:
  include/hw/scsi/esp.h:82:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     82 |     MemoryRegion iomem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/scsi/esp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 3526bad7464..340a713831e 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -1,6 +1,7 @@
 #ifndef QEMU_HW_ESP_H
 #define QEMU_HW_ESP_H
 
+#include "system/memory.h"
 #include "hw/scsi/scsi.h"
 #include "hw/sysbus.h"
 #include "qemu/fifo8.h"
-- 
2.51.0


