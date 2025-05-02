Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7A4C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 13:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAqNs-0005jS-18; Fri, 02 May 2025 09:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAqNl-0005iT-Rq
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:24:50 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAqNj-0004WI-FM
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:24:49 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f5bef591d6so3900653a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746192285; x=1746797085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LYAUx9DJ6xKy5d584zL5N/phNdMDhpbOBcPpyre3rSg=;
 b=a95CsSyAPnAw4Y4JjzPIaCrqwFx+4N6tK6QI6XOVbZn5PSPlzWadlL985SnQ3/vnOQ
 3frcF+2QUFp1+NF2YEzUIxnzacq/Mb+6pEbfht4Hs8eRvMtApvLJZdYGxQaLgosL1ACq
 TDdNyFt8JLuGe6zuTdAS6WvTj9KtTXMHO/DQtfPwvbh42bpzMTxsKAt7JV0Bqj8o8aUg
 5vcAyxl60WH5GjMc0uPKeBMPavxFkEa+nogfZ88pXcTOe2D9h2VpCYVL1beUhBzyI4VO
 FV7GQgLqgYg48HOSAuw7qMk4VdDOOoCUffFYj64Us3TciKeK5DCU+HyNSMyzYuUakDdq
 1zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746192285; x=1746797085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LYAUx9DJ6xKy5d584zL5N/phNdMDhpbOBcPpyre3rSg=;
 b=JOxfp4TwbgA1xbWREzE3ynN0VpOqJdiNLYrd+LZvJuZnFP0orYIfKsPDaAXHklM9oz
 gFnDnCG8U3vhQt3m7ahxv+0xg46Xaykxxyv4JFuVKAgwyhjtL9U9XQeJZsliJTjV6AI4
 a5/c4fRKyIUdS/Qglbl6erIysjGYMgvUIgFD3i/rk8nQGGcT7p+3VAMVKQljpTfmYCke
 2inoDkhS7FP3PwocSCsgAiEL0L3ZkEHvsyr4NoT3WM6mtT+UFbxhkLjhWPkquS2nXinn
 B7G6i6vE4nrmQQz1b6fsTskqZvB25NZsU6Egye8WSZ6iY8PgzJN5CMnckAV/w2hFa3Xm
 dBFQ==
X-Gm-Message-State: AOJu0Ywc8Bs1TZlM3/suoejp60BrR8b9fbYotzvKQndGUzBg6lKnzx1h
 cnWqZxt5BkSUN3assKKjNfz4dEIem6k8Yx37ATbsgRQQnj9myxXqfFM2kIQsWfUcouIIVFsK7uY
 P
X-Gm-Gg: ASbGncvsbetGehEHWPKSd5xi01odkHYeDjz6TU4TR+STMGH16ZkK0fjpL20Nq1ZCvHb
 jlEpIqW60bbzSi1SQLNzp5gyEs8HBT1Lyt7e2GwLxvfBzssoc5Be9H7uj2Ddh/u6eCpMsvBvhCH
 eFKhmTeIevzIw2ddLuvRezD8fgEDriiwU+6aFUe6o1V/mYGU7yJp5d9JgghFkOeZ+MZkoy0hUlS
 9HsGnzR+kH2AObE7gTcknrFnEBARLXawa3PL1LRXbEKdMVWQ/guwo4+rNC5KObFS7gNyRzXb1BO
 OAUrJ+rh+TUo1P0n9G1RwpmwzES1tYc5Y+urvuPfwctbyX2qn1Lq1EKzMTOwsE+Ejzo8tMdFb3T
 FjfWyrGQ2aShK8dA=
X-Google-Smtp-Source: AGHT+IHZP86Pk/cWePeuc+ChNq3UewIyPTncUnZWBpQMeMMMROeNkB0WO7L4GdyAjsvKlxmFvmFdNA==
X-Received: by 2002:a05:6402:4408:b0:5f0:9eb3:8e71 with SMTP id
 4fb4d7f45d1cf-5fa788c0b0dmr2326404a12.27.1746192285025; 
 Fri, 02 May 2025 06:24:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa77756206sm1236041a12.3.2025.05.02.06.24.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 06:24:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH] hw/virtio: Introduce CONFIG_VIRTIO_LEGACY to disable
 legacy support
Date: Fri,  2 May 2025 15:24:41 +0200
Message-ID: <20250502132441.64723-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Legacy VirtIO devices don't have their endianness clearly defined.
QEMU infers it taking the endianness of the (target) binary, or,
when a target support switching endianness at runtime, taking the
endianness of the vCPU accessing the device.

Devices modelling shouldn't really change depending on a property
of a CPU accessing it.

For heterogeneous systems, it is simpler to break such dev <-> cpu
dependency, only allowing generic device models, with no knowledge
of CPU (or DMA controller) accesses.

