Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0A1D49219
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1A7-0003JX-K5; Mon, 18 Nov 2024 07:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1A3-0003CF-1X
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:23 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD1A1-0005P0-Jn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:22 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-382423f4082so929280f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934040; x=1732538840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57xyOJgb7MrtuQp8S+1k7r8lU95GPrcuInZY97Vgr3w=;
 b=puz44dusnzUY4XWwEPc+Kz9e9ANwZ96rSmdjDJn5pSjG+JGPgscD7ICkeSGALgrlaK
 H7Ydl/0M+QgUJTDXK/QplIbJ+pwC6TROJk5z6QBphJSlJbBTpVuwNzJSb2ZA6oB4LeCB
 Z55xk6AHnAtFZyMbXywH+nBq9CEVfAc3jNMbWKPh2naUKWwH8Ids11IyXtLuz4SiiEsj
 p5qtb2cTeUGXkM5zxXmlcRcPlRPyTJEbnNxHL2sIWY/xph8fTZeyEuWYyQWMCll4kJOp
 XCSeM3Bn5qdfte6na/XwqTJH+uQj+Yu6FTL88kN32/Ndn9+N5FgtEDXN23pgnaNymLcd
 t5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934040; x=1732538840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57xyOJgb7MrtuQp8S+1k7r8lU95GPrcuInZY97Vgr3w=;
 b=rtz2wzAcWdBSyoiPYMv8o3UJCej27l8Po+V8xZ84Bab30QGV9KhrErkun16HuVxudI
 ZZyGoE1Brd8TR7wChXOFKG9TW6gxoHfNPucwPGv93z4V1qE2HhiyyoehphxmXygXq9LC
 6Yx7LpfrBvxEhr8qCHIxS6o5c2SlwvbyHsDKuPAdrUx6yp6Hq+cLKd8AJWPNKs8klwbS
 v9zb6Lb2t5Q1blcMmKB665UMgb7yD+VDspRq4XBk1kJUiNiNKYSUoj3xrUO6dI4HlYtk
 HiN4Zh/yM5b14TVbj4C0bYiAeaJWiplemQpai4zOsRiWIcNy7ZWMbRJ4b76+c58g53uG
 23yA==
X-Gm-Message-State: AOJu0Yz0aXIncL33aLAH1kbYFiOFdp/oYuULiJNLbA6Rr50Z1ZLqLUsm
 ONmICPtCL+Fy7bo5ycMn0E/ouxc8gtHvg/ZMTMb6F3bDRATMIyzRsg3w/csRi8Rh0VpnRDxHjAN
 V
X-Google-Smtp-Source: AGHT+IF3DUWa/uhuUCxyLTGnGr3Zxfm5V3YNEHF1T9vlk1op3xVZ5SkkFXBwGVmUowjQNReEJCXDzA==
X-Received: by 2002:a5d:47ab:0:b0:382:3789:191c with SMTP id
 ffacd0b85a97d-38237891a14mr6122659f8f.7.1731934039822; 
 Mon, 18 Nov 2024 04:47:19 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3822e65cbdasm9119775f8f.7.2024.11.18.04.47.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/15] MAINTAINERS: Update my email address for COLO
Date: Mon, 18 Nov 2024 13:46:33 +0100
Message-ID: <20241118124643.6958-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
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

From: Zhang Chen <chen.zhang@intel.com>

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20241112084038.6352-1-chen.zhang@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..3f10529d9c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3559,7 +3559,7 @@ F: include/migration/failover.h
 F: docs/COLO-FT.txt
 
 COLO Proxy
-M: Zhang Chen <chen.zhang@intel.com>
+M: Zhang Chen <zhangckid@gmail.com>
 M: Li Zhijian <lizhijian@fujitsu.com>
 S: Supported
 F: docs/colo-proxy.txt
-- 
2.45.2


