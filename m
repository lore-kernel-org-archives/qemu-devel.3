Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7033BFF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLTs-00055s-89; Mon, 27 Apr 2026 08:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNj-00083j-1D
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNb-0005eH-DI
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so172744295e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294079; x=1777898879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJj22kEkzFF+3jaYL2BVfcuPeld/6/jCQySmORn7JdA=;
 b=cgsWVxfn1wtljhOzGmWXMMVinyuB/KcB2pleEIDR26pzi9ZZYnEfXpvy6DntUSdQGu
 BXmr8AVQq9VZjw89u9i/lBeWmS1C6tNnCHriAlMX/qdKXs6kLuyb+ih7rmgmkzh3gjOJ
 yB7UqjRtS1UQIFY+RU0tJf9DQeyEe9JjWVJxcV85OIIT3ewGuNlI8XIJke2UAsJj+eMr
 I2qjwlVxDxLO9eG3hLMTByX24n4HdvsyVTZHm80RgtmtZ3YITSfAapYBunHO4SavSpyp
 0AjON269DMdXm42zOn/o9oLvnzNqSoKYgZjWHQ9ptQw7l2gW9qzRCKB39fwBMcfk3OPO
 zPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294079; x=1777898879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yJj22kEkzFF+3jaYL2BVfcuPeld/6/jCQySmORn7JdA=;
 b=M0LZJBROCqlO+0F3BzEph2LxnXAO2Y2Chj+QIyKAwxnMWQSOI+LPPzrQhyvXn5whsN
 kwyF/0kRaWH9H2sVU4D2JRn8ZKmedEJUFqaTSb/02amLrC4tQWK/qQPuBOlJ1uytHBiC
 vykezGvwimg8spVCwjd8yT6Nc333f/CEOP9z5bHraU9rDEdNRMkW2jUQOP0RSDg2HIwH
 Kw4RGW/JnzsMhFTCtG0x+g/O5ilnMRblWWvdBoAiTd3WGMx2NA2rbweULT8ssK3/khNw
 HYE2qNvySSb+IYL5Ac0LxbLbDRyE+bS7QrjvXb/001Aymgah0C/LSufwEMLapdlJkhkF
 VJeg==
X-Gm-Message-State: AOJu0YygWHoS0CS6jKtIFy9ksqkYIm6kpvGIGHVDgBQnM7TpDKtSrTRL
 pPphcpnvkp7RvsiyOo7ydzsIuaRq19c1MGlq3S6jQxmdhpWc3nBLEvzTmbhDjLPT4UoQv4dXmfr
 RMXwP
X-Gm-Gg: AeBDieuldZqMtWzrTqNQDAgjwnTJz0xkQlkYjxnDCnQnk1i+fAnCe41z28eHagoOFCP
 /HTAwYiudpmP7jOG8IEL15hICTxS8ZJSQDdN2+E/+64LT1CX+3ej1QdfImNHdQSax4epGv0zl/M
 c7CL1sHIGdmkK/Ou64soGdZssejgBgbHaIfb6NYzz1oLbf1gICaPqJOXzo/E0Pjqxmbd34jE51c
 4KqiLTl+YtgqSGcwCvYiXg8oMStWdTr8TivRhXTDwOlUDHIHUHTwhph1UupmaEOZ1gCrf3B6UMY
 N7Mkm+zO1ixbpnA+Y3kgZlHYiOBBfLqRxeF11AZjG0AXGIUIWkXml4r/qQOHMfX3DbeJV5nn6cH
 ZZoQxDUGLSC7F9syeZ5XjscYBHDsnVu9/mQg4Eos5nOAqaKie7KOdzfX/GEKy7/YWt1t604nt9B
 ued673FzmvPN6OygtdhaWBBUg9lqcdM7USxcMrwU6fSOfUxV27bTWfISKG6lZwBzBUaMVXmVjQ8
 3eucBDzBfnFTA8LdB/3PNLUDYe7hGZ/rUMoSZ7a2g==
X-Received: by 2002:a05:600c:4746:b0:488:9439:881a with SMTP id
 5b1f17b1804b1-488fb738412mr588822815e9.2.1777294079479; 
 Mon, 27 Apr 2026 05:47:59 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/63] target/arm: Compile mve_helper.c once
Date: Mon, 27 Apr 2026 13:46:57 +0100
Message-ID: <20260427124738.966578-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260414005348.4767-8-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build  | 3 ++-
 target/arm/tcg/mve_helper.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 506f031f1a..95e9da151e 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 arm_ss.add(files(
   'cpu32.c',
   'm_helper.c',
-  'mve_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -71,6 +70,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'gengvec.c',
+  'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -94,6 +94,7 @@ arm_user_ss.add(
   'debug.c',
   'gengvec.c',
   'hflags.c',
+  'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 64ab804abc..09ae233416 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -23,7 +23,7 @@
 #include "helper-mve.h"
 #include "internals.h"
 #include "vec_internal.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "crypto/clmul.h"
-- 
2.43.0


