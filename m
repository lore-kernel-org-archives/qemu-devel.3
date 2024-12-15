Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A32E7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtw6-0001DS-Sy; Sun, 15 Dec 2024 14:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw3-0001CE-IG
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:49 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtw0-0000wU-KO
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:46 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e2a50586dso1586648fac.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289542; x=1734894342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/Ka7R5gAPMeuH9uA3sOD+FvUIpwBOAmXMLurlmzjxI=;
 b=fj4rotm59FAiR976WNNm6nq0lcDC5gOd2J/CR1oPuh5UE2CidY5K2C0YZ6+E4Stn4p
 qzSahdzD16zPWfubF0C0rs5WZ3W+cKIECXoNxcSL9vqBEm7zk8e38/9hFcgEFvp38qDI
 9flyuOYn8zFDzQauJIlXO2Um8ve8vZkrKkv8qmPTarXdKJSXBGxJyurLvMcPLGF3cOBu
 8Frwg4uz/nIWmvq8eXLzu4NftkOocLP1VqZSBcz/A2Fra62cztzGLwHpTyrnNCUsIIEu
 l/EjD8RzKQ5F8HQGxUToGHw48fvL7vLvTupTwnKcgL05N/ycmYitB3qLma+vtdCLoY6z
 83SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289542; x=1734894342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j/Ka7R5gAPMeuH9uA3sOD+FvUIpwBOAmXMLurlmzjxI=;
 b=UN+XNPB8SNW2UEWU5SmFwzZTRJLXjX4kdkYKaTWSs4NFZ+8KNQBlUrT8l2rCyvBkmn
 wKfwsiw5i89Ch+SC77tN6+WcrdsYG+w+RTQQ7RGkNBJ47Exdbju8UWTcV+uzDR2OrWuS
 M57USsCG8mRbJXMHsj2sDwogPSUcDANUiREcerlE2+8hrGfa9FZ+yDxfrqOO9RYO0ePV
 w7JrzI833c5j4tETmSlPlNDOgkd/3kWho6VC5MZVzou+2OzoiLLo97f3jXQtI3MDn1d9
 Mpo055Rzr0958/5ffmrYqftKdZtfXgIoEu9oAJ3yPdVGk1bgFR3pynMrsk16vUKFltbl
 vigQ==
X-Gm-Message-State: AOJu0YzoUR5NJmptqYIQEdX+1eZLa9249CKzGkAtNRWkT9tIxHFSTl3o
 x3pgzXAzRudnSlepMiULj8+xcuVQBQG6Ay2B9in7mTTc7L9fxTvXg8mcarzgSW/jy1rWhBqKN1K
 2TTqlxfJN
X-Gm-Gg: ASbGncvGIp8uyG+rJzpKsnSpoZWUJcgEioPUQI0MwOygLWOugQQZv+Z53VdERcJutDx
 7313EGvhL/ZhVH9ICpymDiyCEruGipY6BdGASxKwd31YPpR1rCJI8GKwocnLG1J/NWxJZrQ1PL6
 C0bbo5rwZi0Tqm3sjocvvf8SInXCCWgVHPaB3WRDLYhg0s3rFKhS4XsaqXf3s+7hdmSY0kOqrw0
 6meLHp6A9homv2xmosrjnYI8m6a5+xphYAfN4zfPJz4EV4drR1JXNsqRb4xKf2i7eZ/0B+qoezv
 2GXRN8+RWK7bMZ6+qBueMHsXWfyhCNRjynp0xaRN8tA=
X-Google-Smtp-Source: AGHT+IFeEgJmDyDAAVPAyz2jErjEh+wnDkr6KB6rViFR2BqJ8tV37IW3Ox1qq+YrjSSA0GTJc5o/8Q==
X-Received: by 2002:a05:6870:e313:b0:29e:443b:edcd with SMTP id
 586e51a60fabf-2a3ac914920mr5177591fac.37.1734289542303; 
 Sun, 15 Dec 2024 11:05:42 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/67] target/arm: Constify all Property
