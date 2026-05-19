Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B82CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLjt-00049v-JZ; Tue, 19 May 2026 10:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLjn-0003jr-2N
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:48:03 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPLjj-0008DG-Up
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:48:02 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso2027483f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779202078; x=1779806878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrqG8E5vo4+DPxnoXgzD37IiU6lxoPHb9HCDmG94Di4=;
 b=OPjVAhs+DpaiFLUkHG7jegJi1YD4CLc17eHeoMtuLS7xi1Fd51Jg4WP+m7YQ+gho3+
 0SV28zAGcOoacuZE8uq272a8uJrFuLys71qrGcyGRYnJspuk5oCbbG4II4yKp4QxXRCd
 f60Udh3N3k6T1kpKfdvvYbbBpuVVj1vtrWBILaNSB/A/+LJPtMKJvvbUGXyj3zH33qOK
 MlNuwPVxiVawqkytRhHvP2kzza++n7uK/04sMgReuprSnjNqJ0IKXBtlqmaRGX+F06bh
 eKFwj+mJh2757V7NTJ8HZmKuG7zIDCF1tTMtvkMsUjN4wZFp0/3QUPSgf8vE3RKNkAsM
 1FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779202078; x=1779806878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hrqG8E5vo4+DPxnoXgzD37IiU6lxoPHb9HCDmG94Di4=;
 b=RTmThuPEysNlRPps00+EpgZOnWlPWSJ6F3hNWyryLVHHN56VDi7V28p4CETPiXbQiE
 OhowY/3b3NeLgZDKxZg6U9QN/oOvGD1E2W7Cet62VH14JmnkBtnPS8upkgHXHNKQsJnb
 YMhxDQd5ULE4MAH6VdJk5B1Bvx+JEJY8Z4oaF9888jYUdudoxwwsTGhZE/Sw2Ndsr1Zi
 rXWyEewXycYmem2r4ZVNbNU8cqoSMnC65PNjgbtd0lLo+2FJT3r8HFahLemxZHj2kPpl
 BPdZqlqHYXEzq/yvhayQYWg2mBK51l1Mdbgs7EAE1dSNL1h5ujJm2Dcexd6GUD3eCpfP
 nRzQ==
X-Gm-Message-State: AOJu0YzkJU7xYbaIFtp1mtDoX9tacO4A1j6dT2N1a7R64XYoQeJD4xGu
 5kJNajSCAxrGAYagL4U5rUsZj6gw2Jpl5pbmznIvTFdFiixjXrqMmzSe5O753qkKGkzZSiDUt6X
 V91ico4o=
X-Gm-Gg: Acq92OFZmGVrDiolFTY+NeM/fhAqoTij+QNbFF52ki4bP+oPXjvpUh9OZdUhhj9wDCt
 qxTsN0zAGjJHnMaYshKvwVWbYD58MxbFSkGXWyKVBZPysod1r6PSGO8HfeK6rBIgHYpidw7Mca7
 GwJGRrNU71iu7IhxXqpUlFTUlfxDZqtGcb8GlQlRPfnoHzxZV5wrKDNxguIGU/gMDsqHqltORU5
 G4aer9o/nkYifI8i8ioSuzVKCRUeC8DUDcwmnfTTTM4mNMMIccTr7yyxTS5S9LWERaObfkOkaoA
 6TLNQcaP+ynCycHKo3H4GMHLDMEwHOZlygTF1WtfD6OYpdjPcXzp4Ciz7XYfaqq9TMG6u90vBr1
 Y4cpy9YNHIoV5zGvqhlSbyXFF9wHgAl9Vuxhl4oNH6txIDrFxOUaMOhIUEm5vdqoqtTiMpv0Xlp
 GfMY6TG1vquc5E1JqPefpuqlLMQita52jY15ICN5Eh1a8qhN8MLRTc1AaNv79jn2BmJSQ+F65A
X-Received: by 2002:a05:6000:4305:b0:43c:fe66:43ec with SMTP id
 ffacd0b85a97d-45e5c5af3e1mr33745917f8f.14.1779202077754; 
 Tue, 19 May 2026 07:47:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm48215448f8f.29.2026.05.19.07.47.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 May 2026 07:47:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 18/18] target/arm: Build cpu-max.c once
Date: Tue, 19 May 2026 16:45:53 +0200
Message-ID: <20260519144553.91483-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519144553.91483-1-philmd@linaro.org>
References: <20260519144553.91483-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Call TargetInfo::target_aarch64() at runtime, allowing to
remove the target-specific TARGET_AARCH64 definition and
build cpu-max.c once as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/cpu-max.c   | 8 ++------
 target/arm/meson.build | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 8cf8edc6535..d38bdfcf811 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
@@ -190,12 +191,7 @@ void aa32_max_features(ARMCPU *cpu)
 static void cpu_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-
-#ifdef TARGET_AARCH64
-    const bool aarch64_enabled = true;
-#else
-    const bool aarch64_enabled = false;
-#endif /* !TARGET_AARCH64 */
+    const bool aarch64_enabled = target_aarch64();
 
     if (hwaccel_enabled()) {
         assert(aarch64_enabled);
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3e02941d0d5..9408131d178 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -9,7 +9,6 @@ arm_user_ss = ss.source_set()
 arm_common_system_ss.add(files('gdbstub.c'))
 arm_user_ss.add(files('gdbstub.c'))
 
-arm_ss.add(files('cpu-max.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
@@ -20,6 +19,7 @@ arm_common_ss.add(files(
 arm_common_user_system_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
+  'cpu-max.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.53.0


