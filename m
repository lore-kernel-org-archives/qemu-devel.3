Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C7CF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 07:53:31 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svAxE-0002i8-HE; Mon, 30 Sep 2024 03:36:32 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svAun-0002g3-S0
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:34:00 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svAu6-0008CK-UJ
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:33:41 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d6ac24a3bso742552866b.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727681528; x=1728286328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/XjK5WcFDf2fFTQGUJSEkzp7XAmv+Yjy0CIT72sbc8g=;
 b=iOvHjCUnwKXEl6RKohkl2MywORui379jYC8Zqh+iFTGZdhKVtfXnP39wohwfd9Ljeh
 NHU5FcnhTXFpjVNRqC1p+mcdQ4XvZyCJGC7xTVYkI3zAl0Qt2YloZMo1wHpzXYo1cFH8
 P1OG+Da7RPkqXITvAJfklWpd5ykY6yXgMroMNHlqi/X8PtS1F949TIjKjs1NsdUQc45g
 8lvDlfFWztv7MFMeYPvkFeyl9mEdnJmRWE3R4HMtqGny4uSIXl0TDZjEa7kDpA5Z4iba
 dyungHU/p7t4Lo6pQzgyLF78zkA/Gn1AImESJb83jjnjMJY9yRR8wtHoM/85SA4+uV2K
 zJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727681528; x=1728286328;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XjK5WcFDf2fFTQGUJSEkzp7XAmv+Yjy0CIT72sbc8g=;
 b=gyXWNzetApvzyoYjAgqV+PFKmaLCeB2PBD9jck0wBl7rbpvgRFOffNvIzgE50cSzOA
 1LbFyW2RpFQRB038MseRCVdzv7REN7i7f0uUY8rNdiPWfuonTmMPXamIP5tUB5J8edYC
 aMe9buG+34l/LXIw1wx67Tl1EEteBPu4ryCUE4gctn/4kdos34DnDKWwetK6AdQh6XR9
 vY82Rs/D47sGyO+2ZaLGBrc8lUkx6tgU40WW0QrGHPZvDW/pcIYuuDDKArMfI5JdBILV
 n58kdN7pP7Eq3Kmqts2Musi/oWqM430XeErXIyMGQq3RggiZewGeTSRJv1WAePy5NGAh
 5SbA==
X-Gm-Message-State: AOJu0YzdBmYbeQznYbCdhetarLprM4Vi54xRuNi8D9vlCrU7J5xhlLGN
 rWqrB+NEdGQbjHuU8xXdCBCCBLVZXsjZTFF5Q4BEJUjaYHjjy8lQTLwQYtQV3XBm9f0LZhTcpHD
 q
X-Google-Smtp-Source: AGHT+IHabe0gVWNRqNBo/wNfJsgiQVOcirDK/HqGFwNJ/hTfid9ZO6v73sKFKKewOD7SgqyMLJkCMg==
X-Received: by 2002:a5d:49ce:0:b0:374:adf1:9232 with SMTP id
 ffacd0b85a97d-37cd5696e86mr6036435f8f.19.1727679620487; 
 Mon, 30 Sep 2024 00:00:20 -0700 (PDT)
Received: from localhost.localdomain
 (115.red-88-29-173.dynamicip.rima-tde.net. [88.29.173.115])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57429e5sm8234948f8f.98.2024.09.30.00.00.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:00:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] hw/mips: Build fw_cfg.c once
Date: Mon, 30 Sep 2024 09:00:15 +0200
Message-ID: <20240930070015.28244-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Nothing in fw_cfg.c requires target-specific knowledge,
build it once for the 4 MIPS variants.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index ca37c42d90..fcbee53bb3 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -1,6 +1,6 @@
 mips_ss = ss.source_set()
 mips_ss.add(files('bootloader.c', 'mips_int.c'))
-mips_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
+common_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
 mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
-- 
2.45.2


