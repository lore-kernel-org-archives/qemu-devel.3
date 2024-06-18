Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99002C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJagh-00089G-MM; Tue, 18 Jun 2024 11:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJagd-00088Z-Oo; Tue, 18 Jun 2024 11:23:55 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJaga-0000Ke-Sw; Tue, 18 Jun 2024 11:23:54 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57d06101d76so242569a12.3; 
 Tue, 18 Jun 2024 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718724231; x=1719329031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/uBHlNgBwmPP4HqMSmFwFH4dWkgYw0I0gpooRc/762U=;
 b=eD9Xi5qQt//ZLtApqBF6IlBE1alAFZqwsloCETx+5xdU3RWn2QoSpvIGvvSkHASaUz
 Wc6T9VDw4W6xER/235GivkCqKTX+355XONq4LAVVRSWilu+ZmEuoB+KoCzdO+UHOywr/
 TeAAl/pjhvLlUylkhzlgcWkVdSGN4yyNGCxxa/Zpu0u2oDKwNCshMSY3SvVGDRqvzl+o
 HfAi/6iAts0pScvOIFPariFIiOhky0B5KLYSm7U4FWlT8lBeS2WfwosVawPNnom4056S
 yiJ6Bz4kd+b7V3kPYeW0BOMSoNbEhHJ6xeDDDsrbFv8gdR0ScC5kufOyQrPyOOc7I89A
 S/SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718724231; x=1719329031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/uBHlNgBwmPP4HqMSmFwFH4dWkgYw0I0gpooRc/762U=;
 b=vHSnldSNBoXYBA4+ZAEZ5X+E0I1zhu8NIRuuCZrCN0830sJt2S+CLPARrmNmqZxg2D
 HMNR2O54dbJaYDWJTc1rRm/E7B+EVbMv8lwwXpokXa27KMmHaJfadXgxtzCmrSGBqseX
 k4BLe1nMcmGEaoIkPGmZlrf4ESGxybcBsfgeZuz0WH0iAYJ6hIEHVDjuopqNLcilmtl/
 sIH4z/UM2/PWCqPndkDhGqWIP4W3uPz4o3/fsapOvjaWp03zxYUJUSfKzLGWnY8jhZ0F
 ARFZLUI/txQJAeYDKbIxWUTpootqszPV4bBKMuEZHCr3sEqhPNVIPahS5UUAmkDqS5ys
 KVcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhtWjaMtHvPPacfzA72wL5SXc0yaoAG4yAnXXPUDwmxzHwiS36yegkLDABccRplXri1ukRDogdajT2Ea2XI7jAbuA4nbwa06kWFRxTWJaWkLjhERIDTeDURb6dlw==
X-Gm-Message-State: AOJu0Yxio3QPOPr8WZ+ax3oyANWG6H1QldO+IEHrHLXL3ygMWmrMA6Su
 qI38WdcETva2GhrinTmS7Kcyg+wIQd+wZwFG0eENPGkp2XBdnas=
X-Google-Smtp-Source: AGHT+IGGAgo+I0uUsmOiE39A0Ij2Q/wrs3bpJ0N42P58XlcEEN8+v/zaPN6CZTEk8mW9WhmHuMuVPQ==
X-Received: by 2002:a50:9f2f:0:b0:57c:abf9:e6ad with SMTP id
 4fb4d7f45d1cf-57cbd6a6ea7mr7473062a12.42.1718724230742; 
 Tue, 18 Jun 2024 08:23:50 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cfa753136sm954805a12.34.2024.06.18.08.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:23:50 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] block: m25p80: Fix heap-buffer-overflow in flash_erase
 function
Date: Tue, 18 Jun 2024 17:23:28 +0200
Message-Id: <20240618152328.3163680-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zheyuma97@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch fixes a heap-buffer-overflow issue in the flash_erase function
of the m25p80 flash memory emulation. The overflow occurs when the
combination of offset and length exceeds the allocated memory for the
storage. The patch adds a check to ensure that the erase length does not
exceed the storage size and adjusts the length accordingly if necessary.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine kudo-bmc -qtest stdio
writeq 0xc0000010 0x6
writel 0xc000000c 0x9
writeq 0xc0000010 0xf27f9412
writeq 0xc000000f 0x2b5cdc26
writeq 0xc000000c 0xffffffffffffffff
writeq 0xc000000c 0xffffffffffffffff
writeq 0xc000000c 0xffffffffffffffff
writel 0xc000000c 0x9
writeq 0xc000000c 0x9
EOF

ASan log:
==2614308==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7fffaa155900 sp 0x7fffaa1550c8
WRITE of size 65536 at 0x7fd3fb7fc000 thread T0
    #0 0x55aa77a442db in __asan_memset llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:26:3
    #1 0x55aa77e7e6b3 in flash_erase hw/block/m25p80.c:631:5
    #2 0x55aa77e6f8b1 in complete_collecting_data hw/block/m25p80.c:773:9
    #3 0x55aa77e6aaa9 in m25p80_transfer8 hw/block/m25p80.c:1550:13
    #4 0x55aa78e9a691 in ssi_transfer_raw_default hw/ssi/ssi.c:92:16
    #5 0x55aa78e996c0 in ssi_transfer hw/ssi/ssi.c:165:14
    #6 0x55aa78e8d76a in npcm7xx_fiu_uma_transaction hw/ssi/npcm7xx_fiu.c:336:9
    #7 0x55aa78e8be4b in npcm7xx_fiu_ctrl_write hw/ssi/npcm7xx_fiu.c:428:13

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/block/m25p80.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 8dec134832..e9a59f6616 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset, FlashCMD cmd)
         abort();
     }
 
+    if (offset + len > s->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "M25P80: Erase exceeds storage size, adjusting length\n");
+        len = s->size - offset;
+    }
+
     trace_m25p80_flash_erase(s, offset, len);
 
     if ((s->pi->flags & capa_to_assert) != capa_to_assert) {
-- 
2.34.1


