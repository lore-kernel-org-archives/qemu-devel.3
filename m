Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2094F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqua-0007Tf-8u; Thu, 23 Apr 2026 06:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu4-0006Yq-JG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:30 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu0-0002JZ-VV
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:23 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7badbd7dso3191574f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938597; x=1777543397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCqkL9qseS61pwBSKDOrgWFMZpXLjKncnUqxjIl4M3M=;
 b=Y5sBWTysnD//a5oECssWIbRLQ7+dCOnb5m6zb+fGmQx74XjeXT4TQ9Lgy53PsObAOc
 xMTICCtJ9U9DDEEshBbR07YK1Hee/McPZ5Wahxw3AM422j7S630/AikHpiu5zdGtKNvZ
 knBW5xahrfrrW67YvrkoSA+abA1FDOQuy+/EKqXYzyn+ebYuoFkn8WwdOPdif0ab9Fag
 eyCvRAhdT0LTX3+3mo6ivQEZPhMzt9dQ5G4klZYWBpWAnLlZAFHLF3S7ATF4k9NBIPgj
 iYd76O1iWWnzkJc144dt2hMLon6dD1d74JUT9cBPLHibiAQenCQt1lvb6wPmCV3D6BrA
 Z0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938597; x=1777543397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FCqkL9qseS61pwBSKDOrgWFMZpXLjKncnUqxjIl4M3M=;
 b=lcbJRYLvT0AV6/uOlft8qZ18WOiJeZnk4aG6gUZyMtJWOGgVHYqTIVfC1Z2zWp1ayA
 IfzZjMAIbaC8eVSOlJ0wBhvVhrA00XEaz3S+KW96A2u/yqJPtO4jwTZZb9wPLxlUb4Le
 X1P1OSuRLielLZrJKWSFYkeyPWsWzH9TaNZMYpo60F87ieUlpnSYRABjtU6fWRaK5URz
 ujcX0h2UHJtBIfRCDEvVJIshGTTTmB+zqBQA7q7WvFV2GEIqGKIAFNceSeCNyQQE3O3b
 yZCUW4QCLrbICALD5M/+4cgA3G7Mj/ubq5cZd7tPuEe1Dggl72KdrNzRgNkgwk1wFTS7
 VFWg==
X-Gm-Message-State: AOJu0YycZk553c5cBwqUwu5JG/agV6y95D5X6QCyWQ3SVGDiT+HDTOy+
 wzpN6lMu80fwc/juanIjoI4duF1CCrjbs1jktGGhWIgTD1u2+uZNmhhRauywT6xM4o59OT38PlN
 iw583
X-Gm-Gg: AeBDievFCEjf+Jc3trBCWom08LW47sDVXzsM68RMsqB4j+Zt5Vti0poPGetUyqhOKNm
 t9bUQV8/Am4u4zl7jxNzHbH6aBSoHks98oMQBRLkjSku+4FjU7BSD3VyGxgf8Cko59SL4fg+0ii
 Sw67Mnt+QnnZAoa4NUIWrBu/iHCKIl/9QxJ2Ov6UAS/BBGt8xMpatFiV5wXg31/9h0kax+O6zdM
 Eyaq+FlR4jxX/zYf/k5AveUdQ9BtN4j/o2V43yrfHFD/aDAE/3f8iSkE6zOjx0CGfZq5mpFUvqB
 XkhwpYG/BFZROqkkvQaBMfDLstclylk3y2Yv+Sdi+ROFS+zuozEmd18k47lMDJf/hzk5/2Zwkcm
 M0qZA37bdaDaaSQwgwJekjKDRlzmQxjrfNKw5y8bE+ZgS+35mw/9yA95X+JmLx8EpGn+wg5RegI
 HoGUp1vXlfC92Hj79yJIJNG+efRuzYsIA82707tMYH7VIsCYN6KApMrSQopghlEESgkEUldbApZ
 2l+D62lMdmIDUNK+PSeAcCPg/1jg9SslW4E3CHoEARinqPBqpE6
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-4411c18f7c5mr21542053f8f.37.1776938596805; 
 Thu, 23 Apr 2026 03:03:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/59] MAINTAINERS: Remove Bastian Koppelmann
Date: Thu, 23 Apr 2026 11:02:12 +0100
Message-ID: <20260423100229.2941820-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Bastian Koppelmann has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the Tricore TCG CPUs orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-12-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38958254be..11ae4829fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,8 +447,7 @@ F: include/hw/xtensa/xtensa-isa.h
 F: configs/devices/xtensa*/default.mak
 
 TriCore TCG CPUs
-M: Bastian Koppelmann <kbastian@rumtueddeln.de>
-S: Odd Fixes
+S: Orphan
 F: target/tricore/
 F: hw/tricore/
 F: include/hw/tricore/
-- 
2.43.0


