Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B08C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSJ7M-0004Pm-Q0; Fri, 12 Jul 2024 12:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7L-0004OO-5h
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:31 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sSJ7F-0001vr-6I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 12:27:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso16026345e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 09:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720801643; x=1721406443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gBU2fNmBz7RqNPgCycc5xf7wFhsPLyphN1A0VUFUC8o=;
 b=Ce7LowijCgu4RtSANQkyUQndVioJPMYgx7mmzfkMdXcOyo9B4epqDCPsvJTwqqwFCl
 ZHnh7JUJZ1RSU1IdQkKl5nhJUcSBJnE60hYQ7T/G7t/Bfb8309wzVcpVXE+s6SCTkXz2
 7nGhL55kPbJV/oAAYW9vAzfQ0aI5m6zV5l3fgYQwaB46pjArCf69xYTGgbsTf0pmcuUl
 sVzgV6RONjJKpqOUw363ygOcC2DSS7ooqMu5SIyf+/xO37Zmvt5JgtkMzQR7JyyE6sbw
 uqML9g7lJq/2WwINfmSSooAH94bbk7tHt/mYLntenUVeEpAaYoiUHlyD4xYZK00x7ml0
 ggBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720801643; x=1721406443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gBU2fNmBz7RqNPgCycc5xf7wFhsPLyphN1A0VUFUC8o=;
 b=NSnnPAsbbIuwQuFZUFX8TmEOEx+1xkMnADIA4Zkt/puEt3Kg1KO41Y99Yy5X9D/0k8
 7AyQoIuVnMABpmc7iswjWYc8KAJlGB+cH3zixrILfuufWfWCI8PZi4Rqc385U6AIhxXq
 kw6AyaIGqZXWrBgMUmOtJAPVz6NcIAj98Yk6Ba8Ul6JeMzuzlfOx/lNXDMRoLiTtrGwg
 h2ZDgjEAxvn0EWetilCy3KAeY5RxRdp9enUaYt5ams/jTnUqIXlQjyCytuBMriE8uZtb
 C9d3Hazf8YeFvpLcBFCRjM7ZUS4TxknI8pKSAdVHzI6Hspnu9xmatfsT+Swb0ELvfLr6
 Mv6Q==
X-Gm-Message-State: AOJu0Yz2FDqd9QuTsS3QynxTynuOnR0KhueVRTlXNpIoRW7nd0hfJKG4
 1lemyOWx/9SPqY2XWGmSiexxwNCvwLP67SpZ4pA/RM2p18ty9wazIqUtO49SDBf7iIZFW2q7k+J
 S
X-Google-Smtp-Source: AGHT+IGPeyCSooX4+obt52pn7PCEKkd+P9CEpwjj6IDZee8NRGPlhY5AxQTnBJyNiPQrD/+cioF62w==
X-Received: by 2002:a05:600c:188d:b0:426:5f7d:addc with SMTP id
 5b1f17b1804b1-426708f18e2mr74423245e9.37.1720801643049; 
 Fri, 12 Jul 2024 09:27:23 -0700 (PDT)
Received: from localhost.localdomain
 (nsg93-h02-176-184-54-152.dsl.sta.abo.bbox.fr. [176.184.54.152])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2c1e07sm27763615e9.45.2024.07.12.09.27.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 12 Jul 2024 09:27:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v49 00/11] hw/sd/sdcard: Add eMMC support
Date: Fri, 12 Jul 2024 18:27:08 +0200
Message-ID: <20240712162719.88165-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
  https://gitlab.com/philmd/qemu/-/tags/aspeed_emmc-v9

Since v48:
- Dropped "Implement 'boot-mode' reset timing" patch
- Re-introduce Joel "Support boot area in emmc image" patch
- Comment magic CSD values

Cédric Le Goater (2):
  hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR handler (CMD3)
  hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)

Joel Stanley (1):
  hw/sd/sdcard: Support boot area in emmc image

Luc Michel (1):
  hw/sd/sdcard: Implement eMMC sleep state (CMD5)

Philippe Mathieu-Daudé (5):
  hw/sd/sdcard: Basis for eMMC support
  hw/sd/sdcard: Register generic command handlers
  hw/sd/sdcard: Register unimplemented command handlers
  hw/sd/sdcard: Add emmc_cmd_PROGRAM_CID handler (CMD26)
  hw/sd/sdcard: Add eMMC 'boot-partition-size' property

Sai Pavan Boddu (1):
  hw/sd/sdcard: Add mmc SWITCH function support (CMD6)

Vincent Palatin (1):
  hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)

 include/hw/sd/sd.h |   3 +
 hw/sd/sd.c         | 385 ++++++++++++++++++++++++++++++++++++++++++++-
 hw/sd/trace-events |   2 +
 3 files changed, 384 insertions(+), 6 deletions(-)

-- 
2.41.0


