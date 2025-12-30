Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ECCEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyQ-00080c-Un; Tue, 30 Dec 2025 16:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagy2-0006lL-Jf
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxz-0002K5-Pz
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so43813495e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128958; x=1767733758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DgIrNp2Q4FL23fByvzV3YdB6W+rarWqyshGf/QdgOu8=;
 b=AbeUaTrWHzILkrYCdNagTkycNHLDbyF7kwNXYOlWMejqRa/mhNlIhhxWfREP9/8jJq
 1ugDFK10Zni9e9sF/K+Mza0uTGYhwIP4mCYwUfmZrxoTvxuvpGhBOfboql8KqPc5yEmA
 2J0Af2YZCZ/tbThTn5OhBYupxC3ONbx9P7GOpjzXsoxxh0WnjwZz5gt2daiu+26Nn5yH
 RTnQSFjaXU0pVSYXKiee/ek1PsXYO4yzqH8MB+sKCv4xgm5vJDdQ6gYzohjS50hrP0Jd
 dH053lAfeSVOLDNPs7PUaTsJQB7VoIxvZMLxhEfNJpr+AuXN9WNP113LTMq4Qq/cdhTE
 Ro8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128958; x=1767733758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DgIrNp2Q4FL23fByvzV3YdB6W+rarWqyshGf/QdgOu8=;
 b=vfK0+MaPEPImsCvxMkFHdLR7+RQRT1oPdlsrCOqSTWv4GNPkYph5qyioj1hgh4SKMI
 Z4NvAuJYCLjv0gfIWZvtsP1Z8NtAkdayYtKSvx1621Wy4qROeCIdnIiXaMXG0aB8YxPS
 H+0QCeMERzWokc0SddJrYcmQMmv5oaFZhnDVZ8wKEgBeh6hNR7iafRM/YXqYgjMc4H3r
 Tih/5V25OmjZP4n4AXVHXercxTJqScAUeFoTperwIUjXvkkge+eeDeSuh9FTR0kMz866
 mLkx2UmgjiTeUZjCoFOLl+h+sDcf0GeOa6gVBgMy3OhbHLeE7rxwknuttZG3oIKMc7rJ
 qJ+Q==
X-Gm-Message-State: AOJu0YySZ3KGVyBtj7qAfZwJSHwf6Zq4lcb2o8HJE3g0EYsnKn5B+bh+
 Gf0+fqrDKJJCUCgoZalTrHwY6poQCwz7a1XtjZCP4wszVBZyv1uugEqclUq2N73a+7/9VjhwN7O
 EcM3jOP8=
X-Gm-Gg: AY/fxX4OYYbgt/eTfQeGsFN2KDTgruUShoOOGXkXeskVznDX0bv1eRGLprFvqEGU9oX
 NaihgIDHjheADwrhjwx1XSwO2OOAElCZsY+Wz+aziQEl8/e8G6H4DOb+KoGGVyQmqIu+B2vR6K/
 0y4uy/TgaaRltMc7pkFezFVUzOlWqyjn1XofNHd2dfFH6USn7tZLmD5hN/KWSgQBZjG8hrNPYGl
 XeoH9X05QSSFNpie3AW6kzqbXk2Y0EHqxiCsKqHz4XzWgb1xBmwhUcYtgn4LlWz3BtnJMGpVcRK
 E0Y4iJ5D+memDuAkd9pcGMddKhpkqGLMveVclpBLzIetxd/NcYIxJLGSQCUYGPQKJXTyGjDLcd3
 t5X/FWV4qD/tvUqSHMn+8inM3093suEUoqw47LWZ1gXrYuJRh0vxRnzROZDdZiI2zOhiIgbful9
 yvXgNgy9G/nkFr2FSXYIaoC4vvR8Mi6Egrl1CwkbD6FQg2NfTIWIVvIsshmfr3
X-Google-Smtp-Source: AGHT+IFPWEPE2P2Warughsbvvh4HvSsodSqsri/i/NSj+sSOlZY8AMbMZqqZaJLN2NHpHZBYV5sM5g==
X-Received: by 2002:a05:600c:3584:b0:46e:59bd:f7d3 with SMTP id
 5b1f17b1804b1-47d195a724bmr457324115e9.20.1767128957863; 
 Tue, 30 Dec 2025 13:09:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cbe58sm611524755e9.9.2025.12.30.13.09.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/34] hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
Date: Tue, 30 Dec 2025 22:07:34 +0100
Message-ID: <20251230210757.13803-13-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since commit 17372bd812d, the SoC used by the mcimx6ul-evk
machine requires the IMX USB PHY component.
As this component is only used by 2 machines, do not select
it by default (it will be automatically  selected when
necessary).

Fixes: 17372bd812d ("hw/arm/fsl-imx6ul: Wire up USB controllers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224134644.85582-2-philmd@linaro.org>
---
 hw/arm/Kconfig | 1 +
 hw/usb/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 78775063840..97d747e2062 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -638,6 +638,7 @@ config FSL_IMX6UL
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select IMX_USBPHY
     select WDT_IMX2
     select SDHCI
     select USB_CHIPIDEA
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 69c663be52f..de95686720c 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -132,7 +132,6 @@ config USB_CANOKEY
 
 config IMX_USBPHY
     bool
-    default y
     depends on USB
 
 config USB_DWC3
-- 
2.52.0


