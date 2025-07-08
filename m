Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8F6C83F10
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFAa-0003eD-Td; Tue, 08 Jul 2025 16:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDcq-0002pK-VE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:06:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDcm-0003zK-WE
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:05:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so44277575e9.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001503; x=1752606303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bEOImi2VO3DZu8PRd+W9Z97+V53/R1U1vvMpOETczLE=;
 b=Q8uYeK59UYKbSkk/ovK4Q7WRJi//1Q5thWcvPH3Hywf0LPt3Ts2zHgK2IJe+7nsT3H
 oXlltmS4lLuzg3ghXFVZ8tGTYG2RWZsoINrrc7rBHsUHQf+b5I9mQ6RjHb2pHfhb0GnI
 w0fSYTyuwfFiiQpxi48XT99zs0yDnr0bmVkb+ZCANYeAtru+xy8prpIQ+olh3aKCCIa7
 CFafuL5/Vk6XXmpwY06nt0JOaMfH/PbrZ7Pu9zSRUGupDQhfbpXcCbs00RdsIzMMNMQe
 LqePtlffqwcPCSx/tAWaA4mI0CejkR6ek2ukEt/9lFep8HITLhpmBgXQfpRfA/MMXiD8
 6m0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001503; x=1752606303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bEOImi2VO3DZu8PRd+W9Z97+V53/R1U1vvMpOETczLE=;
 b=d3yv82V86r6FnWBXLNx8o2iVcX1o6Jo8SEmSJYlRt0gfvZIvwM7RdUDRa4v1H9cumh
 2iDuZWYZgisf6SIWhBn8Q5ppa0WUGQuYCrYxM2owZ9zSm1MIKrD/yhSEpS3uOZyuvLE3
 Wx+2marwlMX2Rq5xLtUPZJShgV32S4rYhFkifbesL82fUkDMXzFPZfzlvSmD8uINLMj4
 BIxSgtaOnxVen07SzVefWkhN/pdSTUgcFpSNq4E0BPFDaQM1Dc+YsaObIX2HiknYYuNv
 n1hmkRTFWHtQGiM2p2A9aBFOINvt4fDN/0wNwvDsOwHW+qDd84988VzTbecdduiwtsob
 vVZw==
X-Gm-Message-State: AOJu0YzsyXRfF5WlSBpaMXQAJY5TaErFQWSEwwPfFrzZcOA4ugQIbtNa
 f9i+nrrS6lmAgVWlJer6FXCGXs5iF3iOiypyaTwsxuRHTRIHPJIzmM0hE+meSRrZg3LmHE1Ickm
 FsdW0
X-Gm-Gg: ASbGncspw6GeU3GWmMStSXlEZOkv+ZutPrzgwnLgxzD4l/qliCWFTZR/yrMApppIWdC
 c1FULHF0r5cj3T+A1pWNkme7MFn2lZ6qk60C+BYPODZApZwLsYWhKLZiyGBBnCJo66roh1zVlEd
 UfBaUnLp4F+9lQyec2NpUP24z0Hf0P/sfx6dBAx1tWSJi1bYR9Ni+Z8XpkeoyzZPvZkuiNji+qd
 fvMdiYgdEwGEOQR6p+pRX9UPCki1NqgzufSsk8GkW/59EV6Aw1KENScMWA2dvBfUsDSxcnWEtdZ
 JGSbrcIamGMfM6ChhLaxZLJw/hW6mR6lkh8u2rO68Ona7vbKjUi4f7xW0C08WaFu1EeQk9UFeBj
 M+po8IrTIYwIGhK4xwg3jYmRunoxsPnrDP+nV
X-Google-Smtp-Source: AGHT+IG2E4JIlXfdQQvRjce8IXIvZNIOOF5rgjcL1X02SY3IwGdbbfoCXCdaMg6vCkSGBjZ9LVYmXg==
X-Received: by 2002:a05:6000:2c06:b0:3a4:f2ed:217e with SMTP id
 ffacd0b85a97d-3b49702e79emr12971492f8f.42.1751995451388; 
 Tue, 08 Jul 2025 10:24:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b966c0sm13781596f8f.52.2025.07.08.10.23.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Jul 2025 10:24:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH-for-10.1? v7 8/8] hw/virtio: Build various files once
Date: Tue,  8 Jul 2025 19:19:48 +0200
Message-ID: <20250708171949.62500-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708171949.62500-1-philmd@linaro.org>
References: <20250708171949.62500-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that various VirtIO files don't use target specific
API anymore, we can move them to the system_ss[] source
set to build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
MST prefers to defer this one to 10.2.

 hw/virtio/virtio-config-io.c |  1 -
 hw/block/meson.build         |  6 ++++--
 hw/virtio/meson.build        | 20 +++++++++++---------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-config-io.c b/hw/virtio/virtio-config-io.c
index ad78e0b9bc5..f58d90b6e31 100644
--- a/hw/virtio/virtio-config-io.c
+++ b/hw/virtio/virtio-config-io.c
@@ -11,7 +11,6 @@
 
 #include "qemu/osdep.h"
 #include "hw/virtio/virtio.h"
-#include "cpu.h"
 
 uint32_t virtio_config_readb(VirtIODevice *vdev, uint32_t addr)
 {
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 655704471a5..43ed296cf47 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -13,7 +13,9 @@ system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
 system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
 
-specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c', 'virtio-blk-common.c'))
-specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c', 'virtio-blk-common.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-common.c'))
+specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
+system_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('virtio-blk-common.c'))
 
 subdir('dataplane')
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 164f6fd995a..3ea7b3cec83 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,6 +1,7 @@
 system_virtio_ss = ss.source_set()
 system_virtio_ss.add(files('virtio-bus.c'))
 system_virtio_ss.add(files('iothread-vq-mapping.c'))
+system_virtio_ss.add(files('virtio-config-io.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
@@ -10,11 +11,11 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c')
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
-specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
+specific_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
   system_virtio_ss.add(files('vhost.c'))
-  specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
+  system_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     # fixme - this really should be generic
     specific_virtio_ss.add(files('vhost-user.c'))
@@ -43,22 +44,22 @@ if have_vhost
   endif
   if have_vhost_vdpa
     system_virtio_ss.add(files('vhost-vdpa.c'))
-    specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
+    system_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
   system_virtio_ss.add(files('vhost-stub.c'))
 endif
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
 specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('virtio-nsm.c', 'cbor-helpers.c'), libcbor])
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
-specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_SCMI'], if_true: files('vhost-user-scmi-pci.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi.c'))
 
 virtio_pci_ss = ss.source_set()
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'))
@@ -67,6 +68,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vhost-user-scmi-pci.c'))
 
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_INPUT_HOST', if_true: files('virtio-input-host-pci.c'))
@@ -85,7 +87,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MD', if_true: files('virtio-md-pci.c'))
 
-specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
+system_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
 system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
-- 
2.49.0


