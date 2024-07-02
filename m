Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B2C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfdB-00051f-20; Tue, 02 Jul 2024 11:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOfd0-0004vP-5c; Tue, 02 Jul 2024 11:41:11 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sOfcy-0001U4-5b; Tue, 02 Jul 2024 11:41:09 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ee7885ac1cso7667441fa.1; 
 Tue, 02 Jul 2024 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719934866; x=1720539666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zlsYGxOBAA6aPqp1UDFvjA499Ut0I1N9iQ293R9omT8=;
 b=WkZIeTc2yYVNkUgeluJGdEenTsQH6vf4D/5zLWmkaeNeFZIosTmiG2kvkAbcU8N5hC
 9iZBo5vk6eL2YKZWVsTnFxW+YUMlUXiiZjaGXUN21L0+HmSbNBz98fAMpGOlpT9bT0FH
 5J4HZwJulQhzZz8hT62hX6ktCx08GU1J2faxhaRQ9Dkvuy2R/6bz+kiDEGp8CSNbnAgL
 py0siOzzD4Jg+DpwVx7G7DpeFFqLvGcnKIyC5kDBsI/jy4PiecBhFDm5wcv7yb27mEAe
 UlbX6Q/SffAGhkBHVox6eI4kO6Ir0a1WEd1FfQHfOoCKWSu3WSkOXTT4WM9X42NT4m7P
 WolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934866; x=1720539666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zlsYGxOBAA6aPqp1UDFvjA499Ut0I1N9iQ293R9omT8=;
 b=SPCB/OxsQAnLq5Ds4WSfqUS7fQnFnh28UjJ/prUMOooVS6k0ZyGZO9U+hmtHUaVRDI
 c/nt+ZFo89ke7hW2sX/HcOZSevU2iVcBzeIkVHjxh7DruAA8p6GfQnUVxajFAxVqCiyL
 Q6HhcZzqO1GC6czvqwrpytVgx4W1YHLA8YnJJELZB3gMLp/DdwF1C2nlFLyIGrpt5TG6
 chDYhhLlRiJyDcKKvqQc1EmuGxBlvxD4BOktmwu8d4Iy7j2vypnAsxJ1AKWslQ2vMSQb
 CRl03BWdfmCrb8QXIou6cPKCdGnqSzAjv7+F0Io9IBykAweNW7uHPkB+IlRkoWfvxOtN
 zFjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU94fjA4SUGrSJXSCmhfdIMQwvuZHYyb8ZseZCBjvMv3j0R1RSl1P4K4cawAAbzAUUrPAuZS9idxdCmpQMib7ozYsrzFTAVQtj0D3qRK8qn/P21EthCNqPi6oA=
X-Gm-Message-State: AOJu0YyYS4r09VtskgC28tSnGWZ/4ByjUOgXPesXfqszd2WITl+4Oyyy
 Pidqu9ZmKclWOoCacO09a+iDbLjfmtMMGVaSJ2zmwWYHMeLidhw=
X-Google-Smtp-Source: AGHT+IHyRJKTlb42+0zLVN1xnholb3NBQOYwUglXEymC/ajMDCBk705K531X96sVDEXUof0bygjyTw==
X-Received: by 2002:a05:651c:244:b0:2ee:7255:5048 with SMTP id
 38308e7fff4ca-2ee7255542dmr30379251fa.48.1719934865548; 
 Tue, 02 Jul 2024 08:41:05 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fbbd4sm13617467f8f.84.2024.07.02.08.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 08:41:05 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/misc/bcm2835_thermal: Fix access size handling in
 bcm2835_thermal_ops
Date: Tue,  2 Jul 2024 17:40:41 +0200
Message-Id: <20240702154042.3018932-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=zheyuma97@gmail.com; helo=mail-lj1-x233.google.com
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

The current implementation of bcm2835_thermal_ops sets
impl.max_access_size and valid.min_access_size to 4, but leaves
impl.min_access_size and valid.max_access_size unset, defaulting to 1.
This causes issues when the memory system is presented with an access
of size 2 at an offset of 3, leading to an attempt to synthesize it as
a pair of byte accesses at offsets 3 and 4, which trips an assert.

Additionally, the lack of valid.max_access_size setting causes another
issue: the memory system tries to synthesize a read using a 4-byte
access at offset 3 even though the device doesn't allow unaligned
accesses.

This patch addresses these issues by explicitly setting both
impl.min_access_size and valid.max_access_size to 4, ensuring proper
handling of access sizes.

Error log:
ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
Bail out! ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
Aborted

Reproducer:
cat << EOF | qemu-system-aarch64 -display \
none -machine accel=qtest, -m 512M -machine raspi3b -m 1G -qtest stdio
readw 0x3f212003
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
- Added .valid.min_access_size and .valid.max_access_size settings
  to ensure proper handling of valid access sizes.
---
 hw/misc/bcm2835_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/bcm2835_thermal.c b/hw/misc/bcm2835_thermal.c
index ee7816b8a5..0c49c088a7 100644
--- a/hw/misc/bcm2835_thermal.c
+++ b/hw/misc/bcm2835_thermal.c
@@ -80,8 +80,10 @@ static void bcm2835_thermal_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps bcm2835_thermal_ops = {
     .read = bcm2835_thermal_read,
     .write = bcm2835_thermal_write,
+    .impl.min_access_size = 4,
     .impl.max_access_size = 4,
     .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.34.1


