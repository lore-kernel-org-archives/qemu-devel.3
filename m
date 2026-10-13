Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9111CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8l-0008Si-N6; Tue, 13 Oct 2026 04:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4V-0001XW-Vl
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4U-0008Gs-4m
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so20444575e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880876; x=1792485676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HEpQd9AvFwO8uwPIw2G7NA2tUj48bKXTa16by3JaLzo=;
 b=HHQF9G9cUlVbED3dOFPvl5Jd0ZwOMhynCkqr57Phiwtf2WxyI3o3jC5TSCV/OksDVX
 G04w4XB+ZT6zHZx1KUxDBxVAFyPJ977OdtNx1xWRlRNWpQYWCRHckPY2n1UykUaMZzP0
 6/GB7Kggcvj8Na/HAPQ6l4r2okQ1mCgOQMMS2iittZK6n4D/vPKKHM15m2FqMhKaM0oq
 52WAuT3iHclpvdPFnyqJ7DRivFubjPOjGs9mPegP6oXkQsWqUEX/M2YkeagqZLBwqCLg
 J0cIpUFBlhhnM2KXVUgk/5ThS7qyUdGio0qnKxbr3vLPI4ofgDTO9CUIMZVyA5NhUnzT
 YdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880876; x=1792485676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HEpQd9AvFwO8uwPIw2G7NA2tUj48bKXTa16by3JaLzo=;
 b=KkVxJdngPEJGIN0onIO1kaWT90iTFY8jKbzwnVtvb8f4yikFAW1bXjCma+CqTeBXGG
 DuH8ksBing3NY4F+Hni9TYOi8LdB+Fy2IbSz+MHqLwQARgzTeim1+b2DNl87LisCFQtD
 pGc1broctP2NqQMCkxnBq8KaiVri8YeRUeSCJVJmQfAnci6fIyHB3SdHoO0dOBYWFtf7
 wqTSIEDi4wGCYPoZf0oXJaZwgJOGP6sBydUgaFDxm2u1aVxw8ZZUAzWUSX70bLQV41T5
 jT6CcszMS7G0hpE2wZQDco9zmw9IXBCSWax0RwwLsCFSrhXE8DSe/183IzgQNRBe8CVH
 WrCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwF0TXStOd/5pIrzf3fMfWZkvgi7G74MEqhmzuSBF76zwLwfh7lIiBsm3iUO4gkkE1QKEVmlVz2I4Pg@nongnu.org
X-Gm-Message-State: AFq9FYIsarWFAcch8jHPh/5IY20F7zhvnA4Ue+RzoAW7YTu5I+G32LJ2
 ZiFmihXmQ2IfD50YSIYPnfD2oNpLtIA679pChsaRQt9sHEFZFCqXE0PkoERg5oH9Gkq9TnYYNVO
 Cb4NQpBQ=
X-Gm-Gg: AYBFou0MNnN4y/MAXDjNhWXTnkjBLFtli/O7cks2gfOJdP+ZRWKnh9/2hVk3mt3vN00
 Ia4x2MXa3W2QG6ubG0tbAFLBrucui3sFe9X2JA9OMKQBKVfdfrVs+9pvb1d5GHoq+wyOjAhkzTg
 OErwjqSYvFlfb/2z6Z6leWj4IBuYR+ZfohNF4+mlSSANK3/9xeiewn3Q7T1Mhh8vLWMN8bDvy9v
 yFWBcp57OVvtffevAa7dx4nlV9sYd7FDlLGBSzcVzjUgt2Rd+81KagJpHR2pqdRjNikx7dTjoRP
 q9No1Xo+KNW0EFCNvN5v2T1Gg5HlS97hG7i+2Hx3PnaafQdwI92xPMbG2rNk4WRwZ5ogL/1hbN2
 0qbAA/H0rkXjSKfdQgOVBwiM2Um6FXr2PEkKUBFJ8WmkoZz48gRVA0gNfBvQ0yhssf9qXiLXAOZ
 zYUTsRWVOYSZTs57ul5sCCSY6EX5XM9Q2wAlIaAn7QduacIZ/NW7dZQYX2AlHSr5PyZ/sTbT7TO
 pM7aqfy4KHcxjQjrvA8zqA5rDDRDcHMby/lvdo/0OeMb60reYoECXqVLkvagb21fDHTfM86kq86
 nhgMj9BSv+gvkA==
X-Received: by 2002:a05:600c:4ecb:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4a18e4adcd0mr233780555e9.15.1791880876648; 
 Tue, 13 Oct 2026 01:41:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 79/86] hw/intc/arm_gicv5: Add virtual support to
 gicv5_get_hppi()
Date: Tue, 13 Oct 2026 09:39:26 +0100
Message-ID: <20261013083933.1024405-80-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

If a CPU asks for the virtual HPPI for its resident VPE, return it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 199547abaed..ab0cd1d80e5 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -348,11 +348,13 @@ GICv5PendingIrq gicv5_get_hppi(GICv5Common *cs, GICv5Domain domain,
     assert(cpuidx < cs->num_cpus);
 
     if (virtual) {
-        /*
-         * Until we implement virtualization there is never
-         * an available virtual HPPI candidate.
-         */
-         return GICV5_PENDING_IRQ_NONE;
+        VPE *vpe = s->res_vpe[cpuidx];
+
+        if (!vpe || vpe->vmte->domain != domain) {
+            return GICV5_PENDING_IRQ_NONE;
+        }
+
+        return vpe->vhppi;
     }
     return s->hppi[domain][cpuidx];
 }
-- 
2.43.0


