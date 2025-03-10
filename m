Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBBD7C28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfO-0001sJ-Gz; Sun, 09 Mar 2025 20:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfK-0001pX-8W
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfI-0007Jz-Km
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso20374485e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565199; x=1742169999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzGu8aPFmIQyqFB0ii3ysyS9QgzkXkJa7t9N53ypfFg=;
 b=i/DX3N6WL8h/9E2kkdz4Q9G/ej00XgHf6ri0TLrMHmyghg969iWPK6Ecz7no6ka2wd
 Jvm2Ugj0FYt4lwAFwzcwb7Ab0WTWiKn/fO4BuVnMDqfF/5Rjgy3zq3nIfq1HW0cLeGsQ
 mrYRu54ivMY7Js3HjD9OI/zp6JD+J5nMuEC71sjEhlwZBRlIOrOkRzE+tPMJNx/NojjV
 C/aCCffhgDqWak3ZRs1TtnWwQTlQcy8dW5n1vBh2ViBIlG1vfbLcxI2s/0CZxWE8avO+
 WpDs+JThTNBCmVsAoqfQPTGeVIhPvz5JRc1uPan04/FVzyVSfFvb0uEv+iteh7U/ds21
 KWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565199; x=1742169999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzGu8aPFmIQyqFB0ii3ysyS9QgzkXkJa7t9N53ypfFg=;
 b=QhWTm4C1PnMklzOfUC7/9sOBt6TNXM1sFsD0+uaIVu9JvuYo5wzIvmoNQ2QoTLeuOb
 sUFVI+50lh6U1Y6kzLKZ/09BauZw3q00KGHkvQyKmlJwwQ9ViyYDJvJeWfQkH2upCsUW
 rk+MycgtvAAY0hgIh3hOEVdFItv2x/sqeP1TYhksKiC8UxIuT8emualpLK3syzoERKlD
 neE6P4aTBugLId3csetVTsifFnSoWEosvgT04Cwdhldex3beN4EPWCD4Qtin0NRaWKV0
 +a4XwURdL+/SkzXeKQk9ObSDVYvfogqBKYBeQW0gaDvj/b66yxWO0UI2yczdBeHNprTm
 lkHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiFzegOgC+xfZ5q5Z5iflleaxNzZaHGEdcTszN2xL6ajbmoyt/aL8rceTW6Cc+FgdWM5QTI/tWY+K5@nongnu.org
X-Gm-Message-State: AOJu0YxW348fql+kVcJflhXaKg6GWmRdnWuyI03s8Pq02HNlshdJnPfM
 beyxJFkEKJYgepZ3PRE4qgzqPkeVRXKX3/8XcCdzZA6JxqMARRTd9e0e5BunpEI=
X-Gm-Gg: ASbGncttwXp/oZzBuaanvTkn63lBdSkZ3pOd8s19eZMsAnfAd4c4fZSBOpWptZTKUmx
 HljliUAdRRvi3lIMkN8Q8/Nk1nc35URLiEHHD+T9dkvBT3kJJfPhDdd30XA2p4qxRxFt3sO4M3U
 9KcKBcTKUQHf5Qf1D5zp0fVbnHCYWu9Zcoyb0mH6H/j3Grta2PynYCEf2Sg1KhgOEoaAVnQJRk5
 OFwc0U3HkKQ2Jj4zxxmwBHLDVjcJohcrymfnsMHRjvgHhsnsqaxQGoyR7+Nu6X2OJmdzx5ZDYoJ
 DdaqsNJNBMSOPTFFyEHk2gn6SNPUUgzglaUmyluoksAYj5P9PPdK9Yf1/EXI6QXHJz/D8AzAZhw
 Y+Jh08bXBfeU0Yl+35cA=
X-Google-Smtp-Source: AGHT+IE1yKaFaTzWwBS5WdOP1A/BxzJYjVRFPe8g9jS5JjKCDnxottFdLlhcBmwEz9qJjL41s0hqqA==
X-Received: by 2002:a5d:64e4:0:b0:391:48f7:bd8a with SMTP id
 ffacd0b85a97d-39148f7be31mr1334760f8f.30.1741565199226; 
 Sun, 09 Mar 2025 17:06:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1476sm13191032f8f.70.2025.03.09.17.06.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:06:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 03/14] hw/sd/sdhci: Redefine SDHCI_QUIRK_NO_BUSY_IRQ
 bitmask as bit
Date: Mon, 10 Mar 2025 01:06:09 +0100
Message-ID: <20250310000620.70120-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 include/hw/sd/sdhci.h | 8 ++++----
 hw/sd/sdhci.c         | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 48247e9a20f..096d607f4b7 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -108,13 +108,13 @@ struct SDHCIState {
 typedef struct SDHCIState SDHCIState;
 
 /*
- * Controller does not provide transfer-complete interrupt when not
- * busy.
- *
  * NOTE: This definition is taken out of Linux kernel and so the
  * original bit number is preserved
  */
-#define SDHCI_QUIRK_NO_BUSY_IRQ    BIT(14)
+enum {
+    /* Controller does not provide transfer-complete interrupt when not busy. */
+    SDHCI_QUIRK_NO_BUSY_IRQ                     = 14,
+};
 
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 149b748cbee..1dc942a0e06 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -366,7 +366,7 @@ static void sdhci_send_command(SDHCIState *s)
             }
         }
 
-        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+        if (!(s->quirks & BIT(SDHCI_QUIRK_NO_BUSY_IRQ)) &&
             (s->norintstsen & SDHC_NISEN_TRSCMP) &&
             (s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY) {
             s->norintsts |= SDHC_NIS_TRSCMP;
@@ -1886,7 +1886,7 @@ static void imx_usdhc_init(Object *obj)
     SDHCIState *s = SYSBUS_SDHCI(obj);
 
     s->io_ops = &usdhc_mmio_ops;
-    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
+    s->quirks = BIT(SDHCI_QUIRK_NO_BUSY_IRQ);
 }
 
 /* --- qdev Samsung s3c --- */
-- 
2.47.1


