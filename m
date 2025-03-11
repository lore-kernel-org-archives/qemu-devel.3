Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AABC2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqwv-0004UB-QI; Tue, 11 Mar 2025 00:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvW-0003Ly-OT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:10 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trqvS-0006Rr-QL
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 00:09:10 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so1239094a91.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 21:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741666144; x=1742270944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYUY7egDw13yHwOIShpp+yHE9Lg9eeptR3FMaPhbw5Y=;
 b=dqrKt4t8ywULc1vraOKV/Oswe2/0MW4056PZgs1PAne8kd7+Q4apy7h/4wQaZgpYVJ
 cx74zQAVUTejQL+bz33ZSNB9lljgmmo6hWEfQ+YewLQ9otZOg+/L16dZWXlJOQYrOToj
 Re4AEF64XY/EQbzYdkivo3VZOqtWE5sLsi4o7szCI/gCC2ryFdJnxQdrxFXFxwNWmQzD
 aVFicgEfBoLmk/VkD9RXoeFDnYE20P8Wix1fH2mf/EWoxSJcnzzEBH1g24WaOiYaKEaK
 mRFXhgckp/687nHdSi7TK2QgURgfUMuxmTRsDeFKEm7IzASBDfIwXGu1pilRxdgazEbV
 kYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741666144; x=1742270944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYUY7egDw13yHwOIShpp+yHE9Lg9eeptR3FMaPhbw5Y=;
 b=Msc2/AHc93rIWlHk+F8ziCaAVdZJBRdkB+1XvO+SsEQNkC7Ho65A2XbGhxkWcXb3NR
 +3O70nyvKwmBrnBhNpwk9zYUUmUwFLe3blGi6gBv4KWzYQ/klHIvWs2q9hmLVylhkzvM
 XBUagx2POOzrg9BQ0Cd1I0c9qbwBomjguRr33SpD1ZUPHEVigBinZgjsPWSZr5ZFxR9+
 rheIk2MkfRsv+h7J4ujF++tBSrTlENl8zh68bJxDCbyBPVfa/3UKeNZkCJ93KReW7TnX
 LvQ3nL/FMFJjEkbq6Htm6/KYH+xtA9BAsLpX76/yxskmaYRo/Lk0JObLS41ZvOsrrzT6
 iDow==
X-Gm-Message-State: AOJu0YwdxvpJYA+ncQbL0OigCzb+iIg/JApJ0FPwalFBoAohYmntjVVW
 k4LuUiEbA2GjsZMz69jbyo7EZfhgiiJSkOOBWygOgfzRaDrupuQly4yo03mHmwzwGk4v0s8h3X5
 DKMw=
X-Gm-Gg: ASbGncs5/2a4m/Fe9fY/tc/Mub/YBvgCPuYTp8U8qKvuFxDoWKeqwLrU7r26uaMcxy+
 ++4x5E2/f/Kz/njDzKC+H0on3mkdzeHjTd2W7o45oKvphkvQ7kKL3hWbZ8zLwJRnOl1Dbqlle9h
 Ynff3+TUen7oG3D5zAm/lFAtetxunPWwB+bs9BLN+m0UkTYFdbcOO04UnX1Gdi+DtlAeXcp6OjQ
 aSBeVXKgCK9X0ltwE7lL8FFGhjNyINzPGxfRJReCaNlm+REi6dVZCy/9g33J8Vf4aqNhPhmKjnM
 Q0jU1U7JkuBs9Xt8d7OTrCeRfQZPhdppdXgpdMlnGgrk
X-Google-Smtp-Source: AGHT+IG1r91N/pZj/+/h4MYPAOLJfFbK6eObEmS4IiEzuC9Hkmi66055HrrfvkPljzn8i/+Wegt/7g==
X-Received: by 2002:a05:6a21:4cc7:b0:1f3:36f7:c0d2 with SMTP id
 adf61e73a8af0-1f58cbf3befmr3240926637.41.1741666144062; 
 Mon, 10 Mar 2025 21:09:04 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28c0339cesm7324454a12.46.2025.03.10.21.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 21:09:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/16] codebase: prepare to remove cpu.h from
 exec/exec-all.h
Date: Mon, 10 Mar 2025 21:08:28 -0700
Message-Id: <20250311040838.3937136-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op.h           | 1 +
 target/ppc/helper_regs.h       | 2 ++
 hw/ppc/spapr_nested.c          | 1 +
 hw/sh4/sh7750.c                | 1 +
 page-vary-target.c             | 2 +-
 target/riscv/bitmanip_helper.c | 2 +-
 6 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index a02850583bd..bc46b5570c4 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -9,6 +9,7 @@
 #define TCG_TCG_OP_H
 
 #include "tcg/tcg-op-common.h"
+#include "exec/target_long.h"
 
 #ifndef TARGET_LONG_BITS
 #error must include QEMU headers
diff --git a/target/ppc/helper_regs.h b/target/ppc/helper_regs.h
index 8196c1346dc..b928c2c452d 100644
--- a/target/ppc/helper_regs.h
+++ b/target/ppc/helper_regs.h
@@ -20,6 +20,8 @@
 #ifndef HELPER_REGS_H
 #define HELPER_REGS_H
 
+#include "target/ppc/cpu.h"
+
 void hreg_swap_gpr_tgpr(CPUPPCState *env);
 void hreg_compute_hflags(CPUPPCState *env);
 void hreg_update_pmu_hflags(CPUPPCState *env);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 23958c6383a..18bbb1403c6 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -2,6 +2,7 @@
 #include "qemu/cutils.h"
 #include "exec/exec-all.h"
 #include "exec/cputlb.h"
+#include "exec/target_long.h"
 #include "helper_regs.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 6faf0e3ca8b..41306fb6008 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/sh4/sh.h"
 #include "system/system.h"
+#include "target/sh4/cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "sh7750_regs.h"
diff --git a/page-vary-target.c b/page-vary-target.c
index 3f81144cda8..84ddeb7c26a 100644
--- a/page-vary-target.c
+++ b/page-vary-target.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/page-vary.h"
-#include "exec/exec-all.h"
+#include "exec/target_page.h"
 
 bool set_preferred_target_page_bits(int bits)
 {
diff --git a/target/riscv/bitmanip_helper.c b/target/riscv/bitmanip_helper.c
index b99c4a39a1f..e9c8d7f7780 100644
--- a/target/riscv/bitmanip_helper.c
+++ b/target/riscv/bitmanip_helper.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
-#include "exec/exec-all.h"
+#include "exec/target_long.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg.h"
 
-- 
2.39.5


