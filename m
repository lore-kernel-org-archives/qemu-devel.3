Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D9CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kDI-0003h1-Bh; Fri, 17 Oct 2025 09:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kD3-0003PK-QT
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCl-0004YT-5Y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-426edfffc66so1313744f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706547; x=1761311347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cycdOupry1MmHe8WmC0tU4fLX0XNG8UvdLrV1HILvSk=;
 b=RVl/onhNRdeMPnz323ZJUtVR5DdI1k8qPEJgnop2M7whmeVYbO0QWmbD3jeYH5RjqX
 d37OFD9AHNy7aNhF0900L1VX1sXLbaflsSwsyeLdM+DUVzbLJBYZq+euU2DkUjWY2qQw
 bvJJzB+b5K74NAx8N0X1HCf+rZH5qffSoOpiJLoaMpLEnefkkd+BSkSnFirETPBx5MkS
 Z8F6KIo1lgc5CIO5WJhjd1Ez6bNzp5GKjsVHINv+0js7yoh4IULweamfzTqyUgIi5ENG
 m9vpOB7VYITYKiVoDsNi03J+qCyDuhsRH9w84K5lJwX5A86h/9eAAVKcRF4ofv0IpAeY
 bTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706547; x=1761311347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cycdOupry1MmHe8WmC0tU4fLX0XNG8UvdLrV1HILvSk=;
 b=cmtn/H7f6rO/zCtnE0dCoOmOv+h4C0j+i+xqBF5ioUCekVnnPHDM0dEfTwmGoDfJ1z
 aeWCZHH5/y2q3TceOblX9H0hbJCYq5zlghHCJNiTgA1CpRtMHBJrDbdLvVxXX453HWKx
 mCSzmWWrTHFjLOiS9QMLyQHs7vmk72m00eilHjYb2Euwx+YTMNMQBDi1JA+RnUuiXW6R
 a3rc5chZj937aJXtiZjiHt2htePwcFvYqsFoJ4FAe4dHYWKItj+sRZlMCrlRyFh6Nv0H
 IPrAcLOBH6Ah1LAknM5H1tE7rffMcmOjE7KZnvJPq6Fmqf3w5yKbRHxXz0IdcHG9eVgU
 llDQ==
X-Gm-Message-State: AOJu0Yy9c+e/0OvNrjpNW/Qe7ypg/jz9bzzbw3Ts0L35dvNA0OH1g1pb
 8hgAp/LPKFG2wnc+RWGVnbeuPB28jOldJU5SBYQuthqZieRvUq8HcbZZ4LOc5AGs0EGM3uPCOld
 3kbUZdu4=
X-Gm-Gg: ASbGncvVJbxoiXLqoksNzB4+zqL6kbjOE6ajUVjt3wXHDFCeL/pVEwNeYQ4PMISiw1T
 VW8YB1DSJVwxuWZoQGC4dVBMCjXLzj8UEaBKerqGO1NVKLipFVjyNgBcX+k7uR/8Igm2pjPbKF7
 ivNE33Y2scJ/zrhrfj2BZGrr1HBYFPRF2PSHg0L4JcbizTzeLC9CCYg+JNtXzxi8iqXcgk5PaYj
 KU6W130hHHBBFq9IDmLbGvNmFqVMXSwnG8QWjJ4jYRe3frF3ogGameW1Q1WRgnB6DV+j7nRf1Jb
 el828fomQDXJtSjp6IJW7EskqjA7WOPV5+XnR2xooyODQJ6p8YGO3xUskONqAHpY76UUDe1ylRs
 RxBoCZZ57W2fckxjJpEaJm54fJcAoX8WqmNBsxVc8JVvUB+XUwedZ/VgFW+vwA/WM12SaWQNSaz
 tdLFbCIe5b4VflvZLhRWSj6xakqCHXTG2qja1e3tMOIZmJB4Ir3da43ah5gUfU
X-Google-Smtp-Source: AGHT+IFxx0xGM7YpAWk2ylchCg1Hl7UWJ34JZwZDUFmRfUv4ANT8cjN0v52kv+oXPSnsf0FCZCKC2g==
X-Received: by 2002:a05:6000:186a:b0:427:49b:abe with SMTP id
 ffacd0b85a97d-427049b0ae7mr2762015f8f.18.1760706547121; 
 Fri, 17 Oct 2025 06:09:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cd11sm41263939f8f.5.2025.10.17.06.09.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:09:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/20] hw/arm/virt: Remove deprecated virt-5.2 machine
Date: Fri, 17 Oct 2025 15:08:08 +0200
Message-ID: <20251017130821.58388-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cd0df096de9..e49af505431 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3648,13 +3648,3 @@ static void virt_machine_6_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_6_0, hw_compat_6_0_len);
 }
 DEFINE_VIRT_MACHINE(6, 0)
-
-static void virt_machine_5_2_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_6_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_5_2, hw_compat_5_2_len);
-    vmc->no_secure_gpio = true;
-}
-DEFINE_VIRT_MACHINE(5, 2)
-- 
2.51.0


