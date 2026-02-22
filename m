Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F67C636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuImZ-0003aE-Cg; Sun, 22 Feb 2026 18:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImY-0003Zy-JX
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImW-00012z-Ra
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so34343825e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802551; x=1772407351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1t/vOShq3dfs3m98lmtAeG2rO0W7nmfgaDBtAGUM1Y8=;
 b=MBPNXH+P2tXsmROsce0QcvK17VMKZNmizZkAd81xUCpIL5GCjbGgSiSxFE9B5sOVb+
 bc/JcNKPh0dOe8oyA22Q4kjemboVv6p01N6zRTBA+mvy2S6g3+59wBt9nCRYTrcefjui
 0tdijXwPLsEgq5NsnLu6+7VwnYLrQDQptCqC6E5nCuHm8BgOyZPsNqE0D1/S2WDYeipi
 YF0NNi8MlDA9liJ/jNCFUy8MAJJw0nwbMemCIdWwlNZDQ32yw1B2kctT8aP2b30xlVl1
 JCuo1n1RI8tOeGWvKEmNDMAWoie0whnzAm13PHXJ5z3fRg10cPwDymzL+NvGrjDbaUFr
 +j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802551; x=1772407351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1t/vOShq3dfs3m98lmtAeG2rO0W7nmfgaDBtAGUM1Y8=;
 b=mBXywDwBiVIe8s1Dkh5U2f24Cmyd1ylI33VZT2o0DbtpVp7vv4QxU25mtjOr6NLPlk
 uan+san8AYREtiRhGibQl9BycsZT3ub19JaIhSTqLrA/XONqIgPHdxlIsC6I+Me3RK+2
 /wpARvvtmtP7ZeWxgTmb2jYvD2OFwIdf6n4N7sod7rtLC991GAzcuWp3YxogG5Y1AY2Y
 rFQCKwzxN5VfmIamaoyXsa6Q2t9w3rDzW2U4DfdwGhcskPEdCCi7BmJYrGzUel2ls3/s
 lGvXdk//inmrAKIIzd2PTsRke9i/kN05gmRbP7ucYo7ZzHbJwBfOF6Sqa4ao5LGCFBrk
 eCoQ==
X-Gm-Message-State: AOJu0YzhU5s8BIxav4+Aid+4+FloCY6iiZgoMCfBU8l1ghTbqZrk/P7O
 AJaB5hdmGd9S46pw5FR+60zKvbpPV9LrhvZlsELxmqCK/CfBajfhFDea8RH7sZusdbIeXz5JVnb
 JXnkBK6g=
X-Gm-Gg: AZuq6aKBxeW33QxqYFcx+nI4NC1/zo5GViLpU9i0ZexZp55Oo/AwjhUPqlZd/mn1ebO
 yzDwfD19X0kX/LFeOtWyV+i/WMLMwQvbUFsf33/kQOcGRqXNk5WYG/Jo0ZE8e/MiHCsL1jWJdnI
 kVoH1C70jbBYQzC+bIgjBItjwU4qG1TgLManNYKmeHSF2zmZgSe4uiTy2xGRhbLcQf2khlGuGvF
 Fw1WOynStOYBYb9CUrgiwZmOrBMmKvlGOdKeiK//7tWMd5hNsCRDamO5mHAffi5tGIFRjrAOfsf
 7P9fVw6GPR4CZS50u1J2hKkQfVigLpjJ+y8/+ADvwCw3XBZ887qBmPZ9bGocU6hpGcZpJeeE+V9
 b9PXMNmBxOZ3NEmCC/5CVJEU++u4Fd2MXrX/R7WoEaku0m9djv6W3Oev586XzsTVHcaWStmYKea
 8tMzCIb8Yx0skcG3L9OHCr7LrnnNaOWySEVn0wGl3M47LsS+rkiQY0WTMGQDh6lC7ErcgNX5NM
X-Received: by 2002:a05:600c:8b0a:b0:483:7f27:cdc5 with SMTP id
 5b1f17b1804b1-483a9603c12mr110816995e9.31.1771802550634; 
 Sun, 22 Feb 2026 15:22:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a430927dsm93483105e9.31.2026.02.22.15.22.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:22:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/21] hw/char/virtio-serial-bus: Fix Heap-buffer-overflow
 in set_config()
Date: Mon, 23 Feb 2026 00:22:17 +0100
Message-ID: <20260222232222.7183-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
References: <20260222232222.7183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

