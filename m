Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E1DCD0438
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd04e-0003tK-N2; Tue, 06 Jan 2026 00:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04b-0003q0-8Q
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:41 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1vd04X-0001mw-Bj
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:57:41 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-34c2f52585fso695055a91.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767679056; x=1768283856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2mJj4mfMvlWpf/+iqVC0nzsDjwQbsvp2SDdkZaYSgQ=;
 b=h6ePvNfK3FkWz4+7Uo+IDSCKQsRpEGqlj4q71ODFz6xwo224FwrfFagK+R5owHj19b
 adwWcdds9nRgUJhajKC3EZ1WbJcekQox724HpSlPHAnv8uRJNbE3j6RLlkMr0xKV0DBc
 usxwNd5LczmYaZ5MR5MHaQ/CzcH5nbLPayugK6cM4s3NOlG8/t/8MaC1FMa/suFO9BT3
 GO5vuRafdsZIJ5pI/rZN0ZqzeliJDwrlJloeHWx//UplHkcnHi9hHg8cWvE5RyFkbDg/
 HaBPUNa0yw4G7LBKFblvDyOrrDfaKWZ6vHGf6MLFnuzGiHNL0w6P27aOp5moMgmt5aVM
 w7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767679056; x=1768283856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E2mJj4mfMvlWpf/+iqVC0nzsDjwQbsvp2SDdkZaYSgQ=;
 b=C2jHIuq9PEqFzNuAmEnFUOXFmqGusfoqDrV67woqpx0HAt1yuxUcQkBqLuRmw+9WQM
 C/9cgHyXDOx+t7xVtaG/h1NRlcl88q95dhso71/aQ1eAyDZKBrO8n/fBNVLl23zI+8Gq
 1piaG62pkQTIm19uhnnRDrHKVkLTYzUVT8Bgb4Je+7Ex7UUHzpZcIoHQUOCf2O+poEGF
 biJsaz1yfa+2ie3+EF7k25aPrmI8cY4fxX5tyWdQj07/E2Sf/XGi/mrFKf9APA/x1tz+
 LOYgszrAhq6K5FMGuGITSrdl8V/+ISdVKuGkiE0mIb/QbTH6KmwfSBR+qNYivN9oEx16
 aS4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4xkxc33kSywYFx276ogY1V2lKQfzQw5kG88bEoHn0Aok1nD8KYQ5Q8lRzyWXSxruPhsxCxKT0J3KJ@nongnu.org
X-Gm-Message-State: AOJu0Yynv7MwtDnTCShCN0sGy6a+CQKlusz+Ao9CpTvDZJBgLmyztxPZ
 plYOHVwZ4yTrGm5RXrOEjez6dHTxdZLsyLTchDXMyuL1AA1h+JUrfeFh
X-Gm-Gg: AY/fxX6R/soCA1OQJbPdTlrkUC+QSKmY6bPUxfaoScSAGdMZYBxw4fEr9icFR+kt2pU
 RFJBrQeZDkKa3tv7a+gr+YfOTSwjcV1zxyPnvT6kS5deGB57C6MchMrPnY4tyK3QnUz6NRkCmnE
 lZVj6NoAf8TkNcaOLA5UCxbuqOhLyJ4DVPaVCsi8OFalg0oGAgd3EENxar6gP22aSzv0Vkb/KTP
 RFghd6tVT+Q5umQnh87CNW+cnHAq+YmRPhGhu0++Xi63+rgjvo8eR9a61WcLoVfjliTNheyxrUF
 3xkbYzKqsRdjARaf80h1AzChQ0LDGcLW6+OogU4XdwLjJcC/MFz5WMmw+zvWBrD30yk0JzrjD62
 9yKeDFcolKXfiBZM2gBWCbzJaN6KK2gPNgsdGpzXtgbjJsneU3xbgNMDSRvd6u2/uiwBUNVKUlV
 5NMvwxfa3TEQklPYAKvBkQ6SCfxXCll5Y=
X-Google-Smtp-Source: AGHT+IHZRoG8jgazJ9eB6+r2zc5nPNOLouSzC+bQVqM3FoBLvfLX7ge0cCTB38fEjo4J7kMYhkcYvQ==
X-Received: by 2002:a17:90b:58d0:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-34f5f3079d3mr1406295a91.20.1767679055735; 
 Mon, 05 Jan 2026 21:57:35 -0800 (PST)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f60178af5sm460222a91.3.2026.01.05.21.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 21:57:35 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Chris Rauer <crauer@google.com>,
 Vijai Kumar K <vijai@behindbytes.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Ran Wang <wangran@bosc.ac.cn>,
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Nick Piggin <npiggin@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Subject: [PATCH 04/16] riscv/boot: Describe discontiguous memory in boot_info
Date: Tue,  6 Jan 2026 16:26:44 +1030
Message-ID: <20260106055658.209029-5-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106055658.209029-1-joel@jms.id.au>
References: <20260106055658.209029-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Machines that have discontiguous memory may need to adjust where
firmware and images are loaded at boot. Provide an interfaces for
machines to describe a discontiguous low/high RAM scheme for this
purpose.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  7 +++++++
 hw/riscv/boot.c         | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 51b0e13bd3ea..f53531fc0bd5 100644
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
+                                        hwaddr start, hwaddr size);
 hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                     hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 75f34287ff1b..e3292e75ed80 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -69,11 +69,22 @@ char *riscv_plic_hart_config_string(int hart_count)
 
 void riscv_boot_info_init(RISCVBootInfo *info, RISCVHartArrayState *harts)
 {
+    info->ram_low_start = 0;
+    info->ram_low_size = 0;
     info->kernel_size = 0;
     info->initrd_size = 0;
     info->is_32bit = riscv_is_32bit(harts);
 }
 
+void riscv_boot_info_init_discontig_mem(RISCVBootInfo *info,
+                                        RISCVHartArrayState *harts,
+                                        hwaddr start, hwaddr size)
+{
+    riscv_boot_info_init(info, harts);
+    info->ram_low_start = start;
+    info->ram_low_size = size;
+}
+
 hwaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                     hwaddr firmware_end_addr) {
     if (info->is_32bit) {
-- 
2.47.3


