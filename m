Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A43D5C0C9
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PSK-00074I-MY; Fri, 08 Nov 2024 08:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSJ-00073y-FD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:19 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSH-0005ai-Kz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso19228255e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731074116; x=1731678916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PKVpwzw1sWKF3ABfu6LZIFLN7WX7HAK9O/JR+vxGyVk=;
 b=DFAFKNIqTfFO4FUPov7u5NmQWeo1D6OJc+9nrpKFSV49v3i2BEmRj554EYQQk6D6eN
 EoqregCxooiV22uryZGqMjQQjatCO4AmyV48GxiI/KPjhPmkKB9THEsc6JvgyCy0gu4o
 vQIV57FYVIwU6/jYMzKO4TlrdsH54qhcLlr8RXtTK3gMBAFL5/Bh0GfwR3xm1++1nmM/
 VtoPy/b8MTx8AcE5dkzWI7PGjTQxxE2srNFTwM6/RW8dG1vjB7dmAbBNIIrIdNY8HBQC
 f5FRsW1o2ARPbSDg4SLzkHRoLasP9wXhAo1B4/4gwB1BHWoDLRjRgnDhkxg3J1+zsww4
 tsvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731074116; x=1731678916;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PKVpwzw1sWKF3ABfu6LZIFLN7WX7HAK9O/JR+vxGyVk=;
 b=sMiIkF4v72dQDgsmaG5RwZ2/8eHCPUPqWfIG6dHtUdd1P278JUiiCx4APXzMKM7UAv
 2mhFF/xCDCLdtvqnhAe30f6PM4sgudHew2/3gYKypNdk/kCt8XxEQvpjlrK1RbrHy+gj
 wtKartTkiSvZOsHL/XvznV6/RLBfBT+yrtn6bGaCbvREMvpMegfOMBIdJmMnvYC52X9R
 maatvpfkru+RoIuCRH+k2lIDN1YSL6Yu5X0saSD4iZGvDB848NNOtzSSXk/2GFi+hMvm
 nLOhU+dgO7O/sWf4dEquENYv1DrPv5Um5Q7+KLRiDhNLKK3iq1wfc5DsUJzRB4vfQ/1p
 LlMQ==
X-Gm-Message-State: AOJu0YyNjeZv1+FzK9Z1TWo+Rq2IFv3y65CH1ozm32xF/QXFnYHMhnHm
 uGiPublg5kelxgRK8cieZNUVSc88mbifQYtUG4ODn0Z4N4uCouNhTHiuhqe0ERj46teXBOeBmtI
 F
X-Google-Smtp-Source: AGHT+IFFtL5LGAzm0Yc2/UE/Zc/9NG7MIrPUvIOJUy2pMRb0W8f3Aq2qYM6zprkffJ/5pSKu7Qb5Bg==
X-Received: by 2002:a05:600c:3ca4:b0:431:251a:9dc9 with SMTP id
 5b1f17b1804b1-432b7518f97mr24925755e9.25.1731074115899; 
 Fri, 08 Nov 2024 05:55:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a2ccsm110082855e9.31.2024.11.08.05.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:55:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/3] hw/intc/loongarch_extioi: Fix undefined behaviour with
 bit array APIs
Date: Fri,  8 Nov 2024 13:55:11 +0000
Message-Id: <20241108135514.4006953-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

The primary aim of this series is to fix some undefined behaviour in
loongarch_extioi which you can see if you run the functional test
loongarch64-virt with a QEMU built with the clang undefined-behaviour
sanitizer:

include/qemu/bitops.h:41:5: runtime error: store to misaligned address 0x555559745d9c for type 'unsigned long', which requires 8 byte alignment
0x555559745d9c: note: pointer points here
  ff ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^
    #0 0x555556fb81c4 in set_bit include/qemu/bitops.h:41:9
    #1 0x555556fb81c4 in extioi_setirq hw/intc/loongarch_extioi.c:65:9
    #2 0x555556fb6e90 in pch_pic_irq_handler hw/intc/loongarch_pch_pic.c:75:5
    #3 0x555556710265 in serial_ioport_write hw/char/serial.c
                                                                
The underlying cause of this is a mismatch between our bit array APIs
in bitops.h and what QEMU devices tend to want. The bit array APIs are
historically based on those from the Linux kernel; they work with
underlying storage that is an array of 'unsigned long'. This is fine
for the kernel, but awkward for QEMU devices because the 'unsigned
long' type varies in size between hosts. That means that you can't use
it for a data structure that needs to be migrated between devices and
it's awkward for devices where the bit array is visible to the guest
(e.g. via a set of registers).

In the Arm GICv3 device I worked around this mismatch by implementing
a set of local functions which were like the bitops.h APIs but used a
uint32_t array. The loongarch_extioi code attempts to use the stock
bitops.h functions by casting the uint32_t* to an unsigned long* when
calling them. This doesn't work for two reasons:
 * the alignment of uint32_t is less than that of unsigned long,
   so the pointer isn't guaranteed to be sufficiently aligned;
   this is the cause of the sanitizer UB error
 * on a big-endian host we will get the wrong results because the
   two halves of the unsigned long will be the opposite way round

In this series I fix this by creating new functions set_bit32(),
clear_bit32(), etc in bitops.h which are like the existing ones but
work with a bit array whose underlying storage is a uint32_t array.
Then we can use these both in the GICv3 (where this is just a
cleanup) and in loongarch_extioi (where it fixes the bug).

(There are other uses of set_bit() in the loongarch_extioi code but
I have left those alone because they define the bitmaps as
arrays of unsigned long so they are at least consistent. I do
wonder if it's really OK not to migrate those bitmaps, though.)

thanks
-- PMM

Peter Maydell (3):
  bitops.h: Define bit operations on 'uint32_t' arrays
  hw/intc/arm_gicv3: Use bitops.h uint32_t bit array functions
  hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() for s->isr

 include/hw/intc/arm_gicv3_common.h |  54 +++------
 include/qemu/bitmap.h              |   8 ++
 include/qemu/bitops.h              | 172 ++++++++++++++++++++++++++++-
 hw/intc/loongarch_extioi.c         |  11 +-
 4 files changed, 194 insertions(+), 51 deletions(-)

-- 
2.34.1


