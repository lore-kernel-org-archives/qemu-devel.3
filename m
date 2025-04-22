Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2579FC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR4-0001HC-Hh; Tue, 22 Apr 2025 15:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP5-0005RB-NA
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP3-00076a-Mn
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:35 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-225477548e1so57019255ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350532; x=1745955332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHsAIp23EWRdufSrcLbCASuKqIf9fO9vwVBtAt7EmVA=;
 b=ZRZ/eX6bOVptizFninTiM1bjTmNjnL5w+nxs/MJd2tK1A91YXQOfnhlI5YlTArxmkY
 7gRLEP1zSBavdKDvHC8d3CzRjRAJUy/o+ZPq7flvzHp7Hll30XX+4Ks8CA/UGv7u1ytO
 DzHvM7DD06zyLoUCGz48Bk7DRtpCLOV60Fmwj8AZ7xXUMrSmf6MeMnEa7Sy2nO0TD8Ku
 uTYTPUcrYBTtcX1kXjF6rBwWV+Fsmm2HDVann/czXPiAFDYapIzqvfaTaex1DJedC2NW
 KsrOrdo6EnglR28zUO24Cg2U4ckMFaPpKDlA1upejg/Gde3agOXCZ16NU73lnJlHHQqD
 oHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350532; x=1745955332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHsAIp23EWRdufSrcLbCASuKqIf9fO9vwVBtAt7EmVA=;
 b=I0xidMsTil+O1JYxW/uWD6B482xIPqm6gC1WwKqx/uNyZapVKlJ8+Gp93EEm/1aoSn
 5SowwFEkaJgcmbel+zfs7dDSIHKxcKh2JkQ0m7y5GYOGfciQ2h9tvVIctxeb6TyNkhop
 DIAf3UpgXhKIfrnhvDXWqyjE4YXrgP0jOm5sc/AGquJLf8yvsXJ5OzCRPnibSy+qkul1
 jfHNjjyDntE9eFHlPvZ/V93VE1/h34TYn3QWd2Eyjg3EuShz58bogndjR/iURUW1HyJE
 gy67BalDf4NVgDtUwt6UegVlK5EAwTU+IVlIB8GvgtrhH95tPRC5P5LBIfiq68n2/aS4
 piIQ==
X-Gm-Message-State: AOJu0Yx1F6STAl94nTzQ+x3ujJL/0XnL/zkY0gDTzAcP6JHSvG9flFjP
 EPC2Hv8RSpTwSvOvbFLYr/el8Naj1T0p6P0sV6PrD/y6Oj/eJ/MWJr+5+DdYjaJlL90bXLnAZQs
 W
X-Gm-Gg: ASbGncvL2FmMGZSfXDdyBlDFnw6ZJHiEew65rjyfujI3FEFzrs7Y37eWG0dR3sb56L2
 Me5gfveoz1i2ed98tpUsA3HacbBmJygoesFo6LtjOerroNNaCIRndzpsI5t58c7xnGcNYJRtHs8
 rwRMa4g/xCXWybtQw0NxMbVVfwN+HsBsNOv6xhpt0duw4SOpFOAbeq8HSjA7Yq/stIoQWRqliHA
 VP5/uoXSs29Npcz5ZGz9MwGuRnTNAmynGOlsdDm0nmof/gXc903NuwlgRgx5LghTjbXLcDeI5d8
 T1WS30p8VxzcK9nnV41Mm3Nka6HPoh6bxaCD4SP/WsgnJsdjIgIDYpCLDL/7c8/6njcY6F43oFg
 =
X-Google-Smtp-Source: AGHT+IEfrGCr03PkhmPvL5sX8lozgwc/ql1BAqQ9NZUOTlzuMpVI1MMF7GQx1a3uUXmxdFYKNefwIQ==
X-Received: by 2002:a17:902:ce8c:b0:224:160d:3f54 with SMTP id
 d9443c01a7336-22c535ad0f8mr251054425ad.31.1745350532146; 
 Tue, 22 Apr 2025 12:35:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 109/147] exec/cpu-all: remove cpu include
Date: Tue, 22 Apr 2025 12:27:38 -0700
Message-ID: <20250422192819.302784-110-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Now we made sure important defines are included using their direct
path, we can remove cpu.h from cpu-all.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-14-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 accel/tcg/cpu-exec.c   | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7b712b2556..dae4fbcea8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -23,6 +23,5 @@
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
-#include "cpu.h"
 
 #endif /* CPU_ALL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d388be83d0..8d2b957a3b 100644
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
2.43.0


