Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB550E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOLJy-0002yt-G6; Thu, 19 Dec 2024 13:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJt-0002wj-DT
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:21 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOLJo-0002aI-HG
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:32:19 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-728f337a921so1230871b3a.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 10:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734633135; x=1735237935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgg3DZOeSktQgwpMFQWYfQpPjrdNqQXpM4wVQei4S9U=;
 b=EHb7JArwr4gT8ZL/1ZtLzvZHiRm11C2rh3qflZ7KufVmLF/11BIJK5rTZs7DTdZqN6
 DwDCMj34yJhuEpAGho3D4I6HDhZOdpV7KlQTd58h+jabqtIXTqXASkhnQKxqWNmH8Mx8
 2cWiy1PNkK1UWQo88TlQzADQSQLd6PnSH1HIBtOdYrQU2Hebo5k/4WQE7msgd91rUS9N
 Sw6od+sDTK+EXeAZhVThtQLVuUwC89Rw+nSHDRAwD6NI3lfOcbTflyRhPWZz+5fwIi1w
 pICx8Rt6OYYuFGlghUCOHMbECMXzjGiRy4DUeNUPZayGBbKTBdFyXB/d/Om8C2rr9A5y
 Bxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734633135; x=1735237935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgg3DZOeSktQgwpMFQWYfQpPjrdNqQXpM4wVQei4S9U=;
 b=huZCKzlL5xb3mHWMUQCfSh/KwIj34+U8+2g9LL/X5bC3D4gs2Cmo8Z1jdYQZwIYVR+
 gxXHsw66oW3ZrU/4d/2oPUHqIb9raaERuB/Q/19ydzMXen7otHvOOUPKP/0GPg76IiTP
 1ooqXRfW3JNfYG0/qzzdYM8xyq6ZQWDrDwdmT1nabEKPXCF2dThAVdZNp0kXNA1EMRdw
 ek4/AaEh+ajbEGL9DeUKpaZ0E9cnAh9FYYu9oamAodJT8PU3dP3YNaZSgvFPFZCs2Ilu
 UrmFTUA9vg4Wlwjgmko9xhL3mI8oSuyuQ5ivCKNeVQJ081sgM/P5ILPpuke69KcqZhNZ
 alxw==
X-Gm-Message-State: AOJu0YxK/abRbx/7F1DQ6HRego9UUq9J2VI7Zxdoy1h10p3+55RsS+IK
 s7MRdVZEL149DvHFHRmjkqwTicMhUpNloKaTD48bo2LHFLOXY5CcRTcNBzBULbte/W570TNPwLU
 TenA=
X-Gm-Gg: ASbGnctCwe6lu/ALhTZqrqBMh/vCd2RUMJ1lFKqH+Kb2QVZPF0QcSLA4MfcMSVNq0wm
 GoXQ7kvX5VYEKkDyqbhDcQxZX50JvM45+E2hNrlNu4GmbjSxaTr1xSgHm5tLVtjR5F8KYR/KArq
 P3HvhNC7qUr3XqmjDmVB1Zh98yzNMb3gm7tPPK9tyE/L+b2hmr+chOhO0tLX17YVU3HRZF3kNNc
 UhleTgV3z7ECNCaFH8E3IB2Ztm/1GEuaFYf1x0XbE327IrwsFTyqwEl
X-Google-Smtp-Source: AGHT+IGF+rRqeIO/bCUN5wAwJFBz7SmxzQKFiaqqz696UQGWaKpxx8rf70FBqiqEPKLWfIIKZTyu+Q==
X-Received: by 2002:a05:6a00:1909:b0:71e:6b8:2f4a with SMTP id
 d2e1a72fcca58-72aa8d3a152mr6906058b3a.12.1734633135047; 
 Thu, 19 Dec 2024 10:32:15 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b302sm1624733b3a.175.2024.12.19.10.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:32:14 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 1/3] target/arm: add new property to select pauth-qarma5
Date: Thu, 19 Dec 2024 10:32:09 -0800
Message-Id: <20241219183211.3493974-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Before changing default pauth algorithm, we need to make sure current
default one (QARMA5) can still be selected.

$ qemu-system-aarch64 -cpu max,pauth-qarma5=on ...

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/cpu-features.rst |  5 ++++-
 target/arm/cpu.h                 |  1 +
 target/arm/arm-qmp-cmds.c        |  2 +-
 target/arm/cpu64.c               | 20 ++++++++++++++------
 tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index a5fb929243c..d69ebc2b852 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -219,7 +219,10 @@ Below is the list of TCG VCPU features and their descriptions.
 ``pauth-qarma3``
   When ``pauth`` is enabled, select the architected QARMA3 algorithm.
 
