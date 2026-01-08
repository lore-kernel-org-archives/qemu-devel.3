Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72C2D1488B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdr61-000768-NA; Thu, 08 Jan 2026 09:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5t-00071Q-TH
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:36 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vdr5p-0000gu-RY
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:34:32 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432d2670932so449727f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 06:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767882868; x=1768487668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iroa14hBK2LVpeSpQfZj+3dFVlP7qrWupPJPhYrPWjw=;
 b=ESCndYqRS41Cbbtxt2Guiqz5CYulL46Oh7+0bPwD8bR+sHEV2PiLHqp5/T4TyB5gSf
 mmgkGPYONjSNLWfRfWZREWkxerwcxYM5yYjTfuzaEGMZclXRZGl0M/XbzQlrHZcfb25f
 70yaK5pu6uV0Pv268jgUkdLUCsTAKEZyLWXRu9Jb66eVI6ydc3BBWaWAqjDmJboeMf8S
 gZ5o0wuyHcWH8gyKeAohaAL4eJqXz/JtXJqzoNR+uoCMmqBPs/RCxmGnxGP1VMrf/Cg0
 3JrPxSJ2bR8vuLZ8ZZ0AeoToEcAjXvoFCOae/FpXAUifEn+zTOw8s2vxegu3kogjSlow
 ThHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767882868; x=1768487668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Iroa14hBK2LVpeSpQfZj+3dFVlP7qrWupPJPhYrPWjw=;
 b=Qc49cmOacLUGygwIz0z06OzkLKyVDGS6CvwehVkiiY+y7fEh70RblWiZwAkslY8m0G
 drwT4enyGFwmrbJfCSrAri48dVhfdTjFApTrmgHxr2NQfqr7xAoU3HCpp3GAmfQeIJEa
 e4NkDYEJy+f62vBVpviELdavA80+dRBVWHyHHm7nsTzttyDyLVBVINeyzBY/g+jhRuJD
 K163yBQ19VYn1msbwAEQ1TscNVDich+rZHCM8KRuMCLdzMs3dz6/fKzpua0PRZ5pXa8M
 ejDlUV2kMsqrcgclCiWKNefpRFiFzL2xf7j8JjiFUDkXjA+sOM1Ua/gpuJhkpJYGI5wD
 42yw==
X-Gm-Message-State: AOJu0YwE2PscDLnj1FUWYDM5AmkoX9lXvfCY1MDORHhf7l02kiv+qNvq
 5d70i8fz0HtNX25ng7OBvEn5pt6H6F7EB8LF2Jba9OjzLSZX+XL+GN4Jb1SZGdNbCng=
X-Gm-Gg: AY/fxX53v6kQqlyiXMYQ0UGPv2OOpMhYfUMHbLqXNRT9ZGRfy07aaJblKAniSwm6oGH
 ULDH//6co/hwBRGVi3PKz/3K0CnKbCDG3S88zzvBZHER9g3nOU+PYfki2bmcrfGjZHZsDR5OPHR
 63kuxrLjzzRd4H5mYyV3oQiLeDPZtXX+ipSaQheIIpt02HMD8qlvg9IO6KgMiUCxMI6Hureu0bg
 /tI6jXVuaa0vgLWE4Ef6VQgWsDGx0vfBF8RYT1YJAFpvCWgwwrcNUEVx0YFX3rCHx/1EG/kkkfC
 r32YhZj55qmhZw6iTlrVOq6C4m6w+cHpkkG4oxoQoT98yD18xUewy5alORaVFKIoLsL78XQ3yCp
 XrrE8rof5wV0SbMQDWGqdjmC0IDI6r7tDOLZPjh8+EpgPJUKWfQVH8DI4LYnJWq7d140XRTF5YN
 ZwuRYWhKPQ1aFcciw+EnYojw==
X-Google-Smtp-Source: AGHT+IH8epdayj+gumqDsbORe6YPW9g0b8aY7CGQSZG/pUWsyk8DyQ+Bv3AOBxBD8y9um1EG9+w8og==
X-Received: by 2002:a05:6000:18a7:b0:432:c092:ee3b with SMTP id
 ffacd0b85a97d-432c38d2696mr9095341f8f.62.1767882868178; 
 Thu, 08 Jan 2026 06:34:28 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5edd51sm16659018f8f.29.2026.01.08.06.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:34:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 90AE65F9E0;
 Thu, 08 Jan 2026 14:34:24 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 08/12] hw/mips: defer finalising gcr_base until reset time
Date: Thu,  8 Jan 2026 14:34:19 +0000
Message-ID: <20260108143423.1378674-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108143423.1378674-1-alex.bennee@linaro.org>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

  ➜  env MALLOC_PERTURB_=43 G_TEST_DBUS_DAEMON=/home/alex/lsrc/qemu.git/tests/dbus-vmstate-daemon.sh UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-mips64el SPEED=thorough MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 PYTHON=/home/alex/lsrc/qemu.git/builds/debug/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 G_TEST_SLOW=1 RUST_BACKTRACE=1 /home/alex/lsrc/qemu.git/builds/debug/tests/qtest/test-hmp --tap -p /mips64el/hmp/boston
  TAP version 14
  # random seed: R02S89554f0dc696ece515363e554b13b7f9
  # Start of mips64el tests
  # Start of hmp tests
  # starting QEMU: exec ./qemu-system-mips64el -qtest unix:/tmp/qtest-883372.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-883372.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with exit-with-parent=on -S -M boston -accel qtest
  mips_cpu_reset_hold: dbg
  mips_gcr_init: 0x5600f2160050 - 0
  main_cpu_reset: dbg
  mips_cpu_reset_hold: dbg
  mps_reset: 000000001fbf8000
  mips_cpu_reset_hold: dbg
  ok 1 /mips64el/hmp/boston
  # End of hmp tests
  # End of mips64el tests
  1..1

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/cps.c        | 22 +++++++++++++---------
 hw/misc/mips_cmgcr.c |  1 -
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 620ee972f8f..c91243599e0 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -55,6 +55,18 @@ static void main_cpu_reset(void *opaque)
     cpu_reset(cs);
 }
 
+static void mps_reset(void *opaque)
+{
+    DeviceState *dev = opaque;
+    MIPSCPSState *s = MIPS_CPS(dev);
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
@@ -65,7 +77,6 @@ static bool cpu_mips_itu_supported(CPUMIPSState *env)
 static void mips_cps_realize(DeviceState *dev, Error **errp)
 {
     MIPSCPSState *s = MIPS_CPS(dev);
-    target_ulong gcr_base;
     bool itu_present = false;
 
     if (!clock_get(s->clock)) {
@@ -144,16 +155,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
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
@@ -161,9 +167,7 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
         return;
     }
-
-    memory_region_add_subregion(&s->container, gcr_base,
-                            sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gcr), 0));
+    qemu_register_reset(mps_reset, s);
 }
 
 static const Property mips_cps_properties[] = {
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


