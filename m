Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAF8C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjF-0006rJ-27; Fri, 04 Jul 2025 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjC-0006or-TI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:35 -0400
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjB-0000NL-0F
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:34 -0400
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6fa980d05a8so11377016d6.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648251; x=1752253051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/xFmyDuDauVeDIMGCaBYj1eBTD5nSO1rpYIc6K0NcA0=;
 b=JfeYh+yNn7guuCg1ucaawv8ib+gwDVC6PAkaPFNYpj3JqUX5k39EZ7AlF6I3qlmv93
 WU9RgQn+CuG/Cs8hQ/dW6LPIRv3m/IvifHDE8kf0vdnlZD7xylN6QGEvA0BDZf2zIlgq
 tPx1FhTwOl3zjfemxjVcC8mjEpL52D9LU2k+FOjvQ+UPjJabtxfxXa4Fx5uvrTNvl/xy
 LFSNKVjPG6pmwL3TB1vwt+lTnCSN5QEI+TKyIdyYUxxGGfglaOm+aBzOuZ/62gtHfebb
 /x8vjga/nvsFqSgnBtumzJEgLR9X4sqt5Lsxka/kXL3iewP05pr9LUTbJi9zt2Hjj493
 O5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648251; x=1752253051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xFmyDuDauVeDIMGCaBYj1eBTD5nSO1rpYIc6K0NcA0=;
 b=PlvNQM8m4AJNdz7i26KuNXFngeO2kUjEzYJZbXQJ5ItE1G+LN0Gxq6KbmXhPey4+n/
 D0/8GmxH7oYxvLW2AwhXKDF79AV8czOJ0EUYm8VIE0pZd9M+a7k6HOrx916HzNAcSOPO
 DmMn2+6IFgojxaL5eHgMoy11gDvVYyl0q6ApgrUbDyccJRFAvzwFlP3D6jeL25H6sb2u
 3pmxeXtXsh9bb4rg38oClcXHJj9qGZtl2e25rq8u4f7auQ9FJ2Pki0WqawQ5F5idXMk4
 TKxX9Gyul5kj5cA1h6t0bJd71IM9C2dCjZiuPF9MGNC2sHBrJkn+qSGBZDrE7HPcecs0
 aFRQ==
X-Gm-Message-State: AOJu0YzyIzj8F0n5zQLubeWWxCgGWcZPAuSe8WPejPDjJvNqsAbHZkyY
 rctABzpvwjX22OM6Bqu7WqBEmzmglyIZlLUvJ+E6IyCW+p18ie0JBI30jZ49Xw==
X-Gm-Gg: ASbGncseaxDVuZrSdpQRrASqQyv9+sLlfFGJsLq7Nj5ppBSJMCCoFco0VHf1/w4bkS9
 kOvtKllLOfCjSp1bcOOTQMgQGV8IdvbJNNEzXzmFo8pyrUZ24pc2H2a6UJod1JTBtp/RkeRV701
 xlCJ5BWnepTR3yrfLZQAFothtygkR2gGNxGZ8EsQay6JBpc0FGPBYgm1lnQS+eucRvlQ9XX+6T1
 SSArXLtwZmSc0DglCax9L0G9QAbrDqG5//vFNYrem9rOrcxJNXSOx9AAmyjI6qBmvpKhtITWGbg
 EnMT3RZfcbYopakOzVIuo3RSqMVxcG22o6PPj7iLH9/yi6DUXMUsXCg8EjEaOlw9kYi14GjtM+f
 08txF
X-Google-Smtp-Source: AGHT+IGal/rruOkJLwrV+tK1tYFFanMBjUP6mozepkR5EZhOBBnmAUqTq4ys9vUxzRqjLQ8aSsBmGg==
X-Received: by 2002:ad4:5969:0:b0:6fd:27ba:239f with SMTP id
 6a1803df08f44-702c6d117d9mr43748516d6.4.1751648251119; 
 Fri, 04 Jul 2025 09:57:31 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:30 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 00/11] MAX78000FTHR Implementation
Date: Fri,  4 Jul 2025 12:57:18 -0400
Message-Id: <20250704165729.208381-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

v3:

Addresses a few more comments by Peter. Really appreciate the review, thank you.

ICC SOC:
Gave each device a unique name

UART SOC:
Removed references to DeviceState and gave each device a unique name

GCR SOC:
Set object property links statically, instead of by reference to device id

TRNG:
Added comments explaining interrupt generation logic. See further rationale under v2.
It's certainly possible I'm missing something here, but I think what I have is correct.

TRNG SOC:
Removed reference to DeviceState

