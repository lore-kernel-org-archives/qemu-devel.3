Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB8DCA0EDA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 17:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVyt-0004pF-Sq; Mon, 11 Aug 2025 13:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVyr-0004oJ-Gs
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulVye-0001lD-KC
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 13:06:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459ddf9019cso15114945e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754931985; x=1755536785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTgiDxRSLxB+/Dn7RyfAMOT6DRpkQW6SJaCX0ndx+MI=;
 b=IsG+H3GntxmqMDHatqDlOp4fADROO4cmTatuD85H1Ia5zoobIbN2UcqFuMP9/hQz2d
 1I1tKglOMF7CQ/VA0pbmUPNZEtw9AhFmi1GszImwP0rCTIiwZ95GUdsY3SXg4IkAq5TE
 fPJcBhC5fDtvEdllGMdSeRgyfa6wb8ZhnzBRHBT9TouLnqGPvXeIafuQX5VjHGS5WF3l
 1W3nbmtuSUjXoCjRhUekdH5OHmB2QL91b/c2RPBrLly3MYTU/4iQsbKEp5aRkbEIk+Yy
 ipuThvPF7TVLfgsaLMnbdfZYlHIJiBadZQ7Izk4fhm/hxZyYtkUSH5F61fuDnKo4wSzM
 zuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754931985; x=1755536785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTgiDxRSLxB+/Dn7RyfAMOT6DRpkQW6SJaCX0ndx+MI=;
 b=srTDxfIMuqAk1z9q2lp2TOim6e83p6pevr8m8xTd8TE5ceo1+KPO4ILrC1ku7cXy7/
 HyIA3OpU7fmXHseAv3ICrr68WRtArIHRFrS4i1N/zpJeuhA8c2jMB+0tldAUDONT3MfL
 q6Fso/93UrP+T+zF0IN9UxsPiJA5Bz7VTWRKbIfVLDZE9shujqvWUi7UMcLcHgSK/qMT
 INKeVxNuLMg3HdRkjC/JACMKuIemOm5XK+m1IQVMS5+YlTzIHdqUBmo19ULfIkWLRYa0
 /7gjMtwPme30shNtHKPLzeXt6/v92ant7jfmxjD0oUxYcNizLKKFRRMUXVUq9Xztt2zi
 pI5w==
X-Gm-Message-State: AOJu0Yw/enqSFfrHgvRDPKKVGTyfphlOuoUSvf2U332AhRsw7h73Yx6F
 jciLB9jVsnvul3FcjxBjAGiaENLW1OL7g+ehMCIgmncM8nJIXucLQaKQRm4Ap0VG+CuVO6FLwe8
 fNpYf
X-Gm-Gg: ASbGncvSuoBIfmDrFaVhSoAab8/Z7W9du9Kg0RjUkYJRaewQBIbkoDjUPUOiRxlyg5o
 bURrS4N8gXaQ+vIXmBDKNvF7R8VDTb6HS+ZwmGznkEspbqgy1//W6TEaJuQBun5hDBjSLgpt2nW
 6+QLDN+K5ehreuraKYb6BYs7rh0+q/G/WnVqBF2U6TlFssbR8HzQY+HuXjisvzdkxa2GAMDPic+
 U5dP24aN3fI+FPWAvchX2LRMewsZ3xNhH9sBtUuMnbto6cHrByHg3lhMaHsR8xrovhw9dfKJQuu
 AgLU7n07+c0+QI7y7Slqe+Ennwz94Gt7MwqcGTfQetQbB06FkDA6BA5iIn4+9bX3Kkuo53p+0sF
 +jwA7qxmFwhy4Y64/2shB0DL0nhTWmj1vFR5c/074xetH9/UT6qI+RYY9yZljmkH9mUTJdME1
