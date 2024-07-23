Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB5C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMIL-0004XQ-Ex; Tue, 23 Jul 2024 16:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMIK-0004Uy-4j
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMII-0003xK-Hy
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:39:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3686b554cfcso2898473f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767172; x=1722371972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAWB86PPkrxBCeTbR27TWMyKaulXnrAS2NRotSYIsdM=;
 b=GrDVkwtL1XQYfkDs7gWiFxfboUJl0stRVHNg+1Er2v6VoUzGBJQK+smVLwPU0Ae3x6
 lo1pESbNo/SIowKNvfEe7Jvk1KjkWbps5yx4Q9KKGOhDeC9Uf9bQxx8rXqFTERXkECw0
 kaBnV4F0aeDKfpqYdbssvnjaYTelnv9hIU7SQXPkzueVzAeJxB/sVhTloMxrQrU21maP
 jwy7l90lVrPaqdExIWPplnv5kH24VT2W7sQx5gCIEb33eNKgDC5pbOtmo4LOlDatYnix
 PLejprUUA38MhrJNLQeAFqJXMAjJQfdAKYLAMM+UKDLhIQ4g/tvukZwh7REbRZ2Fanlt
 7rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767172; x=1722371972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAWB86PPkrxBCeTbR27TWMyKaulXnrAS2NRotSYIsdM=;
 b=h/Az2F2cTEfLY1nH1u1czAHGsVEk1Kym4FmXI3lqUSPQJN/qcRhc+xAlD6W2LCTpt+
 Pcd//zegpVFveHNiDpUdptwwLgVAd7G8OwXLdhUIgP0o3HyCiUd5JQ0Bc0toOOK/hE2U
 b2mzDFz5uYGBA+h19lnEG7m+g9mvWWmVLObC2QRHRxqhSnpyMsZpB5zTXM5+Uh+97d4F
 IqekJ0ptsE8Tml+ioQ3oUz344+dk6/Ci9eSL60uCNapvqVE0X3yA8terfXkIjFrBWmMN
 9CmuAVp0zGCbZNFzJ8nV3Y0Kt7GbXHTFhlvGfbjpA8P1fqY2/jgv4JuIqrRsPpXCt78D
 hn1Q==
X-Gm-Message-State: AOJu0Yw/A3Vba8YgtOj3Nj9TOTGGj5OU7+PwzpqXkbknIfNyZhilsRC5
 pkrjLclQG+UtTFv8EVXCI2ZR3yBhX/+AvtUoDM15qWTC6IArbfDC5Isa7mBweAU5mueYEwmChVy
 URi8=
X-Google-Smtp-Source: AGHT+IHw/i222pDAcGyYQI8uppF0fFUZwINVRbOj8+ub+D7NNjE+u6ksBQZ2RPTYluT9BDgGr9VL4g==
X-Received: by 2002:a5d:4d01:0:b0:367:923b:656b with SMTP id
 ffacd0b85a97d-369f5b0b8c5mr36823f8f.54.1721767172756; 
 Tue, 23 Jul 2024 13:39:32 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427f93bc977sm373015e9.42.2024.07.23.13.39.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:39:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 06/28] docs: Correct Loongarch -> LoongArch
Date: Tue, 23 Jul 2024 22:38:33 +0200
Message-ID: <20240723203855.65033-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-20-philmd@linaro.org>
---
 docs/about/emulation.rst | 2 +-
 hw/rtc/ls7a_rtc.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index b5ff9c5f696..3bfe8cc14a2 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -42,7 +42,7 @@ depending on the guest architecture.
     - :ref:`Yes<QEMU-PC-System-emulator>`
     - Yes
     - The ubiquitous desktop PC CPU architecture, 32 and 64 bit.
-  * - Loongarch
+  * - LoongArch
     - Yes
     - Yes
     - A MIPS-like 64bit RISC architecture developed in China
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 052201c2cd5..3226b6105e8 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * Loongarch LS7A Real Time Clock emulation
+ * LoongArch LS7A Real Time Clock emulation
  *
  * Copyright (C) 2021 Loongson Technology Corporation Limited
  */
-- 
2.41.0


