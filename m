Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0008C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DF6-0001ll-II; Thu, 03 Sep 2026 15:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DF5-0001lP-AC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:59 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DF3-0004RL-F8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:58 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-398b3c37877so223509a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464216; x=1789069016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
 b=cbqCW/Aw6AkJSwlZQth8oxLEa0qdL6DTxpxRhyYo/sjAF/STyC80h5tVV9gfGPYkxm
 iBGEP/LK4OjHcsS6COmXtEVb8YCN9gUID8bS+IGxQIe8v6Kmd0jjf2MtbAzL3YNKo1cR
 688KnijAveMbkEt0ExN0L8yMkS5F8VOWTzgekSaXhVcVXzlbTTc2GNQGCahbv0aRm1IY
 jL5xHM/oXB5hRWec8obmm+cUJVIzRKRrDg389s5d/aTx/uUHBIAfGIXaF5LAFT801QRG
 bwkgmTv6pY0aumK0UAiaQQCMaaR9+fLTnpmItwVslH4T1Yu8XMBYgstA2NLeRYKIRdoH
 O6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464216; x=1789069016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
 b=sdcwcahAg07T0ZO1nlk/EnTn5JYwwW2PEuE4fBVLPVTDd507yoDHJeyHCBOdTotyge
 vzDEGP4J5epHpnWG7BjVPxwytz8KupluuXRyakt836PulaQaujdVXww9g9zaHkl1txjo
 mmjoIbu2v+ykS5JgJodf/zTbXyQbIGKe5IwH8rqUgcJGlAWb69ne5VQcMYjQ8Ojo2+3x
 dQrvhI2wakUOMZPEgebA3YQ/V7w8XyaL3ZVTaNoA4tTn1tdJKVrb1houaWGrcTFd1SrY
 Wg5QSOvJlVHyqeopB9G8AaPKw36PhlBcXkdrTMyFC6tgmOOcDcj/L40FJli9wPBY+MCv
 lZlg==
X-Gm-Message-State: AFuF++ntdlTgn3oEit1Sa+FEcZlGiqhoOc8ObcobPUG0wwuLkRdIOb8m
 0zoUq1EVeBC1U0bhK5fWyeoQI2NKKoyb31UoEo7iKqSokrLzluNw8qzKz5h5QEnEBUA=
X-Gm-Gg: AYBFou32TaImKJOsG/fgsu7r+mlz1kk+OcJDQzSBjzNQdREWnwGKJsgNmsHPjY9AKJX
 q/RhhEyr8buor9IvcKN0GLgrQHxVMDhR5xbGFqBrg/lqoJHuVSz7wwZS3KarZBfVFc85kA5CE7O
 rBqbxvPoFaIectfn/vKqhowfJx+IQW5krS/EJgeeddXnuJ/bJDmVvtZjEcwnmwG8uXZADCoVpJS
 SPYN8HX9zgWUMuZ2K84llU8PGa8YbV3nivjczhQidr3PSmd98yRX52WGvdsV97NPAPuQ4JgyQ6I
 WhgJkMgs687CtNd7iXAxEAioyQhrzbz9GWR+YjEyGHVCf56lvdkdz9/HQcn17TSRMqWQ+iS2lLP
 /sBgu8etq7rAoY5cbahx5bVR3AG2B0F0cNFK08JOJRjMQezoEmUe6DsHoqOHuwgTcA8mcepctdB
 U++4xG+ZV8P7i7EuHkO2xz9g6fdTGf57jnOFx+VbiIgpY3ebuWlU9QXSJfB5k7NvKn6ZDW9b2wh
 SQ2WnJpgtIy/f4=
X-Received: by 2002:a17:90b:5844:b0:398:dc16:3c29 with SMTP id
 98e67ed59e1d1-39b26101530mr1289326a91.7.1788464215941; 
 Thu, 03 Sep 2026 12:36:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:55 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 24/24] hw/arm/boot: Skip bootloader for confidential guests
Date: Thu,  3 Sep 2026 13:36:11 -0600
Message-ID: <20260903193611.1058589-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102c.google.com
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


