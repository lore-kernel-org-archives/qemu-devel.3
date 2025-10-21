Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB60ECCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 14:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDjx-0005Bj-13; Tue, 21 Oct 2025 10:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDjm-00059O-Fz
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:53:23 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBDji-0007Xi-DC
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:53:20 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4711f156326so43874805e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761058396; x=1761663196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MVnIcv6wpbRHfrTNL4tWp8Jqn8R3H5q+xlspGqWOfao=;
 b=MyecDPnMjxkBNskRSBzrE4x3QYi/O9J7OWgIythzkAzZfe0bKGIuyE9ooBMNwM5+09
 NLW1odVpJqLLIIENzg8wjaQVQOE9xJp0xt8w8AbguOLegcAhq1yZQcaF0RDN4mgUXyr1
 3WF3pNmrv2S/K4InTzDWfNIhTM8E/lZYWgd5EWdJEFDgRxsEQM7MRE/tcN4dTeJrgm8u
 hPaGV4EZj4W2535niHR7gUnDT42jITOaC2HYuwHsxQyxpWrrURh5ca+28PmE7sIDBgMN
 xOotF6RIfY5upaZGI5b1m43X7bX758E5zluSaG8iYQ8ojMmjcHZP+xJkBlZpY5RfV6Zi
 Kaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761058396; x=1761663196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MVnIcv6wpbRHfrTNL4tWp8Jqn8R3H5q+xlspGqWOfao=;
 b=iW5+NGEnyxTmpTYvBk3hSttD3RcoDy05s6HhpjwGDxJuaiTAm38NEOsOeVOlGh9Jwx
 rR09OxazH6edfGksPmXb9uKMLHkPWeMlYh4Bk/7tr3qJjE7maasqJJ+k1trTR/tHzrGi
 X/PDHO/m8a0iaEOLBGD1X2/IQiAve0wfmMeN4Qu5aJIRUTb3Y11IB/uhBfgDmMHMUdU3
 uPsxU7i4zAlV7blTaFpMCNx55cBi2OijR9BP9lXoeH89nVMwIF6yGKxBghnAHKHIodE7
 9Cpj4BOxGYiTs0/cmQ7XHrT/mbMQNP4+B2RDOQzHOZVhv/xwnwXO4GRYDAcJYehG2U3J
 t7Jg==
X-Gm-Message-State: AOJu0YyLagQxQ1nN+yYJt2wPYrudW0gVMTARnhvgy8fFm5g6zZCGIMkt
 zxUJE25mR1+vsI6XUq+pwsoPndRQMVlRpV+fAiNrm/Ga4jmhOqXL3aslDbRa3gGzo7JwwhPY7KY
 pUMAVRGY=
X-Gm-Gg: ASbGncssT9WipLhWvyQ8vMnqnXB5g8ij+zicGtpr30J+4blfvp8qR8OoWYd7icQB8TG
 9o0eLULGmHaN4YzDeboQldKMGBEF4KMgy8RMiNT0QV/XOViJShQTXxsSQKp1COKtCWGl0x8fhOD
 0fdByPijUjm034tiacwv+dnoL0EYgAuZAaPkiejbGixF1pVqUUXkNWzxZrwsI+m34sMsXn6Fo4Y
 tOMsS7Q4tLRadf+8DsBWFZzrtLEah72DGjSBWrgro/nCRniaBHHHPnTgCUtvhkMrl1k5r5I5m7q
 q9VJIEnd6SA0l63DvLvK4ilwhd/9xp12A4u86tjryLEBVo9M9OJv/gak8q9sz042l/T1kGjJDkf
 pzQMxw4ytwCwiU8qNCoTUwZHX1z+Bm/lq8HD3l0ggii5J9CCVwLHjzHjB0uifXj9d0ww6d3GEkV
 6LcptaguC2Hu1vYUYain1dRTEOLKWU5dLXejBtiL+JK5ulY1FxdTMvOzkrzunEfQFJHHH+hO0=
