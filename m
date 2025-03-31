Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C47AC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL86-0002AM-FS; Mon, 31 Mar 2025 15:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7n-00026x-78
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7l-0003Kf-JY
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso4633185f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450523; x=1744055323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=olSuf49HOKgWluGh/CcNrZxy5tYywYETl9l4VOkHGws=;
 b=BZG4ra6KII1jo24pbEZqJQxCTqLSAkFDboQFu/jMNrKQdyYz1bY+F905n5K5H3eg76
 2xa75c/0iBoBRV7tfUtgkKYqdcJSCBK0O4Dtaidx8aAFiu8hvIv/Eb67R6gYXGW/p7cN
 5T49WIolyBjzKrKHLFGHeg617MMakgkcVRCK69J7s/32wSv+wEANaNMd1rDUKDGA+vsn
 9mYJzXt1wNBR2Mdhdy9a0pveIxpGJzIQl8JYe/pAJnocYVvBbky3tdcPyMASnhHrccb4
 bh3vOQMQjRC2YuJAy3VvgxMYl2c6AGsaQRZAPfUUzSCoE1FoUQulGAaqmWd6Ye8YLxSj
 b55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450523; x=1744055323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=olSuf49HOKgWluGh/CcNrZxy5tYywYETl9l4VOkHGws=;
 b=vKPFI0tMFG+Gt92MSyD39gBqH0gv93vBCjtC2EXMX1LRxCX7siQnC0bgNUiZYUVa+r
 YLPx6S9JCtiH+Q6nsfZ4hLlnqWdSLoClGFBb+R5lFjAlFlZXyAi3Qo/5BugpLOwDQbKM
 qEFGk5uuqCWJPYFJKtHRI0PvBA7Ek1PX1N8fsexw0OcK1bHD1nt8SLSOcGXDzGCU644E
 rtbJlxoHNswVrVAw7Au7cvmu3YV5BigdU6TKsAYlVV/00GtDzn93Ni4rNgFYiYXSptJn
 OW/zabzdXmyAc8w0gXqbsvX/7q8dxuUckd/6TPA9VJ3+TgRiEb881Q7xMSgUd6VHAVAT
 Qa0w==
X-Gm-Message-State: AOJu0YxazgK7heAc+C/60adxHHblloXCnZ5YSTpkNWmOtOpquknoM8wM
 ZX6cnd5D0FSdmQ0WeGo02V2MDBcQziyLL7aAMzX1S+FcxFlYXCOK/ARFy9iXRBUwhlodJHP/vSB
 a
X-Gm-Gg: ASbGncu2fiQYvyqmBHxYMTKIgYCYiwBilHDsUXi0iTH3LVFCStKSHtQoWPH5T55KtFq
 AhVXs41r79+AVgzYoNqQnoPDFU3ms63qjxDdWBmskP37rjshwyS7czJ8uWCz1KrntjgsGyobWRB
 iA/t71jof+Y+4NQczCmDV2i9s7+G2JUaba34mBwxA8zM2O6KMpyfair4zWPWBfAaPws6DUN+PGV
 vrX8NpkH8uR13UR6+GgBf2crSgiyWEUHaEw8n1rt6/yiOlh+T0aPFFdP3IJCynuw3VEQeYUKIMN
 z2MtcQ30SLFnkCxMkvWdGuFU48t9xRKNPnYF9RjzYoGCrbNrPmwLll1sALsdfup7O83uznL4/0g
 OKSKLUPs8qhpTw1dL8wI=
X-Google-Smtp-Source: AGHT+IGG/p026A+pp4CuCPrCx9hvQDo9+5DHkccNfbad6DV9/dcmslrB7TW3N9ck8Pi90/PY0ocwAA==
X-Received: by 2002:a5d:59a6:0:b0:39c:dfa:c92a with SMTP id
 ffacd0b85a97d-39c12118ddfmr8037838f8f.36.1743450523490; 
 Mon, 31 Mar 2025 12:48:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c1845e66esm6049263f8f.18.2025.03.31.12.48.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/23] hw/arm/fsl-imx8mp: Remove unused define
Date: Mon, 31 Mar 2025 21:48:02 +0200
Message-ID: <20250331194822.77309-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The SoC has three SPI controllers, not four.
Remove the extra define of an SPI IRQ.

Fixes: 06908a84f036 "hw/arm/fsl-imx8mp: Add SPI controllers"
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250318205709.28862-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx8mp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index 22fdc0d67c2..d016f7d3371 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -238,7 +238,6 @@ enum FslImx8mpIrqs {
     FSL_IMX8MP_ECSPI1_IRQ   = 31,
     FSL_IMX8MP_ECSPI2_IRQ   = 32,
     FSL_IMX8MP_ECSPI3_IRQ   = 33,
-    FSL_IMX8MP_ECSPI4_IRQ   = 34,
 
     FSL_IMX8MP_I2C1_IRQ     = 35,
     FSL_IMX8MP_I2C2_IRQ     = 36,
-- 
2.47.1


