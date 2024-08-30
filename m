Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86202CA0FFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 14:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk34x-0004z8-1F; Fri, 30 Aug 2024 10:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34t-0004mr-IB
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:19 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk34q-0004Zx-Ra
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 10:58:19 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so11807055e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725029895; x=1725634695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+Su5X1w6A/5pz13eH5ngXgPfWm3ZLisgHu2KQunXaE=;
 b=E5bWNi44dSchAWBTj9YkiEz3s0eCRqUkcrxr79NEuqK6nDZyHCcFnFjpfqT9NtF0U6
 LlDmjYvHIDsEZsQ9H9vj7qHF5fJajOutPHzS6J/jdWwdO4UbkmeiwAy7hG/sv3j+kKyv
 AmaOv6kUeVmUULrWSS0joE0nvivW+nQgHlw4sEEZZF5HQUtbSf/xV0fK5l8fvw1WcN9d
 QWHuWplKnXEWsKDKKu1E9A75C6Hzv53hGtS+JdvPdYu65Noi5cbkf5K/cWvva9beyZV+
 yRQSPmSsIlHgfXsQ1sApBel8U4ko7iibHiTmvi1WstDE5avLe8H6a84lF2QOObRasmHT
 xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725029895; x=1725634695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+Su5X1w6A/5pz13eH5ngXgPfWm3ZLisgHu2KQunXaE=;
 b=OZspdEryhecRplRqZoCnNaDgR7Zv1Io5IiTnvjPx4NZPXT/xS7jE8h/Y1pl64W7pL+
 rLpdRvdbKj/Fxv5AG61X/RoZ9Hm7XO9PZkp53uqUnRGrGLohgXWFRH7R4ROpacvzy8U1
 uh4mZ26d4LPI0h+JBs51Zkl4wJV0ZDHkN5TOsALmYdTq3Yxok7+WPYVV8/lCes4FzTHT
 eeuC5phYqyLXBTSwbOqsQl5iQDAvt0pUju7HJmAQuU67PUgqrnp+LbbwlzxPe2IAc3fM
 yOqDbWJGyeVXvnvWa8/DDP1UuqdC0aw8uU79ii87KRuz1Sn0A24uXZ8SoAmkzuRUV9Fo
 arMw==
X-Gm-Message-State: AOJu0Yy7M3Qxc969QQVcoB1FKdCldXrbq6DQVCkYWvQr1J7t6abVXhfN
 4aesk06osgf6dp5PeVSrzJPXrqCfpmTNTawQ5U3ZoeE9fPVEaGOfIpF7Wso1HTyX9UaVi4/pwlf
 F
X-Google-Smtp-Source: AGHT+IF5I/rqJR35x8l5cW98CdSp0IhsdeW4zy4fDSNrnS35WT3OrciK4PIwtJZeK+PkdyuUx0zZTQ==
X-Received: by 2002:a05:600c:46d0:b0:428:b4a:7001 with SMTP id
 5b1f17b1804b1-42bb4e9ee1dmr39540225e9.15.1725029895243; 
 Fri, 30 Aug 2024 07:58:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6da24bbsm49022345e9.0.2024.08.30.07.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 07:58:15 -0700 (PDT)
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
Subject: [PATCH v2 02/11] hw/s390/virtio-ccw: Convert to three-phase reset
Date: Fri, 30 Aug 2024 15:58:03 +0100
Message-Id: <20240830145812.1967042-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830145812.1967042-1-peter.maydell@linaro.org>
References: <20240830145812.1967042-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Convert the virtio-ccw code to three-phase reset.  This allows us to
remove a call to device_class_set_parent_reset(), replacing it with
the three-phase equivalent resettable_class_set_parent_phases().
Removing all the device_class_set_parent_reset() uses will allow us
to remove some of the glue code that interworks between three-phase
and legacy reset.

This is a simple conversion, with no behavioural changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/virtio-ccw.h |  2 +-
 hw/s390x/virtio-ccw.c | 13 ++++++++-----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index fac186c8f64..c7a830a1944 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -57,7 +57,7 @@ struct VirtIOCCWDeviceClass {
     CCWDeviceClass parent_class;
     void (*realize)(VirtioCcwDevice *dev, Error **errp);
     void (*unrealize)(VirtioCcwDevice *dev);
-    void (*parent_reset)(DeviceState *dev);
+    ResettablePhases parent_phases;
 };
 
 /* Performance improves when virtqueue kick processing is decoupled from the
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b4676909dd6..96747318d2a 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -913,14 +913,15 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
     }
 }
 
-static void virtio_ccw_reset(DeviceState *d)
+static void virtio_ccw_reset_hold(Object *obj, ResetType type)
 {
-    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
+    VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(obj);
     VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
 
     virtio_ccw_reset_virtio(dev);
-    if (vdc->parent_reset) {
-        vdc->parent_reset(d);
+
+    if (vdc->parent_phases.hold) {
+        vdc->parent_phases.hold(obj, type);
     }
 }
 
@@ -1233,11 +1234,13 @@ static void virtio_ccw_device_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     CCWDeviceClass *k = CCW_DEVICE_CLASS(dc);
     VirtIOCCWDeviceClass *vdc = VIRTIO_CCW_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     k->unplug = virtio_ccw_busdev_unplug;
     dc->realize = virtio_ccw_busdev_realize;
     dc->unrealize = virtio_ccw_busdev_unrealize;
-    device_class_set_parent_reset(dc, virtio_ccw_reset, &vdc->parent_reset);
+    resettable_class_set_parent_phases(rc, NULL, virtio_ccw_reset_hold, NULL,
+                                       &vdc->parent_phases);
 }
 
 static const TypeInfo virtio_ccw_device_info = {
-- 
2.34.1


