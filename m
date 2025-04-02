Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC18C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06VM-0004hx-K6; Wed, 02 Apr 2025 18:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VF-0004h2-MC
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:12 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06VE-0002Rm-1N
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so1299155e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632645; x=1744237445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDr/ul5OFsiETmBtqo4fJS+9II8rXl1Dlp4n7ItAQxI=;
 b=Yu0B65ToQ2zlm82Z5lJR/8Gl6DTZBD3aXuWBmQfLhpsoFdeUmqK5e0XReNQsIMhF7t
 ezVZYg6NLPX169cFkJ7d0UGyy9JaUuXfVyp9SThNxOaOS5MXoV3LsxQkaA4raTTuqQSq
 ZEf/FIhc045veFcg8N7pI4Lb43pPdos2V0VGhSv8Zt4yc4trXONWxSBorbf+taNO+ScN
 b/3dyYkm0ye74+t2AcRIwLHqvKadmT4XjXEHA2Agkex39Z2v0OafZNFWM5iFRqvcCg9X
 iPg8IXxUORvocfGZqZTR6DdCvZUBs0Q798vBDe00f+Lq8CaVGf1mM6rqjRvIHo/lh23Y
 +wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632645; x=1744237445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CDr/ul5OFsiETmBtqo4fJS+9II8rXl1Dlp4n7ItAQxI=;
 b=fZ50l25hqGofsivdvSBR6PuL5apxP0ILM7Gb2Sz8xyMHze819sI1bWFc6j82lXwYoO
 gJdCsqsSoE1o/k2J6Ch6IL4E4FL5XkL85ZOocl1Il5LDpGdBJr8bxDOo3bh21AhhUEHX
 gf4MBx7jceK0cFNK99iwBXBVvyKf+yHautNuE90mOiaIoPz8Yv40V7WX6cbVTbUJYVOg
 bdTbz2RHyp4vLLwJQomvTUTtlaiQYXFPLjeTxnUDq6cUR5vzdGbGO5JwTA0WFpg/I64Z
 ElY1Tzgm1FRR4PpUQu+JPaDvYziB2KsSlhcDWzbv8baeyi/Lsq1SfLesc1fC2OFA6wwt
 r8Ew==
X-Gm-Message-State: AOJu0YwkLsEhMKE8fCDJq52UfgSwkEBL+m/52cJXS/8w7NigMSv3DCuA
 ZOc5xW+/S3feNF23bHoVvj1vdMvXcaESL0F40AbnR0dJx3mih72j9UJUBdz+eXDIW/nQTf34zfZ
 6
X-Gm-Gg: ASbGncsFoDE8rcauYVjo7h815yyaV0HP9wE4Ktb6LUpOYOmMCuQMG0ZFqZYbjd70KZa
 7apsobhNAiKniFNcY4f0a4edINA2kf/dKiM5z0kCWgzJMlx+jPTXKDti8qzaJRs7v5+xBb4qHIW
 bedXLN0HHlxxxx6NtmioT4+uWlI3wC06k5Jha1ofFjfoYEoN6+hSsNQv6+FZfA+6r+TfqW8269N
 3j/pUg8XMwH0cEcGMaH2M2JY8iyTz+A0W+mnlmJOdod6gs6wVQkT8KdAD6/Cg9R/Bg/Eqf8eYpv
 O21gXsXP0SE+QdmqZBy2yGFl/7YHTFqIDDCapV+RnBZhGAlhgf+gneqh1N86nEuf+uI6ayFDvj5
 qrb2Vx6RbWDT6BFDwGUM=
X-Google-Smtp-Source: AGHT+IEQh1IR2rRhcYtEp4t13dNvzL5n0vkmGz0oHoU3/ZxOr1lLpEDdGxxiKRHiWZf3fkMXsnuEuA==
X-Received: by 2002:a05:600c:3591:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43db61ffdb0mr145204595e9.16.1743632644836; 
 Wed, 02 Apr 2025 15:24:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a895fsm412665e9.13.2025.04.02.15.24.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:24:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 06/13] target/arm: Restrict inclusion of
 'multiprocessing.h'
Date: Thu,  3 Apr 2025 00:23:26 +0200
Message-ID: <20250402222334.66511-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Only cpu.c requires "multiprocessing.h" definitions so far.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 1 -
 target/arm/cpu.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 88ed06987f3..768e784c3e9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -30,7 +30,6 @@
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
 #include "qapi/qapi-types-common.h"
-#include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b1aa482c726..6f62745d7f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -53,6 +53,7 @@
 #include "qemu/target_info-qom.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/multiprocessing.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
-- 
2.47.1


