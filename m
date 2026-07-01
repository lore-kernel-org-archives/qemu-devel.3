Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A329C43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes2Y-0003SA-HK; Wed, 01 Jul 2026 06:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2X-0003QK-B4
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:33 -0400
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes2V-0004pK-Ox
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:33 -0400
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-13b392c721cso49150c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901170; x=1783505970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BENv5MVQmq/Veibl4ey82H5Kj3VpYn1LY0q1iEs5rX0=;
 b=m0L43MPv5bm5DDhZxqNTRRmVhM4XgpAZHtphDMu2zuskFB8iJ0d1U+rssC5Pix7PtB
 VTnSrir1t2YOGZHjehwyDozoNRplX/ue0EiWVSHQifLNFpnxmd3CbX3YA2rfRPyIFx8t
 2AXpRrI7Hv4TA/amM3ugyrC25yknIUfPmcHrbqkSyx+GqG6l69vccnBlO07Pyc4ewOQz
 PYKPWylL55DX/xVWPLqTASEoGMxnrsbFNGaJ8iuoZkgil2zXtNuRaEr2a+alfwyUpgfh
 Lres162EmdT3PsHbKpmfnVbmuydRjNOKf6q4uW7AglE0jkRMvGT0KBrHr6VNehP7txqp
 goIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901170; x=1783505970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BENv5MVQmq/Veibl4ey82H5Kj3VpYn1LY0q1iEs5rX0=;
 b=aEayl1K1rGWuI7+xP1qtbsfffwk1rusQ1Ao5Vg6K/L2eElehvNXE4X71vHCTBbev/V
 UQUpuIs0GHl7yorUGOBhyCFmv+F+M+iN8cUKKz3/inRn9mHuZqic/EhuAJ3rJWJatAcq
 SrZ3QDAyVfdNVSYJHGaXlgdJ+djdiAvWOsgGQHeG0T6jZ+aE3VZNztAV8czpA+UgewYP
 VzpEpZ8A3KChqS4EVfjPtvESpe0/szfUoFa9Srwkl7wNKXQdAnL4eZm5wsQZ6Y29Kvv1
 WOVgP7/7uNf1YoLhmTqefFLJgt7jLQ2P/MlI39wQwJUC/uzDaLamkjTdPyeviDFw0fQp
 q2aA==
X-Gm-Message-State: AOJu0YwHTzjpsDo3bR7xbzPqtyLlXwzRRD6gsnvoVfPUc9g1It5B4rrJ
 GhHYR5pJmsry7evnyzex+G/6/BlgKxmQ5y1GoUSShsvB4RO27517VIUdDNke1A==
X-Gm-Gg: AfdE7cl0bkmc20M0FPJeNYMunUhriyUNPGbKPa1PrdW1hpMYxQb6hGF4a3nZDY0SVKJ
 nS1ncoPF7+n+vG38PSRaUOEY1rkaaAjRqoK+30hHwz5D1NBVH1wpxe6EKLLWeyzsBeUHe7OAyjR
 aswUXbhxsiHnY7Fr6yBVQZJxvKBH2pBkwjNrNLzcpb2T1w2eOHqTs3RCnV/y2nK3zItvU/pmH86
 Nw+YsG/lZEJ5bIRt5Gnv8k3cJQVVa+/mKq2tOrTaVF3Ru13g4c02dxBAYSd+ZJQcPjKBsDl4MeH
 QQ/z/9C9F4btwdgzb7/TMdNNI4P46ak/+F4N1Vr6yyPUv6tU+375w95310g+AvRnLxuAXMD1Z15
 Qb+M8k9eLUEmI4PTv2FiPXseGDmwSa3kXswXRsY3iszhjbYm/XtSJgIS3cIEMkKpHen8Eh5mFDc
 tqxUiR5M+nHTB3vDSX5F1Liy0LWAP3TQg=
X-Received: by 2002:a05:7022:f697:b0:13a:1e7:e4f4 with SMTP id
 a92af1059eb24-13b36df88ffmr1014447c88.41.1782901170355; 
 Wed, 01 Jul 2026 03:19:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>
Subject: [PULL 27/39] hw/riscv/boot: Describe discontiguous memory in boot_info
Date: Wed,  1 Jul 2026 20:17:40 +1000
Message-ID: <20260701101752.2522962-28-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122b;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x122b.google.com
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
Message-ID: <20260630024952.1520546-2-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  7 +++++++
 hw/riscv/boot.c         | 16 ++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca122..69c99a1496 100644
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
index 7c9cd61468..c8418f83f4 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -70,11 +70,27 @@ char *riscv_plic_hart_config_string(int hart_count)
 
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
2.54.0


