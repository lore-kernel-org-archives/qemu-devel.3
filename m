Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E56C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL7n-00026w-Dc; Mon, 31 Mar 2025 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7c-00024t-Mb
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:41 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7b-0003JV-5w
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3996af42857so3830181f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450513; x=1744055313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNjcGIacRf9GBqLFNdn+7xavPFEAK8T6dq58lm39+Ws=;
 b=M2xNUzbSu0FvvI1HotFgjhngGSxgG/BhMZ38L2PAPG7JANMnGL3eVyz3xBUj8CRz1z
 uXWZz55jp43PH2PY8sk/RjabNsACyIBOivbqYxe+Ftq0p+v5fV6f04Q6P9MiRVArda77
 MFHpSr/Wm5QQ7I32SxEk7p84zRwaR1PilN0rPKRtj5odMDDc40oRSDzd89JDc1KD8gSR
 nUW820I64yLXReYByoXcBHQLX2IS1FPKi9SVIAxjg8WUA1UdKIR8fSNdi8W94H2jFWE/
 /7i7cNwkKypDn72qAwvEKYBWq+r1DJjlj0q0S+HOu6xtewExyiy+meKi4lqMEATP0r+9
 pTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450513; x=1744055313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNjcGIacRf9GBqLFNdn+7xavPFEAK8T6dq58lm39+Ws=;
 b=c/cOvU0Wt2PA7GyPG2M8r5b2L+xFgwYkpt6/c7/6pai67Yzmy8ZaMjU6lMpLHyNGUj
 XAYwIL9q+hgTGrp/uIYqsWEGGzTr8giNUGuWgZvts7HZh+ro2s1CXGb+gEDc4vkj50FV
 u3V/exmU1uGugRdAU38RoxBg9dZjbzOB06kLv3GMbjXVt0P4+Rxq8XTi6Nu6kAKou4/C
 NXBZN9IoU1sQrXXtVpjYPizqRIPNYKGhGUKDZEhLHmwcktHINoNh0obq/mzAEufpLOb2
 n8fNbsVD7EDy8RDggTxzVjF07NhZt+4PMYZdIohvMWJDA/M7ZDF/LyD39w8fZnIigHuI
 BkWQ==
X-Gm-Message-State: AOJu0Yx3P6ZqvEHNCcJnIzM4XcEISH0AXP68SwCpUv5k92blbOA0Eiod
 7HDLrd6awzoMCWmFsqzh2gCb+SVTjAX9VyU/n/7qglCmQYd/u0EtdDw6IOae9yjJdQhtWSZfnlU
 z
X-Gm-Gg: ASbGncvIdbek7d+PA1pDiLSOr8blt4CDun/1WzMeE9rNj/K7GTYhRcgdNa/OyfFUFPt
 cWnGsBF264NYH81ahQOOi0SESA245vL+ZBm7siQQa8iMCcZoG6s1QDO6N+L0uV8cGE7txjSIaD+
 Bwzt/2/GUaNBOb0G3nbYog54ZINEbkojGZtEV9ooWlYlnnN9hhOJ7kuFfeqGxHiyCdLOMgbZLD8
 pPej3bPIOrAJTGYjPb9zYW/rq9LVD+0DwpG1ldTpavxolH0ltqn/CF7lEktgK++d1hK2l2pGM5X
 MWTFkFfaxR2eY3PAB4WJAs5438Scs85F86MXNcf1EIQfXLxDT/8ysmk6jeiFhhW3OI8QWLgNWLi
 kc19woqilZg5MrHtXGQk=
X-Google-Smtp-Source: AGHT+IH8DOsqdvvORZihplizucZpE8iA82IR3GrQ6/4R3B5Vvg8JHB+fn9qgoEFNE8K5nB7yhbv5EA==
X-Received: by 2002:a05:6000:4010:b0:38d:df15:2770 with SMTP id
 ffacd0b85a97d-39c0beb9889mr11670908f8f.0.1743450513334; 
 Mon, 31 Mar 2025 12:48:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d90000a09sm130314525e9.35.2025.03.31.12.48.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/23] hw/arm/imx8mp-evk: Fix reference count of SoC object
Date: Mon, 31 Mar 2025 21:48:00 +0200
Message-ID: <20250331194822.77309-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

TYPE_FSL_IMX8MP is created using object_new(), so must be realized with
qdev_realize_and_unref() to keep the reference counting intact.

Fixes: a4eefc69b237 "hw/arm: Add i.MX 8M Plus EVK board"
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20250318205709.28862-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/imx8mp-evk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index e1a7892fd7c..e1a21e52f96 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    qdev_realize_and_unref(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
-- 
2.47.1


