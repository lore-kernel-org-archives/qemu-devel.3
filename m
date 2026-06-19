Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B945ECD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYuo-0003wC-R5; Fri, 19 Jun 2026 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYun-0003ut-KQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1waYuj-0003P0-Jp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:05:45 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-462bb734793so1511883f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781874340; x=1782479140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=by9u5EKjsb+5+gHbsiBm0Rf3TJxywMdtV+jmRIHAyvY=;
 b=o4E/u+gm/m+liIc/OrKFcYVWYEEdQq53Me03HhmE8FZMB6MDsO6qAdU9PxrupOxGMc
 DMCT3EcJXJlcwIYP9AWtZzunT1K3N9QqHh1NaNBcTFOpr44H54rn80B7ClQTox4dHl3w
 bsBMwhLLrt70np0SzBXiSHgyxXS7T1IxagcTPuwaxutgFpsUPc5TRzK/QKtvAj14UGYj
 r+wUB8W6W9Goo8G54VEElrt3JWUeCK0RqHapGiDFyHjL1iEZoRt6mg9HUJZJGcoLduID
 joZrh/TfD0g/4xffpzoK6wo6W1Euqy6950pse5Jy9UVMj8IPTuimSFYhfKyYPubSwHtQ
 tVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874340; x=1782479140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=by9u5EKjsb+5+gHbsiBm0Rf3TJxywMdtV+jmRIHAyvY=;
 b=XPx+OhmXRhied70jOkndCso/OAGHXSXwJJK3nKt0t90XCIced+2EdBYaNL8bgyi7RX
 XLS83LwTvLMIeAB6jeJ9oAbDXPvlvwZy+HDxxmNtpV9VMAAN8w9DeNvDtRQmAP002U3Y
 XfenK4gtzL5YgLC2h3DuIQNGRKyVWMQaBWMqROE+r+oTBQxc+4Jv2zrt+vhPnyexDKHV
 wD35rm80FrYRyTteL9bMyU5ymv5Ade4yVnrwimETtN82e9EjiHqdIoyhR8841hRESayH
 o44xfkaj3UIvJCH3cR22waR9KMQk3vQh/p5SDBaNlpFzzHxjxKwYzHHRqhTj5Jm9qXYA
 KyZg==
X-Gm-Message-State: AOJu0Ywchg6yNt0dxMPyV8rcWzVpuFgejdCuEwi/WV9/Yafyz53PnGIL
 wJKW8RbJfpevy1pu7FbrtrVMXoS8nx3DSusCw54vYLTVh7+2XiRO0jVXqzOvm4fi6Zc=
X-Gm-Gg: AfdE7cloekdplAJlTP5reSMWikUGV8EU3w/grNVMs9GdegYb/mtpzCh7qJsC+tkwL/p
 RWl+munbKt8sLBh3jp3vsvVUC8AqVO8XfS+/X2VcZEv/NnUZ8VQ3GtR0f+K+Sn9qdSSmEIYH4I8
 JvBMqRhZy6FghqHEO+KTfD89z57t0OnP/ZermY63B/VoXQ8DHkgEHwSjCJH/OvHn3kTM6TTa7Bb
 QLmk3f/Okq6BMDuc/0vh80cx6581aN8suuBrxgo4LmBSCzSE5eJ2IxkgpfWRSTT2PC6mIirnjUN
 /GiXislyO1dItBp37kC2e5UwdTXVY0PuN0Hy4dTpCiLRBzYs0KHlnrmmOHvO69PRBX/uiSif2jw
 jR4yTZJOOK5EWVI5t/yFHU65PiZ0f1Hb63lScfrQchg42FFt85s8gg5CxVzED9H/eMZCqZfRmXe
 sz1Co6B5PF87Ictn2cfgHiKmg=
X-Received: by 2002:a05:600c:c088:b0:490:c2a2:e91f with SMTP id
 5b1f17b1804b1-4923f59f2c7mr60670475e9.35.1781874339752; 
 Fri, 19 Jun 2026 06:05:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49245711032sm23657165e9.0.2026.06.19.06.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:05:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71C7B5F917;
 Fri, 19 Jun 2026 14:05:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Tyrone Ting <kfting@nuvoton.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v8 2/7] tests/functional: update anacapa-bmc image
Date: Fri, 19 Jun 2026 14:05:31 +0100
Message-ID: <20260619130537.820184-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619130537.820184-1-alex.bennee@linaro.org>
References: <20260619130537.820184-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

The initial version had the wrong DTB which caused issues with image
corruption [1]. Update to the latest version.

[1] https://github.com/legoater/qemu-aspeed-boot/pull/7

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/arm/test_aspeed_anacapa.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 27f8bd8b56a..b16c6035c95 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -11,8 +11,8 @@
 class AnacapaMachine(FacebookAspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/3fa3212827b04be4034d43b5adeef57c27d6ab18/images/anacapa-bmc/openbmc-20260512025228/obmc-phosphor-image-anacapa-20260512025228.static.mtd.xz',
-        '2232e241abcfb6d4f6b82cb6c378ce5ce05e364aac6d118785c2b6cc33fe43f3')
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
+        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
 
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
-- 
2.47.3


