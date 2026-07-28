Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8350EC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonTn-0004Xa-Fx; Tue, 28 Jul 2026 15:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSb-0003dJ-8U
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSZ-0001ez-GB
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:29 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso162281a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266846; x=1785871646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
 b=bIah5Jv33DO+0ubqPVlIG4C+Id85DdYOBDrN0E2cmWrZ6/2r1KtgOm7PPTBxJ9EkhI
 riKvcHZ4+tytl1rAvC4k1rdjI567dhiCaxDm0lrgA1meHniJOHImmWH0uD28wuTd47Hz
 CK6XOGRaDP8xaZB7dKeYHlPJQgL3bHsXqI4zhNf5xHRopUDCjzlUrNQvSck8VuNcBSr3
 zt4k1ma+ks89myQBlkEtQCebHJ5hhhAvMNPnCVCDFAqfmI8MevX5OoyHHnUB+PSR5x0N
 siwz6fkaCJGufuUofDvD7bkGQEsshw431u3qQKkBRf5dFQt1J2WHjd2UzAEkRm7KxSNg
 xeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266846; x=1785871646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
 b=Yf5/+FneHi27TiZ4WrN1CTT+ROxRSttbHuxSkQeliZn3e3NbCUzG3R1SEBa+shHc19
 yQ0Mybt4KONtrcYHi4FDzMdvpsPbgnE3JgbOGsO8j6B0ZWgJOFkpse3Atw/gCQMea6Bk
 uUgQJNYcthfEwp4XJ6ZfejW/hWtSwDRKTQImmc04Z7OXN1nmC0tpczRc3D5l1vKbUjBx
 97R3hjQX8B+tWniJVU4j5Te+jiYeKufgaQb1vuYZA09V0ktUOIpnUkCXDE0qC2YweBy1
 TTsZ17CtjTnKywaX6BXrOuZy8onm957K3kASuoqBV2yl4IGdvhtE6oE4VEFPDyAOKR8c
 fRUw==
X-Gm-Message-State: AOJu0YyeZY2IPaA2TvuwbWSRDg/inYkxdeaAeg5d82RutjGNKXbhGoBV
 W/eySSAPM7ZKL61pCZWcslKq1SVrHdtiyEocVGMVxvZh731Tgo0hWcFjWGk/24/zeZw=
X-Gm-Gg: AR+sD134Lq7G7NhLlsDrxhErklEDFZAHa9DHbc/L3hKxw1d3kWr5uFIiQjK8mjmlwF2
 tEsNw2Ig0vMUb8i89691xzzvGb0ni7xWm8J8z2WCun1dR3kQf02fBu6SOou3ydxqzUo7D72SDTN
 k2PwfYkQsKj+IG9NEq7LOdkbsN1UTYUSM1wlo/gXAS1H+/OYxAIgEbm44EQtImhc4aPWlDKG8gb
 lMFVzrmOoLciB2sEg7OflRX6vgOvbiq9+7LKyyG6z72MW99XOJxgATQpC5c2Ozfe+8hsHdiLtjq
 0lXXFCHrgLokctLsnbvUmEEo64jMY5SZUqKrcJdcGMVTsN+Hsbph2uIekIS4VcoR210gpE8nVjp
 lLD1Qb6wqp/sIp2ieNnkbvMQhPzHwaCbKwZKdUlVcDWX8F3sLqzHvQXr5koy9VbspI/qbjzskzG
 9DTtIJOVy5sbX1KWEao9HgZ+dipVOa
X-Received: by 2002:a17:90a:d888:b0:37f:9ce1:735a with SMTP id
 98e67ed59e1d1-38f6a556c28mr3900727a91.27.1785266845926; 
 Tue, 28 Jul 2026 12:27:25 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:25 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 24/24] hw/arm/boot: Skip bootloader for confidential guests
Date: Tue, 28 Jul 2026 13:26:30 -0600
Message-ID: <20260728192630.240375-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102d.google.com
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


