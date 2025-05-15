Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DC0C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpL-0000s2-09; Thu, 15 May 2025 06:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnr-0005hU-B3
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnk-0008Id-2f
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so6077265e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304814; x=1747909614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=phLDyRC8qvkN+cc3d8vZoLY4/awZtK5egXloQpIKBz8=;
 b=sUmv7rV7iLhX0uQD4hpo8A6U9m4LgIFLqGCuV0tpod9mqNV30p4KAJCWHbA+cHwBed
 +Qkjt/wMkauDj+rQDQN0UD7MqR3ImE8exyG4BmmkVpsfQZ/2Gk3wXX2fUzGv7N7ewfGu
 1hDlAGkH3rvYWyvOjvpozeq0AuagxwW+V6vuaU4TwrNB27eEy2+x4Ipx9LPuJHcVLVjH
 K6bNehZA+a/9URR2ElsZWnCVLpVLVfZGZ7Zy0jgKZq8vWnUqec1SJvcWydIaDoU3hW3/
 kseznz2hXoRZ87WtOfTrU+Fx6GfNZtEpYko161jfZTaPrJ0veAL6Qv6GuiMbnBIi3mDS
 WeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304814; x=1747909614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phLDyRC8qvkN+cc3d8vZoLY4/awZtK5egXloQpIKBz8=;
 b=wRZ6lPMqzBhlsdXqp8xKRFO20SBqZRt0GnTWwQujXoemY6YkSuWv0GS0K0yDwHdfGx
 74672dm7cege+0PLUu35vtyEcVD5zhzUTeulci5hPBpj3qLuNXWRHFe0OSGAgDjBnGM6
 MPkTcDaH0kXrfqrsCpJTMnX17s025DFZh7ooq9NSBnLR6408hv1Lpqjii8kCfjB5PJbZ
 ImTiydxwuLFQTPT9lFau6OIpfmtlewhKOm/was4TVFTqCEcZ7pfJGzGWNQIXk9QADi0y
 1ozV99XoOudfrQWxDUaurRNVCANZkUoSAJceDMd858Z+72Fvv1JPA7BNIP9pECjMXVqK
 Wdig==
X-Gm-Message-State: AOJu0Yx2JZo923FsKF0cdoKOwLKs2giWBdw9Toob5sReU9Ie/tjR8ZCq
 Iebzjs8PNbKhS92dkduBuT/cARGuyQzJ3cKAbyorss7i5FwDlHEPGB2gMK0gedeyN+KtFrw/iHk
 q6oU=
X-Gm-Gg: ASbGncv/HehnrX4HBuZ/WaEPdqHIOqEUEtRBpHP/LiDRZU4/PjTFIfvQjJczszxXboE
 beH2nv5BX7m5L5xbJZRV/DD/RZLMw46K7554kDcCC/Eklzko5/oNpiARn33Ohh2n4h9YiuQOOor
 jRgdhEyOOmk1TfmupRqRyxb3Wh455nxZWFSxz3RCIiCWOyaSdAGKuJgZFAkaAL1Jue4y2ei8Z6I
 BCLKqusDz9tk5aLZphjhtefRkM/Th7oEU7du29Y41itZnap1cpBhkmDwCqpxmD3N5CvZbyj18R7
 nFi+AVvHtG59glVv9qTRhiVZ+EdsJ/jlItyYgEsTn0cV1y5ktOqdcNihgQ==
X-Google-Smtp-Source: AGHT+IEklAXsrvUKAr6m76O4VNqAqJkXKGxDoxakPfbg5zMAd7XoxJD92Q/I8Cstae0NUB/poNo87g==
X-Received: by 2002:a05:600c:8711:b0:43d:53c:1ad6 with SMTP id
 5b1f17b1804b1-442f9705f7dmr17113385e9.26.1747304813816; 
 Thu, 15 May 2025 03:26:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/58] target/arm/tcg/tlb_helper: compile file twice (system,
 user)
Date: Thu, 15 May 2025 11:25:42 +0100
Message-ID: <20250515102546.2149601-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-45-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 3 ++-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index d9e6c827d43..23c72a99f5c 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -9,8 +9,9 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
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
2.43.0


