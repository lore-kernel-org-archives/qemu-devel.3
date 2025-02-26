Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D38C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:06:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI1w-0001ta-IM; Wed, 26 Feb 2025 09:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI15-00019Z-3Y
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI13-0005mB-86
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:04:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so65586265e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578639; x=1741183439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1MMLvZbg1LX5Rz6KSjocH3HVYPB/IR+83cVCtz/KGM=;
 b=KWll6xqgakd5GyeCgUUfeb8/VUBrk3mdhZlW9fTQrwWJk5DUEogxlQaEsiUMe0Rkj8
 iEbaYwGAwmboZwoR83FJNfYk2uOdWhFdgYVWpw65HYH4OevmIVDDv4sKOulaAO9sM354
 fw1hZ+A/p6+XyrEFf8tCKwUW49+K62iaWaTu5JYt5A+84MEMhPGJQdBvqtrSuQwpqRs4
 Yu7nGJWGRaD1MFu3VEGighGyx2Z7csYSBGpVYlFxdZM5K11O0TuLN79aY6c2sGZrunBI
 oeIHFo8qv+YekwUtLKRUWyVy/g6BMPD82mAOJ398xMIYVhjunei8oQaUIFvag2iVD+q+
 dAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578639; x=1741183439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1MMLvZbg1LX5Rz6KSjocH3HVYPB/IR+83cVCtz/KGM=;
 b=TVBIsKDrQUqlAIyseudaX561J8hcZ263ni955L6EVDH+1shGh4oDhq32cj3OU+880h
 3Fgw+aWzjet/qdyryM2YDUzdHdgpr82FrGAD05NwFKBpqWN/NCwRDEJKgi+hnbUYsm90
 ZYREl3iCZ0P0tG1kpyPk1bCsN2QblM3aGDmaFr6+aEXm7HNDvm8eHv9GDvDrdyUwosIa
 5qk4nKmksem5a5ZZ+O+MqregbZx8PHg0ETdoGfGbLFCjnSLkmLfLBvLYKxhExlKTL1SL
 /r+vuj9fiyDnNJKvdnsc3+8ixIRTumA9TQ4NHUpco89U+7zieFpf/RzK48+BBD2463Ls
 wgOg==
X-Gm-Message-State: AOJu0YyWKuI6vsTcpPxULqDIzM0b1M2H6kbLa/gOpSgO+g8RtAfLEQAa
 8zizrhE0uarbU8MCMtZzkgxfwy2IYgfoMBcFt/Jg6aEV9K8sr/wQjqifp0SCL3g=
X-Gm-Gg: ASbGncvEer69kjI1lX2iNdJR6Qm1Ht8cslKfIsbqONxfzBh8Q4vV33IjJQAh9eSaA2/
 rlSNmUZzoYkKtQRQgBDlUrr1OEzblem4Gny18efPofNTmCf+WvizscczwiqryNpvF8pLp4o77X/
 AMjnw03YNJI0gysZLiRl/YLj8ZPg9dC5DVPHq0PpMc1JG49IHATcglFiqeW3A2eo5dAyrB/6FNn
 fg6Y1D0Fbsx/muBOzakv/PEkKJei6DAZiK7O0WDxQ8YTQLFI4IntPYtKaDzPRzdqXE2uF8KLfhg
 iKnf3+rD+G9rklp9HGtCHadKdA6s
X-Google-Smtp-Source: AGHT+IECTYhG8QM+//FBl9xrzDWUnh7arnZz/ezerS3qJ2Z6nSgdXc95N1dTzOXL8rUuDkVAq7H5JA==
X-Received: by 2002:a05:600c:3b97:b0:439:9ee2:5534 with SMTP id
 5b1f17b1804b1-439b04f9d11mr175084255e9.12.1740578639446; 
 Wed, 26 Feb 2025 06:03:59 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba58720esm23260055e9.40.2025.02.26.06.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6580960920;
 Wed, 26 Feb 2025 14:03:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 25/25] MAINTAINERS: remove widely sanctioned entities
Date: Wed, 26 Feb 2025 14:03:43 +0000
Message-Id: <20250226140343.3907080-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following organisations appear on the US sanctions list:

  Yadro: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=41125
  ISPRAS: https://sanctionssearch.ofac.treas.gov/Details.aspx?id=50890

As a result maintainers interacting with such entities would face
legal risk in a number of jurisdictions. To reduce the risk of
inadvertent non-compliance remove entries from these organisations
from the MAINTAINERS file.

Mark the pcf8574 system as orphaned until someone volunteers to step
up as a maintainer. Add myself as a second reviewer to record/replay
so I can help with what odd fixes I can.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250221161443.2321327-1-alex.bennee@linaro.org>
---
 MAINTAINERS | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1911949526..9cdfe19115 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2529,8 +2529,7 @@ F: hw/i2c/i2c_mux_pca954x.c
 F: include/hw/i2c/i2c_mux_pca954x.h
 
 pcf8574
-M: Dmitrii Sharikhin <d.sharikhin@yadro.com>
-S: Maintained
+S: Orphaned
 F: hw/gpio/pcf8574.c
 F: include/gpio/pcf8574.h
 
@@ -3627,10 +3626,10 @@ F: net/filter-mirror.c
 F: tests/qtest/test-filter*
 
 Record/replay
-M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
+R: Alex Bennée <alex.bennee@linaro.org>
 W: https://wiki.qemu.org/Features/record-replay
-S: Supported
+S: Odd Fixes
 F: replay/*
 F: block/blkreplay.c
 F: net/filter-replay.c
-- 
2.39.5


