Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE06FCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTI7-0006E7-7G; Mon, 24 Nov 2025 04:55:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTFH-0004Yn-L7
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTFG-0001fa-5Z
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:31 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-429c4c65485so3314010f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977947; x=1764582747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfavX6TO9pU3VMuLQhftw12r96pog3aSJ1S/um/Jk24=;
 b=BUR1zZiecFaPXNx2/nu/CMKHmESeX5V80arsokB0WqetNxNU4YtC6CHxcVFvacVrrs
 mlz2K+lHewRJAGkrQAkrudg+QYoVS9Yk4OnYfJ2wQ+RYRwn9rUaguNp4FoNbplJIPeNf
 yCEQmjFi9kECq1dWpRxsg8hhOw33u2Ws3dRhbas8Szcf1r2vRQFy5RgvONguhMG+U/m6
 TM7DWkbuP4D71y0h4ePZY+IqNANEYSrW5G/5EinTqFWUFvrihUf9QXTNQI8DwRXdSIPv
 r7rXhKin0SuynS8X6F4D3qvmgnKcVe9+G6/2k0DATASeLRsQC0h4zKp4TnQsPuWxDjo6
 c4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977947; x=1764582747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cfavX6TO9pU3VMuLQhftw12r96pog3aSJ1S/um/Jk24=;
 b=vEW08a2+8D0svomEB0joZlt4apsKGZge7MLZ+/PinizGpoTNJlvMmTMFYMt6Z8Px/F
 Pif1e+qY6zVKDok0QflYcb5SFIW1K/q0Gg7BPEVTe4MO3yOnV2ZJlGmK957fkJ5h4oZt
 i3zIv9wDzm9XkxRC087vntiuWuQ3dH0D/3HjqpvA8930lBicfCU472+GWQDmEnJPkATs
 jy43SUCKJGLsTZoFDSr5P70EsGiqiRxdd2hXua+pOBkkKsXlqcesqw8z8n+gpscyfe3X
 q926V6MVlUYYYFR8/0plbZkTN5mdEZX1aK7k9JltVrjmXr0y9EOHJDFLYmlCwLB9fgCt
 Llug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9DTBPMCmbtZmP93eLSfG1b3ZdP93RKFynqdi92d0hbRhAjIqueVKdiGIEFpgVenj8lX4LjENJOZhR@nongnu.org
X-Gm-Message-State: AOJu0Yw0qTEdFW9rRUkU9wDq8WoUMRfN5QCL3I5sD63WcCDe0MDAqmJg
 DCFpGZ8Q0Pqg5lI8ySXNiA0lJ3VEZ5UwM5EPQhKHywpWDeY2xaTXm5n1A2igjTAWMpI=
X-Gm-Gg: ASbGnctxrDGWoJdGuJj4ZMYQ2yth09zf/GZpM4OIsoiCPyuMalcxBYV57CqwIlfawwT
 9CFMNi+IQewAAKw5hD0TKTQ0f6rOsxvEmMNBUgDLSgbpRXAC57VAmWgyNeqNigv2ub05PZacokt
 5oNM3wk0dO4Nw16GFOybmdCSKXmiGrJ/KqTX9ZJAOkqNGIKJFwgt1MfuzABEw2d889VgsLJMHF4
 Pxx8lID5Q4Fe+A1/Imjf2sC1diMWVEpX7acC/103P5RA6A+rWJyIMU1I0ZRlEvr6Af8DVV6Mew1
 lvatsFScvhuTN1HeNfozOoB+ZQWjQjdOopQ4fK6sTW9iQfCW4wnciGMFoEi/sUgDDMyYehBH9Qy
 WHdqTfhM+qyKaUrD13KdFL24Tz1Km1upFhGX+hhAx/WKaGlqVefCfD65xhM6XgBPGu/hioPnwrx
 dPxFnHiOEFsChZsLHv+4kYS/lXX5DoXRU4DKRVG7u77CwCa5rGnOoJRX5zVJy6X8GLjoWTmIA=
X-Google-Smtp-Source: AGHT+IFCu5zlr4hfRhVhgV2uop5oXMZUZNpvhimMpzDACj1DHGdTUBWVYxyIxUqMyv21WJrwnLglcg==
X-Received: by 2002:a05:6000:18a8:b0:42b:5521:31ad with SMTP id
 ffacd0b85a97d-42cc1d51b1fmr10303636f8f.49.1763977947524; 
 Mon, 24 Nov 2025 01:52:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e432sm26877510f8f.9.2025.11.24.01.52.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:52:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 11/13] hw/sh4/r2d: Use EXT_CS_BASE() macro for pseudo
 ISA bus
Date: Mon, 24 Nov 2025 10:51:06 +0100
Message-ID: <20251124095109.66091-12-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 75878abe946..df62f7a48a9 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -255,6 +255,7 @@ static void r2d_init(MachineState *machine)
     const hwaddr flash_base = EXT_CS_BASE(0);
     const hwaddr fpga_base = EXT_CS_BASE(1);
     const hwaddr sm501_base = EXT_CS_BASE(4);
+    const hwaddr isa_base = EXT_CS_BASE(5);
     hwaddr sdram_base;
     uint64_t sdram_size = machine->ram_size;
 
@@ -310,8 +311,8 @@ static void r2d_init(MachineState *machine)
     sysbus_connect_irq(busdev, 0, &fpga->irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
     sysbus_realize_and_unref(busdev, &error_fatal);
-    sysbus_mmio_map(busdev, 0, 0x14001000);
-    sysbus_mmio_map(busdev, 1, 0x1400080c);
+    sysbus_mmio_map(busdev, 0, isa_base + 0x1000);
+    sysbus_mmio_map(busdev, 1, isa_base + 0x080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
 
     /*
-- 
2.51.0


