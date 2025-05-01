Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4563C3ABAA
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLj-0000xT-FY; Thu, 01 May 2025 17:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLS-0000lU-GL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:26 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLP-0001SR-MU
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:25 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b0da25f5216so1008791a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134482; x=1746739282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoLRODbSVmu/s22GYq49CkhKkoU0A0n4gJqgkN8qflI=;
 b=e2XCnQ8hgEKkJCrlTrtDoVRqOV9rkXJe6TSEb5FMho4RuxB2Z2s/auRg91M83FHY1H
 eU0jRRbgGnBPLS13QrmSOIY+1sx/rDaerhzpmL7cmIpjL9ArXNBtBryDzMA/kCGM98pD
 KgaDEAJb8WLFJRV2sUYAs5InkyK3lbqMkwP73PmJqih9hITiS+OVY8V2PYR22WxYJ5an
 yaLOmD4cD46zfJp8IGak2KdboIUIniwSvLPQ9kBP2mIJodx2w/o4bE+XfYdcexvB83Cy
 LfrLwyT7QxJE7XdcUYGoPpZAode86BzSNnZoMOg/1QrW6b1HRe+pnas7hWsAyMUUDyyi
 YIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134482; x=1746739282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoLRODbSVmu/s22GYq49CkhKkoU0A0n4gJqgkN8qflI=;
 b=fkE2rmgOO6ppa2Blo4knEFBfU6iltVO9AOOda7YncFZHsIsXnBMuLjTwzHuoWy0F2r
 Sgm1jjbv/G4sIA3CQ52z/ki2H5qOggq5tFuSUOvDbUpPJEQnqC6ui9bf4AsNNbueI84H
 7cgJdW6nQw4X5AJJ/YgJrW86NAHx9f9Qe74NrmYZQnn0FtT9qT/v+Mu44ltuvaZEz24G
 tV57eVN9s8MAhOGmKaJYxd1zNUq+1HTq8KkpO4zm7bufwKZRcs4m/X7gBIhFTtfeUqk+
 zkHGNfZYjrbt4D0Py9EDDjPXggcE1OAl1e1ZAqjr9WPB71Mugl7AhgbJts5mNsN6PZP9
 6mTw==
X-Gm-Message-State: AOJu0YwcRt1HVvUkojGDvBQg5dpY/CwA4xsURuAbD2ngueUEliWs182+
 tkw41WDTqrAQDKwQGHJF0abnRnE4KH91ToZPcOnoUF9uE9Iwu4B/NRboqssQlY4DwStS9HC0+Nj
 7
X-Gm-Gg: ASbGncvwgcHtUjK/9TZGDPviltL7ZPCMZ2ztd12Mqk701hM70wj6hIwk3SfM5jqCR2Z
 HmAJKLXhIqstrHr+aHe6nzERoJuPw502G3JKnMAI/vH+RATOtmXrnSqX4R9M3KdcLIT28pVGeHn
 HltGoaKu9ob1qbClaVDzWVxsNmujjDPlzud5UkSmThaM8CPQuVMi4/Upnrc1y+kqlenjTtBR7Jp
 DtlJ0AE646mwuVF1jvb4mP07ZLy+YvmKICEueGjToLlw4tbsvsCnvSX5d5Sv59RAsvX1vMp5RE3
 Xyzc20YOE7AQ/OShq8/sLQLNB2K+u+FGOD1haKpWmw5Bsq7gARya98XnOAcIMbR+kIcfiJqRBek
 =
X-Google-Smtp-Source: AGHT+IHQQGP4Yl926oNf36EF9z3LcdFu3LiPPxqhsCMHmvc61KpyTh4RtkLaNE7i2BhiMUu7bn2x8Q==
X-Received: by 2002:a17:90b:5704:b0:304:ec28:4437 with SMTP id
 98e67ed59e1d1-30a4e6947a4mr687294a91.22.1746134482253; 
 Thu, 01 May 2025 14:21:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 09/59] accel/tcg: Simplify L1_MAP_ADDR_SPACE_BITS
Date: Thu,  1 May 2025 14:20:23 -0700
Message-ID: <20250501212113.2961531-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Stop taking TARGET_PHYS_ADDR_SPACE_BITS into account.
Simply allow the entire ram_addr_t space.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 1596767879..13d0376bc7 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -160,11 +160,7 @@ static PageForEachNext foreach_tb_next(PageForEachNext tb,
 /*
  * In system mode we want L1_MAP to be based on ram offsets.
  */
-#if HOST_LONG_BITS < TARGET_PHYS_ADDR_SPACE_BITS
-# define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
-#else
-# define L1_MAP_ADDR_SPACE_BITS  TARGET_PHYS_ADDR_SPACE_BITS
-#endif
+#define L1_MAP_ADDR_SPACE_BITS  HOST_LONG_BITS
 
 /* Size of the L2 (and L3, etc) page tables.  */
 #define V_L2_BITS 10
-- 
2.43.0


