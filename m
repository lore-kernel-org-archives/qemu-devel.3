Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AF0E65273
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 14:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmYmx-0006Q5-EO; Sun, 01 Feb 2026 09:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYmt-0006P1-HF
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:50:55 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmYmm-00026h-Jd
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 09:50:54 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-481188b7760so23083605e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769957442; x=1770562242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3cCvjcH4nd/9UYNExPfAm0kf8ISu0Nv8+rKUq7uBgRQ=;
 b=gkcW+a/dd5zYIZCp3iY5gk+u3toR8JudooJxKEoX4RKZyUKp63oOj/iWxkCvxARxyD
 CWTXkhwETpFuKxuds1QJfhfTjHpGFY55QoDjUyJR0zFyUYarXPc4qIutGTw4cV7M5JGP
 bpnXKeWrpymPqVcz9ked3W3NF6oGilIVjEt9uxHgQAn3zbJ8YCU2FrIk8XT2TM+JOYia
 XvI62G0KX7rjnCKu1CN26IZIb/+Cz0E1uAflmetQIpGrFg4HPBDpGyWeE2SlfVpKKWyz
 Vu8oxtYcQRYkIBE/Gq8ZTK47zCt+p0ZkERY8UrodeZbZXVXM8jqwHRNElGwaiGWcZvNF
 9P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769957442; x=1770562242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3cCvjcH4nd/9UYNExPfAm0kf8ISu0Nv8+rKUq7uBgRQ=;
 b=cA1T9z98I4ubJKCdSg1n3vMhfVFF5zio35nbHOsW6aGuBmCOIKxIWSQKi9CRtc0H4M
 MO0ckpqEl+l4RtbvA21lOk/MiOr+8JvhG94iA1mxzvdb59mBHnxa+nVDVbjvi2lULjt9
 BeNa4Hx3e8D5+azDPdKHDaNHMpzo2pnmsjavH3916jcG+aNtaFV+KydIQiWhtFXbUeXf
 DjRh17b3h9qgrOXZc3EBFXr0oT8mqC9l1vArJE8LwDs4LLmdwit+aiCf4ILUwoUdKauN
 2YLtuqXtZPiq9Oi74xeGgmZsDCiAJvk/KQZH/cL0oHePKRoWbEmX1qxWIe1h7t+8mYOi
 224g==
X-Gm-Message-State: AOJu0YyRxDhvvLaJBZ+J2NaIbk6kcnfV5Jidz713rXx4kuBy2sQckmhq
 L1ApEBBmwD91p+vVJSH9idV3yBxQFNVL2pEg45AZeWRRgZ/ocqWebWBYp1Dwbd40ChTDqHR1TyG
 caraN1e4=
X-Gm-Gg: AZuq6aLVhUPv4QXBSHpQv/WChFfeE5q8yXCbQfF5DKz9A2zrJqlqpIqM8n0ybDe58Ia
 Nle0dlQ/xA76FBJhXy1gZgCH/r+mep53NEmdCY1awfQOTw06vamzVKJpSi5Mb57+3e5n5eZ5+8Y
 539q8RsjKcnC2h7tio5j18GvadGmMGVtxuks1AhJEB5qUyLTDZ9j+YWg/W/sf1IpPZ38PiPRAt5
 Y/skiZplt+DHQOfWS5TTIkpJey52zERmVojkQPFBcZjQ6t1c7tOFDuiJcHbH3hnup4oVv47vdZm
 5udCqJIPt5LfrlQ7ep/01x/wEog986O5O3fUEzXZxxuLSER9Nwzfg1uftQTs9YkTd/je6CClZLh
 OIh/xzd4DrkHR8/6mMwyu05nE7Q9oXBGafHp8OTMrg+v9VcI8m++Dmb5PZDxaTnOxxIlj2YT1i0
 ieR6LDfpsD5BDN/23z50xmltjZsU1LHPk8fek4MguHe51CptLj25hWck8KbngT
