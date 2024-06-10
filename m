Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8085C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGhoG-000461-NC; Mon, 10 Jun 2024 12:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoE-00044n-KH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:51 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGhoC-0005l5-4K
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:23:50 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52bc274f438so177369e87.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718036626; x=1718641426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/dekw1Nq/R1iKuokZ48Fce0bxwVPPxY2BoQfPyzI3c4=;
 b=fOBfi8B7GXoFWoHSywI7b3jCkXMTdpEsZib6V+vwXdB7/8BotbGb8qHU7oNe1aXwIV
 XWux1YIA5DiK1RukgpP7VceXuaGKwZp6/m4eyNxOPr0YV8LLsCRP6PVnsM+tPOEWj/I2
 QRmbjtv5SDHFU+M9oQkaRepumMDY458eRNFnxJIqI5AhQM/s5ASyc+PNoKYm4o9TjGQP
 TjxLn4LWUOIZn+k3o2fHX9u/bD6BxvoObGUZiknJ/dBeauO2OiBc/RQfj+zXlpJ03bAZ
 CT4hRTYV4/Ii+wLB0b1K8FTHUh9XSUSvVEIWbnl/l39TT8QVA3APnQaL0ujj1B7aWQWa
 W0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718036626; x=1718641426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/dekw1Nq/R1iKuokZ48Fce0bxwVPPxY2BoQfPyzI3c4=;
 b=h+2Hw6IskL/O57q7cNX/sboutCI0u7NQcKKmgEKcczEH8QTVmCGnIK1Mb+u1A5Rwfq
 Ad4uKQbW43iGWG7zogZTalFZZ8YlnP0qZkTzRg12tBYO9/MfPmkgsJNtTZbcgDmoSR6g
 KFmeyVJhSV/IIw3R8/te8xiF0TjbdiH5mq/9j44SmeZ9tQdOsrK7644CuTd5dpMvi3W9
 LFqyGKnbq14JLL9DpNCswrxAZVo+3fZufWDAM63H+iCGFZeW6QonpWZoOso7R0ClGSvL
 Vx2wybTZ5YEQcThk2MG7fa30bTnUezJ7sS5/b++PTHgQCAnt9gF/ia7PPoXf1nuQQ23q
 jxlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXE9cygrEmGrROotS6v942PPrzRVvg5W14ZKdJujA8FpJAznnapgTRU/vlkmeXfKMzFQGeUWyhZAQpVW4YgN4GsWbhOXU=
X-Gm-Message-State: AOJu0YwE5WodCMbHqYELzY/4PWJGBKQJLjnDMS0mehahTTYj2gp80iuk
 RbdXp1vjm73im0iJ/+Vw3SToCI6wyI//7PMtD5667Z52kdhLbO1WaTZUqY2cQ0PUmG1/wyf6dlb
 d
X-Google-Smtp-Source: AGHT+IFMorInLOkOU2BqStyAM16G7RmKstTI7hMP72+Z+W5RbUbNqdb4zq/esOI+cE+Gz1Clq2CoCA==
X-Received: by 2002:a19:641a:0:b0:516:cc2d:f6a1 with SMTP id
 2adb3069b0e04-52bb9fc572cmr5544207e87.51.1718036626155; 
 Mon, 10 Jun 2024 09:23:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a6225sm147250405e9.25.2024.06.10.09.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 09:23:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] hw/arm/virt: Add serial aliases in DTB
Date: Mon, 10 Jun 2024 17:23:41 +0100
Message-Id: <20240610162343.2131524-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610162343.2131524-1-peter.maydell@linaro.org>
References: <20240610162343.2131524-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If there is more than one UART in the DTB, then there is no guarantee
on which order a guest is supposed to initialise them.  The standard
solution to this is "serialN" entries in the "/aliases" node of the
dtb which give the nodename of the UARTs.

At the moment we only have two UARTs in the DTB when one is for
the Secure world and one for the Non-Secure world, so this isn't
really a problem. However if we want to add a second NS UART we'll
need the aliases to ensure guests pick the right one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3c93c0c0a61..0c1dab67c00 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -284,6 +284,8 @@ static void create_fdt(VirtMachineState *vms)
         }
     }
 
+    qemu_fdt_add_subnode(fdt, "/aliases");
+
     /* Clock node, for the benefit of the UART. The kernel device tree
      * binding documentation claims the PL011 node clock properties are
      * optional but in practice if you omit them the kernel refuses to
@@ -939,7 +941,9 @@ static void create_uart(const VirtMachineState *vms, int uart,
 
     if (uart == VIRT_UART) {
         qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", nodename);
     } else {
+        qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial1", nodename);
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(ms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(ms->fdt, nodename, "secure-status", "okay");
-- 
2.34.1


