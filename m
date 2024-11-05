Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E9FD3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLL-00057r-Aj; Tue, 05 Nov 2024 17:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLG-00055K-Oj
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLD-0004Ai-La
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:05 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so48965375e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846882; x=1731451682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xv7UbEhHdD/9fzj/drKVgHohG9+tJJcGKEeYob1sMW0=;
 b=C+hVrUh0F17sO3lbOnMkFMSe3kc1tuklb/InMNzNJpy1p+hOYtry1d791WDqqvgg3t
 a6d88mePcJHb9fxKvBcEk9YT0yn3fCFMypwSU5SZiu5A5shaUz2Ge9UaoYyM7R2tAthM
 sejerFNYrAMzZNAoXANiMJBR3kKrNIc6DDrzXkZYntmOwZmBipwm9jZELBYozHO0VfCu
 FBqXqmEqzhnlI+UpX6SY1keVsssczJ5jj0Ye7VJsz2jHUAo5qpauABClok56TbyHeT21
 yCpeJNudxQ3Gh6u1Dn+fi7GAzaGZA/YlgdR0RvgLxuUA9gSBvv8nHavT4CUtH5XIMpb1
 xBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846882; x=1731451682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xv7UbEhHdD/9fzj/drKVgHohG9+tJJcGKEeYob1sMW0=;
 b=Nob3+D0wBbZkZbt6GvHPz5/cpuAN3B7Xp45Ve+6IbOp9xUqygd/Td1bZ/KHNDOvia7
 pLs/nAASgAsDB6RPxzWBeZ6Hzuyb5w7qwt1WZKx9XjOEmp88SAPovRA8Gq6J+rM9Snle
 p/OiIWU9jIMsVKTwalCBy+XuyB5xAokOoPVXslo4wllupuSKYbGEgRT1/bD8ZI7F74cO
 Amb3kRpajEVROwX0IwmqVy1UhZ+mMJwpE0c23VA7BZGpMi3wvyk20gRw854QPP2zj5x5
 PkqbhZNG4wYXX0YkTHJ0ben13cESV4ZQWF92DkQaen7dcfx/m7tHrTse5pmZ9zN9H/yL
 s1PA==
X-Gm-Message-State: AOJu0Yz92QK3sX0ZvzvCq9XM5EW+2Rny+Gxc5Bkfy4wAqD1iyuccUW/E
 6GKMnhDKQKrVv32Tj4ksZm49yMS4AKd6G9jZPll45Eg2ob3vT8J1rq8cFWEoAE79qv42kY9Xt9+
 PqBxLdg==
X-Google-Smtp-Source: AGHT+IEQUMYkS473Oiq0qACceP3Aov8iMV/Et9VbqEr/ZGAadVQwdAgNaLGM06UTNSsVa926jEX2yA==
X-Received: by 2002:a05:600c:3593:b0:430:54a4:5ad7 with SMTP id
 5b1f17b1804b1-4319ac76449mr347199945e9.1.1730846881889; 
 Tue, 05 Nov 2024 14:48:01 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa752d2fsm903505e9.44.2024.11.05.14.48.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/29] hw/core/machine: Add missing 'units.h' and
 'error-report.h' headers
Date: Tue,  5 Nov 2024 22:47:04 +0000
Message-ID: <20241105224727.53059-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20240930221900.59525-2-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 901c64b042d..fd3716b7dfd 100644
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


