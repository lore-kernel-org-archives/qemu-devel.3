Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03B4C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xef-00049L-2p; Mon, 06 May 2024 08:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xeC-0003iI-Nx
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:53 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xe8-0002ZX-LO
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:48 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2e242b1dfd6so21495251fa.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999239; x=1715604039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0IuTaR/rYPSDHaMLMAN6l0+lNFCpJZOF1M4qKW9REw=;
 b=dmgSOB5kYn/53JNrBSp7WSF9MDAMHJcaipEADqQrHj0YEcllNGEuGb2ss0TqLy6TWM
 yVk+lg4x26GJyxp88MxgoO8Fjd18XvwqZcUCC9yN21JmpHX0Y/2VuExJ8iuzJQjgeubP
 2ZdbEfruDk3BmvmNI0kfhM8cIbW9shAqKGa/mFkOc2Hv03b2K1GLSEwQKCsCz++SRa9P
 USSPlGytcN64Xh6/KyR9kD8BWCnLEdS6OlYqisPTt69WuriiPt8V4rYNIgPSK2/qWnqO
 0Upkfd6WqRrfhT5t/L/XP2557/tpltZaletqyoSz/NwQaJ8as8+bB9EBz3BRyvFV9K8U
 fQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999239; x=1715604039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0IuTaR/rYPSDHaMLMAN6l0+lNFCpJZOF1M4qKW9REw=;
 b=M/3RteKKXUEZvYTKQQP9YoUxMmPirIX5GpfE+w6WZU9efszY3zmrttl9/0jhSzWAcN
 JLSlF6xJJh0o6fjopwAiRPUvYK+KXB5JEv+iO/4Fx0uy2GUaEqDf+rMjiDRW9ZRdwmL7
 f7kYDSJLi8Z8iNm+zSZcDqHFPD0E/7OLL4nkYUduNmPAt+Yz5SlXhIy1U6Pn0K0bDHaD
 wo+auSxQY4KkHh7+QrqyRq3Uj98mlSEmiSHsqVciBu/d71jnMqqJqTWGFWrp9eght+lr
 zuUlUPpSN3GSbpeVnsq/mbNn9wGzDZHwvLSRBinOZR65V12KYBVdclBJxnNuDwOaWUvi
 R1+w==
X-Gm-Message-State: AOJu0YwptYVjDk2JndE7CVgIYEyendnDDwPEdzLe446tiNnuM/mSaFdY
 HGRLKqszUNCUmOqaPRmT8r5Vt36+rnDri5W8asuE8FOxHOjA+KmBkgM7qy6zi3mokdGHQojyMBv
 a
X-Google-Smtp-Source: AGHT+IHeSLRnwD3T2bj3xVb3JO1H7O5UcHw5rFWIF3GeirjrV5PGE5wiz1PSX7isIel3AgFSmPwREg==
X-Received: by 2002:a2e:9d19:0:b0:2da:d986:e387 with SMTP id
 t25-20020a2e9d19000000b002dad986e387mr6514067lji.50.1714999238791; 
 Mon, 06 May 2024 05:40:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b0041902ebc87esm15959719wmq.35.2024.05.06.05.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng.cn@windriver.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/28] MAINTAINERS: Update my email address
Date: Mon,  6 May 2024 14:37:28 +0200
Message-ID: <20240506123728.65278-29-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

From: Bin Meng <bin.meng.cn@windriver.com>

The old Wind River email address (bin.meng@windriver.com) is no longer
available due to an internal infrastructure change within the company.
While a new email address (bin.meng.cn@windriver.com) has been assigned
to me, I am unable to find a way to send this patch directly from the
new address. Presumably, the basic authentication with client submission
(SMTP AUTH) [1] has been disabled by the company's IT.

Switch to use my personal email address instead.

Signed-off-by: Bin Meng <bin.meng.cn@windriver.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

[1] https://learn.microsoft.com/en-us/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240505072312.2776074-1-bmeng.cn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63ada48bb4..84391777db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -320,7 +320,7 @@ F: tests/tcg/ppc*/*
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 R: Weiwei Li <liwei1518@gmail.com>
 R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
@@ -1603,7 +1603,7 @@ F: include/hw/riscv/opentitan.h
 F: include/hw/*/ibex_*.h
 
 Microchip PolarFire SoC Icicle Kit
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: docs/system/riscv/microchip-icicle-kit.rst
@@ -1630,7 +1630,7 @@ F: include/hw/char/shakti_uart.h
 
 SiFive Machines
 M: Alistair Francis <Alistair.Francis@wdc.com>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 M: Palmer Dabbelt <palmer@dabbelt.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -2126,7 +2126,7 @@ F: hw/ssi/xilinx_*
 
 SD (Secure Card)
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
-M: Bin Meng <bin.meng@windriver.com>
+M: Bin Meng <bmeng.cn@gmail.com>
 L: qemu-block@nongnu.org
 S: Odd Fixes
 F: include/hw/sd/sd*
-- 
2.41.0