When removing the 'emergency-write' property in commit d0660e5b7fc
we neglected to remove the code reducing the virtio_console_config
structure size, allowing to access up to the unallocated 'emerg_wr'
field.

Can be reproduced running:

  $ cat << EOF | qemu-system-i386 -nodefaults \
                     -machine q35 -m 512M \
                     -device virtio-serial \
                     -display none \
                     -machine accel=qtest -qtest stdio
  outl 0xcf8 0x80000810
  outl 0xcfc 0xc000
  outl 0xcf8 0x80000804
  outw 0xcfc 0x01
  outl 0xc014 0x00
  EOF
  ==3210206==ERROR: AddressSanitizer: heap-buffer-overflow
      on address 0x502000090858 at pc 0x5638f1300a9b bp 0x7fff6b525b80 sp 0x7fff6b525b70
  READ of size 4 at 0x502000090858 thread T0
      #0 0x5638f1300a9a in set_config hw/char/virtio-serial-bus.c:590
      #1 0x5638f0bccdcf in virtio_config_writel hw/virtio/virtio-config-io.c:104
      #2 0x5638f0bd0c89 in virtio_pci_config_write hw/virtio/virtio-pci.c:637
      #3 0x5638f0cf90cf in memory_region_write_accessor system/memory.c:491
      #4 0x5638f0cf975b in access_with_adjusted_size system/memory.c:567
      #5 0x5638f0d01d3f in memory_region_dispatch_write system/memory.c:1547
      #6 0x5638f0d2fa1e in address_space_stm_internal system/memory_ldst.c.inc:85
      #7 0x5638f0d30013 in address_space_stl_le system/memory_ldst_endian.c.inc:53
      #8 0x5638f0ceb568 in cpu_outl system/ioport.c:79
      #9 0x5638f0d3c0f9 in qtest_process_command system/qtest.c:483

  0x502000090858 is located 0 bytes to the right of 8-byte region [0x502000090850,0x502000090858)
  allocated by thread T0 here:
      #0 0x7f0dc32cba57 in __interceptor_calloc src/libsanitizer/asan/asan_malloc_linux.cpp:154
      #1 0x7f0dc2382c50 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5ec50)
      #2 0x5638f1303c27 in virtio_serial_device_realize hw/char/virtio-serial-bus.c:1046
      #3 0x5638f1396a9c in virtio_device_realize hw/virtio/virtio.c:4053
      #4 0x5638f13ea370 in device_set_realized hw/core/qdev.c:523
      #5 0x5638f13fdaf6 in property_set_bool qom/object.c:2376
      #6 0x5638f13f9098 in object_property_set qom/object.c:1450
      #7 0x5638f140283c in object_property_set_qobject qom/qom-qobject.c:28
      #8 0x5638f13f9616 in object_property_set_bool qom/object.c:1520
      #9 0x5638f13e91cc in qdev_realize hw/core/qdev.c:276
      #10 0x5638f0c3d94b in virtio_serial_pci_realize hw/virtio/virtio-serial-pci.c:69
      #11 0x5638f0bda886 in virtio_pci_realize hw/virtio/virtio-pci.c:2351
      #12 0x5638f09bc2ae in pci_qdev_realize hw/pci/pci.c:2310
      #13 0x5638f0bdb2f2 in virtio_pci_dc_realize hw/virtio/virtio-pci.c:2473
      #14 0x5638f13ea370 in device_set_realized hw/core/qdev.c:523

    SUMMARY: AddressSanitizer: heap-buffer-overflow hw/char/virtio-serial-bus.c:590 in set_config

Fixes: d0660e5b7fc ("hw/char/virtio-serial: Do not expose the 'emergency-write' property")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3303
Buglink: https://issues.oss-fuzz.com/issues/484647006
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20260216205527.45938-1-philmd@linaro.org>
---
 hw/char/virtio-serial-bus.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index b7c57ea9678..cd234dc6db1 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -1039,10 +1039,6 @@ static void virtio_serial_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!virtio_has_feature(vdev->host_features,
-                            VIRTIO_CONSOLE_F_EMERG_WRITE)) {
-        config_size = offsetof(struct virtio_console_config, emerg_wr);
-    }
     virtio_init(vdev, VIRTIO_ID_CONSOLE, config_size);
 
     /* Spawn a new virtio-serial bus on which the ports will ride as devices */
-- 
2.52.0


