Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA638CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENEJ-0005rS-3N; Wed, 07 Oct 2026 04:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIww-000175-BO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:08:18 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIwr-0005px-3P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:08:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6ae14eecc64so4957598a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791346082; x=1791950882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8K7Yq/KgL/Zin4VcTKhCZ6b8VSA0wVYhUmnTHSEofyE=;
 b=ri7ojN4Rh2dSupTWnCDN8qy4CHFWCb/AZR/yj07R8lOX+6q/57MeBlBVjgEkAAI0/E
 I69zmd+sGY9YJORvL5Df1k4rpH77CjC4Gye9rStCe1VEc85wnDVzG3fc2zjN5TA8BGq9
 l6soxvSgkWxYs4wFDtpHLKx2VvekHzRqoWkbfH+So7hODvs4iLaOqh67MUCUXYjSppJf
 RYEInIKqElzR3UTH7aQS4QZV8/iR50d5wcijlSfvkYE7ekMPcpRF26bs2oPJe5UJrlQp
 wDMc/PhNj8jwbnxpAqVtk7tnjT9GBBZ9EqoTS3ZK3vCnM1mlpOodM+utMDd+N2Rixpzz
 zpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791346082; x=1791950882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8K7Yq/KgL/Zin4VcTKhCZ6b8VSA0wVYhUmnTHSEofyE=;
 b=GDzjJVwA9NylIXe9dQyDDqWBjKCXopL3OeEUVV4uXEKfS4TPlbKbE1upYyD6r4TULn
 84oISRxpJUVAB2OmzilUo/Mzk5NSh5QXs8ynvY11ARMde7HobOE9RIn8ZhxriSovAVgw
 I4FCk+51pR7w76uwzHATWb1ZvvVCDjUgmRD63wAa/Dqp4vNow42Kc2HXlE+z8AOSgmBo
 J6oXSwhWdqoU/D24VKxQIJC14KCQjAeDYZc1O47cimuyovrWQMHMbGbTFUyknRkPKK1N
 IN0dTpwYPRx3w7BFkgprWsR9ntXZ+TjSLERAb6p8VqA9LMqv4Anqbynne4vC7CgbrdcR
 pwjw==
X-Gm-Message-State: AFuF++mIk105vKWdBWd1JnD7pIV5N33XUk+MtkS3Y/p/xLHs4BuldfS3
 bUzsE1YIYUXK1O++ZjpuMGcR6b6sSh/ny84da2RBd5mfOy2/NA8zecG7fU66Fg==
X-Gm-Gg: AYBFou3xEhAY70MEXHRpfb7akYFMB6T9pzAokqazVYedRLv+eByFeXdTrT5fJF+Clng
 hPh0JBrxr++ErBRfSA6C/5pP6vQ/hm4ab0u/BptqeFkArAvPAjXNnGCm5rDBYOGsKitWLNGV2Oe
 vN3qKA163dgE5W3pSNwf4YOfD0WFUdHbL8YM721tPsX3yChPTfuU2DtwaZqSbxFDGB+zKQMUvbu
 fjhCVuiAkF3w4XVknwL51YT+0ztJpmMIDg3i3COLX0VOzGxefslnGoPCFWmhZ/DCjDDh+wvZvwo
 I3Pc/TrBp0xY7wqcKf6wI8AC85gf4tFgPg7pODorOIUyMBH07Zv57JARFlLtrwR5gIKDjPoq/dT
 SR+6pRfarU0TRkc0HAodZZnwzHRF3DZlzEWU5XS1igbJjysrVZGqlKXmNqrKIv7OYyVMT3Pf1fz
 +ByaVKwbGua0vorJGvDYO2jc4XDwniMK916l21hxL92sEzbY7YQnO77Nis10InxEyyR+FbPZC48
 aOgK6q86JGL+WEnDjWzqQxF5eeKyissu5yruQ==
X-Received: by 2002:a5d:5f50:0:b0:488:8111:6f56 with SMTP id
 ffacd0b85a97d-48c6d0f4c77mr1187617f8f.8.1791275721430; 
 Tue, 06 Oct 2026 01:35:21 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:21 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 01/31] hw/watchdog/wdt_imx2: Preserve own locked bits in WCR
Date: Tue,  6 Oct 2026 10:34:13 +0200
Message-ID: <20261006083445.30362-2-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Apparently there is a typo in the WCR locked bits handling: The locked
values for s->wcr must come from itself rather than from s->wicr, so fix
that. Without it, guests such as u-boot may experience inadvertent
reboots when configuring the WCR register.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
cc: qemu-stable
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/watchdog/wdt_imx2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index c83d4107c1..3283990bbf 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -156,18 +156,18 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
             value &= ~IMX2_WDT_WCR_LOCK_MASK;
-            value |= (s->wicr & IMX2_WDT_WCR_LOCK_MASK);
+            value |= (s->wcr & IMX2_WDT_WCR_LOCK_MASK);
         }
         s->wcr_locked = true;
         if (s->wcr_wde_locked) {
             value &= ~IMX2_WDT_WCR_WDE;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDE);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDE);
         } else if (value & IMX2_WDT_WCR_WDE) {
             s->wcr_wde_locked = true;
         }
         if (s->wcr_wdt_locked) {
             value &= ~IMX2_WDT_WCR_WDT;
-            value |= (s->wicr & ~IMX2_WDT_WCR_WDT);
+            value |= (s->wcr & ~IMX2_WDT_WCR_WDT);
         } else if (value & IMX2_WDT_WCR_WDT) {
             s->wcr_wdt_locked = true;
         }
-- 
2.56.0


