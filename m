Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C25C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXs-0006qL-7b; Tue, 10 Jun 2025 08:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXg-0006pU-Iu
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:30 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXb-0002dJ-O9
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a3798794d3so4649078f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560241; x=1750165041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPmJc92lIzdWkVRDqUj3SpAKD/Q77Fm/aYA6SSL5Z8Q=;
 b=NSRWm/vKXhTfMeGAjSHfoj7Qe2mej7L0pyhAEXbb0Pz/51c+Eurox45fAJZ+8ps6m+
 ECKlneZxYxv9Z0WJbEMizUC4pxAIyqsBqdXLcMR02iLlY1qX62L7u/N5EuxO1kXDitye
 q/CY+lrT8zFagl3Afi5dsL6tvkKiSzxntueF0VvvEV8YhO3HehppsUd6gAi5gmAMSaKJ
 wNicg+l+8aTX05h/DmaF4+tbXDYya2Y84LU4pTwarbNdGMHH4JYYLKS2gaUkcc/1bMyI
 Km9KlqLVndeY07oXNbeBaPGaThWfmJWWOJKaptAAGckN6Cv46BDm5IkQZ4KNbA7FR96u
 7PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560241; x=1750165041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPmJc92lIzdWkVRDqUj3SpAKD/Q77Fm/aYA6SSL5Z8Q=;
 b=W1RRLXrcIzsu65YxrGDc2xB401Pw0+26+wrcl8uAHhATnd9fKfMvUlVa6JpwK9J6Ld
 baMfcQcp+1eAofa0yxana8cWPMXfoW1VV4Yd1090PSodqsYPCLFYIovE4RMBA3hb6/ob
 Qmqx1zfzYcnurNqAJohbQhpArHPbHLsivrzLtNRCLgBTpeEIy5Vwxv6WbABZQjjKbKqa
 Y9d7n6MiuFrqtT5tfkJiOaNLp+Dhp0FaEbukQw4bDaZXo8zodoxCNFrvMP47fGbTPKfv
 3avjoYy5utn33QBvFGMgo/tbrosrFU5C+b2x2a4V40X9laBjMlSB74X9r3w+9/Bsxrl+
 n5Pw==
X-Gm-Message-State: AOJu0Yy+hcLA9iesD+JwTJR06PLlJl7cl5n6kkwdjK/JiUPFln1t/v+j
 AEFAER4rllE4sOvnu3Uy6I3Hhr3tGbXGx2XgfEMbM7RetvixJ19rOuhxBgPaPNI08nHved6kCn/
 JuupmHQg=
X-Gm-Gg: ASbGncuCj4pPIibUJ0aoVQnShFU2F44/SoyHGjMWwAI1oESABB1pzMC2Jc0DWF1tbIv
 LV+Jt8rlebZpUgtuWGiU07nmgOZxlZMZ47xmc+39m/yKrarm+IOQlvkDvbRd19wBNcK6tz8ozs8
 gqtR3xwH25KYWE35RH/hEAQ+otgxnKDGzVNG0SFF7IXfXKIs9PJMZU7DJZo/ONTtuXXJ023U8D1
 SlBwhENE4+Waygnw35EVMzKPjE8L1rlyjGv2ShkEJ4WmKdsLIXwBvrvwi+gJr4uV7d03aHIxtrS
 SUyAoZiWRYr2Sa04C85DYVOOLEqbcRGryP8OrtakhGSbKJc/9R65PzVj7Kos2YklSWvB/QzIRl8
 PHbpCFJL0n8pgTDZwk6eVu7xcAizKMfikjMNymQsqag==
X-Google-Smtp-Source: AGHT+IEU1+LvNWoW0KzES8IwdL5liaSDBBn2aM68LsBKWLwDs6Y3NdsbhEv/agPdn8CX8u/SX89+aQ==
X-Received: by 2002:a05:6000:4313:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3a531cb01acmr14319771f8f.31.1749560241380; 
 Tue, 10 Jun 2025 05:57:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229ddf6sm12079422f8f.2.2025.06.10.05.57.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/24] pc-bios: ensure installed ROMs don't have execute
 permissions
Date: Tue, 10 Jun 2025 14:56:19 +0200
Message-ID: <20250610125633.24411-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

We have been inconsistent about whether ROMS stored in git have
execute permission set, and by default meson will preserve source
file permissions when installing files. This has caused periodic
problems in RPM packaging as executable binary files get analysed
by various tools/linters, which can trip up on the ROMs.

Tell meson explicitly that all the ROMs should be without execute
permission when installed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250530152118.65030-1-berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 pc-bios/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 79bb2e18008..3c41620044a 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -88,7 +88,7 @@ blobs = [
 ]
 
 if get_option('install_blobs')
-  install_data(blobs, install_dir: qemu_datadir)
+  install_data(blobs, install_dir: qemu_datadir, install_mode: 'rw-r--r--')
 endif
 
 subdir('descriptors')
-- 
2.49.0


