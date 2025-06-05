Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DE2C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBQ8-0005Hb-P3; Thu, 05 Jun 2025 10:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNBQ4-0005Gr-KE
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:18:13 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNBPy-000188-AS
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:18:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so8741395e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749133084; x=1749737884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UzSqdQKz9aJ2vSPHh9ioBp0u/bmrqqTbXn12Ae53pTU=;
 b=YiAioirbqDV+UauyiB+5521GHs+QBPL0jFNLJ1gcaFl6/uerwd7u9ORyw55lhzaVNI
 npywytcgJy2zYe0g4sP9OPHpqV+Du1uMH041Twgb0xs+m9znzu8vCHjkx37ZzzNgQhg7
 CmgvVIFGYoDj016Eb7/oLxobtRpkVxaK92TKYQD5tJHDSR0N8pjccEDtn8MFj1gIplRW
 HajYaSI6Q5zSFPxJHSfp3b1hhnESGWeQ+yUOC5sKM/nbQ1EeXrP00w3tF+6NQ9mIuwZ8
 YOQRjC9MNAvjdAD0joHRxeEJir1CE445aNZf30kHXcuSNwvVW2iGqUeiXPZKDhWh1MaJ
 eoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133084; x=1749737884;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UzSqdQKz9aJ2vSPHh9ioBp0u/bmrqqTbXn12Ae53pTU=;
 b=FwNXXWx0x96l8QZjElzMpf+RBrKsWFeBXyLLfqgVcSDzlDPyKM5UzeTv7DjHRLTl4Q
 mmy+9hdWt8owS+S/ZlMP7ZVdiFWOM2LnXiXsVZoY64Vm0pfPA95IOxFz7FPsKd/uSaY4
 HfJ1/0+AS3OIfla8kkC4WpfsuJiiSHNEqxUW0aTzyrUp6YxOFU8j1qCbxoCTuGRq5IfX
 frd/y7/vO6aaxb1ddgWaioIfnDPKftwvCEslwE0gGAoPMqnGkknfuO/BQyVhTGkA1gHn
 4LE6KllZL1l0YGtpPGiqz6tskMv1VgBFYHS1KooFyVG2y6E1V+iTWV8ibzrMdfaun0gi
 4yVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVopFOLlB2CCW32pT4PfkVS5g2X5Z9pkFZugTmzwjgLnSo+JvWBBb7Q0WNTZBovpGrlBKgFUmMZkQ37@nongnu.org
X-Gm-Message-State: AOJu0Yy+bzUJJjJleXDk/4SyZaLamdO2/uknJnDlM7Zgsu2l2tILWKo4
 4bPpUrkRSvYa7s1gkeTGfKwcbK/NpjH5eP0Y7S4LPlCAaNdZI4xRb50uClvH5UxH2i8=
X-Gm-Gg: ASbGnctmtXgbbUOe/kPF6C1NUQLZuBmPapj7zKeHG6vXfQarL3KBcNNIH/Rbtu6wyB0
 +J0iJl4EMjq1xw/uVvAf5PmtnyJ+dPfJUJsvsUiTaagbA1nSOj4pjDA9XkMiPgdAnzpFoA3JMk2
 5k1A3c4e/DT0gaVN+7bX5r+btYZvuaZqJLVNsy0TpacdHrPm2Zd8RfLWiaLaLxCMdSK7ZzDXuIc
 D6l7aM/DiEtmj9xi+G7qKHWp2FjNSAnho5OKCYOcls4DVHw8U/ER5tXpSKYq/wklU/8CF/ON7Pk
 IdDqwPG+wf1YZ6szPQlK8bHdqQA5XK546cya1MbzFaxkv13OBdozggKtPQ==
X-Google-Smtp-Source: AGHT+IHrM/wbcx0Gx5J5R2d5zkfkuNE9yVYpgTMzlOa/CFKj2aJcZ+ZxQz9E2H5ZxF7lozh6NTaS8Q==
X-Received: by 2002:a05:600c:1548:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-451f0a72bf1mr74933005e9.9.1749133083780; 
 Thu, 05 Jun 2025 07:18:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb2213c1sm19756095e9.34.2025.06.05.07.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:18:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Corentin GENDRE <cocotroupe20@gmail.com>
Subject: [PATCH] hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
Date: Thu,  5 Jun 2025 15:18:01 +0100
Message-ID: <20250605141801.1083266-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
---
 hw/arm/mps2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 58efb41e6db..50e1a1c1c80 100644
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
+        qdev_prop_set_uint32(armv7m, "mpu-ns-dregions", 16);
         qdev_prop_set_uint32(armv7m, "num-irq", 32);
         break;
     case FPGA_AN511:
-- 
2.43.0


