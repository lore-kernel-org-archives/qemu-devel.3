Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C60C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 13:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0HI-000371-Co; Wed, 03 Jul 2024 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HH-00036d-0o
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:07 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sP0HB-0005EO-LK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 09:44:06 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ec4eefbaf1so57962851fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720014239; x=1720619039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IxQKZzTHXTZiUGq383gjkPesbOYpGjJzT6tZo0fTFi8=;
 b=eCxIEPTXzpa03PSvwq+tMnj5ONyb5c2zhAsCsix+ixzkQRgtpqc0JBxSFKNwl2VKMY
 drxCD+k/+qde0/GcxUztF3W7ApDUqE5f0kxQe34Smn857G6yXR9qGFiHQ/b4PVN6HKoH
 /kSmkthhQGeH6UTvOqt0I8FisHQkBAEf9HPIimqR9CCLU28CasWsYUk2XOQFzXUOXEMx
 3DP4JzxUCzlVQzbyedCL/x5xawe5z82wjuiJnz6snSJPjWG4NDukB7Dr8YGyLIz5duyW
 FZ1+DXzo69uF9dUcoF7/HN5t9I++Et3o1CB34SzXzfh3Yhy6jxSywZU4AQ9DbJWU9IZg
 BJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720014239; x=1720619039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IxQKZzTHXTZiUGq383gjkPesbOYpGjJzT6tZo0fTFi8=;
 b=pwULgnpnuIZdHA2fjf6/bQfMU75SZmYZcAc5wpsgCbMvbFg6SJRnpRUWuVBRjuqoC9
 8Z6mZr9AzQAcme0oQmBjGiAFGO4zMSM+wyKK5lBkFYYNaXeY609pK0j4AvpSLkB+LQhx
 AgLLreh0PtJjnc3hk+ReTE/gPwhOvC7ORXBt3nlTl2hNmYOK+mICoV/YZ/FgyA0mpTQT
 GieWGgs3ilNznrvCQrgGEJYxojbYw8+n4yHehviLe3Bb8E+EfwRBFL8SFwIpPQJmSKSP
 fkzZsfdy/+GtVbYT5MgKEvWOA1HIb2xw0zEBEhe+vnH0XkoFG0nT3IwpNuGPdUh9uvb3
 9VGQ==
X-Gm-Message-State: AOJu0YxPO0Z849ex5FLA0q8ZT2v8eK1gOaPJb4sNb2ans5ihNYv2xP/Q
 uyL0ipS3odcvltlLqPWwur73edlTsi/WkMV3Bd201UsR+DcxSSZxkUKS9pPg69Kx2Z7VzONEMwC
 6
X-Google-Smtp-Source: AGHT+IEUZ1YcazSy/HC3EYsArDLgIxct1QJ9qU4Xqfh0F6SVHMTvU9BP4nuVslzszzndwNpR6Tyj1g==
X-Received: by 2002:a05:651c:49b:b0:2eb:d9a3:2071 with SMTP id
 38308e7fff4ca-2ee5e6c9cd8mr64379871fa.50.1720014239542; 
 Wed, 03 Jul 2024 06:43:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0642acsm250495845e9.25.2024.07.03.06.43.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 06:43:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v46 0/5] hw/sd/sdcard: Cleanups before adding eMMC support
Date: Wed,  3 Jul 2024 15:43:51 +0200
Message-ID: <20240703134356.85972-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

(patches from v42 already reviewed not reposted)

Since v45:
- RAZ/WI on GEN_CMD (Luc & Manos)
- Rename sd_cmd_SEND_OP_COND
- Introduce TYPE_SDMMC_COMMON

Philippe Mathieu-Daudé (5):
  hw/sd/sdcard: Use spec v3.01 by default
  hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
  hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
  hw/sd/sdcard: Introduce set_csd/set_cid handlers
  hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD

 hw/sd/sdmmc-internal.h |   3 ++
 include/hw/sd/sd.h     |   2 +
 hw/core/machine.c      |   1 +
 hw/sd/core.c           |  29 ++++++-----
 hw/sd/sd.c             | 113 ++++++++++++++++++++++-------------------
 5 files changed, 81 insertions(+), 67 deletions(-)

-- 
2.41.0