X-Google-Smtp-Source: AGHT+IEYJDoQQSAN5VthxcVOeBgHBGl95cNTPBPha3rR2zTBcOQ5ZsgFUCegQrHpYAPXBKSWPNeHww==
X-Received: by 2002:a05:600c:4e11:b0:471:c72:c807 with SMTP id
 5b1f17b1804b1-471179079c7mr142401585e9.22.1761058395936; 
 Tue, 21 Oct 2025 07:53:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a797sm20694706f8f.27.2025.10.21.07.53.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 07:53:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
Date: Tue, 21 Oct 2025 16:53:13 +0200
Message-ID: <20251021145313.4584-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

uint8_t is good enough to hold a property "between 0 and 0xff".

Define pullups/pulldowns properties using DEFINE_PROP_UINT8()
macro, remove unnecessary range checks in pl061_realize().
Update the two caller sites.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: qdev_prop_set_uint32 -> qdev_prop_set_uint8 in callers (Peter)
---
 hw/arm/virt.c        |  4 ++--
 hw/gpio/pl061.c      | 16 ++++------------
 hw/vmapple/vmapple.c |  4 ++--
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a7..28e842f22ea 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1133,8 +1133,8 @@ static void create_gpio_devices(const VirtMachineState *vms, int gpio,
 
     pl061_dev = qdev_new("pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
-    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
-    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
+    qdev_prop_set_uint8(pl061_dev, "pullups", 0);
+    qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
     s = SYS_BUS_DEVICE(pl061_dev);
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 1acca3f2f80..a3ac038c2f7 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -79,8 +79,8 @@ struct PL061State {
     qemu_irq out[N_GPIOS];
     const unsigned char *id;
     /* Properties, for non-Luminary PL061 */
-    uint32_t pullups;
-    uint32_t pulldowns;
+    uint8_t pullups;
+    uint8_t pulldowns;
 };
 
 static const VMStateDescription vmstate_pl061 = {
@@ -547,14 +547,6 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 {
     PL061State *s = PL061(dev);
 
-    if (s->pullups > 0xff) {
-        error_setg(errp, "pullups property must be between 0 and 0xff");
-        return;
-    }
-    if (s->pulldowns > 0xff) {
-        error_setg(errp, "pulldowns property must be between 0 and 0xff");
-        return;
-    }
     if (s->pullups & s->pulldowns) {
         error_setg(errp, "no bit may be set both in pullups and pulldowns");
         return;
@@ -562,8 +554,8 @@ static void pl061_realize(DeviceState *dev, Error **errp)
 }
 
 static const Property pl061_props[] = {
-    DEFINE_PROP_UINT32("pullups", PL061State, pullups, 0xff),
-    DEFINE_PROP_UINT32("pulldowns", PL061State, pulldowns, 0x0),
+    DEFINE_PROP_UINT8("pullups", PL061State, pullups, 0xff),
+    DEFINE_PROP_UINT8("pulldowns", PL061State, pulldowns, 0x0),
 };
 
 static void pl061_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 1e4365f32c9..f3cff329244 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -326,8 +326,8 @@ static void create_gpio_devices(const VMAppleMachineState *vms, int gpio,
 
     pl061_dev = qdev_new("pl061");
     /* Pull lines down to 0 if not driven by the PL061 */
-    qdev_prop_set_uint32(pl061_dev, "pullups", 0);
-    qdev_prop_set_uint32(pl061_dev, "pulldowns", 0xff);
+    qdev_prop_set_uint8(pl061_dev, "pullups", 0);
+    qdev_prop_set_uint8(pl061_dev, "pulldowns", 0xff);
     s = SYS_BUS_DEVICE(pl061_dev);
     sysbus_realize_and_unref(s, &error_fatal);
     memory_region_add_subregion(mem, base, sysbus_mmio_get_region(s, 0));
-- 
2.51.0


