Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D59FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80J-0002Uq-FB; Fri, 13 Sep 2024 11:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp805-0001mb-NT
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp803-0007mE-TK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso21724075e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240458; x=1726845258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NsggWRJP3KBRd4q9MhVbNlsb0QgXLnb4719LpHM7BO4=;
 b=TR1on2ZiC9tjSl411W3LtZacrLw+dtq4ANl7PadI/6z64SwBZ+YUjdmvGoh719+t7l
 tM6sD6/yb2QrbCrNjzv+QBvOOxLwgmEWgJs2Hj8G+uISHbMO4vMdTpVQg83AdQcIH0/Q
 mnm4prrYSaJnc0W8x6oZrZV2iekVGY7fZvLUAf0q0RqlrTxqOzbE1veOuTDdYyT7K22w
 U1/3xVviu2LgbzlcFkIYcd7kBC/a4ABtfnxb2gAG4GdgQgt7jO6iRveoYBwZ59mXvtdi
 5cowSytUObcUesdziSSnv4tBzr8xuEh2g9hauqECfNgV2iitmZzIE6mYrmsD0cuzcLfx
 SXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240458; x=1726845258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NsggWRJP3KBRd4q9MhVbNlsb0QgXLnb4719LpHM7BO4=;
 b=HHsAwrDrkwvlaCty4PXGZ+9rBqxlKjVMzBjFRis86iOoAscb1Fcb4q4e26tyaTbpxy
 s55ESStxqkTBgWSi1XRfI/tuYW+MKiF2L4f3HP4Yyuxuw/8T0523/6YcGKRIWKdd5nSL
 61g5mTZp8x/3KVWDTK6ekzq4rk6T7/x9fa/d7DxJ9hOUjCxdkYeO53uOvYxaXeKgSoph
 0ktLjh6dnnudNp/6bewyKlGn8A93yOtnA2dlPs59Rs2j/0LyLRG1HUj/TAJuBYiRsU74
 cpNJJaQgN84cmt3/o4Kkz8w16hNPrKnt55GI6NT9YBZygRAyQi4sLnbu2l8QupKnl8AV
 PVLg==
X-Gm-Message-State: AOJu0YxNpVz6cTp98P50CQRtI7BM21PvUUM2E259hZ9QZiWncc+hACw9
 3B/zrktg5hREAh0ONsDP8z4P9cVXt/sUCOIPQDHp3sXck6BQYu2qqL/3CVS7dJX497E+K2mCmEZ
 e
X-Google-Smtp-Source: AGHT+IHd54mqYLBNgpLP2MHv3K8qbLcnA9H8YKFYTq0j8M21NZenf/PxuNY6UPgH7LfLNxTVhXO5Dg==
X-Received: by 2002:adf:e684:0:b0:374:c56c:fbb4 with SMTP id
 ffacd0b85a97d-378c2d0627dmr4000787f8f.22.1726240458393; 
 Fri, 13 Sep 2024 08:14:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/27] hw/core/qdev: Simplify legacy_reset handling
Date: Fri, 13 Sep 2024 16:13:54 +0100
Message-Id: <20240913151411.2167922-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Now that all devices which still implement a the legacy reset method
register it via device_class_legacy_reset(), we can simplify the
handling of these devices.  Instead of using the complex
Resettable::get_transitional_function machinery, we register a hold
phase method which invokes the DeviceClass::legacy_reset method.

This will allow us to remove all the get_transitional_function
handling from resettable.c.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240830145812.1967042-11-peter.maydell@linaro.org
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


