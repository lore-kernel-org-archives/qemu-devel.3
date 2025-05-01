Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7839FC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYkT-0004wf-4d; Thu, 01 May 2025 14:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAYkP-0004uY-NW; Thu, 01 May 2025 14:35:01 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1uAYkN-0007Vw-89; Thu, 01 May 2025 14:35:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso2398568a12.3; 
 Thu, 01 May 2025 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746124497; x=1746729297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUdFeSyflWwNMC8spYoAFZC9mek/p0k7XGjJv0BP+DI=;
 b=LWR14DGGNTta48/6yYC21NVXlBtFo1hssg2pFsO8U5kEfAxfjCQp64FP0zJCq/MFFh
 xSSwyHpSFQOx5WR0drPL8Wsjrb/N6QwumsoZ8f/d+ePJxf/mo9wscADyIxiq6ODE9Qi7
 xsqIr79cH0tZNLsxj0RXPX/2cWrZ9oEz/IqHazIOty4STR7quTbMgO+uG3VBmv4sjb8i
 TeSiFLBEXOrfuPo4Bnf9oI88gPdDr3iH5ePeQhYBF1+qCTTrTTRSI9+n9GIiF8cpB5F1
 gAe277WWCWbnSWddBFFXnK/72gExpAg6E0wK5eWjHmKNrsRwN3D2sgesu6XKJUvpTIy8
 cd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124497; x=1746729297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUdFeSyflWwNMC8spYoAFZC9mek/p0k7XGjJv0BP+DI=;
 b=AGvFH3owEAY6kE8ZpsyusJneITYxxK5LjpgXrBug+WC20Grox0s1YLVm5LxFUXPLl7
 ixZ2B3aBVGo+T15WZaiek3cYCUEBEMRzjtmtMC8zGNQdAv8f2KCz0nWlf81gqg9sRnGm
 tAQkfF8EddUjgJpI/tRH6LrGHd5cr/8j2UGOWPWyaKPOU80EDiWW+3htGlgH1SzTG4cY
 ylQI7B+deb60oebdXEBsnI2OspVewHNlZyA9rT/wB7cKFbtAnRrRPmQh5fmvTnUjnHKz
 G/kq8Gmq6f3AX8FILt5PGmWxCknqaFcCH/bv6GZ6qMePwc17IDwzMhTKZFKbxrcamycf
 Mi7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoWHaJA2yJyH0I2X97MB9VQqhJAnPSelRmmDOc1cIa/hcSgtWM9N0RvHJqR8FMdPcCqrr1qd96RQ==@nongnu.org
X-Gm-Message-State: AOJu0YyBZ8/pnlaht5m5tgWipy9x2iH78WVdcUyCWB0UYMIkoSYeSZEg
 cvd0KqWIgLNghjy0clTq1QJUD6TUD9Q+fZP/t3Pby9ZBezRDYHpowppVtA==
X-Gm-Gg: ASbGncsm3vVUAV6f0o5VqzJbsJ3y0Vr173vVRrM7/FBsAnfnmb1SINbi8I/x65O5koY
 39LLNnM6ilnnLdAwCZwUdX+Uir0n0c2rYAogHmpUDY7W3SYF2YjyubAkIooei5An7FCIk/aQzz3
 XNc41hzcvhpDru5KxJkXnNd/h+RCRZlRD91M8S2Lh7UqNiYUqffyF/hm9/yQvq56zns3XbDh1lD
 rtB2DuESOgi9RxikC5hzv/uxjcjPkMOo0Vy8f8XveKFnExmQPW6rCpQBMDw/HxzYEVkah4S7v3I
 ToyZHZbnXx1Nbi2ZiKVVXKBnFmRHr3Zn0+MzFt3QfB4D0MEIST6ulkvEuea2UrR6SlcQ/7G5A7p
 mx1Nme3j/xFD7yX9sjv4lLMys2hy3mktJvQNUxx0s1wyM0bxLGRiVMlz1qnQAL7FnUax9Qx/R
X-Google-Smtp-Source: AGHT+IGIuCoXQtRq3tRwQHLbXYpOQ8pqmlwnVSxYpbW3q+AgKaQs4gDZ7aTyqkHiTR9X7Oylfq8rdw==
X-Received: by 2002:a05:6402:1e88:b0:5f8:e24b:c8a6 with SMTP id
 4fb4d7f45d1cf-5f8e24bca83mr4146734a12.29.1746124496631; 
 Thu, 01 May 2025 11:34:56 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-2980-eb00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2980:eb00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f93000b272sm751709a12.68.2025.05.01.11.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 11:34:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/3] hw/pci-host/designware: Fix viewport configuration
Date: Thu,  1 May 2025 20:34:44 +0200
Message-ID: <20250501183445.2389-3-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250501183445.2389-1-shentey@gmail.com>
References: <20250501183445.2389-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Commit 6970f91ac781, "hw/pci-host/designware: Use deposit/extract API"
accidentally introduced a copy-and-paste error, causing Linux 6.14 to hang when
initializing the PCIe bridge on the imx8mp-evk machine. This fix corrects the
error.

Fixes: 6970f91ac781 ("hw/pci-host/designware: Use deposit/extract API")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/pci-host/designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index b4bff14579..f6e49ce9b8 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -348,14 +348,14 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
 
     case DESIGNWARE_PCIE_ATU_LOWER_BASE:
     case DESIGNWARE_PCIE_ATU_UPPER_BASE:
-        viewport->base = deposit64(root->msi.base,
+        viewport->base = deposit64(viewport->base,
                                    address == DESIGNWARE_PCIE_ATU_LOWER_BASE
                                    ? 0 : 32, 32, val);
         break;
 
     case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
     case DESIGNWARE_PCIE_ATU_UPPER_TARGET:
-        viewport->target = deposit64(root->msi.base,
+        viewport->target = deposit64(viewport->target,
                                      address == DESIGNWARE_PCIE_ATU_LOWER_TARGET
                                      ? 0 : 32, 32, val);
         break;
-- 
2.49.0


