Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47008C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQv-00010H-2q; Tue, 22 Apr 2025 15:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP7-0005Y1-Uq
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP3-00075z-1I
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:37 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2279915e06eso58647115ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350531; x=1745955331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQfBujJU7UIXTPefdL2D/GAfXKoyN3ifbh/HgiWO374=;
 b=vnX7xBXomAvBD32dYBG7hjFtKejVZqt+OFOSQyjwXzYmvyY9PGEmhgGvF00DTRxPdX
 EPCGn1rC7jJqDZN7kCcyhoHsbgm4zWaEXT5BdbIqKWVSkNt2FrC0jdqJfZtuOt+FPJZQ
 VcE/nxH/RjPmtfyDPzXfF5U1D5YQvHxajtzlOBVB9S1pWqza978Wx4mkpQydyQSidDbD
 It26B+Pgfu8JDYpIW+Z5/zXCqrWAc9Pj5Ph1SvCh/H5yZy8FZAYpUbjVu1I6rbblYeSJ
 WDJBUb/xZLzpgrE32FWpSACdrazGfKSKI/Ougbv5IxwpPq0GJcgrWY4K+8u5SiJJwg4F
 SiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350531; x=1745955331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQfBujJU7UIXTPefdL2D/GAfXKoyN3ifbh/HgiWO374=;
 b=neGuJkNcMiuqAxHpU17xoBxCOMTRvTDFJ33VHQdILBuxFpJnMNGLVIZgLDXK9V3KOQ
 9upyaFNPmbkJqOAjoO6sp9jTlL5VrLpROQAX5t6Gurd1SQKF+7+BeYiXA/2m96Duys+7
 94x5ehRGpl8AeRPZgbDaspwmLW40TV9aWNlR4ACK3MAjKSgqq8rr2DmNc1UWV330rhhq
 k+zQI0yLEAvXwuL0K1MGT2bfx9SxGBCwsy7mr/+SNfr9+e6a22CYFTAdy23urhwH2E1+
 SR97L8dttpenoHywOrcm8zRiu+betmn8pF8weofs+EgavKRjCeM1QDeFKtezx67S/DQ0
 NWTw==
X-Gm-Message-State: AOJu0Yyccb7frJu/9b4Dve1bb5MupxnRGynYSnthPhYgOF0wQ7FeDmhv
 ppoj9e81KUjtiLQlrNhLtwKMhC0Fzg2lmd3FlZ6xHfu8M7awsiYUaHDVbYxRrXsL1azn1c6/AR3
 W
X-Gm-Gg: ASbGnctDJEg56EIewDdp2J1AZg35hIO09uZsd70h0OY3m+fVJ46oho/gMLypkNIup6C
 ke923WidU49yW9v1aUD+ZS+EH6vuYDQCnnXGb/nyCAFVZockmsL5qtHdo9KDGm9Ga65WNHBfUL0
 sCNDRbtSY+Mbl6qvMYu662Qw2LqfUwKgmQFPa2d9oqbKjjhN3Q/hC00qThli7HrubSYi+LUTnVk
 iLIl1uDoTCnpqcgp/JfSEAid8sE8q/zISGMY8SleuQfns5v27+DAy/ShgUguSAGkx/QtGAlaFYM
 6NuI7bXD1x5+ic49dwWrsyo9gwZBZkdx8Se+5HFYJWqCQHBmfTbJADOTaCzzNUyAX8tzUBGsa2m
 21ZM+Uged8g==
X-Google-Smtp-Source: AGHT+IH9nPSwdBzxMxOKD90+lF63nPKnSla0U9Ubs+SfmndVEhoYzwcIsJt0cUUXjGYMF1D4jjK+bQ==
X-Received: by 2002:a17:902:d4cc:b0:224:1074:6393 with SMTP id
 d9443c01a7336-22c5362753dmr245579615ad.43.1745350531535; 
 Tue, 22 Apr 2025 12:35:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 108/147] accel/tcg: fix missing includes for
 TARGET_HAS_PRECISE_SMC
Date: Tue, 22 Apr 2025 12:27:37 -0700
Message-ID: <20250422192819.302784-109-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

We prepare to remove cpu.h from cpu-all.h, which will transitively
remove it from accel/tcg/tb-internal.h, and thus from most of tcg
compilation units.

Note: this was caught by a test regression for s390x-softmmu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-13-pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 1 +
 accel/tcg/tb-maint.c  | 1 +
 accel/tcg/user-exec.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 8ec02b40e8..f267da6083 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -38,6 +38,7 @@
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
+#pragma GCC poison TARGET_HAS_PRECISE_SMC
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index df3438e190..d479f53ae0 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/interval-tree.h"
 #include "qemu/qtree.h"
+#include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/log.h"
 #include "exec/exec-all.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 72a9809c2d..7f57d8f1af 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
+#include "cpu.h"
 #include "exec/vaddr.h"
 #include "exec/exec-all.h"
 #include "exec/tlb-flags.h"
-- 
2.43.0