Therefore we introduce the VIRTIO_LEGACY Kconfig key. We keep the
current default (enabled).
New binaries can set CONFIG_VIRTIO_LEGACY=n to restrict models to
the VirtIO version 1 spec.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 5 ++++-
 hw/virtio/virtio.c                | 8 ++++++++
 target/arm/cpu.c                  | 5 +++++
 target/ppc/cpu_init.c             | 5 +++++
 hw/virtio/Kconfig                 | 5 +++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 07aae69042a..b5b471711a6 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -20,7 +20,10 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
+#include CONFIG_DEVICES
+
+#if defined(CONFIG_VIRTIO_LEGACY) && \
+    (defined(TARGET_PPC64) || defined(TARGET_ARM))
 #define LEGACY_VIRTIO_IS_BIENDIAN 1
 #endif
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 480c2e50365..659ab3cb969 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -47,6 +47,8 @@
 #include "standard-headers/linux/virtio_mem.h"
 #include "standard-headers/linux/virtio_vsock.h"
 
+#include CONFIG_DEVICES
+
 /*
  * Maximum size of virtio device config space
  */
@@ -3502,6 +3504,7 @@ void virtio_init(VirtIODevice *vdev, uint16_t device_id, size_t config_size)
 bool virtio_legacy_allowed(VirtIODevice *vdev)
 {
     switch (vdev->device_id) {
+#ifdef CONFIG_VIRTIO_LEGACY
     case VIRTIO_ID_NET:
     case VIRTIO_ID_BLOCK:
     case VIRTIO_ID_CONSOLE:
@@ -3513,6 +3516,7 @@ bool virtio_legacy_allowed(VirtIODevice *vdev)
     case VIRTIO_ID_RPROC_SERIAL:
     case VIRTIO_ID_CAIF:
         return true;
+#endif
     default:
         return false;
     }
@@ -4014,8 +4018,10 @@ static const Property virtio_properties[] = {
     DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
     DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
     DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
+#ifdef CONFIG_VIRTIO_LEGACY
     DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
                      disable_legacy_check, false),
+#endif
 };
 
 static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
@@ -4151,7 +4157,9 @@ static void virtio_device_class_init(ObjectClass *klass, const void *data)
     vdc->start_ioeventfd = virtio_device_start_ioeventfd_impl;
     vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
 
+#ifdef CONFIG_VIRTIO_LEGACY
     vdc->legacy_features |= VIRTIO_LEGACY_FEATURES;
+#endif
 }
 
 bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 5e951675c60..d01fcb9fd1a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -39,6 +39,7 @@
 #if !defined(CONFIG_USER_ONLY)
 #include "hw/loader.h"
 #include "hw/boards.h"
+#include CONFIG_DEVICES
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
 #endif /* CONFIG_TCG */
@@ -1130,6 +1131,7 @@ static void arm_cpu_kvm_set_irq(void *opaque, int irq, int level)
 #endif
 }
 
+#ifdef CONFIG_VIRTIO_LEGACY
 static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1138,6 +1140,7 @@ static bool arm_cpu_virtio_is_big_endian(CPUState *cs)
     cpu_synchronize_state(cs);
     return arm_cpu_data_is_big_endian(env);
 }
+#endif
 
 #ifdef CONFIG_TCG
 bool arm_cpu_exec_halt(CPUState *cs)
@@ -2681,7 +2684,9 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
     .asidx_from_attrs = arm_asidx_from_attrs,
     .write_elf32_note = arm_cpu_write_elf32_note,
     .write_elf64_note = arm_cpu_write_elf64_note,
+#ifdef CONFIG_VIRTIO_LEGACY
     .virtio_is_big_endian = arm_cpu_virtio_is_big_endian,
+#endif
     .legacy_vmsd = &vmstate_arm_cpu,
 };
 #endif
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b0973b6df95..4b6c347bda8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -50,6 +50,7 @@
 #include "hw/boards.h"
 #include "hw/intc/intc.h"
 #include "kvm_ppc.h"
+#include CONFIG_DEVICES
 #endif
 
 #include "cpu_init.h"
@@ -7352,12 +7353,14 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 
+#ifdef CONFIG_VIRTIO_LEGACY
 static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
 
     return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
 }
+#endif
 
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
                               uint64_t **irq_counts, unsigned int *nb_irqs)
@@ -7470,7 +7473,9 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
+#ifdef CONFIG_VIRTIO_LEGACY
     .virtio_is_big_endian = ppc_cpu_is_big_endian,
+#endif
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
 #endif
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 7648a2d68da..314185f0016 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -1,6 +1,11 @@
 config VIRTIO
     bool
 
+config VIRTIO_LEGACY
+    bool
+    default y
+    depends on VIRTIO
+
 config VIRTIO_RNG
     bool
     default y
-- 
2.47.1


