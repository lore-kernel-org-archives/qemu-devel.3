Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53919E9A055
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fW-0005Rs-TH; Thu, 19 Feb 2026 12:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fT-0005Pt-Gv
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:23 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fR-0000T1-K2
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:23 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so166345066b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521500; x=1772126300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUfwa0oycwqnYQ2VQ69bE7FIxznUu+NWvjU6U13JUi0=;
 b=EYz2lv8nXmTHupf7u8MVFMKXH/U0gfS6B9X72DPhWIrr0tYMLkT+cxxljaGoxqY62q
 sMfw3bGGdkVls6ibrl7KHiivgtEwPi3QweH8/Qe3iHS7FRFiZynuFThflSDqv+8fmOz0
 XRJi6GI41q12en98Mz+NQ0Q0ZoQXqHXTNljE3K1SlrjalkWskgN4qrOoftJry9cAqrit
 wPYx9zn3Z2aI7RBXLRpwQPoIeORvNgd0W8cOvghC7uTY2cTRZ8lGNdhl6Hni4kFBEPwj
 FtiA9moyuZu+17R6LyzPNXKRunzsJdp4siWL5hncBLD7M0GZymA29eT/84x/WnjJC4oQ
 GtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521500; x=1772126300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QUfwa0oycwqnYQ2VQ69bE7FIxznUu+NWvjU6U13JUi0=;
 b=MGhdWwZ0dvx2VtkLEO3D9oYezAaHV6aijsuFerug5i0t699TIO+YZjdhZDH62dUHJY
 ey12tB9q67f8YsiZ4Q/1tGRgvHZA2HXg7C8bTJLr8iZmY0YXBtlvVJogh6kf0DH/qiMo
 dNnGwagEx7VGPhlsPlB85DHhDzeQxPBMFBUF9sg5rfwYYM86aPZQOfbyhX2k281PrBvw
 Xi4pl6NUtT85wj+eKBoqyvZQcXOoGdmCe4JTsRDElezlT0ApQ9bHurAf3fs5NeHXqP2m
 GqxgXFc0v7W8/FtUPd6SZsGN8it4b9ms9I00J4dFS6ocjtYNadr9jGOSu2rtU0m4fa3M
 E5vg==
X-Gm-Message-State: AOJu0YwfC2A+u/FO4KwfAoLs2H+btcCHxPelXO+M5fqMOmsyAcxX3tlc
 t/0hXYe4xBIDdWLhouEEMCTvHwO5rnGzQkmYw7EvPuBNzCz0WYMlNAVMl5vcFrNGhb4=
X-Gm-Gg: AZuq6aIfFRHHo2H74CvCPwO5reF6woQ07XUUWOaMPimPVFC+xDZAtLYIl3Py0SxXmQ1
 oMFf3YLgVf5ncERvXEYL4zhNBadSUaGqb96L+AFyQ9s9y9fuXh9+M1G+asx8R6OpYDJcOylVD14
 nYPVwhc19fbGks6uyEqsMNVgxtl0PlMZLco1IXVW6xb5XOx1+wmXwr+OU2Vl+XECfp9ekXSwbIo
 S4pTvHutj8HtM8XXJPKgrf/DAe8XvyxFVxXwjlTesIB9jRyAuUY99p8FDvtdAWNbp8+tjErNCcX
 kyZQ3g8DhsOcH8fez9Ivrq9SGXJVtfxzQ8M3CuBoBOd7avK+pbzb15LZpBBRnAkM/6Q0zBLeYwm
 BV2H5rNcEHV/A9z3eUijiqxudrPNwl5/6olBCly4Ix+y+37sb/y7mIMqnFT6Z5CKc96WJiVzqBu
 dnWiJLt80Ey0e68IHP97PAX3A=
X-Received: by 2002:a17:907:728c:b0:b8e:8874:8384 with SMTP id
 a640c23a62f3a-b8fb419390bmr1165549966b.4.1771521499992; 
 Thu, 19 Feb 2026 09:18:19 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65bad29d826sm4261165a12.13.2026.02.19.09.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B90D5F8CC;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 07/14] hw/mips: defer finalising gcr_base until reset
 time
Date: Thu, 19 Feb 2026 17:18:03 +0000
Message-ID: <20260219171810.602667-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Currently the cpu_reset() in mips_cpu_realizefn() hides an implicit
sequencing requirement when setting gcr_base. Without it we barf
because we end up setting the region between 0x0-0x000000001fbfffff
which trips over a qtest that accesses the GCR during "memsave 0 4096
/dev/null".

By moving to the reset phase we have to drop the property lest we are
admonished for "Attempting to set...after it was realized" but there
doesn't seem to be a need to expose the property anyway.

NB: it would be safer if I could guarantee the place in the reset tree
but I haven't quite grokked how to do that yet. Currently I see this
sequence when testing:

  env MALLOC_PERTURB_=43 G_TEST_DBUS_DAEMON=/home/alex/lsrc/qemu.git/tests/dbus-vmstate-daemon.sh UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-mips64el SPEED=thorough MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 G_TEST_SLOW=1 RUST_BACKTRACE=1 /home/alex/lsrc/qemu.git/builds/all/tests/qtest/test-hmp --tap -p /mips64el/hmp/boston
  TAP version 14
  # random seed: R02S0d3b1a4f1aef5198107851bdee539e7d
  # Start of mips64el tests
  # Start of hmp tests
  # starting QEMU: exec ./qemu-system-mips64el -qtest unix:/tmp/qtest-530181.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-530181.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -S -M boston -accel qtest
  main_cpu_reset: dbg
  mips_gcr_reset: dbg
  mps_reset_exit: dbg
  ok 1 /mips64el/hmp/boston
  # End of hmp tests
  # End of mips64el tests
  1..1

