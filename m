Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFA9F47CDB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFum-0000rr-FB; Thu, 05 Mar 2026 16:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuc-0000oh-Gq
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:19 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFua-0008P4-K6
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:14 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c738a4231a2so551234a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744831; x=1773349631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5idQi/OC8e82sVj6JCkzA1Vc/e1PnMuVGtyHxi+4wLA=;
 b=c29F3Ch7s/zAx7NAJCfpwCILHdmR9dLWFiXR9tFpEIiYYgoaXfLbEtMVs+tppB2Dfw
 FkOm+MCFEOsf9xJC8rPapB7m3/NxcTXzQfGVdyuAmFn0xTzAbUaN3GEMzE/PUjPMQHHB
 amAZg7MVHKCbEOsEY7gfM2QSIXLQtRx6xIqRE5WZQQfGBVdG8rnqdFPB31H2jnAnFxmu
 RNT4xmEZQehtcJcQ1M2/BEwhoe9apCBgw7u43Kcw1fQj+p+9d2q7tO8qoeRE52Alw9YY
 n0kbT6pGvEU3MJuP+y8hOHT0B2JYYfYj3zawdrZXn1N/fwGdbKbpqu5xPrWqg4X5KznZ
 rwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744831; x=1773349631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5idQi/OC8e82sVj6JCkzA1Vc/e1PnMuVGtyHxi+4wLA=;
 b=PR7TBYeymOvHY2a0mUA3GLw7ku3ftncwCRWZrPH8J8QxRAK1mtTPvdbLnUeXWKsFb+
 jHYCKAQXavCxMdzXhR3KvqLxoS9LwPiiS99v+nGZwWSOTGuv05uMtDbHlIS9tKWvfVFK
 fhov1R1A2AFFi0xHrXiBO1PqKVA/5I66AvA2SbOYij/7UiX6y5MKo/uFV8EtAmzFXd+5
 9vpyDp8vCFkX355sbOWFupj8gvEphrBjrG8IIaAb1jf+c8ddWCqc7vPk3huAb0iQUu7w
 3ZBx8qmJgZB90jL9olly+rmUOa/F+w7R65tUFKuNhgkJL1lH3qtlyXaugPVTwzK/Ojre
 ycFQ==
X-Gm-Message-State: AOJu0YxClu1V+D/atq1+mrCikHhYZCfdAzvSLqzL+dXPqNgtPBmkrzAk
 dGHrX1uzlQJzEuDZAdNXjX8MhsdXsO17XlRCMYwf9n+QBbWW5ZihzxEq0zXKUL/G0USXrRkypyi
 gL6KC
X-Gm-Gg: ATEYQzxU2xCNAjcujCEUM1tzoOXdb82cx9zgMJ5+R5T8izXO4kgHkU5QZBjPX6UWQ3N
 5n7etEqySTEyEOOT5SMP/4V/duW21nL5NI7hTlyvUCViXk9Cz9tOnkYXwov3N7cZ9Qn4xJFtbwE
 FtP0G0/eLTGUpGWoUxH69Htb4W2MPBqFy3t8+p55/4XItGzSrThjU30jDw8iufioNkmOA/4QJ7f
 i1hAn1kdsuClvAV1CMiDngchei4wszIsPjYpOdpX0/HYQlOaI4cF1m7SxT0nCxtY7HLzHwlOwsk
 brQPx8MAoF0ckFQ06pXUbEcm6O7emtjjpNYGt17cjtkVN8EyZbdOPjx5cpLbWHPKLjxf4Xx3kKA
 vpAsQUWF4aTQUDDtc74EAWZPSw92Ypo/q/ZrafkXVgcldU71MK5KYnt7FnrwrTpK9VyagG289ob
 etP+W2oGLd88KvxV23MgoWwrzMAYzHHMxyi2cn93mbOp6n93C2+DVZbkVaZKxGQY2CF+xDDnsiu
 xXF
X-Received: by 2002:a17:903:1b4b:b0:2ae:670e:309f with SMTP id
 d9443c01a7336-2ae80214c90mr9586505ad.34.1772744831037; 
 Thu, 05 Mar 2026 13:07:11 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b5813sm236992505ad.63.2026.03.05.13.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:07:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 6/6] hw/virtio/: make all compilation units common
Date: Thu,  5 Mar 2026 13:06:56 -0800
Message-ID: <20260305210656.2140206-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
References: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-7-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 913eaedbc52..056c75b4c7c 100644
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
index 20356fba812..821366f5e90 100644
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
@@ -55,10 +54,10 @@ endif
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
@@ -100,5 +99,4 @@ system_ss.add(when: ['CONFIG_VIRTIO_MD', 'CONFIG_VIRTIO_PCI'],
 
 system_ss.add(files('virtio-hmp-cmds.c'))
 
-specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
 system_ss.add(when: 'CONFIG_ACPI', if_true: files('virtio-acpi.c'))
-- 
2.47.3


