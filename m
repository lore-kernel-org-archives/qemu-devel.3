Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA3DF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcua-0003Pf-3Q; Mon, 09 Mar 2026 11:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuU-0003N6-2U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuS-00088q-Fa
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:52:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso20771575e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071562; x=1773676362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=56kKgKQOzOqlPLqslOUBbDul2Zao5+wxBEi16b8zvOU=;
 b=A58nzerq/vLDD8vCmjGSpve07VnZ2LpJBrs1UejnUVgjTYwNaApb30Vb/BhRLWx+0c
 0U5gEuOC+p4Po4I3zXdtIH6b3xSFE+9dmequMm0P+CZIAAgFS6OT108omOIwQolcupc5
 XVhjHumoBkXd+W08auzMDoe/iMxOMio/bBr9C0gavs38jBHJEiZ15OpXFJqFw0xGQwZK
 N69kVLDCwPEheExBBgaa+ONorMNma5s+Rzt7n7wnUHiUYjZs55zdVC+4U+e1WOmLceQh
 ntB1vqgwxH47DzvoMC8kqWkhupqTsKezZTT0Meyv0ZxesBOTNYQRwqBC+69GaLBVJNWL
 Tong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071562; x=1773676362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=56kKgKQOzOqlPLqslOUBbDul2Zao5+wxBEi16b8zvOU=;
 b=CVzjOBFHlUyWsyYP2kwnN01I3rODI5C/rPL5sNRUMvW0fVafaKcclPCaru4bMfU04H
 DhZCRpkdA0Sf4Nj48WX0YIfMdx+07gDENZ0DQQipTR3cxDw5C5av1h8OOVSLFDzmUPgO
 Ktn1Muvmebb10xTDSUfCNm8mvGTQYmYvQ6ngLkweQ5FhX6a432BttANVeM6l73TsX7yp
 nDAowN9rgRaSBiYH77KiXlIBOiQ22mOzqmp7s0DmUK0AHzsinwBxkAjrKIflXU5/6+yu
 4EIHgSai8AFhdaZ/1e5oFQeDpF4kS2bav0iikGTKIzxULgfrB70+eGTZwUZslhdBze0D
 N1AA==
X-Gm-Message-State: AOJu0Ywrs86QhYAlPzDjbA5esojO7tHpfHFp8SDzWB9lDceeyJxxsv/4
 X8/DjkdAeiASKB3R8mwbiK5iGaXNGvZmu36/DSR+Z8nK++V5iZ7O7o1uXHzofdceX22k0a2GUhj
 sh/5mA1k=
X-Gm-Gg: ATEYQzwMdoeQGlsFxtghR4b+035x+Db9tDMn8/nF7ooKkWpTIXJgTAQypEkfC0PvBxI
 X+Ijrd/XDydNTwdhQDbLn8yCYufhhDvv3guEphKgiNIUbsGkz8jUpL3+wdOzVQamEqDmFdkxj1W
 ymdYDARGCxTctlwkO7lNkP1o1OAp+8o+bv8pHJUpqvZ+eKGoUG08jB4H4p9FeY0FOpK+0fv2eTE
 ILpE0QLsV5k5P71/8m6SkvILxQtensUW9/AyJiGe0vVFFIZvXHmyICvv86T3L5V70ZWKF9654js
 r0Bw/43p/pKaSnJgEnVnPAzwFHg3FuUR/4Uj2zI8zYFnXszp+WcwzGv/Vm3LIb9E9GL3wcv3jpc
 YVXrYdeHBXi2mm298uSSqrQG0lf57uaEESBSACenTjO3CaUiZyPCE9WjQCgTbLsYijpLqhX5hMN
 /ZjnsfUmsPh4cYHcUUffkvpD/cnEyAN194jYXRa2oAhF/WQE9Bjw7E/yT06tByrwzqyf+v58dX
X-Received: by 2002:a05:600c:6092:b0:485:4006:962d with SMTP id
 5b1f17b1804b1-48540069889mr26195635e9.20.1773071562314; 
 Mon, 09 Mar 2026 08:52:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aac28bsm580205e9.1.2026.03.09.08.52.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:52:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/49] hw/i386/pc: Remove PCMachineClass::pvh_enabled field
Date: Mon,  9 Mar 2026 16:51:33 +0100
Message-ID: <20260309155219.62400-4-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
 include/hw/i386/pc.h    | 3 ---
 hw/i386/nitro_enclave.c | 2 +-
 hw/i386/pc.c            | 6 ++----
 hw/i386/x86-common.c    | 3 +--
 4 files changed, 4 insertions(+), 10 deletions(-)

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
 
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index 640b1d8c548..4cd18166ff6 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -164,7 +164,7 @@ static void nitro_enclave_machine_initfn(Object *obj)
 }
 
 static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
-                         int acpi_data_size, bool pvh_enabled)
+                         int acpi_data_size)
 {
     Error *err = NULL;
     char *eif_kernel, *eif_initrd, *eif_cmdline;
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


