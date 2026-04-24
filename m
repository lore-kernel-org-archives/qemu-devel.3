Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DD2FED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 19:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMA8-0003Dx-It; Fri, 24 Apr 2026 15:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMA7-0003Do-Bg
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGMA5-0001Mv-Er
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 15:26:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so5360249f8f.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777058760; x=1777663560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0XEW/JNVZsHqp/kQfSIMtvTC4gnmHOTEQxwltzxFLk8=;
 b=BK+iQq0ImApc5jh/c8tSrt1NIRGdGZvctBvIkZ2nBFRRZlojw6W33tdPDdc5nMdZ6n
 aW6qonDaaBRNxK2wKXkB/HxOtkdfzv92L7GD2y0okqFYpPnzv+FThRgbDQ4XGNoRm/g9
 WmkFMrAa68LWs22xbMYSBparo2ARBEtW02ftvbspiXLUO3Zw3X2Ec9K1uBdyEci0xGlu
 TL0wGp1cJO9lwRQpk+xRzYXeD7snkbvtutcekksdIvag7+rGBu8klWW7x/XRkVw3PfwJ
 sF1x7p1k6RrrI2Ncq82DSKZsoVAxiAc1KqBJvxy6LJFu+EPIXGrzoFPBVYKg6hkDWVDV
 u2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777058760; x=1777663560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0XEW/JNVZsHqp/kQfSIMtvTC4gnmHOTEQxwltzxFLk8=;
 b=kmhtQ67VUH08uA7epFW/tTRIDxCqBDjWJoN7ROzQwRiNGu3xC40I5DW88Zy+SKTlQ7
 9ZosJqLCBZ+LEUac+VNeFJAyTutuEkMfLrT9wwsqiyOfqqSJFQzPlmkHYtcw5PMR6X8i
 Rwhq7J2A/UtoBUUKqg4d+L+kQMe+rCuyciZ8+jVFluWYlS+jPRSTOxifROEYaQFIHkwe
 f6u0nxW2SkRqbP4DUtdquo8tBGYuASzQxA6z6c4u4V+ZJfj9CtjCduAQWl14N4ivMTF8
 /pgxAUlkgv2yOASZIYto+1MjbQDzvXb10QU5zHUhyGscKKeQbKKN7G2t+ioHrnF/+OPb
 08cQ==
X-Gm-Message-State: AOJu0YzBDQQa4/9RJzTU/s6rDKARv6af2/PsDg3NYvJnfNHuzddSSE2W
 d50asIVRqvpWFlELEct0andyC8y7kjBwkVCkK9tCCq2J0aorn38CSu6/XQlRQmR/4Gycw3cXU9e
 Yl//hsvQ=
X-Gm-Gg: AeBDieseL4Zy1bNagtUbi1bo53cQyeagpTxve9TKGZ+vwwBu2ZOhp64chA5Jbi34Kkb
 /OCQyPvP5qYXuoDc6A46ZFKFGJmTbmtbkgth4qOXH/YhDkoUpjIrZTAeTDfJ/HzeGU6JI9tLLrB
 oFElSXUuGcowu4K/VdafYDcGWT9+GLnbqmbraG7JTe5KXyGvWSiOqecXeCnEnsKN9JZ7tIN8XHZ
 DXUo5zt1mUmaJxWW875ufxvPjohOirsF4RzrYjLiDeqiVD82bD6hIsMdHtpC+ED/4Q3Xr/cdFcx
 wnWdofrpa6ochv4TS5+44XOPjdq/I1C1spqlxvTQTMGI9CLUJg0gfKxanVMyAufRORWwVnG754t
 Nx+zuRXtt1/8FfWnGq0heqnIV3gacASo/qiprZmXEH9+dA9rSilhwWcugeYBBBSrriMPSvvr4JA
 o06FbII5V6EtlnbiVbpNRxfVxze6QVSREXXBiQUwLUixrApy+UKEEnKXedEBUcZms264UB6Ry3g
 P5IEB+qtHY=
X-Received: by 2002:a5d:5d83:0:b0:441:1e41:197 with SMTP id
 ffacd0b85a97d-4411e41032fmr26410548f8f.31.1777058759528; 
 Fri, 24 Apr 2026 12:25:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d5b1sm65647731f8f.30.2026.04.24.12.25.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Apr 2026 12:25:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v4 28/62] hw: add compat machines for 11.1
