Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF31AEC1112
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 17:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuZMR-0004sN-IK; Mon, 23 Feb 2026 12:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLI-0002xP-Kz
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuZLD-0000UR-5M
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 12:03:30 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4836f4cbe0bso34591755e9.3
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771866206; x=1772471006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VaAbltozh/selDM1um1aR8XySGP5uwpWPXsGLFrou/8=;
 b=zM/xMWzW0g6hTmso6UPZojM/LrzaSdKed9azJjG0X3+yUYZlDEwBmOCjCYIHFRRtxo
 zgvFuqn4Qh3bNLR7+BybmVcCm3kWlq4TXe4Cmo2RwseZ9q42PDW0bURpRtDOnmxE61dN
 FtIUtLnQwfHmvHs8KqRIHct9xwK2fmCepKQJN60ydPvHixz+AJwN9YJLSAj57eu9n41t
 29Qk37XlWaqRNOp5v3hw9CFd13ZbIS9KZ7K1YhIwdc010H8Lxioujw5RdmJNb4wJNdpx
 Ykj0CGhpR8iPvBSnPwPToE/Vf8pPEIM6mI0Luf0PpIGBZkERxEsZl+8Tj8KvpXZ6R4jI
 35Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771866206; x=1772471006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VaAbltozh/selDM1um1aR8XySGP5uwpWPXsGLFrou/8=;
 b=wVvvdobSlLhuZjMZCTTQlxnZyjNbJVIFFL7GyAJ/vQn2z9Z8Kwnd8kGZeZrvx6CheV
 3HzhNfyl0U8vdBnRkIHf3drM1Hl5YCVwAS6rSpyB84IotM/crZTcH3/fWTIEq08cD9eR
 qcE3XKo7kSh7qFD8ws4Gnwy3Y6MuDh75Br6PrcSqY6ubKTKKFYTfIaXjYKtQlqndOWcW
 NWE26x8It5rqAln0pswFwcUes3siuz9qSed9rRq1pwIrjuQQo+xwRZBcpjnqlKYvbM8I
 c5TtM3+xymS7aX3/L3JsRDhr4858FOjwOdyzlw2kLN/IJ0Axp/X/nO0eHqq/cTjTcV1z
 AmDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYvNkJkh1OY8WI/blPY2KN7jqxo8xV6p949ee2MTwdRlOzcb3ZWbAgdXa5T1Qy32AfG6DDYZuSkeya@nongnu.org
X-Gm-Message-State: AOJu0YweKqvOviQuzvjualg3T8ATXCsegkuxyq4yhSkSf5fd0Br8t3TJ
 HkqXshBSZPcbV2JIg9Oaty6MrxTCnbOcqoGyb8AyKE4KOasclhPjiwPuVBd1gYdy2KSlQezmsgb
 oTYfU
X-Gm-Gg: AZuq6aIbgy7kwsfLosSmOVGgwx7vZUNSB77vkEK7GJZ4NMPDliIygpsoJWn3XbSvMZA
 8nAcmT8kdZLevfYTnlj0tA4xozvCQBhiyhSg743EniQPRxg3vX4uDAyDkwH3Kule0tCurGIgNly
 4ss2IegPMZWFRHLN9EGbNFTgdNQhbJGsdDvfu5jprZN9dHG7buZnY7OT2sScTH2hWY1ArrvU4nY
 2qtuyMvI5LXX1cl4ptlL6fiK+5bTRxBzWWP4jyUhkihXDMHG6q9YTNeh2cx+lVWWAjM5TOF2yqH
 KvvksjB5LPI4uPlgWc4jInBwleXXZb+EyIf8LtMIjo+fPnZVhKR0C/RRP4Bw5C0j0sL/LYt0Wj4
 Nn9EY5zHXHEzk+8E/L1x7iT45P+u5TrYeWcx7hJl46/84KL7KJEuU5/1dEq3TjrMWn4sto19wlz
 EpKgSMz2VSfY1A4MvO3lBpfHvJ0jFSr3qcL7YhMqQDbLEsWtZKN+dqfMDt9Row//GMNODPeM8uu
 igjTYF8R5aKVz3yBCIvLxFukZMl414=
X-Received: by 2002:a05:600c:4749:b0:480:69b6:dfed with SMTP id
 5b1f17b1804b1-483a95e5ab8mr160471345e9.24.1771866205620; 
 Mon, 23 Feb 2026 09:03:25 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a9b21ceasm200155625e9.0.2026.02.23.09.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 09:03:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 65/65] hw/arm/virt: Allow user to select GICv5
Date: Mon, 23 Feb 2026 17:02:12 +0000
Message-ID: <20260223170212.441276-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223170212.441276-1-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

 * the GICv5 architectural spec is still at the EAC level and
   could have minor changes between now and its final version;
   only users who specifically want to start working with the
   GICv5 should select it
 * QEMU's implementation here is still not fully featured,
   and selecting it instead of GICv3 will mean losing
   functionality such as MSIs
 * the GICv5 is not backwards compatible with the GICv3/GICv4
   for system software, so silently "upgrading" an existing
   command line to GICv5 is just going to break existing guest
   kernels

The last one in particular suggests that even when the emulation
moves out of "experimental" status we will probably not want to
change "max".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 19 +++++++++++++++++++
 hw/arm/virt.c            | 11 ++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index f8148b5dcf..e38c567279 100644
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
index 1c684b59b4..ca95cc9f73 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3195,6 +3195,9 @@ static char *virt_get_gic_version(Object *obj, Error **errp)
     const char *val;
 
     switch (vms->gic_version) {
+    case VIRT_GIC_VERSION_5:
+        val = "x-5";
+        break;
     case VIRT_GIC_VERSION_4:
         val = "4";
         break;
@@ -3212,7 +3215,9 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    if (!strcmp(value, "4")) {
+    if (!strcmp(value, "x-5")) {
+        vms->gic_version = VIRT_GIC_VERSION_5;
+    } else if (!strcmp(value, "4")) {
         vms->gic_version = VIRT_GIC_VERSION_4;
     } else if (!strcmp(value, "3")) {
         vms->gic_version = VIRT_GIC_VERSION_3;
@@ -3224,7 +3229,7 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 2, 3, 4, host, and max.\n");
+        error_append_hint(errp, "Valid values are 2, 3, 4, x-5, host, and max.\n");
     }
 }
 
@@ -3792,7 +3797,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
                                           "Set GIC version. "
-                                          "Valid values are 2, 3, 4, host and max");
+                                          "Valid values are 2, 3, 4, x-5, host and max");
 
     object_class_property_add_str(oc, "iommu", virt_get_iommu, virt_set_iommu);
     object_class_property_set_description(oc, "iommu",
-- 
2.43.0


