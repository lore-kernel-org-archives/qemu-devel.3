Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3061DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnqI-0003bY-Aa; Tue, 16 Apr 2024 14:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqC-0003ZW-Ul
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwnqA-00031T-OK
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:47:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4185e80adfbso13796815e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713293251; x=1713898051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Spf4Zi1bBqXxf2Gm6GK4HE1fTrLcNzSmKtfAQewlYLg=;
 b=dd7N3ZE3hFx58vqNiJMX/fOLvm2IfdKY1DRm/XekDtR9wYR17mHLetsYE5fY8fbvgH
 4z3WayQ5xC7tYYVuZkzQGA+H2x4S4UvROCxQgSjNIGBxECTeLmQrJXGpI7yFy/Th9Cyx
 uL4lRau6fR9K4N5Ry0JGc9IGvdkIHn9i9olEnkZ1i4TchNx0mlqWb4z9Fux/Ri+zm0Bh
 8NV1AmSdZuSTjr2K6j/ZlreoLEiFdiDHb4mv2YtmwdSFx0AYB35xffBQNkL5uixyWxfc
 LZ2DdeIgznowhAKSCxqBa2fZHsOUezLl8hU2STOnyUcF3tXOvhxIirlaQwnsWfaOtDUp
 1i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713293251; x=1713898051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Spf4Zi1bBqXxf2Gm6GK4HE1fTrLcNzSmKtfAQewlYLg=;
 b=N+XcZYD7KvXYD+Smdo4o/Z06SvayNcqK6iH/eIXKBy6miI46eVP9zD10idaWsrJ4bQ
 OXtiebDEYhpOzj1ZYmSwzzOBKwOGi4Oi8gi3AKgVICTvBlHA2PR7ZaJZgNapAY4YOrgr
 O3k8esVxH99jcwzkzYvY/Qy6R1E0i20wltR3EWQeWPCE3u/YR54i/IMtTWbVVdFoJUgi
 H1W6NazOsdEfiBJj9HKNA1TZbXUaZCuT3d1iXh24g/fE5g4Ubpu9L7cPVoLvy8SgCQif
 GCP1wHetQzox9MlvbsM59N2FcVxqpggwLtX9us+nElRxQRg5xJsFf+4lUMoLZ48jGEOC
 c92w==
X-Gm-Message-State: AOJu0Yy5JQcbFpU4phyxd7E/xkO92AXdvXZOnml07lCQ3IU7VHLX3w8W
 IKdgtCGNP+uWyA2FhPb2Bn+K5ZDDuOAz+T620+AF9PEwYbtK4giVGD697AKaYpLLHsjzX5Kx5jz
 Y
X-Google-Smtp-Source: AGHT+IE7UA5gf8SSfl83cHXb/2Xy1PaQGFDtgpO4jHPz6k1P3QaMR1axOMDHC9+aOnzWss5gvWEM7g==
X-Received: by 2002:a05:600c:3491:b0:418:2323:e87 with SMTP id
 a17-20020a05600c349100b0041823230e87mr7283079wmq.25.1713293250787; 
 Tue, 16 Apr 2024 11:47:30 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 e29-20020adfa45d000000b00348b46a134bsm2810947wra.1.2024.04.16.11.47.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 11:47:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] hw/i2c: Fix checkpatch block comment warnings
Date: Tue, 16 Apr 2024 20:47:18 +0200
Message-ID: <20240416184722.28334-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416184722.28334-1-philmd@linaro.org>
References: <20240416184722.28334-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

We are going to modify these lines, fix their style
in order to avoid checkpatch.pl warnings:

  WARNING: Block comments use a leading /* on a separate line
  WARNING: Block comments use * on subsequent lines
  WARNING: Block comments use a trailing */ on a separate line

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i2c/i2c.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
index 2a3abacd1b..c18a69e4b6 100644
--- a/include/hw/i2c/i2c.h
+++ b/include/hw/i2c/i2c.h
@@ -4,10 +4,12 @@
 #include "hw/qdev-core.h"
 #include "qom/object.h"
 
-/* The QEMU I2C implementation only supports simple transfers that complete
-   immediately.  It does not support slave devices that need to be able to
-   defer their response (eg. CPU slave interfaces where the data is supplied
-   by the device driver in response to an interrupt).  */
+/*
+ * The QEMU I2C implementation only supports simple transfers that complete
+ * immediately.  It does not support slave devices that need to be able to
+ * defer their response (eg. CPU slave interfaces where the data is supplied
+ * by the device driver in response to an interrupt).
+ */
 
 enum i2c_event {
     I2C_START_RECV,
-- 
2.41.0


