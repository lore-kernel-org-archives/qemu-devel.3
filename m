Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AE9CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIktv-0003uU-1w; Fri, 01 May 2026 06:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktt-0003ty-0M
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktr-0008FX-9A
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:12 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so18444295e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630510; x=1778235310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KeBNe4wyqrjV7VPSNCuKtnzVllsWaRV++aujRpEZVKs=;
 b=ccIKruR5n9VWjoLLyTa4rHLQUXRQCKHtcxxWTKpaah8BMrDbMhHLTyZSqH1deHcuvf
 i/b/cVIeQmuogkv/qRELPfq55cA0mMJTZU9p2V2XAtquq7/TRpphD9j2Wc4xVZFa2eN9
 KSQO0K81803X6j3nMHqOVnOZXD0fS/yAg/KQecsfMkXzTGIMoAVegZbai5RAHhi//yzJ
 gEb5Or8NmT+2s3hSE8LAlBZOakqmE0UdgjVKiUyqacjWkBVO1arxakH+Py+izvTPPmXL
 rAr/hvjZjXmIAHbpo+7qGTu1zx0HUtQ7o2Sy3rNdSJHK94PISXLNIx8nc3H35jG9KY/8
 NY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630510; x=1778235310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KeBNe4wyqrjV7VPSNCuKtnzVllsWaRV++aujRpEZVKs=;
 b=jDRFcC9oj0nLM2QxHIjCp/fE0Y+HYjLVcpENqiWCDqtI6Z+O8oJs4jWm2kGjyn9KoO
 2n7KVAdb0NTK2mLghtMBJqx/kHV/8dI1/7MZsJlsE9jOJ7naA7s/fY354KTpn9debd2x
 3mp0X6wKBC7OhqYYzIrJ6h9ww/NbcD3pfDf2AB1Z4HHu9ZLrpkXoNQv72GlJC1p6zoEK
 sC0LGU/3NoneQnNh3h7BrvhE22sweAS2P0sxyCOPmng9Nf889x9Fp0R5oWKGOVkkKa5m
 Xp5S4lqMAaAHe31vIi7GHTOQeoFPqEUzL1m8RtCAn0E5TEH9B8b0sEMlzzIQgPu1SpDN
 u0DQ==
X-Gm-Message-State: AOJu0YwE8mea/M9QWLe/voAPgSlITzAFncQ1VRXsVnOMzI/QaaeaskW2
 a3/C2d91ZPjd72KZudvPVJYk2hlZpj8fXWwFzgMWepEwfBkbghpzNiF04kaUbd/qVYysL7tqD4g
 ncvn6
X-Gm-Gg: AeBDiestKXKwk5TBG9ukOeL9718CmYJ+r7p6L8wmo7b5XH3Ho7ytmMHOmKMIiYAW7gC
 acXfKmgoUIQUtQ3l3Q51AfLj1fyfs7itR+UES5ZOESXhQSGAtrht2ruVkgdYqyfH6o2cGwv7LOU
 RGypl34g1eK9a3CHZUxuQe73POoOU39MWioVIxHpS/5IBzHJBje0GXsmgBIb7e6SQ/53cupn6wH
 DvX/NAElm+SeYhQcApT0TStwXRCJKaimoOYKXhb7FnNfEin1hZbm9as+ckKW74z+KsfqkLUeeKD
 biJtrGEiZFxj7BNNOBrkoJzxN4DepJ3CwEC502n2W55O4N5ZAvdUaF6Cff83Lhhu8JrbuMixf6L
 Dwo+oDBcRzgvcb4kJcCqkyFFHNjxK5YxgrDIuGZCoM+zYDocbysdzzfud+ci7Vv9g7RU7Q/mtjH
 Xkumg22Ia/lGgN2NPkBmKP5zqXhNgcU8CgVPoXk0L1RuaLpOzFe3dQo3J1iuW7JmHe5pe0NIyfy
 HkRM4/hJQp++Swx4rzNAxohqyMH+iSHBGxeq/3aYQ==
X-Received: by 2002:a05:600c:8b70:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48a8eb88365mr34690405e9.18.1777630509734; 
 Fri, 01 May 2026 03:15:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/28] hw/arm/fsl-imx8mp: Fix parent of ocram memory region
Date: Fri,  1 May 2026 11:14:39 +0100
Message-ID: <20260501101505.3485916-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Rather than having a NULL parent, let the containing SoC object be the
parent. This cleans up the QOM composition tree a bit.

Fixes: 1aaf3478684f ("hw/arm/fsl-imx8mp: Add on-chip RAM")
cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20260308203516.160103-3-shentey@gmail.com

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index 33749d7fe1..7c03ed3c34 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -670,7 +670,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
                     fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
 
     /* On-Chip RAM */
-    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mp.ocram",
+    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram",
                                 fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].size,
                                 errp)) {
         return;
-- 
2.43.0


