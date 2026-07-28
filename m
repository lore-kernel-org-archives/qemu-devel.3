Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD91EC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wogyB-0005Nc-Om; Tue, 28 Jul 2026 08:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy8-0005KN-To
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:36 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wogy6-00030V-Os
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 08:31:36 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so2536571f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785241893; x=1785846693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7UYGFLgmCUwo+Tmi9quT2d9jX0zt0KMl1Zv6YOhYJJI=;
 b=KsElx9UxNDle+8U1Mcq5QbeZLAk+J8AuX+2zmOwx3YEhY/96dizL1SKPC3Syp+wsV0
 drwJxq+IrKGnVhEVOz2V9xQwmT9YPEh5y8/GaopljP6Im/zrPvBjhElt8hWqzFz4Uyr3
 eI5eXijcELOO/I+N+lwsc6yZazqGoZ/jlZ8ABMAiQukkwiEq3T7HGi6sv2dGWWK25NJP
 Dk/FnEa7BBJdt/Jt5mzb+8Io9qw4DtbD05HTWm7I8twhL0ZjWM568mVZxWPprxnasoai
 NikBy/VSvkhwHzQGFX8dWjk7xDaruhjUoQph4SFkPWFF8XGBlY7ccBkq4R+pPz9L3LLx
 kokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241893; x=1785846693;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7UYGFLgmCUwo+Tmi9quT2d9jX0zt0KMl1Zv6YOhYJJI=;
 b=D6V56szfTHVH3SfLwhwXaFHrPuPqncFqBtm5kp6CmOklFgWvS/OYiCeYyo8kDLKDRj
 aJrMZfpwvYS5x/qbO/MyTWiBLn2Zn7MQHiEGlEhcUHy5YSy2fL3q/xWuBCekt2KMzJui
 EGQCjB0ZYOcBG8cPhpsNd1dgMK4fX+BNnKR4AHsxBCPjxiSsmZhE8Sy9f9CSjKyupJHh
 y2yZcWmXakuWx9XmhrBDMhZzV10jkQwMjwM5LYJ19G4E4JJS2xgn++FgjrR3wPRAC52U
 bAiJey76RRw0Y8XMAZBDIRefbzET0aIArxy/22tMLANwU5TOAQShBQS0ht7PLzAFQWP/
 xncA==
X-Gm-Message-State: AOJu0YwRbNjBZp7dkmLkpa4rQdUJ4N0b922KdXjObiPJJAR1o4xvqyHD
 88Tn0G1TH1hhYyA6wwhA4qrRYF95fZGu9lBCWW4IocigMAad6VtOMSakKymbPITqJOULOwcF3W9
 seyve
X-Gm-Gg: AR+sD10J+cDeQRxGjdA9vPoocu1hKNX9I6AYk0blT+O8kFnAScaitR7a2hE83CjtfDE
 m5wBMt0V9KwAOtSfeuEfYLYZfdm6xpWZg7YudVyNqQCVHB/XfAMnKAanHlfedPFpQkXdUwIrJtH
 KteN+w9nV7ZG972Ab4NbQKCwSUcb7yTJrXTnpEeoZ8SxzhSY1IpiHu/ja3ecfF42k+HbYFrZRIo
 FrKQTZ5gKzY0Qo14hino67fUujJXUonZ2g84WJqYSVObBSZZI0lfnHo8Pr7N9thf1pHPWKioLgf
 8sSs+JXlDpE9KS4X/oWM+cjElceZKogJBRi+8gYN3+8k685VuAqGB3h4yYFU/zFSz+iLUc2jwwu
 bdmjaORW0llQ/XIdwBwqKDdZyPde6AfOXFSIybZt5U3pF6TZSILvZKixZ3h+k5wt4w3oKWbfkFF
 DPURu/t1M2tZfgWMoS3h/rH1UhZPBmLCHf0MtRwFGA04hP+Qb3TVdYaPOckEyNH/F2v2/rpvZTP
 14JOGVYDcw=
X-Received: by 2002:a5d:64c5:0:b0:47f:93ea:cf47 with SMTP id
 ffacd0b85a97d-47fb1ea7cbcmr2663634f8f.37.1785241892802; 
 Tue, 28 Jul 2026 05:31:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6f076sm58499039f8f.34.2026.07.28.05.31.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:31:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] target/arm: Build TCG stubs as stub library
Date: Tue, 28 Jul 2026 13:31:11 +0100
Message-ID: <20260728123127.1711653-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728123127.1711653-1-peter.maydell@linaro.org>
References: <20260728123127.1711653-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Use the stub library introduced in commit 0da978cdbc6 ("target/arm:
define stub library") to prevent symbol conflicts.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260721122135.6288-5-philmd@oss.qualcomm.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index f6ae8934d1b..0369f96b4cc 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -38,7 +38,8 @@ arm_user_ss.add(files('cpu.c'))
 arm_stubs_ss.add(files(
   'cpu32-stubs.c',
   'gicv5-stubs.c',
-  'kvm-stub.c'
+  'kvm-stub.c',
+  'tcg-stubs.c',
 ))
 arm_user_ss.add(files(
   'el2-stubs.c',
@@ -65,8 +66,6 @@ subdir('whpx')
 
 if 'CONFIG_TCG' in config_all_accel
    subdir('tcg')
-else
-    arm_common_system_ss.add(files('tcg-stubs.c'))
 endif
 
 arm_user_ss.add_all(arm_common_user_system_ss)
-- 
2.43.0