Cc: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260108143423.1378674-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use proper 3-phase reset
---
 include/hw/mips/cps.h | 14 +++++++++++++-
 hw/mips/cps.c         | 26 +++++++++++++++++---------
 hw/misc/mips_cmgcr.c  |  1 -
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 878b4d819f4..1084a10de0f 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -30,7 +30,7 @@
 #include "qom/object.h"
 
 #define TYPE_MIPS_CPS "mips-cps"
-OBJECT_DECLARE_SIMPLE_TYPE(MIPSCPSState, MIPS_CPS)
+OBJECT_DECLARE_TYPE(MIPSCPSState, MIPSCPSClass, MIPS_CPS)
 
 struct MIPSCPSState {
     SysBusDevice parent_obj;
@@ -48,6 +48,18 @@ struct MIPSCPSState {
     Clock *clock;
 };
 
+/*
+ * MIPSCPSClass:
+ * @parent_phases: The parent class' reset phase handlers.
+ *
+ * A Coherent Processing System model.
+ */
+struct MIPSCPSClass {
+    SysBusDeviceClass parent_class;
+
+    ResettablePhases parent_phases;
+};
+
 qemu_irq get_cps_irq(MIPSCPSState *cps, int pin_number);
 
 #endif
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 620ee972f8f..23918147276 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -55,6 +55,17 @@ static void main_cpu_reset(void *opaque)
     cpu_reset(cs);
 }
 
+static void mps_reset_exit(Object *obj, ResetType type)
+{
+    MIPSCPSState *s = MIPS_CPS(obj);
+    hwaddr gcr_base;
+
+    /* Global Configuration Registers - only valid once the CPU has been reset */
+    gcr_base = MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
+    memory_region_add_subregion(&s->container, gcr_base,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
+}
+
 static bool cpu_mips_itu_supported(CPUMIPSState *env)
 {
     bool is_mt = (env->CP0_Config5 & (1 << CP0C5_VP)) || ase_mt_available(env);
@@ -65,7 +76,6 @@ static bool cpu_mips_itu_supported(CPUMIPSState *env)
 static void mips_cps_realize(DeviceState *dev, Error **errp)
 {
     MIPSCPSState *s = MIPS_CPS(dev);
-    target_ulong gcr_base;
     bool itu_present = false;
 
     if (!clock_get(s->clock)) {
@@ -144,16 +154,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->container, 0,
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gic), 0));
 
-    /* Global Configuration Registers */
-    gcr_base = MIPS_CPU(first_cpu)->env.CP0_CMGCRBase << 4;
-
     object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
     object_property_set_uint(OBJECT(&s->gcr), "num-vp", s->num_vp,
                             &error_abort);
     object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0x800,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->gcr), "gcr-base", gcr_base,
-                            &error_abort);
     object_property_set_link(OBJECT(&s->gcr), "gic", OBJECT(&s->gic.mr),
                              &error_abort);
     object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
@@ -161,9 +166,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
         return;
     }
-
-    memory_region_add_subregion(&s->container, gcr_base,
-                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
 }
 
 static const Property mips_cps_properties[] = {
@@ -176,8 +178,13 @@ static const Property mips_cps_properties[] = {
 static void mips_cps_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    MIPSCPSClass *mcs = MIPS_CPS_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize = mips_cps_realize;
+
+    resettable_class_set_parent_phases(rc, NULL, NULL, mps_reset_exit,
+                                       &mcs->parent_phases);
     device_class_set_props(dc, mips_cps_properties);
 }
 
@@ -187,6 +194,7 @@ static const TypeInfo mips_cps_info = {
     .instance_size = sizeof(MIPSCPSState),
     .instance_init = mips_cps_init,
     .class_init = mips_cps_class_init,
+    .class_size = sizeof(MIPSCPSClass),
 };
 
 static void mips_cps_register_types(void)
diff --git a/hw/misc/mips_cmgcr.c b/hw/misc/mips_cmgcr.c
index 3e262e828bc..9e1c8d26ea5 100644
--- a/hw/misc/mips_cmgcr.c
+++ b/hw/misc/mips_cmgcr.c
@@ -214,7 +214,6 @@ static const VMStateDescription vmstate_mips_gcr = {
 static const Property mips_gcr_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSGCRState, num_vps, 1),
     DEFINE_PROP_INT32("gcr-rev", MIPSGCRState, gcr_rev, 0x800),
-    DEFINE_PROP_UINT64("gcr-base", MIPSGCRState, gcr_base, GCR_BASE_ADDR),
     DEFINE_PROP_LINK("gic", MIPSGCRState, gic_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_LINK("cpc", MIPSGCRState, cpc_mr, TYPE_MEMORY_REGION,
-- 
2.47.3


