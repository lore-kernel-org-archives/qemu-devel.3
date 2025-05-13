Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88524C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtk8-00017K-58; Tue, 13 May 2025 13:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbP-00084A-Ts
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtbN-00037F-9G
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:39:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so61566255e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747157975; x=1747762775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P790GYrQJv0XpWOMoTqY2JnOtiqfx1x49LfX4aa1ATQ=;
 b=qB1mZ8Vff66cIOudrdueggv4Cld9RwQ+w0Srpfd1F4rn9UdTMpzexomU7Rh6hL5Agy
 kDPTLEx43rtfP0l8w5HS5gHhHKgMJISeNuFObjhR6B1Txw2iruugBcXUkXpyAih0wEeM
 tZvnTz9BGbhkFLozlTxZ9bFSNUyfbJeS/1hflHY86XqeEJ08134f6bjIJbM2N9yKXd0P
 +jAyn0Fbvq9uw/YbUHLn+rT+mBrrVKvqb8MI3wv448cPcqc7DWdFcwfZkFrds9NYw8/m
 8aHZpRBQ7m17za/W0ZXecxR2v/ihO0IVFNCAWjJqch2Vt6tm3DKjh1yCxP2HFBfh1GhY
 9miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747157975; x=1747762775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P790GYrQJv0XpWOMoTqY2JnOtiqfx1x49LfX4aa1ATQ=;
 b=YPL3AOCfQ+aR5heNSo41Bt66AFKCXLs2aHJSj/w4xht8KzajhIYKULvNi/EbqFcYv8
 qbALxMJ0eIM7nG5XrImlUaeu6wkdZB3HC8qoUEJG+DcmWqmuzGP0p+RQK7JCXgJTi0yW
 /JA6htN95KEULJiPY08SQBi17jd917jInFXoFTIPgjoqOLBGaPIFcQqrovtd96TMMhnO
 gzn4PHKeO5CoPP28GvVmMRo2/g5S7iZ5lEEuVKjEv9bbR7vKnSnMIqgojEaFV0sPyG7P
 +YdyVZg7DwUFkVU+OO4O0wlbodC/ZPnKkt1zce2morfK62B/GMpjiIBwpIvwFY1nYNht
 P3Rg==
X-Gm-Message-State: AOJu0YyM+JkfxZ51w6iQpr7x3pVUCH8pUZJUr3aAtqRumgOalxYDktLN
 Oz1/Cf7yDLpenA1cmbr7s+jL61d/aATeuj4Do5EPuY4E+qejCEHZi3gARC6aQC/TqwJ/T1GPVPm
 C1bY=
X-Gm-Gg: ASbGnctpapMUKTgtUvpLkX8xAUv8nl9Y3uQAHcW1VKIBdbiRINNOXmTVnoRO/aQ7WM8
 a2ve6Tves1Hk+51pyxDahBcbeVTT/YXH0csuGoXasXiwQ9dvGGBNjCAdnhBNJ9D3NzkznQEHQQW
 6G/O1LfIMqyj7Lu3Fd8y4G6DWhVbRhzcxyQDrkyUAQIQADlloWKhqhe3UvabQIj5GCDt7K6i9yC
 X3NO5OyvOmojOSQ60CFpH/w0rF0XQGVafM+dp/Vkzrw73w1BmIpupbtzMmwKYZVG6olB4eSHEaD
 LPsP0WQ/RJra4l9MJVdo4nDxkRbatLEiDHyXZv5SeipZ6AGqbAOMbQUua9UwktyUPvw/iXuQIdw
 PFEjm1DMOItLk557Uw/ktGOIwFX8h
X-Google-Smtp-Source: AGHT+IEQCCrWnNPvsfp/W/jgTCES71W/+ZAA6UZbvwzvNZMTMvb2e7DjkYs1kPddw95D1WKWv8B6sw==
X-Received: by 2002:a05:600c:1c19:b0:43d:412e:8a81 with SMTP id
 5b1f17b1804b1-442f217986dmr1181665e9.28.1747157975324; 
 Tue, 13 May 2025 10:39:35 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687adc0sm173416585e9.35.2025.05.13.10.39.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:39:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/19] target/arm/tcg-stubs: compile file once (system)
Date: Tue, 13 May 2025 18:39:10 +0100
Message-ID: <20250513173928.77376-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index b404fa54863..e568dfb706a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -48,7 +48,7 @@ subdir('hvf')
 if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
 else
-    arm_ss.add(files('tcg-stubs.c'))
+    arm_common_system_ss.add(files('tcg-stubs.c'))
 endif
 
 target_arch += {'arm': arm_ss}
-- 
2.47.1


