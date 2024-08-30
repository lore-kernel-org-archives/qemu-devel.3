Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC54CA0FFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk350-0005CR-UN; Fri, 30 Aug 2024 10:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34z-00056d-1r
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34x-0004cA-6Q
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42bb81e795bso14416015e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029901; x=1725634701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sl5Nme3PSgR/2emuPf+24SmFqGw+r/hG48Mwdwzeoeo=;
 b=p37PXimPxmpsvHUeJ7TFXWMBprenhyw/r4buQn9EMT/QqEufQq5/dbq5jLuQx/lrPl
 ZSXV+VKjXusDiIfzVkgisan/UEZrwtUlJvW8BwJeJ6IKhfLXrTNTR6W7vRPRxUEMpKl2
 WiPKbpavBDmtrYDk+QwckCy1Ul6NzjtjFnIFQoDnK+hUd1Qp5cirA7Le4yGI6ED5LOwH
 esqHAmAI5zoAc9JJsMXGRoMoQUt718eukcYiaE5YBBWv7O6tfBVAsATWr61UmdF9fwJo
 4QgEmnGQhvy0Wj1iA2/pUo0M+G6JPFco8PwfxO7TsK4rLGbcS1qXtRiyiSoQClyJ36MQ
 QMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029901; x=1725634701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sl5Nme3PSgR/2emuPf+24SmFqGw+r/hG48Mwdwzeoeo=;
 b=mXPgEUj6cBZuiawnYEmqwGlhnw8wr9mm/2LajfGngWq3kP32lDd8xbHAqxbN4wMHF5
 HbsnRHXFEy/nlcAP/Sxmo8ROuI1aYv3CdzGB8wn8HxL9UXJI2n44OR5+aoAMchK5rChL
 8sX6x7y4MBZa0XsOyE06oFX0ujIOnBdEQgwQ5pqtNz9WQcFjzcT/4E4wCbU0LT0kd83e
 hi5t+ewNgLT1Q6m6ZaWDlIfa1r7g7yoX95HskMcqqlFapWM2YqEDTUNO/S8XQEIhh0B9
 NmErcshGvp/wkc9UZw8chjPppHMihLC38XGaiamLuikicZqt8anp3s1xvKfVfSV/n90D
 lVxQ==
X-Gm-Message-State: AOJu0YwBojv2tynxkTC3meLpqg/pZDaAt09N+k2tE8lPYqMBnAMMC6wR
 H5R4yPIXSl9Eah7jBoIUKyvSQK8bNLDYV+GuigxlKJCn0oIJ+89w3jUxQU+7vBq+DYlGI+y7m8d
 q
X-Google-Smtp-Source: AGHT+IEtVm4ZzCVdjJ1emDp2VDHslTVgWP2qYNHbd/xvZLle1rkcAVhSja3nM3TK3LHWBdAbTK1P4A==
X-Received: by 2002:a05:600c:1d94:b0:427:ff7a:794 with SMTP id
 5b1f17b1804b1-42bbb10d2abmr21493975e9.4.1725029901531; 
 Fri, 30 Aug 2024 07:58:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nico Boehr <nrb@linux.ibm.com>, Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 10/11] hw/core/qdev: Simplify legacy_reset handling
Date: Fri, 30 Aug 2024 15:58:11 +0100
Message-Id: <20240830145812.1967042-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that all devices which still implement a the legacy reset method
register it via device_class_legacy_reset(), we can simplify the
handling of these devices.  Instead of using the complex
Resettable::get_transitional_function machinery, we register a hold
phase method which invokes the DeviceClass::legacy_reset method.

This will allow us to remove all the get_transitional_function
handling from resettable.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/qdev.c | 55 ++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9af0ed3e1b7..db36f54d914 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -747,35 +747,6 @@ device_vmstate_if_get_id(VMStateIf *obj)
     return qdev_get_dev_path(dev);
 }
 
-static void device_transitional_reset(Object *obj)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(obj);
-
-    /*
-     * Device still using DeviceClass legacy_reset method. This doesn't
-     * reset children. device_get_transitional_reset() checked that
-     * this isn't NULL.
-     */
-    dc->legacy_reset(DEVICE(obj));
-}
-
-/**
- * device_get_transitional_reset:
- * check if the device's class is ready for multi-phase
- */
-static ResettableTrFunction device_get_transitional_reset(Object *obj)
-{
-    DeviceClass *dc = DEVICE_GET_CLASS(obj);
-    if (dc->legacy_reset) {
-        /*
-         * dc->reset has been overridden by a subclass,
-         * the device is not ready for multi phase yet.
-         */
-        return device_transitional_reset;
-    }
-    return NULL;
-}
-
 static void device_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
@@ -800,12 +771,9 @@ static void device_class_init(ObjectClass *class, void *data)
      * A NULL legacy_reset implies a three-phase reset device. Devices can
      * only be reset using three-phase aware mechanisms, but we still support
      * for transitional purposes leaf classes which set the old legacy_reset
-     * method via device_class_set_legacy_reset(). If they do so, then
-     * device_get_transitional_reset() will notice and arrange for the
-     * DeviceClass::legacy_reset() method to be called during the hold phase.
+     * method via device_class_set_legacy_reset().
      */
     dc->legacy_reset = NULL;
-    rc->get_transitional_function = device_get_transitional_reset;
 
     object_class_property_add_bool(class, "realized",
                                    device_get_realized, device_set_realized);
@@ -817,8 +785,29 @@ static void device_class_init(ObjectClass *class, void *data)
                                    offsetof(DeviceState, parent_bus), NULL, 0);
 }
 
+static void do_legacy_reset(Object *obj, ResetType type)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(obj);
+
+    dc->legacy_reset(DEVICE(obj));
+}
+
 void device_class_set_legacy_reset(DeviceClass *dc, DeviceReset dev_reset)
 {
+    /*
+     * A legacy DeviceClass::reset has identical semantics to the
+     * three-phase "hold" method, with no "enter" or "exit"
+     * behaviour. Classes that use this legacy function must be leaf
+     * classes that do not chain up to their parent class reset.
+     * There is no mechanism for resetting a device that does not
+     * use the three-phase APIs, so the only place which calls
+     * the legacy_reset hook is do_legacy_reset().
+     */
+    ResettableClass *rc = RESETTABLE_CLASS(dc);
+
+    rc->phases.enter = NULL;
+    rc->phases.hold = do_legacy_reset;
+    rc->phases.exit = NULL;
     dc->legacy_reset = dev_reset;
 }
 
-- 
2.34.1