X-Received: by 2002:a05:600c:3b23:b0:480:52fe:58f5 with SMTP id
 5b1f17b1804b1-482db4a01d8mr130309155e9.31.1769957441994; 
 Sun, 01 Feb 2026 06:50:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c428basm416115155e9.12.2026.02.01.06.50.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 06:50:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] bulk: Remove extraneous semicolon symbol after function body
Date: Sun,  1 Feb 2026 15:50:40 +0100
Message-ID: <20260201145040.60074-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
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

C function body starts with ‘{’ and ends with ‘}’, no need for
extra semicolon (‘;’), reserved to end statement / declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/pv.h                     |  2 +-
 accel/hvf/hvf-accel-ops.c                 |  2 +-
 accel/qtest/qtest.c                       |  2 +-
 audio/jackaudio.c                         |  2 +-
 contrib/plugins/execlog.c                 |  2 +-
 hw/arm/aspeed_ast2400_palmetto.c          |  2 +-
 hw/arm/aspeed_ast2500_evb.c               |  2 +-
 hw/arm/aspeed_ast2500_fp5280g2.c          |  2 +-
 hw/arm/aspeed_ast2500_g220a.c             |  2 +-
 hw/arm/aspeed_ast2500_romulus.c           |  2 +-
 hw/arm/aspeed_ast2500_sonorapass.c        |  2 +-
 hw/arm/aspeed_ast2500_tiogapass.c         |  2 +-
 hw/arm/aspeed_ast2500_witherspoon.c       |  2 +-
 hw/arm/aspeed_ast2500_yosemitev2.c        |  2 +-
 hw/arm/aspeed_ast2600_evb.c               |  2 +-
 hw/arm/aspeed_ast2600_fuji.c              |  2 +-
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c    |  2 +-
 hw/arm/aspeed_ast2600_qcom-firework.c     |  2 +-
 hw/arm/aspeed_ast2600_rainier.c           |  2 +-
 hw/arm/bcm2836.c                          |  6 +++---
 hw/arm/npcm7xx_boards.c                   |  6 +++---
 hw/arm/npcm8xx_boards.c                   |  2 +-
 hw/arm/raspi.c                            | 14 +++++++-------
 hw/arm/virt-acpi-build.c                  |  2 +-
 hw/audio/virtio-snd.c                     |  2 +-
 hw/avr/arduino.c                          |  8 ++++----
 hw/avr/atmega.c                           |  8 ++++----
 hw/cxl/cxl-host-stubs.c                   | 10 +++++-----
 hw/intc/arm_gicv3_cpuif_common.c          |  2 +-
 hw/intc/pnv_xive.c                        |  2 +-
 hw/intc/pnv_xive2.c                       |  2 +-
 hw/misc/aspeed_xdma.c                     |  4 ++--
 hw/net/ftgmac100.c                        |  2 +-
 hw/net/rocker/qmp-norocker.c              |  8 ++++----
 hw/net/vmxnet3.c                          |  2 +-
 hw/pci-bridge/pci_expander_bridge_stubs.c |  2 +-
 hw/rx/rx-gdbsim.c                         |  4 ++--
 hw/rx/rx62n.c                             |  4 ++--
 hw/tricore/triboard.c                     |  2 +-
 target/arm/tcg/translate.c                |  2 +-
 target/riscv/cpu_helper.c                 |  2 +-
 tests/unit/test-int128.c                  |  2 +-
 42 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/target/s390x/kvm/pv.h b/target/s390x/kvm/pv.h
index e266fc3d545..511b267234b 100644
--- a/target/s390x/kvm/pv.h
+++ b/target/s390x/kvm/pv.h
@@ -58,7 +58,7 @@ static inline void s390_pv_prep_reset(void) {}
 static inline int s390_pv_verify(struct S390PVResponse *pv_resp) { return 0; }
 static inline void s390_pv_unshare(void) {}
 static inline void s390_pv_inject_reset_error(CPUState *cs,
-                                              struct S390PVResponse pv_resp) {};
+                                              struct S390PVResponse pv_resp) {}
 static inline uint64_t kvm_s390_pv_dmp_get_size_cpu(void) { return 0; }
 static inline uint64_t kvm_s390_pv_dmp_get_size_mem_state(void) { return 0; }
 static inline uint64_t kvm_s390_pv_dmp_get_size_completion_data(void) { return 0; }
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index b74a5779c3d..7312705d29b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -374,7 +374,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 
     ops->get_vcpu_stats = hvf_get_vcpu_stats;
