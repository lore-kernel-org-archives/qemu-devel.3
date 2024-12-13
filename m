Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BE8E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB9Q-0002PL-7a; Fri, 13 Dec 2024 14:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7X-0007iC-T1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:40 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB7T-0007dh-K8
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:14:38 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d88d3d1eb6so20252836d6.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117274; x=1734722074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJW4ejE0j+klMS0haexDL6scIL3gCGlkNOuL2SbrH8M=;
 b=ktQzd/6zgZekOWeRE0MQe8IZ7HUTyMPKFtg7QCansZQ9hbTeKduFW4vcPEHv089TFZ
 isH4mqjAsRNpy7nlC/5GAnj7YCT950/w+a2YYG/B+m0HlNRTsSLnuWvavt3F0QkFMWIm
 icG1uvhMoeFsnugpNcjKmN6wxE3sc4TnhLyv0qxiVmUWs2L7tkrHmo6u6T2Foq6Xpx+H
 2jO9Y2TzqLhd1ZIwkrcL3jk9b4Flr2cQdiAWZ2qf0BC1L9onPrQjLdZg0HbnOehOEz0V
 DblP8W9g5eak8hx/vKZ6zzdrmmiepwakVXHO+uP26BRmhKN13DptSFOyQkwkNgDS5Ngf
 69dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117274; x=1734722074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJW4ejE0j+klMS0haexDL6scIL3gCGlkNOuL2SbrH8M=;
 b=dPrRE4RFyz3tsNkKC5/eDzbXjbHGjip0HQ6uQGQJM66gNGtG82aPYUv4343vpqUqIe
 Y8fzSVn2pGlvhxEQiOJ+ZbyMA7u/T2XzYzLPiNi7JImE2Z2uoTQ0ndpF0Nlyi0N4AnrY
 U4ZWSKPwcxIjQIW34hApSiUrx0K52wtekejazn+mp5cbmMbYyxz4JZanbnKLzng93PS9
 8bxIJQZcQRYFZ4qfNaL65ib31gIsVdr+OoMrndgYI/gf6fzUr3BCbHYEf8pPr8+89y/8
 +Xl+KSnSn4dCT6LmGrDdLWZUINGnWNDGG9EpIo0k1nd7BIHuAoYNVfTwnUxnRbMdW3X7
 ycYA==
X-Gm-Message-State: AOJu0Yy76FH9CXJ4bgeBxrs1CF0KUVKUAepPVkiXMnG6dHpaCOi1acJ0
 cP1MBEloIO2KfVwhgFldMzCKpm0xImQYz0oqaDJYeiVGzz7sfOx5Dtq2mKBve4zN2zSCHcTQkCi
 WjIf/z/cj
X-Gm-Gg: ASbGncvtdgB5RxssXl28TYikq3lcKjl3jLvj5y9SGUOQtHVUV7f49ikwgqGRoNngOVI
 8ZHHmPwlsDsuu4y4lom2zDM/+8r4SkH6aDVeXucHNwbkHsynJGZrsBDQCngiKzpS++ZNfA7i/w3
 sZPcoBmLLXpWgJsZdWSFU/M3hXUau0gkGTid7ay7/HGhvgVZFWndM+WTbIYqh7xGLhDSfG8Q+Nf
 CMI6yaUmSVw2f/PIXj155fnxkczxS8pQB1Wzv6EyPVOGeSqoCXEHUCRjZLqxlFw
X-Google-Smtp-Source: AGHT+IGoX7DkCsi0LrOQqCE3SlKBl45deIuoNHmEoV6qx8FOSJad6TOlAxtUPcVjd1xxAohMPn7HyA==
X-Received: by 2002:a05:6870:9128:b0:29e:2a06:8405 with SMTP id
 586e51a60fabf-2a3855b72b8mr4546276fac.19.1734116875763; 
 Fri, 13 Dec 2024 11:07:55 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:07:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH 01/71] target/arm: Constify all Property
Date: Fri, 13 Dec 2024 13:06:31 -0600
Message-ID: <20241213190750.2513964-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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


