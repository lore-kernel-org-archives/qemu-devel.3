Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B7EF99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqub-0007ch-Kt; Thu, 23 Apr 2026 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu4-0006Yp-IO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu0-0002JK-Fn
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso3191567f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938596; x=1777543396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fEUFHfMcLq9jFYBA6iiHhH3ilA9zZne4OSj0U6OqLbQ=;
 b=nGmog8qEhMfifNYBu75RWnPbUI27hAnA8W1EF/+EkhfCWrmidLjYqaiMsLuDW6iFzT
 GJdYC2nxkleXS7vcUrvbu63hZE/Lx/A9CaOJ6QbBcbeArhwk0EyokmK/kJd8Lfyr6xud
 aR/2uypajJOsNeuuESPkMBPvLkPemAnoNIRV49FEcwsJpok3uJDJ8LrvLW9SRxfCcEFP
 o8bouR6oRI81iunoJ5d7b2CRVpMPuXsynW1vDQeKDyFewgfaHTqgogP/+9aIRQTE6LC6
 NP9kUp+XIlhV+mad+lPQg7AQf/08RIgCWAgDkj4KdFJ8qk+omkGxmCDDWx9f5DKi2J7S
 +JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938596; x=1777543396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fEUFHfMcLq9jFYBA6iiHhH3ilA9zZne4OSj0U6OqLbQ=;
 b=KNKMF2yr5Ft+Qsn1+u/e9kqh0xIaf3h1lRs368mn27dJABDrG1iyZGE3f2W5cY+fvm
 6CEGXFgm+vY7XamwgWZRjvRHB8apicesT9V4rdZORJfdcko/4zNNTdkMHRh/04gmxajp
 2QEiosTNWL68crDAHR52NJkpQGZFCugHl+gYpF3qrIGJVhz2IsZFNBk6z84JyHDrNrJE
 Ymd61UhgKXQ71Lk6zXrNtMaMEZu1WZ8thT+UjPEl861/z0+DKUXgOMymWGPxavWM9ox3
 oUobhwoMagqiEVYhM8y41AvqIsUAGPn4421noaNgbnIKIU2FMTg5KyfX2G/4HxRiaWUT
 SV5g==
X-Gm-Message-State: AOJu0Ywpctq9axhjw6Y7hg0bH6BOejOQHcQpQrQxq8SGHvHc7tvqYEm8
 Nhoos1UgNjtbD8y17i6ozSn/b2lvWPGxrnwSt08lDB5TluS3vdhHJAfZq2l7H5JBXojEpW38x5R
 fsT1R
X-Gm-Gg: AeBDieuVkr6ouNPZYWZ0A9L6Iz3isr5y/qLDTS3Zaml/pvcaA0ecuClOOSUDI2EZynN
 NwtNKqao+5JvrLP6/DqxAoq3SRK2+lQ1eC0hvzRhO58X4UUSPJgVnG+PuQr8YabFwUaXFgJ78Ak
 1r9Naff1q2waqEbo0gLeeQ3Uo9BZsuYOMLFDOk7QHkvxPvAkdPMcOgB3k6j27IJ87ENE8Q1RnqR
 GZt7ZwyoDZQydagB6SxBD/SUxh+GxFvsp8lXBvZZ5ufXNfs+hYcC4Ol313aLjy2hR1JYqAU+t2t
 6yr+hRddG/qmd8tFmJR9jt9nh0lYoNLW7wcGmaYzVfzPULmtaWJItM9g+dzCLk/gQ+7A2PEeFwg
 PF07CALoxyofoDL+uX2kva0bawgSxk4FCR5RHf1oJGyIeDuBIsVY0+0v2Ub4JgsnF90DXPJ/j+v
 BfbKjAb5KKUVOweaPn2Iljb8TVtp+fIT7dTxrYjXQdvlMY/Eyoowu91IbvTzare6Y/jLyjsQZl2
 K8+++yMjqIhk8nJ9hBLQyF6W8rZ/RoUbdelZK26Xg==
X-Received: by 2002:a05:6000:1ac7:b0:43c:ff58:35c2 with SMTP id
 ffacd0b85a97d-43fe3dc5eaemr41742212f8f.20.1776938595797; 
 Thu, 23 Apr 2026 03:03:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/59] MAINTAINERS: Remove Huai-Cheng Kuo
Date: Thu, 23 Apr 2026 11:02:11 +0100
Message-ID: <20260423100229.2941820-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Huai-Cheng Kuo has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes "PCIE DOE" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-11-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index db29b267ee..38958254be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2161,8 +2161,7 @@ F: docs/specs/*pci*
 F: docs/system/sriov.rst
 
 PCIE DOE
-M: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
-S: Supported
+S: Orphan
 F: include/hw/pci/pcie_doe.h
 F: hw/pci/pcie_doe.c
 
-- 
2.43.0