-};
+}
 
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
diff --git a/accel/qtest/qtest.c b/accel/qtest/qtest.c
index bb1491d93b4..9d8abe34e9b 100644
--- a/accel/qtest/qtest.c
+++ b/accel/qtest/qtest.c
@@ -69,7 +69,7 @@ static void qtest_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->get_virtual_clock = qtest_get_virtual_clock;
     ops->set_virtual_clock = qtest_set_virtual_clock;
     ops->handle_interrupt = generic_handle_interrupt;
-};
+}
 
 static const TypeInfo qtest_accel_ops_type = {
     .name = ACCEL_OPS_NAME("qtest"),
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 7a3fcaedbae..4b694355314 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -160,7 +160,7 @@ static int qjack_buffer_write(QJackBuffer *buffer, float *data, int size)
 
     qatomic_add(&buffer->used, frames);
     return frames * buffer->channels * sizeof(float);
-};
+}
 
 /* write PCM linear */
 static int qjack_buffer_write_l(QJackBuffer *buffer, float **dest, int frames)
diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 811f3203199..5e3f2cc7bd8 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -331,7 +331,7 @@ gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
 #else
     return g_pattern_match_string(pspec, string);
 #endif
-};
+}
 #define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qemu(p, s)
 
 static GPtrArray *registers_init(int vcpu_index)
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 776aa43a45d..e44a0e72c72 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -66,7 +66,7 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     amc->i2c_init  = palmetto_bmc_i2c_init;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2400_palmetto_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 8b5cb67be9b..d72a7290e38 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -53,7 +53,7 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
     amc->i2c_init  = ast2500_evb_i2c_init;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_evb_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_fp5280g2.c b/hw/arm/aspeed_ast2500_fp5280g2.c
index 858e0388714..6846ae50395 100644
--- a/hw/arm/aspeed_ast2500_fp5280g2.c
+++ b/hw/arm/aspeed_ast2500_fp5280g2.c
@@ -74,7 +74,7 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc,
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_fp5280g2_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 3f979a78e57..c3646c1bdc9 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -78,7 +78,7 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
     amc->i2c_init  = g220a_bmc_i2c_init;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_g220a_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 91b660e74bb..88f74feb317 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -48,7 +48,7 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc,
     amc->i2c_init  = romulus_bmc_i2c_init;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_romulus_types[] = {
      {
diff --git a/hw/arm/aspeed_ast2500_sonorapass.c b/hw/arm/aspeed_ast2500_sonorapass.c
index 84de4f56b37..b1cd1ec73fb 100644
--- a/hw/arm/aspeed_ast2500_sonorapass.c
+++ b/hw/arm/aspeed_ast2500_sonorapass.c
@@ -88,7 +88,7 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     amc->i2c_init  = sonorapass_bmc_i2c_init;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_sonorapass_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 186dbc1da30..c90c9398926 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -76,7 +76,7 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc,
     amc->i2c_init  = tiogapass_bmc_i2c_init;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_tiogapass_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 28d437fec08..06de62bbb50 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -98,7 +98,7 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
     amc->i2c_init  = witherspoon_bmc_i2c_init;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_witherspoon_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index eaa75bcccbb..fd28aa05b8e 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -77,7 +77,7 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc,
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2500_yosemitev2_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index c43d2687c1c..d8aedaeb992 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -51,7 +51,7 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
-};
+}
 
 static const TypeInfo aspeed_ast2600_evb_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e276..0843a311081 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -126,7 +126,7 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
     amc->uart_default = ASPEED_DEV_UART1;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2600_fuji_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c b/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
