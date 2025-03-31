Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB8DC36017
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOBY-0006jy-8w; Mon, 31 Mar 2025 19:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOBW-0006jO-HH
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:04:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOBU-0005kf-RY
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:04:50 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so40261285e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743462287; x=1744067087; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FSCM4rp57UZEJzLBnlz1xi9GYjXld1lLy219uTKGxdQ=;
 b=swJ3EaDexVh/ul/sPmoJMFcLPMfd/WCyP/8lg6X+is6tkYa10Ixi6/lwlbpqY2Whfz
 s8izHc539/YLysUO3H0XjQSDxQ/QFGIFyxm2TjAi7e1+gA2TuHst/pBXPXQbZjdE+A1t
 U86ri84Bj+oh8SobOwUJSX9uMFFVRVhl3mv8Ipr2gh4VRbmJm/EaMAffcSgX1PPRS5hY
 xegarXj/UAZ3ciA+Q+t3CfSRs1aW6/IdefeRqBJDeBKmEgXp8Z//F8qZDzrhKsQ7ZhDm
 Qxb5DyGbh+982zWBBQt5w+vlDniSFNTVEm6KVnROA4SlV+bRoaon/+2zFjoELuLHJqXz
 Ogig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462287; x=1744067087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSCM4rp57UZEJzLBnlz1xi9GYjXld1lLy219uTKGxdQ=;
 b=ITWWXGFZ2bwBpqY7D+nlVdlJkWZpxOHIkk1q8L4sTSF2ZERl+6pXc6BAKIRzuhD8En
 02rz4vwoDwiubHVHCsJfCw0RmCZJA/u6bhXCrftbk6gx7rV3lArE8VS1RQGl5K45EB1h
 zkKLUq7fDIoA1jCnlpBn/E//g4WihQothP4XEmB9JO3dcddtr5WK6rOMngxzb/CEuHe8
 5wA5RB+NT0rHR6FynXJbzWMFgjnwWmnbOTVl8xcRXIruJbQyHHldulvzV8LMdA+Exumo
 kMKK2kmMdYhuo768amIzIwF8r3AB0Ci0qWEF/ecA58uyx9EsOf5sF9bXxu8XT7s2Cr6J
 KrNQ==
X-Gm-Message-State: AOJu0YxFMJBWEuWXARmWgl7zQsiuiYlUeEcSTQMEbmgm4+R/I5aSgiqS
 yILgqRtyqw1QRrnBD2QBeQqtcSdTBcPnBCpKgbKmS6E6ej7kCEymdplpRPRD1igxPxKMOvBcFAw
 M
X-Gm-Gg: ASbGncuLITTpcYTuvOa9nFgrWzk46nla/yWATZ68FCmg7eb8UXlc+9+ae3j0zjVLwuw
 Gsy3oJI9x2JW3Yqvg/QeNjevMdoFKF7jvBeKiHfdcaPmeyi5n+W4o6V/I5QHX9HyP39LuQmGT4j
 jbmFN19LD7eMm0fQ3by81P1vTPBx7bwgIKyj1Q8e/dSwk9pyzQAeZY83HW4EQjjoWw2a4a/iVLq
 5cztVVhBPYrsXaAv68QQl4trfQYcWa7oU8XWVlPLFOLTOl5rpLtloWYZTXn8s7kT+hg0vwFTzty
 dETNd/ofYT7q4xlTQ1zyaVNUIaN6+ZOO8xseUnoGRbY97sMHYNNQpta3u10xiw2Iwls2WQkeHl2
 oFhyAn+vBPPB77H+3Wws=
X-Google-Smtp-Source: AGHT+IG3Mq1ewJNogMgGNasriJpeEoRPHaPwWRYXZeQmv8YbCDofMpt6SaNazKaqyjrGze4oHg65Sg==
X-Received: by 2002:a05:600c:6dca:b0:43c:f509:2bbf with SMTP id
 5b1f17b1804b1-43d911902efmr121371275e9.15.1743462286834; 
 Mon, 31 Mar 2025 16:04:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fcd0738sm134952745e9.19.2025.03.31.16.04.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 16:04:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 0/2] hw/misc/aspeed_scu: Correct minimum access size
 for AST2500 / AST2600
Date: Tue,  1 Apr 2025 01:04:42 +0200
Message-ID: <20250331230444.88295-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Mark SCU MemoryRegionOps read/write handler implementations
as 32-bit, then allow down to 8-bit accesses.

Joel Stanley (1):
  hw/misc/aspeed_scu: Correct minimum access size for AST2500 / AST2600

Philippe Mathieu-Daudé (1):
  hw/misc/aspeed_scu: Set MemoryRegionOps::impl::access_size to 32-bit

 hw/misc/aspeed_scu.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.47.1


