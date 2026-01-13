Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF8D2D0FD
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 14:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfewR-0006HY-5o; Tue, 13 Jan 2026 09:00:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfew5-00067t-Pk
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:59:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfew3-0000wy-Io
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 08:59:52 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso31203075e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 05:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768312789; x=1768917589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJ1SgCOujNhPuSC3X0aTiI8c4qVh65QJa2DrhUMbkZA=;
 b=M0yWPQqx7cdzsR5iI3PlibJVsuzGl+s/KdB/nlWdiDkFb3XJhvpCndS10UiUDVCegE
 x8j+1jPam2c7Fo2ar52u9XhYRGUyhg546K+/bZnSl09PMvOCwzhMy6Jwx9Wj+qsM+71Z
 COvY9KjcMkTePSMtwRDNnttCnDpEaLrEP50iVWTUWLyqijkf4sSDOlXHwq1CbqglN0Gy
 cuAvfSDtuP1r8iGU2TRh+rf5wzds5RgsloDCdRS4+LJl6Bf+WY6NDsmkBUvWyQ2pGBsc
 Uokyvh4Vf0txDLRIGox7vq7w5lyQFIlGRaKbA5vMsUPgDB+X9Rw/2WKOIzU5ODqKmf5M
 3mkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768312789; x=1768917589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJ1SgCOujNhPuSC3X0aTiI8c4qVh65QJa2DrhUMbkZA=;
 b=cEi5LNdR84sDCaI5W5TkxcCgMd/gnJaQHF07aACargHlaaSGiNOplSzF9g7UHp8MI3
 Rti23pwyPjyGK0m94bklhempw33L8yJFWAHlxaobv4d8JkqBua/h2zDfVax6g1XfTkXY
 mo3VdKGSGS0nv5F0uQ5KkASXS/rHiLa20lnp6Kdx1gY0mFI4fDeH7rZCgD2Jj+bwtUGe
 8eJJatJ4kxBdsEGzIefjQiC7dSX1L6Fx29QpPJB/11DsdSZ+ayOzKaExE2YBAXMDCb9H
 COj2qQVs+nXBuh/mI+eYtBeLiCO5/flwJIOnYdCoedzQNWKs5cHUCYhaVzFq7KpgRE2z
 29Eg==
X-Gm-Message-State: AOJu0YzEIAPsU1j7cBU7gA6Tpck3iRQ1Q/O7XoS9HJDRiFsy2+X33Twe
 UA1uPsbilOa7RyvVrFBcric4QtaJGxAsYoRXuSgc/6wRttH/GU2r7RsNewqvieCc6Ng=
X-Gm-Gg: AY/fxX75Jrt0tOPNlfYuFLp/rbsorxX/U8vANMiJm/ii/M3WEWNA0WX27DkRjKs7LqN
 TADEXbLpdLLEN2wqWqjAC15f01R9JpKj5DJgDbxVjIC8to9CIt1MwXp11gDt43daG2NUmbvoWge
 j+tHVN9KWl/5KTnG6lenV2eHqNaCfl7g9nOP25cQ6d4d6cVagcr8yMMMBR4oMMKrN/4nkCUWWdc
 LpUkAJmH8FUtHislTpf8f58g8ZJbun9nC3boVqhMRTYV9bpapWSmwHwLtvx4W3sYoWMpPfKWIk+
 zCVMsJAsAlOUL8VCYB0LVs4gwW2XBt5GdFt6uvS+Q+7/vPoUFsU7RVXRqgjPRxE1Bmfh6KlAlBo
 W5cMQj8LSxHyMalpzfPDcKJINWq1TVZHY0+WxAHnLmK2pPF7CbBwq2XmvajxwGu3/JxJZOYeL+K
 BhuweGZs9MCd0=
X-Google-Smtp-Source: AGHT+IH8R9ff//fB9odDVGggAgk0NKnc8UovUO3TadWGQ6Qsy8Ppy870injZlQ20uilandi3+iWe6g==
X-Received: by 2002:a05:600c:83c9:b0:471:114e:5894 with SMTP id
 5b1f17b1804b1-47d84b3bc10mr234349795e9.25.1768312789022; 
 Tue, 13 Jan 2026 05:59:49 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm429053545e9.9.2026.01.13.05.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 05:59:48 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 773025F805;
 Tue, 13 Jan 2026 13:59:47 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH v2] tests/functional: migrate aspeed_rainier image
Date: Tue, 13 Jan 2026 13:59:41 +0000
Message-ID: <20260113135941.3361163-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Cedric has a host for the file which allows us to keep the name.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Cédric Le Goater <clg@kaod.org>

---
v2
  - host at kaod instead to keep filename
---
 tests/functional/arm/test_aspeed_rainier.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_rainier.py b/tests/functional/arm/test_aspeed_rainier.py
index 602d6194ac8..30827beca35 100755
--- a/tests/functional/arm/test_aspeed_rainier.py
+++ b/tests/functional/arm/test_aspeed_rainier.py
@@ -9,10 +9,8 @@
 
 class RainierMachine(AspeedTest):
 
-    ASSET_RAINIER_EMMC = Asset(
-        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
-         'mmc-p10bmc-20240617.qcow2'),
-        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
+    ASSET_RAINIER_EMMC = Asset('https://kaod.org/qemu/aspeed/rainier/mmc-p10bmc-20240617.qcow2',
+                               'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
 
     def test_arm_aspeed_emmc_boot(self):
         self.set_machine('rainier-bmc')
-- 
2.47.3


