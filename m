Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B43C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeBp-0005IO-Bq; Tue, 02 Jul 2024 10:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeBj-0005DJ-6s
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOeBf-0008EY-Fo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:08:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so29883265e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719929327; x=1720534127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uvjGohX9jpqU4S0vaNGN/OLaq0Blh/PgFGJDO8c8dTs=;
 b=QSz5sBDGjTzLMQhDBf7pxGa0X0wmLFkpobBO0ac9ko0Bml/gWdmobFQa4IhO1G1lvM
 yM6j8Ayy+g4Kiskc3NODIJ9Mj0ieQAlcOk2gUmuKbyYsTt7+0W/USb8i9ZvXABfRRzZ7
 MwdtF1HgszTAUDhYZxgPppqfHCOcMgraaZUKFohvPi9d0yuzuNfxX98I/jy58fdiwa5i
 CVKISAo+ghDRunov+Tez/eOsNi9srsREGhLBZZ6HNMjHoGmARewD96JIcXLdm0rI6DgR
 /ooCybvO9BRJwH1yfMG0UakUj8z6vsHrrow1SiqIuZ7FNi/WtruaK5Vn4Xw86lKa0MkY
 mIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929327; x=1720534127;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uvjGohX9jpqU4S0vaNGN/OLaq0Blh/PgFGJDO8c8dTs=;
 b=poO7PaVfyo+mvxfdEgJiZEBvjFHo+Eu+0lsFRg6nj6FfkMfxaggxWnjriS4uDDwMPF
 EvDvaUTCkhpPPCyHQF8AhRCXKs7XPwH35ktUO2WBTozUqbs1la/g/MaGi0N9sijWlYfe
 raJQbNOaNIQKA5RWpTCI5325ZIuw+RxTJGaTFM1jU7DfSGI22ZsEIOa6UqCabMFUzEeP
 JNJ6FAUaIj76SElOdTsaFFeBssU7RSNnQ+Tm5LLBWCJgaWzHtTa6c3pTdFWTXY7f8tbp
 16BaubNWNZ/p4pyigYTPvhtIEifOkXt5iDf9+a0tk7CYnZ1ZbFWxMGTSigEerrNNzowD
 Pc4g==
X-Gm-Message-State: AOJu0YwnPix1I2LFMDT7+oJ4siyMJmPSosxwKr/bN6ogApT8KwXO2pQq
 H4UU4vigh1uhd5ypJM2A4VlPtZ1vr/SL+SGGo0QviKn/C2AnctpuYS7qsNe7rutrYL8isG8CFHh
 l
X-Google-Smtp-Source: AGHT+IHFrvHXuxh0hP5aZ+0Qp9pNGRCRzh6Bmr2FcRdtst4WCo5UodAc45HP7w1ylNTO+HM8MSbf7w==
X-Received: by 2002:a05:600c:35c3:b0:425:65c5:79b4 with SMTP id
 5b1f17b1804b1-4257a02b6c5mr65427185e9.26.1719929326704; 
 Tue, 02 Jul 2024 07:08:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257fb4fabdsm106739375e9.46.2024.07.02.07.08.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 07:08:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, Thomas Huth <thuth@redhat.com>,
 Shengtan Mao <stmao@google.com>, Chris Rauer <crauer@google.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Laurent Vivier <lvivier@redhat.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Patrick Venture <venture@google.com>
Subject: [PATCH 0/4] qtest/npcm7xx_sdhci: Use card-provided address (RCA)
Date: Tue,  2 Jul 2024 16:08:38 +0200
Message-ID: <20240702140842.54242-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Avoid to use the SDCard hardcoded 0x4567 RCA in npcm7xx
SDHCI qtest, so we can generate one in the card model.

Philippe Mathieu-Daudé (4):
  hw/sd/npcm7xx_sdhci: Use TYPE_SYSBUS_SDHCI definition
  hw/sd/sdhci: Log non-sequencial access as GUEST_ERROR
  tests/qtest/npcm7xx_sdhci: Access the card using its published address
  hw/sd/sdcard: Generate random RCA value

 tests/qtest/libqos/sdhci-cmd.h   |  2 ++
 hw/sd/npcm7xx_sdhci.c            |  3 ++-
 hw/sd/sd.c                       | 11 ++++++++---
 hw/sd/sdhci.c                    |  5 +++--
 tests/qtest/npcm7xx_sdhci-test.c |  8 ++++++--
 hw/sd/trace-events               |  1 +
 6 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.41.0