Date: Sun, 15 Dec 2024 13:04:27 -0600
Message-ID: <20241215190533.3222854-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c       | 26 +++++++++++++-------------
 target/arm/cpu64.c     |  6 +++---
 target/arm/tcg/cpu64.c |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0cbda76ba0..1afa07511e 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1558,39 +1558,39 @@ static void arm_cpu_initfn(Object *obj)
  * 0 means "unset, use the default value". That default might vary depending
  * on the CPU type, and is set in the realize fn.
  */
-static Property arm_cpu_gt_cntfrq_property =
+static const Property arm_cpu_gt_cntfrq_property =
             DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
-static Property arm_cpu_reset_cbar_property =
+static const Property arm_cpu_reset_cbar_property =
             DEFINE_PROP_UINT64("reset-cbar", ARMCPU, reset_cbar, 0);
 
-static Property arm_cpu_reset_hivecs_property =
+static const Property arm_cpu_reset_hivecs_property =
             DEFINE_PROP_BOOL("reset-hivecs", ARMCPU, reset_hivecs, false);
 
 #ifndef CONFIG_USER_ONLY
-static Property arm_cpu_has_el2_property =
+static const Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
-static Property arm_cpu_has_el3_property =
+static const Property arm_cpu_has_el3_property =
             DEFINE_PROP_BOOL("has_el3", ARMCPU, has_el3, true);
 #endif
 
-static Property arm_cpu_cfgend_property =
+static const Property arm_cpu_cfgend_property =
             DEFINE_PROP_BOOL("cfgend", ARMCPU, cfgend, false);
 
-static Property arm_cpu_has_vfp_property =
+static const Property arm_cpu_has_vfp_property =
             DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
 
-static Property arm_cpu_has_vfp_d32_property =
+static const Property arm_cpu_has_vfp_d32_property =
             DEFINE_PROP_BOOL("vfp-d32", ARMCPU, has_vfp_d32, true);
 
-static Property arm_cpu_has_neon_property =
+static const Property arm_cpu_has_neon_property =
             DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
 
-static Property arm_cpu_has_dsp_property =
+static const Property arm_cpu_has_dsp_property =
             DEFINE_PROP_BOOL("dsp", ARMCPU, has_dsp, true);
 
-static Property arm_cpu_has_mpu_property =
+static const Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
 /* This is like DEFINE_PROP_UINT32 but it doesn't set the default value,
@@ -1598,7 +1598,7 @@ static Property arm_cpu_has_mpu_property =
  * the right value for that particular CPU type, and we don't want
  * to override that with an incorrect constant value.
  */
-static Property arm_cpu_pmsav7_dregion_property =
+static const Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
@@ -2644,7 +2644,7 @@ static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
     return oc;
 }
 
-static Property arm_cpu_properties[] = {
+static const Property arm_cpu_properties[] = {
     DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c1cac912a0..ec77c5b34a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -547,11 +547,11 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     cpu->isar.id_aa64isar2 = isar2;
 }
 
-static Property arm_cpu_pauth_property =
+static const Property arm_cpu_pauth_property =
     DEFINE_PROP_BOOL("pauth", ARMCPU, prop_pauth, true);
-static Property arm_cpu_pauth_impdef_property =
+static const Property arm_cpu_pauth_impdef_property =
     DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
-static Property arm_cpu_pauth_qarma3_property =
+static const Property arm_cpu_pauth_qarma3_property =
     DEFINE_PROP_BOOL("pauth-qarma3", ARMCPU, prop_pauth_qarma3, false);
 
 void aarch64_add_pauth_properties(Object *obj)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 2963d7510f..67c110f021 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -198,7 +198,7 @@ static void cpu_max_get_l0gptsz(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &value, errp);
 }
 
-static Property arm_cpu_lpa2_property =
+static const Property arm_cpu_lpa2_property =
     DEFINE_PROP_BOOL("lpa2", ARMCPU, prop_lpa2, true);
 
 static void aarch64_a55_initfn(Object *obj)
-- 
2.43.0


