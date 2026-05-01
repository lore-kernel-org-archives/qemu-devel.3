Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5822BCCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 16:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIqho-0007hm-KQ; Fri, 01 May 2026 12:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIqhk-0007fL-UD
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:27:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIqhj-00088x-9W
 for qemu-devel@nongnu.org; Fri, 01 May 2026 12:27:04 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so20064835e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777652822; x=1778257622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r/XvK7vLIANXLNEYBnV3CyH3GLQskKOmAzyK3K6rMN8=;
 b=oaFbASJEzkjYPRdnbcDIRevCkQ2mo+5+AQ5VoxGOHurEvwfz45QCaHn0eZWGnapeis
 JCPUVqmpBp6/Z2CNBM6BKXLgLoU/skRn/LwbRMnKXLZlFrQ8z87kakfvO2SaNU77DFar
 TZ6nMsSFwuV7UsZCyDvavK6tFk/EbNjiJS5gF+uBZYMQm7wgdTEkBkoUvJ41Lwl24o2Q
 3lzCflH5IRpAqwV47svNEV3wqySgvcYEVFkC6yB5jKpZZKyp62bEnHV77ljM9+1Ws8GO
 EDD/3d/eNTNc82WLB3Nolm3D5ca/yX7ibau80/kEkHiYvSX6kcPUVAGVT5GD0ws0n8qB
 11HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777652822; x=1778257622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/XvK7vLIANXLNEYBnV3CyH3GLQskKOmAzyK3K6rMN8=;
 b=fB2B/JqBx2fApFeuy0+YoifdVxLORLsVd8cG05I/F05vpEDwTz7xY+r8K00bDZD3R7
 0fN+kvDb2uTjwWUEjO7lQU3/mR4pecpYEMx+VRO6kuJm3RnxPL4dwsCx58g8OGlKLFaf
 mc/l03d5RL7uAITAA0cjS7gGNTWmpAA/pCk3OwJWrVV3MCt/2JXhNx9eQCKC7f/98SM6
 yYNJtop9J5WQFuZ436rAw0opaT2PGercXauUNW6haF+3f3qhbu+UwJ4qWkXNJT1bMBxm
 HpUCQEytINWUrP47C38O0gYW4dYI9CKRHlcD8EgQh2+4/0YjyOhnETUYW6wvUlNS8ZsZ
 1wgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y20o3SaIM5wWdwD+8rq1nL0LL2k4PG0BWGOgmPuw3vPViXxGQMlYoLWpjfDMNoGnBPT1iHruiWC5I@nongnu.org
X-Gm-Message-State: AOJu0Yy/Vu/rvaqlS89N7zy2vwU0gIdCgYFQxQPeDKLEeQd+064lGYD1
 c78V9182Oyx8zZz/M9aVwuIXWqvEazqvbTcUkYi10OlqOoZEOu9Vp7GCYFVWG+glqh0=
X-Gm-Gg: AeBDievuTjGkrs/MVFa4AMnB/8Cn3RnKAcwTy/YoJWNc4eT/XfTS1Zlqnm5W2Y36nOJ
 6tQtVZfTpmFRDVNJF1LSUCfibycSSmi3oW1+qLp3lIBnIK5iEOWqiM0nqUCzRpy1JMJ1vpZ+PYK
 B/wCqcUzLjBpyoHlnwLyswQrCGQ51yiB7xxL/xhQXVL8T4sO34Jd7IQu0XS6vgu3+FOVt1txzRm
 pYVGa58SmErFqyWb/BNU/435MGrcp9miVM8W5PpzswUOMsM75mB4f9sOmataZnL9AJTyNQrRCs9
 Ul6W3pqQOHoRYME3TRoRLsw/hqYc8ujPrLyjwFM/iZyenekekDj79PssTVoXXlja0ubjlKT7P5D
 nBI/w3Yy6Abqg9hykx2BLaHMO9z2hwYyi2Krg5m5f2GVXhhiAYvygG80YpQ8XnfHM+9sjhqS3Mw
 Yoe0cgxmabn27VX0F7R15ZhJbgNIBfqlS/iQ/s77DBbYHjzenfD6mPo4fwKFakVnZ1EfLFYz9XU
 3wOMwnNcIXGjwRIDS2hfI1QO2Qku3WQRAS+8IgA/A==
X-Received: by 2002:a05:600c:1907:b0:488:c683:be89 with SMTP id
 5b1f17b1804b1-48a83d6ee9dmr133144235e9.9.1777652821930; 
 Fri, 01 May 2026 09:27:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8feb6647sm16297535e9.16.2026.05.01.09.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 09:27:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/misc/bcm2835_rng: Specify valid memory access sizes
Date: Fri,  1 May 2026 17:27:00 +0100
Message-ID: <20260501162700.4092512-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The BCM2835 RNG has 32-bit registers only; specify this in
the MemoryRegionOps so wrong-sized accesses are rejected rather
than getting to the assertions in the read and write functions.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3394
Fixes: 54a5ba13a9f ("target-arm: Implement BCM2835 hardware RNG")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
index e4d2c224c8..bd4acade5b 100644
--- a/hw/misc/bcm2835_rng.c
+++ b/hw/misc/bcm2835_rng.c
@@ -93,6 +93,8 @@ static const MemoryRegionOps bcm2835_rng_ops = {
     .read = bcm2835_rng_read,
     .write = bcm2835_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
 };
 
 static const VMStateDescription vmstate_bcm2835_rng = {
-- 
2.43.0


