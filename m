Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1DFE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRk-00008F-Db; Wed, 11 Dec 2024 11:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRg-000057-UX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:17 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRf-0007au-8T
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3863703258fso521947f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934013; x=1734538813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SaE8qkAdKJuPj5dpI7bzFzLk3IAsCJj4Y7jMaT1vwOo=;
 b=Y0UzddCNBdudMRH/6kOi9EGqsTkhn0wlzwq3YZNFS93+lDctIQnFwFTg8tMR3UlVaT
 vUNO9CObSTRojQFaB/9Qt4V4pv7iMucdl1mUgWthGKI78YHIbUskVGOJ6vBdkT0raMWr
 uV+p/rCbxzgEEMHeBZ+QsgaBbCm8oLyX29BHNRbZfQzqWppQ0fI8o/65YgKc//zy+w85
 TH9YqC2JXKBPxuxGd0W/zalsv5KQ27qtfPKHpMb9B6Hi6P5PSV89xWY44mF7HYIhjmM8
 V80/d9wZluq/vhiBPly8HHTaqDFh499KX+eJ8rFaCJduKEpRtdIJjueiTlzbVALbqdwk
 ap/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934013; x=1734538813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SaE8qkAdKJuPj5dpI7bzFzLk3IAsCJj4Y7jMaT1vwOo=;
 b=C/ZXQOENRZagjBs7kGDWgGZ8Jo5oJzjNweQm+53Cuq4XgTYpAYEWNZPENR8fRp7gQW
 gGM5/gdo5/EjUXAEXFPP6Vo4dE4+WQccbmUt/iDx9K3hI2LWIBAUW+BelxOGchJhSCHs
 jsH45UqlgGnyXWPzuDhFUcxh9IEvi1SRh8oEKpjar1sBedULH/OBZf0jyqsNdehUcuT3
 4HmGxm0Edbxi4OJntAOF2fwyqdvuilHYCAT44npdc3oiKK4pjoWH0ujtk7lyqnjZOA6K
 xMZJgJhhIGHaeOskvX+Z8F6Y/GWKguAEI07yayaSSO+9fDe1v3m3A7M+mVOZpmINsrra
 dmCg==
X-Gm-Message-State: AOJu0YwxfmdRjJSVQoTa3V6nB6q5aGPtpJTlAvlovOSd3g8pJiJMOdlg
 +ElCLirt7MC7f6OjLSFTIJr51Ig9vQ2jPcZVX2Dp3sWR56Jj8ae2EtqrZz2fJ3p7/TVaOXwvmIa
 /
X-Gm-Gg: ASbGnct3ZoelyUzqw30hbigGgBK8hFlkAZ30eidvdO0Iz6mjIQJIzYRljdO5n2j2kNY
 Z7dSD5F/67Cq9vc3DN5JGil2ChMBAXRTq5NndyytrWGHUdRC+QzS2hqX/SSs6jUdRNI5cokdokC
 mNNfDgUe1HdeNNFlur57EYdpNrUgcr/9aRXj70JgVak5090tODBCIEQDPcThTas0OGyXLnnEHvw
 kHygolKi1mPKCsONxfZXY9BJ20fHteR9i99/tcIb2AEIt71XAeX/JVrwzKW
X-Google-Smtp-Source: AGHT+IEFB4yAM9ACMxV8c51MI+npLqCg5Ko2Af/2JNy3ErgehvHYAeB3b0Dx+fuegtbZZPlop8DiFg==
X-Received: by 2002:a5d:5f4a:0:b0:386:37f8:451c with SMTP id
 ffacd0b85a97d-3864de8ef5dmr3022550f8f.1.1733934013649; 
 Wed, 11 Dec 2024 08:20:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/72] hw/net/lan9118_phy: Add missing 100 mbps full duplex
 advertisement
Date: Wed, 11 Dec 2024 16:18:57 +0000
Message-Id: <20241211162004.2795499-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The real device advertises this mode and the device model already advertises
100 mbps half duplex and 10 mbps full+half duplex. So advertise this mode to
make the model more realistic.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20241102125724.532843-6-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/lan9118_phy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/lan9118_phy.c b/hw/net/lan9118_phy.c
index 874dae4155a..5c53a4a1e3f 100644
--- a/hw/net/lan9118_phy.c
+++ b/hw/net/lan9118_phy.c
@@ -110,8 +110,8 @@ void lan9118_phy_write(Lan9118PhyState *s, int reg, uint16_t val)
         break;
     case MII_ANAR:
         s->advertise = (val & (MII_ANAR_RFAULT | MII_ANAR_PAUSE_ASYM |
-                               MII_ANAR_PAUSE | MII_ANAR_10FD | MII_ANAR_10 |
-                               MII_ANAR_SELECT))
+                               MII_ANAR_PAUSE | MII_ANAR_TXFD | MII_ANAR_10FD |
+                               MII_ANAR_10 | MII_ANAR_SELECT))
                      | MII_ANAR_TX;
         break;
     case 30: /* Interrupt mask */
-- 
2.34.1


