Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EECBC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRNE-0003YZ-FY; Thu, 16 Jan 2025 10:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMY-0002gY-OK
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMU-0000FU-Cr
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:47 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so9803785e9.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039644; x=1737644444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6rIE3w4PqFdvMDPG/J6E3dDoALYi4FR7d3zVik6HPo=;
 b=DRo5pHl98sMgEwWQxq8EymmMos4j9UrQ4atUEeEBGSvo/rKxoFUu5LN0Gv2L/4yBza
 EPWAifIO6yV9Xrw7/yqaP5G8hdR7LfExeCO0XhxVTZIADvJdMoemE2koB3vl2HG0hjPc
 yaX/wNNbfteEAiekE2RRhcVzonM7B5alt0F+0INV3xRxGobLqy52DCyyY5Z4hVM8NCgv
 +6i8bBaknXB5RfEfiw2QQ42lg2nAUoC7Rhn+gcQPIYlOUgRYWfGjC2dnYjTEsvKADt5M
 zZ4l47pr+rzevC5JRrRKI3AYiPBXbT7s6xcHRRy2c30bPsx9UHs5awikGBCtIrtbWMTD
 IoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039644; x=1737644444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6rIE3w4PqFdvMDPG/J6E3dDoALYi4FR7d3zVik6HPo=;
 b=mt+8/S9SRZp/aXs2wZJp595DXGRXewHaHlNDICWzLArB3F0aVGzc0Of2kP8ebAwR5b
 qJ7MfuoIU6QzSMdP1ifKYbky0rHF0R3LyiMkWUzDJXaqkMUyuiMPlM6GuNhSpr38n3BI
 lh9+8KFsDrf+YqmkGX3KMgipKqm/KrVXP6dh/3ob+c/nWUSkb9PHmUs8mYbKCkOAO/N1
 R9hhuFZ2bYK0eQ59fC3cYvBKGCcOTtGADJPskS/7qokpUrHf/QJe0EinS9gNptrwkMrc
 i+4I6G1M6ujwYEsgrojHp4550nZjiA4ilGNoqlLse1BbDJYWMQ7r2uZVTzGSKCp3SXmT
 gZ2A==
X-Gm-Message-State: AOJu0YzF5ahiOiGriSVUKMa3WqQj0iflRkSg0pr/vOcrOmJnV4zM1+bH
 PCOwv5dNDn5S/BtFEG33CNDSsu+U3/0wHpXTZr2VZyuUV0esI/FjrWpUgEybNZ7rAZHIRbPbPyZ
 m5Ys=
X-Gm-Gg: ASbGncvKlcXigV4PEExJktnIGBa0GwhI1y45S8T6x+1V3c9Srs2w1a8pBFYQ/wSuZhU
 9XcszsDwlZ1A/ppcVyyd5DUTtdkRRT7IXQi1E5JjfaOkTwhoDkn+bxCRRgIh/cCqFrjsj4qawA2
 QfZPT6DEdt0IJ19sTnQ6vnKE6z9EqGqskJ7v+QP+2ZH0PoPvGJdGaYRycZHxJtZM126z9XayHKm
 JhwnXpu2GqygeWfbdxy5RrgTHOZp+OTkdYhc96ooprHs8n1kIRamoJhrMkJVjPzpRP2HFGDemi2
 4i2rCZaSNKhSvsbnjOYc/liGtk3SZ8Q=
X-Google-Smtp-Source: AGHT+IGP1sNf+blsC1nUM3qxo/7SxSdM0EITn8jTum5tZnutTJdQsQQvY2ZnWRLpfZ8BH+YIGYX90w==
X-Received: by 2002:a05:600c:4f06:b0:431:12a8:7f1a with SMTP id
 5b1f17b1804b1-436e26d018emr362254395e9.16.1737039644487; 
 Thu, 16 Jan 2025 07:00:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c4f85sm63520845e9.18.2025.01.16.07.00.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 12/13] hw/arm/virt: Remove deprecated virt-2.12
 machine
Date: Thu, 16 Jan 2025 15:59:43 +0100
Message-ID: <20250116145944.38028-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
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
 hw/arm/virt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index f15d6f230b4..d22b445fe99 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3528,14 +3528,3 @@ static void virt_machine_3_0_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
 }
 DEFINE_VIRT_MACHINE(3, 0)
-
-static void virt_machine_2_12_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_3_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_12, hw_compat_2_12_len);
-    vmc->no_highmem_ecam = true;
-    mc->max_cpus = 255;
-}
-DEFINE_VIRT_MACHINE(2, 12)
-- 
2.47.1