index bbdeb602368..1ff2c94f2b9 100644
--- a/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
+++ b/hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
@@ -41,7 +41,7 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2600_qcom_dc_scm_v1_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2600_qcom-firework.c b/hw/arm/aspeed_ast2600_qcom-firework.c
index a4dbe6eea8a..dfd313dd597 100644
--- a/hw/arm/aspeed_ast2600_qcom-firework.c
+++ b/hw/arm/aspeed_ast2600_qcom-firework.c
@@ -77,7 +77,7 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
-};
+}
 
 static const TypeInfo aspeed_ast2600_qcom_firework_types[] = {
     {
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8f0a412ddcf..8dd73d8582d 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -184,7 +184,7 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
-};
+}
 
 static const TypeInfo aspeed_ast2600_rainier_types[] = {
     {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ee2f44debd1..5df66382362 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -180,7 +180,7 @@ static void bcm2835_class_init(ObjectClass *oc, const void *data)
     bc->core_count = 1;
     bc->peri_base = 0x20000000;
     dc->realize = bcm2835_realize;
-};
+}
 
 static void bcm2836_class_init(ObjectClass *oc, const void *data)
 {
@@ -193,7 +193,7 @@ static void bcm2836_class_init(ObjectClass *oc, const void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0xf;
     dc->realize = bcm2836_realize;
-};
+}
 
 #ifdef TARGET_AARCH64
 static void bcm2837_class_init(ObjectClass *oc, const void *data)
@@ -207,7 +207,7 @@ static void bcm2837_class_init(ObjectClass *oc, const void *data)
     bc->ctrl_base = 0x40000000;
     bc->clusterid = 0x0;
     dc->realize = bcm2836_realize;
-};
+}
 #endif
 
 static const TypeInfo bcm283x_types[] = {
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 57a8d3186e6..c94ec068847 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -484,7 +484,7 @@ static void npcm750_evb_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = npcm750_evb_init;
     mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
-};
+}
 
 static void gsj_machine_class_init(ObjectClass *oc, const void *data)
 {
@@ -497,7 +497,7 @@ static void gsj_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = quanta_gsj_init;
     mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
-};
+}
 
 static void gbs_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
@@ -523,7 +523,7 @@ static void kudo_bmc_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = kudo_bmc_init;
     mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
-};
+}
 
 static void mori_bmc_machine_class_init(ObjectClass *oc, const void *data)
 {
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 042a928857c..9eeb2c08028 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -235,7 +235,7 @@ static void npcm845_evb_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "Nuvoton NPCM845 Evaluation Board (Cortex-A35)";
     mc->init = npcm845_evb_init;
     mc->default_ram_size = 1 * GiB;
-};
+}
 
 static const TypeInfo npcm8xx_machine_types[] = {
     {
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 00e4a10466a..13691c9b651 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -328,14 +328,14 @@ void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     mc->default_ram_id = "ram";
-};
+}
 
 static void raspi_machine_class_init(MachineClass *mc,
                                      uint32_t board_rev)
 {
     raspi_machine_class_common_init(mc, board_rev);
     mc->init = raspi_machine_init;
-};
+}
 
 static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
 {
@@ -345,7 +345,7 @@ static void raspi0_machine_class_init(ObjectClass *oc, const void *data)
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x920092; /* Revision 1.2 */
     raspi_machine_class_init(mc, rmc->board_rev);
-};
+}
 
 static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
 {
@@ -355,7 +355,7 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, const void *data)
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x900021; /* Revision 1.1 */
     raspi_machine_class_init(mc, rmc->board_rev);
-};
+}
 
 static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
 {
@@ -365,7 +365,7 @@ static void raspi2b_machine_class_init(ObjectClass *oc, const void *data)
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa21041;
     raspi_machine_class_init(mc, rmc->board_rev);
-};
+}
 
 #ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
@@ -376,7 +376,7 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, const void *data)
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
     raspi_machine_class_init(mc, rmc->board_rev);
