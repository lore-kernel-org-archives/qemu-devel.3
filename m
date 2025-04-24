Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B3AC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kvs-0002uY-Kj; Wed, 23 Apr 2025 20:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktf-0005zT-O8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktb-00058E-T4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:58 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7396f13b750so433099b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456213; x=1746061013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQfBujJU7UIXTPefdL2D/GAfXKoyN3ifbh/HgiWO374=;
 b=lVpJD0vwRiHviZsyUZI7ZKhFQ6bzjYKxD00WtDUFgz0oFxUQ0Yqc31fQdtAMfnrGrD
 6EweIhvWnmVg2h2WrOUf9cAlCBvcci0OCxvMN6mLlgS3hXu/ocQQiwZhOBuUrbT2WL2R
 YqUHvvl9/Gugj8FH7mzAKRaC/nJp5SpRcb+fykBsJ4Z/zmr9kXvEgGiQVZofyby4lHON
 blKO1+OsUJehtZ0ls+GqHG1rTK4qyXotAepwbrsOB7MFMJw9p1sAaf65kmyQMfb8DH86
 1GtWroSVObrxSraJZbhgCFPg0AyVVudoFc0FslLTPyUjM8d+Xq/hvsH1YmYB7bxWDNd2
 E5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456213; x=1746061013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQfBujJU7UIXTPefdL2D/GAfXKoyN3ifbh/HgiWO374=;
 b=mHK00UBLMGS8+Smm8m311XeQkdG6yhvViPipdLOAWHQa2sRAWlOMHJi0JKwrJ2W2Xp
 3hFrOlVyuqE28LY3e1OGNeFuIffP2u/sdgThR40ujwIl3pvKMGDbyWuiAok0Uu2vfZC+
 rx6LIlewWVfkK6qw+A0brrGpHRukeYmNusEsP8kvJZnDm6sFoIDzo4x0pe0TEx89YZpJ
 plVb1vrqkm3niovtRqmNSM0J0NY6KN5DKrDGi4uiNvRE1eo/8SrATIFQ22N74g6U/T1S
 reLX6dx9b0R/z13CYKlJ1vcYOCNMVirHGfsTm1t7bRmpveLNMYPLGHIo/oO92wT1yCYh
 Gsww==
X-Gm-Message-State: AOJu0YzFUbPtn6J+KFlrrb6AHdYrSrTQqBrHiQUYt8F01e45N6+zdT4P
 jhQ0+I1nQjv1dlsYYLCg/v4BN5zMH3p9UCabKFKT08yswowerkSL2r3+4BTeM56NKEVK4mda9EA
 T
X-Gm-Gg: ASbGncugo82rcrMMjFzT8EqtzU+nNFEeFbEPU258ZolHDksLeaoyBV48w8pa+ENR7q+
 QoVn0TYDA97VRU1Zgrn+Bl4gTbcALrAwAiN5gGdBjTfwuq0rJiymLoDT5IbIFdK0ElC5kytcbVi
 TmLadDx1x8gK5IIDOn4uEy/0Gt/sn72WIKB3qE9J62gDpxbGe25/H9C6C30KjcmvkAILFJsgswX
 gmPf8JM9Gdd+BDyIrvB3TX+0hcBJwXHiUalp0OjJI3WH79Jl9iLKinZ9Q6s2OfjbbbFinD0+P2z
 Kfk61mwUK4kHwPg7M7IN4rsMLlFLKQhDx1+3XCw/unBmyCc1OPKmCu1vWs++2iPaeuXR63i6scg
 =
X-Google-Smtp-Source: AGHT+IGdRJvU0fvLrt8/79tuf3ToWDBPHCjb2N+gqLWAAnPOM/mVUOfnRtxxel3fGmR6mrkdRLlFOQ==
X-Received: by 2002:a05:6a21:78aa:b0:1f5:87dc:a315 with SMTP id
 adf61e73a8af0-20444e9b55cmr838786637.12.1745456213574; 
 Wed, 23 Apr 2025 17:56:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 108/148] accel/tcg: fix missing includes for
 TARGET_HAS_PRECISE_SMC
Date: Wed, 23 Apr 2025 17:48:53 -0700
Message-ID: <20250424004934.598783-109-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


