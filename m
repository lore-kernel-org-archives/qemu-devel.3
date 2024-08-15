Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1B5C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebmy-00038s-K0; Thu, 15 Aug 2024 10:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmx-00035j-5V
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:19 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sebmv-0000C5-2x
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:49:18 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7a8caef11fso132200066b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723733355; x=1724338155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7MaSXOA/ZMqYEU3CV7ts37a7U6olYGDg0a62DJzx+I=;
 b=aaADOblkc4sebtpewmj5xDjfARvgFj9KkBL3JoEqh3dUYpdGr3Hr+R/xCleszv6Jon
 ZKl48AlozDyz4IUuOYY24amcTgQhEGe7gbmXNt333Kce4f83w1So5/zLytvjR2whXwpi
 SUaaGkY/BwAl1lxJdD2ajJYRrQnf5VAUsNNcwm7I6AG4E+60g/YBrGG3vRE7DUF3FCyl
 LbHflch3bA/zIifU9cG9MPV1ZShb8MI1S/Ww1E1yA9dPVQljR5BRmG+qAhGdhUdCVV+1
 g6jeb/woiuOVe3G/smig49eNI9JVYF5HvT47/3b2lCTRpTynWiMnTtmwyXBgk/jRer6m
 JVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723733355; x=1724338155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7MaSXOA/ZMqYEU3CV7ts37a7U6olYGDg0a62DJzx+I=;
 b=N95y8xMB2cHqYveRQS03rQdPj9XeQhpxkKjSCOrAXF0mQBGUbceUNehK1qsgKZdVhR
 qqpidcFCdtAQ1u/yr4aFJ9cDGrAzA89LXH3fr7FPS62bL0K8acTeZoow0ryamTEOpOXX
 V00fxNzq3djnU9VYuHmsBE8gUEzblMmzwlXFw5s419VAqAFwmNRoiBTNWsNIsNHtw5rP
 /Zk5wV/lHDwZPLgTPFwPKpmBx0QGCqw8bp92pBUOxgxfZJFBvbXyPVZir4pKk7iV8ALe
 BLmfwK0YzWpsV1INXCuo7zFnE8mBKIE0jHRRsxqbPX0LZZsJ5h9fCIMUZ17C52VBLpN6
 p2uQ==
X-Gm-Message-State: AOJu0YyJG+VosXPWvK6fTQPXJuFaeOsDqDg3fPfUWvJ0mw6UgODOyeqt
 Mc9CXUYBMvFoY7EExRLDNMagHUB9RH+2c+5XJnkcDE2+rjX23hX4GfnARzn+Plc=
X-Google-Smtp-Source: AGHT+IFGiI0wj4jUT5H/YHq84MNolYeeugOqs5LW8Q6o4GefIeSVnW6TIoR73a0GYB/+Xh1oJrGsXA==
X-Received: by 2002:a17:907:3daa:b0:a77:de2a:aef7 with SMTP id
 a640c23a62f3a-a83670063a3mr523966166b.44.1723733354788; 
 Thu, 15 Aug 2024 07:49:14 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a838393564csm112001666b.128.2024.08.15.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:49:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFA4D5F904;
 Thu, 15 Aug 2024 15:49:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/21] Makefile: trigger re-configure on updated pythondeps
Date: Thu, 15 Aug 2024 15:48:52 +0100
Message-Id: <20240815144911.1931487-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815144911.1931487-1-alex.bennee@linaro.org>
References: <20240815144911.1931487-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

If we add additional deps for meson we need to ensure we trigger a
reconfigure to make sure everything is set up.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240813202329.1237572-3-alex.bennee@linaro.org>

diff --git a/Makefile b/Makefile
index 02a257584b..917c9a34d1 100644
--- a/Makefile
+++ b/Makefile
@@ -78,7 +78,8 @@ x := $(shell rm -rf meson-private meson-info meson-logs)
 endif
 
 # 1. ensure config-host.mak is up-to-date
-config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh $(SRC_PATH)/VERSION
+config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/scripts/meson-buildoptions.sh \
+		$(SRC_PATH)/pythondeps.toml $(SRC_PATH)/VERSION
 	@echo config-host.mak is out-of-date, running configure
 	@if test -f meson-private/coredata.dat; then \
 	  ./config.status --skip-meson; \
-- 
2.39.2


