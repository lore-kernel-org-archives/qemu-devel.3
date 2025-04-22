Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2639CC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JO0-0003Dl-Q9; Tue, 22 Apr 2025 15:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLo-0000sR-0i
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLj-0006f6-Uv
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:32:10 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225df540edcso2861915ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350326; x=1745955126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSAf1+HedmWB7UB003Jb743ifjZ0UvEme3TNs+0ZvNA=;
 b=SOy5jfIydsv5bnXRjxMaCR/GwPFG9lH46AniRisHWJOgbSHGwx4GgZgnPv32Oa0KZo
 kb0Af9aUmE+n2p904Jhj78U/imsNHY+j7+2Wz3SRrjx5ZRbYAqU+VYV1FS2MxDF7QIKT
 tqSyzndpd8xFDJw1Hc865h/YyUgUY37tVL6qmslcqzoWgU3uLkIjmglC9YqXmBgWPCsK
 tUNKB7V8Vsn6O8jLyosbAeKZuXtrSXgnWsUJoKvhD5uFZytQwlQchvXsZ5h9IpbMpEwF
 7sCdppfEKHOgZuWrqBVqh2zCaxfRysldRuONdLohDiYfTsYkhu9aJcxPeE5K01QsgKOq
 gD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350326; x=1745955126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSAf1+HedmWB7UB003Jb743ifjZ0UvEme3TNs+0ZvNA=;
 b=PlB/TaGIxjpQNqPpSxxFqVxwVxcQ+QLxy00PaGPBCahhTsQ4XGVMXtZwrZMDpeM29A
 BkKdZ5J93gWxlknfiAvGoa7/iJFKlwuYrIVjuHdwTvvTCA2ZnyuT4PGwEMT8RswxNYoE
 hjOhVkEde0PzJo5D7t32Qnzr3O0FMJDipibza1l2eA7uwbsM9cudx2vC5Y5XpJE7RtaD
 iw55lR56QzV+iStsEeWfDtubYW65auLkC80EwgZCnQWetj2Q1bxA/ZJqmfRwS2tZj/t6
 M6FHI1lwwDsch/pBv+VU0WbV2OPVUelaEds2JAXUAoJ3sBL1KSOxVLa0SOZgOEqGm4Tk
 yCCw==
X-Gm-Message-State: AOJu0YwzFKjkNiO1wiE1Ygo3YcQ6OP5W5Ipk1yu3nF/kRmCg5G/nssX1
 MSGgctG3wH0HMCGV8VqCFVQM9vBAZ3iv1JsZJzppIKw3wA5m3Qum0HrjJfH3kjhTm5m/uLMZNqb
 w
X-Gm-Gg: ASbGnct/op5KcH3kjS/qwv1UGeTC9U8S+aWIsZOdbU7FoLsRGhEa1tEM4kWqWp3rdQh
 s2n9vYO7oubTVXY3rVoiRq7zBdH3Rk2m2pEr13Qn5h6iLzQDqmZNKxZ/O+Hae9A+9OP3taM3Xuj
 WbaHN4whaPyBrmS7N4dDq+rNjbMMQ650KbSEk2rpObvxeJ3NvSgr3j+Dv3OEaItTNrBZw0hWmSv
 8TTz9t3ioR9SoB/dz/or0bMgrhqe0ZP8rt7JEvtidUZYr0uV5GwCTx2St8EeaHpLzCo2+FeSwW+
 7QIB0/2djmU+voL2t2fCaKbgCM+VHY5gA5gpG+JKcLKi91A0rdPbmvFK+uqR/fzobadiuCw/X4s
 =
X-Google-Smtp-Source: AGHT+IH2Z2pF4fOoUkVEctNzQnT8DhdXcokGsj4N5z6LOy0X3ZhTNUmQ++7Ke0NI/AySXFHznrRb+g==
X-Received: by 2002:a17:903:904:b0:216:271d:e06c with SMTP id
 d9443c01a7336-22da3183acdmr2420475ad.4.1745350326552; 
 Tue, 22 Apr 2025 12:32:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:32:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 070/147] accel/tcg: Remove cpu-all.h,
 exec-all.h from tb-internal.h
Date: Tue, 22 Apr 2025 12:26:59 -0700
Message-ID: <20250422192819.302784-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Not used by tb-internal.h, but add an include for
target_page.h in tb-maint.c.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-internal.h | 2 --
 accel/tcg/tb-maint.c    | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index f7c2073e29..f9a06bcbab 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -9,8 +9,6 @@
 #ifndef ACCEL_TCG_TB_INTERNAL_TARGET_H
 #define ACCEL_TCG_TB_INTERNAL_TARGET_H
 
-#include "exec/cpu-all.h"
-#include "exec/exec-all.h"
 #include "exec/translation-block.h"
 
 /*
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d5899ad047..df3438e190 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -26,6 +26,7 @@
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "exec/tb-flush.h"
+#include "exec/target_page.h"
 #include "tb-internal.h"
 #include "system/tcg.h"
 #include "tcg/tcg.h"
-- 
2.43.0


