Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DB7E6F06E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 16:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6uFN-0004I3-Cj; Fri, 01 Nov 2024 12:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uFH-0004Ga-R9
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:11:32 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6uFF-0008GU-1w
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 12:11:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d47eff9acso1370211f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730477487; x=1731082287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HKFOgXGoRqQTK5wGQoj2VTmlGEEPDpzJ2I7xF+qsPHs=;
 b=hTYLEKHKSTNwsej5ecwrh1vqhBEh1LqJiD8a13KPOvPN7gFJ6zYrf7tSQPcAQLjQbB
 F4QWMAaP+3lOMZ76LDLCLIidTHbejpZaHfUI50HzBbf6/VSGts54l1FUrcQeumTs6tqw
 nBhkQRPtwcbnaoitLBlkGlg9UEfpwIayFcGMeLhkF/dw8OsT6EGJ4dbHc8Y/6VArQELB
 ZZ5Pe52fXU3zAoGpgOXYL9C9IMUHYx0dRYN3u4n4kKF6jDNOKNVhR3401+kKfkDx97xV
 Sf2Pz9tBdzPpFTf9Q7F73oywyidfgyfZmXeAcz9CzT7lMpSL04Bps0fK3jFMETIcQaGY
 Qpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730477487; x=1731082287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKFOgXGoRqQTK5wGQoj2VTmlGEEPDpzJ2I7xF+qsPHs=;
 b=gWETLYlXfyv7N3ne3v8Erq23E2A/S7YqpU7ZthmQl4rNrDNZ8biZ4QE8hirVwIe/De
 D8jGocD93wk52DSD3dlMpwBuya3kjDNYc2cNqK4jSxl4jBh94pqAeMDogHjkcRc69J4u
 fXFfVQ37zmlWAM28jkVpg7uFmKS2dInrEG88T+9l8w12+zbx6HeLCgrwLvvp1LmpPsIs
 ys/J7Z/vxGMuRaJSpLK8OBBwgoK3WIH7Pqomeo0dHZd/hu1riaTFU2Hu0wT5A8IkfexI
 SEQ3cUhPoPnFAMW/9zPyYgQdwKarh7FyBHjsGf/5qbgQy/3mtifSh7bYhdm0sDsKgeez
 CaGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmA5whmEJvHsv3S2ESLWO8oZHelu/JB9WYdJPM1QETPHeMu2hNyHjvPN7ZwSojTFKMyzTel5oaS+nn@nongnu.org
X-Gm-Message-State: AOJu0YzH3EfLwijvu8QF62v/fseTcoWbGItPKbJa3agWfIwO0Fka4rn+
 Un+B5dj9uegX+4Ce0Jh5QlXrzK/kVKvek9qivOY46gZYeh6cgpg/VzS7rr3hwh0=
X-Google-Smtp-Source: AGHT+IGqeT9TFKIVKYHKtwdD7aPa0SjqWTUhe2MGlo07bOHPWu6w47dL1Bb0cRyF64+ZQE3cXZRBTw==
X-Received: by 2002:a05:6000:1569:b0:37d:3f5c:5a9f with SMTP id
 ffacd0b85a97d-381c7ab2fabmr3730890f8f.36.1730477486658; 
 Fri, 01 Nov 2024 09:11:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7f80sm5658313f8f.20.2024.11.01.09.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:11:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 0/2] hw/arm/aspeed_ast27x0: minor IRQ number cleanup
Date: Fri,  1 Nov 2024 16:11:23 +0000
Message-Id: <20241101161125.1901394-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

In the course of a conversation on IRC with somebody who was using
the ast27x0 code as a model for a new board, I noticed that the
code currently defines a local ARCH_GIC_MAINT_IRQ with a different
value from the constant of the same name that we define in the
include/hw/arm/bsa.h header. This patchset cleans that up and
also another minor awkwardness that I spotted in the process.

thanks
-- PMM

Peter Maydell (2):
  hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
  hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ calculation

 hw/arm/aspeed_ast27x0.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.34.1


