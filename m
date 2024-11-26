Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D131BD6552E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyxi-0007mI-RC; Tue, 26 Nov 2024 12:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxg-0007kb-4f
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyxe-00026J-Fs
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:02:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso54060535e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732640569; x=1733245369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3W6K66990zHqezmpYgbBot+Izh9ypQHacNdBXiFdB4o=;
 b=gnP5jgIxO2RSHNd7l7/eZtHMyYFF8CEAxCzFSrSh3oFea5wJnKNZ2mye/1rHk8FCWJ
 Fnid4rr9MK/z1/wbYATzzzIoJQpzOzZvCe2ZLyhJir49ibNBH+yNldMOPPcLjl9GlhUb
 jAu+12+yGi26gfCa9xlsO/IU8vOByXEWBV+ljFCz+I/5pYhVRgTUvZ67skSjE1OXnYxQ
 kFYe4aGval+u2DRwsTmhpqH250qjn/YDI3aHl2j6vuF0peFkwk15TRZAGvmOmuv+apVX
 P4wTP/+f2KP+McjWLF10a5/SM6bQv3Ar7IhBYNqb5sul9Y+dOtI9mf0QZot0sNsfEYFW
 Kijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732640569; x=1733245369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3W6K66990zHqezmpYgbBot+Izh9ypQHacNdBXiFdB4o=;
 b=s9gHC9QcFQiSZqwzYpNv8fB1nfPYK/MEQ1IgvQKa4Sal8pjRDL4PIMGcoA30SA9piA
 wvmeAUCPdojYRlf2jTg1F745CaEMJYyYXXewNcAI1BTTdxEsdyVawzOwVjZwhzqcxzUI
 mDqHr6BcjGHoiOXfuEc9MR5Q2vAkktZyAL8jlgd8x2c9H/zHkgzE/LR0BLNWHyF8LTEE
 dpEycYndr+4F00RGZGujLyZGw+10u6KchiXBCoT1QKNgZTcOcCbkcZdedp45YDEs61U/
 5ldeFvae1fUi0Ot9vzA3yrSZr/ibopqKEIwjU5dfeh55bxhpfLb8jAAfoSl/csgxCaQ9
 Q2EQ==
X-Gm-Message-State: AOJu0YyVwEcnBCbL5kLDi/s0I0iuYb9QApZiJuNqnLiGC+1YMHUTPVD7
 +wwNKseIGXxshxHOOhgxtZQjZRvei3lIlHCID9H9MF2dL1XDKjhrD03/LX3E6dkedqkn1IUF5s7
 w
X-Gm-Gg: ASbGncvLuUT4sqhQndSQcXyEvMTXYfVmGuxa8JSgQ2xYReAOXgCrCGV0ibabUCDsg9x
 LIQPgA1t6FaUiODPxM6AYKzUIgUfpZ4SpmB2SfwCBSPRJtCw+e7kxMSz5eWChhS1v9U3Scj0UQw
 SxqctiIw6hYfN9SxpomJ2X4Xr/zDa+ZXQnbN0aQRvMzQumFWgt/FbR36jJtNruQWZTbPzIKWaRP
 a+mGnEDHOlpt52NbDW3oZML8QnNBJl67esdtd42X0M6NEGOwGjYlwV6
X-Google-Smtp-Source: AGHT+IGUDemz5XVmN+fyqFQlFY7k6S5TLIJq+LQJLzuS5Q0r03iELFdPmCO8x5D7ChfswpAsqSs/gw==
X-Received: by 2002:a05:600c:190d:b0:42b:af5a:109 with SMTP id
 5b1f17b1804b1-434a9de8bf7mr11115e9.24.1732640566892; 
 Tue, 26 Nov 2024 09:02:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a36c7a9fsm43017865e9.44.2024.11.26.09.02.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 09:02:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] docs/system/arm/aspeed: add missing model
 supermicrox11spi-bmc
Date: Tue, 26 Nov 2024 17:02:24 +0000
Message-Id: <20241126170224.2926917-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126170224.2926917-1-peter.maydell@linaro.org>
References: <20241126170224.2926917-1-peter.maydell@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Message-id: 20241122225049.1617774-13-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/aspeed.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 2e9ba12f7ae..d17fe7a4fc8 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -1,5 +1,5 @@
-Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``tiogapass-bmc``, ``tacoma-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
-========================================================================================================================================================================================================================================================================================================================================================================================================
+Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``tacoma-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
+==================================================================================================================================================================================================================================================================================================================================================================================================================================
 
 The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
 Aspeed evaluation boards. They are based on different releases of the
@@ -15,7 +15,8 @@ AST2400 SoC based machines :
 
 - ``palmetto-bmc``         OpenPOWER Palmetto POWER8 BMC
 - ``quanta-q71l-bmc``      OpenBMC Quanta BMC
-- ``supermicrox11-bmc``    Supermicro X11 BMC
+- ``supermicrox11-bmc``    Supermicro X11 BMC (ARM926EJ-S)
+- ``supermicrox11spi-bmc``    Supermicro X11 SPI BMC (ARM1176)
 
 AST2500 SoC based machines :
 
-- 
2.34.1


