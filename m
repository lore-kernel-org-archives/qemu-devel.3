Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B32DC282D0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp382-0008AR-BW; Mon, 03 Mar 2025 05:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37k-000883-CT; Mon, 03 Mar 2025 05:34:13 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp37i-000759-5B; Mon, 03 Mar 2025 05:34:11 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fec3176ef3so3604869a91.1; 
 Mon, 03 Mar 2025 02:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998047; x=1741602847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UQKzoLuwONsbaEu158SgYPwvJWZ2tKwKB1uMOLot0VM=;
 b=Ke8e1/m+yFgqC0Mz5YT32uyUu1X+YsVJ3sYR++8H66QhG7/veTRkoUCiMDNebhW/6t
 v67/TYIpcyqcwssrgA7/3FIgARjHuGd7iqMxCBtfkMW1odoSPxSPOqlOcDfPKkiTDBT2
 8tjqPCr49qGTeGvNMya5IQkzq4GKilZFiln6QDkedcQxyhaMBOBfEAND2WmKOMybNS/t
 U/Z0YU1mbimV2OSk/eEbWoHlWGweiK+EZ10MaDCQLB2gdcg+lqY9fMLbkttIw4ksrBME
 6QBqHR3Z2QGcCKmklQ5MwJNrgUVfAuP15VjGYk4aYWaz0jsEnHx7Vru3MTgoxFBmUCwe
 xYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998047; x=1741602847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQKzoLuwONsbaEu158SgYPwvJWZ2tKwKB1uMOLot0VM=;
 b=uUwvHf4E8VIgQEn3n3TeLEZkjd+mXTp8LAGWIzqgG4xodb2R0TCn3JBzWZQCO8GIWE
 SK7UJmfPYHGyKrRnZdvFDaFHaMPjaLLdlDjNN4cLhSg2wvFiKsEx77jAV7LKbWLA/t/b
 S1PJRzjYv6p0g9gpHM1X5RfeL5hnAZZ0JGJZ0OjkfRvdEIVqUIaoQwzef2hlqAw//uck
 ycfukt43kzCBZvrURV7Z7UiaRSBiPqSM/gtG7uPEOojMsG1fiVoRKZRku/HdvOSLczhX
 GFZJcky6sKKD9ddSqKSO8KMqS+GpVfjX3EK5SNsoM1MlQiFlpLcu5yXY/8W/lggUexXc
 G3jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk35AnKK6yYaAdmyDC5tFWWxzJpCqaw9kTp50WhhR8TkmUmPZDO2yN8CR188Y8xJ57982hsQGsa5S1@nongnu.org
X-Gm-Message-State: AOJu0Yx33gK2hv28AcUwU39hsoZxFQgYrAcF1c4iGrJoIBujdT8UXDdC
 dgw6sevCjL6/ius38hAJhM2EPn59JpbjEGiGkbr2R1B3iu82AwM3EZaguw==
X-Gm-Gg: ASbGnctsfYXvSk1E3qJLvy3H5cJbNEOkGJ/MX5/1UprG6XCkEdLNw/4/JVd555hdIHs
 vWoxTngnR3uLVhTgajoOPYcw4jxXaVbiclnleb3/i7pW2yodbMUfYTo2dT9utSW0v13SybsKq9l
 xs12l90Rd1cbdmc/gT6YPt0dhOY4B9ckrxvIYmUQTYixAyBN8x61l5nnyr6w3bS/T1tcw/uEEIh
 YS5c2k/2n/yRMaWFelTeYo3+hD9PpMMXtWA/Gcw6Og5maF2N+28ZdwKwQ1L1TtkngRwHUu/aX0P
 tCa1T6ML0wo/TlRurOHYoo+eKlElamCB6tF+vAWRlsM75zhGJrQ=
X-Google-Smtp-Source: AGHT+IFXgnrEzOdCRa1zEK3skiMXvPOWzxtLOO3hVwNttUK8Qb8DfrYAA4+9CzOaWGjWgD/3UT9XFg==
X-Received: by 2002:a17:90b:4a03:b0:2ee:7698:e565 with SMTP id
 98e67ed59e1d1-2febab50fcamr20220746a91.8.1740998045338; 
 Mon, 03 Mar 2025 02:34:05 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea698f309sm8594558a91.42.2025.03.03.02.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:34:04 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 0/6] ppc/pnv: LPC fixes and add nice PNOR image
Date: Mon,  3 Mar 2025 20:33:51 +1000
Message-ID: <20250303103359.578994-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1029.google.com
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

Here a few fixes and improvements I gathered looking at firmware
errors. One is LPC transaction error response, another is problems
addressing the PNOR (skiboot has a bug here too I need to fix),
and another is the lack of a nice properly formatted default
PNOR image.

Thanks,
Nick

Nicholas Piggin (6):
  ppc/pnv: Support LPC host controller irqs other than serirqs
  ppc/pnv: raise no-response errors if an LPC transaction fails
  ppc/pnv: Implement LPC FW address space IDSEL
  ppc/pnv: Move PNOR to offset 0 in the ISA FW space
  ppc/pnv: Add a PNOR address and size sanity checks
  ppc/pnv: Add a default formatted PNOR image

 MAINTAINERS                 |   1 +
 docs/system/ppc/powernv.rst |   7 +++
 include/hw/ppc/pnv_pnor.h   |   6 ++-
 hw/ppc/pnv.c                |  16 ++++++-
 hw/ppc/pnv_bmc.c            |  28 ++++++++++++
 hw/ppc/pnv_lpc.c            |  89 ++++++++++++++++++++----------------
 pc-bios/README              |  13 ++++++
 pc-bios/meson.build         |   1 +
 pc-bios/pnv-pnor.bin        | Bin 0 -> 139264 bytes
 9 files changed, 119 insertions(+), 42 deletions(-)
 create mode 100644 pc-bios/pnv-pnor.bin

-- 
2.47.1


