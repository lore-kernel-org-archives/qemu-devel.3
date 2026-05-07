Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AA7CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL127-0005vs-TI; Thu, 07 May 2026 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL126-0005sH-BV
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:02 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL124-00044E-GA
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:53:02 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so10277355e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169179; x=1778773979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l1DRfi7wMTnOi0BVOQSA9ApUBAxlQZ2UlQV8+IjhEyQ=;
 b=thFh+9aaUgWWz53pa1SXcPyz7c6Q7ZHCikiYCyhGlbVwoJElVVkML6mI91yRl/kEty
 P4l1pIEMoz+B2eou8w3kP1sVW0QZy4yKqVLjJ5/c0MazPymbEzFtUNKz6t2mYVzSWSW+
 3eRryXYzuDkunmdkuhVSP//Brjyl62ZX5RwxVxnAoach5vBmj4n5GVhBFN026H5M0RCD
 URtvTn3qLOMqo8SQwnQcfPwEm55MYIf3CTHXDj8QIk9wmWgSIVgrLzAqvDmEXMjPobYL
 2qQUt0sO5YNYL5VhVnMWBDicRliX7jT0IY88oUjWZHzp56hg4Yyr46UWIzH4rat6qJuR
 WQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169179; x=1778773979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l1DRfi7wMTnOi0BVOQSA9ApUBAxlQZ2UlQV8+IjhEyQ=;
 b=XZCyRVONIY5vaFbrNNDD/wC/JifN8IlLrmrh/l7m9xoXydir3s3DPJGJq6+GTFRDzn
 WNQ7jxMgyTiRyCjodDOmHgkTllVgBiLHPDvZ89yVDfolAyZVaUII1jWU/+/ZpMarly5i
 lXspybSiBmOgeAye5b/evCFokIwvaVIB/h6BexCVcDVx67OMI+u9RB6/ocL7Z8KV9w/a
 XMMNftadITEQTao7xKF2nYDSFtwKO3KF7Agfds/51hZhgoaT56RmbZ6+Cgerhl6LS1Vy
 +WZm3xDo+0foM7bXyvZahvzPL4uCD6yOra9FPqLwssVm5WEQUgsPas4SMzIGj/ow+glo
 EYiw==
X-Gm-Message-State: AOJu0Ywp2048rpPlFZ0qDT4+dKCxEWasAFJgBV7qZDkxtoGzjY57ibhm
 aE33selXRR0ETM1I9v8XVEUy8e4ZAyKYYqco4AdU/0YyTr5E/gEY1ZAJqOcn3BrH++7eJi+/OTx
 43AJ8
X-Gm-Gg: AeBDiesposcdeqsN8HlePw+rbyg4dA39H/jcKvvCyUSQINr4uyIteq0peBcLP/Aba9J
 Bt0oxLhSBkHx/R4fconBy3m/cFgmpt8Gz1OVYx4hIPCm8sZWUFXdT2LADYUGRmKp8EJVhGLB782
 VgeF6wdP2V2H33iSNrLot1FWcvbM8EnSzdcH9rf4Kb4znIxg7/lJbnXsLBMxaRffjHurUq7nzf2
 EKjI192BzlXKOYkbZQU+ENqPpoLEFNh1CRVKJZILYUBFmludYf3FCaxOO6eF9yKyV0x5jcNczR6
 TgG4SZq2u2XDLXBwOFBnz5wneHCTQ212IV8G5gKn1OdI14pXY5mpVwawkAn1vmpfR1OWE4S2zui
 KqUCP2lYSTNCuZ/QifjViO5Pvwv9shL0t3bnFu50WMog/7yjElrN9zceMdTxy2DmqStLb9+P+Vx
 iZGFWmgmJKOj1jCr5HkwXXkexZKNDiaJ0pNgSYsST3N5f4gdkkktvfjpGhGRJe5NQz97mx5Lq1O
 m6QkXJln6o9mbXZE5VKv88Vrr3w3v4=
