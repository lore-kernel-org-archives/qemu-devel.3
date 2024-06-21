Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817E5C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZHX-00052v-OO; Fri, 21 Jun 2024 04:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHU-00050o-Ho
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZHS-0008Dj-VG
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:06:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4218180a122so12893355e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957157; x=1719561957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KN16E9BUKPMQG4T8oHAz1JXgBHAHT3sIYZJzcPVZl5U=;
 b=qR1MWZAUk8LeMowk1kn/qfpueKB5+FuFDgRxkTamdphhLmbh4MzMTSzsXAnaZdcvdV
 uUD4k401+VXGRyTUuDlvYX3lx24pTm9mCKWGgXfxHEjZp+j6xsRyOvxoclLWq7xrnjyJ
 zTQrf2CBP81Y8YUzU9A3aPF6oGUb+neAxQ/Szas0s/Gx9inR9W6Dh3Jse+6wjDewViCo
 yFfcMm1PkhKaJycNp+fWyrt0EtUhYpd2eolAvEVzNAqKAseeP3Git34nX0gppRWaWbXU
 nB1RoCMdjYc3US3WZjx+EI4wSaaCC5W0pTrF5owdzBFZOOH9brpsCiKgaq6nxLfOaFIa
 qudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957157; x=1719561957;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KN16E9BUKPMQG4T8oHAz1JXgBHAHT3sIYZJzcPVZl5U=;
 b=VOFj88EELZRKAj+/3GlpOrZi4gDUf9VVVie177hQDjhF02kyxljj7kFNIJeoxnnPny
 Gxaqv9Z2BFosqvssP5XJp3BriRi9R6b9WxXQ8lXEilNobYqXBJUEWj7ZGECelXClOw9H
 iohj5S2sFxwBXDX5kvVUplAvabxIU1cZQrHKdLscxJfXRoLsWTjHyphVXv/rYrRIv5S/
 G+3FOdDnHF2SxMduC0xW6f6mv7DD2v7ZAzxNZzzeJoAgEYCURMZHt/yJNANAN60OtSup
 1Lk7c0co0C+LDdLchnT+w6Lq8PZU4KCLpg/Zw/jj9mTHx61mJubUk+yvSvTuvGm2e5f6
 Pusg==
X-Gm-Message-State: AOJu0YxvNnalESZEm1NDlotQMK9koj485BiJU6g5JkXlM4ATKE3nk9KA
 kHrR+pwUfgXz2CJbbZZGl3zoAl2r34J5P7vqtT/EjCbmdexpwrMM31DHQ7xkjq7uVMi4llU3+84
 /
X-Google-Smtp-Source: AGHT+IGJX7ngFSPBnIRyOaVA9IalliHYLR/ISdgUvdn3d7V3POVFPe2d3RrVq4psA/GtsbNbqq8dTA==
X-Received: by 2002:a05:600c:2141:b0:424:74ed:dbfc with SMTP id
 5b1f17b1804b1-4247529fbeamr62112725e9.35.1718957157187; 
 Fri, 21 Jun 2024 01:05:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d21243esm53095695e9.43.2024.06.21.01.05.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:05:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 00/23] hw/sd/sdcard: Accumulation of cleanups and fixes
Date: Fri, 21 Jun 2024 10:05:31 +0200
Message-ID: <20240621080554.18986-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Various SD card cleanups and fixes accumulated over
the years. Various have been useful to help integrating
eMMC support (which will come later).

Based-on: <20240621075607.17902-1-philmd@linaro.org> st24_be_p()

Philippe Mathieu-Daudé (23):
  hw/sd/sdcard: Correct code indentation
  hw/sd/sdcard: Rewrite sd_cmd_ALL_SEND_CID using switch case (CMD2)
  hw/sd/sdcard: Fix typo in SEND_OP_COND command name
  hw/sd/sdcard: Use HWBLOCK_SHIFT definition instead of magic values
  hw/sd/sdcard: Use registerfield CSR::CURRENT_STATE definition
  hw/sd/sdcard: Use Load/Store API to fill some CID/CSD registers
  hw/sd/sdcard: Remove ACMD6 handler for SPI mode
  hw/sd/sdcard: Remove explicit entries for illegal commands
  hw/sd/sdcard: Generate random RCA value
  hw/sd/sdcard: Track last command used to help logging
  hw/sd/sdcard: Trace update of block count (CMD23)
  hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
  hw/sd/sdcard: Have cmd_valid_while_locked() return a boolean value
  hw/sd/sdcard: Factor sd_req_get_rca() method out
  hw/sd/sdcard: Only call sd_req_get_rca() where RCA is used
  hw/sd/sdcard: Factor sd_req_get_address() method out
  hw/sd/sdcard: Only call sd_req_get_address() where address is used
  hw/sd/sdcard: Add sd_invalid_mode_for_cmd to report invalid mode
    switch
  hw/sd/sdcard: Inline BLK_READ_BLOCK / BLK_WRITE_BLOCK macros
  hw/sd/sdcard: Add comments around registers and commands
  hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
  hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
  hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)

 hw/sd/sd.c             | 278 +++++++++++++++++++++++------------------
 hw/sd/sdmmc-internal.c |   2 +-
 hw/sd/trace-events     |   7 +-
 3 files changed, 159 insertions(+), 128 deletions(-)

-- 
2.41.0