-};
+}
 
 static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
 {
@@ -386,7 +386,7 @@ static void raspi3b_machine_class_init(ObjectClass *oc, const void *data)
     mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
-};
+}
 #endif /* TARGET_AARCH64 */
 
 static const TypeInfo raspi_machine_types[] = {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 03b43425746..2b0dc49615f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -856,7 +856,7 @@ build_dbg2(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     g_array_append_vals(table_data, name, namespace_length);
 
     acpi_table_end(linker, &table);
-};
+}
 
 /*
  * ACPI spec, Revision 6.0 Errata A
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9101560f387..3f79d20fa53 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -498,7 +498,7 @@ static const char *print_code(uint32_t code)
     }
 
     #undef CASE
-};
+}
 
 /*
  * Handles VIRTIO_SND_R_PCM_PREPARE.
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index e166ca18e11..9891f90a42e 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -82,7 +82,7 @@ static void arduino_duemilanove_class_init(ObjectClass *oc, const void *data)
     mc->alias       = "2009";
     amc->mcu_type   = TYPE_ATMEGA168_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
-};
+}
 
 static void arduino_uno_class_init(ObjectClass *oc, const void *data)
 {
@@ -97,7 +97,7 @@ static void arduino_uno_class_init(ObjectClass *oc, const void *data)
     mc->alias       = "uno";
     amc->mcu_type   = TYPE_ATMEGA328_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
-};
+}
 
 static void arduino_mega_class_init(ObjectClass *oc, const void *data)
 {
@@ -112,7 +112,7 @@ static void arduino_mega_class_init(ObjectClass *oc, const void *data)
     mc->alias       = "mega";
     amc->mcu_type   = TYPE_ATMEGA1280_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
-};
+}
 
 static void arduino_mega2560_class_init(ObjectClass *oc, const void *data)
 {
@@ -127,7 +127,7 @@ static void arduino_mega2560_class_init(ObjectClass *oc, const void *data)
     mc->alias       = "mega2560";
     amc->mcu_type   = TYPE_ATMEGA2560_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
-};
+}
 
 static const TypeInfo arduino_machine_types[] = {
     {
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 280f613af3a..c00aedec176 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -409,7 +409,7 @@ static void atmega168_class_init(ObjectClass *oc, const void *data)
     amc->adc_count = 6;
     amc->irq = irq168_328;
     amc->dev = dev168_328;
-};
+}
 
 static void atmega328_class_init(ObjectClass *oc, const void *data)
 {
@@ -424,7 +424,7 @@ static void atmega328_class_init(ObjectClass *oc, const void *data)
     amc->adc_count = 6;
     amc->irq = irq168_328;
     amc->dev = dev168_328;
-};
+}
 
 static void atmega1280_class_init(ObjectClass *oc, const void *data)
 {
@@ -439,7 +439,7 @@ static void atmega1280_class_init(ObjectClass *oc, const void *data)
     amc->adc_count = 16;
     amc->irq = irq1280_2560;
     amc->dev = dev1280_2560;
-};
+}
 
 static void atmega2560_class_init(ObjectClass *oc, const void *data)
 {
@@ -454,7 +454,7 @@ static void atmega2560_class_init(ObjectClass *oc, const void *data)
     amc->adc_count = 16;
     amc->irq = irq1280_2560;
     amc->dev = dev1280_2560;
-};
+}
 
 static const TypeInfo atmega_mcu_types[] = {
     {
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index c015baac813..050f606c522 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -8,13 +8,13 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 
-void cxl_fmws_link_targets(Error **errp) {};
-void cxl_machine_init(Object *obj, CXLState *state) {};
-void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
+void cxl_fmws_link_targets(Error **errp) {}
+void cxl_machine_init(Object *obj, CXLState *state) {}
+void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {}
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     return base;
-};
-void cxl_fmws_update_mmio(void) {};
+}
+void cxl_fmws_update_mmio(void) {}
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
index ff1239f65db..92d476c8d06 100644
--- a/hw/intc/arm_gicv3_cpuif_common.c
+++ b/hw/intc/arm_gicv3_cpuif_common.c
@@ -19,4 +19,4 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
     CPUARMState *env = &arm_cpu->env;
 
     env->gicv3state = (void *)s;
-};
+}
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 13ac2c6ccbf..4a0fa263130 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -2097,7 +2097,7 @@ static void pnv_xive_class_init(ObjectClass *klass, const void *data)
     xnc->notify = pnv_xive_notify;
     xpc->match_nvt  = pnv_xive_match_nvt;
     xpc->get_config = pnv_xive_presenter_get_config;
-};
+}
 
 static const TypeInfo pnv_xive_info = {
     .name          = TYPE_PNV_XIVE,
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ae424d01c42..ed53ecbecbe 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -2606,7 +2606,7 @@ static void pnv_xive2_class_init(ObjectClass *klass, const void *data)
     xpc->match_nvt  = pnv_xive2_match_nvt;
     xpc->get_config = pnv_xive2_presenter_get_config;
     xpc->broadcast  = pnv_xive2_broadcast;
-};
+}
 
 static const TypeInfo pnv_xive2_info = {
     .name          = TYPE_PNV_XIVE2,
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index 3e2beafcedf..757cc276e6c 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -187,7 +187,7 @@ static void aspeed_2500_xdma_class_init(ObjectClass *klass, const void *data)
     axc->intr_ctrl_mask = XDMA_IRQ_ENG_CTRL_W_MASK;
     axc->intr_status = XDMA_IRQ_ENG_STAT;
     axc->intr_complete = XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
-};
+}
 
 static const TypeInfo aspeed_2500_xdma_info = {
     .name = TYPE_ASPEED_2500_XDMA,
@@ -209,7 +209,7 @@ static void aspeed_2400_xdma_class_init(ObjectClass *klass, const void *data)
     axc->intr_ctrl_mask = XDMA_IRQ_ENG_CTRL_W_MASK;
     axc->intr_status = XDMA_IRQ_ENG_STAT;
     axc->intr_complete = XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
-};
+}
 
 static const TypeInfo aspeed_2400_xdma_info = {
     .name = TYPE_ASPEED_2400_XDMA,
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d29f7dcd171..8547cad509e 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1389,7 +1389,7 @@ static void aspeed_mii_reset(DeviceState *dev)
     s->phydata = 0;
 
     aspeed_mii_transition(s, !!(s->phycr & ASPEED_MII_PHYCR_FIRE));
-};
+}
 
 static void aspeed_mii_realize(DeviceState *dev, Error **errp)
 {
diff --git a/hw/net/rocker/qmp-norocker.c b/hw/net/rocker/qmp-norocker.c
index f6c1196a244..49726bb7269 100644
--- a/hw/net/rocker/qmp-norocker.c
+++ b/hw/net/rocker/qmp-norocker.c
@@ -22,13 +22,13 @@ RockerSwitch *qmp_query_rocker(const char *name, Error **errp)
 {
     error_setg(errp, "rocker %s not found", name);
     return NULL;
-};
+}
 
 RockerPortList *qmp_query_rocker_ports(const char *name, Error **errp)
 {
     error_setg(errp, "rocker %s not found", name);
     return NULL;
-};
+}
 
 RockerOfDpaFlowList *qmp_query_rocker_of_dpa_flows(const char *name,
                                                    bool has_tbl_id,
@@ -37,7 +37,7 @@ RockerOfDpaFlowList *qmp_query_rocker_of_dpa_flows(const char *name,
 {
     error_setg(errp, "rocker %s not found", name);
     return NULL;
-};
+}
 
 RockerOfDpaGroupList *qmp_query_rocker_of_dpa_groups(const char *name,
                                                      bool has_type,
@@ -46,4 +46,4 @@ RockerOfDpaGroupList *qmp_query_rocker_of_dpa_groups(const char *name,
 {
     error_setg(errp, "rocker %s not found", name);
     return NULL;
-};
+}
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 97156dd33b9..093b7b24bd2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1288,7 +1288,7 @@ vmxnet3_dump_conf_descr(const char *name,
     VMW_CFPRN("%s descriptor dump: Version %u, Length %u",
               name, pm_descr->confVer, pm_descr->confLen);
 
-};
+}
 
 static void vmxnet3_update_pm_state(VMXNET3State *s)
 {
diff --git a/hw/pci-bridge/pci_expander_bridge_stubs.c b/hw/pci-bridge/pci_expander_bridge_stubs.c
index b35180311f6..680f28e3432 100644
--- a/hw/pci-bridge/pci_expander_bridge_stubs.c
+++ b/hw/pci-bridge/pci_expander_bridge_stubs.c
@@ -11,4 +11,4 @@
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/cxl/cxl.h"
 
-void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {};
+void pxb_cxl_hook_up_registers(CXLState *state, PCIBus *bus, Error **errp) {}
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 0a0ad85a35a..bf91546068d 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -173,7 +173,7 @@ static void rx62n7_class_init(ObjectClass *oc, const void *data)
     rxc->mcu_name = TYPE_R5F562N7_MCU;
     rxc->xtal_freq_hz = 12 * 1000 * 1000;
     mc->desc = "gdb simulator (R5F562N7 MCU and external RAM)";
-};
+}
 
 static void rx62n8_class_init(ObjectClass *oc, const void *data)
 {
@@ -183,7 +183,7 @@ static void rx62n8_class_init(ObjectClass *oc, const void *data)
     rxc->mcu_name = TYPE_R5F562N8_MCU;
     rxc->xtal_freq_hz = 12 * 1000 * 1000;
     mc->desc = "gdb simulator (R5F562N8 MCU and external RAM)";
-};
+}
 
 static const TypeInfo rx_gdbsim_types[] = {
     {
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 3d137a517b8..0f0a7d97547 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -279,7 +279,7 @@ static void r5f562n7_class_init(ObjectClass *oc, const void *data)
     rxc->ram_size = 64 * KiB;
     rxc->rom_flash_size = 384 * KiB;
     rxc->data_flash_size = 32 * KiB;
-};
+}
 
 static void r5f562n8_class_init(ObjectClass *oc, const void *data)
 {
@@ -288,7 +288,7 @@ static void r5f562n8_class_init(ObjectClass *oc, const void *data)
     rxc->ram_size = 96 * KiB;
     rxc->rom_flash_size = 512 * KiB;
     rxc->data_flash_size = 32 * KiB;
-};
+}
 
 static const TypeInfo rx62n_types[] = {
     {
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 23f11cf0a16..39ecd477ab5 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -74,7 +74,7 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
     amc->soc_name   = "tc277d-soc";
-};
+}
 
 static const TypeInfo triboard_machine_types[] = {
     {
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 63735d97898..4f451f80cf6 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -603,7 +603,7 @@ static inline void gen_arm_shift_im(TCGv_i32 var, int shiftop,
             tcg_gen_or_i32(var, var, tmp);
         }
     }
-};
+}
 
 static inline void gen_arm_shift_reg(TCGv_i32 var, int shiftop,
                                      TCGv_i32 shift, int flags)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dd6c861a90e..fcb0eeacc14 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -378,7 +378,7 @@ uint8_t riscv_cpu_default_priority(int irq)
     }
 
     return default_iprio[irq] ? default_iprio[irq] : IPRIO_MMAXIPRIO;
-};
+}
 
 static int riscv_cpu_pending_to_irq(CPURISCVState *env,
                                     int extirq, unsigned int extirq_def_prio,
diff --git a/tests/unit/test-int128.c b/tests/unit/test-int128.c
index 25db2455e80..0728877f59e 100644
--- a/tests/unit/test-int128.c
+++ b/tests/unit/test-int128.c
@@ -42,7 +42,7 @@ static Int128 expand(uint32_t x)
     l = expand16(x & 65535);
     h = expand16(x >> 16);
     return (Int128) int128_make128(l, h);
-};
+}
 
 static void test_and(void)
 {
-- 
2.52.0


