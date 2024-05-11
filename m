Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D33C25B5F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIy-0000Ml-IL; Sat, 11 May 2024 07:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIv-0000Lc-Ul
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIu-000701-3y
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34d7d04808bso2029908f8f.0
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428454; x=1716033254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TszikIIR0P364Y+SfqYmtCRzUOVzTKFI40YQ9lx2ZZQ=;
 b=DRPzxLOmN0bK+oy83RYmAk514pFRLzU3B2vPzC0HFumODOX2nX5DuphSONvURsNO+d
 8rgEvUXGxW99d6AeHqqx5ctdd/4vMxB6aBVed+lzi3Yk/Wjd7ABxukvJSJj6P2y4q8Tk
 Pi4aHBUo8rR5wMrvLvFMcvyt3p7tw7yW+95HrhrADCZ9xWvrNIQLonCJSJBv6kD6L5z9
 D2bhLUie0jbex0vg4ohwvoaj/0sv0FSNmMuNrWDTCdDbYbErW7tqXLo7ddEhuoDbldi5
 r24FIHcy7DUnbwY2VTTQD0phaqueJ+Lw134b6kJukOVaDZiQLhCC2nrm1gEeko6gI4/s
 Shkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428454; x=1716033254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TszikIIR0P364Y+SfqYmtCRzUOVzTKFI40YQ9lx2ZZQ=;
 b=j+9YNHV0lP+AZpy8YPw+2DDOYar/bzE2xjKRrlLBN+3yXG7liOHaQwfi4P4DdoXexM
 J01weVpy8xPqvHU2kIhUHIp7YUA2mykXJcsF46hLNt4Dp8FYJEnDJSwO3vDex7YJH8FP
 J0gsOmw5shxzkNwFP1o7ZGs4K7N7/LGbVRqeEgLcOrtPdsuaUHd3XKqufLrsnpKtFZek
 nGCB28b6xtu2GJyCF5pom6hBeiQUGhgbzSn2jYA5znPlBx6w6kxPt3FVWNLCyFz3L3Av
 sAiFxf7N1AJYZAY2LGa4pDhSf6tE32lB9iREmsEdhXRUk5XQulk23yb925fzMGnL2VSy
 RAww==
X-Gm-Message-State: AOJu0YwofIk5A+h3qnUq4gyBL4n+/T1/uCXzFOYHa12zwnRZldQ3QTiG
 hqaH5vA6VBJcReyWBH1l1aG8xxxC9BKiYNw8rIsf73o9KlBEp8GRoTe7TVu3JwoQEn+SK3TOD24
 Ccs4=
X-Google-Smtp-Source: AGHT+IF9EqG2lwjbMa0DFrrLcJXXEC0qlFbRB7QMEv2Xh6wHmE8IXqSCdVpyP+DrxGZ7yh4Fw39FxQ==
X-Received: by 2002:adf:ef4c:0:b0:349:bccc:a1e7 with SMTP id
 ffacd0b85a97d-3504a6310c6mr5585661f8f.19.1715428454677; 
 Sat, 11 May 2024 04:54:14 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 12/17] aarch64: Trivial SME test
Date: Sat, 11 May 2024 13:53:55 +0200
Message-Id: <20240511115400.7587-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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
 test_sme_aarch64.s | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 test_sme_aarch64.s

diff --git a/test_sme_aarch64.s b/test_sme_aarch64.s
new file mode 100644
index 0000000..acd08d4
--- /dev/null
+++ b/test_sme_aarch64.s
@@ -0,0 +1,63 @@
+/*****************************************************************************
+ * Copyright (c) 2022 Linaro Limited
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1.0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *****************************************************************************/
+
+	.arch_extension sme
+
+	mov	w0, #0
+	mov	w1, #0
+	mov	w2, #0
+	mov	w3, #0
+	mov	w4, #0
+	mov	w5, #0
+	mov	w6, #0
+	mov	w7, #0
+	mov	w8, #0
+	mov	w9, #0
+	mov	w10, #0
+	mov	w11, #0
+	mov	w12, #0
+	mov	w13, #0
+	mov	w14, #0
+	mov	w15, #0
+	mov	w16, #0
+	mov	w17, #0
+	mov	w18, #0
+	mov	w19, #0
+	mov	w20, #0
+	mov	w21, #0
+	mov	w22, #0
+	mov	w23, #0
+	mov	w24, #0
+	mov	w25, #0
+	mov	w26, #0
+	mov	w27, #0
+	mov	w28, #0
+	mov	w29, #0
+	mov	w30, #0
+
+	smstart
+
+	ptrue	p0.b
+	rdsvl	x12, #1
+
+0:	subs	w12, w12, #1
+	lsl	w13, w12, #4
+	index	z0.b, w13, #1
+	mova	za0h.b[w12, #0], p0/m, z0.b
+	b.ne	0b
+
+	.inst 0x00005af0		/* compare */
+
+	rdsvl	x12, #1
+0:	subs	w12, w12, #1
+	lsl	w13, w12, #4
+	index	z0.b, w13, #1
+	mova	za0v.b[w12, #0], p0/m, z0.b
+	b.ne	0b
+
+	.inst 0x00005af1		/* exit */
-- 
2.34.1


