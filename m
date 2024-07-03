Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AA2C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOviz-0001aa-BN; Wed, 03 Jul 2024 04:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOviv-0001a5-Jh
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:21 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvio-0004T8-SO
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:20 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52e992a24a1so319610e87.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996733; x=1720601533; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zj4HYUzXDv0A1hTe/qO2rFG9BXTThHtoCKV011XHWzs=;
 b=VNJoAEGxOKixBf544yMb/mQ6By1JA8evG7GaKOKlL4Kk4+aufy9bIPzMB/8AOv8ka2
 5E519gaiHby6SXZv27ILgLQUw2RH6887Nk0kc3EvjMa8sFkfjobmVc0mOshijcvDN/BZ
 VG4simuo7uptheLcpyFjDxEe+4IRDpM03pdiRMJHkUOggAirNqJGN/p87Nuu/xjkF725
 oDOi9Nla53QKsn70wwxLQ6Gb5/4QzEaP1WYJkVO80oBvNN3DBGqixoJrGU2SnEfBN+kS
 rjYODq+Gog0hoUjRYJuF6n0UB6Pzj1iZJRWHMPopLqF7tWzwbhXCNHdLVj2mqPJF7AHD
 C8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996733; x=1720601533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zj4HYUzXDv0A1hTe/qO2rFG9BXTThHtoCKV011XHWzs=;
 b=eUPuwT2YMyxR49OB6WeR/7hFf3wEbhgNuJxrX/8UkURu6zqPhWNzcRC1RVs9IzPAHv
 4lSs+qhkHTnnhAwIBe3HvduMSyAzNsTV6Xc0L7c1KZ+Miezt9U5+jVRrb9GhI4Nbouhx
 58VlYlkKikGxpQHuZbKjjSPMGnVuiCVb3xDw3sedT3mrQ31KBdKelll0Y+/f5dX+1CJF
 +ET1Q2FBbn/VJo3P7C5qaPXTIGQkS3MK3m4fWoBXHBE3HtULtiOaO3MZimpIv85ALENs
 8hMyqO0iHk8q+E9QYxlg4lJeZTZfoRV3c7dnpaPELC+fLDqWjlqIlsZDRSndfRVHXUfY
 xjMQ==
X-Gm-Message-State: AOJu0Yy9RQVtw4h0xJT0yhsISPQNa1bKh+qhlv9PWpy8dfy1PT+fD1CS
 Tsg+marXN2dTDeTDTKYF20Q0Jvq0tI03s3tC06kaVV2p/wUwMjRM5gWNF5jqqtcVu58blprbUWA
 p
X-Google-Smtp-Source: AGHT+IHvevyisN2WzHVC4bzwQ4lnygyawv4vQxHkl/G4xjgjqw8W+9NWe+pySx5YZNp+ioZjKmJgJw==
X-Received: by 2002:a05:6512:3a8e:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-52e8264dfebmr8097238e87.6.1719996732873; 
 Wed, 03 Jul 2024 01:52:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257c4e1112sm158320545e9.3.2024.07.03.01.52.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:52:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v44 3/3] hw/sd/sdcard: Remove leftover comment about removed
 'spi' Property
Date: Wed,  3 Jul 2024 10:51:48 +0200
Message-ID: <20240703085148.66188-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703085148.66188-1-philmd@linaro.org>
References: <20240703085148.66188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Commit c3287c0f70 ("hw/sd: Introduce a "sd-card" SPI variant
model") removed the 'spi' property. Remove the comment left
over.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 000b923c73..904da440ba 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2485,10 +2485,6 @@ static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv3_01_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
-    /* We do not model the chip select pin, so allow the board to select
-     * whether card should be in SSI or MMC/SD mode.  It is also up to the
-     * board to ensure that ssi transfers only occur when the chip select
-     * is asserted.  */
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0


