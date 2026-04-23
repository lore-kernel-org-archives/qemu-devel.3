Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E141F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFquh-00087W-Nv; Thu, 23 Apr 2026 06:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu0-0006VZ-Un
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtw-0002Is-Br
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:17 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so4401447f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938595; x=1777543395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YOyaac/ldGKuN+XC25ESAWOFzoZJtPFbNO1EUt1ltGA=;
 b=fm2ztJqGLqwy6/oAFBomwODyz3QwmKc0g/MNDiz80FMkbvdr0X3fonRnzXkUcr6BxI
 z9mXT6HdFIbwY8QWHhkdBcLjuMFpkOYx/L9bQQqQ/ZHoH790c1wUXkD1aEB4Ks9opVRo
 yrWFJ5gT+Lo8b1/7fpAEKcTfmdb9/tuTuFiAjJu8j2QjwvIcpXjlVrN8roWHYJ0xSx7I
 1rpbmHPtZpQpX+37mJSTmVOcH2P0yFeXLDUkCNuZ2We4GEvwsDyVdxfSGOHden1thcEN
 Iqee4AH81I7HrXUNI/Gqmo8F/WMs2GBblgCMXuvT+m2h1sJACg1uGh3gGraAgoPc1S1S
 oGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938595; x=1777543395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YOyaac/ldGKuN+XC25ESAWOFzoZJtPFbNO1EUt1ltGA=;
 b=DWDQ/ODz7JPrcFXrxr2DZLEvPSHnS+ktvOyl+mhAHseRkKjVEBEQaAqYNbsAbqD38z
 LorE868w4LgCembNr6DMqQ8+Qmxd4qiAnxZW40NALeo+woinMJUHybQga2vpFj4/H9+K
 AUNMp8GpuE2rB8rFezHquXOIgp32TqQJEC1ZALtmq4ekPa2t99GIsN+Pjm//Q29vU/qd
 QuzWsn7lWQmnO0/4GnbP0eBNO9MaSf+/wBOvcXj8XVycr78l8Z1gOWQKE1a3P/gPqqHE
 PCZwNErSi1HjtLQ7NZs7f1a5YovIUSlJ2eKaySjt5N/DToUEUn+wBV+6CEIXRcBzJeHr
 m1QA==
X-Gm-Message-State: AOJu0YyNwaA6kqTuY0Z6tR9/cfF+gUK9Vn6jpdxBJA5/SQ5LxCc2/FA6
 biTV2u47N3YCwW48iF6x+Wff8nIcLib9Ys2TgFbBLoSW5F2Yy9gjRkOtaaHduVFiadQPPnsBiwu
 6+fuA
X-Gm-Gg: AeBDietnshNUfvgkaN0cCHKL2FSbfic+lSaFhoh2blWl8bmtx/em5I5WG8uqS7+Wo5c
 4hu9Yr8rq9Zm9lHsLvohieMeBXJ76ScJUtEfTFK9QArnHH/FHG09PZYZyQwN2xdbxhZSVrvI13c
 4xEOXVtD7pxxjmA289yXgkN6ATIvZzrnOSZ6dh9RpfMy72muRfPIWCyEAX9If+72EVIunGkvM/F
 6J3TmhhF4ZhmIs4hU3u4uqBLTP67m29FfMPvdf1q7W6t8Fa93Lr1gnXnqdg30v44+0n2cutYO9X
 nNfdTgw+kiXAgxBb0tKdkJlTpEsmfy4xjSpY1xMrd91FeR+QOU9jYMvL6VQnREE4ho62efTNJmm
 7fQT4N0v886CoNcc84udiRmjTnxp/RP6BKDCciRzUz/5/H2aoekHMwdYxpQ5dWtWyjB2OL1oVdz
 4Wr6DC0v8bbL8OE8aehVX03qEwSPSuH9UG0Z8acQnM6Cw7KaYsZfwH9Cfw3SRnfiGBCvNL8WtqH
 Q82t1b9WWh7JuI5OE8Ha1KIjYYxNvzRf1xWcN4NuQ==
X-Received: by 2002:a05:6000:4283:b0:43f:e211:1090 with SMTP id
 ffacd0b85a97d-43fe3db3c62mr39345262f8f.1.1776938594861; 
 Thu, 23 Apr 2026 03:03:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/59] MAINTAINERS: Remove Dongjiu Geng
Date: Thu, 23 Apr 2026 11:02:10 +0100
Message-ID: <20260423100229.2941820-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Dongjiu Geng has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the "ACPI/HEST/GHES" section orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-9-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 34944c3948..db29b267ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2220,9 +2220,8 @@ F: tests/functional/x86_64/test_acpi_bits.py
 F: docs/devel/testing/acpi-bits.rst
 
 ACPI/HEST/GHES
-R: Dongjiu Geng <gengdongjiu1@gmail.com>
 L: qemu-arm@nongnu.org
-S: Maintained
+S: Orphan
 F: hw/acpi/ghes.c
 F: include/hw/acpi/ghes.h
 F: docs/specs/acpi_hest_ghes.rst
-- 
2.43.0


