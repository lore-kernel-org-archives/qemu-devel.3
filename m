Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F55C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLee-0006Yr-M3; Wed, 29 May 2024 11:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLed-0006YA-9Z
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:55:55 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLeb-0001C8-DA
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:55:55 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so225858a12.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998151; x=1717602951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MEfV/LHTtxknexC1VCl/NQG/4BOPKASY1nM/6kx47Gc=;
 b=wajPMbqULDjaeHQbeW69vuMdr0OdIR5C43WifQ+OQWlHv+1rtgLDe0lBXxRH7UZdT+
 h2ow4N1YDPOVUzjUJtxaxgK94A7KYpvuFQvx/n888K+Ti78SJhEmvAQcr9k+5iYOtC9+
 yWAmSUTh8C3zg55Kyl+FI7/P4rN+HTApS8Dg8k3Zi60zAHjEauc9SiQWQhupa13haQBa
 QWUqsQde5WqERQy9BxlA2nxuV7yazFFpUVaMv7pSFYuu1lEHw4MnGc0InxkvD+goTESe
 l84fy4JbtIqgvovv5rBvHebRE4GNA8UneQXrwuVNnbOw2zfMhZlOiMhzfjg16vwWHH6E
 R0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998151; x=1717602951;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MEfV/LHTtxknexC1VCl/NQG/4BOPKASY1nM/6kx47Gc=;
 b=WHdelwCUflLtXYX7/deBw4F0iT0y/UbcTIMGpzBOxKPLJZWHqyTwi688EGA9Ib+2Sc
 FPntkxdKaMub3yhP81RY6IeEQXD6QatsIXF1e0NJ2COMtY3SomcpUafh/RiRykOJHXaD
 1hQcNvl9LTdkAEKalSq7ubX1FwU8IQVhVDEz9Hgup5D+XqYHceAe+PJimSPDcLxKUqy6
 pwBqsywYcud4xY5j+KFDx7rFaW/+j/yc3sGWptnWXh5Gv6afk+ZfU80l2K9VdJxxD+dD
 zyG3Coeumj9bDaVvQB/a7t3vTORjvcBJrz9RzCx2fmWkATveb8r7nRezewweYZ20BvON
 Vi2g==
X-Gm-Message-State: AOJu0YzVAx2VFvqqngNw2taWQzsMtSOVCfjMhk//2PnkxnAlqcrIbjHt
 8WqxIUScwk8S+Fah2rrGNTBiZbeRUU24YQziHfjSbXkw+Uth5DfBvYCgRvYQ2e2vDND7mTMYF3K
 /
X-Google-Smtp-Source: AGHT+IF2zXEH/FzFWK7yCrYJVFZ8FP4wvdf0M0a5GUAJXJHHid1EkqT3KLHnyL1pFclPTClj8dyaBQ==
X-Received: by 2002:a50:9996:0:b0:579:d34c:396a with SMTP id
 4fb4d7f45d1cf-57a03f7ec17mr2160355a12.11.1716998151227; 
 Wed, 29 May 2024 08:55:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57860a2eab3sm7462003a12.28.2024.05.29.08.55.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 May 2024 08:55:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] semihosting: Restrict to TCG
Date: Wed, 29 May 2024 17:55:45 +0200
Message-ID: <20240529155548.5878-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

It is pointless to build semihosting when TCG is not available.

Philippe Mathieu-Daudé (3):
  target/mips: Restrict semihosting to TCG
  target/riscv: Restrict semihosting to TCG
  semihosting: Restrict to TCG

 semihosting/Kconfig  | 1 +
 target/mips/Kconfig  | 2 +-
 target/riscv/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.41.0


