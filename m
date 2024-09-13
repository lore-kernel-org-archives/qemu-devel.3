Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48345FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp805-0001ko-HM; Fri, 13 Sep 2024 11:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp801-0001e2-L2
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:17 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp7zz-0007lF-HM
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:16 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb58d810eso21132755e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240454; x=1726845254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FEVlYNj+KkVzvYMimZ0C37BEH9XfIFMPrSdV/xyd06Y=;
 b=BlP1gskm8tp62NNbrWsmES233TP9HMRv1fbPwq4wTRoNEZIWTpBXY3nfh6JS1qgny7
 cZDkDpNKztybfaAgVH05d32dBmMeIwmAmQ2QLCC8dkAaj4kj2SUIMBCYZlBvzp8CkfpR
 hDNdGMFozDorsr54kbkieyufzVKQHQGWNDtRCGdotkAH84knMwnUirXY4JhiYoNiHWwW
 ASX0S+v3J5WQ/YjyedtYI5JgcecMJv3MwXZPde5OXuMyODWuAm4Wsbow7Eu3b38gbFJi
 pItVy86xWk8xY/oARCN00ErGeQD7DBHpw3cYR/BRbxG3nVsGQGNW2aY8KVGPjgXSR9kA
 NQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240454; x=1726845254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEVlYNj+KkVzvYMimZ0C37BEH9XfIFMPrSdV/xyd06Y=;
 b=ZEggyJM38tDBpmR7ZOejMgp7RDg8YXTeBMCTenXeL6r+Z9I4cjkIUIiWEQ4SkWejKN
 QAU8kx6z7MIEadpCEyCnPAegJhSWb5fgsISr1F5T/BCr9nxjBQ7FVwmKQMBgjymjNfrW
 67ffLHJpmSSjlymuOB5YOW508U8fv+qUGK840PLjXyajcDD/PnJaUt0FEt+Ke/z5zyLb
 Tr/RVV6sEuB7sap6zVdML93CjzoaDwIslDpvn88yUmNS4q0i54uSC+Ro6YvrnWMWjxLX
 7CRKkk3laYOziO31bTODtSoJ453xjVd5gHsmHoG9j5DSsvaQbqi7oMCJY0tWu3P1QgMN
 sNAw==
X-Gm-Message-State: AOJu0Ywi7let0qbRwDH3pizfFxTgJp0dblCwUrMXvjQlmT7CQn0rLV8m
 lLI8EEe5rAaeK8cTk3dchFvHtyy0uLmjHe44HUTVybqVU5Wbxj8waGX+5VMWPnW7uMBt8LSnvip
 O
X-Google-Smtp-Source: AGHT+IHg9dB+A1vt518VIBktTNbt4/yfKuECiGbzO692SseMomCzmdwXFWTvz8ARTluamk4CgdOzfA==
X-Received: by 2002:a5d:5f46:0:b0:36b:c65c:661e with SMTP id
 ffacd0b85a97d-378a8a1d30cmr11529096f8f.13.1726240453881; 
 Fri, 13 Sep 2024 08:14:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/27] hw/s390/virtio-ccw: Convert to three-phase reset
Date: Fri, 13 Sep 2024 16:13:46 +0100
Message-Id: <20240913151411.2167922-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-id: 20240830145812.1967042-3-peter.maydell@linaro.org
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


