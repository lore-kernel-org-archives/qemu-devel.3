Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533D4CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 17:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk5WX-0004y0-5H; Fri, 30 Aug 2024 13:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WU-0004tY-WD
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk5WS-0003O6-Dm
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 13:34:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42bbf138477so3879995e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 10:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725039295; x=1725644095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hTjpBg36zHF05SzURNvPqThL65TJ1O2Awt657MNLYHU=;
 b=xfeemnDMuDYtIgYKwmyY0tFEb3fXnUlCDuComNRgG7WlJk5HnFuaxGrT0/QWlDZgwe
 7DxcP9mI88A6HQOBrqt/Opl/tPIo/AXdQE+KjuRW78dJowb+o9v9KmzVsrVacde5E28U
 3/Bt34M3rBvApMkLx8ybcBRWBGCihiee1ikYcOn13JzMSCzdc+n9dmXv6oGoZ6McqaLm
 n0oXs3g5U81L1D8qvO0CX1fcFPMF3ka5r0Tt1Ii5LApjkaDe5iSJRh0R9GALXlj410Kc
 etf9dubqcxzSqf1Zg+f1uVH0Wctq9iOfvkZ8CKsqbk94JHVtgH5LY6PfjlFEqEvb69rC
 8owQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725039295; x=1725644095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTjpBg36zHF05SzURNvPqThL65TJ1O2Awt657MNLYHU=;
 b=XFfrbMWx94C21DObZcfFs6bY2VSpMAqR2EaNxof/k991+qcCoJNnMmCmj81naaINE/
 fiWpWKkJY6Oal1kspJeGkSdTYqyPV/yi9f6x709HC7HsnstpaWlXYTFBZijfLnHD3wNz
 s+NM8F7Tt4KSkikByLktxBHHpgTYis9wNQZg9cx3g5aWCdn1nT4+oWF3RgPnKrZfd5Ck
 2TIJ3eziBbaFPjp4ZQeiEZOLLxCkhbn89Y7hwERdnFr3HNFLYmjVpxXAMcLW9w8l3vxB
 Q5VpJj2HpX/+aEbqsxlFP219UrHVjnSpbmw5+vhJbFSg+buqoAMSYabL9HbtaoJ8mREX
 NDHw==
X-Gm-Message-State: AOJu0YwX3K+DVUOEhPYw25rdW3WUpEUdku6r1LYoinpR2GEewRvWqAAc
 yhw1Z2gvxJv6vDTc1Uh6A3MWbpZaeUbg1CyewLRgn/vHBAd5O4eK29tRxaQTZwE3Fn7H2AfzbJn
 W
X-Google-Smtp-Source: AGHT+IEw7nXy7wC/HQOd12xidkxs57afPG8TDJsTaSB0YKYKddP7cBAZJ/NvBWEUhIN5aT7B8K+VMA==
X-Received: by 2002:a05:600c:4f42:b0:42b:b016:94a3 with SMTP id
 5b1f17b1804b1-42bb0343a6amr56735035e9.31.1725039294637; 
 Fri, 30 Aug 2024 10:34:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb37f7849sm58471775e9.7.2024.08.30.10.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 10:34:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 1/3] hw/m68k/mcf5208: Avoid shifting off end of integer
Date: Fri, 30 Aug 2024 18:34:50 +0100
Message-Id: <20240830173452.2086140-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830173452.2086140-1-peter.maydell@linaro.org>
References: <20240830173452.2086140-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In m5208_sys_read(), we have a loop of n from 0 to 31, and we
calculate (2u << n).  For the n == 31 iteration this will shift off
the top of the unsigned 32 bit integer.

This is harmless, because we're going to stop the loop with n == 31
anyway, but we can avoid the error by using 64-bit arithmetic here.

(The SDCS0 register is documented at
https://www.nxp.com/docs/en/reference-manual/MCF5208RM.pdf
section 18.4.5; we want the lower 5 bits to indicate the
RAM size, where 31 == 4GB, 30 == 2GB, and so on down.
As it happens, the layout of the mcf5208evb board memory map
means it doesn't make sense to have more than 1GB of RAM
in any case.)

Resolves: Coverity CID 1547727
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/mcf5208.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index ec14096aa43..0ad347dfa81 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -158,7 +158,7 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
         {
             int n;
             for (n = 0; n < 32; n++) {
-                if (current_machine->ram_size < (2u << n)) {
+                if (current_machine->ram_size < (2ULL << n)) {
                     break;
                 }
             }
-- 
2.34.1