X-Google-Smtp-Source: AGHT+IHmKFWh0EX5W4UrlAuaShc8z5HGaqyl6BzhAlbha6mdD4im91lzcojjBo1X/5DvQMYjrTsAeg==
X-Received: by 2002:a05:600c:3b89:b0:459:ea5d:418b with SMTP id
 5b1f17b1804b1-45a10f58f2amr1775565e9.9.1754931985104; 
 Mon, 11 Aug 2025 10:06:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0683045sm32464335f8f.41.2025.08.11.10.06.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 10:06:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Miguel Luis <miguel.luis@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Haibo Xu <haibo.xu@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Mark Burton <mburton@qti.qualcomm.com>, Alexander Graf <agraf@csgraf.de>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 02/11] target/arm: Use generic hwaccel_enabled() to check
 'host' cpu type
Date: Mon, 11 Aug 2025 19:06:02 +0200
Message-ID: <20250811170611.37482-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250811170611.37482-1-philmd@linaro.org>
References: <20250811170611.37482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We should be able to use the 'host' CPU with any hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/arm-qmp-cmds.c |  5 +++--
 target/arm/cpu.c          |  5 +++--
 target/arm/cpu64.c        | 11 ++++++-----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index d292c974c44..1142e28cb76 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-commands-misc-arm.h"
 #include "qobject/qdict.h"
 #include "qom/qom-qobject.h"
+#include "system/hw_accel.h"
 #include "cpu.h"
 
 static GICCapability *gic_cap_new(int version)
@@ -117,8 +118,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    if (!kvm_enabled() && !strcmp(model->name, "host")) {
-        error_setg(errp, "The CPU type '%s' requires KVM", model->name);
+    if (!hwaccel_enabled() && !strcmp(model->name, "host")) {
+        error_setg(errp, "The CPU type 'host' requires hardware accelerator");
         return NULL;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e2b2337399c..d9a8f62934d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1984,8 +1984,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * this is the first point where we can report it.
      */
     if (cpu->host_cpu_probe_failed) {
-        if (!kvm_enabled() && !hvf_enabled()) {
-            error_setg(errp, "The 'host' CPU type can only be used with KVM or HVF");
+        if (!hwaccel_enabled()) {
+            error_setg(errp, "The 'host' CPU type can only be used with "
+                             "hardware accelator such KVM/HVF");
         } else {
             error_setg(errp, "Failed to retrieve host CPU features");
         }
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..034bbc504cd 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/hw_accel.h"
 #include "system/qtest.h"
 #include "system/tcg.h"
 #include "kvm_arm.h"
@@ -522,7 +523,7 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Exit early if PAuth is enabled and fall through to disable it.
          * The algorithm selection properties are not present.
@@ -599,10 +600,10 @@ void aarch64_add_pauth_properties(Object *obj)
 
     /* Default to PAUTH on, with the architected algorithm on TCG. */
     qdev_property_add_static(DEVICE(obj), &arm_cpu_pauth_property);
-    if (kvm_enabled() || hvf_enabled()) {
+    if (hwaccel_enabled()) {
         /*
          * Mirror PAuth support from the probed sysregs back into the
-         * property for KVM or hvf. Is it just a bit backward? Yes it is!
+         * property for HW accel. Is it just a bit backward? Yes it is!
          * Note that prop_pauth is true whether the host CPU supports the
          * architected QARMA5 algorithm or the IMPDEF one. We don't
          * provide the separate pauth-impdef property for KVM or hvf,
@@ -780,8 +781,8 @@ static void aarch64_host_initfn(Object *obj)
 
 static void aarch64_max_initfn(Object *obj)
 {
-    if (kvm_enabled() || hvf_enabled()) {
-        /* With KVM or HVF, '-cpu max' is identical to '-cpu host' */
+    if (hwaccel_enabled()) {
+        /* When hardware acceleration enabled, '-cpu max' is identical to '-cpu host' */
         aarch64_host_initfn(obj);
         return;
     }
-- 
2.49.0


