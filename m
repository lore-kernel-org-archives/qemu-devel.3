Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FA4C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr1p-0003ua-0w; Fri, 17 Jan 2025 13:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1m-0003te-E1
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1j-0007eF-Fr
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:06 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21654fdd5daso44787895ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138302; x=1737743102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kbD2fy0ZsrIZjczUigAT7kEYROqKzeHL89DQQ9XFYc=;
 b=dbNfKwoGYzFcogVw2pMjmyooeUt/e4yYa49cqxxrIfFSJHrl5DGubbJsg7mdfiJz5A
 HiDqxtptNKDe4YsVxgh8buYwAo79YUU0IoH2UAC4HShUJfEnCF1AF7XC5dkHVb7qbOPN
 P38bGK9klwiMbxPbk8SQ1GjQGT4GsCkXf2PdkTxZcpc+dscB0isLOByBOn9uTPHuKiA1
 4wqTa3W2ZpzPHiJlNn4k0kEiM6UxFgU+bwXcQm+D6VvZ+cfq6SDmCjTE3CmSoXEZrliV
 JXzilStwzvpcEd/Z6wyCvZZ1q6l22xeKhGuS331t/MOWB1XSRMdJ+0Qifezc4quKUyMZ
 9n3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138302; x=1737743102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kbD2fy0ZsrIZjczUigAT7kEYROqKzeHL89DQQ9XFYc=;
 b=XYMR9oDyFF9VGwkchbCmSb2TA8Dtf/E+W3Og18EeRt//+NT/JYUYHn3NtcX+i9yGgl
 n/OEexfSJjcJLJvXFFKfZaazeu517I/r96pNHn8D1SrahMllJvaPybYuguXVlXRWrX9U
 Uvg1rw5hSNBx7TzBR+rvYFJNJD88mzlB1J/gREh5Oum6+wH+P/n+mafXxVeK68ykYnRQ
 5CLP1oEhWv6Aqm6cnupXlJJ02JqUTCBv5uUEhXmmWkoL63ASKYvGReTMG+obaJiaYzHU
 WopJwxNUBKLq6TK2cwL48HiYDP5P8/hee/Homc87pBC19yYrFaEagEeHotyFMI5fAigN
 L54Q==
X-Gm-Message-State: AOJu0Yz/I+4gjP6FqgIxdY5HRg4mPbZ+D8vedBMe//lMHf3+NCRWn489
 7wEna0iw0f1ujtAdvdZ1XwU5qvw+wPeVfE0nO5xpOdb34aq9Q8WkH0HyJJjyOxH9x+f53M2stHI
 a
X-Gm-Gg: ASbGncsk1jR0PtENyOfFYShHPP/PyqWPR/jfyf2aLheIZQmjjnD8pVHV8lDlyTS1+78
 sYCetlxtfTwNnm9rWOpk1N5pGTlR+/UeARU8wLsrICcEgtaYtqj8q0VyGo3xx9CMyDffaz2WB9C
 SvRXsLUjp4IlxI3BZor15dVolGTaSWdmm63efXMj5vNWSXdVJcbzshKttO6fZoaSVNbOxuJnuIT
 77ub2X+6isbUgZijWYR0ewqXYxhD9PUcLQbHTBXB7otNAWzcrCLRqsAioqd0N6D6vvwOzHRVjCa
 gHZGb4W9m+/1bx0=
X-Google-Smtp-Source: AGHT+IEKzADLG1zTjlrGJJMmCLlyLKvS2bC7GrFGYDe0iV/sj6H+oCW7z7/EculFSQdIEV7Umx8bvg==
X-Received: by 2002:a17:903:41c4:b0:215:b75f:a1cb with SMTP id
 d9443c01a7336-21c352c7d9cmr51724725ad.9.1737138301798; 
 Fri, 17 Jan 2025 10:25:01 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/68] tcg: Copy TCGOP_TYPE in tcg_op_insert_{after,before}
Date: Fri, 17 Jan 2025 10:23:53 -0800
Message-ID: <20250117182456.2077110-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Simplify use within the optimizers by defaulting the
new opcode to the same type as the old opcode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 6838ecdefc..f2bbff8079 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3249,6 +3249,8 @@ TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *old_op,
                             TCGOpcode opc, unsigned nargs)
 {
     TCGOp *new_op = tcg_op_alloc(opc, nargs);
+
+    TCGOP_TYPE(new_op) = TCGOP_TYPE(old_op);
     QTAILQ_INSERT_BEFORE(old_op, new_op, link);
     return new_op;
 }
@@ -3257,6 +3259,8 @@ TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *old_op,
                            TCGOpcode opc, unsigned nargs)
 {
     TCGOp *new_op = tcg_op_alloc(opc, nargs);
+
+    TCGOP_TYPE(new_op) = TCGOP_TYPE(old_op);
     QTAILQ_INSERT_AFTER(&s->ops, old_op, new_op, link);
     return new_op;
 }
-- 
2.43.0


