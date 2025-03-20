Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75811C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOSI-0006MC-SP; Thu, 20 Mar 2025 18:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPr-0002h0-Ab
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPM-00079v-27
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:31:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-225a28a511eso29432595ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509827; x=1743114627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/4XryTOWm6w/MZRVd6kifOMES+Py2IKRoyOKSLgV8g=;
 b=UkTYg5KZLxmcGGE5ARi5Wf7dUGBJcy455nKaNv1gL59/O9S6wlLTtzUhsbL6ELYdD6
 M7/x5hAYJTRHqmtoj3pKZtO7ksnFNAaycNp32mo2joHgsC5PyaXCOz6YqXwIk0UIqfku
 Wlz1igpSETqrhA7uQK+pi27rWm2O+5aWStBYb+5/Nt9eZl6Z4aZhyJpTXLPChtq2DeLq
 LgxcLX5pFMjm1HlnzItniXvPj3P0VdTMRUXiRPpU6+yR3zUrrGYR0yoIv0XwI1J0FpMP
 VG/3LOcAJOoHF7fmGVJhWhHBahiA5E+AC6uEiWrS7T7dc2T6ZiuzqMp4NyWLyO+qdOHG
 pf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509827; x=1743114627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/4XryTOWm6w/MZRVd6kifOMES+Py2IKRoyOKSLgV8g=;
 b=VT6J0GHytgjbixdYUpUZe2DQvAGa+XpU4wt9Z/dxyc7l9j6JcwaaDyJ80YlOuQMM07
 vQXNciSsNSLB+rJgiIAo77kEpzu+29y+bV+7xviMR5YVwpZIt6KFbSwZNgFbG8o8+P8m
 9Pv6qmRuaYfK4aqNYeDRpUr+hr8bJfG0diLiaG2IbzW6r5lEjuOanq5K2wJsS7pVcgrm
 jPaZrTVvk+mDl96MDeszkLXBxATCcVY8aNwOfJ+/rIhMaV/MJZ0YB8NJhwjYqIlg/sYa
 vPIlNugpEL1tobzr3tZVX2D55d9NUNR9WGlnfz/CaXKsFaIRHpmxGVqsQbbY/hcAjKNJ
 8Neg==
X-Gm-Message-State: AOJu0YztRYtF0J365sZ+UFUeAeQpnOP6Gaz5pR54sqoLxRnw3EUrH15a
 wH0TjuXN7uwJcPFqrY61OtqfDqtgOEHzslWa0YOphrD13hq3c3sSePt67bVVjNI4fvJrEmvXLrz
 D
X-Gm-Gg: ASbGncsUUYlSfCWavYX/2u2V314rTxssSlBYPUJvLAPrIW+ezM6GxURtYfePeqW66Na
 xOdUAQ0XGncvWSgimCY8isNufld2UOU4UsFw/6B8erBtPaxyhXVSpgymttxHCOkyC5lrSknlECk
 lHC5XQR2w5bB4R7/SkfbrJ6PiA+dQo6oDOFbnhvvpjLJx/Rz4bKEMltiww0X1h34I5L5Tje1873
 TNsGsHoR1icDi1PD4LW7cV92Jg8yZWgC7ncpMdjBrb3Fn8jRQ2t8sJq5ma8crCJF85UR+tPXA3U
 iJFxYnFi2aj3kGXR8iMaj5wCcXZI25YWck0EFCnjWLJL
X-Google-Smtp-Source: AGHT+IEsmAbnRKeqDLb8Obh57hU4D8dne9W2d0POjgz1H5aMyJvN3a79EMmmYiR7WIxM0NHx2HlH/A==
X-Received: by 2002:a17:903:41c6:b0:215:b1a3:4701 with SMTP id
 d9443c01a7336-22780c7ab87mr14047555ad.13.1742509826750; 
 Thu, 20 Mar 2025 15:30:26 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 14/30] exec/cpu-all: remove cpu include
Date: Thu, 20 Mar 2025 15:29:46 -0700
Message-Id: <20250320223002.2915728-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Now we made sure important defines are included using their direct
path, we can remove cpu.h from cpu-all.h.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 2 --
 accel/tcg/cpu-exec.c   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d4d05d82315..da8f5dd10c5 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -21,6 +21,4 @@
 
 #include "exec/cpu-common.h"
 
-#include "cpu.h"
-
 #endif /* CPU_ALL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 207416e0212..813113c51ea 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -36,6 +36,7 @@
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-all.h"
+#include "cpu.h"
 #include "exec/icount.h"
 #include "exec/replay-core.h"
 #include "system/tcg.h"
-- 
2.39.5


