Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2B2C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DEu-0001Xz-GB; Thu, 03 Sep 2026 15:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEr-0001Vl-VU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:45 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x2DEp-0004IJ-RT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:36:45 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so1360776a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788464202; x=1789069002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yYE9pOet48lRlcAA3fKM0Js3n1ztODOyy6XvoWvQ26M=;
 b=SQPD9hWTFokx2hy45BNdd5KDBy+HmaAC8mJewjQRj74g0woobMpOqk3yC+Qng90wV9
 dY94An4kwKUV7K5C0Mo+FXYbhmAEISait84gi4kvzsucU0Kj5ARfMhM/qdTI4ZTTNg46
 AC12+hAqRWDJlAOV0jo0MkM0+0FlbBvDRPHur2BC+uV1TBsOSmaiESlN+by1AcdyQavN
 l/rd5z1hFVhCCvUEJBX8yffF4CPp/Q8B9/YWoT9/eJpH+p13gtYMRmLHv5sjH7w0uh7j
 /ZDGDQj90UIC5FylUglarDnPzah/lh+nbprCKF1MOzl+5dPE/fO2pagDJCEUcitItJiC
 V6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464202; x=1789069002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yYE9pOet48lRlcAA3fKM0Js3n1ztODOyy6XvoWvQ26M=;
 b=FGBFXpS2qTjZnr3yFVAP1fkScvtnhtXM9iEMNw/qCK6kwP7rc9shgA1VoHcd8EDZZs
 4hw7DcZ/zkDI4bTn8Tr+O0zgA7Tfeysms0ETRiRCZHfnKDzNXR4UKLmntK/hS6Renkhr
 Oi91kxdxYjEDGI2YWbC1o/3xfZPHJzJT/dUQ21OzejlKOO8MmdOZBazkkyXRVJuRxjaT
 k33qKz1sRM0tcnM6hwpYw6wo4IhIfccTGhvOUf1JwHJxW2nu0dNc6rDwLMJ4gUREtOK9
 TLnSIU/cVYY0LzxNj0ZcjPhLaJgCHD33ClpNSH9J3pR/SpkcFqDcX73Lq4ri932K8Yb4
 V9fw==
X-Gm-Message-State: AFuF++kZl5WrT1xzweN7WbMQaFI1L+RTXBirMslzxihvpNo/fMcXAbdR
 M7NPzQ9Qbp1XmQsM5ylx7plZDQ4hfQnJnD0dEZy8zQ52Ev03q5qWliB0OozH+55GzUo=
X-Gm-Gg: AYBFou26X4W8o4JKZ/tVvuvBocOwfGpopNIwzCnE7Ry+pEK+G7rSiVTOEk/bTo9YpE/
 RF6ubq6ik3hYL3eUFP/h60Bu9/tGjXWqikxskDt6Vw/t8GgwkiQ2xsbNoqBlFxw+ccjtKRtQzLa
 VbHI+y8s2/mkSRIE0vCH3hOBvCEjRuwksaE1QfP+uXLsxFHtIdcrHEnf3kdUW70k6226SU9G2xy
 EJ5PCqs11lV2nU6CkqCm9fpmXLyCNRzrDIXtMqbNLjwPnnTcI/lNA+pyswoURDtuDsO/EY6v61J
 kN+ABjC09PAcfQI2wuITz2kb3g1ky1WgnO2APgmZWAAO1QifNju4TTC99WYo3UQDxOmh1AkMogQ
 XtevevbZ3/qudU6M+/ubd15eNCI3h8xONG7eDdxlwCIH9h+O7FwrWldLRdKLyZpEMdUo+EEu5zj
 4be0mCPj73rsmmcF1wyL8zY5uq3ku9G9Gpnh+UZ5Mp6eZ+nRCJYC8zzM1MYVljoQSxayExezlW8
 VX68FMGKAxSWEM=
X-Received: by 2002:a17:90b:5484:b0:384:927f:3db9 with SMTP id
 98e67ed59e1d1-39b27c0fa43mr86643a91.1.1788464202333; 
 Thu, 03 Sep 2026 12:36:42 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:36:41 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 mathieu.poirier@linaro.org
Subject: [RFC v4 16/24] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Thu,  3 Sep 2026 13:36:03 -0600
Message-ID: <20260903193611.1058589-17-mathieu.poirier@linaro.org>
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

Set the Ream VM bit in the IPA address space size when needed.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 37211bc81926..61751aa31e0d 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -97,6 +97,8 @@
 #include "qemu/guest-random.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 
+#include <linux/kvm.h>
+
 static GlobalProperty arm_virt_compat_defaults[] = {
     { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
 };
@@ -4053,9 +4055,12 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
     VirtMachineState *vms = VIRT_MACHINE(ms);
     int max_vm_pa_size, requested_pa_size;
     bool fixed_ipa;
+    int vm_type;
 
     max_vm_pa_size = kvm_arm_get_max_vm_ipa_size(ms, &fixed_ipa);
 
+    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
+
     /* we freeze the memory map to compute the highest gpa */
     virt_set_memmap(vms, max_vm_pa_size);
 
@@ -4080,7 +4085,11 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
      * the implicit legacy 40b IPA setting, in which case the kvm_type
      * must be 0.
      */
-    return fixed_ipa ? 0 : requested_pa_size;
+    if (fixed_ipa) {
+        return 0;
+    }
+
+    return requested_pa_size | vm_type;
 }
 
 static int virt_get_physical_address_range(MachineState *ms,
-- 
2.43.0


