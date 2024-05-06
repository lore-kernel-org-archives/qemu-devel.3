Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD606C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xew-0004WB-CY; Mon, 06 May 2024 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xe0-0003e2-KO
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:50 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xdy-0002YD-St
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:40:36 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2e2a4c20870so24071431fa.3
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999232; x=1715604032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkL5eliVD3ZZyqFaQzJbXHxlNyzeRrAKJ2SMZi0kzO4=;
 b=ovsYD8s3naKOvQQJqIeDrdxWzaSWix53h+sqY/IfbEIKdejNEv1PgyB7LEehaZwa5q
 dIZjptyuufVad0ZxoSkah2tG2jEE3uj6K4fwMG4NUY4ADSoC7JxsRCClt9QwbBfQPinn
 rKxWgbAMTIZNdfVlgP5bYWx9+rorb8nNbHJV+eoGtSJOuqKYdHGu6qRCZWEn2s5C5fS6
 RBRz8U6RfEhgqAVDW3Z/U12KQc2BDWtnk2e2N+YdPAWX7mo35D+fXE+dZaUI6Qyd8+Au
 m5cKHvpEWZDfMwNJD2xHxeygFQSwkE5hdXannBC5SjG3hU5jRjwOwAubnxvo6YLRg7g/
 6xOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999232; x=1715604032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkL5eliVD3ZZyqFaQzJbXHxlNyzeRrAKJ2SMZi0kzO4=;
 b=SfoD/I/V+jDIkkzWI+VpGmyiWURFzD2gm3hZoMwVZVbwsqRBQrkY3HP5WgT7fJrDAT
 MjJoLyIp/yXGG5EzaKzJVpX/ZaCFptD3tvar0KOHt8eHTQvUaWNov6wgEfPzhuyoVCw1
 imIzisvfu8iqYQP/WNcly7r2VZBjQtRIG1p20IehL6+VPCPWYdVW1wi9IxhLzqWrsvEI
 5ahx5X5LCcMMrpNu3HES5DxMf174PglENxPTYMcXBrQkRtB5ki6KgCIB6vfxBPM7HDZl
 BRFFWDLIv0MAh22XAqyvL0pamBQCe4JEPmrWz1YHhFzyf43QhW2Chgk2cxNHILh1Xkc/
 Buqw==
X-Gm-Message-State: AOJu0Yz//bEpiX+RtPevT6CZWSUoWNXFD41n9JDgZGGi5x2gtqv/N62z
 biq2VNcvmlsPp/VwMeC+qOUBxa/ClBSa5/oR215fvvZxVO63MAyC0RmvuVs3ijI4NYzIVrF5cS8
 m
X-Google-Smtp-Source: AGHT+IEapOKP390YtIWRC3pM7KQmejmHpo+AOYFejMDBJlkEmfwnkzR8O3wZSfEqGXuUEqx0Eb2irQ==
X-Received: by 2002:a2e:a58d:0:b0:2e0:1349:1eb0 with SMTP id
 m13-20020a2ea58d000000b002e013491eb0mr7318261ljp.43.1714999232200; 
 Mon, 06 May 2024 05:40:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b0041abdaf8c6asm19693892wmo.13.2024.05.06.05.40.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:40:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/28] MAINTAINERS: Update Aleksandar Rikalo email
Date: Mon,  6 May 2024 14:37:27 +0200
Message-ID: <20240506123728.65278-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

From: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>

Syrmia LLC has been acquired recently and the syrmia.com domain will
disappear soon, so updating my email in the MAINTAINERS file.

Signed-off-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Message-ID: <20240209062147.62453-1-aleksandar.rikalo@syrmia.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 595808fc96..63ada48bb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -285,7 +285,7 @@ MIPS TCG CPUs
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: target/mips/
 F: disas/*mips.c
@@ -1335,7 +1335,7 @@ F: include/hw/mips/
 
 Jazz
 M: Hervé Poussineau <hpoussin@reactos.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Maintained
 F: hw/mips/jazz.c
 F: hw/display/g364fb.c
@@ -1357,7 +1357,7 @@ F: tests/avocado/linux_ssh_mips_malta.py
 F: tests/avocado/machine_mips_malta.py
 
 Mipssim
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Orphan
 F: hw/mips/mipssim.c
 F: hw/net/mipsnet.c
@@ -1385,7 +1385,7 @@ F: tests/avocado/machine_mips_loongson3v.py
 
 Boston
 M: Paul Burton <paulburton@kernel.org>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
@@ -3762,7 +3762,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 R: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
-R: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
+R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
 F: tcg/mips/
 
-- 
2.41.0


