Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF20C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfIOB-0000Y9-Ts; Tue, 04 Feb 2025 07:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINv-0008QG-Jk
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:38 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfINn-0002C4-42
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 07:50:32 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38dabb11eaaso312585f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 04:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738673420; x=1739278220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09VHH1K+AfyKzHK84Dwim4tocdMil186/qzqBE0PsZE=;
 b=qj8mNrKWplZRVo9I525f4UVmQ72nzGqPD+athTuZvv66AFUqXEKIedR0a0io2GxFE7
 ZxoFAb2b6vRLv4CXcOjDx0M/ZWtgtH+ImbN0tTSk2YBRa40HDQ0ptvDNJ+eHEcnhcHRx
 QtRqdhqguRDOoJPnVXo8MLK7ZQjw2gtu/Es3NPGHrtJRzkix/ohdfUpva2nm8Ymlvkyt
 oguV4a1Dk7xDy7DZ4dGfbzOVi1bxJBRc4r01ZTgM8RpaoRNzMxwoeVHvRsobQwuOZWpV
 hnBnQ9jOJexGjQgIdCmwmX+ivrHgkqRpzdJi3N8Yr2RD5zpgVdNYqmvIbu8862WM/DUh
 n6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738673420; x=1739278220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=09VHH1K+AfyKzHK84Dwim4tocdMil186/qzqBE0PsZE=;
 b=tBBlyXWA3bN9BFtBD80aXUpGjlHqGlxcSRPZrX8gkJedewYhvDKHzUcOmbkyUnYmPN
 JFzc/5bCD0U5Ykr7rN4uSjD9G33JGiHzcTtgVIgojS9rSH5I9gMqWbRJCvNKKtkzwXQI
 kvjw/PnsorS8mWdbojBB+PmqCsA4qZkg+HU4/aV+bVy6ojCWoHCX5Hq17a+zhOTuTdRh
 TiKLNqFURTBziZd1Qo6W2UwtVmK1kpy5Tis23YysJzpKsrQ7XrUL04vCi6Zluax911Qk
 AoRGygftIxER5zYV1BhxTtKYPaGTY0Quly4s0EgCjkqBQltcBXLXm+PsXEBXRZomxEG5
 A2DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfb/0mg5/Y59OO4vHf9kcQ+OfaKh30c0XCNu90pcBPLdVFAgOuBQ5/9J03vlxu72Wjiyhx4ck01d5Q@nongnu.org
X-Gm-Message-State: AOJu0YyRWTn8Lh1XTb2gNhc/jl3g88w4aZYn4EG4vmOtJjgcp2uTaW1+
 tBU+xTv51AunahEUdlRiqieCaZ/D2xgPNtLZjIwjohrRzqxE/iFlWSgljkLQJnOL2NFqWaT5eQL
 M
X-Gm-Gg: ASbGnctO6N6xNcfanh1zRJx8/iE11nl/jBt/k2DrNGlyWW4+N4Velig5PGQ3PQlYe7o
 2PpnpBscc8HUVnexhL9Flky7yLJDeaTUbd0i04ialDt1cZYO4DfyjWO0UnSG5q6tLzs6UjMrboX
 cwTisiBCkRRYTmEBS6FxsIUXiHNyAmLihO0CxxDz8l+VSMKVX1H13EEjSMOgGkvseFsuId4VbXV
 6qqdnWpYyCGefNt6XTX22m2vOHgKSjqH1NFR0JoeOWQJJ8ZBd8qNQENQsxHV9RrFEO4pLmuYfdn
 pSn6o9pW0LJCgu3GanCFlw==
X-Google-Smtp-Source: AGHT+IGyz8/6HdawodkAOlH5PK8Zn2lvjzDTYof2mfxaGdU5rwm+uLFeWzG0EqbBJJ3xZ/3JXd2Djg==
X-Received: by 2002:a5d:5412:0:b0:38a:9f7d:9339 with SMTP id
 ffacd0b85a97d-38c51a693c0mr16853944f8f.28.1738673419704; 
 Tue, 04 Feb 2025 04:50:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm15757919f8f.47.2025.02.04.04.50.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 04:50:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 8/9] hw/arm: enable secure EL2 timers for virt machine
Date: Tue,  4 Feb 2025 12:50:08 +0000
Message-Id: <20250204125009.2281315-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c5..c00a6e410cd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -873,6 +873,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
             [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
             [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
             [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
+            [GTIMER_S_EL2_PHYS] = ARCH_TIMER_S_EL2_IRQ,
+            [GTIMER_S_EL2_VIRT] = ARCH_TIMER_S_EL2_VIRT_IRQ,
         };
 
         for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-- 
2.34.1