-Without either ``pauth-impdef`` or ``pauth-qarma3`` enabled,
+``pauth-qarma5``
+  When ``pauth`` is enabled, select the architected QARMA5 algorithm.
+
+Without ``pauth-impdef``, ``pauth-qarma3`` or ``pauth-qarma5`` enabled,
 the architected QARMA5 algorithm is used.  The architected QARMA5
 and QARMA3 algorithms have good cryptographic properties, but can
 be quite slow to emulate.  The impdef algorithm used by QEMU is
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280d..b7500bebd7f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1062,6 +1062,7 @@ struct ArchCPU {
     bool prop_pauth;
     bool prop_pauth_impdef;
     bool prop_pauth_qarma3;
+    bool prop_pauth_qarma5;
     bool prop_lpa2;
 
     /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738bb..33cea080d11 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -94,7 +94,7 @@ static const char *cpu_model_advertised_features[] = {
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
     "kvm-no-adjvtime", "kvm-steal-time",
-    "pauth", "pauth-impdef", "pauth-qarma3",
+    "pauth", "pauth-impdef", "pauth-qarma3", "pauth-qarma5",
     NULL
 };
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ec77c5b34ad..9a193d2b489 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -520,9 +520,12 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
         }
 
         if (cpu->prop_pauth) {
-            if (cpu->prop_pauth_impdef && cpu->prop_pauth_qarma3) {
+            if ((cpu->prop_pauth_impdef && cpu->prop_pauth_qarma3) ||
+                (cpu->prop_pauth_impdef && cpu->prop_pauth_qarma5) ||
+                (cpu->prop_pauth_qarma3 && cpu->prop_pauth_qarma5)) {
                 error_setg(errp,
-                           "cannot enable both pauth-impdef and pauth-qarma3");
+                           "cannot enable pauth-impdef, pauth-qarma3 and "
+                           "pauth-qarma5 at the same time");
                 return;
             }
 
@@ -532,13 +535,15 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
             } else if (cpu->prop_pauth_qarma3) {
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, features);
                 isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 1);
-            } else {
+            } else { /* default is pauth-qarma5 */
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, features);
                 isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 1);
             }
-        } else if (cpu->prop_pauth_impdef || cpu->prop_pauth_qarma3) {
-            error_setg(errp, "cannot enable pauth-impdef or "
-                       "pauth-qarma3 without pauth");
+        } else if (cpu->prop_pauth_impdef ||
+                   cpu->prop_pauth_qarma3 ||
+                   cpu->prop_pauth_qarma5) {
+            error_setg(errp, "cannot enable pauth-impdef, pauth-qarma3 or "
+                       "pauth-qarma5 without pauth");
             error_append_hint(errp, "Add pauth=on to the CPU property list.\n");
         }
     }
@@ -553,6 +558,8 @@ static const Property arm_cpu_pauth_impdef_property =
     DEFINE_PROP_BOOL("pauth-impdef", ARMCPU, prop_pauth_impdef, false);
 static const Property arm_cpu_pauth_qarma3_property =
     DEFINE_PROP_BOOL("pauth-qarma3", ARMCPU, prop_pauth_qarma3, false);
+static Property arm_cpu_pauth_qarma5_property =
+    DEFINE_PROP_BOOL("pauth-qarma5", ARMCPU, prop_pauth_qarma5, false);
 
 void aarch64_add_pauth_properties(Object *obj)
 {
@@ -573,6 +580,7 @@ void aarch64_add_pauth_properties(Object *obj)
     } else {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_impdef_property);
         qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma3_property);
+        qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_qarma5_property);
     }
 }
 
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index cfd6f773535..98d6c970ea5 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -419,21 +419,28 @@ static void pauth_tests_default(QTestState *qts, const char *cpu_type)
     assert_has_feature_enabled(qts, cpu_type, "pauth");
     assert_has_feature_disabled(qts, cpu_type, "pauth-impdef");
     assert_has_feature_disabled(qts, cpu_type, "pauth-qarma3");
+    assert_has_feature_disabled(qts, cpu_type, "pauth-qarma5");
     assert_set_feature(qts, cpu_type, "pauth", false);
     assert_set_feature(qts, cpu_type, "pauth", true);
     assert_set_feature(qts, cpu_type, "pauth-impdef", true);
     assert_set_feature(qts, cpu_type, "pauth-impdef", false);
     assert_set_feature(qts, cpu_type, "pauth-qarma3", true);
     assert_set_feature(qts, cpu_type, "pauth-qarma3", false);
+    assert_set_feature(qts, cpu_type, "pauth-qarma5", true);
+    assert_set_feature(qts, cpu_type, "pauth-qarma5", false);
     assert_error(qts, cpu_type,
-                 "cannot enable pauth-impdef or pauth-qarma3 without pauth",
+                 "cannot enable pauth-impdef, pauth-qarma3 or pauth-qarma5 without pauth",
                  "{ 'pauth': false, 'pauth-impdef': true }");
     assert_error(qts, cpu_type,
-                 "cannot enable pauth-impdef or pauth-qarma3 without pauth",
+                 "cannot enable pauth-impdef, pauth-qarma3 or pauth-qarma5 without pauth",
                  "{ 'pauth': false, 'pauth-qarma3': true }");
     assert_error(qts, cpu_type,
-                 "cannot enable both pauth-impdef and pauth-qarma3",
-                 "{ 'pauth': true, 'pauth-impdef': true, 'pauth-qarma3': true }");
+                 "cannot enable pauth-impdef, pauth-qarma3 or pauth-qarma5 without pauth",
+                 "{ 'pauth': false, 'pauth-qarma5': true }");
+    assert_error(qts, cpu_type,
+                 "cannot enable pauth-impdef, pauth-qarma3 and pauth-qarma5 at the same time",
+                 "{ 'pauth': true, 'pauth-impdef': true, 'pauth-qarma3': true,"
+                 "  'pauth-qarma5': true }");
 }
 
 static void test_query_cpu_model_expansion(const void *data)
-- 
2.39.5


