Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0D1C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDuy-0006eA-9L; Fri, 11 Jul 2025 09:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu7-0004Xq-KH
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDu5-0003Nf-OG
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:35:07 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-454f428038eso6894685e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240904; x=1752845704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3KkAwbN1hZEC2FoNhPdG0KBNKiVsXfiwU6S1weZwVek=;
 b=YOlY1Syfewh5mmGUwk/O8puHGAC1KMzX/PUNkLXSZaZcfXX1MaGeUVqYK0kIWEniIM
 FDiM2dDbJi9CNZ36k30QwwjNII7KdmjlamERIEWGpWoFK2b2nwy82lwo1zIq9NkZyARb
 dZJUl+o7q9P/8zkUVXrlnp4GHMQSJODowyBQZjvHMMtlmftQD2s5nmqQwm4Thn1hBGDm
 iHn+n93zXV2WhrVOLtdIWgT/ZHm79eZxo+wY7vr7W4hiUiqgtRk2l50OSSxx5rP4JRqT
 3byukVjIA4aWSterbQKUCAe5vxnSlTsJGsR44HJ+6NykGAtjLwxaiLjQvLTx6gyf9pQR
 sI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240904; x=1752845704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KkAwbN1hZEC2FoNhPdG0KBNKiVsXfiwU6S1weZwVek=;
 b=JEnFVST41F3Ih1X6sW4Z/FIYZk28jNfS2zdiiGoN1LcsrtkiP1Nz+I1LbUPvcN4LNe
 cy4VR1F9NQo3ckV2QyVs0CXGidKKJyZ4te6S9ndJl4fGwK8ML9AxP81I7ujaOe5be6oK
 AKKlcjVD7u/K3uXFMDt8PhfyN6iB/vukZ0/sQbHAoa45xPuNvDOd2J4I1qRp2BdWKF0q
 GAnRrfdeVEvPTqihcp2Mb1ci1tyN8pSZT1PC/iWkGiU8fdTivgJ3qUqim9LuxEdUJfBT
 1QPXYz9gVIrJtJdc2uxi39j7XPbrb+RBPxsdQpFGtQK+bH/hV8bCEgMySYBT++IQvVMl
 /c/g==
X-Gm-Message-State: AOJu0YzbPGVqd8X+i9oXb/r1xsmjZvQT2XEeVaD9YTIctMjolZoDVC0j
 7GRrOPmTcWil6BLWWnINq4rNT+i5F0CZqhJOPTZmkhcwSNiO2aGZtvYg+krtCU5DnckqVNnEnff
 R8SZx
X-Gm-Gg: ASbGncs8h74jTsWlQAsylWoF+euS7ERToMKkxrOpG1E+Skt+gwwpdKh4k+kpJXKntRt
 LCeVsozwdZggSSXT4DdvpHy873RzV+lvR2b2PE7RBRNec8vIG4t0cF45baR5lCX6GjMoPp8Xaoq
 SlIVSAu4akhyl813UPBmv1hBIHiuDlcNpC7rJZv4wFNaEASqhcsFU8ngNdjmzUtO4iLXahKuX51
 wefpvMNO9h40J/HAkZ5tP7kE5XdphaFKg0lzPav7dpjnBGibgC4VCEdV4D9CC/RcpWWE29KJxii
 BiVfcxRTZAy+Q02qGFIm2kcivNAMSXaFbHVmjT9c9q66lIuM5ylvpPzoD2QwPeA/U1f1qzYZux2
 oF/WvmtzIjtPEm0LqvTT/KPP1tdbE
X-Google-Smtp-Source: AGHT+IE6H5Gc5o93MnQyjSKh7N465kjYDs/s29fC67QCd+EbdvgQnCIccLkbYv1Ns+gFg3fu2ppmLA==
X-Received: by 2002:a05:600c:1d14:b0:454:afb1:3bcb with SMTP id
 5b1f17b1804b1-455f7ed2d73mr4248325e9.25.1752240903743; 
 Fri, 11 Jul 2025 06:35:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.35.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:35:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/36] hw/arm/virt: Allow virt extensions with KVM
Date: Fri, 11 Jul 2025 14:34:24 +0100
Message-ID: <20250711133429.1423030-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Up to now virt support on guest has been only supported with TCG.
Now it becomes feasible to use it with KVM acceleration.

Check neither in-kernel GICv3 nor aarch64=off is used along with KVM
EL2.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250707164129.1167837-6-eric.auger@redhat.com
[PMM: make "kernel doesn't have EL2 support" error message
 distinct from the old "QEMU doesn't have KVM EL2 support" one]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c9f39919370..8070ff7b113 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -797,6 +797,13 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     default:
         g_assert_not_reached();
     }
+
+    if (kvm_enabled() && vms->virt &&
+        (revision != 3 || !kvm_irqchip_in_kernel())) {
+        error_report("KVM EL2 is only supported with in-kernel GICv3");
+        exit(1);
+    }
+
     vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
@@ -2092,6 +2099,10 @@ static void virt_post_cpus_gic_realized(VirtMachineState *vms,
             memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
             memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime);
         }
+        if (!aarch64 && vms->virt) {
+            error_report("KVM does not support EL2 on an AArch32 vCPU");
+            exit(1);
+        }
 
         CPU_FOREACH(cpu) {
             if (pmu) {
@@ -2237,7 +2248,13 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
+    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
+        error_report("mach-virt: host kernel KVM does not support providing "
+                     "Virtualization extensions to the guest CPU");
+        exit(1);
+    }
+
+    if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.43.0


