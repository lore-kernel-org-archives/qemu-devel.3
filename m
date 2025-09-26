Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3A4CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 13:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v28LX-0008Bl-4B; Fri, 26 Sep 2025 09:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28LU-0008B4-RN
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v28Kv-00044F-V0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 09:18:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e30ef74b0so15673255e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758892680; x=1759497480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n9ccHrqUiuKP+PUJpZRKMvcFrFBUUGVHqrCB+4rnREA=;
 b=qrkey+miYQG4dMifwVhcpLXhq+x5uYHKYndo7OCJSWM8+avTJ1AqTo+m8Gsfb9Hr/v
 JRAUfi7MnjTxBXWxte/MTNfklqpWYaTXHzYrRpn0Z52gvFXCd4SK+Ch/ZjfDkFBjB/Kz
 4F/5U2dBswzZObagTpWzUVQ5T264JACjT4RL/J+kgFuAxB9MQuQn4xWXyuEoomYj8XJL
 CHim4wMLXBqI3cmbmgNnyGxTw1i12t71PVSHepl9Ogc1qZYVj+PGbxuYA6Cj9nrQIDqq
 7gAwwt414/SGfbSt0ZUHmzmUO+UBrDALjg4W8eFb+Xrkee+tljZ+rVgNi5gW7t8Ylc2g
 zFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758892680; x=1759497480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n9ccHrqUiuKP+PUJpZRKMvcFrFBUUGVHqrCB+4rnREA=;
 b=Le5ooX4U37fX8H69p9TAJfpIK5dlu6r6Xk3hkGxGhtiGVMLaE+JrkDyE/PMDukgNSL
 79IweOQi/i6f/Dbseshynts8+nkfUEfbniPdZOTAoKEpKJH9ImCSaWUmJ5NWzLDnInh7
 f8TyssZVBGcwrCAg/oCyjBHdN6PeqENgOQFmEjld61Cs05uyMuMUKMtF/JtDOG7eYiqB
 BwtiTmWP7aIsG74juqJGoXp8tE/9ryGFwEQOV6z/EvVtle9gVEsKH/BB/317KTiKnIlL
 h59fNU2Nhkd9bPry9oStae/fHcFug/YQsbV91qb9BVbHJ1yFl4nUtWSvwNO410dn9jIw
 RLwA==
X-Gm-Message-State: AOJu0Yx4QPeEPefckJNuUOFakVTqfgb3J/bU/FtpDaiPRNp3/JI6jalJ
 eY2X6okEm1jHo318jK/xz4aSU6ZZyNSixykIhiR0NoHcnfYtfxVWKLGwTkumvIdTlzI=
X-Gm-Gg: ASbGnctsQupw4QkXTK0WOEsswnZMcvHjvUJKFQCh7y01bfkib8DGPJP++wUNNk0QrcB
 MVIDsPy3MjCYzy7yams4DtoSyIhd9q1oy2Ue/n8vn27FXZbKVGEArgNP2tNphwoFhDe7LN2zQ8L
 Y/Cc55sAHkf0CtxPYCdMUCCc/aWt/IlvnHvdkjLnn/tEcqjhX09UpzFocOG2eNYff99V4A8FZCB
 e1HELCvsBEd0tn0FH9ukVPAEXpLUiZXKL+/4i+9WZuBftew0aShk/G5iLAs6+4A25fp0AOBnc7r
 RlOQWfvEDXJEsUHuQte3gfODXLSa3H7u8jncW766uVNXEq0nKeNBM9DHedGvTaDpStcUbV0aCSl
 2DvI+/WpCNdpGO0omGteFKsM=
X-Google-Smtp-Source: AGHT+IEICVh1+1hKdSM3g9J4xsG3N8FLPIJbaT+jWJPd5Hk9aUYXMtZhD1TeiIdvjD1nYvCc5p73mQ==
X-Received: by 2002:a05:600c:1695:b0:45b:79fd:cb3d with SMTP id
 5b1f17b1804b1-46e32a1b1fcmr46636345e9.36.1758892679662; 
 Fri, 26 Sep 2025 06:17:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bf70dcsm73289055e9.23.2025.09.26.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 06:17:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11FF45F91D;
 Fri, 26 Sep 2025 14:17:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 14/24] semihosting/arm-compat-semi: compile once in system and
 per target for user mode
Date: Fri, 26 Sep 2025 14:17:33 +0100
Message-ID: <20250926131744.432185-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250926131744.432185-1-alex.bennee@linaro.org>
References: <20250926131744.432185-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

We don't have any target dependency left in system mode, so we can
compile once.

User mode depends on qemu.h, which is duplicated between linux and bsd,
so we can't easily compile it once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-13-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250922093711.2768983-16-alex.bennee@linaro.org>

diff --git a/semihosting/meson.build b/semihosting/meson.build
index bb0db323937..99f10e2e2bb 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -12,9 +12,10 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+  if_true: files('arm-compat-semi.c'),
   if_false: files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
+specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING', 'CONFIG_USER_ONLY'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.3


