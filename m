Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF61C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5CM-0002IQ-Eg; Mon, 05 May 2025 19:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AX-0006ys-9X
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:21 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AV-0003xq-1Y
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:16 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2241053582dso75202955ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487453; x=1747092253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tCOIjYNw0nrrfgNh5tW9ScxZaAXWwfrCxDZEIXL0aSo=;
 b=Y0wjXLdKikD2jZ7Ym90hGyehFW8vnnkC0sY2D5wmBWRoSc8BDMfDIpwukXwrCFhGjl
 IJPdtINmgO0IdZ/l8ckFYeeQNvdSn0/xeYmjB70oEeMSW8ta+tR1jCP4M4Qf+yYBCXyK
 63OWLhQfOkUa1E3piBgec3/rQHv7hGfxVVJq64JjiUY0FLhTcVOO08IOhHv9nfQJKSG/
 dA29mneyMsg4eIhA3Ax3dJVoRuF0bw4Lh7xk7NECcPDxXZyUXIUQlQAMGWgwXXYhNp1x
 qrZbW9L/uVPMb57A4zmTLPBP9sf8vBkpVn/cxX1ItHRYibxVos/TSG1vhOrD+OKBY0t6
 lcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487453; x=1747092253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tCOIjYNw0nrrfgNh5tW9ScxZaAXWwfrCxDZEIXL0aSo=;
 b=T1VijGp2dYWzZix9T2y0VPS5GrDaPExQ9hMc3JmNfrpWEBsKle2Ifr7kVifJNyZF+9
 aMgdSRUwAltoqqry24CcoYpjEjaMmu9Rmwq/U164PoBaL/pIUsgo0bsnh9dL04S+4MPU
 ZytZ+q0mxH/YH8RTthbnn8wbI2djp6Yeqv8Ip0S4S/01mRY8HLs3iM3zsTWdrPTAP8Gf
 0mYHoKhH9h+IP+2Zh82lLeP9fBG1XvQOUGf3NzkWjBK6Z84Se4wuxIRIPzfmGJ3lyA18
 m6jOqk17ob46pMsNcxCOGilIWike36gfJFm0QMc7dh/UMBgPsrQSt5rOW+VD7Ip1CwM6
 9I9g==
X-Gm-Message-State: AOJu0YwOPQ4+NNhmc/zUfQ78m2t3Rcxwc3J8y7lapCpjUa5tdgSeVllr
 mRSngBxrQmzQa1djtG1nWeTb88fKyD+OYyGbyIEJr+TsngGv1P3p9nTNcC8UWspXU0rETt3SKJU
 zNO4=
X-Gm-Gg: ASbGncsaDDvIA+9hGMFtiw+oO6A8/zQsMctD3b6xX+cieCZdCVgV/heOwwgKvaitt+M
 XxnseGfV9H/d/1RSJuSAzKTkatgffLneP0XxU/YT3V17i5u3JeRnJiA1feXLXC5sVJsfp9U2qYe
 rmeuM83IGlOtf3rt9cVSZaHAc3x2eigdKqMvXH05zrOQw2MxSfWYujb6QO9S+6Ycrh0cVMxFOFB
 WQTUU7RekguecR+9kWuskHl+JpxGzUE1irShe/6awtUWuIPqLkvR1jFvXDdBXRJ6k9rh1YWI7MG
 DAoRZAYT1zp5gV94CJO425j9C5NlTKNq+2gJIFG3VT+HNl/vDjM=
X-Google-Smtp-Source: AGHT+IFjxaZn4mAfiKBNjulls3ChlwCP6Nku+tbKpjjt1EV7oV6tV5Sau1TaU3st3hFyaMq+a/8qAA==
X-Received: by 2002:a17:903:32c9:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-22e33012cf3mr16530595ad.43.1746487453415; 
 Mon, 05 May 2025 16:24:13 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 46/50] target/arm/tcg/tlb_helper: compile file twice
 (system, user)
Date: Mon,  5 May 2025 16:20:11 -0700
Message-ID: <20250505232015.130990-47-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 3 ++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 4e3e96a2af0..feaa6025fc6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -10,8 +10,9 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "exec/exec-all.h"
-#include "exec/helper-proto.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
 
 /*
  * Returns true if the stage 1 translation regime is using LPAE format page
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index af786196d2f..49c8f4390a1 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(files(
   'm_helper.c',
   'mve_helper.c',
   'op_helper.c',
-  'tlb_helper.c',
   'vec_helper.c',
   'tlb-insns.c',
   'arith_helper.c',
@@ -68,9 +67,11 @@ arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
   'neon_helper.c',
+  'tlb_helper.c',
 ))
-- 
2.47.2


