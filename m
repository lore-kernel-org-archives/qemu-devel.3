Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BC8E83830
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 20:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5d1-0002zO-SF; Mon, 16 Feb 2026 15:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs5d0-0002zA-D1
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 15:55:34 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs5cx-0001HW-Mc
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 15:55:34 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso27223445e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 12:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771275329; x=1771880129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WXPM9a6ODtDiETBYoStoyeuWQ/pVVHKVGm1hwVLd90k=;
 b=KXizdKw29Gj1bcBWeQHMBbMZiyqZ5Fk7042yKz8pLghUU2flSJaDzoW4gCDRcAvmoi
 4efIKILCe/en/v2iwcTVIj0FA8R+gNxFh8ltpacez0ox0MoJea2a7KmUEo1YTawje6MW
 8hxmsTajdVmUi55H2f9mJhuPiUuB9yCEF34B0EaxU7sm7mEQi+Nfee5JUugjERLOhpd7
 C9JIKg53ebwMsvuCl++BiKvqeIPo5Jq9UCUTryy9Wr54MVWBCLWJuLPhtOlFYEfSb5SL
 geA2E8hGVb2tEXGzIOKHf1Cj73CNTOrm1rbSnUCz4duncpZsRj37BOVfqHvrrz4/yJ4b
 5YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771275329; x=1771880129;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXPM9a6ODtDiETBYoStoyeuWQ/pVVHKVGm1hwVLd90k=;
 b=ZZM73mK1RhwnGhHYJtaHCi2O0UlhXoamz/iZyt0Qvn9Qhp+Yjjjp27LaKfgfIcZ1Ge
 b8CPm5+Sxr+8/c4Ctkygc7HPUtn3m9IWRxig44PllpJrqaqnoaRzD16fK/L928jnvcuo
 /8q+WiVFMBnDdn90c5EjC5LH+jqLrnzVIKyAiqzI9darvDcIYrpyon9HcgOKKPNSX5JX
 VGz2OJAT71J0gYy13VKSEhvA3JQ6iXPhaGCqaymjrscC1pqdgNamAyQ/rshxuq3X0kQp
 9DYYjSfwrrd6wp1tIV1YeQtjbnoU+CUo7ES/F7eu/sl6hhqinZY2ScD5MIpns5jFtuDC
 1v9Q==
X-Gm-Message-State: AOJu0YxLUGx7eWGrBz9h65NiVWqQsDsa+8ZU+DPiMX2AlhUm+tr0W+K6
 EMAIiacVOafuHbSwbQlZq5tJ4tQqtSOi5ETISRPtZmukhENraOt4dMXqAPTk4bMa4ExTcosDmt9
 ygh0ioYs=
X-Gm-Gg: AZuq6aJhOdRLyFKn5cuUrMAdgD9rrYhs3qa+AmqahxHTrVZta40c0rCEv8E2MQVPdXE
 B9kF2Ka6auUfJ39GBn2rPnJr/SOVqsapC1C2863V74HqnmHUqPAU2MFVqj0+GMvO8ahn2nHQnN9
 3aRsT+ATfO5UJFfN3K8D+G99tdQ4xRfEXI6sPVSimxLlaaTYt7bNXVI5ma1cly3+FE+/bukfL0w
 WS2vvmLmspw58gkGGJwr85Llp8uI6h9bpQfuply+LeYZ5SHkqHqMTXLE6De3OFewNNMVrXCm/o4
 eOV2jkNTq2HYXJti50VocnJNPhjwn+/GWg0MBgwuEgVDaF5sVbpP7VvP3EWr+eINrTwxh0idKaS
 7rfL/MUGIelqYqWOX2jGUY6LDjr52JnDSRM9u8D6X4UkGHVnaqGAVxxKM3CI6TonsKK9Kes5cz5
 PWX0fr7fqVkvwafH1mE6LWcNjmGe2uTNKQ4AdQ5db1Qqd0uU+L6Mps1WWwENjeLESfFl+GH7MM
X-Received: by 2002:a05:600c:a10d:b0:483:7783:5382 with SMTP id
 5b1f17b1804b1-483778355e0mr140763835e9.27.1771275329499; 
 Mon, 16 Feb 2026 12:55:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac82f7sm32512050f8f.28.2026.02.16.12.55.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 12:55:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Amit Shah <amit@kernel.org>, Laurent Vivier <lvivier@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH] hw/char/virtio-serial-bus: Fix Heap-buffer-overflow in
 set_config()
Date: Mon, 16 Feb 2026 21:55:27 +0100
Message-ID: <20260216205527.45938-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


