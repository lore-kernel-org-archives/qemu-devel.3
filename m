Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B706AD3E76E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTP3l-0000zO-TM; Wed, 10 Dec 2025 13:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3k-0000yl-Py
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:08 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vTP3i-0002Pm-DF
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:37:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2b80ab25so23821f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 10:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765391823; x=1765996623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hBVLNLzh2h7x+zlFBYT2iI+TEnUQJ8dUS09XaPFchj4=;
 b=qDlI3MR1+0AySMB6QlO7Ni0joy8LsWtx7xgDj2ychIuSSCprrU0AZOkdzkhSGsyUqT
 8VSSyGuoyDKTaXsSi+RhJISWuIPWipacTfn+ekZjE7GCEdRsxMND+K75wE9pMqG7hZA8
 tNeRj/XNZpXePuOqSPwCH3iwyK5x0Wo9aAprGKHi8Hr6r7pVRV6mxsNRyAxkTcaKejUW
 gS0+bdZ65c+EKXm2yqxu1/V1H/H75uK+xCj3zzgvZi6jbtZ2fEz9hdkV77xKXrNvS6U4
 Dr6JgbfvG55yU5fXjO4+r4cxP9cJG3elNVDpiXEY0M7NhXYtv7hD6yEBmC9ovCxl48VY
 B4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765391823; x=1765996623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBVLNLzh2h7x+zlFBYT2iI+TEnUQJ8dUS09XaPFchj4=;
 b=wQZxvyksI0BS2G1hAf4uSnWjh2c7hl8q1AvJYazs/o39terfdkwLpuk5blTyeo8vsT
 23Jq+DAtfKJkoJRM8xlWeg+wizF/kWri817U3Jfoi92nd9jdOPP+TjfgbRWNFWOocsd4
 ZdRV695p6INLkUTFtQ+V8O23eZb6DjKNbweewRKVNY5jrTPHt1yvD3UgjslI3AlPEwzI
 fVC0goPYM5M4qkR+PbLGkPkn4RNHb01L5wXxu+OaIAW3ofUenazAf4D56ip0OlcXAcdq
 zlNC2XxayrsLbAP9T1/I3myckixDMjqYFmpQj6qIM8NGlO7tL4Zlr/JhpJnTXrkxlM8s
 SF0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc3bXkjJpx1u4chOg/MqcNkBnE5M/LpH19rZPJL+foNKUspgn72X4OYF7ES+sAxdg/eho280J6CjeZ@nongnu.org
X-Gm-Message-State: AOJu0YyhgEvuhrmrpB0zBMWmJVVyuT9S/7pMjwkLzzEFbHIMcJMM3f2i
 Imdt7wv38/0Rgd4Y4jrHv/d+X0kK83Mp1CErW6XrPV2SVFG4MHE8w5OLafl67gIof0s=
X-Gm-Gg: AY/fxX4Mp0s1wOl4aFW8kgRlNHTeABiZtGZEIwKgXlOjm6XRfCTFhdyfH2oGjyLri6o
 xwiB7+XAvJzsD5tf5Ml2aZbtscjsPdDKjdDdQLnvTnLqY4/1J+a0QSWn6ofQw8Abm5yp0kntcCa
 aodC2VVcM6Go3ZYkWTF6b56poKqSywqe2wX2YU5KYJ9fvhjSaK/aiEO8XdlFBPnX1aomcqJZDHE
 1UPbW/cXntG17Bk5lBe66tHrWNMn1tWwMeP5el6+PbBtcgwANgZaI9wj5xpegD5LZ0bKwjVfyVw
 g/A7pUIQ0RJ2+NSMVg7+/TufhhMyVVkBLtJUzDZzlw+9JnDnd1sOyI8KEA5wkAppQ/J0SwKGcWS
 jyCkqwTR/zwUB/pqi2WHRkDWZPkjv1r9/vjXzDM6EvT5sYXMWp0oW2xRn7nqipt9UsiI84O4CZE
 ocNNPK9RfDwuPIgiNT
X-Google-Smtp-Source: AGHT+IHGOwdWq9kScrnFx6XVXxXDXDMCl1pCnbxGkGhRFLFbQeqxl3pEFav3ZApMoEBCDV+OuI2CNg==
X-Received: by 2002:a05:6000:208a:b0:42b:53ad:bbfa with SMTP id
 ffacd0b85a97d-42fa3b0651fmr4138323f8f.53.1765391823206; 
 Wed, 10 Dec 2025 10:37:03 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a7044csm477702f8f.15.2025.12.10.10.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 10:37:02 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 0/7] hw/arm/omap: Remove omap_badwidth_* functions
Date: Wed, 10 Dec 2025 18:36:53 +0000
Message-ID: <20251210183700.3446237-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width. They do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap_badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

At this point it is unclear what the original intention was in feeding
these bad accesses back into the memory system.  Rather than trying to
make them do that again, this series replaces them with open-coded
calls to qemu_log_mask() and RAZ/WI behaviour, and then removes
the implementations.

The benefit of this is that we remove a callsite of
cpu_physical_memory_read/write that was doing something badly
wrong anyway.

thanks
-- PMM

Peter Maydell (7):
  hw/sd/omap_mmc: Remove omap_badwidth_* calls
  hw/i2c/omap_i2c: Remove omap_badwidth_* calls
  hw/gpio/omap_gpio: Remove omap_badwidth_* calls
  hw/dma/omap_dma: Remove omap_badwidth_* calls
  hw/arm/omap1: Remove omap_badwidth_read* calls
  hw/arm/omap1: Remove omap_badwidth_write* calls
  hw/arm/omap1: Remove omap_badwidth_* implementations

 include/hw/arm/omap.h |  10 ---
 hw/arm/omap1.c        | 203 +++++++++++++++++++++---------------------
 hw/dma/omap_dma.c     |   7 +-
 hw/gpio/omap_gpio.c   |   7 +-
 hw/i2c/omap_i2c.c     |   7 +-
 hw/sd/omap_mmc.c      |   7 +-
 6 files changed, 122 insertions(+), 119 deletions(-)

-- 
2.43.0


