Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DD5C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weOYA-0004Al-EI; Mon, 29 Jun 2026 22:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOY7-00049z-Ic
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:11 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOY5-0001tE-W1
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:11 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-380544d00b1so142142a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787808; x=1783392608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsWbPE3Bt2Gd8XbRXKbewV3tBI1M4bc8RRw0T8jY90g=;
 b=F8G4ljvE5L3fnlAAWKKILznRQwEh4MDmoZpZhgDmSwsOpSLXV+a1SgQsXKMc2HCMAo
 uvm5qgRCh0jT2fn8lIeVN5VXcxPcpOMr+TdSvK145gcET1X9Zi1+RWepCkMlRJq2ZjMk
 d71AtuYXZSbT9gvrF23KZOWxTM1HxH5k5KlIu0g/UuR2q+dVfOXLOY2DfOZV5R8OzzRk
 m3EB8MP0Vz/i5P/br9jBTB+SP0wMawsNXXhQ+gDKekLUkleqVVp2BNdT5/XFCt24SIgR
 kd5+oO5p9W05h/iJTFoQQy0ZtqgwTW6LaU4E0NzUljlTXKGU7CoMXESgB497lVVW/hUr
 S6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787808; x=1783392608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WsWbPE3Bt2Gd8XbRXKbewV3tBI1M4bc8RRw0T8jY90g=;
 b=kbX83XnD80Kcyd53Bm3CjCxR13O3shX93/PoRhTGO+rb7D/ZBC4FJpikvtMxyTN780
 oahcS17hXmIxbhdtxSVSWrQ3YYDxHX11Nj/XQ3Ng+StoZikl/QY4PDVQJz6IlgLUaQ0j
 ccWyJW9ZIbbNkUuMpBU+w8NDN2tjzTt1hcrC91RwmfMdOoojkr3SI5QLg/uFot0NLNod
 u5CMn5ywPr0XZtUvXBCF/nLv8G2Fb/ehME2Rr41MnrtxWpRLeAlhn42VP+6fDoH6er0E
 Y6ignqbAnbctPzrfx1uF3GKsF1s4ggCWZ2aRUROmyRgvle+Y9C3RHkXKADNzPnlEnydr
 axgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RobUhGf+YVVaPIfeEeDonju3+928IxHQ1s85j4wRoepDIXCGsJgTRhY6oOlMRuNcwd4FbYxtPawD/w0@nongnu.org
X-Gm-Message-State: AOJu0YxqMJ/KYYS3DsH8n0a/3IApNrwLUSlATPYVnSQps7d7jMn62U8S
 6K0BiDR5Ge38kVfAAHKRK32RVlSWcERRFtR5CA2cEvtwwLA8Na6x1H0i
X-Gm-Gg: AfdE7cnBeolemki3jvmQbnEU1BzEXTY/jb450/gzoNWsdn3X3ufY6l4IlmELQ9omFJJ
 eoe130gOlK+bVUgEEpJHnsVPbYhriHSbzegqxOpADRuSZUgiOFAAg/7nD8QnzQGI80PRWLn39se
 yp0pMUqDIH5GF9/6BUUhafvjQQ7N4bednf2myOCRTfD55SyPhmELUuu4bjVXkMI9OllyUfX0T02
 QF7BljaNISgWifRfB1F1DoTULpvfzYg1eRvRdJsMfHTlyHzuWxHiYekmKmSGbkPhjnUE+BXZcaj
 A64PFfn71gpB2Ddvci0SvETrQWuU7NXEs2CggfqRB+Bw3vMN4D+4xPLlJgT2kl6wX8mW3lLAk+8
 mTRbrAEhI/KEO27Ofr10FeW8r839RX6nJqN0AfAZhx5vPwE2Ns81lP+jsRh+fqKw68yUkcQ+C5A
 PIMSOKZt9lNBxR9mFje4uQ+0IFKpBRTYySaC/XlHPeVCgh1RgQAllvWYSiktS4+zF80y09XSqis
 u2t5hSWpgVAczAtG9Jq61APg97rUw+JlBRz3ES4Zr0=
X-Received: by 2002:a17:90b:58c5:b0:37f:e483:e933 with SMTP id
 98e67ed59e1d1-380527a829dmr1187031a91.23.1782787808266; 
 Mon, 29 Jun 2026 19:50:08 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32661sm704545a91.9.2026.06.29.19.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:50:07 -0700 (PDT)
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
Subject: [PATCH v10 01/12] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Tue, 30 Jun 2026 12:19:39 +0930
Message-ID: <20260630024952.1520546-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630024952.1520546-1-joel@jms.id.au>
References: <20260630024952.1520546-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1035.google.com
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
index 7c9cd6146815..c8418f83f480 100644
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
2.47.3


