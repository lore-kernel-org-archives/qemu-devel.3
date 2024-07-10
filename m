Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F00EC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRY5K-0004jF-SW; Wed, 10 Jul 2024 10:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5I-0004fJ-Sl
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sRY5H-0003nJ-6E
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:14:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42797bcfc77so778115e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720620853; x=1721225653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9xETedJR2BfeiJWzg9JjuUfyJ/0K4iLRZm8ojwa4zvI=;
 b=wbXvsbCvBJW3SEiCwa9TX51YPwxM2rnRc3nrwdKvgKsTwxtOfGZSwvK9teyjdIOr6U
 4OgKo2aadUoUXbRhbNG92+AeJ0He0QA/QSbJyK46KmQkGCckA8QXMyg6WAUywS1GMv5V
 +9ITGg8o6GeS8K9KekYsrGK9uD8bTFvLpxNJFHBOlKM0UHJWeRKkvu8a05MjVx19Fa+U
 YNf+hLlSeniqHtvq2J0uoU1i7YHJaBRqofgGVGM75RMbr9KNHnZF6amSiD2Vm29iLbKu
 w64580Asit64h8VJEGax+ZY+pmrKLYVzrC0p4FKSEl/6ZMerr0xKBnRx/n2OWviUgrFW
 nZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720620853; x=1721225653;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9xETedJR2BfeiJWzg9JjuUfyJ/0K4iLRZm8ojwa4zvI=;
 b=iIwvkuvfUcI/jhbntQ8Zj4CmEMY0PWOr5ArRMPI7+b3Z+/F1c6MpjMxGwkfxX0nVFq
 5b0veXZpWLHuikNa8UhktDFL9CDLU4Vr6DTqhth+aTIRGGtEtFRxtFclCuHjthm7b9wK
 6ub4F/7UDzNkk8BU3tZ/9CyLer2smlSl1Y6+KslPV9C22d3Bh9Og2ePjqIBW4YXqyjMA
 yKD5AG+bm5RX86CqN8VSmn6cYa8etGnm9l8mhk/z8rRCveTHTXiYcPzSJo7WM1HuB0f7
 FtP9M2C0rYzF0iS/w+iWEE01QnxJvGvDlRr+G+H7fNrerWZDC1fozi3A6t7B8zQLWZY5
 HUTA==
X-Gm-Message-State: AOJu0YykVsHfSqXuztAS/Z5VlggRqGmcl8uVXmdjlKwaAQvKLxcpdzns
 8dlA0AGWVAk+XuYvP6UdiHqgxUCcGgzjVt9trFI2QyNXx8IWJH7vwA153Fn4KKkdt3/Z3vS/NlM
 0
X-Google-Smtp-Source: AGHT+IGCEtEubHHhclxFcMUtI1+6iwUnhSuaTrAm+0dFoTJ2CoP2uw46um2BN1li8ivT9Xa9LDgPLA==
X-Received: by 2002:a7b:c412:0:b0:426:618f:1a31 with SMTP id
 5b1f17b1804b1-426708fa731mr40091535e9.34.1720620852768; 
 Wed, 10 Jul 2024 07:14:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.167.117])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426e7638d1dsm64198045e9.25.2024.07.10.07.14.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jul 2024 07:14:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Luc Michel <luc.michel@amd.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v48 00/12] hw/sd/sdcard: Add eMMC support
Date: Wed, 10 Jul 2024 16:13:56 +0200
Message-ID: <20240710141408.69275-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Tag to test Aspeed tree:
  https://gitlab.com/philmd/qemu/-/tags/aspeed_emmc-v8

Since v43:
- Reordered and squashed commits (Cédric)

Since v42:
- Stick to spec v4.3 (re-simplified EXT_CSD register & migrate)
- Fill CID register
- Few changes to CSD register
- Implement 'boot-mode' reset timing
- Add 'boot-size' property

Cédric Le Goater (2):
  hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR handler (CMD3)
  hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)

Joel Stanley (1):
  hw/sd/sdcard: Support boot area in emmc image

Luc Michel (1):
  hw/sd/sdcard: Implement eMMC sleep state (CMD5)

Philippe Mathieu-Daudé (6):
  hw/sd/sdcard: Basis for eMMC support
  hw/sd/sdcard: Register generic command handlers
  hw/sd/sdcard: Register unimplemented command handlers
  hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
  hw/sd/sdcard: Add eMMC 'boot-size' property
  hw/sd/sdcard: Implement eMMC 'boot-mode'

Sai Pavan Boddu (1):
  hw/sd/sdcard: Add mmc SWITCH function support (CMD6)

Vincent Palatin (1):
  hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)

 include/hw/sd/sd.h |   3 +
 hw/sd/sd.c         | 418 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events |   3 +
 3 files changed, 418 insertions(+), 6 deletions(-)

-- 
2.41.0


