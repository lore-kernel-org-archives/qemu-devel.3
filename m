Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E76C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9dY-0008BE-Ix; Tue, 07 Jul 2026 13:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wh9dW-00084a-Q8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:31:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wh9dU-0005sW-9C
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:31:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so38931995e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783445466; x=1784050266; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+d0d8z5mwtfwDTuBj837GZ0g3RzJV41rwO3e9i2YeFw=;
 b=WbfcFZDKdV5GVfSb8Xq/EhbHHHp1hF59/6LkADJMVUfW/PIiiEzc7pOV9rzR7xIlhQ
 D3+HRrHZXlJiesxZb4ErLP7HiL2l7fSSwXTMIcjGQ6CUEhewXqnQDls8szU/9bWTiS5x
 sCqTudZcIKp2n56ZLoHEMm0LFGYDC/o/yIjDQLSO0OAlY1k1u5lDPGofq12+o8gMqcqk
 yECAInP1M63habdXR4LUN62ziF24iFgkJCJzGc4lWGAf/84QTdiBH50dKiPYkBdPCZ8Z
 WcvKVm/30tInf56AHSrrhAFvVZFw9BVio95vjwmPPWcXpbqShiXICHbxL1ijXkyzSHUH
 wlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783445466; x=1784050266;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+d0d8z5mwtfwDTuBj837GZ0g3RzJV41rwO3e9i2YeFw=;
 b=nYxly1TH9edVimFg/ZNpwQtxXhpLWN6brJXuh86bQHb97yrW4cK4IlxVtKKMqTVDEA
 NPj+3ouaV/fkztKOtqty44ydYPGjaKy70mfWtoQke9f2LxL31J8Hz1ugTRfuR78BpLaf
 xwoB1JQoYA59GQhVwaJJf60GPk8RQmWE8IdZK+1MroZZm1EbjhhmypMKRNIXrbzr/qP/
 RXqHr6m0Ci2ntNBPQnEpHxFGxglZMFzxfHU+xg7m3Uv04gZHjeFAi2TwZfZt/2ikW5nz
 xk7uLntTz9mS74lr3tj3M4dLz5JQESKN3uzbLWU1wNIPxBNqORKwKtM0lRrGQ/4qtxPd
 mx7g==
X-Gm-Message-State: AOJu0YzmnO86oCG/6DCptOpmT0IieQO1dO8tD8poN4M0/poeuqR+Uzmd
 843PRX7fasHDwA75NGesjT5MzwxRV3tXBY588T4TXU9SKcOaqwdwXEOkb+zeUA==
X-Gm-Gg: AfdE7clgLEhakvvvzABHZGpqfoQgUcjSA+VGh9cBPFwMCIn5sdkZOi4VfXz889oEaOQ
 O0DnpQxVTj46EHKQC1vsxoxNUGAZGsoiehIlfZqj6EldBxpVa1J66dsms+NqdvzQ+e8pHo25eh9
 S0VTTTeEAaX0FleC42M45OnVJKeDPdyadQq4A77B1GJAyzhUenrTjsIHscZ95nDU2mDb6GpZqZ5
 vAYcGmvEaaFtC6A1+9M4nfSvBoJXR6DzFOUvZOXD+wwLIoL8RmfsG6Mo6ubg03DBCmFca++H9Y9
 TNjGQPNqdy+p6FIxEuqrUW6bCFJhLyVO3eMVZyXPbtnBahISEF+i0riFIopee0yJv/QYe//z5m6
 Ds7Kj9dNV/h2G8CJRY4rIWf3kIvVEmavmP0PQhFwa0ZCxW5CK3q/wr9HHfJEl2irMedw7CTBmwM
 IjdgLwyu7a8hz9/1YhBw==
X-Received: by 2002:a05:600c:3556:b0:493:b4cf:d37f with SMTP id
 5b1f17b1804b1-493df314e83mr65376675e9.16.1783445466211; 
 Tue, 07 Jul 2026 10:31:06 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e54a27cbsm3130235e9.1.2026.07.07.10.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:31:05 -0700 (PDT)
Date: Tue, 07 Jul 2026 17:27:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PULL 00/32] Misc HW patches for 2026-07-07
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
Message-ID: <C892C8D2-9E0D-4F8E-8B97-BB315041C34E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 7=2E Juli 2026 13:11:50 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <phil=
md@oss=2Equalcomm=2Ecom>:
>The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c3=
48:
>
>  Merge tag 'accel-20260706' of https://github=2Ecom/philmd/qemu into sta=
ging (2026-07-06 18:38:14 +0200)
>
>are available in the Git repository at:
>
>  https://github=2Ecom/philmd/qemu=2Egit tags/hw-misc-20260707
>
>for you to fetch changes up to 04584a27dd59741bc20272c6faab96c08bcbb926:
>
>  Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles" (2026-07-=
07 15:08:41 +0200)
>
>----------------------------------------------------------------
>Misc HW patches
>
>- Fix in few trace event formats
>- A pair of improvements in util/
>- FlexCAN3 to imx8mp-evk board
>- Various fixes in hw/
>  (EDU, ATI VGA, IDE AHCI, PCA9552, i8257 DMA,
>   e1000e/igb, MPT SAS, Hyper-V, QXL, M25P80)
>----------------------------------------------------------------
>
>BALATON Zoltan (1):
>  hw/display/ati: Include vga state in the blit context
>
>Bernhard Beschow (5):
>  hw/net/can/flexcan: Wire clock control module via link property
>  hw/net/can/flexcan: Subclass TYPE_CAN_FLEXCAN
>  hw/arm/imx8mp-evk: Open code DEFINE_MACHINE_AARCH64
>  hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
>  hw/arm: Add basic FlexCAN3 support to TYPE_FSL_IMX8MP and imx8mp-evk

