Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8983C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UTq-0001qO-Hv; Thu, 03 Apr 2025 20:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTm-0001bq-LA
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:14 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UTk-0002w1-AO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:00:14 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso10269945e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724810; x=1744329610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MU0NXB5YOpxPzbW3TbTpdtY5zarUPJhlnGyCYPlRhd4=;
 b=CJGx2E4UAN7RsRXGOsCfYwYyg5jOxFZ7oOoZSo4HTeCyhGuGOTTZpfSAYBA9CMbWAh
 /gub1S6YXzHxo0QNbf2c4crtYdBXYQ4TYM+h9y3/Zn6W+bd7tnWLiQcm2+snZY08GFsO
 M4JAg7iSKUJIxEJoQvBzxvWQQ9TpNhcKXqbaRYWsCh72G6BLy1e9A9fpKQMT0oOUboEP
 +3tqAXdyST8271bVB+rwDGx5BCILchxgYkjCYjPrzs/wSUaq98menauEdZr8xMB4xbpK
 MvxtUDXwW581MdIopYK20leQy4pdvhCTZ2Sx5toyFRZ4PWdMVDuljTm33jOtxNR1QTLO
 VAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724810; x=1744329610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MU0NXB5YOpxPzbW3TbTpdtY5zarUPJhlnGyCYPlRhd4=;
 b=Y1Y0cDs6wuobn7FNN80qzO5YvDaBlDUtff658b+mWycMtdSf2641upw6XqK8ubAH9M
 KZiRTHlUjr3tclfEoFDV3NAVU66wAvjiyiKz0bsWuu2mmqdNkszARSv657A3LT90FXpq
 wT8R3T72X29XdbLj2H5TB6pqKoXcY7V5afL3JXenMYO6KbhmedHqHFHjTw6eVBI4JJQC
 E4AoCaKPxVC5QN+WDVzrH3HBZ6x25G/9uXwZrYBrVmbUpNXbMITW2rQy4RBFfhIzCm+r
 rWrMiaPbpUPHiHjzY2bPHO2z3Fi4Cmavy+70vsHXEjMVktw2dX1kSXHDLjVNHsiQyUtn
 e9Yw==
X-Gm-Message-State: AOJu0YwGS34ObmuPvPnXIKxS0N2XbOFz4D7IHRu1wfsuAeo1qzvxJoUr
 +R+ge7JYvW7wUJY1p48fS+H6Ik6JQZi6sZYVczMgJUQmmVzFyJADWM0u/iQC1jev4YIXziBqLVR
 T
X-Gm-Gg: ASbGncvH5J8bki3Srpe1tFhq8E8pHv9DsEOwu5ryg0p7wlcU65IWKgF/Gt3d5lFkVcs
 O45cw6AsNmuQOg6f4q0AF6GViYMxoS9X8jfhVMm7rYMZnbQzAQALl6jqLyWWd+4rM0MN+nUkdQs
 sGk+cpnB8nBaWOBsNOeiEia7oW4gqNVSi771mEcqZ2YxnD0TpURy5XQtiErxDQ7MlgkKe3LsQ28
 2YheBNM5uFlQX+EYl2kDNSWhlmFMIwUAKIibFiGSMK4EcJ8+X8qQUBB7HIjm3okyCCi7XxOGJXv
 yBmn4/wdCJChzMC+sago+tudFmInuhm8eWHboNGtCncBCdYZjAR5pAOnuZcPNdVfhMorfhxmitf
 5OGUD4VNVSoS4WJOXc3A=
X-Google-Smtp-Source: AGHT+IG1ckqzvb0I3f8A/UyhFfPwY5rbtDc9FJKBy6WLCBC501gf4/vUNQ54uqShBypVpNnlRxYYKA==
X-Received: by 2002:a05:600c:4443:b0:43c:fabf:9146 with SMTP id
 5b1f17b1804b1-43ecf8d04e2mr7608485e9.17.1743724810106; 
 Thu, 03 Apr 2025 17:00:10 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34ae0c5sm30942505e9.15.2025.04.03.17.00.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:00:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 16/39] hw/arm: Remove unnecessary 'cpu.h' header
Date: Fri,  4 Apr 2025 01:57:58 +0200
Message-ID: <20250403235821.9909-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/exynos4210.c | 1 -
 hw/arm/highbank.c   | 1 -
 hw/arm/mps3r.c      | 1 -
 hw/arm/smmuv3.c     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index b452470598b..04439364370 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
-#include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
 #include "system/blockdev.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index ea3621e4f87..0caa08631ad 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -35,7 +35,6 @@
 #include "hw/cpu/a15mpcore.h"
 #include "qemu/log.h"
 #include "qom/object.h"
-#include "cpu.h"
 #include "target/arm/cpu-qom.h"
 
 #define SMP_BOOT_ADDR           0x100
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index e9abbf00b43..604f6845fde 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qobject/qlist.h"
 #include "system/address-spaces.h"
-#include "cpu.h"
 #include "system/system.h"
 #include "hw/boards.h"
 #include "hw/or-irq.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4362ae6aa1c..df3f5a707a9 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -24,7 +24,6 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
-#include "cpu.h"
 #include "exec/target_page.h"
 #include "trace.h"
 #include "qemu/log.h"
-- 
2.47.1


