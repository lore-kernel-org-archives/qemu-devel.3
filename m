Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3D6C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhM-00013T-Ut; Tue, 02 Jul 2024 05:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhI-00012v-EU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZh3-0006M6-6f
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso19036985e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912054; x=1720516854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kBloExwWJk9U/pRDjib3w5J+DtD6Yp3lyW4YWIFqHiY=;
 b=Nfi/N5D3RoudUXuviIyjefhge8IZwpw9cuQ/U89QvLFBW0YGJCP9x40EnyEPhj59By
 MEYtQiCJQDwerOMeOQaJVEpyKt63VbSCv9jpJ3rIrprLzeMlLNkdxQoAP0QfVNeyJkp3
 0wz9EID93ZM9zzDOwgFHt3qu022YdX3vab639otU9+QY/QrDjrpZ0F3IgoutLpq41VrE
 jYjlk5e/0HYBgsu9L9GRsOGQtXtRclSIaUE2tRwoT2eNMz5aYPWLxXBdwZRmLPVmyIeh
 Womw5Nnx2L3/x5xEiY3Cz2AS/gWjsrrvE0PosMd3qofpzh7feCDMY986ORNCOm9SpmlW
 TZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912054; x=1720516854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kBloExwWJk9U/pRDjib3w5J+DtD6Yp3lyW4YWIFqHiY=;
 b=k2LEKGhScdzLbhDA8AXl7VfuzddIh/2YA95tAByc77gQ+75I3t9ssKZ5pLP5MNj9Wz
 y+ETLsZJ5/24v/kSHl1z1JUTpFgPqahjzzQ6g5xzpw/yb5ODYwiC8BDgl0ydv6NAO7V9
 nV8xXvlrphpNyV/XxjP9mF/sxDLmtf0D0ndHmSPqUGT8oJxWMdLWollBdzdp3WXuIaUB
 Ihw72jMwYqfNkIqaetxDCxbb3PoPEUBuubQ0CCeL2nqXnv22FY0GeEjtVbRKHQmX9zdz
 d/NbAarmq7YMtI/oLWuqJrJDm33JDH3nGv1pO4kRrGIZiufxYFWdy3bo6jW5QpNxhJkJ
 We8Q==
X-Gm-Message-State: AOJu0YxH4kcEZLMrPlForxVsvtKRGSkPckHdVfBxwjS8DNhsoTHpWFsk
 jPBWzLWFHlNW2QnI8vcVAYswNUBVhYKCAqWVLzaOL+IC61FXQHTzbKbmf6xRfId0LEeMwiwDpEV
 n
X-Google-Smtp-Source: AGHT+IEgy3gBW01zBZUowZlgCibtWKoYh+/oBpd67O8TsUL/hzLg2d9Cu+RNCSQxs0bQ3zKuh8wR/Q==
X-Received: by 2002:a05:600c:4da1:b0:425:64c4:e016 with SMTP id
 5b1f17b1804b1-4257a0098c1mr53041665e9.12.1719912054518; 
 Tue, 02 Jul 2024 02:20:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9cbasm12652074f8f.38.2024.07.02.02.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:20:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe =?unknown-8bit?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 00/67] SD/MMC patches for 2024-07-02
Date: Tue,  2 Jul 2024 11:19:43 +0200
Message-ID: <20240702092051.45754-1-philmd@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:

  Merge tag 'pull-target-arm-20240701' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-07-01 10:41:45 -0700)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/sdmmc-20240702

for you to fetch changes up to 8442e1625ba6723bee2c6d0fdb7207a3e27a2b05:

  hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51) (2024-07-02 10:08:32 +0200)

