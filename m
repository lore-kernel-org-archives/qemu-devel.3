Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC1CCD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBYv-0006FM-Dc; Wed, 27 May 2026 06:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYt-00063s-9F
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBYr-000144-OF
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso62121025e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877948; x=1780482748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e6O/ogzr+K6mAT+/rTwXwSrAD8WtOVYWXrLB9FiOP2c=;
 b=zdc/oB7EfUOG59OYnvixTlgTOk6a23xLXfuDYioPUkwHDR3Jk9PHSm+R76yfnsqr8I
 sCeuBKvZlK/zo2Kr/Ja+RQagG4hbda5/jVY4PEimHVztEasa6t7x6gQo+Vqn6CkkNiNQ
 v3gbY5xKb/81nGPtfV6BBPKsiUTOxWXKWjNVwsldkfNn4ayyzCql5+ukeFArYvt5FLrB
 zUG7ggT2Jy22mG35Y8d0I/oHUi1QULpR6aBeHUGBTHK+emfhn5izkK6ex+ZHgADVY3nS
 +7DW40snhR4lAryMcZo7mKbcqOiJsdABWr7vFVdmBPUSUOSt7JWmJ8BWNUWu3H6TF4Th
 hZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877948; x=1780482748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e6O/ogzr+K6mAT+/rTwXwSrAD8WtOVYWXrLB9FiOP2c=;
 b=sRth1672E451qFL5K8h6LJu7JONNbUbgHQaFu1wTW2zet8YbmbuPUYCFEcPjyXtWj0
 pGh27LXdneBrbLFCp8s6vX5XeHtctTCHDnVNn99WlOHB3jM6YL0L6yUo4jD2sigzxQK8
 lVP6HltSy4tiBAiq05hqdzW1ktbZjO5g8IVEwwyF6X8OZ7N+SWXR84/fwWTKiC1hwd66
 xJ8ZozhndP13k2D1vGarHv4Wz3DLR1TLFBiSr5SMyczXje7I+MBqaqmPrnDVSM2WpSCh
 LHYP1z1ghC/vLeh9Hno/HhK3BbzQ9jtfhMXjjWCEeYnfr9curMBelvnrmMaDV6FNzIV5
 brNg==
X-Gm-Message-State: AOJu0Yxnq121GO5Kk+2Yt+ZPAa67UixNF3DDPfmUAeWkz/bo49DnXvn8
 uirQIt1kdjxZXpy2A2hG6LSaRcLjoZYoum+1MD06nCf8T/Mre4B/QEmdhBxWeIOVH21eMeCqr/B
 OlTuZFsg74g==
X-Gm-Gg: Acq92OHxiYZLTuldsfZoweEEcFN3Ju9BaVY9Jxrc45Sd0Ue/0TB7g2OZz7Ou9lz7mHU
 /nqA0mJbE5vSnUfEbhM0wuIFs5armx6UkJ3YoFUourbP/tzWQaPEDpePZ0UJiIBrrxa9IyVB3yq
 eL5XJlRFm0fBFQQL6QzA7jSZzjIuGOSe9TBBUN8H7lTmyDyU2qyj87K5kBEriVuRqIGqGvpbzit
 Cx5xDty9YRfb4L6uhqre4vh0w15odDw1z+KNno3DTZKAgVch+lDzIpRibiplVabDduGMse8VWvN
 rXb72hKd6JydMCgPyAkOcevUipKSpOFnliZzxOnCQG7zo8obDmdBqJAayAN+1z9CQMamDFVWWQz
 Ce/vx4WrhhwzeW3OW6IdOHdpkG+zAEBn3bYe0vHrb37JXKW7aIKy9nwndI4u9ZToDlG4ViXyNEj
 ygKLsyfS28hqEYRgPC39RCe+LFF3ogT5eVKaLAO2UY53mACRXTfJxhI0YbiRzBiyKtTw==
X-Received: by 2002:a05:600c:a012:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490519170bamr325194295e9.18.1779877948027; 
 Wed, 27 May 2026 03:32:28 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4907e7ceefdsm22256065e9.2.2026.05.27.03.32.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/32] hw/arm/meson: Remove now unused arm_ss[] source set
Date: Wed, 27 May 2026 12:30:20 +0200
Message-ID: <20260527103037.4461-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-6-philmd@linaro.org>
---
 hw/arm/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 22e8ad924a2..8f66a80e10e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,3 @@
-arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
@@ -111,5 +110,4 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(files('boot.c'))
 
-hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.53.0


