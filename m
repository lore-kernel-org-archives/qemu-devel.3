Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A84C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQur-0006MT-3T; Tue, 04 Jun 2024 05:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQup-00069a-BG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:15 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQun-000272-Mb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:15 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so917137e87.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495032; x=1718099832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImVmefo1MlwAmY4FNzose8vP9/wMtnxVjazWG/n/+Lw=;
 b=Iips2Im6vBwTDCb3WLOsaVMwPyunx4KfWRy+1oLXKorwGVn213VOO9u9oluQ2I+MfY
 Rw4+0cp2pJ2P6gvnlMXxn3cSpy6HB220pKPUglwiU1EPqN3NjM1wFyx7IujrD1G5J1Os
 3htD8d1ktaDGm4Gen4jFqm/MkZSuMFfpmMsBA3o8Sx7VCKuueaGXgJVENAs7HF+WoKhC
 35lS+0sG9GhzBS3zAzSQqK310k2qT12LKo9MjUePSkvrBc22WxJ1PYbd+Bxf19RTgydX
 jl200G4uJF9fkF4keDXjTYGB51v2sumtmEKx6X8wbYWlbHx76EBpeiXt5wUNmOzBdI1c
 RTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495032; x=1718099832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImVmefo1MlwAmY4FNzose8vP9/wMtnxVjazWG/n/+Lw=;
 b=JG0tA+dQFfrjmrDzqqfddra1d841qx8wKAQ0qrB1JPQPsAht7lEPQ9Gg5IaZYR2tIT
 /aKQ3k5tAwOpfcIxT6djskzYprqdz+tmtXviv1wUViVuKdcMbmgPu7DyOGO71rk1vtyj
 zpUq6plaIFGdfwIqT76/memVrG2F+AjN+0R7/XZRWMsvfBRcQqcDmOTKrRLPRsgDjJrx
 TjPoTjOo9C9oGdDlajuD+/q1wmqpGQBRTI07wleJn+J8CEEqwApk1rSc+Tca+dP2DI8X
 PDEZWvYNOLSAE+9YHdX9Y/Zw4UYWeYvo4F0VwhPhqaf/8xVeRdS7QeyTyIqlmKfBLUov
 YucQ==
X-Gm-Message-State: AOJu0YxbD6y9k1I5qQkci6DDSMlTINu4vr+nzVtWxoMf7PSjh23w8jh5
 jhQKgPYbmW+f0bTaLD4f8r0ZusIbN6BNelvhIA0Jvy/VlG+dcy4BLMpeaebdMFZfSSL5yhBoQC6
 Y
X-Google-Smtp-Source: AGHT+IEnB+OfoGZGHL7izD1AQ0ApPkEpicQlRTfCoLwEG1OAbzt/sn1ZXy9I33G2SdxSt0XWdH62nQ==
X-Received: by 2002:ac2:5b5d:0:b0:51d:68fb:5d73 with SMTP id
 2adb3069b0e04-52b8956932dmr7798641e87.8.1717495031553; 
 Tue, 04 Jun 2024 02:57:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0de3sm11095383f8f.9.2024.06.04.02.57.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/32] MAINTAINERS: drop usb maintainership
Date: Tue,  4 Jun 2024 11:55:47 +0200
Message-ID: <20240604095609.12285-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gerd Hoffmann <kraxel@redhat.com>

Remove myself from usb entries.
Flip status to "Orphan" for entries which have nobody else listed.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-ID: <20240528083858.836262-3-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 448dc951c5..5bc478f7ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2141,8 +2141,7 @@ F: tests/qtest/fuzz-sdcard-test.c
 F: tests/qtest/sdhci-test.c
 
 USB
-M: Gerd Hoffmann <kraxel@redhat.com>
-S: Odd Fixes
+S: Orphan
 F: hw/usb/*
 F: stubs/usb-dev-stub.c
 F: tests/qtest/usb-*-test.c
@@ -2151,7 +2150,6 @@ F: include/hw/usb.h
 F: include/hw/usb/
 
 USB (serial adapter)
-R: Gerd Hoffmann <kraxel@redhat.com>
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: hw/usb/dev-serial.c
-- 
2.41.0


