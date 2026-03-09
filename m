Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D28F417F1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 14:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzbxC-0004Hc-BR; Mon, 09 Mar 2026 10:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwI-0003WK-2T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:36 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzbwF-0005fJ-RI
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 10:50:33 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-483487335c2so98742115e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773067830; x=1773672630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twH0MoLU9gm5rBOzlpHaIy0topLpBsNv4557Fsob2w8=;
 b=lyNdX39M++8ik/1y/XKCQKFwC9ovMSHBlybt/aDULOiybxrHmlJVy2StJmIoO9xdo1
 2UnztWsojzt+4pvKZIEVL401FDkm05RuWJZwprEkm01uzMz88sbB9rDxmNteWuQ1r0dV
 Wp09kyVEkqHQb3adoYqY77AeIfbgJ03zBlBGIrcmdFvIBzoh5Ff5F1OLs0IVzsJ4n5Rj
 tyGFlOzgWAd7PphfjC31yqj3JsXUM6ciqFcGreYEjX4V/zHjkNxOpBXKiu2bzyAZJHY6
 RWCUt5PqnzYI/84KJMxOSeqfPO5GCeGuHDAP8JWmaJC2JSEaDWU4QWya9xYp4lZZ2VLE
 GPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773067830; x=1773672630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=twH0MoLU9gm5rBOzlpHaIy0topLpBsNv4557Fsob2w8=;
 b=lnB0Xke23t+wFmUJ/KEIpIWYMH8X0IbsIz+rlPnn2HsoRCEynm8CcwQqwixaURFf+5
 Cy5nFg4UcljPdgebiztLzB5e9N6BaGjMngF79/cy+91Zl5qApyjZCFk2bf9Fut62tP49
 ZGfl/jXBXMTndc5xvP40NX8unStPdcdQ14UgwaefsQDIGRgqO0nzXPxg2nSo2eKTQ1c4
 IhwhIPwlF4skZrgYH2rjZ+HydjBKmGxW74bEGwWdULdARHjpcemPSbPiPTSlstBwokwa
 FB0ZRZSy9mdDytNbK2VJYOlM3dIdf00aKfW1T+Vy/G24Ple9dMJyQwLRqejDtn86iLOg
 PrtA==
X-Gm-Message-State: AOJu0YzWG/ttnXgeJWIeyqnxkn+U0tPE/Cva86B0yDOszNgjClTdCqVM
 QZZkLZWn5ltFDxIT9yklmgfcH9JmKZg2c4gnB+MIJTSPnFFC+ddnJEiO9jV7CLZ32Bh+sQrDGXd
 7MTzdwlw=
X-Gm-Gg: ATEYQzzGYA5fL8K6AW/G8eTOLYmpF6GwCiQG1ZFUL1BLp4h36EQ8nhEEi+xyiSCdY/O
 N90vc6nMqiBStbKhE4piw5R7gWBU0uyT20c2G5mYFPZnpbXjbkEhRa3XINIJcQ/sQOGbccvIxyj
 G58tPOXQhAf0XI+s25aRmaN3Wkq9H0zJXEeEFXFjVV/pBO9aRgILdzeuiZNHs8RdhWfFQt1Tlcu
 w8Em657EVRRK8/Vh8gvwqG9xqE7g5uzLuDCqZmvw2VJNSwmcC48n76kEKcrbQ2rxcSh6ZYn+zT/
 Bj5oaYNQ8CnkNKB1BGijptdJrLUEpsQdBRE1yZ/TekCQEMoXrvovUgxJdjXbjeaRC/647tTOwZ7
 WP5sQEeI2dOx+FJE3j3HCqj1BPxLiOjLwE75+RIGjw2q+5+w9HPyv81bA0nxHYgd0VE1AKRDyP0
 BFBK5fBG3KOB5dYdyYgmt3EQxBG69m2WMUxh9GZO4N4QqtYgbiQox0zQqonCmz9IDO2o/yA1IrG
 DpbcQ==
X-Received: by 2002:a05:600c:3b13:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-48526969359mr218672575e9.19.1773067829463; 
 Mon, 09 Mar 2026 07:50:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852f369118sm76824055e9.20.2026.03.09.07.50.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 07:50:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 02/10] hw/i386/pc: Remove PCMachineClass::pvh_enabled field
Date: Mon,  9 Mar 2026 15:50:04 +0100
Message-ID: <20260309145013.44327-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145013.44327-1-philmd@linaro.org>
References: <20260309145013.44327-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The PCMachineClass::pvh_enabled boolean was only used by
the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-3-philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 6 ++----
 hw/i386/x86-common.c | 3 +--
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 5623660f5dd..908de5e1eab 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -110,9 +110,6 @@ struct PCMachineClass {
     bool enforce_amd_1tb_hole;
     bool isa_bios_alias;
 
-    /* use PVH to load kernels that support this feature */
-    bool pvh_enabled;
-
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 052226baa57..3fc2f0a057e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -588,7 +588,6 @@ void xen_load_linux(PCMachineState *pcms)
 {
     int i;
     FWCfgState *fw_cfg;
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     X86MachineState *x86ms = X86_MACHINE(pcms);
 
     assert(MACHINE(pcms)->kernel_filename != NULL);
@@ -598,7 +597,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
+    x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
                !strcmp(option_rom[i].name, "pvh.bin") ||
@@ -932,7 +931,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, pcmc->pvh_enabled);
+        x86_load_linux(x86ms, fw_cfg, PC_FW_DATA, true);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -1673,7 +1672,6 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->isa_bios_alias = true;
-    pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index a420112666a..db8d4e855f4 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -704,8 +704,7 @@ void x86_load_linux(X86MachineState *x86ms,
          * saving the PVH entry point used by the x86/HVM direct boot ABI.
          * If load_elfboot() is successful, populate the fw_cfg info.
          */
-        if (pvh_enabled &&
-            load_elfboot(kernel_filename, kernel_size,
+        if (load_elfboot(kernel_filename, kernel_size,
                          header, pvh_start_addr, fw_cfg)) {
             fclose(f);
 
-- 
2.53.0


