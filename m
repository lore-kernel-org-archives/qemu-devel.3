Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908E2E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnh2-0006Sg-8U; Sun, 29 Dec 2024 02:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRngy-0006SJ-4x
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:28 -0500
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRngv-00026S-VO
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:27 -0500
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso967894566b.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457184; x=1736061984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvEIz2KWEbr8/oabtZ3wflvXGoGDCq8wUZeLDrOaRDg=;
 b=oijlkAVYJqc5ZzaboTMZB9QBSqY1662eUxdcBxo0rqUM30ByVXANutDZpjJNLNHrJA
 zB5yaG9R5naYRG88Rcxe9kw2szqNgNY/9ho45n45cCPPdKrYn/AD+IHPKjh6NOQytFaX
 zNlOFbVAGm9gPh6x590bX5hOUF1D+wW7pfrMYbsRbNSSSXHlfkH85Iy4opx1Hy6DZXot
 JbzdlkmqWqtI2Ml0/TNSf1v85xMpLx+CaIEIUk4sySmMYdrjLNiV44ubuhoX2q4c6caS
 VPY6r1zp/SXsSX8c3BzURjwUduJMfLBGO+/L4QAAYG8w8ZfGsjZndM3lcQ2YlQKFIjfX
 3ybg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOqRAXylcSD/CflAVqL6dxFzJEFblYBy0UU8gdjsz3hV1L++19D4nUcCc0iawtRE2r/1gMf60mFjcA@nongnu.org
X-Gm-Message-State: AOJu0YzRxR8YK7O8keGZW6VlU/lCUju/xlBtbOWJOTked1wxkE/JboIZ
 4rK83fcq5KKnuqIAzfoMRVrVuHaRSZqQmHxgkMvXrXFVHJ6AvSDL1BAesw==
X-Gm-Gg: ASbGncviLa9XeWz7tnZX2LTIYW3HjecgZFUelMyLlK4+7jzROBjqRV81W6E7HR36Q5E
 NWGtRjD2XRaCaU9+qNXLhGzim9v9cWThxTyL2JwDMt/JkmPSLdg0hodFRNcdefLYOnpM/uKp6sN
 1ChBZRjhB5DRQutsy818+rd03oEfaQUTAZuDl1zDvEA54q90Qt+Ya1g+gQkmLPKRx5i6lTg2ydC
 0rYIX4adY0Y90TmJk3qZ+IyjO8LuSXzo5e/n4W7pgXQ5hv5xB3EzXCd2xUg13mW9B+EyGDH2zOb
 wkU=
X-Google-Smtp-Source: AGHT+IF2Utf412/vgPQyhjMA/aGiYiv5zBphmoTzQS3fEzj7Y1UYKPG33PYMUddNo1i5qX6nzB8kIQ==
X-Received: by 2002:a17:907:3f19:b0:aa6:730c:acb with SMTP id
 a640c23a62f3a-aac2702a2c2mr2612289966b.8.1735457183871; 
 Sat, 28 Dec 2024 23:26:23 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:22 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 00/35] m68k / next-cube patches
Date: Sun, 29 Dec 2024 08:24:51 +0100
Message-ID: <20241229072526.166555-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.49; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f49.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 Hi Stefan!

The following changes since commit 2b7a80e07a29074530a0ebc8005a418ee07b1faf:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-12-28 10:16:34 -0500)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2024-12-29

for you to fetch changes up to ee58d282aa87a7f4a4409528ff12192c0bcfeb82:

  next-cube: add my copyright to the top of the file (2024-12-29 07:13:47 +0100)

----------------------------------------------------------------
* Rework "next-cube" to bring it up-to-date with current coding standards/APIs
* Remove overlapping memory regions of the "next-cube" machine
* Encapsulate the next-cube SCSI related code into a separate device
* QOM-ify the next-rtc device
* Declare m68k devices as big endian instead of native endian
* Disable the CD-ROM drive for the next-cube machine

----------------------------------------------------------------
Mark Cave-Ayland (33):
      next-cube: remove 0x14020 dummy value from next_mmio_read()
      next-cube: remove overlap between next.dma and next.mmio memory regions
      next-cube: create new next.scsi container memory region
      next-cube: move next_scsi_init() to next_pc_realize()
      next-cube: introduce next_pc_init() object init function
      next-cube: introduce next-scsi device
      next-cube: move SCSI CSRs from next-pc to the next-scsi device
      next-cube: move SCSI 4020/4021 logic from next-pc device to next-scsi device
      next-cube: move floppy disk MMIO to separate memory region in next-pc
      next-cube: map ESCC registers as a subregion of the next.scr memory region
      next-cube: move ESCC to be QOM child of next-pc device
      next-cube: move timer MMIO to separate memory region on next-pc device
      next-cube: move en ethernet MMIO to separate memory region on next-pc device
      next-cube: add empty slots for unknown accesses to next.scr memory region
      next-cube: remove unused next.scr memory region
      next-cube: rearrange NeXTState declarations to improve readability
      next-cube: convert next-pc device to use Resettable interface
      next-cube: rename typedef struct NextRtc to NeXTRTC
      next-cube: use qemu_irq to drive int_status in next_scr2_rtc_update()
      next-cube: separate rtc read and write shift logic
      next-cube: always use retval to return rtc read values
      next-cube: use named gpio to set RTC data bit in scr2
      next-cube: use named gpio to read RTC data bit in scr2
      next-cube: don't use rtc phase value of -1
      next-cube: QOMify NeXTRTC
      next-cube: move reset of next-rtc fields from next-pc to next-rtc
      next-cube: move rtc-data-in gpio from next-pc to next-rtc device
      next-cube: use named gpio output for next-rtc data
      next-cube: add rtc-cmd-reset named gpio to reset the rtc state machine
      next-cube: add rtc-power-out named gpio to trigger the NEXT_PWR_I interrupt
      next-cube: move next_rtc_cmd_is_write() and next_rtc_data_in_irq() functions
      next-cube: rename old_scr2 and scr2_2 in next_scr2_rtc_update()
      next-cube: add my copyright to the top of the file

Philippe Mathieu-Daudé (1):
      hw/m68k: Mark devices as big-endian

Thomas Huth (1):
      hw/m68k/next-cube: Disable the default CD-ROM drive

 hw/m68k/Kconfig     |    1 +
 hw/m68k/mcf5206.c   |    2 +-
 hw/m68k/mcf5208.c   |    6 +-
 hw/m68k/mcf_intc.c  |    2 +-
 hw/m68k/next-cube.c | 1022 +++++++++++++++++++++++++++++++++------------------
 hw/m68k/next-kbd.c  |    2 +-
 6 files changed, 665 insertions(+), 370 deletions(-)

