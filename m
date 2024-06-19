Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183BEC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 12:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJukX-0005YT-Ej; Wed, 19 Jun 2024 08:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJukU-0005Wn-N8
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:49:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJukQ-0008LL-NG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 08:49:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-57d07464aa9so1104802a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718801347; x=1719406147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GcVbfAkS8W8gQIjPCN8HOtm0HdYc+tEWdN0wNBVQ5yM=;
 b=ZxM+0tH0YIP9VzwgH9BUQr8jCA9EsXRa9zROCuOVUzR+N+6tZwCLP1Hrx+GMUs2zuT
 F6VM51xUuABYxUeEa1+MNHqa4PKtbj1XTm3itOvrzsTzHCTe8seIXkKCkXzvoZbJ9GUw
 ijQyJyO5bBV9I+ypwKN/sdsMm6U31ExRhEVS4PbN03NmoAzKg0gCqO2MXUUloxNEgv8p
 Gsx0hEStvHiRLe/aJ4AemimInim+RkSfu/sOOYuOa+LMB3TgcCc0i9CgDiY8QYsEdGM6
 oncADI3gQbN5YR5PdpvtjPOqM8xQtxP1rCBxixNNeK51rOv1Anu/v/GT1QNwi+QJlTV0
 rn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718801347; x=1719406147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GcVbfAkS8W8gQIjPCN8HOtm0HdYc+tEWdN0wNBVQ5yM=;
 b=P3f4Xb6fGpex5w+jWq8b6NLrMsx1o/gPivjfrZbwoiy1p1fxi+Q1zPgz6xR12hmaaH
 H3tTMq3A7jNDIOPHUHnbQl3BWHtf57HVz/+AWkIw3SyJy/DM0Wp+lDG0l1RWG9SqOl+1
 oldqCfQxRQ5XEGSlf4j/zlOMusa/ZpjKvgCHObYs6noQ5EnwmSxxPcz8ceLv6fIT5OOW
 izZlMzRnwA7oPwjMikm0Eg9brTzzwI1edhd2riajMxtVVAGKE1vGaQkECzNFZ+NSSxK1
 s//l+Rc14yEzVoxyIz7FxqMGdmI6Z6d4/DXYdpdC2DHBeKpldpHkxjIE2c1HZTpKsBUb
 BaHA==
X-Gm-Message-State: AOJu0Ywt5+IL58fEV7v/I0+jCI2Zj/ujkrQbxG+OnJ/mbIQ+hoyR4j0q
 xPqQTXQmTfp7Zza13YlqI6CuozhYAR/pi7WexQx4Nq6I+1DZvqJ9RS0owztgUz1CH2B3B2AJ4MJ
 a
X-Google-Smtp-Source: AGHT+IH/wycrgETGIrZ14OJYoM1kQk5FdyE1fwxV6xQ+e2PmHpwowo7avFvTmhqMcanHj8FOHHjRSw==
X-Received: by 2002:a50:9982:0:b0:57a:2ccb:b3e5 with SMTP id
 4fb4d7f45d1cf-57d07ec1e50mr1289195a12.42.1718801346616; 
 Wed, 19 Jun 2024 05:49:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.133.105])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb741e758sm8309727a12.68.2024.06.19.05.49.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 19 Jun 2024 05:49:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] target/arm: Always build Aarch64 gdbstub helpers
Date: Wed, 19 Jun 2024 14:49:01 +0200
Message-ID: <20240619124903.56898-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Merge gdbstub64.c in gdbstub.c and remove uses of
target specific TARGET_AARCH64 definition.
Small step toward single ARM/Aarch64 binary.

Philippe Mathieu-Daudé (2):
  target/arm: Merge gdbstub64.c within gdbstub.c
  target/arm: Always build Aarch64 gdbstub helpers

 target/arm/cpu.h       |   8 +-
 target/arm/internals.h |   2 -
 target/arm/gdbstub.c   | 363 +++++++++++++++++++++++++++++++++++++-
 target/arm/gdbstub64.c | 383 -----------------------------------------
 target/arm/meson.build |   1 -
 5 files changed, 364 insertions(+), 393 deletions(-)
 delete mode 100644 target/arm/gdbstub64.c

-- 
2.41.0


