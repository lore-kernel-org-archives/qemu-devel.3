Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041B0CD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 13:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snHht-0002uS-E5; Sun, 08 Sep 2024 09:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHho-0002pZ-Ij
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:52 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1snHhm-0000fI-C1
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 09:11:52 -0400
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-5c3d20eed0bso3380775a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 06:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725801109; x=1726405909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QChWw5AXY/Eh/tPeZIzDezE86tfwMhZTwskv5OivgNc=;
 b=jQO6PMfTQPum76YKF1p8zuYAD0V0kddLE5tpKvh+dbBM3Hpppg74t9gxzbsFKQb0Ru
 wl1QvI2U+f5TWqYUevYbmOHqoI6hBcLBTf4O1oFDDZ9z9vp1v4yRYIoHabcauvANE1FD
 S9p+tBL4GU/w+iq8NIGQWQG4kRYEsT7ZNBI2P86Gsn2UjQwQbBe6fB0jZ4Lu675gDdBe
 X7xrhvLewO403a+73UO7ec3KO5OrxPwwqZnWyFwzr4iFg1Jz/vZZ6rEjGWWijJ5QJrOm
 bDAt2RY20mGR94WFLGZUaKS+dw6fQtw9b3Y93OOUf18LCoino/Vf4kx4s2Cs5VgrPjFE
 K3lQ==
X-Gm-Message-State: AOJu0YyBkYUrWQp1ppnmdLmBdVKP15yh6zgcBNfaeH2ZBBdlBOOOo+9G
 bWjlWGDPCznuMT9Wcgm2mf3VOdENTft7IELmvH44dUE+i32eeHLINJz/Lw==
X-Google-Smtp-Source: AGHT+IEW14NK54vrKJTAHbHmO5knB45raX2tnm0p2YVE4LYrIZy9el7V8N26AYLFKuwW4cpUut2zhw==
X-Received: by 2002:a05:6402:13cc:b0:5c3:1089:ff23 with SMTP id
 4fb4d7f45d1cf-5c3dc7c92bfmr5171376a12.35.1725801108417; 
 Sun, 08 Sep 2024 06:11:48 -0700 (PDT)
Received: from fedora.. (ip-109-43-115-52.web.vodafone.de. [109.43.115.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd5212asm1842418a12.57.2024.09.08.06.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 06:11:48 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/3] hw/m68k/mcf5208: Avoid shifting off end of integer
Date: Sun,  8 Sep 2024 15:11:26 +0200
Message-ID: <20240908131128.19384-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908131128.19384-1-huth@tuxfamily.org>
References: <20240908131128.19384-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.46; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f46.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20240830173452.2086140-2-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5208.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index ec14096aa4..0ad347dfa8 100644
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
2.46.0