Date: Fri, 24 Apr 2026 21:25:34 +0200
Message-ID: <20260424192543.22614-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424192543.22614-1-philmd@linaro.org>
References: <20260424192543.22614-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Add 11.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Reviewed-by: Eric Farman <farman@linux.ibm.com>  # s390
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20260331140347.653404-1-cohuck@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h   |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              | 11 +++++++++--
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             | 11 +++++++++--
 hw/ppc/spapr.c             | 17 ++++++++++++++---
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index f38b3f5f784..9d4ccd1c1cb 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -803,6 +803,9 @@ struct MachineState {
         } \
     } while (0)
 
+extern GlobalProperty hw_compat_11_0[];
+extern const size_t hw_compat_11_0_len;
+
 extern GlobalProperty hw_compat_10_2[];
 extern const size_t hw_compat_10_2_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 22325324d09..85a74363b52 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -208,6 +208,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_0[];
+extern const size_t pc_compat_11_0_len;
+
 extern GlobalProperty pc_compat_10_2[];
 extern const size_t pc_compat_10_2_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1725744d1aa..f62253e1aba 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4052,10 +4052,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
-static void virt_machine_11_0_options(MachineClass *mc)
+static void virt_machine_11_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+
+static void virt_machine_11_0_options(MachineClass *mc)
+{
+    virt_machine_11_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+}
+DEFINE_VIRT_MACHINE(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e95..1abc8ae7373 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,6 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
+GlobalProperty hw_compat_11_0[] = {};
+const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
+
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
     { "isa-cirrus-vga", "global-vmstate", "true" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4b53b5be4a9..2ecad3c503f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,6 +73,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_0[] = {};
+const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
+
 GlobalProperty pc_compat_10_2[] = {};
 const size_t pc_compat_10_2_len = G_N_ELEMENTS(pc_compat_10_2);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4d71e0d51a2..82457bdb167 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -428,12 +428,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_11_0_options(MachineClass *m)
+static void pc_i440fx_machine_11_1_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(11, 0);
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
+
+static void pc_i440fx_machine_11_0_options(MachineClass *m)
+{
+    pc_i440fx_machine_11_1_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
+}
+
+DEFINE_I440FX_MACHINE(11, 0);
 
 static void pc_i440fx_machine_10_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cb23322f5a4..972dd9275f6 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -364,12 +364,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_11_0_options(MachineClass *m)
+static void pc_q35_machine_11_1_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(11, 0);
+DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
+
+static void pc_q35_machine_11_0_options(MachineClass *m)
+{
+    pc_q35_machine_11_1_options(m);
+    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);
+}
+
+DEFINE_Q35_MACHINE(11, 0);
 
 static void pc_q35_machine_10_2_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index cf8ebd65e30..51158ce1c08 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
-static void virt_machine_11_0_options(MachineClass *mc)
+static void virt_machine_11_1_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+
+static void virt_machine_11_0_options(MachineClass *mc)
+{
+    virt_machine_11_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+}
+DEFINE_VIRT_MACHINE(11, 0)
 
 static void virt_machine_10_2_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ab39dfea6b..428b491a7df 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4761,14 +4761,25 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
 /*
- * pseries-11.0
+ * pseries-11.1
  */
-static void spapr_machine_11_0_class_options(MachineClass *mc)
+static void spapr_machine_11_1_class_options(MachineClass *mc)
 {
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(11, 0);
+DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);
+
+/*
+ * pseries-11.0
+ */
+static void spapr_machine_11_0_class_options(MachineClass *mc)
+{
+    spapr_machine_11_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
+}
+
+DEFINE_SPAPR_MACHINE(11, 0);
 
 /*
  * pseries-10.2
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3ef009463d1..cc768daeb04 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -907,14 +907,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_11_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_11_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(11, 1);
+
 static void ccw_machine_11_0_instance_options(MachineState *machine)
 {
+    ccw_machine_11_1_instance_options(machine);
 }
 
 static void ccw_machine_11_0_class_options(MachineClass *mc)
 {
+    ccw_machine_11_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(11, 0);
+DEFINE_CCW_MACHINE(11, 0);
 
 static void ccw_machine_10_2_instance_options(MachineState *machine)
 {
-- 
2.53.0


