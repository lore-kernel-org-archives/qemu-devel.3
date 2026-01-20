Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2ACCA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG5J-000758-By; Tue, 20 Jan 2026 13:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4w-0006bC-Ea
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:52 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viG4u-0000T4-2h
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:03:46 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43590777e22so539478f8f.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768932222; x=1769537022; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCPqRpQUUqzqFmpPhdz1jQmtLeDG3BlVkhJSsKOlHuY=;
 b=UbOU/51hS0AOV++3d6AIMK6JVnfRAwVUZf0KTeI5o81yHnvBIxHPYrhZuXdf3hGUaD
 n62Yj19EHtXvAfKt3coMto3Dehu8VftE6ggd+itI2BUy0k6JURWVlF3tWKAnt3LxSVY0
 67aIJ2LUIuKT7tYHdR6hQgPbCcj4LrQO/yHX4dV5Koq6T0ApuX4yHSu8Fot2J1aBAfNH
 BaVE20E8FtLetOvVU3aD6kMw4zFC+AHCfNIzTUiRO3Fx/pPWfqQ8QsR+7kuCCwP1Di65
 SDJz+J9XtIxGzoSpKonka1sOB6m3dCSKoHaRPsobQMD1gxuheHKiMCm9W5KpLQvswC0b
 Cx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932222; x=1769537022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jCPqRpQUUqzqFmpPhdz1jQmtLeDG3BlVkhJSsKOlHuY=;
 b=LzOzXv46pMq/S3eWHRFi3VaXRL6X3nJ3Lsc5EfC0T2EK4Wums7gOntmM67ibyKIRC0
 fYGX1AMGr3OwJ4eLPLNae6dnMynnrhli2ceaQBvTjz4Vp1NINSRCy5P/vH5lXCJkTBra
 VnQVux3V3gdjhkxMA4pwiz2LLht749ZiEt+7mrfh+qQE749UmBhMqDMyitnnG62Ynvpm
 L9H4daYc6q5fUVRPyfDLhu+D/7kDKjki2EFY9kpGnyQ4bfDHTSJGiHc4zTpAQC1oitbn
 RU+t5NoXAgQPv1SRTDjyqszx92rUCDMXRZZU6d1ecj+KNe85hXGCIHgExB1hsh5ugq2y
 q+dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSCIBbje+LHGzt4+xQ9jtuPndk6KhOPgy/uQSohBpfNLJb2jY4x7G0J6QOTgrYGTYO9fHSIZpskzIh@nongnu.org
X-Gm-Message-State: AOJu0YwS4FUdUkGvdhEOmWeBGwLw03CJPYPciMAon7pdCTT3zZ+MleqJ
 +3uJNJQt82iXq1pPjOJWqco2LR6CqqONWQ264ZN93qylXeNhlxjxUYDuSv0RflwmPgw=
X-Gm-Gg: AZuq6aKsf366guWRUGG2+cKWXX0O4127txxO2WNQDFN06KjwdpMpzKRLF9gQNiCPT82
 cX3HOZ4iVNSluha8n6NYV7TZemZPCdGT9H4y+ksHB/M1SVxcik7r9IW9D3qWvKx2LZNElP+XHWD
 Sza6sv3C/b2o6CbyH/Cyrqp2yUnGgOt0rW8p6LDaiW9h7sxOuzk4qliQD7bEo6XheWHPSm9+bKa
 UJa8aNR9ctuwHHgl2j50naQigu51fVvuu1StCiJ4XVvO4UDNBmF+Gu2PuWYDjGDt5gQAs11yi+K
 cIHJ/v1XyfBVU9W06sgekJw7joUIpSEJSoVzTFdAswBcU8JZ51JyNFA4rg/u9KJD8dyz6vRx9Qk
 mZTEvlNiOFxz76PB1AyW1JgHRNcoNNp9Ij3/Y730bdMPdSL4uFC03ckwp8SKh+RDlgwzFhvs1e3
 WjhoLHi+P8qqSh/1PNuhpJVqbG11UiFS7fB2KXzDDDq4dHt4uf7D7b
X-Received: by 2002:a05:6000:2281:b0:431:16d:63d7 with SMTP id
 ffacd0b85a97d-4356a05d461mr21542141f8f.47.1768932222095; 
 Tue, 20 Jan 2026 10:03:42 -0800 (PST)
Received: from mnementh.archaic.org.uk (mnementh.archaic.org.uk.
 [81.2.115.146]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cf58sm31310889f8f.22.2026.01.20.10.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 10:03:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 1/4] hw/arm/virt: Clean up MSI controller selection logic
Date: Tue, 20 Jan 2026 18:03:36 +0000
Message-ID: <20260120180339.1416328-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120180339.1416328-1-peter.maydell@linaro.org>
References: <20260120180339.1416328-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

The virt board might have multiple different ways to handle MSI
interrupts: via an ITS, via the GICv2M device, or not at all.  The
logic to select which of these we use is confusing because it is
controlled by a mix of versioned-board compatibility flags, board
option flags, and open-coded logic inside the create_gic() and
create_its() functions.

Currently we set VirtMachineState::msi_controller as the very last
part of this, inside create_its() or create_gicv2m().  This field is
then used only in the hotplug pre-plug callback function.

As a first step in making this clearer to understand, move the logic
into a single finalize_msi_controller() function, which sets
VirtMachineState::msi_controller.  The actual machine creation code
can then look only at that field.  (This is a parallel to what we do
with the GIC, where finalize_gic_version() sets the
VirtMachineState::gic_version field.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a734..b55297455f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -738,13 +738,6 @@ static void create_its(VirtMachineState *vms)
     DeviceState *dev;
 
     assert(vms->its);
-    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
-        /*
-         * Do nothing if ITS is neither supported by the host nor emulated by
-         * the machine.
-         */
-        return;
-    }
 
     dev = qdev_new(its_class_name());
 
@@ -754,7 +747,6 @@ static void create_its(VirtMachineState *vms)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
 
     fdt_add_its_gic_node(vms);
-    vms->msi_controller = VIRT_MSI_CTRL_ITS;
 }
 
 static void create_v2m(VirtMachineState *vms)
@@ -775,7 +767,6 @@ static void create_v2m(VirtMachineState *vms)
     }
 
     fdt_add_v2m_gic_node(vms);
-    vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
 }
 
 /*
@@ -957,10 +948,15 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     fdt_add_gic_node(vms);
 
-    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_NONE:
+        break;
+    case VIRT_MSI_CTRL_ITS:
         create_its(vms);
-    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
         create_v2m(vms);
+        break;
     }
 }
 
@@ -2079,6 +2075,24 @@ static VirtGICType finalize_gic_version_do(const char *accel_name,
     return gic_version;
 }
 
+static void finalize_msi_controller(VirtMachineState *vms)
+{
+    /*
+     * Determine the final msi_controller according to
+     * the relevant user settings and compat data. Called
+     * after finalizing the GIC version.
+     */
+    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
+        if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+            vms->msi_controller = VIRT_MSI_CTRL_NONE;
+        } else {
+            vms->msi_controller = VIRT_MSI_CTRL_ITS;
+        }
+    } else if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        vms->msi_controller = VIRT_MSI_CTRL_GICV2M;
+    }
+}
+
 /*
  * finalize_gic_version - Determines the final gic_version
  * according to the gic-version property
@@ -2251,6 +2265,8 @@ static void machvirt_init(MachineState *machine)
      * KVM is not available yet
      */
     finalize_gic_version(vms);
+    /* MSI controller type depends on GIC version */
+    finalize_msi_controller(vms);
 
     if (vms->secure) {
         /*
-- 
2.47.3


