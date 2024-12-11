Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A28E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVku-00035A-E9; Wed, 11 Dec 2024 18:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkr-00031V-UN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:29 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkp-00023S-FN
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:29 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so9679795e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958266; x=1734563066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e1gkSU7M75EFdbW95JvRzZevk5diVkYdExWvAc1of60=;
 b=R/eBWH5z2dx6cjzsEN6u3+idu3vFuwzErwO8oX11xXUX49xg7u3+co4bLtb8Lwtojd
 5NHmmaixLvtSXFqWCc2Jgbd40xh+tbLlPsc251PbFJ9YmL8Q2NXnPExaZcudXcqXOu/j
 3HOJ5ZQeVfiblEkwyYcKRDfEEduHeHlE9GFVeQ4VeMTyHH/XoCh8GIx3eDq4QLBAcagv
 zAxyQs58tKFEF1Zf1vJ+6Z6uU9+1pMMeT9e3DP0+KHzEiflCuXTUtTyO4dDnkAnGt8Wi
 jTd6vixOeaHcpuPvX0SG2FSGxAGhAa4Anwj4I9VDP4et61vZCi0Emut8HYBzWO7qlTzY
 0syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958266; x=1734563066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e1gkSU7M75EFdbW95JvRzZevk5diVkYdExWvAc1of60=;
 b=AUk8Kp3o+2R71Cu7UkZoaL0MvrffSlmQi2LUSkpaksoRUwhzWdFDPnDM1lTcoUbvaZ
 JdJ8vLcE6Ej5mxarcscZUiGGFGA7DmdUGANcVRcu3PHuULR1sYVjSo0JcHOVBoH78OLx
 lgTDvnXw0W2gFUrM+HWvfF5LOnnN7vlImzaIg9zEgXyHiXyFyoAkDYVCIeyxjSPLVD+p
 pwHFvUNdt1Ogceq7ZogS2fAHKuUH/waV9VAsvLjstAZ9AQGep53wjOSQVuok0d44VrR0
 Afj35d3naaSJPGyCQovLJJjMYDvcbdn+ww01ajpJpcIlVV4hyxr4K50h6fUEBWkqV6yF
 e+Cw==
X-Gm-Message-State: AOJu0YzfpOGomkAkuLdgtCDh67FQKQFGRuXmvg9ESaMSgSjq9OJZZblT
 7GL83uJtes+fk4QSoJ2A2yNWxDOCofMvXQTR5iU11ayt/DctMz7/v/VGEG8nIq8ybBgnJeffODN
 n
X-Gm-Gg: ASbGnctPFhUcdsXqrpiOgk3tuuP1D5m/UkamQE/J4bs/xB15SuPvrE5aVfz81na+rOF
 PLaTpiu4LcXZoVUexBuMxXeRmnMbljH+2Wx6TYbZQpcQOsppUFC1jF4A4hIpHrQU4ecyZsCyOtT
 NKxZ0EQey7QaGhqSqUYtvzPttDmn7hJT+N1uIqByr0yemd3BA4X/+o8h9kQsHrueJlb0mhZ986v
 RK5UFtGjKZLgk7IS5+0Vot7GHpOAhia49L0OZuCB4lRcTXzJLMqwTJy6/BIJq/3zG06qtPL3pMk
 iQVqQvtRH4bNty1OjZh8V6C9cDHuRAaItA==
X-Google-Smtp-Source: AGHT+IH13sBDrrNq1YNP2KE3qw+IE73kK1J9viuwif4RhVJDSJvBV6NWIotfSC1dDfDCvcGxhZZv6Q==
X-Received: by 2002:a05:600c:46c6:b0:434:f9c4:a850 with SMTP id
 5b1f17b1804b1-43622833224mr13851425e9.10.1733958265695; 
 Wed, 11 Dec 2024 15:04:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f981880csm117938685e9.44.2024.12.11.15.04.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/9] hw/ppc: Include missing 'exec/tswap.h' header
Date: Thu, 12 Dec 2024 00:03:53 +0100
Message-ID: <20241211230357.97036-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Some files indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove
the former from the latter, otherwise we get:

  hw/ppc/virtex_ml507.c:123:19: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    123 |     env->gpr[6] = tswap32(EPAPR_MAGIC);
        |                   ^
  hw/ppc/sam460ex.c:238:23: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    238 |         env->gpr[6] = tswap32(EPAPR_MAGIC);
        |                       ^
  hw/ppc/spapr.c:1617:13: error: call to undeclared function 'tswap64'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
   1617 |             DIRTY_HPTE(HPTE(spapr->htab, i));
        |             ^
  hw/ppc/spapr.c:1406:55: note: expanded from macro 'DIRTY_HPTE'
   1406 | #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |= tswap64(HPTE64_V_HPTE_DIRTY))
        |                                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/sam460ex.c     | 1 +
 hw/ppc/spapr.c        | 1 +
 hw/ppc/virtex_ml507.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 78e2a46e753..3bbab263ae8 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -22,6 +22,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/block-backend.h"
 #include "exec/page-protection.h"
+#include "exec/tswap.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "exec/memory.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d4efaa0c09..02136b3295a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -90,6 +90,7 @@
 #include "hw/ppc/spapr_numa.h"
 
 #include <libfdt.h>
+#include "exec/tswap.h"
 
 /* SLOF memory layout:
  *
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f378e5c4a90..0e9a2469599 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -26,6 +26,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "exec/page-protection.h"
+#include "exec/tswap.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial-mm.h"
-- 
2.45.2


