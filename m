Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06E3C3ABAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 15:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8tz-0002La-4w; Wed, 30 Apr 2025 10:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tr-0002Gw-A9
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:04 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tp-0002gz-AS
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:59:02 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30828fc17adso7400142a91.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025139; x=1746629939; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijNdOguPfwk3cK3WhRDHWMHgdilsTL/0Rfwd87XXhiw=;
 b=gcjyNlKq8ZrQjbI8LK9Bz5nlAxOnOB5OV2/IN35CoQI1O9UNoQilvtB9TmBn/kjK3A
 qRll8WjlMI1x4ZjIsQ6l6bCbP3JKmVMee8h3mZsdvf9sN4I2xWRf21A+XU500BLMCHBQ
 vewiEEAw0vBx9dMyWVr+eXXWtIbqDc27Z7puEnMFs23+gH1IzNQ7IF1idKN79dWJFKlW
 aQWSKxYmkgmBNTv5I0kw2UI0JDuPxSUlf8ir3evCB80fBf1isMKfEwfxuC8SsWh2GHBm
 Mfg4wY7+X+0UnMaSPTUb/8m0KKre3hhViBGcEnm9Hj/8KpDO5LOnBwK8B2bMQO4IanRo
 0BWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025139; x=1746629939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijNdOguPfwk3cK3WhRDHWMHgdilsTL/0Rfwd87XXhiw=;
 b=fjR1wJMDMBFQkqbCZww/JX+2XL4E9EZ4HqRo0hyoN1SlYiMu5jOCBbFrn5uuPbJuVP
 d6XttcH1YnFJ5UDqesinlbcM2OXtx2irOFJUHieu6KBe8GfweojEln7hbGkClHYUrOMv
 Iz0P6Hc+0zaLkyqeknxqaGBM5uu0+68cGs88rNsRm2eiEp08OfqflJcCzBmRVs6HTjax
 /pzv/+v1qQKzzSmz2/Fj1CH3lQRtM/dAPvvu4Zog3cw7a6lX+9lZPCo1W5n4FIzS8Tpq
 lzyZh0Znl0tNX/OO/nnMHEW+/kfWPB2UTQLnJ6zR6RWp9whsmIwgsKQrCLyLdhb82AUc
 Va4A==
X-Gm-Message-State: AOJu0YxzlyR2kPvlVgYkm+EuViUHp2y1Rjbj+h2ezd2WdkwralGegcdA
 PVhJhjjlwpdo3B9GKA24E4b5EFysuoQDIpkfW/Fo3gKIo7QlQb0oYCdZ6NHRZDt05CqRsXOfIMv
 v
X-Gm-Gg: ASbGncslqBdAasj570TVbruWC7gjoUSc0X1gQnz7WijTi5SJgRIlEvjLcieWU591YM8
 cf9mJYtJ0KReI6pRW1DuHVd508YYGbwv6HyJEDPoiIEC0Uop3L9HsMgtuFKGxiSikY6wxq7VKg9
 fO3lcIUQ/su1ZYgQtP8j9SqN0g48faAPuP+fDZKic2iKgMb8pXIAZ+ME7Lb1ZHcfQor2puVnszJ
 4NRYFWUATEqvOGCiQ6sUnMPvoxyHJfm1ZARCaig4A8I0311FeYwgbGfp1pzW1XAYyIqzDT9klZr
 wnEJN9F8qa+D2Lfh2Q5HHJrQSbrmwZ8oQDvwTXke
X-Google-Smtp-Source: AGHT+IEtWQgBR1dIPtKgtkqPJNvg9G3OixpeD/ih698aPZOgwyFwhJdy8XlkdVtT04JfqY+wRAy3tA==
X-Received: by 2002:a17:90b:4f47:b0:30a:255c:9d10 with SMTP id
 98e67ed59e1d1-30a343e8b08mr4234791a91.8.1746025139383; 
 Wed, 30 Apr 2025 07:58:59 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 10/12] target/arm/cpu: remove TARGET_AARCH64 in
 arm_cpu_finalize_features
Date: Wed, 30 Apr 2025 07:58:35 -0700
Message-ID: <20250430145838.1790471-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Need to stub cpu64 finalize functions.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c         |  2 --
 target/arm/cpu32-stubs.c | 24 ++++++++++++++++++++++++
 target/arm/meson.build   | 11 +++++++----
 3 files changed, 31 insertions(+), 6 deletions(-)
 create mode 100644 target/arm/cpu32-stubs.c

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 00ae2778058..c3a1e8e284d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1878,7 +1878,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
-#ifdef TARGET_AARCH64
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         arm_cpu_sve_finalize(cpu, &local_err);
         if (local_err != NULL) {
@@ -1914,7 +1913,6 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
-#endif
 
     if (kvm_enabled()) {
         kvm_arm_steal_time_finalize(cpu, &local_err);
diff --git a/target/arm/cpu32-stubs.c b/target/arm/cpu32-stubs.c
new file mode 100644
index 00000000000..fda7ccee4b5
--- /dev/null
+++ b/target/arm/cpu32-stubs.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "target/arm/cpu.h"
+#include "target/arm/internals.h"
+#include <glib.h>
+
+void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+void arm_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3065081d241..c39ddc4427b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -11,10 +11,13 @@ arm_ss.add(zlib)
 arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
 arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
-  'gdbstub64.c',
-))
+arm_ss.add(when: 'TARGET_AARCH64',
+  if_true: files(
+    'cpu64.c',
+    'gdbstub64.c'),
+  if_false: files(
+    'cpu32-stubs.c'),
+)
 
 arm_system_ss = ss.source_set()
 arm_system_ss.add(files(
-- 
2.47.2


