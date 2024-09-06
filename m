Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D315FCE7B11
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ1b-0003U1-42; Fri, 06 Sep 2024 09:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1Z-0003PM-1d
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:17 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1X-0008Mq-2E
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:16 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a868d7f92feso282760066b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725629353; x=1726234153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=higbf/H/m+iWK5EKx4vHWTv+DJVaDMOZrGgJdkrWBZw=;
 b=ghmErc8EFFFs4Au1Utj3rBV9Y5KNH3RL7VTUAKbSm6koDElHBTU7nmyM50ps2VrHUZ
 UU7rQDlXyfeYz2WZXRvSFm+V+TFXAUdIHm81/bDX3tM3jqJfw17GyLl80RAzb9uAu9T9
 CSttIXIZ3e3Dbm8i///NqVoG7brhSbAIj/ihA5D46aNxnuQvKr1MvdLBTxo3jhne+KVa
 f4NYSJlmWYR3xfVpVyARa5FnsrfjONgfy1+BzaTPEh/Fp/uv48gbXBLA/j63WtK6PSlT
 cLqwzvFaTuQOrO2UNkLxtsz4VvM43NkOmQI8Dbk2x3PBzY1rr2Lxr6CYbjzfGurGbORh
 CTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629353; x=1726234153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=higbf/H/m+iWK5EKx4vHWTv+DJVaDMOZrGgJdkrWBZw=;
 b=I/w7NrM8QWR4PK1kp/DQ/7pdC8LpIAEAhzW9M3SZ4ZTAAZwuP+QOSkwmzZuUeGTIf/
 ma8vvTrSwGepsINtKYJ8KN6gw0eVrlyjxF8OPCIeFbgwYCSuUIjL3shCUYb7HmFEvZyt
 qxbgiiSOJn28wfcC91U6h5rg5lRG7HmTvOH1h8diwAqSU7EWpTXmxiyLHd1n863cm93r
 CIqtSEtNWlMwMuXaP1AS/aEcG/IxVzmHJnvmny/gdok3ICW9L2LR9gotbs2USViTpdhc
 W2H3jIF31dshYaS8zB7aZ9MXgx6jAPHleA8hF5e1ueEAY4nhHsGJSmriH1O9xQIUkvSd
 2IUw==
X-Gm-Message-State: AOJu0YwXBP6NmkPq18yzffoPO+pxV7g8wgGLAhIZffWMa0cOjgs/SN6+
 5pDzsmwfo5r8VdjQcMMlA0mrxzSePzkkl18O/Xpr6S+bZUi+I25nyeivzscKronbY02jhb/3Whm
 Q
X-Google-Smtp-Source: AGHT+IHogDMtRAzlCIX1u7xUR9Bp4EqGW2KcveO01/NIAq44HpxD247cRbcQDbRUa01d8YYel2MV5w==
X-Received: by 2002:a17:907:7295:b0:a86:9d3d:edef with SMTP id
 a640c23a62f3a-a897f77fa48mr2295729066b.12.1725629352516; 
 Fri, 06 Sep 2024 06:29:12 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a623a690esm278804066b.175.2024.09.06.06.29.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:29:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] tests/unit: Slightly expand FIFO8 tests
Date: Fri,  6 Sep 2024 15:29:06 +0200
Message-ID: <20240906132909.78886-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Since v1:
- Correctly place patch hunks in corresponding patch

Mostly add documentation while reviewing them.

Based-on: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>

Philippe Mathieu-Daudé (3):
  tests/unit: Strengthen FIFO8 tests
  tests/unit: Expand test_fifo8_peek_buf_wrap() coverage
  tests/unit: Comment FIFO8 tests

 tests/unit/test-fifo.c | 209 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 201 insertions(+), 8 deletions(-)

-- 
2.45.2


