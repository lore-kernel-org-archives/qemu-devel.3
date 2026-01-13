Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BBDD2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcwe-0003yf-39; Tue, 13 Jan 2026 06:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfcwB-0003u5-Nz
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:51:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfcw8-0005h1-Uf
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:51:51 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso34075655e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768305107; x=1768909907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IxMuWm7xQKjAl4Pj3jxQYVv7ZjOfvdG6QHv6xK0z5aE=;
 b=o3aBxbHUs8HXLERg9HMP+2qK4VFeB8wY1IudYvDaz++V2THleTBVFSiWbHKSoEMckk
 9FPDc4XYgMCZp8MsFusFIEka15PQFhgG6FtGi5Qpa6FNHegpJtfguhJAejyu4C/ty9JR
 eTHtujIh97AsOg+O3aUPTvk79JmuNhheAx+fEvvDRcWtuxD0hfjEKQX2MfU9FIfWoi+z
 0IV75NfkSYTnvNSv0JZbQsL9JYmk4mekK9TjzU5ljXGk/ltxp4y0CyXJBL1i1pmtTdH/
 USqFRzzwSE8wb+eCb15Uq1kf6ur3YD1Hd0qDhS/jfQt5bm7lZY+Cr/dfy9+X10NCVQ1P
 ZzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768305107; x=1768909907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxMuWm7xQKjAl4Pj3jxQYVv7ZjOfvdG6QHv6xK0z5aE=;
 b=FmfnNPEmz0Yh5qtJPE1Nisb/52f4tGUdGfM3920DEJYjgS6k3R1K8vwAurex0Nugd8
 +rx89B/bP8wOLFqkEhHbTB56xSkPsUMb2HoF6nYDHRqw2qtWBk5MEtoZ7zOqo115QDCd
 j2C87OXBtnESqsxGV1gglMB4LZNVY1qaFQO286GEG6h4lZmB9gNmix+qvaJ2Fdt1sdAx
 wmS2kzv70W8tQKAgUCR4zdhrdPNyfZFXCcz8qURpVpv4TeBoKKgwnQtumS/KqDEuDTF2
 ww/cQK4a2eXG52UFs2qNym2zg9Fyt0qxu6ds1jH937ubN1Et/tzkZnTs4F7W16O7CK56
 3poA==
X-Gm-Message-State: AOJu0Yy4AldTvrF86KMoc2ZfgRVacKwtdvVPB3zRwruj87+ATQjUXwPm
 q+saMbBbVUNclxKf/HLcg0mfnRE98IIdBq42U1XoJr7yfYBX+66Mf6yUqY3DbD1fv8s=
X-Gm-Gg: AY/fxX4HYobvNLcLESEVIpKRUqRjRtyUqO5rTa7ZyiCRclXvaB70YBGvMHASX/Y1aB/
 l4b3K2IdQ5X97CYS9CM6y0MP3bV1ZXJYxTejA/+XeWIcSVAZ6s2jTktRiMXGvW0P4WLv53h3Owc
 NwtwXRWkHvNSImb6F9dKm9mmSAzSvI9UH5SN7oQjENOMBMiwQ22YFYgDO5puizHbzVCbTFvXdBL
 xxZwrJwRzqaDVvZRDur4RDNkaSG1UeYIepiWEc/VmYIWJddzeQPyF/vij4prxR28TldVrB/X3jN
 4OpABw92C/YgMexkkOHcCyFyrmyE96RcpMBZvQzfH6iAD4gWv0DVSphiXiHdujmZJ1+bqCiqW2l
 nLxOLQN3g5W6qmAlQvvQfDbyS5P1nMr23Y94aZ0SbdQaW7zZNzpkZEf8e7vrI8rPLzo5VMqs/rf
 Y/n460pMWiTzo=
X-Google-Smtp-Source: AGHT+IEdefbkAp+AV8nKuaVOJwcYStRCAQGUMrTome1AngMpQKdXqE1/UthnyfU7ixCQ9gudgLJb2g==
X-Received: by 2002:a05:600c:5306:b0:477:7b16:5f88 with SMTP id
 5b1f17b1804b1-47d84b0a992mr192540685e9.6.1768305106655; 
 Tue, 13 Jan 2026 03:51:46 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df96asm42982732f8f.28.2026.01.13.03.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 03:51:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 219585F80E;
 Tue, 13 Jan 2026 11:51:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PATCH] tests/functional: migrate aspeed_rainier image
Date: Tue, 13 Jan 2026 11:51:37 +0000
Message-ID: <20260113115138.3171479-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

fileserver.linaro.org is going away, migrate to the new share server.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/arm/test_aspeed_rainier.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_rainier.py b/tests/functional/arm/test_aspeed_rainier.py
index 602d6194ac8..025e5751dc7 100755
--- a/tests/functional/arm/test_aspeed_rainier.py
+++ b/tests/functional/arm/test_aspeed_rainier.py
@@ -9,10 +9,8 @@
 
 class RainierMachine(AspeedTest):
 
-    ASSET_RAINIER_EMMC = Asset(
-        ('https://fileserver.linaro.org/s/B6pJTwWEkzSDi36/download/'
-         'mmc-p10bmc-20240617.qcow2'),
-        'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
+    ASSET_RAINIER_EMMC = Asset('https://share.linaro.org/downloadFile?id=PaCHfyerwpSr0CV',
+                               'd523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b')
 
     def test_arm_aspeed_emmc_boot(self):
         self.set_machine('rainier-bmc')
-- 
2.47.3


