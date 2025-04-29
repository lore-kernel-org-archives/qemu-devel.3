Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD796C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n3c-0006wd-0Q; Tue, 29 Apr 2025 11:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3V-0006mq-6U
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3R-0007eZ-Pg
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso4612930f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745941167; x=1746545967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvMuIcy7uWLKoIFwC4B1ZONwZFZEu+NYFeyFXhIve0M=;
 b=SohTDoJOl6rKTE9RuAl/DomJU2IME7t9RsMEyZ4XXJqO0cxrgeQpzafoCeF1F9qBAi
 ODLTh3gA+eo0WBsQDbmYEzBcEdKP9+qtZRhdJDVfxBz7ipq2xbW0jxCjAeovpDq9nyu/
 O5QoSiGgZFld1M9ejRB6hxwuOwNuDLlwYUT1hlk4BonromnZO2gM8Nh5dh1XSQA2zJuw
 oVaTdLBIXMqhnIjjSS6mnN+xp+e5I+lsIIwCH33br2h8YxbEl/C8UzTEuB1ON9tfYUjw
 xoAE8jk27BKRgpZnD/05iQsiDf+u00JcxlinF3Cr15p03+qzxAh1mpFOj1Ii+4tpbPcP
 Pi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941167; x=1746545967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BvMuIcy7uWLKoIFwC4B1ZONwZFZEu+NYFeyFXhIve0M=;
 b=ElEdFonxdCy5WrmATG9wkol/nD7GvO72rftjjz7TFEWkfBe468nUrqMoipy506Ogpz
 bJ4N2509HOnaHqiCAPB72zyvKQ0FHlJcaDCY1fW5jR27rCLzBWcPxxTWesenRqP26E4V
 qcP3uUvtvU3fnqso5Um0jjE6INfWpLPaSkV0IPuXVOWLzPGh17CF9zazT81rthj6y4ca
 vA6TJWiMALX7DMvfqBeeOCv89UroBSMtJYjSTXIggHWeLyUkUmlI7XjMoUddeUsGMPoT
 1LLd9uVCNbgT5YDkLhEdl9Qy4QxERwh3ct6o6S+vW3qmI81Xz9BRxHVsS1SWeWYcqpVt
 EQ4A==
X-Gm-Message-State: AOJu0YxdVU0L56omiiBzFt4EpJ7wSSdUQmLId41MpMN7FcSU0N2tHW6D
 jYjPArQo7qNdr1qVVZZmytBWcde1mWLAlVmdXtaGuz0HgjiHiMBhnDXe15EyUvFYt6c7oPsf4Up
 y
X-Gm-Gg: ASbGncsp+d9TtbxQnFKduWnx7zTMi41KpqRQpsWsojDAjYc3yHJOhs/WUvLAzQuNOTN
 oqm6FEliw9Je97hh2sposmE8xoIRW4gCWvL0AbT2Y/rzImC/mP9nSj0aNA/2E7r9PhWTv+N0d+Y
 i4k3ZUh9Au4WBVoR2HOurEgOLyNbVPR0UyPj2hHh/8e36U8oDnSdyAlzF0axf1YMfHQGf5H9r6G
 IZKlPgmQmS5KvNClLUapOb02k+1yWCC0CZ4fVy+Pj2IV9z3opqGbBqS1ELt7rwiiJPjXQ5znJ6W
 okJlcCSjqBEdyjGThtNhiaHAzlv461Jkyrt8XGneLSfv6DUXr9n1Su28i/+qHHG+lmoa14Jk44J
 taSrvfysNacAYYbkVaPm/VFboGxxZE1E=
X-Google-Smtp-Source: AGHT+IEry+VIZvO+m36cn5QUXRWa8BiV7RymsqIy7mZy3C27jDCpvTkSCPeekHXaoJq4EEVEgTf1UQ==
X-Received: by 2002:a05:6000:400e:b0:39f:cfc:d520 with SMTP id
 ffacd0b85a97d-3a08a51f5aemr3425102f8f.15.1745941167596; 
 Tue, 29 Apr 2025 08:39:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46517sm14306959f8f.71.2025.04.29.08.39.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 08:39:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/arm/virt: Remove deprecated virt-4.0 machine
Date: Tue, 29 Apr 2025 17:39:07 +0200
Message-ID: <20250429153907.31866-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429153907.31866-1-philmd@linaro.org>
References: <20250429153907.31866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bccbc54073e..f4e5a93f0c5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3563,10 +3563,3 @@ static void virt_machine_4_1_options(MachineClass *mc)
     mc->auto_enable_numa_with_memhp = false;
 }
 DEFINE_VIRT_MACHINE(4, 1)
-
-static void virt_machine_4_0_options(MachineClass *mc)
-{
-    virt_machine_4_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
-}
-DEFINE_VIRT_MACHINE(4, 0)
-- 
2.47.1


