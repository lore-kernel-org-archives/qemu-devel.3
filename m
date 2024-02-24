Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070C5C54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 12:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdrNo-00026c-Lk; Sat, 24 Feb 2024 07:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNn-00026Q-Ct
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:59 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdrNl-0006qO-Sn
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 07:43:59 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d746ce7d13so15310665ad.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 04:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708778636; x=1709383436;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Nh78pCGrZWFa3bWv5ikfLdo2X41inBkS2nqEBAwwhg=;
 b=WNi7FhYPgPfaDSnSteuNF5wgs1pPHi2okizoISMzSiJUt5vnRdsfVBYzTQzwxKfevn
 18IpMKWa+Bdsk/HF1wfBZ8W9ZmAUczQzXOuaHSACdHJ94RK9DRB839kEobpVwyiCmqgk
 AhCOS+2us4IdiXibGim7zUuhp2l5XScg23U6L9PZlBJcJH6D0vseHoGn3XJrPaATuAIv
 O++Y994lsvqLNvJSKe/n4Gwmo9ZprSHcc1IfGnbec+hQnaGAGm4KBzy+pgRLXLGML+W/
 HgN/NPST8T2u94c0RFO9tTjzSQlJnNkQciSlA9Wjvw0acwlMoNGxbcPACtLOhw6U/9X/
 PwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708778636; x=1709383436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Nh78pCGrZWFa3bWv5ikfLdo2X41inBkS2nqEBAwwhg=;
 b=Dq0uRqmxg6WsSGWmKTx0d0sMA2vTjh0Mxyhtm13PqwbiLJW88Uq8tEw5skJGqJ5wsq
 AIg7szlEqGjM6D7tSipjMgFtQYPJwVJDc+FNny9sQkhSPeO2XqUJfqO7kjLM+YPi1zoe
 RplVU5qIJVnBdnHoK6kreU81vak8aGc7OIltj45u0kiri55YDYiXj/PwnIks9UODDq0H
 zQ5L2YFFgPL1qBJgZ8le+K1R5ttkLCWVhgLsR4T5J79DJ33fie/woMnp3PvPNKyfKSWB
 jTpmU7HR9E2de/uMMYVPhHs4AhIJ89zdpvQVQj4IMTZJVk0ivr6kRz+g2H4RicCGN2Gi
 Afzw==
X-Gm-Message-State: AOJu0YzFhPFigJ6i1+HsudDYmoUeGwkM23LsSpZySK2MDckWNajlr8Dz
 W5iY47zfvtO3O17u4oOUSj7LOAymBBq/y+5nIkn4OQsGvuY71IbWk3JjFlVOW98=
X-Google-Smtp-Source: AGHT+IH2koTqTae/JAsftM6wLlpdhf49DDYfUm9XumFY+8m7AsAdqU34RPimYB1ga3t9+9ZK/q/spA==
X-Received: by 2002:a17:903:2587:b0:1db:8fd6:915e with SMTP id
 jb7-20020a170903258700b001db8fd6915emr2398770plb.33.1708778636675; 
 Sat, 24 Feb 2024 04:43:56 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 z6-20020a170902834600b001db94dfc2b5sm955681pln.107.2024.02.24.04.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 04:43:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 21:43:36 +0900
Subject: [PATCH v12 05/10] ui/cocoa: Fix pause label coordinates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-cocoa-v12-5-e89f70bdda71@daynix.com>
References: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
In-Reply-To: <20240224-cocoa-v12-0-e89f70bdda71@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Marek Glogowski <smarkusg@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A subview is positioned in the superview so the superview's frame
should be used instead of one of the window to determine the
coordinates.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/cocoa.m | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index 644fd32eaa4d..df8072479c82 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1432,8 +1432,8 @@ - (void)displayPause
 {
     /* Coordinates have to be calculated each time because the window can change its size */
     int xCoord, yCoord, width, height;
-    xCoord = ([normalWindow frame].size.width - [pauseLabel frame].size.width)/2;
-    yCoord = [normalWindow frame].size.height - [pauseLabel frame].size.height - ([pauseLabel frame].size.height * .5);
+    xCoord = ([cocoaView frame].size.width - [pauseLabel frame].size.width)/2;
+    yCoord = [cocoaView frame].size.height - [pauseLabel frame].size.height - ([pauseLabel frame].size.height * .5);
     width = [pauseLabel frame].size.width;
     height = [pauseLabel frame].size.height;
     [pauseLabel setFrame: NSMakeRect(xCoord, yCoord, width, height)];

-- 
2.43.2


