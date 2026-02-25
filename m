Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39BBF55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6OA-0006J8-3b; Tue, 24 Feb 2026 23:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6O8-0006H7-Gt
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:40 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6O6-0004yx-He
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so37829835e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993237; x=1772598037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24jaYt0AJT36PqAdhuaefwmGKsMoTDVGvqSIw9dSfEM=;
 b=LA/iXa1e6vUIQt8RrycjVip3V0rb5EDIhwLsBOEde1ZvLcBNDOcAjkAHi+4pEZARGk
 WuaYVJwgnSxwB/D9p0Srb5KSfiHev9md97U9CnvzpR43+CHMP/3cTzfUlN33JzLjsL2E
 QVVOhBc/pvCp5KSZOI9tnopogWg2kmhCPfJApfoE/xrgTLZjIVu8JMuoS24xJjbvA5m4
 VzCZi1Njcfpo49xpunHpgYDeg7sydY/SgSEEvPazeuuUxZfD6ShPIdzOhHQ6OLF+LEOZ
 7S/bmLVB2IMfj+vs85/HZXtCaZcv5yJGd/lx6hO8/ZBeTbL7QmreDS1dPk7oh2EiBjhJ
 7MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993237; x=1772598037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24jaYt0AJT36PqAdhuaefwmGKsMoTDVGvqSIw9dSfEM=;
 b=dbZ+gb8QJrW98VyEHLBsXm4ympPkpANXcZdBG9vDjytwQKjzJVI2a8kWi5h8JG3gq9
 BC2MF/j4B5GSu9fZTJRvnx4iNJJCzxGeP7t7iAmZIGdNwJsPeoNaIO2mreTyMPLzAmsa
 0+itTlscJguCbBkHIf8YkcXbmQhqPuREq5t0CK46CM8pMMqlSDXGuB9rcwgYTiy/HpvG
 EyPGWuQOnmAKkHySm9O074Sq0vp20Wjja1viiGBHpeKXiLRwCo2Cln+Fg41lWL6F6tjZ
 ukvrjeZOgw6I517YtofidJdfwnAwU5sPbgZcoiVBCGwEgZrDVYjPU4iec6myNuy4huQf
 aHDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnTXqVAhAjQ0nSO27m2GM9Ir7pyGf5QWQC+Msanb/mCGxPqF0MfNvFew71gRN1fxbXk9NozFSUmPni@nongnu.org
X-Gm-Message-State: AOJu0Yw9oegs8h+MPssJwofAH2b9Hqy+Pwk3nMlh0P6YdoPREH4NTYGX
 kypbG8fI93LJenpN7TEF14XsjVEt2oqUADfsTCbJL6THuM+Nu54NcVq0pxDfzv5rewM=
X-Gm-Gg: ATEYQzyowOwLh8qRGG2sQcgCokI521jRulwRS+kIG+l8I1GtqB9XGnMy6cokbGnJt2a
 l1KqE4EkgRnhdohitpohv1/PUVs5u++cXPtEaSCscaFMPSdy8Dyv0De6GRG9WRb0fJOc4d7qP+m
 bGLxnxprd5oAE+y6Yp0ga7mzqMgX9ZF+oSpe0IgJDflssXDfrSTvlG/r2/N769NQpd9kgWWs3cZ
 C9SE1iHKwFkdFckwoHAL0vbTvUoybN53m0CItym3Aikd+5wcU87Ps3MH8oxfNLY6z7LltSWZ1oe
 Uqsy14QZAsp+dfi6hl3zZPsx0onCfDKq3PYkdRcUSuqAtTaozowybsjhdRU5UR9uMfXBe9aG/GC
 EDiuZCmflMR5dbfrctF3aanQ350HAKBO4DxTpJ+LEW/TNNAbe3Ef3IB0cIHbSwP1LOJENP4XjxT
 nqsSAwPNYZwjK03v0unGcYa/m4U19AE8KSpaNsHwdpt6BCJjG8VGCqrb2dSlSNFMMN1zwylXLx
X-Received: by 2002:a05:600c:310f:b0:480:1c53:2085 with SMTP id
 5b1f17b1804b1-483bef53d2fmr16251755e9.19.1771993236793; 
 Tue, 24 Feb 2026 20:20:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb2c5a8sm2891815e9.0.2026.02.24.20.20.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:20:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/6] hw/virtio/: make all compilation units common
