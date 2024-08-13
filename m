Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589A2C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulh-0005O0-Fx; Tue, 13 Aug 2024 12:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulf-0005Eg-Dt
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:07 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdula-0001Df-JA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:53:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so43456655e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567980; x=1724172780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/XbK4W6WcusWbmEGz4mZUUTHPz5h7sU2/2RKWWgMjE=;
 b=qEpAocHAgUMzR8mEp5vXPgtPQlAr3eaXnOLZhP5fvhgeBoxghVWAWx8C2iH+vIuHw5
 QKAG3jHdmFjCfZF31VEzdHJ20bWzxEn2Tovsb7L5spFHJoBVAP0UIjv2KypG+QcRHF33
 g2MMFaqMl3NlOw+qqjKlZVMpP9Vz3DS7qQ5wpq23Up4BsGPJpHczfFpwORFa5w3XCgbR
 ++4Jgl+ZHxM8ZS7zoN224Q7PNhtGqy7MqiS2cpNMuKnRxoJ/wfhkzOw62sssuOvfLKr4
 H1iD8wDdxfNwqNh6oNS82FxZG63ezE6YNCgmKadNdVyBTGp99gk0MLGZ4wdGG+rRK8Ig
 5o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567980; x=1724172780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/XbK4W6WcusWbmEGz4mZUUTHPz5h7sU2/2RKWWgMjE=;
 b=qGmSSSD+nF7sp4w8JLIYuLkOMQJM33gMStglHvqHbq6k5YlWsxg0zVmw8rt56DOfIU
 wIeXvUglIQD+4XCttv2wsAPkFX7Omx/5Dhj3+RsE++OP1NShcA+H1okNK7fmtzcwVzJg
 VMs8MFaatMXPNGlkgfT20B0IspmgbBzYBlFDh5IRzsIhNwGnj0VPpBieGWvSpGG04bR1
 iREA0id8R8FYe/52ietqvX2Iro9FsLyQUspkmqtfZAhI3UyHH1Sz26WNxdivCN7V3I4C
 oe8/0UOSmQhS4eH0UCnHMOP+Fbz5oxBIt0ycOYV5dTPIF7dGj05uLVQEPWy01Xh9jStB
 FczA==
X-Gm-Message-State: AOJu0YyGo+oIY2xk+z+P1orGBx7nc4KLq6f8Ncdt0aiU3nKzOqfdN5+8
 11o2zm5gI5Mj3j+Wrk3tti/wx9oQvWMpUP0rc1tia+y0C6EviO0YcFsVIHtmqutFzHHinHj79Ts
 v
X-Google-Smtp-Source: AGHT+IHoMIxvrbbFp4iUPGngKiVpIzxkjj5OCsUaU+6ek0DDvo4QQAzXxuR1FwXZxNqkC6qcUt5a9g==
X-Received: by 2002:a05:600c:4e88:b0:428:150e:4f13 with SMTP id
 5b1f17b1804b1-429dd268180mr837055e9.33.1723567980021; 
 Tue, 13 Aug 2024 09:53:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 10/10] hw: Remove device_phases_reset()
Date: Tue, 13 Aug 2024 17:52:50 +0100
Message-Id: <20240813165250.2717650-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


