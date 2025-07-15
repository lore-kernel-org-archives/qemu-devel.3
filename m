Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF39C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6P-0001zU-B7; Mon, 14 Jul 2025 20:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6J-0001es-Us
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:52 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6H-00083Y-Lr
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:51 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so41847696d6.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537647; x=1753142447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JrIhx6eISGfYFMzOikqtWPrp3DNp3jH05jHJYiMTBK0=;
 b=DiqkVWhBHvuzdIp3vmNOnv4iqRn0yX7UQrxFBlLulJKHjUdcXwwc1F6QVzIeEfJd0g
 0bGrLwVk2sn5ut8++ugv13Ka+zxm5Q49fqIcOPU1U8q20VSPTBwaoxCCjhUJbFfcZFMJ
 odlPU5OHozic+B2UFYIABa9EcAEWgwEmSmH1HHRDXDHffEz83MI5uFHrUmNb8/yuIRaS
 AmahdrriMYvN/iEq1pESbv2GhwuMIP0RQVhn8MCwH4/ZsrEn4nxtwXmrEwbnCyvfgEV6
 DU9zX0UJmbuJ6ojYFNebdBp7OAfiUxcH+fY/3tjoHe8qvHIrUiyagXcJI3o1yIhjsuEq
 fiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537647; x=1753142447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrIhx6eISGfYFMzOikqtWPrp3DNp3jH05jHJYiMTBK0=;
 b=a/uIU9rGGP2IwJhXKCxZEUGp9Cy1wIemjziRTgqavgZ5uf3qLqSdoiwMWw0kWJDHt/
 XdynMQACFz6+IBKLGoUaUcdfQXY1X2p8eGJuWM6cCcz0CxaINvBG+vtYe8cfAmJfpz+f
 E88uGTqN9daPxG/GHHucR5c5dgAJZHIHBC9n1Da852Q/QljiglVxNJkfCxQUjTGTYOwk
 NghzMPjW9WfRUM4y6SmbR1Y1s4C5En4JW1gW4oaZDOIuXMPx/LHOhQxAHSKqa4OFkZNW
 vzBA2mQF1uyflBhoHm0KQeUISZ+ZNfWRgCMfaruP3kT49d5qCUOoZXWsliBh9dztoB5Q
 C8/g==
X-Gm-Message-State: AOJu0Yw7Nxf9JGA+pmPfxz0XVE+lOptoVI3SkqZCMz+dM4dSGbn3q7hp
 8IeSI3pcRk1BXCFXdtKmIQe4Te3f/Fx0Yz638mcNohzuq8ysfOf5y3t1TlSb1w==
X-Gm-Gg: ASbGncuzyFvf7pC40Y7+gBOTlVWJfk1d7zmtp/zW50alJvLRzYKjZrHaVfVzOqOQFcI
 xNg5kSGPUzlKHoI0h1aLmKvlLbvPr0e4eSKvLWaKcQxCEhD1+jdcS3+km/ZWId7Zg8CfGEGH4PK
 MJtAFQkJQCKJBkwDFeBFF1zH2kWxMPD5eOSjgmTJsuO4FrdF3n0n8ZcDZTgX0HIDt08XVhBpLpY
 jnKNgQo+nk+IXkPDANLNFIBKo5H7UuhMzx2ePRNuZM/iRxzrQ3KmoDeqI48c3xjB1mS8AvVgbXW
 cmYZhWPLNjKTvG7Z4sGa7sLXEoFD5WhU5oYnEbHGoDBnklrHQz2SM/GpHpXzwnz6O0sbGyCWUGX
 htPj8aSMRYXK6Kwdtb8bQIiaI9lhHml4pIzU5j07aqtc6b7E=
X-Google-Smtp-Source: AGHT+IFne4kz+MjUvh8al6Ge6MmB/TuPtHKxMkV9nRDeSiSF0GN51wmL+HGeSkyvLZmtVguRcH1ZkA==
X-Received: by 2002:a05:6214:2465:b0:704:8d8e:e9a7 with SMTP id
 6a1803df08f44-704a42b0a68mr212736216d6.24.1752537647070; 
 Mon, 14 Jul 2025 17:00:47 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:46 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 00/11] MAX78000FTHR Implementation
Date: Mon, 14 Jul 2025 20:00:34 -0400
Message-Id: <20250715000045.57332-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2a.google.com
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

v5:

> > +    AES_KEY key;
> > +    if ((s->ctrl & TYPE) == 0) {
> > +        AES_set_encrypt_key(keydata, keylen, &key);
> > +        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
> > +        AES_encrypt(s->data, s->result, &key);
> Here we call AES_set_encrypt_key() and AES_set_decrypt_key()
> before calling AES_encrypt()...

> > +        s->result_index = 16;
> > +    } else if ((s->ctrl & TYPE) == 1 << 8) {
> > +        AES_set_decrypt_key(keydata, keylen, &key);
> > +        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
> > +        AES_decrypt(s->data, s->result, &key);
> 
> ...here we call AES_set_decrypt_key() twice before
> calling AES_decrypt(). This looks a bit odd: should we either
> (a) call both AES_set_decrypt_key() and AES_set_encrypt_key()
> in each half of the if(), or (b) call AES_set_encyrypt_key()
> twice in the AES_encrypt() code path ?
> 
> (Coverity is sometimes wrong, as it's only using a heuristic
> here, so the other option is "the code as written is correct",
> but in that case a comment might be helpful for human readers.)

> thanks
> -- PMM

The AES engine stores an internal key which it uses only for decryption
when in the last TYPE. This results in the odd-looking call pairs.
I've added the requested comment.
- Jackson

v4:

Spacing and style standard changes in GCR SOC, TRNG SOC, and AES SOC

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
 hw/arm/max78000_soc.c           | 232 +++++++++++++++++++++
 hw/arm/max78000fthr.c           |  50 +++++
 hw/arm/meson.build              |   2 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 hw/misc/Kconfig                 |  12 ++
 hw/misc/max78000_aes.c          | 229 +++++++++++++++++++++
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
 19 files changed, 1838 insertions(+)
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


