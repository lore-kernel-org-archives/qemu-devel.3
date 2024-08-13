Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D077DC52D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 16:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdulY-0004kF-8c; Tue, 13 Aug 2024 12:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulW-0004eu-K8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:52:58 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sdulT-00019G-4m
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 12:52:58 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52f01ec08d6so7803257e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723567973; x=1724172773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TWMOZJL0m51lCwqZPLvqybuuVnTOHdvjuL5Fp/TafgQ=;
 b=g8nt7XlPjuHFET2V79jXZFKHeAIRvRVWoSHAu6c2/jVkmtok5YpD1/qqbDHeejMVbK
 5OUeN0Evnpmstv1cKqHd7OlMAfqPxIiO6SzAs3rsAhcwWq+cgtf9i6fn+GrMt/4BzTz9
 Dc2Y9WECO9lfrdiLOZrPO9PDnLLEL6m1xbCIs6vdCNX8yK8yqZ+eekZtPliDRPnKACFS
 DUHmiUHA5i39PNWMuGtB9eFF2ItihoAm9pEkcGvPAH+Jv6GdbqBI1TR2LGIYR0G2lbAQ
 HP7n62xoWvZTgAtvoax9os74rAIHGIdgq48J36YcWKU1W9G49C+5FO2v+LvRFw/d0o9O
 z2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723567973; x=1724172773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TWMOZJL0m51lCwqZPLvqybuuVnTOHdvjuL5Fp/TafgQ=;
 b=cGvbYjArjpV8OO+ff5dm4jZeFzL/H/ljOF7vBSo7FKFMGR4eB3/Ap5BOM74JSupc0V
 5pJNB6YuZ6In4Z4eSBD1Pg698G5X4heQgyYPZBn2LneNe7PqhwUCzYucDx8EG74Jugx8
 qNXVVyEBwSZgYLKEhbtaAoQ1kV7o2WgbpYJNNURL8aceSlzLX1FXRrW3vkZGDM9ttFLF
 Xa+Bnb/kaf9Fz3YT/gCwcAq+VJq7q73ufbQHsw4yLZJPm7BJqvQrMRv0NJrJhwE9yT0t
 8g11oc/rDu9uKdfxRvBB6H7fjrGw9+DDetRBuUUsRSWV5IjTimSVWU3EVhva7Fvlp/ve
 h5bg==
X-Gm-Message-State: AOJu0YyrAERQKxzs2xPLS6RiLfDJ2KFt4+i9E5Sx/IGbug2BP6G3eARa
 vNGsmGgiPnmedZk3TQao88D3i3rezK01AHLQAQyQ33gh+JrJCz8LHJbaNO2nZXtRgsTxkuwyubS
 2
X-Google-Smtp-Source: AGHT+IGRuB0H2e9BqwjG3cuhHCVyFEAXtLgWqTdTZJUbNQiDdzYkCYpanqdRs2/vUF8qBNmiBMuCHA==
X-Received: by 2002:a05:6512:3c89:b0:52c:d905:9645 with SMTP id
 2adb3069b0e04-532eda79383mr3140e87.13.1723567972902; 
 Tue, 13 Aug 2024 09:52:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c77374a5sm147347015e9.30.2024.08.13.09.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:52:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH for-9.2 01/10] hw/s390/virtio-ccw: Convert to three-phase reset
Date: Tue, 13 Aug 2024 17:52:41 +0100
Message-Id: <20240813165250.2717650-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813165250.2717650-1-peter.maydell@linaro.org>
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

Convert the virtio-ccw code to three-phase reset.  This allows us to
remove a call to device_class_set_parent_reset(), replacing it with
the three-phase equivalent resettable_class_set_parent_phases().
Removing all the device_class_set_parent_reset() uses will allow us
to remove some of the glue code that interworks between three-phase
and legacy reset.

This is a simple conversion, with no behavioural changes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
It looks a little odd that we do the this-class reset first
and then chain up to the parent's reset, but that's what the
existing code does, so I left it alone.
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


