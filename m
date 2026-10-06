Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD436CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENAF-00035c-7D; Wed, 07 Oct 2026 04:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIMU-0003OY-C4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:30:52 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEIM4-0006jS-Ns
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:30:28 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5ba3ec92031so1313494e87.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791343737; x=1791948537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N/5rhyy/mMpIN1IzB3BZV2jjbBviZx0PpmAocvijwJ8=;
 b=V9G32UL+p4hgzdmQQesduGbvKTbYclMnzcAuycmSbmpxRHRQP14pwEvj8qozQDkO/W
 AJfhjuPkpaJ3w2cgj3/Qw2hoRrD6a2bPCTrOR+i57naUu7UGTQEg6bEBy58HSdLNGFvt
 rgZa/P9Nu1md1gvBsib4MKX10w9WlUorYUPPF+nofB0zAPod8lj37rViq9A3brjZh6RD
 a+TTUEacFUDNcqJchcRiY/favczxqODyIy+wuoLwJLX+vFW2Hmkno+z6Mp0G74JEIL7B
 Ct1abjKPQgr+IPfOT3JT4Iiqq6lSy17F6YXkuzow+T0FEpuHcWToOHdAZkbjZmAqObdt
 rhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791343737; x=1791948537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N/5rhyy/mMpIN1IzB3BZV2jjbBviZx0PpmAocvijwJ8=;
 b=K7m/Vi+DlFXfQL3LJdxtijerVCqLKfQqbx+E7dSBH47ocFSsGnb2stVbm/nNa3S72y
 LHhE0AVG1gcPTJw62glcbTkwVqAJ1x5eKKNKK12O0UQY2cDbW0uQ8mwy588f9aYvPTF4
 HXTKhzNSrdBxRpPXsY7vk4360qYfOzsioODXYwV/6EoNvAHJ/4I1tYLTduXJZfMlYm3a
 dsOIy4JjlBEDr3u+vkZcqR0N0rJsZoGgjVj9Wt5lS8HI//YzeZVqMOfeiFODY5L0nO/K
 F9s9JJA4NwSqW9J4ujjPLsmCqAGx4GVz2EedoLAs1HleUAul4qSJOqT6wRkE5n0tJFc0
 Bd5A==
X-Gm-Message-State: AFq9FYKeZN8WulGlT7kU5omReewoSf3F67fbulu7Q9oNrw1KyffM4feo
 hcyiG6+pbjVyad9vONmTfz1Izf3pNNsRBM0GGPhZYUfAg6XjBAJlRbIzbdshsw==
X-Gm-Gg: AYBFou3x/9LLVMeE6+veLBn1QaKnytPooRK7eMMOzmTog501A0ytGFssEirhJBMLcPA
 Y94SPAtugChAxr6d2eYHSRbsH5773zBhGlcrFH06bOyYU0SmaxtNGkuKU4CtoQpnVDO2eBHHsg7
 r7blPWfp3trJCcTx4maquGvpMuk9KXTGjw5pbXQIYSlzO4FNNgQlQkJhptWzEFe9VCaf4fk3k7C
 EFB2iOKymqrx7ylqf6hdfZIbpgmymX8w1IMw6bb0seV8oA/arVju2O9aeIGkDqjc0uqPuPr5VQj
 qUqgnBBrbbyS4ju968+P175kC6rnCuV1jj5GkdjFzkublc7BlojGxkMbKzPfS/wmfHGh9MzXROe
 Q8ykIcRPMVabOc62PeT2C35OOatPOGIVmqFvDsslc6ogwmriAP0fZZ3Arct743fRLNO4tUkQq/C
 iAVHMT6Qik5J4ETlcZNCPKJj4CG+TT6UeooSgAblzHvbHVOeK30lZ3g6ZH2dcyn62Z1SRbgh5y2
 yekLc7Ykeod24U0fX+1tMwIllc5rexuS8LY9w==
X-Received: by 2002:a05:6000:22c3:b0:48a:eeef:b4a7 with SMTP id
 ffacd0b85a97d-48c6d1f58efmr1126312f8f.48.1791275723584; 
 Tue, 06 Oct 2026 01:35:23 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:23 -0700 (PDT)
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
Subject: [PATCH v4 03/31] hw/watchdog/wdt_imx2: Clear WDT lock on reset
Date: Tue,  6 Oct 2026 10:34:15 +0200
Message-ID: <20261006083445.30362-4-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The WDT bit gets reset and becomes writeable after power on reset which
imx2_wdt_reset() represents. While the WDT bit in the WCR register
already gets reset, its locked attribute wasn't. Fix this inconsistency
by adding the missing unlock of its locked attribute.

Fixes: daca13d495a1 ("hw/watchdog: Implement full i.MX watchdog support")
cc: qemu-stable
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/watchdog/wdt_imx2.h | 2 +-
 hw/watchdog/wdt_imx2.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index ad36b8820d..fc01fc46e7 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -85,7 +85,7 @@ struct IMX2WdtState {
 
     bool wcr_locked;            /* affects WDZST, WDBG, and WDW */
     bool wcr_wde_locked;        /* affects WDE */
-    bool wcr_wdt_locked;        /* affects WDT (never cleared) */
+    bool wcr_wdt_locked;        /* affects WDT, cleared on POR */
 };
 
 #endif /* WDT_IMX2_H */
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index d897ff6e52..a15f452d48 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -60,6 +60,7 @@ static void imx2_wdt_reset(DeviceState *dev)
     s->wicr_locked = false;
     s->wcr_locked = false;
     s->wcr_wde_locked = false;
+    s->wcr_wdt_locked = false;
 
     s->wcr = IMX2_WDT_WCR_WDA | IMX2_WDT_WCR_SRS;
     s->wsr = 0;
-- 
2.56.0