Checkpatch warnings ignored:

    WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
    WARNING: line over 80 characters
    #64: FILE: hw/sd/sd.c:2327:
    +        [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
    #72: FILE: hw/sd/sd.c:2386:
    +        [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
    #75: FILE: hw/sd/sd.c:2395:
    +        [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},

----------------------------------------------------------------
SD/MMC patches queue

- Deprecate SD spec v1.10
- Improve tracing
- Fix endianness on DAT lines
- Introduce helpers for commands transmitting data on the DAT lines
- Convert most commands to new helpers
- Register various optional commands
- Add command {name, type, class} fields to SDProto structure

----------------------------------------------------------------

Cédric Le Goater (1):
  hw/sd/sdcard: Introduce definitions for EXT_CSD register

Philippe Mathieu-Daudé (66):
  hw/sd/sdcard: Deprecate support for spec v1.10
  hw/sd/sdcard: Track last command used to help logging
  hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
  hw/sd/sdcard: Trace requested address computed by sd_req_get_address()
  hw/sd/sdcard: Restrict SWITCH_FUNCTION to sd_transfer_state (CMD6)
  hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
  hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
  hw/sd/sdcard: Use READY_FOR_DATA definition instead of magic value
  hw/sd/sdcard: Assign SDCardStates enum values
  hw/sd/sdcard: Simplify sd_inactive_state handling
  hw/sd/sdcard: Add direct reference to SDProto in SDState
  hw/sd/sdcard: Extract sd_blk_len() helper
  hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte
  hw/sd/sdcard: Convert SWITCH_FUNCTION to generic_read_byte (CMD6)
  hw/sd/sdcard: Convert SEND_CSD/SEND_CID to generic_read_byte (CMD9 &
    10)
  hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK / READ_MULTIPLE_BLOCK cases
  hw/sd/sdcard: Convert READ_SINGLE_BLOCK to generic_read_byte (CMD17)
  hw/sd/sdcard: Convert SEND_TUNING_BLOCK to generic_read_byte (CMD19)
  hw/sd/sdcard: Convert SEND_WRITE_PROT to generic_read_byte (CMD30)
  hw/sd/sdcard: Convert SD_STATUS to generic_read_byte (ACMD13)
  hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to generic_read_byte (ACMD22)
  hw/sd/sdcard: Convert SEND_SCR to generic_read_byte (ACMD51)
  hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
    sd_generic_write_byte
  hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK / WRITE_MULTIPLE_BLOCK
    cases
  hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to generic_write_byte (CMD24)
  hw/sd/sdcard: Convert PROGRAM_CID to generic_write_byte (CMD26)
  hw/sd/sdcard: Convert PROGRAM_CSD to generic_write_byte (CMD27)
  hw/sd/sdcard: Convert LOCK_UNLOCK to generic_write_byte (CMD42)
  hw/sd/sdcard: Move sd_[a]cmd_name() methods to sd.c
  hw/sd/sdcard: Pass SDState as argument to sd_[a]cmd_name()
  hw/sd/sdcard: Prepare SDProto to contain more fields
  hw/sd/sdcard: Store command name in SDProto
  hw/sd/sdcard: Store command type in SDProto
  hw/sd/sdcard: Store command class in SDProto
  hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
  hw/sd/sdcard: Register generic optional handlers (CMD11 and CMD20)
  hw/sd/sdcard: Register optional handlers from spec v6.00
  hw/sd/sdcard: Register SDIO optional handlers
  hw/sd/sdcard: Register Security Extension optional handlers
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
  hw/sd/sdcard: Add spi_cmd_READ_OCR handler (CMD58)
  hw/sd/sdcard: Add spi_cmd_CRC_ON_OFF handler (CMD59)
  hw/sd/sdcard: Add sd_acmd_SET_BUS_WIDTH handler (ACMD6)
  hw/sd/sdcard: Add sd_acmd_SD_STATUS handler (ACMD13)
  hw/sd/sdcard: Add sd_acmd_SEND_NUM_WR_BLOCKS handler (ACMD22)
  hw/sd/sdcard: Add sd_acmd_SET_WR_BLK_ERASE_COUNT handler (ACMD23)
  hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND handler (ACMD41)
  hw/sd/sdcard: Add sd_acmd_SET_CLR_CARD_DETECT handler (ACMD42)
  hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)

 docs/about/deprecated.rst |    6 +
 hw/sd/sdmmc-internal.h    |  124 +++-
 include/hw/sd/sd.h        |    5 +-
 hw/sd/sd.c                | 1462 +++++++++++++++++++++----------------
 hw/sd/sdmmc-internal.c    |   72 --
 hw/sd/meson.build         |    2 +-
 hw/sd/trace-events        |    5 +-
 7 files changed, 940 insertions(+), 736 deletions(-)
 delete mode 100644 hw/sd/sdmmc-internal.c

-- 
2.41.0


