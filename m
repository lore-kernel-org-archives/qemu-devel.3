Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9C6EDEBFA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 22:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxY7z-0004f8-Q8; Tue, 03 Mar 2026 17:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY7y-0004e2-FK
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:06 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxY7w-0002OZ-RB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 17:22:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483a233819aso60593295e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 14:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772576523; x=1773181323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyEy/g1PEDGl9OT2R7W8yjv5uTeT+1EIBQ0lv6lijmM=;
 b=Ce1tyRBtBpTBlK1hgT8eC3gMyjG9sNafd+cZf2i2gI9dRCde4yCU3J1c8LXTAMDNeg
 jElp5F/+ax45IAbFmO4BOEYOy2cyroGxp+JVMsVY2yrmOgCwL8b4cCi1Br/cbkKdXCq4
 pAFb/7aaB3+dZXmDAiNi2z91k0cFQ1/CuhhNN314dUGOjlXxLfH3RcR7N/eMMsWZSEnB
 XV+7zOfNsNOwwHDdFSk1nBVEpGXGxPJUb9sBtmLroaBLDrHzjta8ONvOch8rzXaeYv7K
 WbveopJ55b8JtNGUJjMZmjl9U+On4hoGVGg5VjtAt3YsXAt2FAeN5RZ0J+au9YT+ubl0
 cYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772576523; x=1773181323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UyEy/g1PEDGl9OT2R7W8yjv5uTeT+1EIBQ0lv6lijmM=;
 b=AZbCDhaUIlcUYjEAZNJmxhlD9gCQ50zD2Y+cZd++DKKhAhwWzFmOwfFT3KHzr6RC0/
 cOrokz7dvRsm4ngroCk7/HKlp7PQYSTPt6E2lsFGUoiERRUZ8sm5+si6OwIr22zczePT
 J04cQlbBPF4x1G+6YmMg8Ms7/ojZkqEC8hki91Yum02T3+4Vn3N+Yw3Bb8wPGon2OW3j
 RRasOb5rA+co0shNW4ivKOcbHkUpqQ3MnAs2JVrjIj9RcfqKoBDJI6hwwdq2/rFh3igV
 0j7gmRGkA1FPxikC3FBgRNKJxTBQfu8vShq8aifvIfnEk6p8etu+q3ZZCDh5EIhF4K0L
 2c3Q==
X-Gm-Message-State: AOJu0YxCjMcOV0R3r/D154zp3P8eEViZY+A8xti5TM2fze0X/jKfGwBz
 yB9/fq3eesoORPk571iCj6CTpaezL/TYcWSMH63PHAIepuJyW7JUuyFlZ9Q+Iw==
X-Gm-Gg: ATEYQzzH9vX7XQyBrX2e9EUe+SpplAgpw4yBe0WrBhpsWzKJRPMiHUySekj7Rr74aSt
 rHdiLUwNLjDydJuEEbx6aj43KN1GEkCF7QbH+dGvOVhDBZryE0/gE1yZHoJfC9lY8HjXflYhmQJ
 z80Y9OGhObXzHWnbd+4MfPoHCPGH9EyvCXVrltDPM+UD9jlcxZD/Y8SVPhsEPWKx+sXZhSM8aaX
 GLZqyCp0Inp6NsSkUW1YQLY+a8zydRTgIKNT3falAVYE3/lDxpJynBzXEqgwcDJFN6UidOAjfIt
 XBrBQSlL+Nc/oMk0l6vzPJpr3CGexNqsMlR1UKd8GCVqVIopfUM4in/bqyvJwABBG8OuqoGzs3d
 Xistt4nbQc7we0d17NHMK34nB0y0oD5vbMS6pURzX6nJ2yfG0mfR+eyB/AEZgSQnexg4EtGibol
 nwqv/SkIOXMf1CcGd70+AEwie8HCeF5+XJ6036RNI2mapq9csTRjUCaYsn0jL9zJSAviNg93NyG
 OR3JJWHgjfIY5WHW9/InStpgN337lz1mjFK4SXLeA==
X-Received: by 2002:a05:600c:3103:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-483c9bc19a4mr306193725e9.10.1772576522717; 
 Tue, 03 Mar 2026 14:22:02 -0800 (PST)
Received: from Provence
 (dynamic-2a02-3100-1c79-b600-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c79:b600:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485187c81adsm7577715e9.6.2026.03.03.14.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 14:22:02 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-arm@nongnu.org,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 01/13] hw/arm/Kconfig: Fix serial selection for NPCM8XX
Date: Tue,  3 Mar 2026 23:21:31 +0100
Message-ID: <20260303222143.142741-2-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303222143.142741-1-shentey@gmail.com>
References: <20260303222143.142741-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

CONFIG_SERIAL selects the internal TYPE_SERIAL device which is akin to
an "IP block" that needs to be integrated with glue logic. In case of
NPCM8XX this glue logic is TYPE_SERIAL_MM which the code uses already.
Fix Kconfig to select CONFIG_SERIAL_MM which matches TYPE_SERIAL_MM.

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..20e99e52b1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -493,7 +493,7 @@ config NPCM8XX
     select SMBUS
     select PL310  # cache controller
     select NPCM7XX
-    select SERIAL
+    select SERIAL_MM
     select SSI
     select UNIMP
 
-- 
2.53.0


