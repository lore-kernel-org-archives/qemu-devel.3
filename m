Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67594CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kCv-00039z-KM; Fri, 17 Oct 2025 09:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCb-000312-8y
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:09:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kCT-0004Ua-8I
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so17422485e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706528; x=1761311328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+g/3UGrO4dRVqOdEbSBjp1aEwx70W+XzWh1duuSdeK4=;
 b=FxWNWVONFy7XzTOBfl99fIUOQfyxBC90YoXaXbyy/kQelK+7RyvzJMpvymTGL/xtTC
 vQChbHUudrTKOXIAsV2d+23HEq90aH3hgWQE5B/H31akuvmANGFL/LgLL1gOtJ8M7zaI
 fjmMYdXfn+Ik9z9tyWou1txuawDavT4gckifrcsbppwjfJ9VB6+HhIc6ZjvVKZ/dcT/5
 PynGdQfH2omwtK/y+VpaJr27tgR4Kp+31aNzk0W/LjsOmriLRNUU92dgnhFdMJpxG/5s
 6WIqnHBKXbVGi0AkbPGDbIDgLq/rgf0ko535h3nG0LJvdO8fgpa1Bg8kr6HbWA0uoqqf
 JFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706528; x=1761311328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+g/3UGrO4dRVqOdEbSBjp1aEwx70W+XzWh1duuSdeK4=;
 b=SYj4ImlzXTeGtVyPFxVujbEqOa4MAyTGwh77e01gqMr5CFYnBdZD5gN1FFElfZe6yo
 jdL/usrDiXPj7dxH6+x3hrJMF5QMujK9SZjdX5wHhnHXhM1gw2PwiUwQS4IPw9pzQRig
 DM1/X+OJ2m7SkDz68X9CScwnZ1aj4fKxhg19nC5cVGwoZ9J25oeOHeUTxHQf6ptit+FI
 q4b5c2mQHuIk5cfLuIBCKOGdzz42t9QlxkJmublz8Ui4lxXXmqv4fNyf1O4xJOpUygqG
 NLnGkOhVp+xfQSFWf1F/EpyskkM3RXD1d1mwXz5q3CyIAdpa0KNRdPZS29q6GsFqQHfb
 UUww==
X-Gm-Message-State: AOJu0Yw0oonkm+4/xMBEt9Uypih8qdLNBIZb3gB190Vb83DdxP420Ag3
 IanH9kGeGxKISUD7BDs5yiHtg/w3qw/EMFhxD8sp/qIVqgpzwK6wdghqWKy2SspgXhTfkCF+rA+
 ilRSHCdE=
X-Gm-Gg: ASbGncutg+DRyBJPpvu5zlx7F3aEv1CzStU4XzCmU+W+wBImvzHN2/uqLa8nyB4+Ckn
 O/ADBjN70K22iva+Nh9ne3uC/eU3dGKixPUU8ytS5aNahI2lWFY5o4zcB2XcdEyz/U1mVtdiDAZ
 FnzwIcP3cJARXeShHSFzbsPdSngp6JLiGjNrx5ahNZWjcsWgyY/icMIdqmyI3g0CjM9G5FL7xqE
 Rjh5saqJTGsP/thxgrjvROQmHBg2kHWEBof0mWi5jDd7QdJimE2RBYdluaxeORdnc4mWoELugNg
 Bl4y7cV1mFj6ZnhDADbLyxvhgeWg8s2TEQ5gvpep2DlUdol0sOkMN/NBbFDhpd/Mrp5TjnbjHxW
 N2HiaI4BuTxBzbGu3xdP3lXr06U2l9culAlzLV4OxqYp/TbCTtmtVwsoEXVioO7fvvoHWSwKEyo
 rKxGPIO2GnAIBDJjPkJbCaaSnSUN8wYKRSxO0zuN7QMlDhIwkhIw==
X-Google-Smtp-Source: AGHT+IFDPRHbpEjiY+ij0cvNWh4gdkxh6Q7MWCddU73DCl58RpdcZyuSqsuTH51Zcd/0VSqvPc6G3Q==
X-Received: by 2002:a05:600c:32af:b0:46e:6a3f:6c6 with SMTP id
 5b1f17b1804b1-471099257b0mr37558945e9.6.1760706527703; 
 Fri, 17 Oct 2025 06:08:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c29sm83561905e9.12.2025.10.17.06.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:08:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/20] hw/arm/virt: Remove deprecated virt-5.0 machine
Date: Fri, 17 Oct 2025 15:08:04 +0200
Message-ID: <20251017130821.58388-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017130821.58388-1-philmd@linaro.org>
References: <20251017130821.58388-1-philmd@linaro.org>
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ffbddb711f6..953b2e5a94f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3673,15 +3673,3 @@ static void virt_machine_5_1_options(MachineClass *mc)
     vmc->no_kvm_steal_time = true;
 }
 DEFINE_VIRT_MACHINE(5, 1)
-
-static void virt_machine_5_0_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_5_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
-    mc->numa_mem_supported = true;
-    vmc->acpi_expose_flash = true;
-    mc->auto_enable_numa_with_memdev = false;
-}
-DEFINE_VIRT_MACHINE(5, 0)
-- 
2.51.0


