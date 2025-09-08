Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36CF0CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvcik-0004c8-29; Mon, 08 Sep 2025 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvcii-0004bb-2V
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:19:48 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uvciV-0000hO-He
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:19:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3d44d734cabso3075706f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757341162; x=1757945962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ccrvKvMZOn56WMXboWclj1pPmiF/EWBGokbC7E5yq4=;
 b=k0z98hiR2kdGuvq201Pr+QYEUdOEiALlvSJzd/JxuO3Yw3pnl2Vzx/xF+59V0jZNfr
 NhPvJmXC4y04MtALUZyumDyf10jtQaerEfZlKNXnb/RklZYvy61xRhDyHG/60KiWP2JI
 hSP/hJ3raurZ2IeFGD7IUYeJ4D0zn+Xw2cbCSxhG2fysb6Xwmqa9cTt0E0KxHTV/AUf/
 RzGk0CYEB/FuD5uCxTemh2ZheBHoJqNG46PVrdGlFmwYjiBgCrk6DGyFwG5tAuxd0l4L
 TiU1YfKLD+oa7unwes7dyeWj4Yr8ID1iAI1gCxq7RV7AKNHaLOM9x+u0KWLgNpVtWb6L
 IEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757341162; x=1757945962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ccrvKvMZOn56WMXboWclj1pPmiF/EWBGokbC7E5yq4=;
 b=X/gnATEnxJlOA++7+AZyUYErLwpiftVrh8IWnE95OmT8kMd9+tYPtrmfLOQHJf/gtH
 XkfJFUxg+OBuNxlWZkdhaI4J513jK1zGmQ7wxaIXeSSqGU5GFXJtvphtP3s5PIYfWLxo
 qu0uo/6Lc8YclfNlM/41EqE6QLOWdwRtd0gnzy3VCRE5hFec/KoUsvUAx4p+swZquaTb
 ud3FUNVUIOjv49KF6LrNJBqhJHGgPnrkcJBp3/HVXb3TZGgCNMQQFYFX35S1jJrVcJyX
 GJuBfjUxLxfCHvbIbd+nQqT4vmq8XkT+CN+mwYYQ/w08Pfqd6puq+MgR5exsxwaQozBW
 GwFA==
X-Gm-Message-State: AOJu0YwwfJwA+eST2wTCuHjhadgEhy4HOMBhG7xI+iGkgmVYEWW2TLZb
 2MRydCp2aRTHu8EO4S7W0TJjQDSjaj/BpeJC4jFpO4ghF9vIWPWb1+TVZEf2DBiNTGU=
X-Gm-Gg: ASbGncv0Pi8OVrczsm8Cz2zflu+BmAjss2Q+BhZodi786hUev3yyuNwia4qYA4+gocN
 ouuPLdUPmiPWEBl5Cz24FLeMtgOkpT11o2Z9jVsZTdve5Ut3BjJfL/IMXI1X7kjD4oGhHUifARd
 vykZ2u8+ca9v7/3Tu0ToUonFNcoQGBmMEx4CInxx2xu6UyTic8LZwpSI1u1Y0HJuXuwMfJOfrAJ
 ijHPGQknzP8rpSyEGgBZQe4JNpGkPD2I68mSQB2WZRNvo70WJQZRiqMRAsI5N/a9Qx/yPLzeReb
 7Bg/25OM7pERIsooODApkifgqBbxECbVlcRghlf8Cr9wLnqpDPOVKOvXNspavPiq6AV1d4GsUaY
 D3VrEjSNdj1gDbZ4PCcHho5cOH+n27gEsGg==
X-Google-Smtp-Source: AGHT+IH6g5oQwdDnWSsgmvgyaAsU+JXeE5M6uI/sI/HRfhJHce7kkDx8WnOHvVuUQGdv+g/gPZxQcw==
X-Received: by 2002:a05:6000:178e:b0:3dc:33aa:a2b8 with SMTP id
 ffacd0b85a97d-3e642da2f85mr6601374f8f.19.1757341162197; 
 Mon, 08 Sep 2025 07:19:22 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e74b2e0511sm2879346f8f.62.2025.09.08.07.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 07:19:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 505B05F7FA;
 Mon, 08 Sep 2025 15:19:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH] .gitmodules: move u-boot mirrors to qemu-project-mirrors
Date: Mon,  8 Sep 2025 15:19:11 +0100
Message-ID: <20250908141911.2546063-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To continue our GitLab Open Source Program license we need to pass an
automated license check for all repos under qemu-project. While U-Boot
is clearly GPLv2 rather than fight with the automated validation
script just move the mirror across to a separate project.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
---
 .gitmodules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 73cae4cd4da..e27dfe8c2c1 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -15,7 +15,7 @@
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
-	url = https://gitlab.com/qemu-project/u-boot.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot.git
 [submodule "roms/skiboot"]
 	path = roms/skiboot
 	url = https://gitlab.com/qemu-project/skiboot.git
@@ -27,7 +27,7 @@
 	url = https://gitlab.com/qemu-project/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
 [submodule "roms/edk2"]
 	path = roms/edk2
 	url = https://gitlab.com/qemu-project/edk2.git
-- 
2.47.3


