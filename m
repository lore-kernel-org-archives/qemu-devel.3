Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DC9F8A149
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIqd-0005Es-5i; Thu, 16 Apr 2026 05:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqL-00059X-UO
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqJ-0007ja-8R
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:00 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so3097385e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331017; x=1776935817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FZEjNUcnZ9Wu4qIaQufKgxNKsKv9uju/CtGEKuVbwc4=;
 b=xUPSxI19UdMRKWGkuiPLXAOB4K7y7ZcgSH2pvBqkiYAHAD3bpUylUscaqgF8BpE+wc
 UOpJVZs5oqUXUwOI6S1utruAWlK9qDWOPToa4rFup5YPRUDws/vKqK7PgNPtlDf8WUvL
 DwurgA0huVJLwZv2SRLy7fTyf9CzcrCo1129gBuR9wjx8CiphZBqtwPOH/HfkGtdrVo5
 /JuC9gsJZ41KPSpGPnW/cpgqTj7AyawBbACtj3c86ua7uc88bj1QFY9jlaed1EeVk4/8
 46V9/Rb+5AArJEGVfZcOoaAscCjs8saM3N0bVsL1tNHVnkDO//nokQfZ5mMCcGPbB+E8
 tfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331017; x=1776935817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FZEjNUcnZ9Wu4qIaQufKgxNKsKv9uju/CtGEKuVbwc4=;
 b=Gh8XzV17iKtqWMObhfqA1sIb1Qjbr1m6wOaEqcNYrU0MaNmJum2OccTPLIA4F6BzvG
 YxuoHpPYXOsOLvZzXkpZUDdFT5FEWZ3qLMjEtzb3Ji5Wj78k8Et61EmiJQUXNPJ5xWZz
 n5QO5vvT58v2/GUNE1bURAnpbIZLU0l0TYGGIAGtnRWLYfmkRRhrauRlI6tYbP1THD2s
 8tGXi3Z4YpoaV16CWCHsBAfh39s+EwL2x/r5xxYsbIe9ZHvQiBRsVGIVi9ocJSb0bscy
 FrNVqM9/586TdRlB291Nj1wHFmX6Gor+QlcfDROdoPrRdN1qNTGE19WF3shp+oAJAejq
 2ZEw==
X-Gm-Message-State: AOJu0YyJDE3HmS1cWabAbOljmBLVmqhGKWZDk2gVIXUpKCQxD2jirw4T
 L3Q7stKTql4WWBm0mmZUf4qskX4yz3C+q5kPoKSObmTaDOWDmI75mHdOoA5X9K+BBu/dJ/JID7+
 TtBqHiPc=
X-Gm-Gg: AeBDietWoZhGWwGRkTBk06zdG2kJJWOrDpaEC33dVnP64vspE6Asyz8CQzcSKQhDBZ+
 O6UQa4DRI1xQWY2JX6DXGk0SLT+qLB+p6XElJRvUymteIvPEbcDlwGPqpdWXlUlDkxa3pO13K3O
 RXo0+jMm9PkPWrPPRlamAYLM0kvB14kKfqcVhUIaW4iJHDva3QS/gdgxtyVykAzwdpHwnXtZEyI
 RpatAJ8k1YQ9joWYKrf6p2YqwE3oyJ82UtqHQjWf9GHbEHpvwSawQoaA9gAJfttOI6r4J1EKIut
 YI5ftBPpOMhAk8z33zSyziqObHHe/duBOu1gvwylM+xuBEW/9uPKiL+w/ui0y0Drjf1pY8hnONN
 Do9nM9uss3Gf/ybFy3F70T575v33giyEeuvnl3UJZz4KD1m8eetsjowdVlEqavkfYLNOGU7W/Z3
 SG6NZlJugGeX4B78SR3Sqz7BW2NxBgENGY84SEEAyokIK3fhaHgo7xxonH2crkL1U1Tz1xEKLGq
 +y65aDuXyk8sOwtRe76k3eLwUq0RuqYkcgd/+pMUA==
X-Received: by 2002:a05:600c:4a1a:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-488f480c640mr21864985e9.12.1776331017344; 
 Thu, 16 Apr 2026 02:16:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.16.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:16:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/28] MAINTAINERS: Remove Ahmed Karaman
Date: Thu, 16 Apr 2026 10:16:27 +0100
Message-ID: <20260416091654.316158-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Ahmed Karaman has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "Performance Tools and Tests" orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..bcb9521d25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4633,8 +4633,7 @@ F: rust/wrapper.h
 Miscellaneous
 -------------
 Performance Tools and Tests
-M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
-S: Maintained
+S: Orphan
 F: scripts/performance/
 
 Code Coverage Tools
-- 
2.43.0


