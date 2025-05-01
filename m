Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D378C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVKB-0005jf-D7; Thu, 01 May 2025 10:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVK2-0005i4-7U
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJz-0005Xx-0f
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:32 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso1303365a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111329; x=1746716129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NpsPRpqYy0EdExgjwMRc7rUCQIZJoGgOry5zvIX2oes=;
 b=gDmTO3ymeJj/466t7O2qs5cwyfmf4fVSjht1MjXZjUMSVyMVAMkfnHhNfsRsG2XUQb
 YqF7q7rdDpAS/4i3V8bp2JVt8hIizOjf+KK0uaaTUvuA7NPT4O4ZfkiltZ97AXbLCDmm
 g2lY8khXDngiv3RYzgLRZmWfLmUrtThhwu8n9tbDe9i9Z/L8IkOgPnXRMG4RkAWm2FP5
 9FbRqCjUX/lAsvGVL33Q9xKr5jBRibghAM3mZ1Q8+03lR1a7P3JmNBw+9VW2zEDqxZNq
 MzYTrgAevYfqH0V8y2oABmu2zjUZ04tekmiK+C6CghqdqLG7SOpoxDkqkTLN0vNwoC/S
 4sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111329; x=1746716129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NpsPRpqYy0EdExgjwMRc7rUCQIZJoGgOry5zvIX2oes=;
 b=tRj7cONz6zL90c6bJ7k4zPLmJufk8khiAhAtHdiAzQVksI+tyJ76QKqr3E5Yqd5Bpk
 1jasEO+LjWPoeERUKXH0KSNIb7qk9/SbO5m5TcVIO5JHetwKls8jTTN6dOs1arPCBM+I
 qoue+/SfyundzWTEmESGeh6DkcBjrY3JXo0+0/35dxVNA4tOwHSnz1S8b7z537tWHKqa
 Flll3YWLS2yM9LIAIJEXruN4yZdo5HHqA7PhSuzMExYrCn7GFSFYSE8eHYrNd3BRqc6g
 Z5aNsd3RqD82cscpLGkqG0J3YQ4UKZcBs/ngyc2Sevo5iGCwfberyiYr5xyIQIt15sLm
 wyFw==
X-Gm-Message-State: AOJu0Yy45Sd8VMxZBKOWzPdMSz9Iw/bhYY5RLfS/ABx2NDBaa1o0KYWW
 phsG++rFNOiT1uQKH0cGbQ3KUENSK5PS6xDYSBCvbjZPzluH9YPOrl9ReoxuwA3v4ez4TVFdAS7
 9
X-Gm-Gg: ASbGncsGYLpRjOX2uGR1TPs3zLs7f4X21Y4G1OLD6CYYWo99K50yNmNOcC8HmUFhE0G
 40lyVXhzP0e7tKYnt6wRPe1ZS82KeYj1xjbPbmdiPcasi46JPYeVlskmYd3QA/8q6WhqBwPv53e
 EGOzhbCUreZ51Fih9urmIZZ2J06JbzqGrhlJ1PT1n9ETcHGOB3UR2fH5jMB8bi1uNxFntaoQU1V
 4brdaLmdq6FyKCrfoY97gr3cbQFRBdMHaWjrsc9q8Ljka4fdlfn3uiuc8xXgN9IJq1088CNgY7v
 4wjJlysn01zcT+DlhwW/kqCpPYcpB7CxAYcQLzUGuGSJWj/Ex0DbjsjK/d1g252ewUMqsupTHIM
 fL7uyWU+4+g==
X-Google-Smtp-Source: AGHT+IEkihyDrcdG5GTmO0kCkbmbJIyn/QC/dRNyBK/I2JvpfRA+6N6GWqZcZYqCBIHl6KOCSHB5nQ==
X-Received: by 2002:a17:90b:2247:b0:2ff:52e1:c49f with SMTP id
 98e67ed59e1d1-30a34467cbfmr9183749a91.26.1746111329146; 
 Thu, 01 May 2025 07:55:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] accel/tcg: Build user-exec.c once
Date: Thu,  1 May 2025 07:55:19 -0700
Message-ID: <20250501145520.2695073-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 5 ++---
 accel/tcg/meson.build | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 085da0c036..f25d80e2dc 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,13 +19,12 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
-#include "cpu.h"
 #include "exec/vaddr.h"
 #include "exec/tlb-flags.h"
 #include "tcg/tcg.h"
 #include "qemu/bitops.h"
 #include "qemu/rcu.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
 #include "user/cpu_loop.h"
@@ -33,7 +32,7 @@
 #include "qemu/main-loop.h"
 #include "user/page-protection.h"
 #include "exec/page-protection.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "qemu/atomic128.h"
 #include "qemu/bswap.h"
 #include "qemu/int128.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 9b86051b82..d6f533f9a1 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,11 +21,8 @@ endif
 libuser_ss.add_all(tcg_ss)
 libsystem_ss.add_all(tcg_ss)
 
-tcg_specific_ss = ss.source_set()
-tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
-
 libuser_ss.add(files(
+  'user-exec.c',
   'user-exec-stub.c',
 ))
 
-- 
2.43.0


