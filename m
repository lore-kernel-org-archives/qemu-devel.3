Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1B4C41513
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIn-0000HC-OD; Sat, 11 May 2024 07:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIm-0000GZ-CU
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIk-0006wF-Qr
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34de61b7ca4so1940336f8f.2
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428444; x=1716033244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9q5UQizGwrMYMCi99D6HLSzNEy+uYysxva9bCXYLNI=;
 b=f6Ax+JFy7Y7AzCDnAoPhZwmvIiDWEuXrZglacz0b4l1qmuEtYe1o2+8j7iUQ6sL+Cd
 aVDA9REDeR/1n+7YAeSQm4quKvP91Nn1pWkFAc3Pj1pUjFxTtZ5OC9nFnfW7+7o4BjFq
 ZWg28cGo+Ku+Qll7MnyAY1XClia0SxjOBoBWgfmg13k10O2aACczVMGY+E3YXQtazo11
 i4ZKzk0Rd+c2nd2SyFD/EKqJ/H3tVsU1SWwUWO56bzp4yA1ZzdqfK0MxW36M6r0trAV5
 ett+WrKDJPpc+o1jVPxXrca76pq1DPP3v1yA5rzxx/zrYDEOiWfiHhqdivESUTFmEjIM
 J0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428444; x=1716033244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9q5UQizGwrMYMCi99D6HLSzNEy+uYysxva9bCXYLNI=;
 b=hxP7mh6tavcXPJPDcaKKQmCwXg5QlVFUmEPFwiu0dTQXbIEiii5vhNz9UFt1KmGsT3
 9VgXkVTODEYEdHsLab2cvU5OdH23Zoi5poUiuZSLGwtgb//YSR1UBGr7+nUaDf+6SOta
 sgG8XB+6AhJ/cldLbchPn75LjFtnu/yHJttzxeo00uEqnRkUKgZEKx5InxdT+b4ENKGA
 CBQsUoIm2dAXbyDk2oxRsGMrFHV1nimOjiv+tjo0pXSZRFI/IxkBrQeiPs6OqvaMCWzF
 uqLtf6Ifjdg2a0Ar/FG/BgqJ+jUUNBE47sH/WyJz/T8aLvY6G/8OxqRuy/+JyaqLDoFJ
 TACQ==
X-Gm-Message-State: AOJu0YxON1fRcINXTxVKkeeS1mBhUVBXe2K3mXjr2ZkcQyBC2XQFCXNI
 zi47r8Kx3JGAy73hedZUiHo7uWYZv5IIbxllEMlU5bgzPssAbzRp59PnAUxQpOPeYHMlO3y4kOc
 CD/Q=
X-Google-Smtp-Source: AGHT+IFQzbgcKT7k+7lSnmBZAy4bCKZmrkQa/ErK5nU2JeOet9dpiAAc5WGy4nRLKaA6J6i0hh+Ahw==
X-Received: by 2002:adf:e851:0:b0:343:ddbe:4579 with SMTP id
 ffacd0b85a97d-3504a61c790mr4880986f8f.1.1715428444031; 
 Sat, 11 May 2024 04:54:04 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 01/17] ppc64: Fix <sys/user.h> include order
Date: Sat, 11 May 2024 13:53:44 +0200
Message-Id: <20240511115400.7587-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
 risu_ppc64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/risu_ppc64.c b/risu_ppc64.c
index 9df8d58..62cf6aa 100644
--- a/risu_ppc64.c
+++ b/risu_ppc64.c
@@ -11,9 +11,8 @@
  *     based on Peter Maydell's risu_arm.c
  *****************************************************************************/
 
-#include <sys/user.h>
-
 #include "risu.h"
+#include <sys/user.h>
 
 void advance_pc(void *vuc)
 {
-- 
2.34.1