Date: Wed, 25 Feb 2026 05:19:47 +0100
Message-ID: <20260225041948.52929-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225041948.52929-1-philmd@linaro.org>
References: <20260225041948.52929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/9pfs/meson.build   |  2 +-
 hw/block/meson.build  |  4 ++--
 hw/char/meson.build   |  2 +-
 hw/net/meson.build    |  2 +-
 hw/scsi/meson.build   |  6 ++----
 hw/virtio/meson.build | 12 +++++-------
 6 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index 7f4d6e3a451..91b51af838f 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -23,4 +23,4 @@ endif
 fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
 system_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
 
-specific_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_9P', if_true: files('virtio-9p-device.c'))
diff --git a/hw/block/meson.build b/hw/block/meson.build
index 43ed296cf47..d646323b82b 100644
--- a/hw/block/meson.build
+++ b/hw/block/meson.build
@@ -13,9 +13,9 @@ system_ss.add(when: 'CONFIG_SSI_M25P80', if_true: files('m25p80_sfdp.c'))
 system_ss.add(when: 'CONFIG_SWIM', if_true: files('swim.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
 
-specific_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk-common.c'))
-specific_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
+system_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk.c'))
 system_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('virtio-blk-common.c'))
 
 subdir('dataplane')
diff --git a/hw/char/meson.build b/hw/char/meson.build
index a9e1dc26c0f..fc3d7ee506f 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -17,6 +17,7 @@ system_ss.add(when: 'CONFIG_SERIAL_MM', if_true: files('serial-mm.c'))
 system_ss.add(when: 'CONFIG_SERIAL_PCI', if_true: files('serial-pci.c'))
 system_ss.add(when: 'CONFIG_SERIAL_PCI_MULTI', if_true: files('serial-pci-multi.c'))
 system_ss.add(when: 'CONFIG_SHAKTI_UART', if_true: files('shakti_uart.c'))
+system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 system_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-console.c'))
 system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen_console.c'))
 system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_uartlite.c'))
@@ -39,5 +40,4 @@ system_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 system_ss.add(when: 'CONFIG_GOLDFISH_TTY', if_true: files('goldfish_tty.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
-specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 4ee09143165..ccfcdfb6526 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -46,7 +46,7 @@ specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
 system_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_ethlite.c'))
 
 system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('net_rx_pkt.c'))
-specific_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
+system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
 
 if have_vhost_net
   system_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
diff --git a/hw/scsi/meson.build b/hw/scsi/meson.build
index b874fe1ecdb..69fde0cf840 100644
--- a/hw/scsi/meson.build
+++ b/hw/scsi/meson.build
@@ -1,7 +1,6 @@
 scsi_ss = ss.source_set()
 specific_scsi_ss = ss.source_set()
 virtio_scsi_ss = ss.source_set()
-specific_virtio_scsi_ss = ss.source_set()
 
 scsi_ss.add(files(
   'emulation.c',
@@ -21,10 +20,9 @@ virtio_scsi_ss.add(files('virtio-scsi-dataplane.c'))
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi.c'))
 virtio_scsi_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi.c'))
 
-specific_virtio_scsi_ss.add(files('virtio-scsi.c'))
-specific_virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
+virtio_scsi_ss.add(files('virtio-scsi.c'))
+virtio_scsi_ss.add(when: 'CONFIG_VHOST_SCSI_COMMON', if_true: files('vhost-scsi-common.c'))
 
-specific_scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: specific_virtio_scsi_ss)
 scsi_ss.add_all(when: 'CONFIG_VIRTIO_SCSI', if_true: virtio_scsi_ss)
 
 specific_scsi_ss.add(when: 'CONFIG_SPAPR_VSCSI', if_true: files('spapr_vscsi.c'))
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 08872ba68b4..415e359e9fc 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -9,8 +9,7 @@ system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vs
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
 system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
-specific_virtio_ss = ss.source_set()
-specific_virtio_ss.add(files('virtio.c'))
+system_virtio_ss.add(files('virtio.c'))
 system_virtio_ss.add(files('virtio-qmp.c'))
 
 if have_vhost
@@ -53,10 +52,10 @@ endif
 system_virtio_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-rng.c'))
 
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
-specific_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
-specific_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pmem.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: files('virtio-nsm.c'))
 system_virtio_ss.add(when: 'CONFIG_VIRTIO_NSM', if_true: [files('cbor-helpers.c'), libcbor])
@@ -97,5 +96,4 @@ stub_ss.add(files('virtio-md-stubs.c'))
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.52.0