X-Received: by 2002:a05:600c:4449:b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-48e51f2e67fmr137884255e9.11.1778169178673; 
 Thu, 07 May 2026 08:52:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 65/67] hw/arm/virt: Allow user to select GICv5
Date: Thu,  7 May 2026 16:51:52 +0100
Message-ID: <20260507155154.1886557-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Allow the user to select a GICv5 via '-machine gic-version=x-5', and
document this.  The 'x-' prefix indicates that the emulation is still
in an "experimental" state as far as QEMU is concerned; the
documentation describes what "experimental" means for the user and
what parts are not yet implemented.

We do not make 'gic-version=max' enable GICv5 here because:

 * the GICv5 architectural spec is still at the EAC level and could
   have minor changes between now and its final version; only users
   who specifically want to start working with the GICv5 should
   select it
 * QEMU's implementation here is still not fully featured, and
   selecting it instead of GICv3 will mean losing functionality such
   as MSIs
 * the GICv5 is not backwards compatible with the GICv3/GICv4 for
   system software, so silently "upgrading" an existing command line
   to GICv5 is just going to break existing guest kernels

The last one in particular suggests that even when the emulation
moves out of "experimental" status we will probably not want to
change "max".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-66-peter.maydell@linaro.org
---
 docs/system/arm/virt.rst | 19 +++++++++++++++++++
 hw/arm/virt.c            | 11 ++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index fbe3ca9e12..f811e662d6 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -161,6 +161,25 @@ gic-version
     GICv3. This allows up to 512 CPUs.
   ``4``
     GICv4. Requires ``virtualization`` to be ``on``; allows up to 317 CPUs.
+  ``x-5``
+    GICv5 (experimental). This is an experimental emulation of the GICv5,
+    based on the EAC release of the GICv5 architecture specification.
+    Experimental means:
+
+    - guest-visible behaviour may change when the final version of
+      the specification is released and QEMU implements it
+    - migration support is not yet implemented
+    - the GICv5 is not exposed to the guest via ACPI tables, only via DTB
+    - the way the interrupt controller is exposed to the guest and the
+      command line syntax for enabling it may change
+
+    The current implementation supports only an EL1 guest (no EL2 or
+    EL3 and no Realm support), and does not implement the ITS (no
+    MSI support).
+
+    Note that as the GICv5 is an Armv9 feature, enabling it will
+    automatically disable support for AArch32 at all exception levels
+    except for EL0 (userspace).
   ``host``
     Use the same GIC version the host provides, when using KVM
   ``max``
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 75b20cfc9a..10b1954382 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3570,6 +3570,9 @@ static char *virt_get_gic_version(Object *obj, Error **errp)
     const char *val;
 
     switch (vms->gic_version) {
+    case VIRT_GIC_VERSION_5:
+        val = "x-5";
+        break;
     case VIRT_GIC_VERSION_4:
         val = "4";
         break;
@@ -3587,7 +3590,9 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    if (!strcmp(value, "4")) {
+    if (!strcmp(value, "x-5")) {
+        vms->gic_version = VIRT_GIC_VERSION_5;
+    } else if (!strcmp(value, "4")) {
         vms->gic_version = VIRT_GIC_VERSION_4;
     } else if (!strcmp(value, "3")) {
         vms->gic_version = VIRT_GIC_VERSION_3;
@@ -3599,7 +3604,7 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 2, 3, 4, host, and max.\n");
+        error_append_hint(errp, "Valid values are 2, 3, 4, x-5, host, and max.\n");
     }
 }
 
@@ -4192,7 +4197,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
                                           "Set GIC version. "
-                                          "Valid values are 2, 3, 4, host and max");
+                                          "Valid values are 2, 3, 4, x-5, host and max");
 
     object_class_property_add_str(oc, "iommu", virt_get_iommu, virt_set_iommu);
     object_class_property_set_description(oc, "iommu",
-- 
2.43.0


