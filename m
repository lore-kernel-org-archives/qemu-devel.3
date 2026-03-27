Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCAD10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65Dq-0001v1-Q7; Fri, 27 Mar 2026 07:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65Cb-0007qV-Q1
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:09 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w65CX-0000JY-Re
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:18:09 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43b7481f9d3so1157578f8f.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774610284; x=1775215084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Sc6A8mUH5H33CEhbJhf4m2nOob0B+CIV382Sacc+zU=;
 b=CQWhW8mxpojBqTu4WsPGMT5aR6KideQbgdCncVkUgpeKqR6zEC946GZI3vVoaPgKW9
 LiHr5Wuy/qat/pjyN7vj1Z+i0vryOq7KOtTtf3dMFE3TV2m5VNzoLy6Njg+eXfLR+cIx
 LBhxaeq7s8Uzbc7efWXqfKfrmO5B8uLxXeKRgxegO4SFbcUQ0emPXpYW6C5lO19YwfLl
 DsQkd86rz0JmZemcQ/QBzY/06Mq7OilmTGEncalKDpWUZpN7fOEBpyAfOz2ZBoe3ssMs
 8Oi1TraPLN39ZFaQYFFLUP7lPT8dJAg7j42JbsX8bIoOO2qUNfLFEZUg0J9+9LAxNYmn
 lvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774610284; x=1775215084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Sc6A8mUH5H33CEhbJhf4m2nOob0B+CIV382Sacc+zU=;
 b=ct4BsuB8HYNcSTLB5ig/qxnnMwT3ojPX6rKZ7PSwtmmmUHfBxdyNtISLgXhho6QMz4
 otXFipIl1qIJpV5FBWPRaFVRYc2Cg2B1j0iDQjCtUsMQd8bBUq7k9ef/fUHX6xpsG+d1
 BgpSfu7LPVHcEh8tCb6AJqv/9PVlbUGThIuz2ug58N0iMOet5Wtw5/RYIxPN+TLYmv/z
 lMVgtugRkpwrKhz5HjY0sz2TxoR0//Hp+05W15MkzNQm6IjIzau7Vj7AvqXhGed6Wq53
 QtO1O6FqOK5cLQK23J5dXIgQidwrMzl1FO/E4tkP5OmOOyve6eeh7D+IrVdZDjT8ZOMf
 GS2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxw24k9Fu5HvCtArMG/ENEnzfhm2uvOLwiw5BsYcQPzxk2rSEtXKGMChOegPsPSPJg/AEm4AFoMris@nongnu.org
X-Gm-Message-State: AOJu0YyZuhenEX/dkWAKnnaWKjrARTFraXsGzvFlLxVq8jP+zj1Ow06x
 leaYnVrC4bovhN5bwZlFLZ6aNyr0Y/IVd1cgk9CbxHP/ZDMa3rfaX3Q0uIRJ2JPJz9s=
X-Gm-Gg: ATEYQzxTr3idkRZVgZyI2PQlMbFJ7+spf52KnyBHB7KauRan1MZh0GR6x+I7mBgI/ST
 Vvz4artLubh4VxmuNqk3cBM9SC/4DCIfVIBQCPUy2xkoaiN28kJ7ykjxsyYl5hxzDVdbfauXb3f
 WOSEpS9bZp7BqsslLQZ271B21irY+3R102kVPMSfRQ+w4nSvlZIAiRPztFad0Vs271EVrwJURH0
 LePsKymVLRN1VShFwkpBMsJUY13LJgGhuIcTquNm7KBOlBVGM10m1CrkZ+OrAjVFKA0GKQHifeL
 ZTcnqLr7AEhAckNgL9mMr571xhZ1tMcBAA9mVVL4laLuBEumiKceA/jMKWLWCubauXCJ6Mwr0qS
 PmqPG8+gJBkIKjfRvA5Er8rOiRQRw1/NJT/OFl3NsHfhirFS0oxyF2X8wrI8E2afWtUbwYUeY2A
 9AigNwgvWYOYamDcmw3Mu859tgRfeac07poah733z5pjGDCPvBr/4YLycYHxBi0VEJPxvz9r4kB
 BcNhRSJu6vRkuj7nW5wk7Du8SDxkIHkfg9P31LsUQ==
X-Received: by 2002:a5d:5f42:0:b0:439:de1d:74ae with SMTP id
 ffacd0b85a97d-43b9e9fa204mr3373603f8f.22.1774610283900; 
 Fri, 27 Mar 2026 04:18:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm15484227f8f.18.2026.03.27.04.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 04:18:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 65/65] hw/arm/virt: Allow user to select GICv5
Date: Fri, 27 Mar 2026 11:17:00 +0000
Message-ID: <20260327111700.795099-66-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327111700.795099-1-peter.maydell@linaro.org>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
index 0aff58bc3c..0064491063 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3223,6 +3223,9 @@ static char *virt_get_gic_version(Object *obj, Error **errp)
     const char *val;
 
     switch (vms->gic_version) {
+    case VIRT_GIC_VERSION_5:
+        val = "x-5";
+        break;
     case VIRT_GIC_VERSION_4:
         val = "4";
         break;
@@ -3240,7 +3243,9 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
 {
     VirtMachineState *vms = VIRT_MACHINE(obj);
 
-    if (!strcmp(value, "4")) {
+    if (!strcmp(value, "x-5")) {
+        vms->gic_version = VIRT_GIC_VERSION_5;
+    } else if (!strcmp(value, "4")) {
         vms->gic_version = VIRT_GIC_VERSION_4;
     } else if (!strcmp(value, "3")) {
         vms->gic_version = VIRT_GIC_VERSION_3;
@@ -3252,7 +3257,7 @@ static void virt_set_gic_version(Object *obj, const char *value, Error **errp)
         vms->gic_version = VIRT_GIC_VERSION_MAX; /* Will probe later */
     } else {
         error_setg(errp, "Invalid gic-version value");
-        error_append_hint(errp, "Valid values are 2, 3, 4, host, and max.\n");
+        error_append_hint(errp, "Valid values are 2, 3, 4, x-5, host, and max.\n");
     }
 }
 
@@ -3827,7 +3832,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
                                           "Set GIC version. "
-                                          "Valid values are 2, 3, 4, host and max");
+                                          "Valid values are 2, 3, 4, x-5, host and max");
 
     object_class_property_add_str(oc, "iommu", virt_get_iommu, virt_set_iommu);
     object_class_property_set_description(oc, "iommu",
-- 
2.43.0


