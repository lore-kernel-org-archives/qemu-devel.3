Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629ABC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY6uX-0007LW-Ki; Wed, 15 Jan 2025 12:10:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uL-0007DN-Bx
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY6uJ-0006Vm-L6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:10:21 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so49909065e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736961016; x=1737565816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tO82mELrC9ge/485uM+xBiac5JrZdcxe00dmNBeeW5o=;
 b=KBxokSMaGDjGsnT6P1OT9RXr9xfywnz29iFe6xWnfNn3WxkV2DEjMd3rzauSDCLA+K
 /txwqlWg2MTgpVknnjcKfyZ+7GbBpwwX0KWrrNXhN7zMi/6TlkKAU3XBBKCX+iCRnGh/
 HYAmp6W0DujcHxUn+XUWWapMaGdQzU7Eleyb6Q+qTcV0Z8n3hrrelN3pMbycDM5j97mv
 /xO39nAr2zKN4Tx8HXBGL6ZDFMzP7qYom6UUKtOtV1V+O+sgkoO5gQ9Dy+fKwI4CBU5o
 y7w8uru5kFGAnM5a9gl2GY+dtlv2pTYo5xn+82kGu6eu9pyYnpuAWuFAWt2iOI6oW3BO
 U9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736961016; x=1737565816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tO82mELrC9ge/485uM+xBiac5JrZdcxe00dmNBeeW5o=;
 b=sVrpPC78b0hAdGGHAx7teP3vNXRguIEAtcbGOzrwyf2vUNAcQvnlcliAlPkc8lAi5E
 oDRTCcgrTKLaJfUlssq6Ghxi+bb4wIg5vfe7lWahGxE5BacSWiK9LNTCaJTTMkH3obEY
 rjbo/rd0UrAPYafYe6sb9VGIhzsoRkXyxQiAvjlpCoGwwyX5/u+285G62ViGTNK/f1j0
 vD+9Kd1CZqH032tG3khtL3g2lQf0nOFmV6Ua33BFNbbuhsdolcpMQQPfEiIt51QBCIgb
 m/I+9xu6bvYRzeDqg3etAAsc0sKuw5plhdLa/LLbqVkCJUxH3H1g0qWtnF0H4f245U/L
 H9nQ==
X-Gm-Message-State: AOJu0YwJkPWl7M4ZlhsUifY0BvXhvK3HKBUg4O3/zFfAntY1Ah9p7mJ4
 89igiSIPHaZDaGU24cSpN9XhXuWzuh3gDO0a5xit+AuqZsSCMVy3CbKr3GVPz456TEZAWPanMSL
 oAAA=
X-Gm-Gg: ASbGncs0UuL31t6kdCwdiutGRkHwzrJyJwWBkBusPYCAeG8fNAUcDdPYZH8eTot1mK9
 wu7gwLhxziDhAloeNW4elEX++syr2D+HfDGo0LUT8bfHq2wYaAmSvKb44niQGNmq75U2wRBaa0G
 +5uKWlkQamTC8n3NIlfKsSUkznhcIv/WEPXKYK90nPR+/JNaLnRERG7yoi+6qwN+CepUyBNsui/
 JJXUVkxesjhjoXOylqGQA+QvvfNcPj/KBqthUFs6zngIOT4dg3yjJN4GWttZebkZmLdFrjogvv3
 jFUmRObrHyUpB0rGuwaHuhEIhptnhKVpqaY+
X-Google-Smtp-Source: AGHT+IFiGSzmwCxqFZ/xX3I4s/b9Xp4asSsFxqy1N30kvRoi3PwEH+40dargU28XdMb6eIywhz2jmQ==
X-Received: by 2002:a05:600c:3ca0:b0:42a:a6d2:3270 with SMTP id
 5b1f17b1804b1-436e26f01aamr233136665e9.21.1736961015906; 
 Wed, 15 Jan 2025 09:10:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c475csm30575235e9.20.2025.01.15.09.10.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 09:10:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>, qemu-arm@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/13] hw/arm/virt: Remove deprecated virt-2.6 machine
Date: Wed, 15 Jan 2025 18:09:57 +0100
Message-ID: <20250115171009.19302-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115171009.19302-1-philmd@linaro.org>
References: <20250115171009.19302-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

This machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/removed-features.rst |  4 ++++
 hw/arm/virt.c                   | 12 ------------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c6616ce05e5..813988fad4a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1065,6 +1065,10 @@ for all machine types using the PXA2xx and OMAP2 SoCs. We are also
 dropping the ``cheetah`` OMAP1 board, because we don't have any
 test images for it and don't know of anybody who does.
 
+Arm ``virt-2.6`` (removed in 10.0)
+''''''''''''''''''''''''''''''''''
+This versioned machine has been supported for a period of more than 6 years.
+
 linux-user mode CPUs
 --------------------
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c5..3bb8a9c7bd6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3606,15 +3606,3 @@ static void virt_machine_2_7_options(MachineClass *mc)
     mc->minimum_page_bits = 0;
 }
 DEFINE_VIRT_MACHINE(2, 7)
-
-static void virt_machine_2_6_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_2_7_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    vmc->disallow_affinity_adjustment = true;
-    /* Disable PMU for 2.6 as PMU support was first introduced in 2.7 */
-    vmc->no_pmu = true;
-}
-DEFINE_VIRT_MACHINE(2, 6)
-- 
2.47.1


