Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44742C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsE0-00012P-Kx; Thu, 27 Jun 2024 12:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsDz-000125-Dn
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:43:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMsDx-000864-K7
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:43:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so1253132f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719506632; x=1720111432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hybq2dnk2J6e6a36j79MJcKwB5kaIfrliZBRIYBPPug=;
 b=CBEgNhYbc0rpYYkYeb6g6c0LQM4GRijQXRib7Rzuda4Ebc7HCkrsCMIaWkqZura2x1
 JmbfMpXwlN9eprpjXla2jqn7YftrP4UxNgaHrtOEdKZmw4+MHjySfo/ShxhHs4KiwqaW
 NGpOPlNIsHIw//m3MdOBgrh54ipufT6It9rfGTjFfDOIt7/w0aqmPSm753OJw4QqX5Kw
 UbsTYhqYxqjs129qgBOImlL9cxnh0yZlKOsDCYCBOtz4rvoyLcimSlCcB/vd7eLMBWO+
 lM2yZDtrLjDrepqT32XKls401C4JDF8T6Qkzr1eMu27vM6ZkCfEGBpWkUyd9gsQaetZn
 7Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506632; x=1720111432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hybq2dnk2J6e6a36j79MJcKwB5kaIfrliZBRIYBPPug=;
 b=WlP0feCurz13q4e8Z2ZGfr+IHsTDsx96vakN/JiZSOCGPe7M4QLYF7mCDB84+hbzpg
 6FX/QP/+6T0zTTDwu/++kOAYFyHYuIGSrbh4Utt2lpvOpRP54wCnyo6rBrqnjwDMjlVf
 3YNbwH35MaJtxAlPG20Vx5ya4Hzxosjv6vwd7zZqWeEAYsuYaQH/ViLCl/NGUqMCOwpv
 370gIQe7rszqiDOGisu888MaN+ciL2uQi+pK1hqfvCsLzM1o2eFAyVV1BB1i5sQErBWD
 esDO1+QMmNPp1Ax3oAJTluaxap+ZQmyRxgyNXWXhB+5klMMXgyGQdjJDh7p8PG+JJeFL
 2GnA==
X-Gm-Message-State: AOJu0Yy8MENR/hTLck9ezo9qtyUJYoKOb65cykDAiEk59Ac8b3aasgzk
 3BxII9cuXe/Sx9M+53Wa9y8WHZKOsBpylnDqoGUra7thULnyH9QEwKQJ4HWotANCHGwsmsA1P97
 E0hs=
X-Google-Smtp-Source: AGHT+IHUSHoZ5qiClH06UgjvbhBf1wdq3SeTCh/hd4XX1ep0psAvn++D3oH9u5S/GN1cY35Wls0B1Q==
X-Received: by 2002:a5d:668d:0:b0:363:d234:c790 with SMTP id
 ffacd0b85a97d-3674192f5fcmr2432748f8f.29.1719506631885; 
 Thu, 27 Jun 2024 09:43:51 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8424554sm74316635e9.37.2024.06.27.09.43.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:43:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Joel Stanley <joel@jms.id.au>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 00/21] hw/sd/sdcard: Convert CMD to sd_cmd_handler format
Date: Thu, 27 Jun 2024 18:43:23 +0200
Message-ID: <20240627164345.82192-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

For each switch case in the big sd_normal_command() function,
extract the corresponding sd_cmd_handler.

Based-on: <20240627163843.81592-1-philmd@linaro.org>

Full series for testing:
https://gitlab.com/philmd/qemu/-/tags/emmc-v4

Philippe Mathieu-Daudé (21):
  hw/sd/sdcard: Add sd_cmd_SWITCH_FUNCTION handler (CMD6)
  hw/sd/sdcard: Add sd_cmd_DE/SELECT_CARD handler (CMD7)
  hw/sd/sdcard: Add sd_cmd_SEND_IF_COND handler (CMD8)
  hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
  hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
  hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler (CMD12)
  hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)
  hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler (CMD15)
  hw/sd/sdcard: Add sd_cmd_SET_BLOCKLEN handler (CMD16)
  hw/sd/sdcard: Add sd_cmd_READ_SINGLE_BLOCK handler (CMD17)
  hw/sd/sdcard: Add sd_cmd_WRITE_SINGLE_BLOCK handler (CMD24)
  hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
  hw/sd/sdcard: Add sd_cmd_SET/CLR_WRITE_PROT handler (CMD28 & CMD29)
  hw/sd/sdcard: Add sd_cmd_SEND_WRITE_PROT handler (CMD30)
  hw/sd/sdcard: Add sd_cmd_ERASE_WR_BLK_START/END handlers (CMD32 &
    CMD33)
  hw/sd/sdcard: Add sd_cmd_ERASE handler (CMD38)
  hw/sd/sdcard: Add sd_cmd_LOCK_UNLOCK handler (CMD42)
  hw/sd/sdcard: Add sd_cmd_APP_CMD handler (CMD55)
  hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
  hw/sd/sdcard: Add spi_cmd_READ_OCR handler (CMD58)
  hw/sd/sdcard: Add spi_cmd_CRC_ON_OFF handler (CMD59)

 hw/sd/sd.c | 843 +++++++++++++++++++++++++++++------------------------
 1 file changed, 459 insertions(+), 384 deletions(-)

-- 
2.41.0


