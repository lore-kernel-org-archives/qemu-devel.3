Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215F4CA5FE5
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 20:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCjl7-0007v4-QK; Fri, 02 Oct 2026 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkn-0007e3-B2
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:14 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xCjkl-0005ro-9m
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 16:21:12 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 d9443c01a7336-2e494adf48dso2225ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790972470; x=1791577270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
 b=ChhRJoC51ElmzL59TVMPgWPlYQtSg4CpDllgpvcIqu2NPa2nYb9QgxvY1oAjd6wTtR
 9KlJDq5A0ZaZX5F3Tam6HqTBFjOCSdM4vKb5PCgwOMrP8HqfH6AEkZ6JseHmoV3MXrLH
 Ph6fylvwNbkp/j+Bwve/lu9vcs3NhGNjMX1znTf4uktJlSi93lVGdqeI1oUt5ZhH3w33
 ZPffMII+0Kbo3xIMpuqJV9mM24hAk/EHT9enP2nBjD6IpskO0ftpMcyGKCXjSUcKzFiH
 BrywI7E8v4JTvDVpn63+5O/udliuQiYYqiKC0aZNT3j6WAcPUCL+ALkcFpOoyRzoh3PW
 N5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790972470; x=1791577270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
 b=xhtM2hUVNScKwBUy7nF6dQzwqwQkcUDLHtxxJ5c7Bs2Skr8w7+C+DvTrDwVcgEKGIj
 IN4Od9dTSveaDoLviPoUtZHIybK/jObB8Rys2n4qNbM0jXf9sTkhPtDNA1yzy5R1yyfC
 BMt9BUa9SCz6xeEGd/7oQIDShi9l6yHKV2pkHsunQ3epzSWZ/3C3CNpjYjegXv2VUKRY
 buAFZfcim4kq8+nTN6dJZe29onm0lUHtZ+gPYHqJ8njzuQAoRE62WmUEbmkrnBbzrTnR
 2uclREybuShJHfVfCUJJKPPI9lMi7lVDKrHrkHbpdXFRXUwxT1g4Q4tRDS5R159j5TWl
 vpnw==
X-Gm-Message-State: AFq9FYJehNj18gYYTvY/2BCIu0m6Y1qDtDznOCEQ2RpYnR/8/955xMKx
 kHxrTyUt9HqkP7F+JcPIly71qzrJJ29cmgcxDdewqa5gYLIztttKuwNXu4EP3Btd4Ko=
X-Gm-Gg: AYBFou3iD6Tctn4ArDJzSPfC+oaW+Z67HgFrVHO3MneRSzzPUebM48TMggPlKFHMbvp
 GuN0VGjHg5GZuBvZzzUsJLMVRDbEYmu4GfUCj6vYsdMo1ePHvvVT/YSXleHn1CBtJZrdrxpTSAx
 f4C3A9X5OKlvX8/5RNZ3G0ailskBqmM+cKZcKF0HWW0kEUINDUMNdCwZCaWeBm+FTxHciguc6x9
 /Bh7+RB927mO13XTdy5aa8wO1gcpDpPnOLJXbZVbsJFSwQIBDJ2VsAwpXBTYjfHCW2WU8sX6EjV
 FfqQCdu60CMa6wARdxxuMZ7EUvk8Q1RkCMHuWBoiLluzYR4EV/rtvgzA6d9mau82SOP21Yf7acK
 DDIFYhROePg71tPYsNJ3vO0za3gbQNsgJQ9hOUl8wFNDUhQim5z3Lpgx4/t2b0wYyxMww88WDYD
 ysEB1n+cT7LMZHGss+BXre6UgbKpClAqr8fvo4C/E6IXrTbEKE4RfLiFCAnln13/TT57GbtO9wG
 n4uSa+D34m1BfV/4k+eHL3p
X-Received: by 2002:a17:902:d4c5:b0:2df:83ce:727d with SMTP id
 d9443c01a7336-2e49b4e2662mr34316245ad.21.1790972469706; 
 Fri, 02 Oct 2026 13:21:09 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:61ac:e744:6559:a357])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 13:21:09 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, enju.kohei@fujitsu.com, lorenzo.pieralisi@linaro.org,
 gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 22/22] hw/arm/boot: Skip bootloader for confidential guests
Date: Fri,  2 Oct 2026 14:20:26 -0600
Message-ID: <20261002202026.1204110-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

An independent verifier needs to reconstruct the content of guest memory
in order to attest that it is running trusted code. To avoid having to
reconstruct the bootloader generated by QEMU, skip this step and jump
directly to the kernel, with the DTB address in x0 as specified by the
Linux boot protocol [1].

[1] https://docs.kernel.org/arch/arm64/booting.html

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b3d3558bcbc..da4f399a3026 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -731,7 +731,13 @@ static void do_cpu_reset(void *opaque)
             if (cpu == info->primary_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
-                cpu_set_pc(cs, info->loader_start);
+                if (info->confidential)  {
+                    assert(is_a64(env));
+                    env->xregs[0] = info->dtb_start;
+                    cpu_set_pc(cs, info->entry);
+                } else {
+                    cpu_set_pc(cs, info->loader_start);
+                }
 
                 if (!have_dtb(info)) {
                     set_kernel_args(info, as);
@@ -821,7 +827,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 }
 
 static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
-                                   hwaddr *entry, AddressSpace *as)
+                                   hwaddr *entry, AddressSpace *as,
+                                   bool confidential)
 {
     const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
@@ -873,7 +880,8 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
              * bootloader, we can just load it starting at 2MB+offset rather
              * than 0MB + offset.
              */
-            if (kernel_load_offset < BOOTLOADER_MAX_SIZE) {
+            if (kernel_load_offset < BOOTLOADER_MAX_SIZE &&
+                !confidential) {
                 kernel_load_offset += 2 * MiB;
             }
         }
@@ -957,7 +965,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
-                                         info->loader_start, &entry, as);
+                                         info->loader_start, &entry, as,
+                                         info->confidential);
         is_linux = 1;
         if (kernel_size >= 0) {
             image_low_addr = entry;
@@ -1098,8 +1107,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
         fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
-        arm_write_bootloader("bootloader", as, info->loader_start,
-                             primary_loader, fixupcontext);
+        /* Immediately jump to the kernel when guest is a Realm */
+        if (!info->confidential) {
+            arm_write_bootloader("bootloader", as, info->loader_start,
+                                 primary_loader, fixupcontext);
+        }
 
         if (info->write_board_setup) {
             info->write_board_setup(cpu, info);
-- 
2.43.0


