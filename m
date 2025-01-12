Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DEBE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6It-0001WE-DN; Sun, 12 Jan 2025 17:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ia-00015V-4J
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:13 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6IY-0006W6-Cg
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:11 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1885100f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720348; x=1737325148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tapoh0/SBib6qRzr75O/lv4A8ahdf/FQ6/7pfjWt9KU=;
 b=vaYNeKuBclEElUtoZsb3ebh/ZGLR5GtZ94g5ocEF1X+BmGuoxGYzXYLW2d3YHVjuVJ
 j4oY0hsBgEtADtcqxc7/gy8hsde5TRHW1voRenxROOc31tQhK3vCwdE4cpaZnKLqxuOW
 pcH/AGMOtlX/0IN0cYZCUk/jniSafmxx4Fjv/6LJUnCBw1mMv+bQxzZzkPzW0YKw6mRO
 6+le5znRi6rD2vXA0xtAfa849meCXaVplEXfxwi/MZKPRwFG8VZ6I59en4AZohiQwGMg
 1GIYudEylnAIQJ5uV6swxT09/t3e5eyJjyzFscG0wjdTkB5s2J9Yoc9TDcEjz+ZLbxjA
 sKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720348; x=1737325148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tapoh0/SBib6qRzr75O/lv4A8ahdf/FQ6/7pfjWt9KU=;
 b=M/WIeKM6PdZ22aUIp4SPAuavGEgPZ7b1HA7HYzKPQvWcA6XhgbHLkWr1dbDD6ti4ft
 LTkM3MWhzbPdhIwhMEDnoPiGlzPgKqXd8Dhr4tQoRaGEbzH7/qOzK4msIJZBSUj1E7ok
 pgFhM/appAxDzYil1mwnsswQXFQ0dnIWttYvlCdjXyBKcS2HaUHiYMHJZ87sQ36ZT9Pc
 hW66uzJrjjQKb8+619rPCB0ogcyR3Wxom/q2LYtCajV2eKyF8m/5GYbXdLQ/G23i8oJe
 BsyZLtGo9I4nQ43um+N/BviAmwFYgEeHnIOYw/wNXEdBIjGovpl3ojJnBWHuEr4xOTdU
 B8cw==
X-Gm-Message-State: AOJu0YwC48XmvtTF38MSLKbK3GgJY2bQCb+2dMiM/DKqQRtd2zkb/T4d
 OI8NW15c/D2SRcsRhijrW4b+6jzKEts0uNK9MfecmFyRJngF1hP18t6c2uPmm1vjwRTMPeqw7b1
 bym0=
X-Gm-Gg: ASbGncubWKqgex/ssPIQnepJl/XYdxG9N4KSQwW5+qglkK08tiJ9yobo617a221ETwY
 lF3oagVV+XoVk+PKTpaNIxGlN9qqGwSUSNX9AOCxvc0rhpJ0G9yk3gY7Ohj2y2TIYaixvr8tBFK
 tjuu3WldwUEoqzxzoxdfp6O53bvjxAtS2LTEC4fzcuZtVaMpaGM4KmdEtfYeYurk1/gP/VchiPA
 tbHOhHNbGcSpiKJu7FAcFpQbF0wp0OOQWdiHUSOmpOxywq8YBT7OnenFI+SvFZhIGBER/OOmCX7
 Kxdl+8W5jBZ7xbyxZ9r2n6qTTMFD33U=
X-Google-Smtp-Source: AGHT+IEqmlXPfoICnA10Tw/L6zohN7g3/t75UtGhOMpnJsjQ1uqdY0F06FFhLsxTzg/KydLNwZVEAw==
X-Received: by 2002:a05:6000:1acc:b0:385:db39:2cf with SMTP id
 ffacd0b85a97d-38a872c943fmr14867664f8f.12.1736720348565; 
 Sun, 12 Jan 2025 14:19:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e384f2bsm10503500f8f.41.2025.01.12.14.19.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 20/49] hw/net/xilinx_ethlite: Map RESERVED I/O as unimplemented
Date: Sun, 12 Jan 2025 23:16:56 +0100
Message-ID: <20250112221726.30206-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In order to track access to reserved I/O space, use yet
another UnimplementedDevice covering the whole device
memory range. Mapped with lower priority (-1).

The memory flat view becomes:

  (qemu) info mtree -f
  FlatView #0
   Root memory region: system
    0000000081000000-00000000810007e3 (prio 0, ram): ethlite.tx[0]buf
    00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
    00000000810007f4-00000000810007ff (prio 0, i/o): ethlite.tx[0]io
    0000000081000800-0000000081000fe3 (prio 0, ram): ethlite.tx[1]buf
    0000000081000fe4-0000000081000ff3 (prio -1, i/o): ethlite.reserved @0000000000000fe4
    0000000081000ff4-0000000081000fff (prio 0, i/o): ethlite.tx[1]io
    0000000081001000-00000000810017e3 (prio 0, ram): ethlite.rx[0]buf
    00000000810017e4-00000000810017fb (prio -1, i/o): ethlite.reserved @00000000000017e4
    00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
    0000000081001800-0000000081001fe3 (prio 0, ram): ethlite.rx[1]buf
    0000000081001fe4-0000000081001ffb (prio -1, i/o): ethlite.reserved @0000000000001fe4
    0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241114210010.34502-20-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index a7f6d1b368c..14bf2b2e17a 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -94,6 +94,7 @@ struct XlnxXpsEthLite
     uint32_t c_rx_pingpong;
     unsigned int port_index; /* dual port RAM index */
 
+    UnimplementedDeviceState rsvd;
     UnimplementedDeviceState mdio;
     XlnxXpsEthLitePort port[2];
 };
@@ -303,6 +304,16 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
     memory_region_init(&s->container, OBJECT(dev),
                        "xlnx.xps-ethernetlite", 0x2000);
 
+    object_initialize_child(OBJECT(dev), "ethlite.reserved", &s->rsvd,
+                            TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(&s->rsvd), "name", "ethlite.reserved");
+    qdev_prop_set_uint64(DEVICE(&s->rsvd), "size",
+                         memory_region_size(&s->container));
+    sysbus_realize(SYS_BUS_DEVICE(&s->rsvd), &error_fatal);
+    memory_region_add_subregion_overlap(&s->container, 0,
+                           sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rsvd), 0),
+                           -1);
+
     object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
                             TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
-- 
2.47.1


