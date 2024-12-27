Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A828E7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 20:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRGt1-0004Ep-6w; Fri, 27 Dec 2024 15:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGsz-0004EU-Ev
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:24:41 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tRGsy-0004z2-0o
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 15:24:41 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e3621518so3503906f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Dec 2024 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735331077; x=1735935877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9MrOGxf4wy56MqIqYLeWo/x8/KYygjnPnkZEDiH+gag=;
 b=moZbsCY8XiubuG1ZLjGwHfW3boPkwYj8GLN6OjV4RBIIurFakaw9k2o1F/YgXMy4pV
 6+UfjxDdfeQ1m9ihqrs0HiC//T0m4aV+QiLhYHZFZGfyPg7by8RU+0kuqdOEe2EU2UD3
 K/6cxR8lcXjpuHwyg9m6dwrPspfj3CMRcBiasOQ/2iRtrcw+klfgOT3Mz4HP+oDX2xRY
 0NzToIJFT21hy4qKlzLPA+piiMjaX+oC6erqzzSEkBwPDRNTNDVuMVNOWVrh81UEM596
 zg+h/N9oHmgXv3seIbGo9gT9bZLfeWMLJtD0q3RP3RBw/CAJVQ9GHPX9u8fBKaePcKmL
 hjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735331077; x=1735935877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MrOGxf4wy56MqIqYLeWo/x8/KYygjnPnkZEDiH+gag=;
 b=J2WL5LUahQB0rlSw+rxa1YhY+UnXexVYOausSpOwMmq4gQ04sZMH25QXJKSnRYiUy2
 mLxVWrvgaE1DVAbeKu5KzN+tBtHw+WEc3dqNf4KEvb3v6pthUakukSXwhNhARdYeI2FF
 sBwP23ILqhb5WaUNDensVxku3fv+Isi9+980+lCOQPg6THMO4uAAx0tp2B2OuV3J5hwP
 edHGhBmWfVWPgD9TPdcb8q2NBpgkIu5ivs9EkiB+Y0VjVh/lbVrPPRCwcTGWJM9JCudX
 nMzezPbXnw8ZKeu1JuBzWE7DFEi98MqPXqBmjStaHk/uMWlUeB6QKULebo6zvuEP7T80
 NwXA==
X-Gm-Message-State: AOJu0YweKVy3leJWk1P0oQaUNLhV2fOplnBoDrepf5RYaKCCxFgjtCXK
 qHYyGfDg2f8SHFHnpsJxrryKpbWdCnQJRpZRfPgzjfJ9okrswdA2THxC97VUGAJcL9LNVkl6+Rl
 1
X-Gm-Gg: ASbGncsqOe/4wciNbRKeV8aqa94nPz2Fd/5mUfvCInwA1uPq3Q2RSaWQQjSzvUZgrUJ
 FijKU+KEEol8akzSTa7DfGok5S2BO21gJwz0RlV2W4EZmQ1/2viUplI1CyyJSoc5lVx6yHvxT8l
 SNt/8u9/vdGA/XMgVNqhqYz9Ym3jQM6PuW8mjFSAjZHWpKj3amg+SsQT8CNNjI9cgO6V+bB+hmm
 /LODuo7f/DYGt8PBvzci5Xf0FcJh+UAxhfdEPma7D21a8rcT/tjcN1Kwt/1qm0xiajadQpFtf1+
 MGi2kjTrhotMnxPPr3163OuXHN3d0eA=
X-Google-Smtp-Source: AGHT+IFr4qRvZIgwmhqzqRTz43jjdJU7zMglA86N32rHIjoeGT8jIhvIfGbk0b8VpPy6EW2gMt2iRg==
X-Received: by 2002:a5d:5e09:0:b0:385:faec:d94d with SMTP id
 ffacd0b85a97d-38a223fd75amr25716130f8f.51.1735331077451; 
 Fri, 27 Dec 2024 12:24:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2b0sm23419435f8f.82.2024.12.27.12.24.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Dec 2024 12:24:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/intc: Select generic ARM_GICV3 when KVM is not
 available
Date: Fri, 27 Dec 2024 21:24:33 +0100
Message-ID: <20241227202435.48055-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

ARM_GICV3 is not restricted to TCG and can be used on HVF.

Philippe Mathieu-Daudé (2):
  hw/intc: Remove TCG dependency on ARM_GICV3
  hw/intc: Have ARM_GIC select ARM_GICV3 when KVM is not available

 hw/intc/Kconfig     | 6 +++---
 hw/intc/meson.build | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.47.1


