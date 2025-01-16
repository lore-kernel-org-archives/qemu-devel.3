Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A856C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 15:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRNG-0003gv-Bj; Thu, 16 Jan 2025 10:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMC-0002D1-Pz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYRMB-0000AQ-0C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 10:00:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43618283dedso9715675e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 07:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039625; x=1737644425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MTHv/51XufZ1391deMGkMD7k2+fuA6D8r2HqDbrkqM=;
 b=wsw8hWEgTofEGWD+DYvOpii5z3/DcjK0GWMp89gfgbF/zZOHmbnT++OukoMUAvsF4w
 gLJWnKs998E0cjdAdDT7yxXcpJFFY+MjCXP6dhQH3mYbri1IuVB8kGkQwhFsFucJh3ko
 TTuCPPBp8oDOAGhmYeTs9Ff7oCMXH/h6/adkC8t94FuR7GRHYRr/dLbp93s/Utxur1s9
 m1DxlXn4v7d4tE1GxEMhG7aQjaw09zq7w7cx5V6NbR9QW8lk0DJZeO2gJw1UepGDPNkW
 mHESy8ZDNqH7zBYYJc/16P0PH/jWPbSn4ht1mqG2drFpsinZ+h/dd5pQoQ8oftUEPO+7
 dvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039625; x=1737644425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MTHv/51XufZ1391deMGkMD7k2+fuA6D8r2HqDbrkqM=;
 b=Ko8KIaaKLvOLQnNwme5+trT2dQ+SRnfgFoFhHVZU71bjXDH1E+g17UGeTg/Df2HVTm
 U2giBF5DMri0sI9tD5Vm26lbMzZQ/2BCAiCRce58Xlj8pgOVHGoWm7YpS09k75wAHw5R
 rc4L0t+GGEqbjPV4H5H5zKrHRnOJ4HIJ20103k2D0FSy3jjeUj2WjxFU/QGMACSsgfr5
 Ix5wfkJ0psCpTyi7M/jEIv4pqC7aat3G4bCtZ7X2fuTBGaSRzYRWB2LiLmGcChfmhsw0
 mvRlxef7oGfqaF1TkgUgnq6heHmYdCvCS04EHPCYAh8dk5dKnNoI3uB5sMbk0NB9cjJL
 8bkw==
X-Gm-Message-State: AOJu0YzY9sGXFcApIPYu0ukwnbdJ0gjOSLeRUJ2iXKC5m20HwRyUGGR3
 D8mG1GpKnmBhSE+nPDM6tWfwgKbAWtOfknMWdacsokx+lwrT21VMFAr84VDsXKneizmYDIL1xL4
 M7jw=
X-Gm-Gg: ASbGnctXNRnePIDEQJHnm1fXAPQ0WtEt3io+dYgWAbjtsXnPyY1qT4xt6Dh7bvN/Y90
 KQJhWfh9UDRnv8jivOaChNngp6fX2hVPYWEa4KJ+f0Yw1bGIFdBa80QQycIBzOSknMPSal1ipJ0
 puCT0Lz9AghGppT7Y92/PAPPfXMgtFhKdz1gKdrQW6AObpHsD2nmGpAJJNkRZuzlS3iUnlYglNQ
 mGTNAYCcU/5q3i2grDkp5HUZLbn+SNVbY0TwrQVTar5e1AmqMANP8du8OfmTX69KyGs88zv+JS0
 2nj6BCKlvJILRjhRnHzHQoIM/D9/WBA=
X-Google-Smtp-Source: AGHT+IHtKg5dO8aqpPBQ7MFgQxNr8P/YuAorEtZnd1vDUeQVAZ7fTZbIxMpHOuXeVnUxDdsn0yObPA==
X-Received: by 2002:a05:600c:5117:b0:434:fe62:28c1 with SMTP id
 5b1f17b1804b1-436e26cfe5cmr170202295e9.18.1737039625202; 
 Thu, 16 Jan 2025 07:00:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904625e5sm1720085e9.32.2025.01.16.07.00.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 07:00:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Thomas Huth <thuth@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 08/13] hw/arm/virt: Remove deprecated virt-2.9
 machine
Date: Thu, 16 Jan 2025 15:59:39 +0100
Message-ID: <20250116145944.38028-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250116145944.38028-1-philmd@linaro.org>
References: <20250116145944.38028-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 589f3e27ee8..14fc4b100a3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3560,10 +3560,3 @@ static void virt_machine_2_10_options(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 DEFINE_VIRT_MACHINE(2, 10)
-
-static void virt_machine_2_9_options(MachineClass *mc)
-{
-    virt_machine_2_10_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
-}
-DEFINE_VIRT_MACHINE(2, 9)
-- 
2.47.1


