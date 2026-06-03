Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E9ECD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfZW-0003wK-BF; Wed, 03 Jun 2026 02:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfZV-0003w4-AL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:25 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfZT-000683-8Y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:25 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso5628097a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780469962; x=1781074762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58LAzm/e1KCJqi5R0CKTCeU65PCJcJsIuIaEq/eXBzE=;
 b=LKeaPgh5JrHQY+HjYa6HveMvvgH0ZTD27n5eFhC6bkimuuo4HsE4ToxHa8/f2VuyXz
 WFwq6tBuKDyTVsuL/0NjolUiHsOoznoTK7OOMpVMKU7dUKozLAcW+h6pCRNmlE5pDC16
 9R9bzef2VT2QBB55Dux9HuYC9VK+ry3jGL/rG3YUVzYNvb8jNbIEDynTLoBUrwlCW7Ey
 t7sVq/yjKNjBAbbaGO4w6m/gyW1wv+JHbrOAOSjG1hD3fP3T8/unZzqRh0cYxL7J27/h
 KOdibzoCRV6AZa8AAz1ULYXHTHmrPaneFLAqV2AT91R//LhQCJHjWkpUHqPucjfH4TbS
 rqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780469962; x=1781074762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58LAzm/e1KCJqi5R0CKTCeU65PCJcJsIuIaEq/eXBzE=;
 b=FL/M+LrPYX1YGqyRrNDN5rhPJ/U3lir/xDu4GJDHLoRfqguhPph9jg5vgb6PpYw0DS
 wIWQfYCSdF0eEFJNgYfsCK9ECEjqfjbgUKh7Vx+kZVyCPYww14Yk3Aos2eFeFx+DO8HY
 EfkUc+pK/VcOIo8AsyNPXzmU0sal5QbBkSsrSKheVUGV9OG/I6e2r+rrapUYUP0kCGO3
 C05zGGrBuT+JSHGejHcN7M4Dl+6bTiWXidLenwYwDelRJOVacxeTUtb+vr3BpR5BFQgG
 0OcyP2vs2CBX4axqxU7/P0QZeWVdPpxKzGxvDHn+HWBVDeWy2qfJDB+h86HRczXyLZGo
 kC+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/k/WCxwC81NlXDVm6O9kOJFf0hIo6mUGtPiExF29c9IAHSnUDumLZEK5rKGUVZWgnQnhP1+C9Qhrjb@nongnu.org
X-Gm-Message-State: AOJu0Yxx7wCVDyRezF2IHFGMg2Bhjor8FBVB3l0z2HOjAB86rT/gqblN
 QcHTt6q0WInuThMVNMMxJ5hHi7FrppMa+2EtJcJFkXfUKAOq/xRC2qNa
X-Gm-Gg: Acq92OHaeDoydXoAYogF9Of0BSBG8ndYOR/fT4kGALqwd8E+3upBt1hcf+b4xMepfZm
 r40QQQOk0isvabdWn2z+/E5HWkcaE0nfr4nkYE6X554mwLwW1pvmhhIG7Qfs2jR1Kl3/nu6qOs/
 rmtmfIHo77grc3bFBFgS9m4Iq4ZlDZmDELQJP05PEwMeKrQ9kQGmgOq4lyr4LM0uoZxRNXhz9zU
 WkS2LQ45f7XB3HQPS3zlInn4EjmIiZjeMqLx2VP64K0GRBj6uMgio26wZkZLw9pYXRFgU+m0AQr
 YRFUcdunJ7b+2CvrDEmUQ9k8rCDEpZnfH/tlHI4Kb9wJj2kl2RmUmey/glWd58TDm0bWwN7YRA1
 zJA6Sg8KBHtviRkNtZuAWhSIzbtI/j3IRpYYysrAVzGWJebCY+ijQAF+Le3A9hDY/p4Xwoz3ODW
 U+JAHrlwJ7kDm8/Eai5opvkg61RGRAET9CoihAtTgS7NtDBv4K6cVqzLK1/TXwOptGPciE3xbb+
 ru0DN5JF4v3K3MMFo62ho5htufzczS8ewpg3OxZKC9hIdFOkaRX3VR42EJFrkQo
X-Received: by 2002:a05:6a21:6e88:b0:3b2:924c:567d with SMTP id
 adf61e73a8af0-3b4979438b7mr2327305637.46.1780469962029; 
 Tue, 02 Jun 2026 23:59:22 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.02.23.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 23:59:21 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v8 01/12] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Wed,  3 Jun 2026 16:28:45 +0930
Message-ID: <20260603065859.592063-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102a.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Machines that have discontiguous memory may need to adjust where
firmware and images are loaded at boot. Provide an interface for
machines to describe a discontiguous low/high RAM scheme for this
purpose.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  7 +++++++
 hw/riscv/boot.c         | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca12245..69c99a149613 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -28,6 +28,10 @@
 #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
 
 typedef struct RISCVBootInfo {
+    /* First contiguous RAM region. If size is zero then assume entire RAM */
+    hwaddr ram_low_start;
+    hwaddr ram_low_size;
+
     ssize_t kernel_size;
     hwaddr image_low_addr;
     hwaddr image_high_addr;
@@ -43,6 +47,9 @@ bool riscv_is_32bit(RISCVHartArrayState *harts);
 char *riscv_plic_hart_config_string(int hart_count);
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts);
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr low_start, hwaddr low_size);
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ae2f86c7ceb3..b1a020b58aed 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -69,11 +69,27 @@ char *riscv_plic_hart_config_string(int hart_count)
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
+    info->ram_low_start = 0;
+    info->ram_low_size = 0;
     info->kernel_size = 0;
     info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
+/*
+ * This can be used instead of riscv_boot_info_init() if the machine has
+ * discontiguous physical memory. The low memory range specified will be
+ * used to place firmware images.
+ */
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr low_start, hwaddr low_size)
+{
+    riscv_boot_info_init(info, harts);
+    info->ram_low_start = low_start;
+    info->ram_low_size = low_size;
+}
+
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
-- 
2.47.3


