Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3762BE63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 03:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrpXZ-0002XM-A7; Sun, 15 Feb 2026 22:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXX-0002Wr-Q0
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:51 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vrpXW-0002QU-Ac
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 22:44:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a9296b3926so17971075ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 19:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771213489; x=1771818289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PxqU8tvo+gNnuGxhj0o+hsuYHhhpNyvRSdlXMU1ShJM=;
 b=a5BATFP0fwjnKUHC0eKeI2e0HTvBU+It6bY+SA9txy32AR9Zla7jw80G88sXUaiZtM
 tlr1M476QTRyWA3j9HwSq2kT5zFj4DVPqYFHPUAGcG3jVtcsfQXsd8V8rr/7QeaOSPI8
 P8rPNR4mRNjS9fDUdLZbTT1ues80AnQBScuQEW/2/e+w5e5sPAW5HI9RJ3AAWRaC+Zn0
 KIctjpek0XfFcyLF+yHKnNCcI8HYcA4qw4OTRt1GVZmgS6rmasfu1gSVHcMJ3S1x4Xqz
 P4KS/79F2TaFKjPEgqG5OQPuLv9F/GLbE8c7v0M7xgdyNVx9vSDuqdN+GcfcGJHaqe1u
 UrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771213489; x=1771818289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PxqU8tvo+gNnuGxhj0o+hsuYHhhpNyvRSdlXMU1ShJM=;
 b=js+5elRdmx72snsKJ3Hql3rlEQUxckK+M6zcq4TM3Z0cjUmciyuyiG92UiHAXun+BF
 wbvOwcOSWv5F1X9DnkuvX5scELXeoBKzQNfmrfjSNyotAWhKtsPNxU57NEcyTIp2PiZy
 UcZL8Q+EFDdHQLmglXEbdILhIgvo+2rFVNhB8IxtlIkBgThD5Y6jNQVBwCgUl2ZaVIl4
 1tHvj4yoko7fdea00ba3K3hW9ldRF3y0TYO6TwjMZWgQBgaARkj6kNoWUQf+JhPv5tnB
 I0f7rKA+dbbEpPBlDAmCeEH1FV1x5sI/K8+klzNqcYt1tJVbm8DB3U7xos1lISPmeumZ
 Rs+Q==
X-Gm-Message-State: AOJu0YzEesZiFQ6xMVouQPgF4Rw03VHhQUSqwemARwhxn8Qc0C4Fbi6E
 CWl+QP6Cg0vhjYOfEj3KN6SskYhjSpsO37inxarktqIa1hOBBFNHv/Pv0Oh3vEfCaFwStig8i46
 pet7tZoo=
X-Gm-Gg: AZuq6aL+s66iBLQpWYQQomjSySlTWvXBFMMkUgDmPB4SUhi9e2emOSdOfpqT2TA3D0O
 NwRmjtFgtkHP1CH7MQQYFC6Hki7outrz+YUW/HM2NmODQuurI26u6jOsQNIz3YgnIuVg9rIYgVd
 q+PIEIVhPP4FGpEga8qxz6C03qZZDkFaRI/Wwr0bKqbrDmE4Mhv492IQ0NAJrXvNzv0AvGMkilc
 9WMEIZut+EXtpuYYtTAB1SXwWvgTrx1VQHAcwoCT7Z1U4HoZo5HFqROKeKF1I96wsYv7XgmvRNv
 Bzg4KM0o069pFFeihZPRwuCY6eeFRgUg1UAG3mI19ldtBANMrBO/SVTFUL4KYk6TGjoxKLQQq2Z
 d+AxjCAuWAVv6Xk/aEgHGO7o03F0nuYVBPHGcDWNGeX/cbkSYeH14ICpu6SyhW6Igof+d/pckJ7
 QV4zISFPquhcK4hMbsrnD2Xa8WGj14ITZR
X-Received: by 2002:a17:902:ecc6:b0:2aa:e817:1bd3 with SMTP id
 d9443c01a7336-2ab505bb034mr94688145ad.29.1771213488652; 
 Sun, 15 Feb 2026 19:44:48 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:4a1:428a:70f2:5844])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1aadca84sm53294155ad.70.2026.02.15.19.44.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 19:44:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 05/13] target/arm: Move kvm test out of cpu_arm_set_sve
Date: Mon, 16 Feb 2026 13:44:24 +1000
Message-ID: <20260216034432.23912-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216034432.23912-1-richard.henderson@linaro.org>
References: <20260216034432.23912-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Introduce a set of stub property callbacks for when we really
don't want to be able to enable SVE.  Register the real or stub
funtions in aarch64_add_sve_properties depending on whether or
not SVE is available.

Adjust aarch64_a64fx_initfn to initialize the set of supported
vector sizes before calling aarch64_add_sve_properties.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c     | 48 ++++++++++++++++++++++++++++++++++++------
 target/arm/tcg/cpu64.c |  2 +-
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 0116b6cc88..38d06af49f 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -292,6 +292,30 @@ static void cpu_arm_set_vq(Object *obj, Visitor *v, const char *name,
     vq_map->init |= 1 << (vq - 1);
 }
 
+static void prop_bool_get_false(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool value = false;
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void prop_bool_set_false(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool value;
+
+    if (visit_type_bool(v, name, &value, errp) && value) {
+        error_setg(errp, "'%s' feature not supported by %s on this host",
+                   name, current_accel_name());
+    }
+}
+
+static void prop_add_stub_bool(Object *obj, const char *name)
+{
+    object_property_add(obj, name, "bool", prop_bool_get_false,
+                        prop_bool_set_false, NULL, NULL);
+}
+
 static bool cpu_arm_get_sve(Object *obj, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -301,12 +325,6 @@ static bool cpu_arm_get_sve(Object *obj, Error **errp)
 static void cpu_arm_set_sve(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-
-    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
-        error_setg(errp, "'sve' feature not supported by KVM on this host");
-        return;
-    }
-
     FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
 }
 
@@ -439,7 +457,23 @@ void aarch64_add_sve_properties(Object *obj)
     ARMCPU *cpu = ARM_CPU(obj);
     uint32_t vq;
 
-    object_property_add_bool(obj, "sve", cpu_arm_get_sve, cpu_arm_set_sve);
+    /*
+     * For hw virtualization, we have already probed the set of vector
+     * lengths supported.  If there are none, the host doesn't support
+     * SVE at all.  In which case we register a stub property, to allow
+     *   -cpu max,sve=off
+     * to always be valid.
+     *
+     * For TCG, this function is only called for cpu models which
+     * support SVE.  The error message in the stub is written
+     * assuming host virtualiation is being used.
+     */
+    if (cpu->sve_vq.supported) {
+        object_property_add_bool(obj, "sve", cpu_arm_get_sve, cpu_arm_set_sve);
+    } else {
+        assert(!tcg_enabled());
+        prop_add_stub_bool(obj, "sve");
+    }
 
     for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
         char name[8];
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index fa80e48d2b..84857fb706 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -524,10 +524,10 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->gic_pribits = 5;
 
     /* The A64FX supports only 128, 256 and 512 bit vector lengths */
-    aarch64_add_sve_properties(obj);
     cpu->sve_vq.supported = (1 << 0)  /* 128bit */
                           | (1 << 1)  /* 256bit */
                           | (1 << 3); /* 512bit */
+    aarch64_add_sve_properties(obj);
 
     cpu->isar.reset_pmcr_el0 = 0x46014040;
 
-- 
2.43.0


