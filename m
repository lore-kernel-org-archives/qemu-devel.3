Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466C0CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 07:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfa5-0004Nf-MP; Wed, 03 Jun 2026 03:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfa3-0004Kg-TI
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:59 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wUfa2-0006L2-AZ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:59:59 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c8584e80bd3so1686796a12.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 23:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780469997; x=1781074797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E90nf7xW+NKvQAIt+EHSN+RO7M9OYwJYktU2B5LQARo=;
 b=WP9ZJBaEixeoOqQs9YBekSku1YjQUFL8TUGOxt0Ct5XU+FHW1o2CFQmuBFySJqDKFF
 CODHoiHe5nLTZp+tc5UqImEykLX3h/MjjcF9Avb8tz+fIsTvQa7s4qImqbzXz7K4RNe5
 6cQtyS3JuHjwfhzFfqCW6UuEa0dtKBe+6sNd0Kxb7MS5OXoycfmno/ZAV/A18cw5MsGh
 usjc6WTm1D22cL6Ij5px7orbxSaXr61i9sp5kCCcjt6TIYFkXbFPoP7VIj55CO91V1Du
 /Bo+grfxCicinl54zOW93CKPWvHnCBs9xzkL246I//FlNsWcaiqYmwKPKm4FyQiQZf9A
 0sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780469997; x=1781074797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E90nf7xW+NKvQAIt+EHSN+RO7M9OYwJYktU2B5LQARo=;
 b=rbsenR7ZdXcdCirry2MX82oQARIkHS8pRAU4LjUtxsoGUrGR32jr7q+2W3ajU1cX7o
 X70TBHPzfjJy/2dGql4goljgWZsVHQL3zMBrvvK/odZ4HSOYBDydQo3uyyJgGgscD3sX
 TwEtwsNgiM0EMvALYOMtn3FuY/xZLzY/f4ms/79i2XEMebvfNVBkkr2T+dsgWQPgG93c
 oaqCdwPAiVqihqsd5oD1cUpw79Hr5sWQis/0B0a599PC/WnvcVjWtCy4ZsJwA3KEqi+f
 CtsTv718xELYw4XYhabblyJFY2F7LwoqVcCGyFGo09UU9qW5P0+1obhyMeceKv7itqKD
 BjAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Chd3vus4o0vYgp1uHhfs5VE9DEUZ7qpK72t0zhr8PAHPdZPrc4x8U6cecylkdWJ/G9d6Wzzvmx6Ij@nongnu.org
X-Gm-Message-State: AOJu0YxpECuatZox/QOwt82+ehsXe4LIsxu3MYFlts0KyMHVG60ZfE/8
 2jd2DZBNXtJO9yGas7A+/LUvIkRdTI6NVjvInpQFf/1dLqxzPIhVKebH
X-Gm-Gg: Acq92OHSMk47dr3RJNMGrPYbDKl6UfXvMMkjgRqg03JrzfM1SMN1AtJu5QI+OaupG/s
 66QWO1JzlnMmsyeLbWK4MP9SXfAbczuEw4mQHLfSaI0FvXa9q1KBjcLRi46ofX1I6YYyaDhxPMH
 cEJ5Ct+KKLFdyjS0m2nEQ4MIuBatOn4fladuBVC5dJtoB0bvWZDwILFUtDVBSvF0CyIHoRUQ8nv
 W2RzIV6/JO/sU9MBIfDob4IZoElLLwfZpsfQ5e6Jsb+VQdo6P8qMNlZzWAbUwkmW69Y7/fxFTrz
 8LX8Yis5yzO4jH7jMDhJK2VRyqfQL9DQD8BwhTUpuvAeQQaYNP2ZDVuPHYnCblYVVWzr7mpcZD5
 6HN6Z4ySXWuMVSfC4RIptXzPmoyYjeuB4KxXMz5ttzuGUmMgBr/jlfEpdHUyQPbnZxhKp00rn5J
 isCPVsxBLOmtjB37o6QOzIug8avtfYp3dZFZBw7QOdSgKdAJ33ClmBkbX3AqnefiI//pq2uCTIy
 mOelOWekRh5QeiH5gLkzQZQoARrC/iEIToy+NqAbePLIxcAreSQzV1V/TxR3WSQ6H2ihJm5W7s=
X-Received: by 2002:a05:6a21:9090:b0:3b2:86cb:929e with SMTP id
 adf61e73a8af0-3b4978f7fd5mr2425731637.46.1780469996988; 
 Tue, 02 Jun 2026 23:59:56 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm1283261a12.2.2026.06.02.23.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 23:59:56 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 08/12] hw/riscv/atlantis: Provide a simple halting payload
Date: Wed,  3 Jun 2026 16:28:52 +0930
Message-ID: <20260603065859.592063-9-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603065859.592063-1-joel@jms.id.au>
References: <20260603065859.592063-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
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

OpenSBI hangs before any console output if the domain init code sees the
next stage is not in an executable region.

If no kernel payload is provided to QEMU, the next stage address is
NULL, and the riscv virt machine memory map ends up covering the 0
address with the catch all S-mode RWX region and so OpenSBI prints
console messages and does not hang until the next stage boot.

The Tenstorrent Atlantis machine address map has RAM starting at 0 and
it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
tripping the early check and hang.

Add a helper to set up a simple payload that gets OpenSBI messages to
console, until OpenSBI can be fixed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 1ccd7d017c56..5de138578b48 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -413,6 +413,30 @@ static void load_fdt(TTAtlantisState *s)
     create_fdt_memory(s);
 }
 
+/*
+ * This works around a problem with OpenSBI hanging with no console output if
+ * no payload is provided. By chance, machines with memory at 0x80000000 do get
+ * output, but Atlantis memory begins at 0x0 which takes a different OpenSBI
+ * error path.
+ *
+ * This can be removed when OpenSBI is fixed in QEMU.
+ */
+static void tt_atlantis_setup_halting_payload_opensbi_fixup(
+                                        RISCVBootInfo *info, hwaddr addr)
+{
+    /* Store the payload vector in little_endian byte order */
+    static const uint32_t payload_vec[] = {
+        const_le32(0x10500073),         /* 1: wfi           */
+        const_le32(0xffdff06f),         /* j       1b       */
+    };
+    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_vec),
+                          addr, &address_space_memory);
+
+    info->kernel_size = sizeof(payload_vec);
+    info->image_low_addr = addr;
+    info->image_high_addr = info->image_low_addr + info->kernel_size;
+}
+
 static void tt_atlantis_machine_done(Notifier *notifier, void *data)
 {
     TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
@@ -450,6 +474,9 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, &boot_info, kernel_start_addr,
                           true, NULL);
+    } else {
+        tt_atlantis_setup_halting_payload_opensbi_fixup(&boot_info,
+                                                        kernel_start_addr);
     }
     kernel_entry = boot_info.image_low_addr;
 
-- 
2.47.3


