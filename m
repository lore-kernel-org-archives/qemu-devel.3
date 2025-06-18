Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5790CC71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7ia-0003HH-LJ; Thu, 19 Jun 2025 01:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1qu-0006p1-Ee
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:05:56 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1qr-00063j-Co
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:05:56 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3de0f5ff22dso556525ab.1
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287951; x=1750892751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tfcC1kApZBi+jcfZc2MyM5AiwIvLczIG1aR2fWHBSgI=;
 b=OAw867WurOMOGIGLtExq52OMRGKbsblBakLHbODV5WCD7tkpECkz2Y2w1aKeIY8qOw
 UZUXe+Ci4kK1Bn4poD26KwkFwwnxnHbTt9Q3cYKygCq/W2cyOec1Kvr7Nf3QkCn2SmQz
 afvLxf4fZN9enclBp52dBRosy4fGGeJXuLLEKs6t7vvhWuLOvhVTdXy4jaYij8RI+cdy
 rFrN7jLAE2bc+DgTJXOQQMzf8z8k/QijH+K391xzCv6LYJ2mpDDdQ2K7EVelik7q+rI1
 eV8ZDuqkEacRPfKAeONfW7rVqRm5LKkZ7lx/3PUAI/PHlyT2pry/L0eMx1Mp04+d7S5f
 pNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287951; x=1750892751;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tfcC1kApZBi+jcfZc2MyM5AiwIvLczIG1aR2fWHBSgI=;
 b=ZEbHaq2lt+my0JvqJagdu410BGYKwatitYnq/gcBnn13iz7xotnvvls8HXYqK0hcZC
 dEgmYGpZ0aEN6BstQpZK8Kf9wzm9S9G9ZaxMenuQjOpaKIAupRChroM1dWj3FCxhqg1P
 mURd8rdPLdcuSC3/RH1A9ZwvXgF4phhhwV0la1AByz3pP867PifoIBoxHhSZQ+jsGI4p
 mg49bbXck5M5mx1ErGgGTfegVtuYfNxwIiKKu/JqCgfWtv6JMGua/jdodSw5/cMv2qL5
 2ZrdApHz4LljXPPjwmdpVVqL1pWw7PAmgvhsPBwDuRE916zI4iaLuBimWoe2xj4RfzzI
 96IA==
X-Gm-Message-State: AOJu0YxvYxvRQcxZDWYhNW6rgBIFJVzGyvEGS6WdxQ/rCPMM5LaT9XlR
 bmr5WxWx2Rs8k0pWZX8qIu75YPRDbeIsB+m9hzg3dXv4Xw/QNvwK4KpRpfkyDFEJgF4=
X-Gm-Gg: ASbGncuEOcI68nzKr+k7RE6n7jFl4iQ1lYI7AyAeopqVhcf9ESgQ9ekq9XU6kwpqLkh
 ZTsnyqMw5Cb/9flwovdqFjwDWEuyMoAdZStBNfmq78S7vMd4k4aHmxLt4tQtC0/Dy0rduQ+FbU/
 PaUOFMd2Ej1D6pWmJK6QVBUJi2+2lqgOEuM/Y4OrwL8TAgxEk/J8FuMSociYz0l30pyxiJZf/+i
 goRwre9Z407qDHnDvhYFn1rB903VEdsztoKtIgpbC8X0+auFSeZCgXccgDznULN2drpmDIDlosN
 c6PP1ovCldwpPqyk2plerFAeyNnlbLjs5oHiPNb35mv4z24sXyWLIBiWFnwsLuWeRMKBboLFBv9
 +j5oh
X-Google-Smtp-Source: AGHT+IHutbs89UCDP5RIVe0OxMVt3JAV2UtsxMAs7h3jGoDxVU1SkQaPimc9/jGpxiTf1BYTedY8yw==
X-Received: by 2002:a05:6e02:4605:b0:3d9:2992:671b with SMTP id
 e9e14a558f8ab-3de301f22e6mr16744435ab.4.1750287950550; 
 Wed, 18 Jun 2025 16:05:50 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:05:50 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 00/11] MAX78000FTHR Implementation
Date: Wed, 18 Jun 2025 19:05:38 -0400
Message-Id: <20250618230549.3351152-1-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=jackson88044@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:21:41 -0400
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


> A minor note on email patchseries formatting: something odd
> seems to have happened with your cover letter. Patches in a
> series are supposed to be followups to the cover letter, but
> in this case each patch email has a header
>  In-reply-to: 20250510042043.2056265-1-jcksn@duck.com
> but that doesn't match the message-id of the cover letter mail
> (which was
>  16B81215-B460-4A49-910E-E5FB479837C8.1@smtp-inbound1.duck.com
> ).
> 
> It looks like something has rewritten the message-ID header
> between when git generated it and it got to the mailing list.
> I don't know if that's something you can fix at your end.
> (Otherwise I guess you could work around it by sending the cover
> letter first, finding out what message-ID it got given, and then
> generating the patch emails with the --in-reply-to=<identifier>
> option of git send-email so they come out as replies to the
> cover letter. But that seems a bit of a faff :-/ )

This is probably because my emails are forwarded through duckduckgo
with the @duck.com address. Testing that workaround didn't appear to
accomplish the desired result, so I'm sending directly from gmail
now.

v2 changes:

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
 hw/arm/max78000_soc.c           | 234 +++++++++++++++++++++
 hw/arm/max78000fthr.c           |  50 +++++
 hw/arm/meson.build              |   2 +
 hw/char/Kconfig                 |   3 +
 hw/char/max78000_uart.c         | 285 ++++++++++++++++++++++++++
 hw/char/meson.build             |   1 +
 hw/misc/Kconfig                 |  12 ++
 hw/misc/max78000_aes.c          | 232 +++++++++++++++++++++
 hw/misc/max78000_gcr.c          | 351 ++++++++++++++++++++++++++++++++
 hw/misc/max78000_icc.c          | 120 +++++++++++
 hw/misc/max78000_trng.c         | 127 ++++++++++++
 hw/misc/meson.build             |   4 +
 include/hw/arm/max78000_soc.h   |  50 +++++
 include/hw/char/max78000_uart.h |  78 +++++++
 include/hw/misc/max78000_aes.h  |  68 +++++++
 include/hw/misc/max78000_gcr.h  | 131 ++++++++++++
 include/hw/misc/max78000_icc.h  |  33 +++
 include/hw/misc/max78000_trng.h |  35 ++++
 19 files changed, 1831 insertions(+)
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


