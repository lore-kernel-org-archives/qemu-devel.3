Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0012AD41D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz3-0000fF-Ar; Thu, 11 Dec 2025 13:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyz-0000dM-6I
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:41 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyu-0005zy-MV
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:38 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42b47f662a0so254936f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476095; x=1766080895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqtmNswMbkYyEU+NhJq72TVMbc6kD4yPFILIwQaGzrE=;
 b=gN6nwbrUHSULI6cfeRhrGby1w5S7SYDEHhaTjgbNVQGCmMDpzzClbYUhLlI8bGl61f
 cKCzc8ZiGqrQ33vnB6hl5As846FIDVDqBFCgrH2j2QUdxbB4sSfuN0N7pzYsbnLdhnaJ
 G3rUFgn7Elm4QAmEK/8Wb4iYRgPiPL1jVAlKVryDdQB76RCjGQbo0ooWvZbyz2vdnEKX
 V88HTpxDUsCe2OlM2pWBPBmZqa16Aqf43jCWUy5r4H1yT4IMJhoKfl06rInDBzHH/4PU
 vy1g8FIyLDx2V0zisO0XFuF8hNncvZT01lqZMbbYggITFWyFM3zS93H34k+ZZ+6reAb2
 UuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476095; x=1766080895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqtmNswMbkYyEU+NhJq72TVMbc6kD4yPFILIwQaGzrE=;
 b=FVDGYRtpxXU7IjfXfnDFKwXLjIFArxAPOt1+//Lk9RkB4zLTA5V6ATwU+HzulGDBGb
 9ZA258yZFIvx6gx+PzBpYiWKqsugGmbJ/hCAgh9zyLohp96rf58TTyVZXcgaJ4wnPYfx
 yZRHjD1aGRKkv4eV2kq/VUj3/5W1oQ/8iGw4D+uaKTBoJAdcI9dKOJqxvXm67fPpQ5YL
 y4aX+OYC7+Q3kOk7qnmQO8ZnkvitB7kUkPiP68KhldJ12jao/E2A5pcdOKume/ofxJvt
 CyJYNXBe3DMTunUoth+dPhEslifwV+RAbKuy9NBSRmtbMUjaoTzadIY1xztSETWAQnHp
 ue2g==
X-Gm-Message-State: AOJu0YwllFOdz6VCqXIrmI8pIacwxK4EXzmrVak1Vqmc8zIW0pdbyl82
 3+SWJAkTDZ+vyn1RQ5SsCcTRUcpcj4v+68WKZZs/zYJckiOVN9LQmVAm20vDXaYCWXA=
X-Gm-Gg: AY/fxX7xFxCmsCvDoxalipHkc5lF6uybO9pIma1hPEXR2Ryf3xZqRqWBo7YZkuhJy92
 yzqDv8yarIcEGUcMbc1lJ585/CNdAs5vh5baDd8ngYIHG7TUyfrVFElZ60mlcHEOIS2VxowaV2D
 NIaJu0KScHR4Sbc49rTZHGK4g2p0yyV+6kTLCLl1se5M7hbtx/aOyImDxR6P4MPWPVINCgl0bAu
 cEyt1/7o9Ma30uG/x9kh7e5mgV0SPLioVmYgY8gJFNpVC+i7v6DUw46G4Z30j7U1F1E+Ofjt1sz
 LnN9kFl2rNrIoG3rYzoXrfiqDZ1GL4UFYO8Q6O5H9eFMkGcc1DnfL6z6jMia5Zyf+SVOqeTbaha
 UxzW/f+3tzXMnE0TUjFrIyMe2enYiZbMuYwEVGRcporVGdheJJWjpNIui6vKfJuUJivjkmrixX4
 XJB5HpDMt3FsU=
X-Google-Smtp-Source: AGHT+IFmb61jMTBPRLp0mm/VGiASOfskbtXklrhUS30Py39UYj786+iLBTtuHPoaWHlZpylwSiqouw==
X-Received: by 2002:a05:6000:208a:b0:42b:2db2:159f with SMTP id
 ffacd0b85a97d-42fab242bdamr3777340f8f.12.1765476095065; 
 Thu, 11 Dec 2025 10:01:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8a950sm7857530f8f.32.2025.12.11.10.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D75535F892;
 Thu, 11 Dec 2025 18:01:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 3/9] MAINTAINERS: regularise the status fields
Date: Thu, 11 Dec 2025 18:01:26 +0000
Message-ID: <20251211180132.3186564-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Orphaned isn't a state, Orphan is. Likewise all the other "Odd Fixes"
are capitalised so fix the ones that are not.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3fdc4ca911..4488364c14e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2662,7 +2662,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-S: Orphaned
+S: Orphan
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -2884,7 +2884,7 @@ S390 3270 device
 M: Halil Pasic <pasic@linux.ibm.com>
 M: Christian Borntraeger <borntraeger@linux.ibm.com>
 R: Collin Walling <walling@linux.ibm.com>
-S: Odd fixes
+S: Odd Fixes
 F: include/hw/s390x/3270-ccw.h
 F: hw/char/terminal3270.c
 F: hw/s390x/3270-ccw.c
@@ -3795,7 +3795,7 @@ F: tests/unit/test-uuid.c
 
 Yank feature
 M: Lukas Straub <lukasstraub2@web.de>
-S: Odd fixes
+S: Odd Fixes
 F: util/yank.c
 F: migration/yank_functions*
 F: tests/unit/test-yank.c
-- 
2.47.3


