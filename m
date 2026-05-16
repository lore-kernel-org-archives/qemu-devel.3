Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B2FCD4F46
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 00:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO36p-00008i-3X; Fri, 15 May 2026 20:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36n-00007x-Rn
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:25 -0400
Received: from mail-dy1-x1333.google.com ([2607:f8b0:4864:20::1333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36l-0001iS-7q
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:25 -0400
Received: by mail-dy1-x1333.google.com with SMTP id
 5a478bee46e88-2f7020a928eso566578eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778892141; x=1779496941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AKRd1GtIACLYgLrmdueXXfek23JdEyyvDuQY89fFdBw=;
 b=hVhJ65fPkLurDQTJAf0lpGqnKdTkmr+ZCUoysWow5reiDEF33dvhtp3FX/fq+cQKIN
 w763Jic4HqiYTPzTLqJ9W/4iiYaxhCJcn/AujQj7TPZx+NYG700Buw1WS+DcFMhwbVlP
 fC+1AU4U5J9O9EMFwzB/rOwxeHtGlTqJimgbze/ucSAULIbS72nZMWQy1+Daw2vB3SWA
 jshK2vCIMuPcMSSr3xatjviBll8AjKFqZSmEKuO9se7Lac2vTtRFtYykhhN0+wJU/KU0
 K0txjnIz8tpecgLxYUvlg20JBC8vlbkBvtpEvT1rAAYMsuKTh5rvp83YZPfYVqGBFDyv
 nG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778892141; x=1779496941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AKRd1GtIACLYgLrmdueXXfek23JdEyyvDuQY89fFdBw=;
 b=X7Jt9GepVf8CXxOzDZbOE1IY4IscbFe8W8Pv4PVgo2cTRFM7H7hPSdkRngmji0XDu2
 VxyhL/l3qPv+6Nnt0yvGJQemKZQcELElPjRS0JQVqci0a5jmlbBWO9yfFnxOYTTkiH2H
 +AwdNsTtVVUTfVXyIk677S7WaHFjKZhqY7eQFnQ8dcZMgTUhKjhIHJyFMjSOFiydSTSP
 RSTRU9f02+KSnMvlhZ16oH+ZS3z4+iWHgcxwX9rMU9vMVpJHCc4SP5jtZUskvOrLoUk1
 juXsVFipcv+3E2DSDCOe15DM8yKinAlmZnFgRyatOP+tZl2G1LAD7WmKL5f2kIUp/P+d
 QSWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VoPsW05R0ejXlHSZYFQ7Srjj3hvn1bMShJHokGoFgmO5CqUnkRIJRLLplzUV9ogrpAw2hLOfk6xTz@nongnu.org
X-Gm-Message-State: AOJu0Yw34WMS7URpwlOxLf+O5Rd1SloDX5X1npOF+ocBHAVx1Y6dpczR
 KP+Qauy8JzTGoADdDxP7H0J1ppZATb/FqQCOIZsVdGssc/gW7eqKbACZ
X-Gm-Gg: Acq92OFHI8OC12jZ2lZW10QsUnIbP/XLeOG97vIi24bFLgKYoabfFMG/6RsPSvi9pzA
 TYw/KgbzfPprg0pBD+DOPP7k2M3olz/hcVz/7f6nKnkcuwM04/A8GurEp1388SCyCfDeREH4Urg
 lVes4JUX1Hh8CJvwW8aaPMWzCEsyAUeLyOlvNL8shvKJSxNo5v56Q5TdaT3oiRrKqZP0okhcTLC
 AfTBvhPqX0F5OUqAyArI6XguRO6d/HA8HO66r9SMnC2EeMRzXP9TdhhDK0unnzotHULsKViVSwg
 ajapb5npjEXmQ/Zq3QDdjxQW3uaqwTQCN0ZrmsNN9mRYD1NFkRRtRs6WjJSwMjHUxV/ua9f4eei
 QddoSwWyfXO2K4RadAl0fb8ebPPea7fjOLJC57anhonesggc8PBGJt900M3nf3rIOaFQmc/KUgr
 rQO3a8Koig1AZ/PosaPhSE3uugo2clsVM=
X-Received: by 2002:a05:7022:925:b0:11a:fb3c:568b with SMTP id
 a92af1059eb24-135044172c4mr2754094c88.17.1778892141336; 
 Fri, 15 May 2026 17:42:21 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc33a67csm11514517c88.13.2026.05.15.17.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 17:42:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v6 01/10] hw/riscv/boot: Describe discontiguous memory in
 boot_info
Date: Fri, 15 May 2026 17:41:56 -0700
Message-ID: <20260516004206.169035-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516004206.169035-1-npiggin@gmail.com>
References: <20260516004206.169035-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1333;
 envelope-from=npiggin@gmail.com; helo=mail-dy1-x1333.google.com
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

Machines that have discontiguous memory may need to adjust where
firmware and images are loaded at boot. Provide an interface for
machines to describe a discontiguous low/high RAM scheme for this
purpose.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/riscv/boot.c         | 16 ++++++++++++++++
 include/hw/riscv/boot.h |  7 +++++++
 roms/seabios-hppa       |  2 +-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ae2f86c7ce..b1a020b58a 100644
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
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index d9560852a3..1a8ada1fb7 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit d9560852a34f156155b3777745baa0d96d553f22
+Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9
-- 
2.53.0


