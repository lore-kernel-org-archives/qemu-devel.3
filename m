Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC11C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 21:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYAVe-0007Ho-0R; Wed, 15 Jan 2025 16:01:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYAVT-0007HC-V0
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 16:00:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYAVR-0003fF-CW
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 16:00:55 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436637e8c8dso1303275e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 13:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736974851; x=1737579651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vjRl7JCegegyXyUnn5GpI7jVd0qmkWGQ7fWtdXQEF/k=;
 b=T0P2BE5R7oMyoClmnUv8AJmmOU/XZeo9hXbeuUULWp0SFaDaL+3Nm96b4PJBulrWQh
 /AKOhF7NE7O2KgQYiG5zl5c+fBV9hUqic89DId5fEbPdoYcKVLIAzT2r910+m7g3m9LT
 wXd6rqjRE4oZlLidYvpDAuEZD4RzvEm9Kag0EEhas5iOlPy1LyHD3YSI4LPum1I4u+16
 /RHttm1w2qoHk5M1tBipjs2QLtNsA+KohKsvI7XNqMlmK6pBaeze56RghdBFpZttQmg3
 WLbbKbXY55jOVxWCGJVZDf5TvLuUhY9tfcl8GZJdc4jRwIghHb3WtK9xe1/8Pfg3NYsu
 gd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736974851; x=1737579651;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjRl7JCegegyXyUnn5GpI7jVd0qmkWGQ7fWtdXQEF/k=;
 b=Pb/a7sC3w8kxSmhpUzbCXCY9kQ3UyLsJtd5szIgFeqdR5sSFj6eMUWf9oudjM3jecZ
 zmQh4+N8OIxMv4pxm8QknhY3n4RdpPPBkCp5tUtBEXG0mrsSrGNlpKwToHT7aFcAgYqd
 JruZr/7dWq6w2CApyyHgimvl3elUFDK62HwIV9gpYVc74X7RUOuKgxPW4NxpvkHVJcX9
 TwuTskLB/oT9nfs1Ra7bhnxQBEalxUAX2hO/v6wNmCCoXoaaL+xT8hY+nAsOHlzdmPKx
 FbC1wt38LtmQoBBF7850nxmloU15gZrmPSIcghl5jmkGrnSLdU7HpI8EOLQfWhi0bZbZ
 85+g==
X-Gm-Message-State: AOJu0Yykhlmw9W64FKKfYmoIQSRgo94uBym6wLdgny29uzRMR4np5Mve
 GwRCDokZrVJmROPESJ938vxeTh3Cvdr6QGv3AfNCpRImxe2suSRuR8CJOFak7R9o22jIXyd6kNk
 Vo90=
X-Gm-Gg: ASbGncsaFkA9YbNnYP9dBkgiIrOT4WDeKU+RepcWcNi6bfzUiQtx7Vr2WxmLlHzhwW5
 3D4tjj6F3xgquFrezWxKChFGPK0d/6MEva/NualmuuYVvb+KiDmy53OEYy37nCPk0UTamqTMerM
 pVLOOzSNuXQWZ/+CzG/Ye2sayvJ2hbN+mMPMMnIFEpPRfrsm+qq4SxRlHwK6JV2vZz2l86uyh9+
 xgfsvErnegOS5iOJlZnwtHGgTTXZI/9XZlZTUNlcYfoF6S8UcTk1vFY/Sut8OjgxK70/2ErvSLQ
 cB8DR4WQTEeh22CucTKRWA5OHoIM07Y=
X-Google-Smtp-Source: AGHT+IEPnqA26HsY1T3QYoZJSzPtk27DGxHd+Ph6iXMVR5dUZjwpu05fGO6AWN/pt3elxtkMNZzr7w==
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-436e26f4d53mr289809355e9.31.1736974850947; 
 Wed, 15 Jan 2025 13:00:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac73csm36339965e9.15.2025.01.15.13.00.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 13:00:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/rtc/mc146818rtc: Drop pre-v3 migration stream support
Date: Wed, 15 Jan 2025 22:00:48 +0100
Message-ID: <20250115210048.25396-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

mc146818rtc's migration stream is at version 3 since commit
56038ef6234 ("RTC: Update the RTC clock only when reading it")
from 12 years ago, released in QEMU v1.3.0!
No versioned machines are that old, we can safely remove
support for older streams and the qdev_set_legacy_instance_id()
call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC to check whether my reasoning is correct or not.

Goal is to remove qdev_set_legacy_instance_id() globally.
---
 hw/rtc/mc146818rtc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index e322fc2ffb9..b7927f7e258 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -819,7 +819,7 @@ static const VMStateDescription vmstate_rtc_irq_reinject_on_ack_count = {
 static const VMStateDescription vmstate_rtc = {
     .name = "mc146818rtc",
     .version_id = 3,
-    .minimum_version_id = 1,
+    .minimum_version_id = 3,
     .pre_save = rtc_pre_save,
     .post_load = rtc_post_load,
     .fields = (const VMStateField[]) {
@@ -829,13 +829,13 @@ static const VMStateDescription vmstate_rtc = {
         VMSTATE_TIMER_PTR(periodic_timer, MC146818RtcState),
         VMSTATE_INT64(next_periodic_time, MC146818RtcState),
         VMSTATE_UNUSED(3*8),
-        VMSTATE_UINT32_V(irq_coalesced, MC146818RtcState, 2),
-        VMSTATE_UINT32_V(period, MC146818RtcState, 2),
-        VMSTATE_UINT64_V(base_rtc, MC146818RtcState, 3),
-        VMSTATE_UINT64_V(last_update, MC146818RtcState, 3),
-        VMSTATE_INT64_V(offset, MC146818RtcState, 3),
-        VMSTATE_TIMER_PTR_V(update_timer, MC146818RtcState, 3),
-        VMSTATE_UINT64_V(next_alarm_time, MC146818RtcState, 3),
+        VMSTATE_UINT32(irq_coalesced, MC146818RtcState),
+        VMSTATE_UINT32(period, MC146818RtcState),
+        VMSTATE_UINT64(base_rtc, MC146818RtcState),
+        VMSTATE_UINT64(last_update, MC146818RtcState),
+        VMSTATE_INT64(offset, MC146818RtcState),
+        VMSTATE_TIMER_PTR(update_timer, MC146818RtcState),
+        VMSTATE_UINT64(next_alarm_time, MC146818RtcState),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
@@ -929,8 +929,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
 
-    qdev_set_legacy_instance_id(dev, s->io_base, 3);
-
     object_property_add_tm(OBJECT(s), "date", rtc_get_date);
 
     qdev_init_gpio_out(dev, &s->irq, 1);
-- 
2.47.1


