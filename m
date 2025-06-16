Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA69C71155
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 14:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRAUe-0001II-9p; Mon, 16 Jun 2025 10:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRAU8-00016k-Up
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uRAU1-00041E-1x
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 10:06:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45300c82c1cso14610065e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750082801; x=1750687601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h8VneX6jvIb39sL+b3h3e8ynlMbxT5M4RcGTGS18RQw=;
 b=sBPVineeVA9oLzGzW+lz1LWpcb12d9tKRyI6he3Qm5eDcmgevzYE5auT4TtxxmLG2i
 RaSS091CCexL8jNxh/n7wl4jP1VXeZRW2zM9wuiOaYy4pwW+dY5PASR/89pFoc4dZMyP
 AP+WxCB28YPxqUjlE3vkaju+x6aGL7QvVYG8EtyVPZm5VmJoZfJLGSYfXecIlk6DXJ1S
 2ee0C13q3hlZpHlVc2JfFeFSqBqlsuftAWxxDUb7cyFdQ8pao+WErYtlTt4cT21NORJE
 CMc+aOWlt226g9Iz/Ty3tIPCrlHLPVXH6Tt/aF2FudemzbwY/BIkC7IfBGxCozq+xHWv
 nZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750082801; x=1750687601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8VneX6jvIb39sL+b3h3e8ynlMbxT5M4RcGTGS18RQw=;
 b=Khl/2qj98N00u241hjirQ2o4qtAz/8DkWRnT0R7uL36OkXf97JyXZU3d3uyqlw2MDY
 wda/Z1OoibLnltvkEmLapRzEwDyXvfblDuuAiKBLXYgNRfKBVbhxK0//aC56f+oayz0P
 4fiHtMAXKNJlzneAUJVN8qycs39r/D3YPJi7V1ewcxulUl/tzU+j6LT/TWZNyibhb9oq
 hV1omK2NwXwhiu+9KCyItD+a3JLlM0Z2EhcDdhlPEPn9Nmm5kLj4hESfcDAVm8QZOGHL
 doLfQ8GqMmIJtB5/VXFbhGpZYnuREO/l8d6f9Ld+DoDdhfiYzrPSElHFEjLJDFfP/VxB
 cNDQ==
X-Gm-Message-State: AOJu0Yx6sWdKlkJU2+9yta233+3JB4COCrwsKraaIuX9BhJa2HE/3LSF
 5++s2f3OM0sjjugOVInsF+VGVoglNowKlGQM547Dh5SHGKK6zogLAtKnrggoogKt24pFsufeVfa
 F3RUy
X-Gm-Gg: ASbGncsA3AwgcW31Q/yCtCTRdRFEm8no275awr6YPh2hk9JqpjLsI2ZSftf0wCkR7+m
 PqURcoxSOcNQ+jesJBg068WiMILiZT8NNp9SBKcKguEpHct97LAV3IILubElaIayWKjE6c2Pofc
 ZhFAFsYirFnx1c5R+WyMPfuPV1QoFIVmUeM/ypY+rsVtpo9im2WqI5XkCIDbScsnKCbwVdXCgPn
 +79STIbHOAxIFSASMw9NBIHbgIoUKhSe6IreaY4OiVitFXWrKCgTGvJByyulyNXyn4r+ZUsvOP0
 4r2ALS7nTuVN82GQ7+nmMFCk880BFCpRuqG+Orq6dx1M5XdK04tDGHBRKEmmSXCBhz4Y
X-Google-Smtp-Source: AGHT+IGEUbNS6fUD2J+4+c6mukXCxf+pqV4qLJ3+rIwndQaAvFO+UBg2GetW05FzLWsmZ77I5yv0CQ==
X-Received: by 2002:a05:600c:4ed1:b0:442:d9fb:d9f1 with SMTP id
 5b1f17b1804b1-4533cacf7c0mr95856955e9.4.1750082801226; 
 Mon, 16 Jun 2025 07:06:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13c192sm146561975e9.26.2025.06.16.07.06.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 07:06:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
Date: Mon, 16 Jun 2025 15:06:29 +0100
Message-ID: <20250616140630.2273870-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616140630.2273870-1-peter.maydell@linaro.org>
References: <20250616140630.2273870-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The AN500 application note documents that it configures the Cortex-M7
CPU to have 16 MPU regions. We weren't doing this in our emulation,
so the CPU had only the default 8 MPU regions. Set the mpu-ns-regions
property to 16 for this board.

This bug doesn't affect any of the other board types we model in
this source file, because they all use either the Cortex-M3 or
Cortex-M4. Those CPUs do not have an RTL configurable number of
MPU regions, and always provide 8 regions if the MPU is built in.

Cc: qemu-stable@nongnu.org
Reported-by: Corentin GENDRE <cocotroupe20@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250605141801.1083266-1-peter.maydell@linaro.org
---
 hw/arm/mps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 58efb41e6db..bd378e360b0 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -224,7 +224,11 @@ static void mps2_common_init(MachineState *machine)
     switch (mmc->fpga_type) {
     case FPGA_AN385:
     case FPGA_AN386:
+        qdev_prop_set_uint32(armv7m, "num-irq", 32);
+        break;
     case FPGA_AN500:
+        /* The AN500 configures its Cortex-M7 with 16 MPU regions */
+        qdev_prop_set_uint32(armv7m, "mpu-ns-regions", 16);
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
-- 
2.43.0


