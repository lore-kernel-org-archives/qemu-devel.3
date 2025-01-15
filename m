Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D24C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjR-0000Wg-MS; Wed, 15 Jan 2025 18:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjP-0000QS-Kv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:28 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjN-0003qk-SN
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:27 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso317347f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983403; x=1737588203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUxPrJq33zbqetS3KdsFfaEYg8U4Um6tBpvIBoEhOmo=;
 b=Urj+UI/cC7YzUcZ+zR42IsDEC9hphQP2YH++S6N6XS7N2q58MaHU08mIwUa53pTx9J
 0g6bK4E1zjCL24bt1z6ao6urue9qZcqOP9087/BO/I/Amnh/rxfmPNL8SrkQoqXlg7AL
 iJRMD9YyONn1NDXV+NXTox4HSAS8foUSvfUj6oROnHxGnVLOrbvEyCODTBxkZszPaKVw
 N0WIzP8OtPKIyd/3cGilWe6YceSZnYyO5TEGeTWHbFCTERsxUoLZ8TG+Iblo5rGzbwHx
 2B58ZBrfKrjLLkaR+qtQrwabvnKH72bzBBQ9T3f9nqIx78v6tvnsKUXsTmWsrLGMnwEX
 coiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983403; x=1737588203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUxPrJq33zbqetS3KdsFfaEYg8U4Um6tBpvIBoEhOmo=;
 b=ah6K8A2/Fohi4GCeTrIjCvdxpd6HGmyrPhrf+feqgzxJu0r1jEs6HvZVF5rcHgZMD1
 XzXfMfcFQBcZU6BQ15Y+tGDOdc6UArcm1Jf8iwubyyvkxXWsfwYyr+tkx6yHhKuq4slp
 9Xkp+LmFXZ6IqPNTyynWgZz9PfCJb7NiC9Br2AxPLYr5L9QO58/WxrgVMHndTlEmlzJ+
 MnshXzLLluxcoD5p0bCZtrmXKfXuYb6zCvrgr3vjtZ2vVd4Q320Wpt0j9BHLU2oUnch7
 SP4t6OA2M0RjTDCHbSNxhChwLhA2W0rkss+yBcEoB4H3uwGmLEiQrMaA9OK3b/oKK62O
 y/Fg==
X-Gm-Message-State: AOJu0YzGS7cBQh5mgSDNiywIC/dOUb9UPFjFPC7/mRKDpRRa89LTCYzi
 7psFoXEpbM/jjDaasuXStvRi5jnAUTdDKZTDJra6pCnX0tmINl3l8fwm6/BHfOuReEpb0Fh76vs
 VDVA=
X-Gm-Gg: ASbGncsoonEt6CiK0a//CgYqqybaegiI4saOA/OCvQkGxBMhREeAbM5k2Mv8bV9i4Jj
 CKkodlhWrAI0lnUF4zAoHgT3VSVuMv/cWk88F0hNTElBTjd8dbvRLmpE27/eNJgv0pkkS1CELdj
 PGzt6s4iMOwwdWlGfLEul9BiNN7ZcJLC9o8wke+ZrgGEC+gIlE/muN4Q8KT2o0w4jRdHDJltnG4
 Z6e2WHryjWhbu93a6uKdM1keQtSud0OutJcxk+pp57v9BSYa7P6g64TuwEguHHilxW5RlEAGLFp
 m7aoX+6Lvor5dlVUpQr+cbA8/lguZTw=
X-Google-Smtp-Source: AGHT+IEAOL0BiVVPNhg3ZJxG+vdyKt8Dc59/uzDX0sZYzNdKS/ldU5vA9XjjgjfFWFSVTrqEOjY0mw==
X-Received: by 2002:a05:6000:4618:b0:385:f560:7916 with SMTP id
 ffacd0b85a97d-38a8732aeefmr32429907f8f.35.1736983402754; 
 Wed, 15 Jan 2025 15:23:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3853b6sm18634302f8f.44.2025.01.15.15.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 06/21] target/i386/cpu: Pass Error** to
 x86_cpu_filter_features()
Date: Thu, 16 Jan 2025 00:22:32 +0100
Message-ID: <20250115232247.30364-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Simplify x86_cpu_realizefn() by passing an Error**
argument to x86_cpu_filter_features().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 42227643126..c48241fb902 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5896,7 +5896,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
     }
 }
 
-static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose);
+static bool x86_cpu_filter_features(X86CPU *cpu, Error **errp);
 
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
@@ -6084,7 +6084,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         error_free(err);
     }
 
-    x86_cpu_filter_features(xc, false);
+    x86_cpu_filter_features(xc, NULL);
 
     x86_cpu_list_feature_names(xc->filtered_features, tail);
 
@@ -7650,7 +7650,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
  *
  * Returns: true if any flag is not supported by the host, false otherwise.
  */
-static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
+static bool x86_cpu_filter_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
@@ -7660,7 +7660,7 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
     uint32_t eax_0, ebx_0, ecx_0, edx_0;
     uint32_t eax_1, ebx_1, ecx_1, edx_1;
 
-    if (verbose) {
+    if (errp) {
         prefix = accel_uses_host_cpuid()
                  ? "host doesn't support requested feature"
                  : "TCG doesn't support requested feature";
@@ -7712,15 +7712,13 @@ static bool x86_cpu_filter_features(X86CPU *cpu, bool verbose)
         uint8_t version = ebx_0 & 0xff;
 
         if (version < env->avx10_version) {
-            if (prefix) {
-                warn_report("%s: avx10.%d. Adjust to avx10.%d",
-                            prefix, env->avx10_version, version);
-            }
+            error_setg(errp, "%s: avx10.%d. Adjust to avx10.%d",
+                       prefix, env->avx10_version, version);
             env->avx10_version = version;
             have_filtered_features = true;
         }
     } else if (env->avx10_version && prefix) {
-        warn_report("%s: avx10.%d.", prefix, env->avx10_version);
+        error_setg(errp, "%s: avx10.%d.", prefix, env->avx10_version);
         have_filtered_features = true;
     }
 
@@ -7822,14 +7820,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid)) {
-        if (cpu->enforce_cpuid) {
-            error_setg(&local_err,
-                       accel_uses_host_cpuid() ?
-                       "Host doesn't support requested features" :
-                       "TCG doesn't support requested features");
-            goto out;
-        }
+    if (x86_cpu_filter_features(cpu, cpu->enforce_cpuid ? &local_err : NULL)) {
+        goto out;
     }
 
     /* On AMD CPUs, some CPUID[8000_0001].EDX bits must match the bits on
-- 
2.47.1


