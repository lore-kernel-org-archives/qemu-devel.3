Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD58DC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr1sW-000731-CT; Sat, 08 Mar 2025 16:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rF-0005Yu-1d
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:31 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr1rA-0003vs-ST
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:37:18 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso1402075e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741469834; x=1742074634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akRNzOoRRyY/xSKhmyVeI+5UU9kBXMKW6nWI01FbvUE=;
 b=Io2AyQFP+0pG4t9mNFdUsDeQtliT4b9N30kLRMQEQJn6KyOtsTVXXM+QhjO4BJH8AD
 yBua7QK4P/BT1uGx7H2poKbeUICqCRpCe+tU/gwzzoCAQycQmRK/s6i42QUtEv1OMPSd
 gMkMIEiSjtKjJG0P9OZxLQtZogpxQMtCgDZA2d2TLrIbNMLj6sTN8Jasdt1cH+xHghsu
 ddNdR5oyw/QPILobDkoDPkA0YBp4aC2ITC9aBVMXg+3WY1FKklF4n7Fo4w6tT9XDvH+S
 mfcb3iUpEMRKR9fuLcoENDC+Ahy2rVA7yH168LCzLq03EzwBx4+INaeADeRMEnoJdP5m
 wzsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741469834; x=1742074634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=akRNzOoRRyY/xSKhmyVeI+5UU9kBXMKW6nWI01FbvUE=;
 b=MGInRME9YWkxZI1Bp7FQYGEtdG5Q5Gai1w9mj2H6XVj4VpqNcOeb4j91WNjlvBfc4R
 LsNtXtXXf1w3jldKFwEmkijZ17EKix41tqsV4bz9R+rha+UnITH7o0utr4eYvRFn8VkZ
 rEjWrdK12WumKgrlEvLTN224WvKQszxZydeMXnUSI4qA1unJy3SsJ7P5NLoEOOQDhTAp
 M48wyIihKiWxGySsRGneOoKKqLJ1/Cb/eRprLkBBmxLKY0gm+d8Kqul55huOdJ2bXqlU
 kgmoH/SWBxXBvAniXzkrOJAPdwSusol2boxWmjj2hoXZxuPECfnx42k4Th4d7i8xq67h
 TtRw==
X-Gm-Message-State: AOJu0YyZCUkl3cr3C/+7YD3UnnN1Ld43Mz8fJzkzEjUQ3qEQbH0fXtKU
 6fEe2EdNeCaq6O+HanpuZdQTyMJs7iErt8wZy4vK/GfnyMzdxx9J8gFOda3wkex5WRr/5ODmn/e
 bsf4=
X-Gm-Gg: ASbGncu5U5uWNQlXV0znOe+JDZTNhhnzQ9TNo2tbNYOlWASh9H7QMc7Sw7bUL1bd8Xf
 ikeHauUJ69qMQ9oXiBVPc02PtX6xhBbvSntzMZsBzk1kzEDo66+d4FyQBK/dnRXu2E4iYQyE0vN
 v256p/yElOyvwt7vjwGWk9tKWeDs0sxcvbIsH7J2hDO+f4o235W2h70YGt6g42VIcPsEhp4dGW2
 K0SyXCOcW5zFjzbVwfCeG+zzwm0loIW5U7amuIMVDXSyGJzlDGfOcNMzt8iheIdJKBDDaEN9+YU
 fXroJJk8SvM/Q5/BPMro3DUnmlga6Z64kj+20n2zFMWeRIGnQnUD4N7B55zOX/qjTl58ddviWjP
 NbkoQRh6xeEqMVshLBfE=
X-Google-Smtp-Source: AGHT+IFleBt6cR4JT4IujkflDeTTtooakD+z+Ef87GAhnmCJ81BWA/eBLG7qhw2k0d6EmYnU7SMm3w==
X-Received: by 2002:a05:600c:46d0:b0:439:969e:d80f with SMTP id
 5b1f17b1804b1-43c60231ddamr59791445e9.31.1741469833745; 
 Sat, 08 Mar 2025 13:37:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfbaa94sm9963087f8f.14.2025.03.08.13.37.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 13:37:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v4 06/14] hw/sd/sdhci: Enforce little endianness on PCI devices
Date: Sat,  8 Mar 2025 22:36:32 +0100
Message-ID: <20250308213640.13138-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308213640.13138-1-philmd@linaro.org>
References: <20250308213640.13138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

This is the default, but better be safe than sorry.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 5268c0dee50..5f82178a76f 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -32,6 +32,7 @@ static void sdhci_pci_realize(PCIDevice *dev, Error **errp)
     SDHCIState *s = PCI_SDHCI(dev);
 
     sdhci_initfn(s);
+    qdev_prop_set_uint8(DEVICE(dev), "endianness", DEVICE_LITTLE_ENDIAN);
     sdhci_common_realize(s, errp);
     if (*errp) {
         return;
-- 
2.47.1