Thanks Phil! I owe you two beer (another one for the rs5c372)=2E Or whatev=
er liquid you like=2E

Best,
Bernhard

>
>Bin Meng (8):
>  hw/block: m25p80: Fix dummy byte handling for Winbond flash
>  hw/block: m25p80: Fix dummy byte handling for Numonyx/Micron flash
>  hw/block: m25p80: Fix dummy byte handling for Macronix flash
>  hw/ssi: npcm7xx_fiu: Correct the dummy cycle emulation logic
>  hw/ssi: xilinx_spips: Fix dummy phase handling
>  hw/ssi: aspeed_smc: Fix direct-read dummy bytes
>  Revert "aspeed/smc: Fix number of dummy cycles for FAST_READ_4
>    command"
>  Revert "aspeed/smc: snoop SPI transfers to fake dummy cycles"
>
>Denis V=2E Lunev (1):
>  hw/ide/ahci: cancel in-flight buffered reads on command engine restart
>
>Dmitry Frolov (1):
>  utils/module: fix memleak in module_load()
>
>Evgeny Kolmakov (1):
>  util/filemonitor-inotify: Use QEMU_LOCK_GUARD()
>
>Junjie Cao (2):
>  hw/display/ati: reset host_data=2Enext in write handler after flush
>  hw/display/ati: guard against zero bpp in ati_host_data_flush
>
>Mark Cave-Ayland (2):
>  hw/rtc/mc146818rtc: convert date from object prop to class prop
>  hw/acpi/ich9: move initial property values into
>    ich9_reset_properties()
>
>Peter Maydell (3):
>  hw/dma/i8257: Return zeroes for read_memory in verify mode
>  hw/scsi/mptsas: Reset doorbell state on reset
>  hw/hyperv: Avoid crash if hyperv_find_cpu() passed invalid vp_index
>
>Sanjeeva Yerrapureddy (1):
>  hw/net: fix e1000e/igb ip_len inflation by Ethernet minimum-frame
>    padding
>
>Shameer Kolothum (1):
>  backends/iommufd: Fix dev_id and type order in viommu trace
>
>Song Gao (1):
>  hw/intc/loongarch_dintc: Fix OOB access in DINT MMIO write handler
>
>Thomas Huth (1):
>  hw/display/qxl: Fix mono cursor validation that can read past a cursor
>    chunk
>
>Torin Carey (1):
>  hw/misc/edu: restrict dma access to dma buffer
>
>yujun (3):
>  hw/gpio/pca9552: fix off-by-one in QOM led index validation
>  ebpf: fix swapped toeplitz/indirection args in set_data trace
>  crypto/x509-utils: fix gnutls error code in crt_init failure path
>
> docs/system/arm/imx8m=2Erst     |   1 +
> include/hw/acpi/ich9=2Eh        |   2 +
> include/hw/arm/fsl-imx8mp=2Eh   |   8 ++
> include/hw/net/flexcan=2Eh      |   4 +-
> include/hw/ssi/aspeed_smc=2Eh   |   2 -
> include/hw/ssi/xilinx_spips=2Eh |   2 +-
> crypto/x509-utils=2Ec           |   3 +-
> ebpf/ebpf_rss=2Ec               |   2 +-
> hw/acpi/ich9=2Ec                |   8 +-
> hw/arm/fsl-imx6=2Ec             |   5 +-
> hw/arm/fsl-imx8mp=2Ec           |  38 ++++++++++
> hw/arm/imx8mp-evk=2Ec           |  64 +++++++++++++---
> hw/block/m25p80=2Ec             | 122 +++++++++++++++++++-----------
> hw/display/ati=2Ec              |   2 +
> hw/display/ati_2d=2Ec           |  44 +++++------
> hw/display/qxl-render=2Ec       |   8 +-
> hw/dma/i8257=2Ec                |  13 ++++
> hw/gpio/pca9552=2Ec             |   8 +-
> hw/hyperv/hyperv=2Ec            |   4 +-
> hw/ide/ahci=2Ec                 |   3 +
> hw/intc/loongarch_dintc=2Ec     |  13 ++++
> hw/isa/lpc_ich9=2Ec             |   1 +
> hw/misc/edu=2Ec                 |  24 +++---
> hw/misc/imx8mp_ccm=2Ec          |   3 +
> hw/net/can/flexcan=2Ec          |  90 ++++++++++++++++++-----
> hw/net/net_tx_pkt=2Ec           |   7 +-
> hw/rtc/mc146818rtc=2Ec          |   4 +-
> hw/scsi/mptsas=2Ec              |   4 +
> hw/ssi/aspeed_smc=2Ec           | 135 +++++-----------------------------
> hw/ssi/npcm7xx_fiu=2Ec          |  25 ++-----
> hw/ssi/xilinx_spips=2Ec         | 123 ++++++++++++++++++++++---------
> util/filemonitor-inotify=2Ec    |  28 ++-----
> util/module=2Ec                 |   2 +-
> backends/trace-events         |   2 +-
> hw/arm/Kconfig                |   1 +
> hw/ssi/trace-events           |   1 -
> 36 files changed, 488 insertions(+), 318 deletions(-)
>

