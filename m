Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB3DC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2MO-0004oF-43; Wed, 17 Jul 2024 06:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2MN-0004lp-G2
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:58:11 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2MI-0005h2-MY
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:58:11 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367a3d1a378so5780501f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213884; x=1721818684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQhy8hrl81u7GNgqWNgI0Q8CnNR/8+x5QLQF6iXo760=;
 b=EAxCSOQs309zoqCvVDuCu9kcojJ7PnBRxPOQudSgZp2NM1XmfpXsliIaHVZuG83eML
 JgSg914huZIFitrBQF2gxV7lqERr+DQhGndRhi4mt+sExdZhKLbd5KhRLj5pnPbueTgF
 KtkIfawDA9m39BA6g0blAQhV3PZGl68LU3oLXuVlPnS2fMYM1h2r7b35uqUo2YkCMeJN
 UDyR3Eb/aMQvO8W23IrZRu3zFAAzmNsezzTqtM4hFqxVt7JcJ1x9t4uJ8m5qKtqPCxCG
 di/ncXobQSO964Bl1knDDmr/tWOxRnu7tDv6CIdSBdG9zR0XMazue7V86sj1KpMLur2Z
 92ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213884; x=1721818684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vQhy8hrl81u7GNgqWNgI0Q8CnNR/8+x5QLQF6iXo760=;
 b=EdpgyyXfJ/LgA1BXiOTvxn7mU2aJOkXf9YYIXtyfl3thlYea+0yK0dbiNChP0IAPQB
 tYUK2zkiIVxz6d+bVz/uL1RV9dt9CRSS5ll5W9NDEnhY9tH7qRaW1TmxxqtqeI5qW8Jr
 msz9UgoboR5Zuisob0VCjyV6AboJ1cGnhpYkItBpF9XgjAkhmQvyH79rVFk1RpkAXBDo
 cCOfZXPGSUEQdaKwHviGz613B7otQ0jNvgTtAjM1a0RRpo4lHEcUiPdr1jPsKOsjr9X/
 doAvHO9/HCr3pZJZkcz8ux1CWGy5F85qdHYpaEGds86yW68Y+mo9NnKEr46fnn3mir/9
 bB/g==
X-Gm-Message-State: AOJu0YySnYTOsuCaiiX4lU5F9dyWHYNi8wU9lI4X8v/NOlugSghGfVzL
 ZFbwbu7JOvur13p+VNOFYxt4nUy1rulFKkTKO6cY8fDEilmtxcob8JDgaXP34R/hCiArM3hTWA9
 x6x6rnA==
X-Google-Smtp-Source: AGHT+IHj1D6egyRizVLhAmUWoLS0647TnuQwqHYn5D1nM1mUW6PDpKnneJ0AC07v/mqX/DqaHrpo1w==
X-Received: by 2002:a05:6000:244:b0:367:8607:daa9 with SMTP id
 ffacd0b85a97d-368315fe1d3mr1166903f8f.15.1721213883801; 
 Wed, 17 Jul 2024 03:58:03 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabefa6sm11331239f8f.44.2024.07.17.03.58.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 03:58:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 7/8] target/xtensa: Restrict semihosting to TCG
Date: Wed, 17 Jul 2024 12:57:22 +0200
Message-ID: <20240717105723.58965-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org>
References: <20240717105723.58965-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the xtensa target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
index 5e46049262..e8c2598c4d 100644
--- a/target/xtensa/Kconfig
+++ b/target/xtensa/Kconfig
@@ -1,3 +1,3 @@
 config XTENSA
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.41.0


