Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1DCC61DCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzE2-0005TV-SN; Tue, 25 Aug 2026 18:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDT-0004PM-He
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:02:00 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wyzDQ-00022M-R6
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:01:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ccf2360620so3628685ad.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787695315; x=1788300115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OpjWlRmtEinG28PJ3JYITgibmsTwvl/nI4qxNWAczI8=;
 b=J3UcPbv5q5n1xVqq0BODH17MIKVQ/SmvPPIV3KPI3jAWG30xscCZk3/Ts2Z3ZzwcSl
 sv2fmi+KAC7ndDzDqe1VaLnx4peTeLKPsCAAoy811+HrmKisiKNL/BzgvSxiBr4lcOUz
 gQKGW9gBC4+RcrUMk5D3MuI8LfGymWt5EhL+8F7Lpog4bKJgH5oRt2JWKsN2w1rumWaD
 Zt3+c8uVcy4u0q5yx8eps1nYeaDvXhrlnYYjyJTVCdPQjdAIbkUoX2PwE/bvsreVDADE
 zR5PNIMb4PtqRvUI/gLPqoYR5GpPX92mk855KiM3Hw18GtK7xmvi2Ps7V4iCdircECst
 +klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787695315; x=1788300115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OpjWlRmtEinG28PJ3JYITgibmsTwvl/nI4qxNWAczI8=;
 b=d3rCku4OTz+umsYu/E2aYaZO9GmApCzDUky0k0xpa6kbUWALlVBd6kIJmQ71bfxM6N
 NDSR6H1w2/bdf3dXNUEQNPh58idLcNIYze6QU2TkfSNG2Fg5Wu7qwe+rpXjw39VvD/dP
 Fhbbfut9F9b4XbeY5p3PhbuK6ybgtBrWbGjXZVwyB/z83ZkHaZKJudBgKzJzSAB2b01i
 wNXFpQN85YuL203XMoJ3YsdVrxn11zw4EA9kB0J3HaSps3qLyyxj0OWO4qtGIlFgd/OJ
 c/10jmOFJBz8bHKZ3GHu31HSaVlk3HPAz70AR2Q2RYpq10rmQ5pOtBalFctKHdjYcqxP
 bfbA==
X-Gm-Message-State: AFuF++mf1SiP8e/XD/oSKfMlgiAa/xfMuKArvACemLaaZx1O9NbyPH8n
 cJOBGiHDlT0DeoHKyExItXLKhTFUpbt8o5348LJXdhqVsOZ+Awq4ldQkhOhxiVbwFIM=
X-Gm-Gg: AR+sD13Nd3670NZj6v/HM4v7/NFx4El3iWuRAyttu+YwV2kZGMiiXyj2egTNlLucpV/
 Sq+kaaCA0r1UzkiKH6LmjfoSBZi0/E5UGgi/EV4+9lFKEdALAljPFfbvtF/6EEWMYJqIXEZr2hh
 rugCAdWIwIjyb5Hwb9emY4xq5n1oNAkDvrk8biNQO6hAuyavDt2J40fLxqZwYL0pk99GJ+5S5UB
 dpWIg/HqcNQ4cO40WGU6fuHveud6+kjEH3LYqlJRZmKSrhtpzT0aXaHm+PwmLBvd7T2L1UDx388
 hL0UKXKbreA0bit0RBi6rn/WqiHYI/UFu7Ajoe40tqBj5lpC0bXn6s9mXHh3Cyg8rxoIYOQdV24
 rFBFENH5xH0Y0sahWw2wfUlWGRi0ipu5QlW6nAbuk2nhIALPp5SXhc9fAn3EhGH1AxQf8amDQLd
 NMuggfd585NdC99Y6Jh2/dT5Ws8FPBSDE5xo+j0AVAiWBLxiUuK5bEyB2sDlkUswTvxOawPjH3O
 FLyYyd3cmGvC7U=
X-Received: by 2002:a17:90b:4a01:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-3966d1bae93mr3763741a91.6.1787695315471; 
 Tue, 25 Aug 2026 15:01:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:01:54 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v3 24/24] hw/arm/boot: Skip bootloader for confidential guests
Date: Tue, 25 Aug 2026 16:01:01 -0600
Message-ID: <20260825220101.3443954-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x630.google.com
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
index ad588121452a..c555228a0dcd 100644
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


