Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9CCC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4Q-0002QS-Su; Sun, 04 May 2025 21:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4I-0001ih-Qj
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:30 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4H-000367-6Z
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:30 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so2636948a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410187; x=1747014987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qD9vVqLBGjput0IZ+F6o4hs3gsnwUP4nuOaAH5o+vHU=;
 b=ao0qQc1G8PNN3hwGDOMobqxB3K6g0JM3Ew6/jg+p1J9BgyN3cR2wrFlyyNYwghwBYE
 6AvP1xGvTwnkAII7kJGMecK150Mh63V/xdyNhkZ3hd5vmHSc3TKNvsS0dun8cqAFR7N7
 pfG/FWUVHbG/4cIhhe64UrnxZwweVcXG88iNR4f5Fm8oHMoU7Cbz/bsyFsncLbXa59DG
 MSUYD6L2/bz/hQPmF6Wjw/QTvogR1UAMX1iQGVl3HzPAyacCKNkSX1/1qe3xVYK+H7eN
 9JdUfcQH91gD2HmpRg4ESEYLhE2mS0wD12wm2ypZEr1cSxz2le7xiEFcdxokY2YfLSJC
 p8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410187; x=1747014987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qD9vVqLBGjput0IZ+F6o4hs3gsnwUP4nuOaAH5o+vHU=;
 b=lF3jdrpUDr664oKeJeH7qLpoY/jxna9unQ3dInI4zTc74WuVp/78CI1w/kNj80+B24
 GKC8OFf+lBkGn9BuJ4XZ27ugnhtszCuRd9oEdq3Rj4j6SYqfktwYD58fXr/kgo8hNKdi
 iua79tgQPSW9VijfY+4LYqE2mqrFP1j1PDciT9AEgJcw/OJPKjegfkzgo/HmXVXTXA+x
 t2cmeb1pZz7LRaLvthPkZT6y5olqZXctxTsmYeciFAbDJb3gF56jlTjO0sp+Mh/GljIS
 QMdKp8ustf5DnyN89+bRA00C70g96YEl6aqsSze4y+3BWpumukBpqFrxj6OW3e6rB2Op
 a5AA==
X-Gm-Message-State: AOJu0Yx0PnSNnpg9de6ekzU17IxETeCUJbSGVE0va/xxpMB/WUj4yFUq
 rjVUJV7uwTSFGkViwCAl+c1gc0VuTqOKN5W1JXsWIO6JO6PP8u4uyrZLEVPioYh91Pe2JSvF6cL
 heBs=
X-Gm-Gg: ASbGncvV2r70Mty6R5pP0qAAbS1SzvJ3Gg8WQpfnaZJwlsh9D+I7O2Axvbi6su1hBpU
 iIpl8JwIMPxTY8R7uEH3snVyCrR32/3AbTuDqKeQVMwixJn0y3fVUiVIn95oz+rwoRRzjutHZkE
 kNe8FJalI/frW+o+qbr/01JrFAWxEYuvDizQiexYsmvACQlK5gKVsmqTSO+n35Oo9i3h3b74FLu
 vP5pBp89rtrMQ2pUqNll7ps6HqIvoAHmSZaPBrcciRCwP9CIKN81XNplZ6i6fdA7zDv8cU8g3Ja
 RCfMsDAWfxj5QYRC8oTT678MJgRHg9cZARWNb5Cf
X-Google-Smtp-Source: AGHT+IHd/AYNlC9/+eGUzUQbXsHjdxY4eWx9rL/q1NHWCF/Mmj/1cPsEHPNZmlSNg6CCopLTE0vdnQ==
X-Received: by 2002:a17:90b:5830:b0:2f9:bcd8:da33 with SMTP id
 98e67ed59e1d1-30a5ae599fcmr10633990a91.21.1746410187712; 
 Sun, 04 May 2025 18:56:27 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 44/48] target/arm/tcg/neon_helper: compile file twice
 (system, user)
Date: Sun,  4 May 2025 18:52:19 -0700
Message-ID: <20250505015223.3895275-45-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/neon_helper.c | 4 +++-
 target/arm/tcg/meson.build   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index e2cc7cf4ee6..2cc8241f1e4 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,11 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 3482921ccf0..ec087076b8c 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(files(
   'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
-  'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
   'vec_helper.c',
@@ -65,9 +64,11 @@ arm_common_system_ss.add(files(
   'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
 arm_user_ss.add(files(
   'crypto_helper.c',
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
-- 
2.47.2


