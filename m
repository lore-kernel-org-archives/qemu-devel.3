Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1C4C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weOYm-0004Ql-1S; Mon, 29 Jun 2026 22:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOYl-0004QJ-4N
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:51 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOYj-0002Yu-JX
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:50 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-37fdee9276fso1767563a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 19:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787848; x=1783392648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lwF06D+I4bZjzRk++w+Ob4Vd+Sjoyc0NQBk/zUwQ/OU=;
 b=awoUGpwj/oVW6NnmIyQ/oP2p+gpU/mAWCGGGoWCGwCO5HIYKCXIh3bXJSE9cfgu5iY
 8YgRx6qx3y8nEBnbhdXEo8IJ20Z0+HOabLcOJbZqnJRVxvaUl3bZiFd0Rt6hk2rWoC70
 WJfkb9hbf65o+POoHQw1gVKxIoCp/URQuUyb01rFcyu9fvALSE5oe9/Ym34weVr8El6/
 0ARuLrFsc+pba87QHnrAAjthk//v4a5Ue0W/jdXRY5iTZU0T5Lr9wXXKeZmGGpYQGiq5
 Sgj3fjkb7jEPa4mT7DvNxjvgKUOjHwG2BEzTboGSw/UzQ0VdbYhad7I1DPW8WBwUWisC
 ChZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787848; x=1783392648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lwF06D+I4bZjzRk++w+Ob4Vd+Sjoyc0NQBk/zUwQ/OU=;
 b=nVXi4Jr2zEi+jKvuJzCfs4P99Agn2ZAchlcZ66eYWb385kdGJqWgL3lbhtFsH3tl6F
 qqMW9du3cvpC4Nztx4X98QrrE2ovOV+ROISb6TwPgxzLfWlHEvzlmWbW2ut1BIqbb8Mb
 jVAxsp5c61Ju9na8KmapuaGYbsuC5ra/QEnb/lRrbKkchyyoWS6K5Ysyqnm9iiX60HFA
 qv3zWS5uZvR2hwY9ZakNdould+iUTiTDONQhK33tuSJHhd5l1xdocnK458MkK37Jcvex
 I3YEuVNrQprNLvJn1BcEwvYNpv6bOEds1PCvueYbehr8nF0cOEl+27gfMcNk2QYNtKId
 4agA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMstSbywVO5ljRiruCGPg0U5lYeFFk7j4bafrX8/OcJbEi5a55QXszoXLhQWO3wlw4jkmDZ0E3CcrB@nongnu.org
X-Gm-Message-State: AOJu0YwMw0JrWVsKIekKS2uU2DCSirqFt33oBnpjalpK3OQbiYRDrGP5
 SWyqLp3jIs9HeLs/OdgwDIcGAHyO2YZC+hFj32tyn+wACGBBC59Dcknh
X-Gm-Gg: AfdE7cmWuoZUIQ03TpAnya64rDMntCYA3c0f4W9l15WHSsayCMqw007q5bh6iHbNBaG
 GEnbIfkhncRXcF5cQcS/jKcByzRIES34AFmtwSQ9x2mCZRTUddPspTCP+OPN1CP7zPsQqBfYjMO
 g/ZypcqmV4Bo6zGFopceX9/olHQc4sKTTQBl8D1R20wVcJBZTw5kYGJQp7hOqu4qreRekbEYQcu
 Gb7wtBOlS6g0uJI6bkzInisAoMfO1TU06bi2SOWonxrHYUbSXWXqSI2K0dc3ty6w/Jf57JOefbN
 3xHVdtbYE360gfQ40+ztct1kuqbuvuHaOD7ziTG7rGxrO1s+mmxX0v2Xj5qzcaDwFK9AO+njJPF
 ySQJ3jsetMGowY/W7RkfXKE503PkjJuHx1OGVZ0wwcnZxXWYz3D4ELslaOulxUD7ubt56DQW88t
 S71gxHhQ2iwBOuC5N+0S5mXilkpSuNiYnFGuoOKTP+z2muLUmt316qGiZNohmp7X9NuTT17wD+h
 OjYGJZlMN0J4g9aU9B5DU+JLtx1Lh4sxz9su7s96yA=
X-Received: by 2002:a17:90a:ec87:b0:37f:b91d:89c5 with SMTP id
 98e67ed59e1d1-38052757198mr1212122a91.19.1782787848331; 
 Mon, 29 Jun 2026 19:50:48 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32661sm704545a91.9.2026.06.29.19.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:50:47 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v10 08/12] hw/riscv/atlantis: Ensure OpenSBI has a non-zero
 next_addr
Date: Tue, 30 Jun 2026 12:19:46 +0930
Message-ID: <20260630024952.1520546-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630024952.1520546-1-joel@jms.id.au>
References: <20260630024952.1520546-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
to print any output, as it hits an error early on
in the boot process and gets stuck in `sbi_hart_hang()`.

The error occurs in the `sanitize_domain()` function inside OpenSBI.
`sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a generic
coverall S-Mode RWX memory region are created. `sanitize_domain()` is
checking that the next address is executable.

If no next address is provided (which occurs on QEMU with an empty payload),
then `dom->next_addr` will be 0. On most RISC-V boards address 0 will fall
inside the coverall S-Mode RWX memory region and pass this check. On
Atlantis the OpenSBI firmware is running at address 0, so this address
falls inside the M-Mode only OpenSBI firmware region and fails the check.

Once the check has failed OpenSBI aborts and the user doesn't see any
messages. This can be fixed by either supplying a payload, or just
manually forcing a non-zero address (actually just any address that
isn't the OpenSBI firmware) for next_addr.

This patch ensures that if no kernel is loaded we still specify a
default kernel_entry so that OpenSBI happily boots and jumps to
the first address in memory.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1f0cd08ac959..d4fa9c251d3b 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -377,8 +377,16 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
+        kernel_entry = boot_info.image_low_addr;
+    } else {
+        /* If we aren't loading a payload, OpenSBI thinks we are trying to boot
+         * address 0, which fails `sbi_domain_check_addr()` as that is where
+         * OpenSBI is running. Instead point OpenSBI to the end of the region
+         * where it was loaded, which avoids the early hang, allowing the
+         * system to proceed with the OpenSBI boot output.
+         */
+        kernel_entry = kernel_start_addr;
     }
-    kernel_entry = boot_info.image_low_addr;
 
     fdt_load_addr = riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].base,
                                            s->memmap[TT_ATL_DDR_LO].size,
-- 
2.47.3


