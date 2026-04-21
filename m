Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAF7F55805
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3jb-0000QE-D2; Tue, 21 Apr 2026 01:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jX-0000Pd-Og
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:15 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wF3jW-0004P0-42
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:33:15 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-356337f058aso2458593a91.2
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776749592; x=1777354392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GEoNIH1lDbG3wacvRNg9ITqfxSNVJqno7NS+0+CTsdk=;
 b=Zx/F43IsTX6YCJ5KU5L2OCLuLMwc5wJ6Tcw+cRNHeGc1kb44bbapEYN44TtRs484Xi
 RLE69Kts54kcIvMqq0ZNQMG6scYUvyVgOCqHvByHvG1y93nWQWi0qxkEP8qcDLDmWPwg
 ymCHErXyWLAhbPDoauzi10SfWcAG6SMsWPMT89JBJ020k7/Jovhx0UFqt7I2DQF957Fl
 o+drbJvDOpvYNQ2HEOoWEUoD5bsHNDa1I1Ih9t3hE1K2ITIsP2LOrAZANLqvKoc0TXuv
 eYZv2VthIA62X/9Qx13btmDsrkUUZp7vtxu9ZzmZwKtqAOYJOOU0/e3iAWri2iXuyMDW
 mWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776749592; x=1777354392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEoNIH1lDbG3wacvRNg9ITqfxSNVJqno7NS+0+CTsdk=;
 b=gOZAB4ePlWMbDbTz3iADdG8A4iRPXRUn2s6iKWwM6BFqPO6BLraFoSqY6RCAZCBEEY
 BedHKwB4sPTgKHRHOXeyfxzNqHGABRbbFa5BN7eDYeot9/Jp+/TE9VM7IKrau2U6WdES
 Z680SXifWRG44hsejxGiFZGz92x0xlk+wswUybfAAGhrcd8ORpdqL2x58cjxD/XViEJ4
 ry7zFcWZjh3+rFVgFuvbWYpqaN2v88/LO7BUPNY77qJihzz90uXJAtKqzW+wGNRf9Ck5
 sY5RI1w/5D1J3C+qFYJ7se3kbmeW0ubLMny38onWBh8tYy+x20CvOQxYfNtX4d3iExW9
 8Ecw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zWELj63EvdZZkCJfYFf1hSn+wHd6oZPtihdIFy9oUDO6qzq1ele710fRo0yU6at+MDVdL09RSNhnx@nongnu.org
X-Gm-Message-State: AOJu0YyAXV3DJ1hUoKXa2BW7MCygaLHb0MPhOoUh5RBsdqHwa26c4PHR
 ncWV8Wt4Dwko3yylJSHD27SbeJrvMOGwK8J83bYPhuB6NZFGYIeqAEW5
X-Gm-Gg: AeBDieuDMxn+BQaogjMLpBfDRhNHFqCnUImq+Ya0/4qwiKiqK4OXs6if3NVndVh4d6F
 JG2d9ViI2Comqc/H0wQtC9FsglXDgihPn0ZfJ5mkarlYe52D4t3y6n2Fl3MnvtmubjicJgcHD2N
 N/9VubCs3FFJnMtHZr4kTT+KG6jO9lPH+jqAKbIAsj1q68QcBCt5TE8Gjo+JXipqxhXNOqrQaGt
 SvJqLgYhR/tLrreaQBliXXJjQJyYCuE4kdhMNIoovmWKjBc3YEsMActibngCQsRAZ0pM4nq66z6
 8bPBcTUpeXA8l1CY2jxy73eCiUT4v3MT0BTn7/80CzlWWlS/A/KQjuE3AVtDh+qzj0LL/Z/eYXi
 2OypTNWsKvMpmLRidEZ++Bbcgq25gwRN9jc/CGMqib+fJzegD09DsnQAOs5zDjQcPrJG6Ne7rex
 gWiHmglPYpjzIrIhaKfKYbboxj2reOhqWDtf27HbiFV7v7VFEWdw4qsUPtaAvXRUhCv+KG2ANDG
 Dioz0GBVoWUp5dNj9Z4BNmXrncOberyz+OXaQ==
X-Received: by 2002:a17:90b:5865:b0:35d:a557:e41 with SMTP id
 98e67ed59e1d1-3614046f978mr17751470a91.14.1776749592559; 
 Mon, 20 Apr 2026 22:33:12 -0700 (PDT)
Received: from donnager-debian.. ([203.221.103.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36141898ebasm12472308a91.7.2026.04.20.22.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:33:11 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 02/13] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Tue, 21 Apr 2026 15:31:27 +1000
Message-ID: <20260421053140.752059-3-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421053140.752059-1-joel@jms.id.au>
References: <20260421053140.752059-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/riscv/boot.h |  7 +++++++
 hw/riscv/boot.c         | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca12245..115e3222174f 100644
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
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr);
 hwaddr riscv_find_and_load_firmware(MachineState *machine,
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9086793b7a7b..5c9547429a36 100644
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
 vaddr riscv_calc_kernel_start_addr(RISCVBootInfo *info,
                                    hwaddr firmware_end_addr) {
     if (info->is_32bit) {
-- 
2.47.3


