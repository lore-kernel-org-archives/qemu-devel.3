Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCDBFD8FCE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 15:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdid-0005Qi-1G; Thu, 26 Feb 2026 10:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiV-0005Ol-74
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvdiS-0003mE-AD
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 10:55:54 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4398913af88so940998f8f.2
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 07:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772121351; x=1772726151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZfBUJaYraA8yxuxaiXVVUn603JpjW9lcSMUyJUScvg0=;
 b=H+zAsPKnzipjVL8CmSxqh3n34WT8ctXV0UoyzUyzt9vKsbxUefrP4Drt8PJydxX9MH
 9DntlvTK1IJDsgklsxPUKZeGdIf4x0ErSMy8F9cdr4LEEw1ec9MKoq47GKpcM7cOIXja
 Yh7LjfRpPVpQT1XBtFNBDI7IJYuhPRPjyNjYOTftBKFULOXnh/jqtwbQZB+yDu2mSqMD
 fCAuBOhqy53gQtWSrW2UOHUiDww/aH/THL0hddaJdtN7c8RIWcMpaeojPo2rt9dAdE8G
 Mp6UJtDiYlJxZYSdSeLR1DGvhPnsWNDw6BptxjfAUymvt6YPNMEI9+9+L2RGTp3rgkvR
 0tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772121351; x=1772726151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZfBUJaYraA8yxuxaiXVVUn603JpjW9lcSMUyJUScvg0=;
 b=QeSXUmp4O87sTb9JPmsF954+5JTCgPL89EJNjIzD2sHOXRi3qUpW3jF0bMNeDypfwz
 Db9twb42zap1qwHu8dn6aoko9Hw0aLUhBBqSaapjEcjPdFf4huKtOAg9M0yxjca2uUhx
 wygK4dKwDLFeX6oGm74ZHRXUO8OE7j1PlS3viRKu/vdd664JQaOB1UHUnnsYkR/xfczA
 zkj4HMZ+01p8ssYIZNSVKARDjLGNTdKSYBL7R7n+Prm6sDYrovjhUDuZhMx4F6dS4oyY
 gRN5fRpaGw5CvxOnwTC9ZtywvqoJBW+Xllcp0hZ7sbmY/+qyqUQECKTq2srsuLZ6xbBK
 pGtw==
X-Gm-Message-State: AOJu0YxFl9BoAG49kSHarfI5TuhGlljrRLJ1RFA+tjh78O4TvAzZ65sY
 HFWxgVp2vtNmMjCS1beQpyMhxd8poQuGT6Ji8+STqgOdLgiz1F6U7y2hc+RyzVBHVXLRPV8bzi9
 kVwwC
X-Gm-Gg: ATEYQzz0I2Daj105BycRpPGHQLWYdB191Qi69XFwzd9YiaFD9RnqYEyG6ku4IOvP3+v
 TChJHw4VzDt2XGiCULbNEi8jvegLJpR9ZJvoY0wHo4JoDi5dkhoiUg379fVRh+aeqAZKBBlwcPp
 89KjmcV3zP8ugoTb4swDTeDfKdE9glvj+sujdhQdNnhoNorjl5y0nRN/oKXCNeMtKdHGWxP8gLs
 id+RGTWrXFUe/VKgDKyqqC2hxK3YTMVVkmj0gb54lIHw+mBPMdKR6zpse92R4Wczz8PNwxqY/zK
 l4wtfIBozt2G5UFRw3lSkDkut0SVeMgeZQX+KDaFg9YREhtEMFAE8xRPXZTWqj/jeDlO1kcZHqk
 YPtc3heeDq5owu9eNWLwTrroap4wJtUJ4OBqSSX/l3U0c3Dur45CYvQkZm4t4O5QspvUxWSpipt
 AdzmTybh4AVUDZJE3gr0ohuB7CcVV5X8FRRsdn4h9/GzRNBwjPgBv++QUdYQjc/FKwg9X/OZaJV
 cDM4ztCag5Vj7wvM7QHimAhzr2gBrQ=
X-Received: by 2002:a05:6000:290b:b0:439:8d77:4dad with SMTP id
 ffacd0b85a97d-43994305b07mr8859477f8f.55.1772121350521; 
 Thu, 26 Feb 2026 07:55:50 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b8afsm407235f8f.23.2026.02.26.07.55.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:55:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/20] target/arm: Move kvm test out of cpu_arm_set_sve
Date: Thu, 26 Feb 2026 15:55:28 +0000
Message-ID: <20260226155535.1171290-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226155535.1171290-1-peter.maydell@linaro.org>
References: <20260226155535.1171290-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Introduce a set of stub property callbacks for when we really
don't want to be able to enable SVE.  Register the real or stub
funtions in aarch64_add_sve_properties depending on whether or
not SVE is available.

Adjust aarch64_a64fx_initfn to initialize the set of supported
vector sizes before calling aarch64_add_sve_properties.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260216034432.23912-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c     | 48 ++++++++++++++++++++++++++++++++++++------
 target/arm/tcg/cpu64.c |  2 +-
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 209ab5c344..58215216c5 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -300,6 +300,30 @@ static void cpu_arm_set_vq(Object *obj, Visitor *v, const char *name,
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
@@ -309,12 +333,6 @@ static bool cpu_arm_get_sve(Object *obj, Error **errp)
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
 
@@ -471,7 +489,23 @@ void aarch64_add_sve_properties(Object *obj)
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


