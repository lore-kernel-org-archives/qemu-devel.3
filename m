Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4208FC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvh-0002FW-JM; Wed, 23 Apr 2025 20:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktf-0005zS-NL
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktb-00058A-T4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:58 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so346750b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456213; x=1746061013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gsVC4o8Cb7EzlC8YjKgR6GZM8zAAxzQ3ALZayRZdrA=;
 b=DWGUIM6MIoRH+nMGa9iwqGUu9AKSk5SQt9/X7bCpauuq5b5Ze6fDj2yOEPx8Cc74R0
 6GNIQeKtVSDQE1/AOBVO0Yq7IBldYByg4YPJ+y3qnvmsi9Qfakm2t5qsKo9OB0KNvmW6
 IdqDlNk/o/Kw03xt60I9bsX+2x2Wk36AdGJup7+ci1CQJiLvEduvxN2XdI+3b7KLfjHD
 mOhpNbSWEPQKdIfU1+QRbjYW0bbx4r0ORLyKma8VDpAjc6hRJPh4k33jQQRU7SPEzFd7
 42iweieyLoKv+tCPAD32lxqwMjQ1Gyi9KOKEUb8LrM1zEbT6Ky+F+wPQHuTqkETzBfVZ
 R9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456213; x=1746061013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+gsVC4o8Cb7EzlC8YjKgR6GZM8zAAxzQ3ALZayRZdrA=;
 b=Eh906UzTHcg9WzcA7Vm6DU9dfKxGI1Lt6AXvWgMZ4KgZithnTAFiyeZZ7HRpg/+P3H
 RMkKrJag/Tc3qNQh1OUBpuXF2L4Um4PAG1v/Wzj9N+BafwEuNAL6C+EbCiEyzkzOL9vL
 r3ERKS0blVlgiS51QAUFSQybYpbx6pIO1riJB7qABmWXDzuatpIV+c9KdjTp0NKR7YGa
 zIyXHZcocCcJIQWkX8pVUzi+VnmvuKHVsWCLaL+Ra2vKufZ62RvVSIdIqEFg5M7FyuJ5
 ybnvL1x8+9SVn+771uafbYRXCK1eitdtyOe1mcGN3zZyOLDeSTUORTjPM7mImCxb1ukg
 J1ug==
X-Gm-Message-State: AOJu0YypxRFMK+q5kL70Vlntg6VzNmTGvPKAZW81IzkNCzvTVTdNTZ7e
 LlniYghqcggZl/4pQWTsIUCi7XLmMYt9FUwrGFH5NLVeCXo/B+g7XypNnKA2M4Xpy/NtXBoYAwy
 7
X-Gm-Gg: ASbGncvgvESYb5TIivPErfIx+yhurhbnDGpSHeOczDf23J6Y4KAdbU/mSh8FwQhQjfD
 r0i0TJPPwKCGnTTm+wXdFJXthaa9mO39SX78aKa7pQ7GEybJi+Lsri1E+P6PB+AGiTaC4rYfgJj
 41X9L2ptz0868cXbEaIRmxHv1VjKjJ7cWj5g76icSKFgqOEw7Cxp27pWFg4VfNxLGpEK7ApOrAC
 17SY9Pz9nVfPLgBvdPzIy0672T/eKzzLIkmbUqQESHJQEU3Pm1PSsmTvvEI6fs267/2ft1uNOaa
 Yr/dKGjz0bd713tCU2NtyFa2JUutRGX3SHzyg9bqH1jel3GyUfQa0wfdAqamBXQw4p3aqucIhwY
 =
X-Google-Smtp-Source: AGHT+IER63EtuY3NysYQlTuCk92D9RGMcgTDphdSbofZxxNmdZuPpt1AFHJJw0LJJfh4rr4lAw0PvQ==
X-Received: by 2002:a05:6a21:174d:b0:1f5:915b:3e30 with SMTP id
 adf61e73a8af0-20444f0ddb2mr978744637.22.1745456212969; 
 Wed, 23 Apr 2025 17:56:52 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 107/148] accel/tcg: fix missing includes for
 TCG_GUEST_DEFAULT_MO
Date: Wed, 23 Apr 2025 17:48:52 -0700
Message-ID: <20250424004934.598783-108-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-12-pierrick.bouvier@linaro.org>
---
 accel/tcg/internal-target.h | 1 +
 include/exec/poison.h       | 1 +
 accel/tcg/translate-all.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index c88f007ffb..05abaeb8e0 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -9,6 +9,7 @@
 #ifndef ACCEL_TCG_INTERNAL_TARGET_H
 #define ACCEL_TCG_INTERNAL_TARGET_H
 
+#include "cpu-param.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "tb-internal.h"
diff --git a/include/exec/poison.h b/include/exec/poison.h
index 4180a5a489..8ec02b40e8 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -37,6 +37,7 @@
 #pragma GCC poison TARGET_NAME
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
+#pragma GCC poison TCG_GUEST_DEFAULT_MO
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 87fb6c51d3..ed41fc5d0c 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -43,6 +43,7 @@
 #include "system/ram_addr.h"
 #endif
 
+#include "cpu-param.h"
 #include "exec/cputlb.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
-- 
2.43.0


