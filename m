Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCCDD68BC8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 15:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBy8C-0001nN-1M; Fri, 15 Nov 2024 10:21:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy89-0001nD-W6
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:06 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBy87-00043e-MT
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 10:21:05 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4315df7b43fso16214175e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731684061; x=1732288861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHhL6wb85s4vVZ9BFDdlVsTHRSAYWS3+Ku4UPdQPugs=;
 b=kwQghvE43+ZoRdzJTiKU8xE0miAcJaXEO0apx7YYj66PN0B3Zhm+Ajn0geIZIGdyAX
 dWekkX5+xj0wnXUt8XSvBdH7BHKa//s5AXkPUFQa//AphWcyfoe2ebtyx7t6p8JTw7lK
 LyVU0WzXchJYc0rnZDmDmzgj3/2gGPxnUu5xB3sK0DjE/ndsnO9B+V5mqR+g0yOYhFJ/
 JXoTV+RjEnm8mQmdK1q0cl/Uj/JiaRtPtrejjPR2curnpW5gkzd2xzySgfAw4QvRKXFN
 BB9GNtQzW/75aBSqYHGpBAf8wADo81CqaxLY1U1expkcTIJAqCFOcuicxZ3BjrlPnYl5
 Tllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731684061; x=1732288861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZHhL6wb85s4vVZ9BFDdlVsTHRSAYWS3+Ku4UPdQPugs=;
 b=ai8sWhkaQCm+JgUlPT/so9PNIIHnLyawcfOxhW6md38deWPb9WnnXkc49ZEYHpFR0H
 PQuFjXlc6j263i7th4yKZ0xlRkaHIKPlVXiB8czMrOd66qP8QQeF0xzlte3bkJ+BgIVy
 Q7nm6Pet0B1iClArzOj1W3JSbpdU1pOam9JizQ1cGPjw3EpGI41cnpcPsUZyothJ18Ik
 q/yBsUUGYNP3TXZC4R8qq8+QPlRRZjwQssM519VltRykDDeA50qNXN+qoBb2rST0kx2e
 6hlTBzdHEH+Zne07wHPoUdRDa4WTNw0qDu4XiF/znmzuH8fubLJVFT/7BLH7mKg5AAua
 1v0g==
X-Gm-Message-State: AOJu0Yy9INRXZcC1GweCOhjgdqapyiF2N+hWVpHkP3z4eC/BcxV3C04a
 ZXXU+TDertlrAgIIUi0RB3c0EdIMTvc4aypnHe9rpxBhoQ4yyhnL/8mxPBZsQpOFa5gUSVxH9zZ
 5
X-Google-Smtp-Source: AGHT+IFcZqtj0nrYajCPzZ2ZxHFcoOHUpsn12FX+AoPttX2uVp/ShhRLVZMmFwr0HU4t65Eh76cQ9g==
X-Received: by 2002:a05:600c:1382:b0:431:5d4f:73a3 with SMTP id
 5b1f17b1804b1-432df74f0d4mr23861875e9.18.1731684060699; 
 Fri, 15 Nov 2024 07:21:00 -0800 (PST)
Received: from localhost.localdomain ([176.187.214.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab721d7sm58337185e9.9.2024.11.15.07.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Nov 2024 07:21:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/10] target/mips: Drop left-over comment about Jazz machine
Date: Fri, 15 Nov 2024 16:20:44 +0100
Message-ID: <20241115152053.66442-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115152053.66442-1-philmd@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Commit 3803b6b427 ("target/mips: Fold jazz behaviour into
mips_cpu_do_transaction_failed") removed update on TCGCPUOps
and commit 119065574d ("hw/core: Constify TCGCPUOps") made
it const. Remove the now irrelevant comment.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c..7c6f438e5d 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -546,10 +546,6 @@ static Property mips_cpu_properties[] = {
 
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
-/*
- * NB: cannot be const, as some elements are changed for specific
- * mips hardware (see hw/mips/jazz.c).
- */
 static const TCGCPUOps mips_tcg_ops = {
     .initialize = mips_tcg_init,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
-- 
2.45.2