AES:
Simplified integer load & stores, added assertion before writing to memory_region_init_ram

AES SOC:
Removed reference to DeviceState

v2:

Addresses comments by Peter.
For each device:
- Switched soc to use sysbus_realize
- Standardized switch case bracing, indentation, and error case
- Added valid min and max access size
- Changed endianness to DEVICE_LITTLE_ENDIAN
- Added reset method, if not already implemented
- Added migration support
- Split soc integration into separate commit

Machine Implementation:
Added user guide URL
Removed refclk. According to https://developer.arm.com/documentation/ddi0403/d/System-Level-Architecture/System-Address-Map/The-system-timer--SysTick/SysTick-Control-and-Status-Register--SYST-CSR the systick clock can be either the processor clock or an implementation defined external reference clock. As far as I can tell based on the user guide, the MAX78000 does not define an external reference clock. I have not confirmed this in hardware.
Changed IRQ count to 120 and noted that the user guide is unclear on this number
Fixed unimplemented device lengths and names

ICC:
Removed ICC_Invalidate
Added number to device names

UART:
Fixed interrupts, allowing async UART
Added number to device names

GCR:
Changed string-based device search to prop links for device reset
Changed cpu_physical_memory_write to address_space_write

TRNG:
Changed source of randomness to qemu_guest_getrandom_nofail
Did not change interrupt generation
> Your interrupt generation code in this device doesn't look
> right: the interrupt is supposed to be generated when each
> new random number is ready, so in our "generation takes
> zero time" model a read from DATA should provoke a new
> interrupt immediately (assuming the interrupt is enabled):
> you need to simulate the ready status bit going low and
> then high again.

I believe the interrupt generation is fine in this case;
by latching it high so long as the interrupt is enabled,
the interrupt handler gets called repeatedly until it
receives the desired amount of data and disables the interrupt.
I've tested this and it works with the maxim sdk's
implementation of asynchronous trng.

> See also my comments on an earlier patch about the usual
> logic being to have an update function which does
> "set interrupt to (condition && enabled)".

In this case there is only one possible interrupt condition
(is there random data ready), which is always true when enabled.
As such I don't think a handler function is really necessary

v1:
This patch series implements basic support for the MAX78000FTHR machine

https://github.com/JacksonDonaldson/max78000Test
Contains instructions for building a test program against the MAX78000FTHR
as well as results of the test suite run on QEMU and hardware.

Jackson Donaldson (11):
  MAX78000: Add MAX78000FTHR Machine
  MAX78000: ICC Implementation
  MAX78000: Add ICC to SOC
  MAX78000: UART Implementation
  MAX78000: Add UART to SOC
  MAX78000: GCR Implementation
  MAX78000: Add GCR to SOC
  MAX78000: TRNG Implementation
  MAX78000: Add TRNG to SOC
  MAX78000: AES implementation
  MAX78000: Add AES to SOC

 hw/arm/Kconfig                  |  15 ++
 hw/arm/max78000_soc.c           | 240 ++++++++++++++++++++++
 hw/arm/max78000fthr.c           |  50 +++++
 hw/arm/meson.build              |   2 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 hw/misc/Kconfig                 |  12 ++
 hw/misc/max78000_aes.c          | 223 ++++++++++++++++++++
 hw/misc/max78000_gcr.c          | 351 ++++++++++++++++++++++++++++++++
 hw/misc/max78000_icc.c          | 120 +++++++++++
 hw/misc/max78000_trng.c         | 139 +++++++++++++
 hw/misc/meson.build             |   4 +
 include/hw/arm/max78000_soc.h   |  50 +++++
 include/hw/char/max78000_uart.h |  78 +++++++
 include/hw/misc/max78000_aes.h  |  68 +++++++
 include/hw/misc/max78000_gcr.h  | 131 ++++++++++++
 include/hw/misc/max78000_icc.h  |  33 +++
 include/hw/misc/max78000_trng.h |  35 ++++
 19 files changed, 1840 insertions(+)
 create mode 100644 hw/arm/max78000_soc.c
 create mode 100644 hw/arm/max78000fthr.c
 create mode 100644 hw/char/max78000_uart.c
 create mode 100644 hw/misc/max78000_aes.c
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 hw/misc/max78000_trng.c
 create mode 100644 include/hw/arm/max78000_soc.h
 create mode 100644 include/hw/char/max78000_uart.h
 create mode 100644 include/hw/misc/max78000_aes.h
 create mode 100644 include/hw/misc/max78000_gcr.h
 create mode 100644 include/hw/misc/max78000_icc.h
 create mode 100644 include/hw/misc/max78000_trng.h

-- 
2.34.1


