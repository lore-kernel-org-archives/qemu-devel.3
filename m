Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6867CC54F56
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonSx-0003dw-UO; Tue, 28 Jul 2026 15:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSJ-0003SX-Vh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonSI-0001ZX-HT
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:11 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so246648a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266829; x=1785871629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O97834IMZHMJj8CNpJQMqMEGxl2bcDXLGwhFx5nEj0E=;
 b=JGvp3EC9S3QKc2++uBAqH4Q5I0O+DaoAUSg4jSpE8loaJH6Nf9sKjLNRHK6zhbnkHD
 eCFEAK0snC/ZtSIvQrYUw4Y/X74nBXKkaeugCfMyHKTMPBTb3TBLj/8Iv5oBcydeHE7j
 NIIOFEX9+PAdZEfqPzHjcwbDGJ6fm6LAxDzr9F53mPrXLZfz0QBfqLgqphoSTfEXl6Xl
 xptfsRrNBaxnsgnfgclph0vjgZjIDESeOkFaGZv/U1+wpvUrOjnFJtqNz0jCk+iWMoEf
 uHD5Dd83F5H+ImOwQlBkrhGOqbMDhW2hXUVpQIhBHV4os9xNX1zynudAy78OymxweBhP
 zBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266829; x=1785871629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O97834IMZHMJj8CNpJQMqMEGxl2bcDXLGwhFx5nEj0E=;
 b=Hq3jD4f/jmb7urS0deKBW3k5qKNQV6UTfFtrrES3PYLdI0LyoAUGf7pxrzcmlOrbNL
 ZeLv56B8llFAqoTQ1qwIKeRRr8ykfM/JsS8HnzqlS6pwS74fOvgeIqTYe7k80PmUpAeE
 eZCL2ILD6JaSUu7SgC520sd+bsHjblaWWBaZcacZo1wj0j5m6rDjyhoNGf7B29wfppQh
 6wtffXBVgDjUONXWX4N5Di1zpKxhfEcIFmbBXnf8s49cFN0RmwWDecPuVn8RJsJzRujU
 2b1AWAlMSGLS0/WZ9f7P4bK5bhNycLw/rz198nC/HMqZijdaFpi96hyNXmPStt+v0sBB
 dQhw==
X-Gm-Message-State: AOJu0Yz2uXDYsk0qqucg4y22AzvluOZPoMwiCvzQSOdVFvciAhVWTUUn
 J2TzIDonyeq2KiF4aBbW55laZg7vUs+qPUJ5I0YOtWWpqGlve9htMSStn2e09/98cZE=
X-Gm-Gg: AR+sD13vHWRtxJGLI50pThhPquYjPNGrzCyz+itiFH4Y52Y7Pp+0F+32vLrMaltc8qc
 Ei5Ztqw+0F3V/9OWd6zQ21Ia4yyYwAVIIl85oIghW7YoKfweJ0juAAj3Tmz2oEJESCg+x7wAC9W
 y5impy0iaieGUqn3S0gp/sg2Yxa1+sFYRQ+5OV4y0mQQ7nruAIzZuzdsS8KlUD8ojnzm+1GnW7E
 znSDkTjNf82CLidvAHJZhnuqxNW6RzIZdisGleisNjeNWsuiXc2/9c4AP764jPENDQHly257Ui7
 aP5ugx+0KYYmYFSGsEBVBXJ2wan5eu8a9rL26PmZbhvADa/kaDP1i9hT66aYpQZsoMTpZ8rwJdg
 TJ0yBiFc5nP/OjhVLUEBWuVGINH8AbxOFa9uci8BBy8ROUV4tgCNO2XOwZPWMVuVaC4nfoIgwhk
 L8RpG5EBYa3qZvoLxF6L4lGcT20aUs
X-Received: by 2002:a17:90b:4483:b0:38e:584f:2515 with SMTP id
 98e67ed59e1d1-38f6a465c40mr3652686a91.37.1785266829178; 
 Tue, 28 Jul 2026 12:27:09 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:27:08 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 16/24] hw/arm/virt: Embed Realm VM type with IPA address space
Date: Tue, 28 Jul 2026 13:26:22 -0600
Message-ID: <20260728192630.240375-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1029.google.com
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
index 27bed9755320..9123f46fae4a 100644
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


