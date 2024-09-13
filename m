Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C8AFA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80F-0002OJ-4h; Fri, 13 Sep 2024 11:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp806-0001qa-D8
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp803-0007m3-Co
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so14106245e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240458; x=1726845258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mnv/J1Z1Rw3t69Me+R9k35D204OTX7owdK5k3oeHGi8=;
 b=Jx2kRyt163tkKybAJqtI5kS2K/IA/JvC18uRqnjTJc0UvjeeMz0UDX6Nii71DPgOg6
 pUYYXB/79X57Nfub2PxKPQQJQ2Eeu3q/EY4pBzMZTNvGmXqDQyhp0qpK1mqKhoS47Me4
 nxoTCs19eR2AhOYp+ZbasjXm1N4YsFxLcU6Y++ZBz9RthYl+VHnxDHobdOcB6gIFTZ/6
 e+mKO4hzncO+nIG2RNBgl9O3Ty6S7ivhTf/qUhGhI2XONqM7apN3EQRykut4IPHm0Beb
 k7IS6vRTy0ccczk34k68rK23DxJ6wZSI2Y6y/gbz9Lst+skcWcqtwfr8u+ysXmrfIeKa
 MJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240458; x=1726845258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mnv/J1Z1Rw3t69Me+R9k35D204OTX7owdK5k3oeHGi8=;
 b=hmVMHw2cqaXYTXFfe6mH4fM2pFp64EGlW8PErCVzt1R/gw5v9M0pm5KXxzX1LqX3yn
 KBxj4PX0cSe1JDF/Z4kdtfeKTmnJ0hdBBh7wfUJOLM6f3+FpNKSFe87a/UY2TnR/Cets
 NfL9nJmPNAS8oJT4hCurmzJ4u1b/L02oG4EjXmiRq9Uh5wrUa4Q6zmNA+a5EyiQ8TZVe
 KVCgrs7a/i5nQ4M/5Ki5nNUtMKbo0KKhA1geBTBbjRjYOzEYh9qJxrnP5wqnAdsx+I1H
 IC0s3Ms3qQeMZ8zp20ZJ9p4pkLFru7aRL92tmGaazT15ihGlG4o2d7wnV2IhCC7i1e0i
 P+eQ==
X-Gm-Message-State: AOJu0YyHlCl7xqPpt06Ey4c5dY4kLHo/aGfCdJXeT09J0w+fTvDP5wPI
 Ln5f5vrnldQXj5yk3ZfPegvGiQFLIZe0/wFOzg60Gc63UmRyxbaASAnI6wI/wS6+OmLsA1/fh0b
 r
X-Google-Smtp-Source: AGHT+IFCftEr0kCs9//SIOSsRuCd4X5C3aIp7IpKY4+H966yiMRDWsKOPo0KgHx/biHpZe8hVaFF/g==
X-Received: by 2002:a05:600c:1c12:b0:42c:b5a6:69bd with SMTP id
 5b1f17b1804b1-42d964e0027mr33713175e9.30.1726240457934; 
 Fri, 13 Sep 2024 08:14:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/27] hw: Remove device_phases_reset()
Date: Fri, 13 Sep 2024 16:13:53 +0100
Message-Id: <20240913151411.2167922-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Currently we have transitional machinery between legacy reset
and three phase reset that works in two directions:
 * if you invoke three phase reset on a device which has set
   the DeviceClass::legacy_reset method, we detect this in
   device_get_transitional_reset() and arrange that we call
   the legacy_reset method during the hold phase of reset
 * if you invoke legacy reset on a device which implements
   three phase reset, the default legacy_reset method is
   device_phases_reset(), which does a three-phase reset
   of the device

However, we have now eliminated all the places which could invoke
legacy reset on a device, which means that the function
device_phases_reset() is never called -- it serves only as the value
of DeviceClass::legacy_reset that indicates that the subclass never
overrode the legacy reset method.  So we can delete it, and instead
check for legacy_reset != NULL.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240830145812.1967042-10-peter.maydell@linaro.org
---
 hw/core/qdev.c | 51 ++++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 460114609b0..9af0ed3e1b7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -747,38 +747,16 @@ device_vmstate_if_get_id(VMStateIf *obj)
     return qdev_get_dev_path(dev);
 }
 
-/**
- * device_phases_reset:
- * Transition reset method for devices to allow moving
- * smoothly from legacy reset method to multi-phases
- */
-static void device_phases_reset(DeviceState *dev)
-{
-    ResettableClass *rc = RESETTABLE_GET_CLASS(dev);
-
-    if (rc->phases.enter) {
-        rc->phases.enter(OBJECT(dev), RESET_TYPE_COLD);
-    }
-    if (rc->phases.hold) {
-        rc->phases.hold(OBJECT(dev), RESET_TYPE_COLD);
-    }
-    if (rc->phases.exit) {
-        rc->phases.exit(OBJECT(dev), RESET_TYPE_COLD);
-    }
-}
-
 static void device_transitional_reset(Object *obj)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(obj);
 
     /*
-     * This will call either @device_phases_reset (for multi-phases transitioned
-     * devices) or a device's specific method for not-yet transitioned devices.
-     * In both case, it does not reset children.
+     * Device still using DeviceClass legacy_reset method. This doesn't
+     * reset children. device_get_transitional_reset() checked that
+     * this isn't NULL.
      */
-    if (dc->legacy_reset) {
-        dc->legacy_reset(DEVICE(obj));
-    }
+    dc->legacy_reset(DEVICE(obj));
 }
 
 /**
@@ -788,7 +766,7 @@ static void device_transitional_reset(Object *obj)
 static ResettableTrFunction device_get_transitional_reset(Object *obj)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(obj);
-    if (dc->legacy_reset != device_phases_reset) {
+    if (dc->legacy_reset) {
         /*
          * dc->reset has been overridden by a subclass,
          * the device is not ready for multi phase yet.
@@ -819,19 +797,14 @@ static void device_class_init(ObjectClass *class, void *data)
     rc->child_foreach = device_reset_child_foreach;
 
     /*
-     * @device_phases_reset is put as the default reset method below, allowing
-     * to do the multi-phase transition from base classes to leaf classes. It
-     * allows a legacy-reset Device class to extend a multi-phases-reset
-     * Device class for the following reason:
-     * + If a base class B has been moved to multi-phase, then it does not
-     *   override this default reset method and may have defined phase methods.
-     * + A child class C (extending class B) which uses
-     *   device_class_set_parent_reset() (or similar means) to override the
-     *   reset method will still work as expected. @device_phases_reset function
-     *   will be registered as the parent reset method and effectively call
-     *   parent reset phases.
+     * A NULL legacy_reset implies a three-phase reset device. Devices can
+     * only be reset using three-phase aware mechanisms, but we still support
+     * for transitional purposes leaf classes which set the old legacy_reset
+     * method via device_class_set_legacy_reset(). If they do so, then
+     * device_get_transitional_reset() will notice and arrange for the
+     * DeviceClass::legacy_reset() method to be called during the hold phase.
      */
-    device_class_set_legacy_reset(dc, device_phases_reset);
+    dc->legacy_reset = NULL;
     rc->get_transitional_function = device_get_transitional_reset;
 
     object_class_property_add_bool(class, "realized",
-- 
2.34.1


