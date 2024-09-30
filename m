Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EEFCEB2C2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 22:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svOjh-00053o-0l; Mon, 30 Sep 2024 18:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOjc-00052h-Rp
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:19:17 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svOjb-0003OF-CF
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 18:19:16 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so717478266b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727734752; x=1728339552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIxUd45FAwon6flSZCXe0no1A54a/QmmveEo4YQ5JqQ=;
 b=CGLSVCrAL0eg25y1jP7nQdsRWCMaYHiSbqDFYL56b541cJbSUoB4sdXjugMXndaIju
 s6nohohIPiL30Y9NwZ7U2nfbOYo6mWyzJ8SE+4/5VHnVTZQOmR8BNsgB+jfBGXNyaDET
 dhTCj2j97vpPtbQqEXobEHBQYt6usVUrPK5Wl6UKkPfsKA5smH5mgGYkK2hoSYEtDRKH
 ruz8+UQHo3lEwscEu1x/pu+9V6xblUDdVHdZZ04BeRfRkdYAn3vWK7HQTntGXF5UTTED
 iRFT16lRXbuogpiYwt8nnJXCxmklgZhznQuCMLoj4bN1ONIBhO94xh/1KQiWi168P74H
 +23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727734752; x=1728339552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIxUd45FAwon6flSZCXe0no1A54a/QmmveEo4YQ5JqQ=;
 b=vpi8T0JttFDepvlgOKs6z4IGJmKJXYVr4EaXHjouMm7TbY9n0dqpWW+R9xDAunaEZn
 iIjRQQHkVtDj3eiLkT8cHUngv2BPPevJ6dPXTzz1sPi7kxzuVQOY6LqX6/m/vzwL+ZkP
 ZL8FBjx0gwQTV8xbrHMITGRNpQaN3RWVszJsvLn/zcgZCqw+z8Wli4wK4RtrvujQD1JI
 3eNM/DQ1paSYu2IZ7e9vFcEsecq8ZvsTC6dMiuMlGYH/rz+AgLKbd0VuxNB62+7bXHuq
 dVhRj4cvjF5hkbuDZELVKseagDrQzCnU87HtN4ImchXeEJ/Xh619Nb7K3t/4J7etlfcq
 qIng==
X-Gm-Message-State: AOJu0YxatZ7wKbfQPbVFPKSwFGgXCLQbVItKkdlfWpLFewyjntx9SCuV
 TtRWWNL5KeR5WOz/wSz8TRrSPIpK5wKoBoJ0wQhHHPM3FwzumMogaoFB1qb1Sx5+z6wXm1F8jBs
 /k6Y=
X-Google-Smtp-Source: AGHT+IEFJoLx9r/eCciL7fnJqlIfwmhBYXzuCGIzjmxg7zkp9TN5ybLayEp6ekykkMiGT/IGIEb1LA==
X-Received: by 2002:a17:907:3f9e:b0:a7a:b070:92c6 with SMTP id
 a640c23a62f3a-a93c4a880acmr1229236766b.50.1727734751581; 
 Mon, 30 Sep 2024 15:19:11 -0700 (PDT)
Received: from localhost.localdomain (46.170.88.92.rev.sfr.net. [92.88.170.46])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c2775934sm591861166b.35.2024.09.30.15.19.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 15:19:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 1/2] hw/core/machine: Add missing 'units.h' and
 'error-report.h' headers
Date: Tue,  1 Oct 2024 00:18:59 +0200
Message-ID: <20240930221900.59525-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930221900.59525-1-philmd@linaro.org>
References: <20240930221900.59525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Include the missing "qemu/units.h" to fix when refactoring code:

  ../hw/core/machine.c:743:34: error: use of undeclared identifier 'MiB'
  743 |     mc->default_ram_size = 128 * MiB;
      |                                  ^
  ../hw/core/machine.c:750:44: error: use of undeclared identifier 'TiB'
  750 |     mc->smbios_memory_device_size = 2047 * TiB;
      |                                            ^

and "qemu/error-report.h" to fix:

  ../hw/core/machine.c:1029:13: error: call to undeclared function 'error_report' [-Wimplicit-function-declaration]
 1029 |             error_report("NUMA node %" PRIu16 " is missing, use "
      |             ^
  ../hw/core/machine.c:1240:9: error: call to undeclared function 'warn_report' [-Wimplicit-function-declaration]
 1240 |         warn_report("CPU model %s is deprecated -- %s",
      |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..94d3b11a53 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -11,10 +11,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/accel.h"
 #include "sysemu/replay.h"
 #include "hw/boards.h"
 #include "hw/loader.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
 #include "qemu/madvise.h"
-- 
2.45.2


