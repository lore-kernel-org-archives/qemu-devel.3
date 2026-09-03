Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2BBCC624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEu-0001Xb-6Y; Thu, 03 Sep 2026 15:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEt-0001Wh-5O
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:47 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEr-0004Jc-8A
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:46 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso159141a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464204; x=1789069004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y7O2QFPzNWx332l2m0iFWMqO57jF7lDWROu5Spv39Uc=;
 b=pgM3rZlGE+fILtvnRoyn/6Zzu3qkoTZUFPiHYVDIBWguTn8m7vU5Hs/1LxXQSOm4+U
 bLZc+bDDptEYn6hM6zVaV7npqKeHpdTQYtizZin5eSzWyzLFiMp4mnoqR7EuoKmoaAK5
 lnaXbShKRXqgbERIBHCj8LrWSF3+joKOfbgQ0c804f3fdSIg+kbXXoA6d4c44SC+sPLl
 P6LegvVwDbf+ABwmq5JU99wg5xQvBmsDkFt4ZX1s0JpHRPYTXk3vE56C+u+ZPX6Gmwoq
 UzzSoFNDfB9BbnZ3FrQoMqCpooGmBi0HPf9zJBsoS4l/WtBv+8orkrBz/guMloSXT274
 AXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464204; x=1789069004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y7O2QFPzNWx332l2m0iFWMqO57jF7lDWROu5Spv39Uc=;
 b=drTmbIqwcC9hZymluE7Vyt9GPY8fyCY9lJ2PzQZIvh789u8JIwwjk/10/6j0AyWZ1i
 6e5MZYtG7m/ooBSQyCtWXdszTaG1m0j16JKcXbN1PhAgUQsZlJ/A1WK61Qt+elE9ZHTK
 LB5yfLA0xoB+k2jApfdVDXMVT3d0fbzm0LG8XHjYVu7PUQI/WNgeWip6O5H2aKghfLc4
 JNuGD8SpngrekRUkw+jm9qTq/XB83hYV5xISwuFTlbJ+fgBnOkEW+cfV0uQNOJTUcIzN
 U0jcPwPXz89vyo3saSk2u+WCyPZ/nLtRHr2B47P8OmN7GfK9qRGxHj5gqexE4MP04oql
 toFQ==
X-Gm-Message-State: AFuF++mGZUn/3rC0LsNw7jz4AudexZGAe06kgRxAgYc3UwQQLuAt503x
 bfdXOuRrCe/bYVT73Jq9m5zr9th1XIGIrtqMEO/0WWeoCzlz3ciRlfVa3TxHjfMwgXw=
X-Gm-Gg: AYBFou3KcV8MY9u0kNMbMxxaVaFJklFUb2OSwjIlfy/EbbMPa7wOo6qek2ILsuOxaYJ
 5tZHGMtXRPzSaSwoBPLK0qMbPHBE9S73IbsXpiFOLYmZswOfMgVYFrUQy2YDxD1rzdezO7OfbH8
 ySWlWDUTuuCINrC/9mxk2k8OoRSXgPCzAmcuo7vc1flEk/PCRgRbmGw5kwvaNCiO+Ia6FIkdi6/
 vu8bGRMO8yhjqmqcu94xqoCGWzZoP6x6ShTp3ga/+b9W93/AFyg5czDOSf5BAkLjTHWkGA9s8dh
 pQvH1GrdsNSDCHPVOiSuKb1uPLAEk5GIKbNnYXYURoVYhe1PJzckPae5Dc7XNVxKknDcMNXiYIv
 h9b9CBRP33QuOFbrpstTSJeSuqL0/9X3ElHjKsBO/jyOK5M6ENsXQqs9YJFRIfRJuG2MlJuSooS
 bXkObIwuCDbOelTdrsuMb4VV75J1a19h31++xBVyISs/GCkYnTbwEcw6reopCEMjYRfKV7HRBOm
 G9WQ3X7sKNT0jw=
X-Received: by 2002:a17:90b:274c:b0:398:9be9:ab92 with SMTP id
 98e67ed59e1d1-39b2629b27fmr1266138a91.23.1788464203921; 
 Thu, 03 Sep 2026 12:36:43 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:43 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 17/24] hw/arm/virt: Reserve one bit of guest physical address
 for RME
Date: Thu,  3 Sep 2026 13:36:04 -0600
Message-ID: <20260903193611.1058589-18-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x102b.google.com
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

When RME is enabled, the upper GPA bit is used to distinguish protected
from unprotected addresses. Reserve it when setting up the guest memory
map.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 61751aa31e0d..cf3a9320dc3a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4054,17 +4054,27 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
 {
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
+    int rme_reserve_bit = 0;
     bool fixed_ipa;
     int vm_type;
 
-    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
-
     vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
 
+    if (vm_type) {
+        /*
+         * With RME, the upper GPA bit differentiates Realm from NS memory.
+         * Reserve the upper bit to ensure that highmem devices will fit.
+         */
+        rme_reserve_bit = 1;
+    }
+
+    max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa) -
+                     rme_reserve_bit;
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
-    requested_pa_size = 64 - clz64(vms->highest_gpa);
+    requested_pa_size = 64 - clz64(vms->highest_gpa) + rme_reserve_bit;
 
     /*
      * KVM requires the IPA size to be at least 32 bits.
@@ -4073,11 +4083,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
         requested_pa_size = 32;
     }
 
-    if (requested_pa_size > max_vm_pa_size) {
+    if (requested_pa_size > max_vm_pa_size + rme_reserve_bit) {
         error_report("-m and ,maxmem option values "
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
-                     requested_pa_size, max_vm_pa_size);
+                     requested_pa_size, max_vm_pa_size + rme_reserve_bit);
         return -1;
     }
     /*
-- 
2.43.0


