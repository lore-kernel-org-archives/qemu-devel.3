Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E896C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 17:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJFi-0000MW-8U; Tue, 23 Jul 2024 13:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWJFf-0000L6-M8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:24:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWJFb-0001xT-UC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 13:24:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so1463658f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721755473; x=1722360273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k2czhJvtkMfqRXVZ9gzbq0AkCoGEcqVzVE/Mgbbqq84=;
 b=QUZfItPS4+rS5luaOCfXMOhAAS0hCuJ6Q60w+NLz2+nU7iMH5l9Yf/eEnD1LgjDzY9
 FqAJn8PHRyynxVBDVqw0mHyVPq5EOOMrv9cqtno848o5BB13nZfbSH2XG5QK8rV1w7dW
 W1/SkRx8yzbnQEdVPHoFoyTKfGwC/XNejPXTjSHpc7dbUhhm4xLGSrtL/e4jzcwK1r1J
 ANRgSNcWZDXOeUdNPqYw/ZEB9vrRm8KYfySvytv7HZcp/p2HTf9YE23EZBEzoYQgjGjY
 p6ew0V4HtEWPCN95HVeY39bWcAkIVrCqLgf+/i+DAoE2D1T473GApnEnB1EKvFnQpYJH
 +KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721755473; x=1722360273;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k2czhJvtkMfqRXVZ9gzbq0AkCoGEcqVzVE/Mgbbqq84=;
 b=KRm9vPb9kvjgSm044G0/ONjn2IeKXm0nnP6hzlyKmC8gPYxI71JKs6W+nDUTLp2HOX
 kuj/vvk4sqPg5Lo06aEf8yMqvOJDycDYtJEV0fyCZk/F1/X5gof1c+2UosYJhGY88GuD
 mZB0mNZUlSb5s8mxcGlo36cS9VwQVNZenahr8TmkmO7Nbz4SforCosoSeoVc5OO6Ngr4
 vEwBcmB6Gxmajk6kXIdxmD4FPWXBGvouBJPq86antPpTpP2XMrMulNvytnvVSYvttWh9
 unJ701eeWh2EfjD0YNkErOFiAD1evHnfXSDLmpIt15zv5NK6PcPrUeYrlz6yF9xsRwzg
 eBxQ==
X-Gm-Message-State: AOJu0YxtSXHs7kyTsl4K3GsKlJbqZox0wctyOj7qUqCEU9TYtNz/NC2w
 F5ZoWe8mJLiRxfwWkxaofSnujUIZ3fVrO2rLu8CtXtKWcnyzy3dIgrcDa/CAJayTc9JeDeuoMXn
 5
X-Google-Smtp-Source: AGHT+IGPAF70pPkaDSzs2qiDJcBg860Yyv4b3o4Uh4Yy+khBLmFsRhqbhxMnY+s8QHMYC7tBc4Mzqg==
X-Received: by 2002:adf:e70a:0:b0:367:980a:6aa with SMTP id
 ffacd0b85a97d-369bb2a19camr7174141f8f.54.1721755472948; 
 Tue, 23 Jul 2024 10:24:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ceda0sm12065827f8f.87.2024.07.23.10.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 10:24:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH] target/sh4: Avoid shift into sign bit in update_itlb_use()
Date: Tue, 23 Jul 2024 18:24:31 +0100
Message-Id: <20240723172431.1757296-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

In update_itlb_use() the variables or_mask and and_mask are uint8_t,
which means that in expressions like "and_mask << 24" the usual C
arithmetic conversions will result in the shift being done as a
signed int type, and so we will shift into the sign bit. For QEMU
this isn't undefined behaviour because we use -fwrapv; but we can
avoid it anyway by using uint32_t types for or_mask and and_mask.

Resolves: Coverity CID 1547628
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sh4/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 67029106277..9659c695504 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -187,7 +187,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
 
 static void update_itlb_use(CPUSH4State * env, int itlbnb)
 {
-    uint8_t or_mask = 0, and_mask = (uint8_t) - 1;
+    uint32_t or_mask = 0, and_mask = 0xff;
 
     switch (itlbnb) {
     case 0:
-- 
2.34.1


