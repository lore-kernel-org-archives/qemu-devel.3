Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65917D59D68
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFO-0005I3-BM; Mon, 25 Nov 2024 14:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFK-0005Em-Hc
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:46 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFC-0004ru-TJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:45 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so44393155e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564777; x=1733169577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0X0EuUhZkl3V6dkF5yC+rBGIPkT3Qq6H9A8p4Nm7TQw=;
 b=hpz6CoXWrfu/u5D/zuUdjHh/AvL8kP27mzNPXiXdNnoalsfkyzsBrzGSqBII1X7CIa
 rp17wBbh7KHPR2xV2TNhp7/ta9AogEokpZjqOH5OiRBnC6mqK7P1w5EmEeyu3vF1ZrJv
 Rqrf6NRdA2YmWzedbX6P3Om39hocVrlgGKlgnj02Oslb/sJxeb4iISvhq91Df+axqSuz
 x7PpQbz3GsEDERvckGsNDWJTfsz7ZfcyULuDI3fqQhdQX2xadmLZYUfcK4Rvl0vfR+Kw
 hroJBsgXpx/9M8TR8JBj6TvaZA301YtxUj6ZNOiMyzyprwnIqoQbnlpJTGVdGHK5/Pym
 IAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564777; x=1733169577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0X0EuUhZkl3V6dkF5yC+rBGIPkT3Qq6H9A8p4Nm7TQw=;
 b=EXaDtip1lRuSytzP6s3rJFwTUIJWz0+6R+aHT4Nogsi3ZpkKhS4/nhXNQzZ5lFxNlU
 uBCOjC9SjnZw/G1oCpnKPNTnl7MD+BVm4CGAUseuEvSzfLZxCYJVSAo24PDky/dNDAse
 wRN9UvEDABqlrTlNzL6xMIoM7yyA9S1QOUTCN+wmrwN/hlGRsOgpnDieILTusktlCIrj
 OXe2xP1AJ2ElQeSB6Z9LHybfYLVQ44SyIWeK1bZPrDQv2+3ZMhGVVyL/UHFhkWGKJR6R
 pIyJcwoPUyuqcw2Qz0GyqQO/jtPN6kVuL18HkZuL6NBypstdyQ6Jm+cz3udhiqpFC+ei
 +RjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcXAetnsNvuVxjjgshZV+2EFUzg7fV8dZHws/xbWCsRAp5idw0uLtS16M2GcFR2P1xSnqf6lI8+i8g@nongnu.org
X-Gm-Message-State: AOJu0Yxvyt7xB8HIWk2d9S2yRilHHUNQr29GaxDusMf9JWF58zzhukAp
 QvoEayi+zuNjdPU23oDPQdzPyyinnTcYbV5hBbmBXcBXAT1WmrOLSj3D0QYJyY8=
X-Gm-Gg: ASbGncvXdYCk8R0r1qSjZcTRZeLcWCaghjpWHm1Lo/mOQpeKoVU6xi1sX6xYOIQ4rnz
 Fh8b+MQ+rOLnSv0qi/+/bW7qqwP0QiptD5gzDGCOjc9FcuKRItBPF0U9pGFhjGwFGg6Uk98d+8I
 Mp3yd1+jdZDnIMmPKcnZ7y4C+eo0kgxZUUFy4Hpdi3sDWDe2MyVtbOjUjXsK9/4Pdxe1aXjbkHJ
 aESqR0HMjTfC3znSE0jRbLBlrVmtxyAmln0LcovKAWcbPa/u4qV95du9hhdoS3NjtKn
X-Google-Smtp-Source: AGHT+IFSmpP21tnbsCvXgk64PcQ1IqbTren1CzqreRLS7x4zvWdbhUeeP02hsbF6jzpxXIfyBKQGpQ==
X-Received: by 2002:a5d:6d0b:0:b0:385:bd85:5a32 with SMTP id
 ffacd0b85a97d-385bd855a91mr2115120f8f.15.1732564777217; 
 Mon, 25 Nov 2024 11:59:37 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH v3 22/26] hw/arm/boot: Skip bootloader for confidential
 guests
Date: Mon, 25 Nov 2024 19:56:21 +0000
Message-ID: <20241125195626.856992-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

An independent verifier needs to reconstruct the content of guest memory
in order to attest that it is running trusted code. To avoid having to
reconstruct the bootloader generated by QEMU, skip this step and jump
directly to the kernel, with the DTB address in x0 as specified by the
Linux boot protocol [1].

[1] https://docs.kernel.org/arch/arm64/booting.html

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: new
---
 include/hw/arm/boot.h |  6 ++++++
 hw/arm/boot.c         | 23 +++++++++++++++++------
 hw/arm/virt.c         |  1 +
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index d91cfc6942..5fcbaa2625 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -137,6 +137,12 @@ struct arm_boot_info {
 
     arm_endianness endianness;
 
+    /*
+     * Instead of starting in a small bootloader that jumps to the kernel,
+     * immediately start in the kernel.
+     */
+    bool skip_bootloader;
+
     /*
      * Confidential guest boot loads everything into RAM so it can be measured.
      */
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 20b3071339..e461137595 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -762,7 +762,13 @@ static void do_cpu_reset(void *opaque)
             if (cs == first_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
-                cpu_set_pc(cs, info->loader_start);
+                if (info->skip_bootloader)  {
+                    assert(is_a64(env));
+                    env->xregs[0] = info->dtb_start;
+                    cpu_set_pc(cs, info->entry);
+                } else {
+                    cpu_set_pc(cs, info->loader_start);
+                }
 
                 if (!have_dtb(info)) {
                     if (old_param) {
@@ -860,7 +866,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 }
 
 static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
-                                   hwaddr *entry, AddressSpace *as)
+                                   hwaddr *entry, AddressSpace *as,
+                                   bool skip_bootloader)
 {
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
     uint64_t kernel_size = 0;
@@ -912,7 +919,8 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
              * bootloader, we can just load it starting at 2MB+offset rather
              * than 0MB + offset.
              */
-            if (kernel_load_offset < BOOTLOADER_MAX_SIZE) {
+            if (kernel_load_offset < BOOTLOADER_MAX_SIZE &&
+                !skip_bootloader) {
                 kernel_load_offset += 2 * MiB;
             }
         }
@@ -996,7 +1004,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
-                                         info->loader_start, &entry, as);
+                                         info->loader_start, &entry, as,
+                                         info->skip_bootloader);
         is_linux = 1;
         if (kernel_size >= 0) {
             image_low_addr = entry;
@@ -1136,8 +1145,10 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
         fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
-        arm_write_bootloader("bootloader", as, info->loader_start,
-                             primary_loader, fixupcontext);
+        if (!info->skip_bootloader) {
+            arm_write_bootloader("bootloader", as, info->loader_start,
+                                 primary_loader, fixupcontext);
+        }
 
         if (info->write_board_setup) {
             info->write_board_setup(cpu, info);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0750c83fae..5247f53882 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2509,6 +2509,7 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.firmware_max_size = vms->memmap[VIRT_FLASH].size;
     vms->bootinfo.psci_conduit = vms->psci_conduit;
     vms->bootinfo.confidential = virt_machine_is_confidential(vms);
+    vms->bootinfo.skip_bootloader = vms->bootinfo.confidential;
     arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
-- 
2.47.0


