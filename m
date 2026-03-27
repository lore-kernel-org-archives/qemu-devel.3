Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DDA10F284F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AOx-0006I1-61; Fri, 27 Mar 2026 12:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOk-0006Bi-Pz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:02 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6AOf-0005HO-U5
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:50:59 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso944285a12.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630256; x=1775235056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXy9rBoaCMMTOp0VTinfarPcqqyC5TJjKb/l+a6N0ps=;
 b=NXeF+ks4DGhXqCyr8VEh7BQFID6rFr9pq2OYmzCXDDXD0YcYJhhoQyXy+v/yMoEvEz
 01qUwFZ5XcyUwp8Qy7O+S7+v05fwYAABo+YzsRmFczQvdyj2KDH616B/akV2VkxmloIF
 8PrS/XBWw0kTQAwfxYGBkhdrRdZ059OvmnAzUYKQzOJwCEbdr9Zjf0GXTlbGU5Ttfgog
 WIyYyBumDdHtzv5ueKgytnMTcVyjlm1diA8XBuYB9p7c5+MOcLUaJeMEz591A/tzcCz/
 4zqgxuYIty/2pPbvJ0XH0xlEwoeEZfrZ81HHZ/JIVR8nUsHXHqc2ONdZ3CnCZ0fJQC63
 ZKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630256; x=1775235056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zXy9rBoaCMMTOp0VTinfarPcqqyC5TJjKb/l+a6N0ps=;
 b=BE4XmUVcLojiksdRY2owvttHVj6jDs5iEFUkvEqnw1U1hQep4uVayU/4UcQ7TsekHS
 j32MzI6JJNcYQDRcMu/Fl+hL5JPy7WFrbkCJXvwr6OlaD874oVvkjen/0GRP6BuSjj3D
 Vy51It6CdiAvT9MwbeQlNo229vZy2kZU+L1ELc0OiHoj1aSzYVPn7shXnwd5q9tRLLIz
 KzpNk7a1igwi54CQPqv38u5+D4gTXLyEMB2/4XZfOUmupO5p6d6+a6b+VFGCe2SjvUv0
 XeiLJAgQW5LgxrOizwzIdY3mIPCFaI/U7aS5Pv1GkC654vnMRgpgXAXOd0AWpf1BtY6C
 9IzQ==
X-Gm-Message-State: AOJu0YxBHd4Nu7Oq75PZ7bjqvgBDmS2bsA12ps39kWAxlKMjVBRx0Llt
 S0lMHsHUdJmlM4x14+L6KJjxVGCza/+bOuOE2Jb1ZutXH4oGntdkYdJqwRVOPJOeysa9TUgmeZS
 vQV1nrPI=
X-Gm-Gg: ATEYQzxmqkOwr3psOKEzt55QQqOL5Sga5W6U5u7rs5WPKnPQ0kt4GgrnfYZ5LTfNxp1
 KKlWDECg+AtQm08IhGfXsgxeWhN583b8QBQM1Yf6e+iVRG4iYRIKFHKrwzWH03eLtDxHn4aKsgc
 Oyt3t4GHIdldsYLcVRa2u7kJ47iwUR9UgkL7VISSwOAtlb2r7tRN3QS4uU5bwr/x1OZFQgRwR7r
 CA9mY1pfc2mysAsqtw66ksqrLLIv8Kgi8nHCNR/ue8Cjv4Ceufhdoh0ib+WtKlDDoG+HzE53UVq
 JchCSRzIs28EmlIwdT5OLJrT15fMrTMjDbFP1ucRjCVmOzmrorHYjF0OFrHIwvkiSbdChnEwBNC
 wfzs4EV4r05z82QzoUZzwBezVIYHRM8S+3eOZkRxl6BjnTvC/qLGhbIj7lxt121a1WE7OB9ZTHi
 rYKRFHtdflP/4r0oHE6etaU/f2CA/rjqKs6b9GjK4u7FMF1Y6b3lYeU8ZkWDQFcsgD43pSW8g7d
 7c5
X-Received: by 2002:a05:6a20:2590:b0:398:aaac:a079 with SMTP id
 adf61e73a8af0-39c87ab4125mr3880991637.45.1774630256486; 
 Fri, 27 Mar 2026 09:50:56 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c767399e0casm5514038a12.31.2026.03.27.09.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:50:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 09/12] target/arm/tcg/op_helper.c: make compilation unit
 common
Date: Fri, 27 Mar 2026 09:50:39 -0700
Message-ID: <20260327165042.604105-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

Remove unused header accel/tcg/cpu-ldst.h that has target specifics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/op_helper.c | 1 -
 target/arm/tcg/meson.build | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index aa14f15eb62..75ad53ec6c6 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -23,7 +23,6 @@
 #include "helper.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/probe.h"
 #include "cpregs.h"
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index eb87eb63c1b..a2b944e81c4 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -29,7 +29,6 @@ arm_ss.add(files(
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
-  'op_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -69,6 +68,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'psci.c',
   'tlb_helper.c',
   'tlb-insns.c',
@@ -83,6 +83,7 @@ arm_user_ss.add(files(
   'debug.c',
   'hflags.c',
   'neon_helper.c',
+  'op_helper.c',
   'tlb_helper.c',
   'translate-m-nocp.c',
   'translate-mve.c',
-- 
2.47.3


